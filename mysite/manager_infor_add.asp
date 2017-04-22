<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>1 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员添加</title>
<style type="text/css">
.style3{
width: 550px;
height: 410px;
margin: 0px auto;
margin-bottom:20px;
border:1px solid #BBE1F1;
background-color: #EEFAFF;
background-image:url(images/dd1.jpg);
border:inset
}
</style>
</head>
<body>
<form name="theForm"  action="manager_infor_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
<tr height="48px">
 <td colspan="2" align="center" ><h2>添加管理员</h2></td>
</tr>
<tr height="44px">
 <td align="right" width="40%">用户名：</td>
 <td align="left" width="60%"><input type="text" name="mgname"  /><font color="#FF0000">*</font></td>
</tr>
<tr height="44px">
 <td align="right">权限：</td>
 <td align="left">
  <label>
  <select name="mgauthority" id="mgauthority" style="width:100px" >
         <%'输出当前页面记录
          for i=1 to 4
         %>
          <option value=" <%=i%>"><%=i%>级</option>
         <%
        next
        %>
         </select>
		 </label><font color="#FF0000">*</font>
 </td>
</tr>
<tr height="44px">
 <td align="right">密码：</td>
 <td align="left"><input name="mgpassword" type="password"  /><font color="#FF0000">*</font></td>
</tr>
<tr height="44px">
 <td align="right">密码确认：</td>
 <td align="left"><input name="mgpassword2" type="password"  /><font color="#FF0000">*</font></td>
</tr>
<tr height="44px">
 <td align="center" colspan="2"><input name="Submit" type="submit" value="确定提交"></td>
</tr>
</table>
</form>
</body>
</html>
