<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>3 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
aName=session("guess")
aFlag=session("authority")
%>
<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员表</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div align="right" style="height:35px">
<br>
 <form id="formsearch" name="formsearch" method="get" action="manager_information.asp">
 <label>
 <input type="button" class="btns" 
<%
if session("authority")=1 then
%>
 onclick="location='manager_infor_add.asp'"   
 <% end if %>
 onMouseOver="this.style.backgroundPosition='left -40px'" onMouseOut="this.style.backgroundPosition='left top'"  value="添加新管理员" />
</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <label>
    &nbsp;&nbsp; <input name="search" id="search" maxlength="80" value="请输入管理员名称" type="text" onclick="this.value=''" onblur="if(this.value=='')this.value='请输入管理员名称';"/>
  </label>
 <label>
     <input type="submit" name="Submit" value="提交" />
</label>	 
</form>
<hr width="100%%" size="3" color="#0099FF" />
</div>
<br><br ><br><br>
<div class="content">
<div class="mainbar" style="height:350px">
<%
search=request("search")
if search="请输入管理员名称" then
 search=""
 end if
set rs=server.CreateObject("Adodb.Recordset")
if aName="admin" then
  sql="select * from t_manager where mg_authority>="&aFlag&" and (mg_name like '%"&search&"%' ) order by mg_name asc"
else
  sql="select * from t_manager where mg_authority>="&aFlag&"  and mg_name='"&aName&"' and (mg_name like '%"&search&"%' ) order by mg_name asc"
end if
rs.open sql,conn,3,1
if rs.eof then
response.Write("记录集合为空!")
else
rs.pagesize=10
nowpage=request.QueryString("page")
if nowpage="" then nowpage=1
nowpage=cint(nowpage)
if nowpage<1 then nowpage=1
if nowpage>rs.pagecount then nowpage=rs.pagecount
rs.absolutepage=nowpage
%>
         <p><table width="95%" border="0" cellpadding="0" cellspacing="0" class="main_table">
            <tr class="main_tr">
		    <td width="10%" height="30"><div align="center"><strong><font color="#3366FF">管理员名</font></strong></div></td>
		    <td width="10%" height="30"
			<%
			 if session("authority")>3 then
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
		    <td width="10%" ><div align="center"><%=rs("mg_name")%></div></td>
		    <td width="10%"
			<%
			 if session("authority")>3 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><a href="manager_information_edit.asp?Id=<%=rs("mg_name")%>">修改</a></div></td>
		    <td width="10%"
			<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <%end if%>    
			><div align="center"><a href="manager_information_del.asp?Id=<%=rs("mg_name")%>">删除</a></div></td>
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
response.Write("<a href='manager_information.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='manager_information.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='manager_information.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='manager_information.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='manager_information.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</p>
</div>
</body>
</html>
