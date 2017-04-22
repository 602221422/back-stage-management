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
<title>添加新闻类别提交</title>
</head>

<body>
<%
ctname=trim(request.Form("ctname"))  '新闻
if (ctname="")then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
  set rs=server.CreateObject("Adodb.Recordset")
  sql="select ct_name from t_new_ct where ct_name='"&ctname&"'"
  rs.open sql,conn,1,2
  if rs.eof and rs.bof then
     rs.addnew
	 rs("ct_name")=ctname
	 rs.update
     response.write"<script>alert('添加成功！');location.href='new_ct_infor_add.asp'</script>"
	 rs.close
     set rs=nothing
  else
  	 rs.close
     set rs=nothing
	 response.write"<script>alert('新闻类别已存在！');history.back(-1)</script>"
  end if
end if
conn.close
set conn=nothing
%>

</body>
</html>
