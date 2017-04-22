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
<title>会员添加</title>
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
<%
set rs=server.CreateObject("Adodb.Recordset")
if Fname="" then
   sql="select * from t_club"
  else 
   sql="select * from t_club where s_no='"&Fname&"'"
end if
rs.open sql,conn,3,1
%>
<br>
<form name="theForm"  action="t_club_member_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
<tr height="48px">
 <td colspan="2" align="center" ><h2>添加社员</h2></td>
</tr>
<%if Fname="" then%>
<tr height="44px">
 <td align="right" width="40%">社团名称：</td>
 <td align="left" width="60%">
 <label>
	  <select name="clno1" id="clno1" >
      <%'输出当前页面记录
       for i=0 to rs.recordcount
      %>
       <option value=" <%=rs("cl_no")%>"><%=rs("cl_name")%></option>
      <%
       rs.movenext
       if rs.eof then exit for
       next
	   rs.close
	   set rs=nothing
      %>
      </select>
	 </label>
 </td>
</tr>
<% else %>
<tr height="44px">
 <td align="right" width="40%">社团编号：</td>
 <td align="left" width="60%"><input type="text" name="clno2" value=<%=rs("cl_no")%> readonly ="readonly"/></td>
</tr>
<tr height="44px">
 <td align="right">社团名称：</td>
 <td align="left"><input type="text" name="clname" value=<%=rs("cl_name")%> readonly ="readonly"/></td>
</tr>
<%
rs.close
set rs=nothing
end if 
%>
<tr height="44px">
  <td align="right">会员学号：</td>
  <td align="left"><input name="sno" type="text" maxlength="9" onchange="if(/[^0-9]/g.test(this.value)){alert('学号只能输入9位数字哦！');this.value='';}"></td>
</tr>
<tr height="44px">
  <td align="right">加入日期：</td>
  <td align="left"><input type="text" name="cdate"  value="<%=year(now)&"-"&month(now)&"-"&day(now)%>" readonly ="readonly" />
  </td>
</tr>
<tr height="44px">
  <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
</tr>
</table>
</form>
</body>
</html>
