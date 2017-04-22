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
<title>教室查询</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="searchform" style="height:80px">
          <form id="formsearch" name="formsearch" method="get" action="classroom_information.asp">
            <span>
            <input name="search" class="editbox_search" id="search" maxlength="80" value="请输入教室编号" type="text" onclick="this.value=''"/>
            </span>
            <input name="button_search" src="images/search_btn.gif" class="button_search" type="image" />
          </form>
</div>
<hr width="100%%" size="3" color="#0099FF" />
<div class="content">
<div class="mainbar" id="online" style="height:350px">
<%
search=request("search")
if search="请输入教室编号" then
 search=""
 end if
set rs=server.CreateObject("Adodb.Recordset")
sql="select *from t_classroom where (cr_no like '%"&search&"%') order by cr_no asc"
rs.open sql,conn,3,1
if rs.eof then
response.Write("没有教室信息!")
else
rs.pagesize=10
nowpage=request.QueryString("page")
if nowpage="" then nowpage=1
nowpage=cint(nowpage)
if nowpage<1 then nowpage=1
if nowpage>rs.pagecount then nowpage=rs.pagecount
rs.absolutepage=nowpage
%>
          <p><table width="95%" border="0"height="50" cellpadding="0" cellspacing="0" class="main_table">
            <tr class="main_tr">
            <td width="10%"height="30"><div align="center"><strong><font color="#3366FF">教室编号</font></strong></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>地点</b></font></div></td>
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
<tr height="30" >

		    <td ><div align="center"><%=rs("cr_no")%></div></td>
			 <td><div align="center"><%=rs("cr_place")%></div></td>
		    <td
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><a href="classroom_information_edit.asp?id=<%=rs("cr_no")%>">修改</a></div></td>
		    <td
			<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <%end if%>    
			><div align="center"><a href="classroom_information_del.asp?id=<%=rs("cr_no")%>">删除</a></div></td>
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
response.Write("<a href='classroom_information.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='classroom_information.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='classroom_information.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='classroom_information.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='classroom_information.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</div>
</body>
</html>
