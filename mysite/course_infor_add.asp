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
<title>录入课程</title>
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
<form name="theForm"  action="course_infor_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>添加课程信息</h2></td>
 </tr>
 <tr height="44">
   <td align="right" width="40%">课程号：</td>
   <td align="left" width="60%"><input type="text" maxlength="8" name="cno" onchange="if(/[^0-9]/g.test(this.value)){alert('课程号只能输入8位数字哦！');this.value='';}"><font color="#FF0000">* 如(2011+1+001)</font></td>
 </tr>
 <tr height="44">
   <td align="right">课程名：</td>
   <td align="left"><input name="cname" type="text"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td align="right">学分：</td>
   <td align="left"><input type="text" name="ccredit" maxlength="3" onchange="if(/[^0-9]/g.test(this.value)){alert('学分只能输入数字哦！');this.value='';}"><font color="#FF0000">*</font></td>
  </tr>
  <tr height="44">
   <td align="right">学时：</td>
   <td align="left"><input name="cperiod" type="text" maxlength="3" onchange="if(/[^0-9]/g.test(this.value)){alert('学时只能输入数字哦！');this.value='';}"><font color="#FF0000">*</font></td>
  </tr>
  <tr height="44">
   <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
  </tr>
</table>
</form>
</body>
</html>
