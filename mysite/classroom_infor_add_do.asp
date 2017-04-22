<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>教室添加提交</title>
</head>

<body>
<%
crid=trim(request.Form("crno"))
crplace=trim(request.Form("crplace"))
if (crid="" or crplace="")then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
set rs=server.CreateObject("Adodb.Recordset")
sql="select * from t_classroom where cr_no='"&crid&"'"
rs.open sql,conn,1,2
 if rs.eof and rs.bof then
  rs.addnew
  rs("cr_no")=trim(request.Form("crno"))
  rs("cr_place")=trim(request.Form("crplace"))
  rs.update
  response.write"<script>alert('添加成功！');location.href='classroom_infor_add.asp'</script>"
  else if rs("cr_no")=trim(request.Form("crno")) then
    response.write"<script>alert('课程号已经存在！');history.back(-1)</script>"
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
