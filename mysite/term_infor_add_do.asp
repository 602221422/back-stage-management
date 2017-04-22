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
<title>学期信息添加提交</title>
</head>

<body>
<%
tterm=trim(request.Form("tterm"))
if (tterm="")then
    response.write"<script>alert('数据不能为空！');history.back(-1)</script>"
else 
set rs=server.CreateObject("Adodb.Recordset")
sql="select * from t_term where tm_term='"&tterm&"'"
rs.open sql,conn,1,2
 if rs.eof and rs.bof then
  rs.addnew
  rs("tm_term")=trim(request.Form("tterm"))
  rs.update
  response.write"<script>alert('添加成功！');location.href='term_infor_add.asp'</script>"
  else if rs("tm_term")=trim(request.Form("tterm")) then
    response.write"<script>alert('该学期已经存在！');history.back(-1)</script>"
  end if 
 end if
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
  %>
</body>
</html>
