<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	if session("guess")= "" or session("flag")<>"admin"then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	 else if session("authority")>1 then
	     response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
     end if
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加教室</title>
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
<br>
<form name="theForm"  action="classroom_infor_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>添加教室信息</h2></td>
 </tr>
 <tr height="44">
   <td align="right" width="30%">教室编号：</td>
   <td align="left" width="70%"><input type="text" name="crno"><font color="#FF0000">* 如(3A-101、南东101)</font></td> 
 </tr>
 <tr height="44">
   <td align="right">地点：</td>
   <td align="left"><input name="crplace" type="text"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
 </tr>
</table>
</form>
</body>
</html>
