Class Graph.Person Extends (%Persistent, %Populate)
{

Property Name As %String(POPSPEC = "##Class(Sample.PopulateUtils).Name()");

Index NameIndex1 On Name [ Unique ];

ClassMethod CreatePersonGraph() As %Status
{
    set node = ""
    For {
     Set node = $Order(^Graph.PersonFriendD(node))
     If node = "" Quit
     
     Set record = ^Graph.PersonFriendD(node)
     Set id = $List(record,2)
     Set friendid = $List(record,3)
     
     Set name = $List($Get(^Graph.PersonD(id)),2)
     
     Set ^Person(id,"Name") = name
     Set ^Person("NameIndex",name,id) = ""
     Set ^Person(id,"Friend",friendid) = ""
 
    }
}

ClassMethod Setup() As %Status
{
	do ..Populate(100)
	do ##class(Graph.PersonFriend).Populate(1000)

	do ..CreatePersonGraph()
	
	quit $$$OK
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^Graph.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>99</ExtentSize>
<IdLocation>^Graph.PersonD</IdLocation>
<IndexLocation>^Graph.PersonI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>1.92</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>5.03</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="NameIndex1">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Graph.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

