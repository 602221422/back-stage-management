﻿<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>1 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员信息删除</title>
</head>

<body>
<%set rs=server.CreateObject("Adodb.Recordset")
mgname=request.QueryString("id")
sql="select *from t_manager where mg_name='"&mgname&"'"
rs.open sql,conn,3,1
if rs.bof or rs.eof then
   rs.close
   set rs=nothing
   response.write"<script>alert('没有改条记录！');history.back();</script>"
else if rs("mg_name")="admin" then
      response.write"<script>alert('不能删除admin管理员哦！');history.back();</script>"
   else
    sql = "delete from t_manager where mg_name='"&mgname&"'"
	conn.execute(sql)
	rs.close
	set rs=nothing
    response.write"<script>alert('删除成功！');location.href='manager_information.asp'</script>"
end if
end if
conn.close
set conn=nothing

%>
</body>
</html>
