<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="conn.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
admin=request.form("admin")
password=request.form("password")
if admin="" or password="" then 
  response.Write("<script language=javascript>alert('请填写完整的信息');history.back()</script>")
else
  set rs=server.CreateObject("Adodb.Recordset")
  sql="select * from t_manager  where mg_name='"&admin&"'and mg_password='"&password&"'"
  rs.open sql,conn,1,3
  if rs.eof and rs.bof then 
     rs.close
	 set rs=nothing
     response.write"<script>alert('用户名或密码错误！');location.href='index.html'</script>"
     response.end
  else
     session("guess")= admin'admin
     session("flag")="admin"
     session("authority")=rs("mg_authority")
	 rs.close
     set rs=nothing
     response.Redirect "admin_index.asp"
  end if
end if
admin=""
password=""
conn.close
set conn=nothing
%>

