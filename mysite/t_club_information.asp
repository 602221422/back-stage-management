<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>3 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>社团表</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div align="right" style="height:35px">
<br>
<form id="formsearch" name="formsearch" method="get" action="t_club_information.asp">
<label>
   <input type="button" 
   <% if session("authority")=1 then %>
    onclick="location='t_club_information_add.asp'" 
	<% end if %>
	value="增加新社团" /> 
</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

 <label>
    &nbsp;&nbsp; <input name="search" id="search" maxlength="80" value="请输入社团名称" type="text" onclick="this.value=''" onblur="if(this.value=='')this.value='请输入社团名称';"/>
 </label>
 <label>
     <input type="submit" name="Submit" value="提交" />
</label>	 
</form>
<hr width="100%%" size="3" color="#0099FF" />
</div>
<br><br><br><br>
<div class="content">
<div class="mainbar">	
<%
set rs=server.CreateObject("Adodb.Recordset")
Flag=request("search")
if Flag="请输入社团名称" then
  Flag=""
end if
sql="select * from t_club,t_student where t_club.s_no=t_student.s_no and(t_club.cl_name like '%"&Flag&"%' ) order by t_club.cl_no asc"
rs.open sql,conn,3,1
if rs.eof then
response.Write("记录集合为空!")
else
rs.pagesize=4
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
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>社团编号</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>社团名称</b></font></div></td>
			<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>社团创建日期</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>会长学号</b></font></div></td>
			<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>会长姓名</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>社团logo</b></font></div></td>
			<td width="10%" height="30"
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		    <td width="10%" height="30"
			<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <%end if%>    
			><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		  </tr>
<%'输出当前页面记录
for i=0 to rs.pagesize-1
%>
		 <tr height="30">
		    <td ><div align="center"><%=rs("cl_no")%></div></td>
		    <td><div align="center"><%=rs("cl_name")%></div></td>
			<td ><div align="center"><%=rs("cl_date")%></div></td>
		    <td ><div align="center"><%=rs("t_club.s_no")%></div></td>
		    <td ><div align="center"><%=rs("s_name")%></div></td>
		    <td ><div align="center"><img src="<%=rs("cl_picture")%>"></div></td>
		    <td ><div align="center"
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
			><a href="t_club_information_edit.asp?Id=<%=rs("cl_no")%>">修改</a></div></td>
		    <td 
			<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <%end if%>    
			><div align="center"><a href="t_club_information_del.asp?Id=<%=rs("cl_no")%>">删除</a></div></td>
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
</div>
<div class="content"><br><br>
 <p class="pages" align="right">
<%
if nowpage<>1 then
response.Write("<a href='t_club_information.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='t_club_information.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='t_club_information.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='t_club_information.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='t_club_information.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</p>
</div>
</body>
</html>
