<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>删除新闻</title>
</head>
<body>
<%
set rs=server.CreateObject("Adodb.Recordset")
nid=request.QueryString("id")
sql="select * from t_new where nid="&nid
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	response.write"<script>alert('没有符合条件的记录！');location.href='new_information.asp'</script>"
else
sql = "delete from t_new where nid="&nid
	conn.execute(sql)
	conn.close
set conn=nothing
response.write"<script>alert('删除成功！');location.href='new_information.asp'</script>"
end if
%>
</body>
</html>
