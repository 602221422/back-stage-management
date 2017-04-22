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
<title>成绩修改提交</title>
</head>
<body>
<%
cgrade=trim(request.Form("cgrade"))
cgpa=trim(request.Form("cgpa"))
if (cgrade="" or cgpa="")then
  response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
  sid=trim(request.Form("sno"))
  cid=request.QueryString("c_id")
  set rs=server.CreateObject("Adodb.Recordset")
  sql="select * from t_grade where c_no='"&cid&"' and s_no='"&sid&"'"
  rs.open sql,conn,1,2
  rs("c_grade")=trim(request.Form("cgrade"))
  rs("c_gpa")=trim(request.Form("cgpa"))
  rs.update
  response.write"<script>alert('修改成功！');location.href='grade_information.asp'</script>"
  rs.close
  set rs=nothing
  conn.close
  set conn=nothing
 end if
%>
</body>
</html>
