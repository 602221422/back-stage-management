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
<head>
<!--#include file="conn.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加新闻提交</title>
</head>

<body>
<%
ntitle=trim(request.Form("title"))  '新闻
nsource=trim(request.Form("source"))  '来源
if ntitle="" or nsource="" then
  response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else
set rs=server.CreateObject("Adodb.Recordset")
set rs2=server.CreateObject("Adodb.Recordset")
sql="select * from t_new"
sql2="select * from t_comment"
rs.open sql,conn,3,3
rs2.open sql2,conn,3,3
rs.addnew
  rs("ct_id")=trim(request.Form("ctid"))
  rs("title")=trim(request.Form("title"))
  rs("source")=trim(request.Form("source"))
  rs("ptime")=trim(request.Form("ptime"))
  rs("body")=trim(request.Form("body"))
  rs.update
  
  rs2.addnew
  rs2("nid")=rs("nid")
  rs2("ptime")=rs("ptime")
  rs2("region")=120113901
  rs2("content")="非常好！！！"
  rs2.update
  
  rs.close
  set rs=nothing
  rs2.close
  set rs2=nothing
  response.write"<script>alert('发布成功！');location.href='new_information.asp'</script>"
end if
ntitle="" '新闻
nsource="" '来源
conn.close
set conn=nothing
%>
  </div>
</div>
</html>
