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
<title>管理员修改处理</title>
</head>
<body>
<%
mgname=trim(request.Form("mgname"))
mgpassword=trim(request.Form("mgpassword"))
Flag=cint(request.QueryString("id"))
if  mgpassword="" then
   response.write "<script>alert('密码不能为空!');history.back();</script>"
else if mgpassword <> trim(request.Form("mgpassword2")) then
		mgpassword=""
		mgname=""
		response.write "<script>alert('密码不一致，请重新输入!');history.back();</script>"
		response.end
  else
    set rs=server.CreateObject("Adodb.Recordset")
    sql="select * from t_manager where mg_name='"&mgname&"'"
    rs.open sql,conn,1,2
    rs("mg_password")=mgpassword
	if Flag=0 then
	  rs("mg_authority")=request.Form("mgauthority1")
	else if Flag=1 then
	  rs("mg_authority")=request.Form("mgauthority2")
       end if
	end if 
	rs.update
	rs.close
	set rs=nothing
	mgname=""
	mgpassword=""
    response.write"<script>alert('修改成功！');location.href='manager_information.asp'</script>"
	response.end
  end if
end if
conn.close
set conn=nothing
%>
</body>
</html>
