<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>3 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>成绩查询</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="content">
<div class="mainbar">
<%
set rs=server.CreateObject("Adodb.Recordset")
tmid=trim(request.Form("tmid"))             '学期编号
noorname=trim(request.Form("noorname"))             '学号或课程名
if noorname="请输入学号" then
   noorname=""
end if

if tmid="" then
   response.Write("请选择学期哦！")
  else if noorname="" then
     response.Write("忘了告诉你，学号也得输入哦！")
   else
	sql="select *from t_student,t_course,t_grade,t_class where t_student.s_no=t_grade.s_no and t_course.c_no=t_grade.c_no and t_student.s_no='"&noorname&"' and tm_id="&tmid&" and t_student.cs_no=t_class.cs_no order by t_grade.c_no asc"
    rs.open sql,conn,3,1
     if rs.eof then
       response.Write("目前没有该同学成绩记录哦!")
     else
%>
<p>
<table width="95%" border="1"height="50" cellpadding="0" cellspacing="0" class="main_table">
   <tr height="30px">
        <td width="10%"><div align="center">班级<br></div></td>
		<td width="25%"><div align="center"><%=rs("cs_name")%></div></td>
		<td width="20%"><div align="center">姓名</div></td>
		<td width="20%"><div align="center"><%=rs("s_name")%></div></td>
   </tr>
   <tr class="main_tr">
	    <td width="25%" height="30"><div align="center"><font color="#3366FF"><b>课程号</b></font></div></td>
		<td width="25%" height="30"><div align="center"><font color="#3366FF"><b>课程名</b></font></div></td>
		<td width="25%" height="30"><div align="center"><font color="#3366FF"><b>成绩</b></font></div></td>
		<td width="25%" height="30"><div align="center"><font color="#3366FF"><b>获得学分</b></font></div></td>
	</tr>
<%'输出当前页面记录
for i=1 to rs.recordcount
%>
   <tr height="30" >
		<td><div align="center"><%=rs("t_course.c_no")%></div></td>
		<td><div align="center"><%=rs("c_name")%></div></td>
		<td><div align="center"><%=rs("c_grade")%></div></td>
		<td><div align="center"><%=rs("c_gpa")%></div></td>
	</tr>
<%
rs.movenext
if rs.eof then exit for
next
%> 
</table>
 </p>
</div>
</div>
<%
rs.close
set rs=nothing
end if
end if
end if
conn.close
set conn=nothing
%>

</body>
</html>
