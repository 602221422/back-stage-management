<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	if session("guess")= "" or session("flag")<>"admin"then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	 else if session("authority")>2 then
	     response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
     end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>教室信息修改</title>
<style type="text/css">
.style3{
   width: 550px;
   height: 200px;
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
<br />
<%set rs=server.CreateObject("Adodb.Recordset")
crid=request.QueryString("id")
sql="select * from t_classroom where cr_no='"&crid&"'"
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	rs.close
	set rs=nothing
	response.write "没有符合条件的记录"
else
%>
<form name="theForm"  action="classroom_information_edit_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>修改教室信息</h2></td>
 </tr>
 <tr height="44">
   <td align="right" width="40%">教室编号：</td> 
   <td align="left" width="60%"> <input type="text" name="crno" readonly ="readonly" value=<%=rs("cr_no")%> /> </td>
 </tr>
 <tr height="44">
   <td align="right">地点：</td> 
   <td align="left"> <input type="text" name="crplace" value=<%=rs("cr_place")%> /> </td>
 </tr>
 <tr height="44">
   <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交" /></td>
 </tr>
</table>
</form>
<%
rs.close
set rs=nothing
end if
conn.close
set conn=nothing
%>

</body>
</html>
