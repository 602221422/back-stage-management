<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")=1 or session("authority")=4 then
    else
	response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
Fname=""
if session("authority")=4 then
 Fname=session("guess")
 end if
%>
<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>社团活动添加处理</title>
</head>

<body>
<%
body=trim(request.Form("body"))
if body="" then
  response.write"<script>alert('内容不能为空！');history.back(-1)</script>"
else
set rs1=server.CreateObject("Adodb.Recordset")
sql="select * from t_new_ct where ct_name='社团活动'"
rs1.open sql,conn,3,1
if rs1.eof or rs1.bof then
   rs1.close
   set rs1=nothing
   response.write"<script>alert('新闻类别中不存在社团活动，请先添加后在操作！');history.back(-1)</script>"
else
  ctid=rs1("ct_id")
  rs1.close
  set rs1=nothing
set rs=server.CreateObject("Adodb.Recordset")
set rs2=server.CreateObject("Adodb.Recordset")
sql2="select * from  t_comment"
rs2.open sql2,conn,3,3
if Fname="" then
clno=trim(request.Form("clno1"))
else
clno=trim(request.Form("clno2"))
end if
set rs3=server.CreateObject("Adodb.Recordset")
sql="select * from t_club where cl_no='"&clno&"'"
rs3.open sql,conn,3,3
if rs3.eof or rs3.bof then
    rs3.close
	set rs3=nothing
   response.write"<script>alert('没有该社团！');history.back(-1)</script>"
else
clname=rs3("cl_name")
rs3.close
set rs3=nothing

sql="select * from t_new"
rs.open sql,conn,3,3
rs.addnew
  rs("ct_id")=ctid
  rs("source")=clname
  rs("title")=trim(request.Form("title"))
  rs("ptime")=trim(request.Form("ctime"))
  rs("body")=trim(request.Form("body"))
  rs.update
  
  
  rs2.addnew
  rs2("nid")=rs("nid")
  rs2("ptime")=year(now)&"-"&month(now)&"-"&day(now)
  rs2("region")=120113901
  rs2("content")="非常好！！！"
  rs2.update
  
  rs2.close
set rs2=nothing
  rs.close
set rs=nothing
conn.close
set conn=nothing
response.write"<script>alert('添加成功！');location.href='t_club_activity.asp'</script>"
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
end if
end if
%>
  </div>
</div>
</html>
