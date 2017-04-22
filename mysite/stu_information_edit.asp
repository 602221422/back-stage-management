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
<title>学生信息编辑</title>
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
<%set rs=server.CreateObject("Adodb.Recordset")
s_id=request.QueryString("id")
sql="select s_no,s_password,s_name,s_sex,s_age,t_student.d_no,d_name,t_student.cs_no,cs_name,s_phone from t_student,t_dept,t_class where t_class.cs_no=t_student.cs_no and t_student.d_no=t_dept.d_no and s_no='"&s_id&"'"
rs.open sql,conn,3,1
if rs.bof or rs.eof then
   rs.close
   set rs=nothing
	response.write "没有符合条件的记录"
else
%>
<form name="theForm"  action="stu_informaton_edit_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="40">
    <td colspan="2" align="center" ><h2>修改学生信息</h2></td>
  </tr>
 <tr height="36">
    <td align="right" width="40%">学号：</td>
	<td align="left" width="60%"><input type="text" name="sno"  readonly="readonly" value=<%=rs("s_no")%> /></td>
 </tr>
 <tr height="36">
    <td align="right">密码：</td>
	<td align="left"><input name="password" type="text" value=<%=rs("s_password")%> /></td>
  </tr>
  <tr height="36">
    <td align="right">姓名：</td>
	<td align="left"><input type="text" name="name"  value=<%=rs("s_name")%> /></td>
  </tr>
  <tr height="36">
    <td align="right">性别：</td>
    <td align="left">
          <label>
          <input name="sex" type="radio" value="男" 
		 <% 
		  if rs("s_sex") = "男" then response.write "checked='checked'"%> /> 男 <input type="radio" name="sex" <%if rs("s_sex") = "女" then response.write "checked='checked'"%> value="女" /> 女</label>
        </td>     
  </tr>
  <tr height="36">
    <td align="right">年龄：</td>
    <td align="left"><input name="age" type="text" value=<%=rs("s_age")%>  maxlength="2" onchange="if(/[^0-9]/g.test(this.value)){alert('年龄只能输入数字哦！');this.value='';}"></td>
  </tr>
  <tr height="36">
     <td align="right">所在系：</td>
	 <td align="left">
	  <label>
	      <%
            set rs2=server.CreateObject("Adodb.Recordset")
            sql="select d_no,d_name from t_dept order by d_no asc"
            rs2.open sql,conn,3,1
         %>
	   <select name="dept" id="dept" value=<%=rs(6)%>>
         <%'输出当前页面记录
          for i=0 to rs2.pagesize-1
         %>
          <option value=" <%=rs2("d_no")%>"><%=rs2("d_name")%></option>
         <%
         rs2.movenext
         if rs2.eof then exit for
        next
		rs2.close
        %>
         </select>
		 </label>
      </td>
  </tr>
  <tr height="36">
      <td align="right">班级：</td>
      <td align="left">
          <label>
		  <%
            set rs1=server.CreateObject("Adodb.Recordset")
            sql="select cs_no,cs_name from t_class order by cs_no asc"
            rs1.open sql,conn,3,1
         %>
          <select name="class" id="class" value=<%=rs(8)%> >
		  <%'输出当前页面记录
          for i=0 to rs1.pagesize-1
         %>
		    <option value="<%=rs1("cs_no")%>"><%=rs1("cs_name")%></option>
		<%
         rs1.movenext
         if rs1.eof then exit for
        next
		rs1.close
        %>
          </select>
          </label>
        </td>
    </tr>
	<tr height="36">
       <td align="right">联系电话：</td>
	   <td align="left"><input type="text" name="Phone"  value=<%=rs("s_phone")%>  maxlength="11" onchange="if(/[^0-9]/g.test(this.value)){alert('电话号码只能输入数字哦！');this.value='';}"></td>
    </tr>
    <tr height="36">
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
