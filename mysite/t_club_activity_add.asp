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
<title>社团活动添加</title>
<style type="text/css">
.style3{
width: 550px;
height: 100%;
margin: 0px auto;
margin-bottom:20px;
border:1px solid #BBE1F1;
background-color: #EEFAFF;
}
</style>
<script type="text/javascript" src="SimpleTextEditor.js"></script>
<link rel="stylesheet" type="text/css" href="SimpleTextEditor.css">

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
<form name="theForm"  action="t_club_activity_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
<tr height="48px">
 <td colspan="2" align="center" ><h2>添加社团活动</h2></td>
</tr>
<%if Fname="" then%>
<tr height="44px">
 <td >社团名称：
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
	 </label><font color="#FF0000">*</font>
 </td>
</tr>
<% else %>
<tr height="44px">
 <td >社团编号：
<input type="text" name="clno2" value=<%=rs("cl_no")%> readonly ="readonly"/></td>
</tr>
<tr height="44px">
 <td >社团名称：
 <input type="text" name="clname" value=<%=rs("cl_name")%> readonly ="readonly"/></td>
</tr>
<%
rs.close
set rs=nothing
end if 
%>
<tr height="44px">
  <td >标&nbsp;&nbsp;&nbsp; 题：
    <input name="title" type="text" /></td>
</tr>
<tr height="44px">
  <td >发布时间：
 <input name="ctime" type="text" value="<%=year(now)&"-"&month(now)&"-"&day(now)%>" readonly ="readonly"/></td>
</tr>
<tr height="44px">
  <td >发布内容：
  <textarea name="body" id="body" cols="40" rows="10"> </textarea></td>
</tr>
<script type="text/javascript">
        var ste = new SimpleTextEditor("body", "ste");
        ste.init();
        </script>
<tr height="44px">
  <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交" onclick="ste.submit();"></td>
</tr>
</table>
</form>
</body>
</html>
