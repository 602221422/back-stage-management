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
<title>会员添加处理</title>
</head>

<body>
  <%
set rs=server.CreateObject("Adodb.Recordset")
if Fname="" then
id=trim(request.Form("clno1"))
else
id=trim(request.Form("clno2"))
end if
id2=trim(request.Form("sno"))
if len(id2)<>9 then
    response.write"<script>alert('学号只能输入9位数字哦！');history.back(-1)</script>"
else

sql="select * from t_cp_club where cl_no='"&id&"' and s_no='"&id2&"' "
rs.open sql,conn,1,3
if not rs.bof or not rs.eof then
	response.write "<script>alert('你已经加入了本社团，无需再次加入！');location.href='t_club_member_add.asp'</script>"
	else
rs.addnew
  rs("cl_no")=id
  rs("s_no")=id2
  rs("cp_date")=trim(request.Form("cdate"))
  rs.update
  rs.close
set rs=nothing
conn.close
set conn=nothing
response.write"<script>alert('添加成功！');location.href='t_club_member.asp'</script>"
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
end if
  %>
  </div>
</div>
</html>
