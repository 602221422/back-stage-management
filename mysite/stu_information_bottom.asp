<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="conn.asp"-->
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学生表</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div align="center" class="content">

<div class="mainbar" style="height:350px">
<%
set rs=server.CreateObject("Adodb.Recordset")
csid=trim(request.Form("csid"))             '班级编号
noorname=trim(request.Form("noorname"))  '学号或姓名 
if noorname="请输入学号或姓名" then
 noorname=""
end if            
if noorname="" and csid="" then
   sql1="select s_no,s_name,s_sex,s_age,d_name,cs_name,s_phone,t_student.d_no from t_student,t_dept,t_class where t_class.cs_no=t_student.cs_no and t_student.d_no=t_dept.d_no  order by s_no asc"

else if csid="" then
   sql1="select s_no,s_name,s_sex,s_age,d_name,cs_name,s_phone,t_student.d_no from t_student,t_dept,t_class where t_class.cs_no=t_student.cs_no and t_student.d_no=t_dept.d_no and (s_name like '%"&noorname&"%' or s_no like '%"&noorname&"%'  ) order by s_no asc"
 
  else
   sql1="select s_no,s_name,s_sex,s_age,d_name,cs_name,s_phone,t_student.d_no from t_student,t_dept,t_class where t_class.cs_no=t_student.cs_no and t_student.d_no=t_dept.d_no and (s_name like '%"&noorname&"%' or s_no like '%"&noorname&"%'  ) and  t_student.cs_no='"&csid&"' order by s_no asc"
  end if
end if
rs.open sql1,conn,3,1
if rs.eof then
  response.Write("目前还没有学生信息!")
else
  rs.pagesize=8
  nowpage=request.QueryString("page")
  if nowpage="" then nowpage=1
    nowpage=cint(nowpage)
    if nowpage<1 then nowpage=1
       if nowpage>rs.pagecount then nowpage=rs.pagecount
          rs.absolutepage=nowpage
%>
<p>
		  <table width="95%" border="0" cellpadding="0" cellspacing="0" class="main_table">
          <tr class="main_tr">
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>学号</b></font></div></td>
			<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>姓名</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>性别</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>年龄</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>所在系</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>班级</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><strong><font color="#3366FF">联系电话</font></strong></div></td>
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
		 <tr height="30">
		    <td ><div align="center"><%=rs("s_no")%></div></td>
		    <td><div align="center"><%=rs("s_name")%></div></td>
			<td ><div align="center"><%=rs("s_sex")%></div></td>
		    <td ><div align="center"><%=rs("s_age")%></div></td>
		    <td ><div align="center"><%=rs("d_name")%></div></td>
		    <td ><div align="center"><%=rs("cs_name")%></div></td>
		    <td ><div align="center"><%=rs("s_phone")%></div></td>
		    <td 
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><a href="stu_information_edit.asp?Id=<%=rs("s_no")%>" target="in">修改</a></div></td>
		    <td
			<%
			 if(session("authority")<>1) then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><a href="stu_information_del.asp?Id=<%=rs("s_no")%>" target="in">删除</a></div></td>
		    </tr>
<%
rs.movenext
if rs.eof then exit for
next
%>
 </tr>
</table>
</p>
</div>
 <p class="pages" align="right">
<%
if nowpage<>1 then
response.Write("<a href='stu_information_bottom.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='stu_information_bottom.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='stu_information_bottom.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='stu_information_bottom.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='stu_information_bottom.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</p>
</div>
</body>
</html>
