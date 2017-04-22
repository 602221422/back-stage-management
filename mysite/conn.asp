<%
dbpath=server.mappath("database/db_campus.mdb") 
connstr= "provider=microsoft.jet.oledb.4.0;data source=" & dbpath 
set conn=server.createobject("adodb.connection") 
conn.open connstr
%>
