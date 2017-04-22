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
<title>修改寝室电费</title>
<style type="text/css">
.style3{
   width: 550px;
   height: 250px;
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
e_id=request.QueryString("id")
set rs=server.CreateObject("Adodb.Recordset")
sql="select *from t_electricity where e_no='"&e_id&"'"
rs.open sql,conn,3,1
if rs.bof or rs.eof then
    rs.close
	set rs=nothing
	response.write "没有符合条件的记录"
else
%>
<br>
<form name="theForm"  action="electricity_information_edit_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>修改寝室电费</h2></td>
 </tr>
 <tr height="44">
   <td align="right" width="40%">寝室编号：</td>
   <td align="left" width="60%"><input type="text" name="eno" readonly="readonly" value=<%=rs("e_no")%>></td> 
 </tr>
 <tr height="44">
   <td align="right">电费余额：</td>
   <td align="left"><input name="ebalance" type="text" value=<%=rs("e_balance")%>><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
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
