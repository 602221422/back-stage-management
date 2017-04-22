<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员添加处理</title>
</head>
<body>
  <%
mgname=trim(request.Form("mgname"))
mgpassword=trim(request.Form("mgpassword"))
if mgname="" or mgpassword="" then
   response.write "<script>alert('不能为空!');history.back();</script>"
else if mgpassword <> trim(request.Form("mgpassword2")) then
        mgname=""
		mgpassword=""
		response.write "<script>alert('密码不一致，请重新输入!');history.back();</script>"
		response.end
  else
    set rs=server.CreateObject("Adodb.Recordset")
    sql="select * from t_manager where mg_name='"&mgname&"'"
    rs.open sql,conn,1,2
	if rs.eof then
	  rs.addnew
      rs("mg_name")=mgname
      rs("mg_password")=mgpassword
	  rs("mg_authority")=trim(request.Form("mgauthority"))
      rs.update
	  rs.close
	  set rs=nothing
	  mgname=""
	  mgpassword=""
      response.write"<script>alert('添加成功！');location.href='manager_information.asp'</script>"
	  response.end
    else
	  rs.close
	  set rs=nothing
	  response.write"<script>alert('用户已经注册！');;history.back();</script>"
	  response.end
    end if
  end if
end if
conn.close
set conn=nothing
%>
</body>
</html>
