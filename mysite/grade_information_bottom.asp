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
<div class="mainbar" style="height:350px">
<%
set rs=server.CreateObject("Adodb.Recordset")
tmid=trim(request.Form("tmid"))             '学期编号
csid=trim(request.Form("csid"))             '班级编号
noorname=trim(request.Form("noorname"))             '学号或课程名
if noorname="请输入学号或课程名" then
   noorname=""
end if
if tmid="" and csid="" then
	sql="select *from t_student,t_course,t_term,t_grade where t_student.s_no=t_grade.s_no and t_course.c_no=t_grade.c_no and t_term.tm_id=t_grade.tm_id and (c_name like '%"&noorname&"%' or t_grade.s_no='"&noorname&"') order by t_grade.s_no asc"
else if tmid="" then
    sql="select *from t_student,t_course,t_term,t_grade where t_student.s_no=t_grade.s_no and t_course.c_no=t_grade.c_no and t_term.tm_id=t_grade.tm_id and (t_course.c_name like '%"&noorname&"%' or t_grade.s_no='"&noorname&"') and t_student.cs_no='"&csid&"' order by t_grade.s_no asc"
   else if csid="" then
       sql="select *from t_student,t_course,t_term,t_grade where t_student.s_no=t_grade.s_no and t_course.c_no=t_grade.c_no and t_term.tm_id=t_grade.tm_id and (t_course.c_name like '%"&noorname&"%'  or t_grade.s_no='"&noorname&"') and t_grade.tm_id="&tmid&" order by t_grade.s_no asc"
     else if csid<>"" and tmid<>"" then
	     sql="select *from t_student,t_course,t_term,t_grade where t_student.s_no=t_grade.s_no and t_course.c_no=t_grade.c_no and t_term.tm_id=t_grade.tm_id and (t_course.c_name like '%"&noorname&"%'  or t_grade.s_no='"&noorname&"') and t_student.cs_no='"&csid&"' and t_grade.tm_id="&tmid&" order by t_grade.s_no asc"
		 end if
	  end if
   end if
end if

rs.open sql,conn,3,1
if rs.eof then
response.Write("目前没有成绩记录!")
else
rs.pagesize=10
nowpage=request.QueryString("page")
if nowpage="" then nowpage=1
nowpage=cint(nowpage)
if nowpage<1 then nowpage=1
if nowpage>rs.pagecount then nowpage=rs.pagecount
rs.absolutepage=nowpage
%>
<p>
<table width="95%" border="0"height="50" cellpadding="0" cellspacing="0" class="main_table">
   <tr class="main_tr">
        <td width="10%"height="30"><div align="center"><strong><font color="#3366FF">学号</font></strong></div></td>
	    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>姓名</b></font></div></td>
	    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>课程号</b></font></div></td>
		<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>课程名</b></font></div></td>
		<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>学期</b></font></div></td>
		<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>成绩</b></font></div></td>
		<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>获得学分</b></font></div></td>
		<td width="10%" height="30"
		<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <% end if %>    
		><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		<td width="10%" height="30"
			 <%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <% end if %>    
		><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
	</tr>
<%'输出当前页面记录
for i=0 to rs.pagesize-1
%>
   <tr height="30" >
	    <td ><div align="center"><%=rs("t_grade.s_no")%></div></td>
		<td><div align="center"><%=rs("s_name")%></div></td>
		<td><div align="center"><%=rs("t_course.c_no")%></div></td>
		<td><div align="center"><%=rs("c_name")%></div></td>
		<td ><div align="center"><%=rs("tm_term")%></div></td>
		<td><div align="center"><%=rs("c_grade")%></div></td>
		<td><div align="center"><%=rs("c_gpa")%></div></td>
		<td
		<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <% end if %>    
		><div align="center"><a href="grade_information_edit.asp?s_id=<%=rs("t_grade.s_no")%>&c_id=<%=rs("t_course.c_no")%>" target="in">修改</a></div></td>
		<td
		<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <% end if %>    
		><div align="center"><a href="grade_information_del.asp?s_id=<%=rs("t_grade.s_no")%>&c_id=<%=rs("t_course.c_no")%>" target="in">删除</a></div></td>
	</tr>
<%
rs.movenext
if rs.eof then exit for
next
%> 
</table>
 </p>
</div>
<p class="pages" align="right">
<%
if nowpage<>1 then
response.Write("<a href='grade_information_bottom.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='grade_information_bottom.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='grade_information_bottom.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='grade_information_bottom.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='grade_information_bottom.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</div>

</body>
</html>
