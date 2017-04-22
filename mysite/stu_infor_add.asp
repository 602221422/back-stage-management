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
<title>录入学生</title>
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
<form name="stu_Form"  action="stu_infor_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
  <tr height="48">
    <td colspan="2" align="center" ><h2>添加学生信息</h2></td>
  </tr>
  <tr height="41">
    <td align="right" width="40%">学号：</td>
    <td align="left" width="50%"><input type="text" id="num" name="sno" maxlength="9" onchange="if(/[^0-9]/g.test(this.value)){alert('学号只能输入9位数字哦！');this.value='';}" ><font color="#FF0000">*如(120113902)</font></td>
  </tr>
  <tr height="41">
    <td align="right">姓名：</td>
    <td align="left"><input name="sname" type="text"><font color="#FF0000">*</font></td>
  </tr>
  <tr height="41">
    <td align="right">初始密码：</td>
    <td align="left"><input name="spassword" type="text"  readonly ="readonly" value="123456"></td> 
  </tr>
  <tr height="41">
    <td align="right">性别：</td>
    <td align="left">
	 <select name="ssex" id="ssex">
       <option value="男">男</option>
	   <option value="女">女</option>
      </select><font color="#FF0000">*</font>
	</td>
  </tr>
  <tr height="41">
    <td align="right">年龄：</td>
    <td align="left"><input name="sage" type="text" maxlength="2" onchange="if(/[^0-9]/g.test(this.value)){alert('年龄只能输入数字哦！');this.value='';}"><font color="#FF0000">*</font></td>
  </tr>
  <tr height="41">
  <td align="right">班级：</td>
  <td align="left">
    <label>
    <%
     set rs2=server.CreateObject("Adodb.Recordset")
     sql="select *from t_class order by cs_no asc"
     rs2.open sql,conn,3,1
    %>
	<select name="csid" id="csid"  >
    <%'输出当前页面记录
     for i=1 to rs2.recordcount
    %>
       <option value=" <%=rs2("cs_no")%>"><%=rs2("cs_name")%></option>
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
 <tr height="41">
    <td align="right">联系电话：</td>
	<td align="left"><input type="text" name="sphone" maxlength="11" onchange="if(/[^0-9]/g.test(this.value)){alert('电话号码只能输入数字哦！');this.value='';}"></td>
  </tr>
  <tr height="41">
   <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
  </tr>
</table>
</form>
</body>
</html>