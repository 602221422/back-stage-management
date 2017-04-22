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
<title>社团添加</title>
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
<br>
<form name="theForm"  action="t_club_information_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>添加社团</h2></td>
 </tr>
  <tr height="44">
   <td align="right" width="40%">社团编号：</td>
   <td align="left" width="60%"><input type="text" name="cno" maxlength="3" onchange="if(/[^0-9]/g.test(this.value)){alert('社团编号只能输入数字哦!');this.value='';}"><font color="#FF0000">*如(101)</font></td>
 </tr>
 <tr height="44">
   <td align="right">社团名称：</td>
   <td align="left"><input name="cname" type="text"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td align="right">社团创建日期：</td>
   <td align="left"><input type="text" name="cdate" value="<%=year(now)&"-"&month(now)&"-"&day(now)%>"readonly ="readonly"></td>
 </tr>
 <tr height="44">
   <td align="right">会长学号：</td>
   <td align="left"><input type="text" name="sno" maxlength="9" onchange="if(/[^0-9]/g.test(this.value)){alert('学号只能输入9位数字哦！');this.value='';}"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td align="right">社团logo：</td>
   <td align="left">请在社团表修改选项里边进行添加，尺寸和容量不要太大哦，亲！</td>
 </tr>
 <tr height="44">
   <td align="right">社团简介：</td>
   <td align="left"><textarea name="cbrief"></textarea></td>
 </tr>
 <tr height="44">
   <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
 </tr>
</table>
</form>
</body>
</html>
