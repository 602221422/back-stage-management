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
<title>寝室电费信息</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div align="right" style="height:35px">
<br>
<form id="formsearch" name="formsearch" method="get" action="electricity_information.asp">
<label>
   <input type="button" 
   <% if session("authority")<3 and session("authority")>=1 then%>
    onclick="location='electricity_infor_add.asp'" 
	<%end if%>
	value="添加寝室" /> 
</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <label>
    &nbsp;&nbsp;<input name="search" id="search" maxlength="80" value="请输入寝室号"  type="text" onclick="this.value=''"/>
 </label>
 <label>
     <input type="submit" name="Submit" value="提交" />
</label>	 
</form>
<hr width="100%%" size="3" color="#0099FF" />
</div>
<br><br><br><br>
<div class="content">
<div class="mainbar" style="height:350px">
<%
set rs=server.CreateObject("Adodb.Recordset")
Flag=request("search")
if Flag="请输入寝室号" then
  Flag=""
end if

sql="select *from t_electricity where (e_no like '%"&Flag&"%' ) order by e_no desc"
rs.open sql,conn,3,1
if rs.eof then
response.Write("没有寝室信息哦!")
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
		    <td width="10%" height="30"><div align="center"><strong><font color="#3366FF">寝室编号</font></strong></div></td>
		    <td width="10%" height="30"><div align="center"><strong><font color="#3366FF">电费余额</font></strong></div></td>
		    <td width="10%" height="30"
			<%
			 if session("authority")>3 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		    <td width="10%" height="30"
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		  </tr>
<%'输出当前页面记录
for i=0 to rs.pagesize-1
%>
<tr height="30">
		    <td width="10%" ><div align="center"><%=rs("e_no")%></div></td>
		    <td width="10%"><div align="center"><%=rs("e_balance")%></div></td>
		    <td width="10%"
			<%
			 if session("authority")>3 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><a href="electricity_information_edit.asp?Id=<%=rs("e_no")%>">修改</a></div></td>
		    <td width="10%"
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><a href="electricity_information_del.asp?Id=<%=rs("e_no")%>">删除</a></div></td>
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
response.Write("<a href='electricity_information.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='electricity_information.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='electricity_information.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='electricity_information.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='electricity_information.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</p>
</div>
</div>
</body>
</html>
