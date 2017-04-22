<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>3 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>图书信息编辑处理</title>
</head>

<body>
  <%
set rs=server.CreateObject("Adodb.Recordset")
id=trim(request.Form("bno"))
sql="select * from t_books where b_no="&id
rs.open sql,conn,1,2
  rs("b_name")=trim(request.Form("bname"))
  rs("b_author")=trim(request.Form("aname"))
  rs("b_press")=trim(request.Form("bpress"))
  rs("b_pb_date")=trim(request.Form("bdate"))
'  rs("cl_picture")=trim(request.Form("cpicture"))
  rs("b_brief")=trim(request.Form("bbrief"))
  rs.update
response.write"<script>alert('修改成功！');location.href='t_book.asp'</script>"
rs.close
set rs=nothing
conn.close
set conn=nothing
  %>
  </div>
</div>
</html>
