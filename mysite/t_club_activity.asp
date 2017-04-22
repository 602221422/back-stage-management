<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")=1 or session("authority")=4 then
    else
	response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
Fname=""
if session("authority")=4 then
 Fname=session("guess")
 end if
%>
<!--#include file="conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>社团活动表</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.btton { 
margin:10px 0 0 400px;
width:143px; height:36px;  background:url("images/bg11.jpg") ; color:#FFF; }
.inputsearch{ 
margin:10px 0px 0 0;
width:200px;
height:34px;
 color: #122e29;
 float:right;
 background-color: #73b9a2;
 }
 .button_search{
 margin:10px 40px 0 0;
 float:right;

 }
</style>
</head>
<body>
<div align="right" style="height:35px">
<form id="formsearch" name="formsearch" method="get" action="t_club_activity.asp">
<label>
 <input type="button" class="btton" onclick="location='t_club_activity_add.asp'" value="增加社团活动" />
</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <label>
    &nbsp;&nbsp; <input name="search" id="search" maxlength="80" value="请输入活动内容关键词" type="text" onclick="this.value=''" onblur="if(this.value=='')this.value='请输入活动内容关键词';"/>
  </label>
 <label>
     <input type="submit" name="Submit" value="提交" />
</label><br><br>
<hr width="100%%" size="3" color="#0099FF" />	 
</form>
</div>
<br><br><br><br>
<div class="content">
<div class="mainbar" style="height:350px">
<%
set rs=server.CreateObject("Adodb.Recordset")
if Fname="" then
    sql="select * from t_new,t_club where  t_new.source=t_club.cl_name and (body like '%"&request("search")&"%' ) order by ptime asc"
else
  set rs1=server.CreateObject("Adodb.Recordset")
  sql="select * from t_club where s_no='"&Fname&"'"
  rs1.open sql,conn,3,1
  clno=rs1("cl_name")
  rs1.close
  set rs1=nothing
    sql="select * from t_new,t_club where t_new.source='"&clno&"' and t_new.source=t_club.cl_no and (body like '%"&request("search")&"%' ) order by ptime asc"
end if
rs.open sql,conn,3,1
if rs.eof then
response.Write("记录集合为空!")
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
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>社团名称</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>发表时间</b></font></div></td>
			<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>活动内容</b></font></div></td>
						 <td width="10%" height="30"><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		    <td width="10%" height="30"><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		  </tr>
<%'输出当前页面记录
for i=0 to rs.pagesize-1
%>
		 <tr height="30">
		    <td ><div align="center"><%=rs("cl_name")%></div></td>
		    <td><div align="center"><%=rs("ptime")%></div></td>
			<td ><div align="center"><%=rs("body")%></div></td>
		    <td ><div align="center"><a href="t_club_activity_edit.asp?Id=<%=rs("nid")%>">修改</a></div></td>
		    <td ><div align="center"><a href="t_club_activity_del.asp?Id=<%=rs("nid")%>">删除</a></div></td>
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
response.Write("<a href='t_club_activity.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='t_club_activity.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='t_club_activity.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='t_club_activity.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='t_club_activity.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%></p>
</div>
</body>
</html>
