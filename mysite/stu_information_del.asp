﻿<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	if session("guess")= "" or session("flag")<>"admin"then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	 else if session("authority")>1 then
	     response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
     end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学生信息删除</title>
</head>
<body>
<%set rs=server.CreateObject("Adodb.Recordset")
id=request.QueryString("id")
sql="select * from t_student where s_no='"&id&"'"
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	response.write"<script>alert('没有符合条件的记录！');location.href='stu_information.asp'</script>"
else
sql = "delete from t_student where s_no='"&id&"'"
	conn.execute(sql)
	conn.close
set conn=nothing
response.write"<script>alert('删除成功！');location.href='stu_information.asp'</script>"
end if
%>
</body>
</html>
