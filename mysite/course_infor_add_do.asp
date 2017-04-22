<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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
<title>录入课程提交</title>
</head>

<body>
<%
cid=trim(request.Form("cno"))
if len(cid)<>8 then
    response.write"<script>alert('课程号只能输入8位数字哦！');history.back(-1)</script>"
else
cname=trim(request.Form("cname"))
ccredit=trim(request.Form("ccredit"))
cperiod=trim(request.Form("cperiod"))
if (cid="" or cname="" or ccredit="" or cperiod="" )then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
set rs=server.CreateObject("Adodb.Recordset")
sql="select * from t_course where c_no='"&cid&"'"
rs.open sql,conn,1,2
 if rs.eof and rs.bof then
  rs.addnew
  rs("c_no")=trim(request.Form("cno"))
  rs("c_name")=trim(request.Form("cname"))
  rs("c_credit")=trim(request.Form("ccredit"))
  rs("c_period")=trim(request.Form("cperiod"))
  rs.update
  response.write"<script>alert('添加成功！');location.href='course_infor_add.asp'</script>"
  else if rs("c_no")=trim(request.Form("cno")) then
    response.write"<script>alert('课程号已经存在！');history.back(-1)</script>"
  end if 
 end if
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
end if
  %>
</body>
</html>
