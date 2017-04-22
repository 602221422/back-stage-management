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
<title>录入成绩</title>
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
<form name="theForm"  action="grade_infor_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>录入成绩信息</h2></td>
 </tr>
 <tr height="44">
   <td align="right" width="40%">学号：</td>
   <td align="left" width="50%"><input type="text" name="sno" maxlength="9" onchange="if(/[^0-9]/g.test(this.value)){alert('学号只能输入9位数字！');this.value='';}"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td align="right">课程名：</td>
   <td align="left"><input name="cname" type="text"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td align="right">学期：</td>
   <td align="left">
    <label>
    <%
     set rs2=server.CreateObject("Adodb.Recordset")
     sql="select tm_id,tm_term from t_term order by tm_id asc"
     rs2.open sql,conn,3,1
    %>
	<select name="tmid" id="tmid" >
    <%'输出当前页面记录
     for i=1 to rs2.recordcount
    %>
    <option value="<%=rs2("tm_id")%>"><%=rs2("tm_term")%></option>
    <%
     rs2.movenext
     if rs2.eof then exit for
     next
	 rs2.close
	 set rs2=nothing
    %>
    </select>
   </label><font color="#FF0000">*</font>
  </td>
 </tr>
 <tr height="44">
  <td align="right">成绩：</td>
  <td align="left"><input type="text" name="cgrade" maxlength="3" onchange="if(/[^0-9]/g.test(this.value)){alert('成绩只能输入数字哦！');this.value='';}"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
  <td align="right">获得绩点：</td>
  <td align="left"><input name="cgpa" type="text" maxlength="3" onchange="if(/[^0-9]/g.test(this.value)){alert('学分只能输入数字哦！');this.value='';}"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
  <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
 </tr>
</table>
</form>
</body>
</html>
