Include %occErrors

Class Graph.FF Extends %SQL.CustomResultSet
{

// 

/// Friend of Friendを検索するカスタムクエリー
Property Name As %String;

/// Friend Of Friend
Property FF As %String;

/// 行番号カウンター
Property Zid As %Integer [ Private ];

ClassMethod FF(pName As %String) As %Status [ ReturnResultsets, SqlName = Friend_Of_Friend, SqlProc ]
{
	#dim %sqlcontext as %Library.ProcedureContext
	
	try {
		if '$Isobject($Get(%sqlcontext)) { set %sqlcontext = ##class(%Library.ProcedureContext).%New() }
			#; 第一引数はSELECTMODE。 デフォルトはプロセスの現在設定($system.SQL.GetSelectMode())。
		set tResult = ..%New(,pName)
		do %sqlcontext.AddResultSet(tResult)
	}
	catch tException {
		if '$Isobject($Get(%sqlcontext)) { set %sqlcontext = ##class(%Library.ProcedureContext).%New() }
		if tException.%IsA("%Exception.SQL") { set ..%SQLCODE = tException.Code, ..%Message = tException.Data }
		elseif tException.%IsA("%Exception.StatusException") { if (tException.Code = $$$SQLError) || (tException.Code = $$$SQLCode) 
		{ set ..%SQLCODE = $Listget(tException.Data,1), ..%Message = $Listget(tException.Data,2) } }
		else { set %sqlcontext.%SQLCODE = -400, %sqlcontext.%Message = "クエリー実行中に例外発生: " _ tException.Name_":"_tException.Data }
	}
	quit $$$OK
}

Method %OpenCursor(Name As %String) As %Library.Status
{
	
    set name = Name
    set id = ""
    Set counter = 0
    Set ..Zid = 0
    // 結果セットを一時的に保存するためにローカル変数（%付きはパブリック変数にする簡便な方法　本来は%変数はInterSystemsの予約変数であるため使用は非推奨）
　　　// 容量が増大する場合を考慮してPPGの使用が推奨されるが、ここではスピード優先でローカル変数を使用
    Kill %FF
    
    For {
      Set id = $Order(^Person("NameIndex",name,id))
      If id = "" Quit

      Set friendid = ""

      For {
        Set friendid = $Order(^Person(id,"Friend",friendid))
        If friendid = "" Quit
        Set friendid2 = ""
        For {
          Set friendid2 = $Order(^Person(friendid,"Friend",friendid2))
          If friendid2 = "" Quit
          If $Data(%FF(id,friendid2)) Continue
          Set %FF($increment(counter))=$ListBuild(^Person(id,"Name"),$List(^Graph.PersonD(friendid2),2))
        } 
      }
    }
	quit $$$OK
}

/// 次の行に結果セットを進める。 結果セットのカーソルが最後の時には0を返す
Method %Next(ByRef sc As %Library.Status) As %Library.Integer [ PlaceAfter = %Execute ]
{
    Set id = ..Zid
    Set id = $Order(%FF(id))
    If id = "" Quit '$$$OK
    If ($ListLength(%FF(id)) < 2) quit '$$$OK
    Set ..Name = $List(%FF(id),1)
    Set ..FF = $List(%FF(id),2)
	Set ..%ROWCOUNT = ..%ROWCOUNT + 1
	Set ..Zid = id
	quit $$$OK
}

/// 終了時にクリーンアップ
Method %CloseCursor() As %Status
{
	Kill %FF
	Quit $$$OK
}

}

