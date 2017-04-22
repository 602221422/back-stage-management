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
<title>添加班级</title>
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
<br>
<form name="theForm"  action="class_infor_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>添加班级信息</h2></td>
 </tr>
 <tr height="44">
   <td align="right" width="40%">班级编号：</td>
   <td align="left" width="60%"><input type="text" name="csno" maxlength="6" onchange="if(/[^0-9]/g.test(this.value)){alert('班级编号只能输入6位数字哦！(年+两位编号)');this.value='';}"><font color="#FF0000">*如：(2011+39)</font></td> 
 </tr>
 <tr height="44">
   <td align="right">班级名称：</td>
   <td align="left"><input name="csname" type="text"><font color="#FF0000">*</font></td>
 </tr>
 <tr height="44">
   <td align="right">所属系：</td>
   <td align="left">
	 <label>
	  <%
       set rs2=server.CreateObject("Adodb.Recordset")
       sql="select d_no,d_name from t_dept order by d_no asc"
       rs2.open sql,conn,3,1
      %>
	  <select name="dno" id="dno" >
      <%'输出当前页面记录
       for i=1 to rs2.recordcount
      %>
       <option value=" <%=rs2("d_no")%>"><%=rs2("d_name")%></option>
      <%
       rs2.movenext
       if rs2.eof then exit for
       next
	   rs2.close
      %>
      </select>
	 </label><font color="#FF0000">*</font>
   </td>
 </tr>
 <tr height="44">
   <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
 </tr>
</table>
</form>
</body>
</html>
