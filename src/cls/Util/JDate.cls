Include JDate

Class Util.JDate Extends %Base
{

ClassMethod LogicalToDisplay(pDate As %Date, pFormat As %Integer = 1, pError As %Status) As %String
{
	//明治　1868/1/01 - 1912/7/30 	$h 9862 - 26143
	//大正　1912/7/30 - 1926/12/25	$h 26143 - 31404
	//昭和　1926/12/25 - 1989/1/7	$h 31404 - 54063
	//平成　1989/1/8 - 2019/4/30	$h 54064 - 65133
	//令和  2019/5/1 -              $h 65134 -
	//
	// 明治、大正、昭和に関しては改元日が重なっているが、その重なっている日を新元号とするケースが多いようである。
	//
	// Format 
	//     1	Gyymmdd				Gは元号を表すアルファベット
	//     2    GGyy年mm月dd日		GGは元号を表す漢字表現
	//
	//　明治より前（<9862）、令和100年以降(>101172)の$horolog値を指定した場合は、$zdate($horolog,8)を返す
	//
	//Meiji　	1868/1/01 - 1912/7/30 	$h 9862 - 26143
	//Taisyo 	1912/7/30 - 1926/12/25	$h 26143 - 31404
	//Syouwa 	1926/12/25 - 1989/1/7	$h 31404 - 54063
	//Heisei　	1989/1/8 - 2019/4/30	$h 54064 - 65133
	//reiwa  	2019/5/1 -              $h 65134 -
	//
	// The Meiji era, the Taisho era, and the Showa era overlap with the new era, 
	// but it seems that there are many cases where the overlapping day is the new era.
	//
	// Format 
	//     1	Gyymmdd				G is an alphabet representing an era
	//     2    GGyy年mm月dd日		GG is a kanji expression that represents the era
	//　If you specify the $ horolog value before Meiji (<9862) and after reiwa 99 years (> 101172), return $zdate($horolog,8)
	//
	
	Set pError = $$$OK
		
	Set tDate = $Zdate(pDate,8)
	
	If (+pFormat > $$$LongExpression) || (+pFormat < $$$ShortExpression) Set pFormat = $$$ShortExpression

	If pDate < $$$MeijiStart Quit tDate  //明治より前は西暦のまま返す
	
	If (pDate > ($$$MeijiStart - 1)) && (pDate < $$$TaisyouStart) {
		//明治
		Set tYear = ..GengouYear(pDate, $$$MeijiStart)
		If (pFormat = $$$ShortExpression) {
		   Set tDate = "M"_tYear_$Extract(tDate,5,8)
		}
		Elseif (pFormat = $$$LongExpression) {
		   Set tDate = "明治"_tYear_"年"_$Extract(tDate,5,6)_"月"_$Extract(tDate,7,8)_"日"
		}
	}
	
	if (pDate > ($$$TaisyouStart - 1)) && (pDate < ($$$SyouwaStart)) {
		//大正
		set tYear = ..GengouYear(pDate, $$$TaisyouStart)
		If (pFormat = $$$ShortExpression) {
		   Set tDate = "T"_tYear_$Extract(tDate,5,8)
		}
		Elseif (pFormat = $$$LongExpression) {
		   Set tDate = "大正"_tYear_"年"_$Extract(tDate,5,6)_"月"_$Extract(tDate,7,8)_"日"
		}
	}
	
	if (pDate > ($$$SyouwaStart - 1)) && (pDate < $$$HeiseiStart) {
		//昭和
		set tYear = ..GengouYear(pDate, $$$SyouwaStart)
		If (pFormat = $$$ShortExpression) {
		   Set tDate = "S"_tYear_$Extract(tDate,5,8)
		}
		Elseif (pFormat = $$$LongExpression) {
		   Set tDate = "昭和"_tYear_"年"_$Extract(tDate,5,6)_"月"_$Extract(tDate,7,8)_"日"
		}
	}

	if (pDate >= $$$HeiseiStart) && (pDate < $$$ReiwaStart) {
		//平成
		set tYear = ..GengouYear(pDate, $$$HeiseiStart)
		
		If (pFormat = $$$ShortExpression) {
		   Set tDate = "H"_tYear_$Extract(tDate,5,8)
		}
		Elseif (pFormat = $$$LongExpression) {
		   Set tDate = "平成"_tYear_"年"_$Extract(tDate,5,6)_"月"_$Extract(tDate,7,8)_"日"
		}
	}

	if (pDate >= $$$ReiwaStart) {
		//令和
		set tYear = ..GengouYear(pDate, $$$ReiwaStart)
		
		If (tYear > $$$MaxReiwaYear) {
			Set tDate = $zd(pDate,8) Quit tDate
		}
		If (pFormat = $$$ShortExpression) {
		   Set tDate = "R"_tYear_$Extract(tDate,5,8)
		}
		Elseif (pFormat = $$$LongExpression) {
		   Set tDate = "令和"_tYear_"年"_$Extract(tDate,5,6)_"月"_$Extract(tDate,7,8)_"日"
		}
	}
	Quit tDate
}

ClassMethod DisplayToLogical(pDate As %String, pFormat As %Integer = 1, pError As %Status) As %String
{
	//明治　1868/1/01 - 1912/7/30 	$h 9862  - 26143
	//大正　1912/7/30 - 1926/12/25	$h 26143 - 31404
	//昭和　1926/12/25 - 1989/1/7	$h 31404 - 54063
	//平成　1989/1/8 - 2019/4/30	$h 54064 - 65133
	//令和  2019/5/1 -              $h 65134 -
	//
	// 明治、大正、昭和に関しては改元日が重なっているが、その重なっている日を新元号とするケースが多いようである。
	//
	//Meiji　	1868/1/01 - 1912/7/30 	$h 9862 - 26143
	//Taisyo 	1912/7/30 - 1926/12/25	$h 26143 - 31404
	//Syouwa 	1926/12/25 - 1989/1/7	$h 31404 - 54063
	//Heisei　	1989/1/8 - 2019/4/30	$h 54064 - 65133
	//Reiwa  	2019/5/1 -              $h 65134 -
	//
	// The Meiji era, the Taisho era, and the Showa era overlap with the new era, 
	// but it seems that there are many cases where the overlapping day is the new era.
	//
	// Format 
	//     1	Gyymmdd				G is an alphabet representing an era
	//     2    GGyy年mm月dd日		GG is a kanji expression that represents the era
  Try { 	
	Set pError = $$$OK
	Set tH = ""
	
	If (+pFormat > $$$LongExpression) || (+pFormat < $$$ShortExpression) Set pFormat = $$$ShortExpression
	
	If (pFormat = $$$ShortExpression) {
	   Set tEra = $Extract(pDate,1)
	   Set tCheck = $Case(tEra,"M":1,"T":1,"S":1,"H":1,"R":1,:0)
	}
	ElseIf (pFormat = $$$LongExpression) {
	  Set tEra = $Extract(pDate,1,2)
	  Set tCheck = $Case(tEra,"明治":2,"大正":2,"昭和":2,"平成":2,"令和":2,:0)
	}
		
	If (tCheck = 0) {
	   Set tH = $zdateh(pDate,8)
	   If tH < $$$MeijiStart Quit
		Set pError = $$$FormatError Quit
	 }

		
	If (pFormat = $$$ShortExpression) {
		set tYear = $Extract(pDate,2,3)
		set tMonth = $Extract(pDate,4,5)
		set tDay = $Extract(pDate,6,7)
		If ($Length(pDate) '= $$$ShortExpressionLength) Set pError = $$$FormatError Quit
	}
	Else {
		set tYear = $Extract(pDate,3,4)
		set tMonth = $Extract(pDate,6,7)
		set tDay = $Extract(pDate,9,10)
		Set tNen = $Extract(pDate,5)
		Set tGetsu = $Extract(pDate,8)
		Set tNichi = $Extract(pDate,11)
		If ($Length(pDate) '= $$$LongExpressionLength) Set pError = $$$FormatError Quit

		If (tNen '= "年") Set pError = $$$FormatError Quit

		If (tGetsu '= "月") Set pError = $$$FormatError Quit

		If (tNichi '= "日")  Set pError = $$$FormatError Quit
	}
	
	If tYear'?2N Set pError = $$$FormatError Quit
	If tMonth'?2N Set pError = $$$FormatError Quit
	If tDay'?2N Set pError = $$$FormatError Quit

	If (+tYear = 0) Set pError = $$$FormatError Quit
	
	If (tEra = "M") || (tEra = "明治") {

		Set tYear2 = $$$MeijiYear + tYear - 1
		Set tH = $ZDH(tYear2_tMonth_tDay,8)

		If (+tYear = $$$StartYear) {
			If (+(tMonth_tDay) < $$$MeijiStartMonthDate) {
				Set pError = $$$RangeError
				Set tH = ""
			}
		}
		ElseIf (+tYear = $$$MeijiEndYear) {
			If (+(tMonth_tDay) > $$$MeijiEndMonthDate) {
				Set pError = $$$RangeError
			    Set tH = ""
			}			
		} 
		ElseIf (+tYear > $$$MeijiEndYear) {
			Set pError = $$$RangeError
			Set tH = ""
		}
	}
	If (tEra = "T") || (tEra = "大正") {

		Set tYear2 = $$$TaisyoYear + tYear - 1
		Set tH = $ZDH(tYear2_tMonth_tDay,8)

		If (+tYear = $$$StartYear) {
			If (+(tMonth_tDay) < $$$TaisyoStartMonthDate) {
				Set pError = $$$RangeError
			    Set tH = ""
			}
		}
		ElseIf (+tYear = $$$TaisyoEndYear) {
			If (+(tMonth_tDay) > $$$TaisyoEndMonthDate) {
				Set pError = $$$RangeError
				Set tH = ""
			}			
		} 
		ElseIf (+tYear > $$$TaisyoEndYear) {
			Set pError = $$$RangeError
			Set tH = ""
		}
	}
	If (tEra = "S") || (tEra = "昭和") {
		Set tYear2 = $$$SyouwaYear + tYear - 1
		Set tH = $ZDH(tYear2_tMonth_tDay,8)
		If (+tYear = $$$StartYear) {
			If (+(tMonth_tDay) < $$$SyouwaStartMonthDate) {
				Set pError = $$$RangeError
				Set tH = ""
			}
		}
		ElseIf (+tYear = $$$SyouwaEndYear) {
			If (+(tMonth_tDay) > $$$SyouwaEndMonthDate) {
				Set pError = $$$RangeError
				Set tH = ""
			}			
		} 
		ElseIf (+tYear > $$$SyouwaEndYear) {
			Set pError = $$$RangeError
			Set tH = ""
		}
	}
	If (tEra = "H") || (tEra = "平成") {
		Set tYear2 = $$$HeiseiYear + tYear - 1
		Set tH = $ZDH(tYear2_tMonth_tDay,8)
		If (+tYear = $$$StartYear) {
			If (+(tMonth_tDay) < $$$HeiseiStartMonthDate) {
				Set pError = $$$RangeError
				Set tH = ""
			}
		}
		ElseIf (+tYear = $$$HeiseiEndYear) {
			If (+(tMonth_tDay) > $$$HeiseiEndMonthDate) {
				Set pError = $$$RangeError
				Set tH = ""
			}			
		} 
		ElseIf (+tYear > $$$HeiseiEndYear) {
			Set pError = $$$RangeError
			Set tH = ""
		}
	}
	If (tEra = "R") || (tEra = "令和") {
		Set tYear2 = $$$ReiwaYear + tYear - 1
		Set tH = $ZDH(tYear2_tMonth_tDay,8)
		If (+tYear = $$$StartYear) {
			If (+(tMonth_tDay) < $$$ReiwaStartMonthDate) {
				Set pError = $$$RangeError
				Set tH = ""
			}
		}
	}
  }
  Catch tE {
	  
	Set pError = $$$RangeError
	Set tH = ""
  }
	Quit tH
}

ClassMethod GengouYear(pDate As %Date, pGengouStart As %Date) As %String [ Private ]
{
 quit $Translate($Justify($extract($Zdate(pDate,8),1,4)-$Extract($Zdate(pGengouStart,8),1,4) + 1,2)," ",0)
}

ClassMethod Version() As %String
{
 quit "2.0"
}

}

