<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")=1 or session("authority")=4 then
    else
	response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>社团活动编辑处理</title>
</head>

<body>
<%
body=trim(request.Form("body"))
if body="" then
  response.write"<script>alert('不能为空！');history.back(-1)</script>"
else
set rs=server.CreateObject("Adodb.Recordset")
id=trim(request.Form("id"))
sql="select * from t_new where nid="&id
rs.open sql,conn,1,2
  rs("body")=trim(request.Form("body"))
  rs.update
response.write"<script>alert('修改成功！');location.href='t_club_activity.asp'</script>"
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
%>
  </div>
</div>
</html>
