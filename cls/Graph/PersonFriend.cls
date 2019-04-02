Class Graph.PersonFriend Extends (%Persistent, %Library.Populate)
{

Property PersonId As %Integer;

Property FriendId As %Integer;

Index PersonIdIndex On PersonId;

Index FriendIdIndex On FriendId;

Method OnPopulate() As %Status
{
	Set id1=$R($Get(^Graph.PersonD))+1
	Set id2=$R($Get(^Graph.PersonD))+1
	If (id1 = id2) Quit '$$$OK
	If $Get(^Graph.PersonD(id1))="" {
	   Quit '$$$OK
	}
	If $Get(^Graph.PersonD(id2))="" {
	   Quit '$$$OK
	   }
	Set ..PersonId = id1
	Set ..FriendId = id2
	QUIT $$$OK
}

Storage Default
{
<Data name="PersonFriendDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PersonId</Value>
</Value>
<Value name="3">
<Value>FriendId</Value>
</Value>
</Data>
<DataLocation>^Graph.PersonFriendD</DataLocation>
<DefaultData>PersonFriendDefaultData</DefaultData>
<ExtentSize>975</ExtentSize>
<IdLocation>^Graph.PersonFriendD</IdLocation>
<IndexLocation>^Graph.PersonFriendI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>2.89</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="FriendId">
<AverageFieldSize>1.92</AverageFieldSize>
<Selectivity>1.0101%</Selectivity>
</Property>
<Property name="PersonId">
<AverageFieldSize>1.93</AverageFieldSize>
<Selectivity>1.0101%</Selectivity>
</Property>
<SQLMap name="FriendIdIndex">
<BlockCount>-8</BlockCount>
</SQLMap>
<SQLMap name="IDKEY">
<BlockCount>-12</BlockCount>
</SQLMap>
<SQLMap name="PersonIdIndex">
<BlockCount>-8</BlockCount>
</SQLMap>
<StreamLocation>^Graph.PersonFriendS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

