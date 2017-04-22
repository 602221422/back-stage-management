<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	if session("guess")= "" or session("flag")<>"admin"then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	 else if session("authority")>2 then
	     response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
     end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学生信息编辑提交</title>
</head>

<body>
 <%
sname=trim(request.Form("name"))
spassword=trim(request.Form("password"))
sage=trim(request.Form("age"))
if sname="" or spassword="" or sage="" then
     response.write"<script>alert('数据不完整哦！联系电话可以不填的哦!');history.back(-1)</script>"
else
  set rs=server.CreateObject("Adodb.Recordset")
  s_id=trim(request.Form("sno"))
  sql="select * from t_student where s_no='"&s_id&"'"
  rs.open sql,conn,1,2
  rs("s_password")=trim(request.Form("password"))
  rs("s_name")=trim(request.Form("name"))
  rs("s_sex")=trim(request.Form("sex"))
  rs("s_age")=trim(request.Form("age"))
  rs("d_no")=trim(request.Form("dept"))
  rs("cs_no")=trim(request.Form("class"))
  rs("s_phone")=trim(request.Form("Phone"))
  rs.update
response.write"<script>alert('修改成功！');location.href='stu_information.asp'</script>"
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
  %>
</html>
