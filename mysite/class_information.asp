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
<title>班级信息</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div align="right" style="height:35px">
<br>
<form id="formsearch" name="formsearch" method="get" action="class_information.asp">
 <label>
    &nbsp;&nbsp; <input name="search" id="search" maxlength="80" value="请输入班级名称" type="text" onclick="this.value=''" onblur="if(this.value=='')this.value='请输入班级名称';"/>
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
if search="请输入班级名称" then
 search=""
 end if
set rs=server.CreateObject("Adodb.Recordset")
sql="select * from t_class,t_dept where t_dept.d_no=t_class.d_no and (cs_name like '%"&search&"%' ) order by cs_no asc"
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
          <p><table width="95%" border="0"height="50" cellpadding="0" cellspacing="0" class="main_table">
            <tr class="main_tr">
            <td width="10%"height="30"><div align="center"><strong><font color="#3366FF">班级编号</font></strong></div></td>
			<td width="10%" height="30"><div align="center"><strong><font color="#3366FF">班级名称</font></strong></div></td>
		    <td width="10%" height="30"><div align="center"><strong><font color="#3366FF">所属系</font></strong></div></td>
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

		    <td ><div align="center"><%=rs("cs_no")%></div></td>
			<td ><div align="center"><%=rs("cs_name")%></div></td>
		    <td><div align="center"><%=rs("d_name")%></div></td>
		    <td
			<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <%end if%>    
			><div align="center"><a href="class_information_del.asp?id=<%=rs("cs_no")%>">删除</a></div></td>
		    </tr>
<%
rs.movenext
if rs.eof then exit for
next
%> </tr>
		  </table>
</p>
</div>
<p class="pages" align="right">
<%
if nowpage<>1 then
response.Write("<a href='class_information.asp?page=1&search="&request("search")&"'>首页</a>&nbsp;<a href='class_information.asp?page="&nowpage-1&"&search="&request("search")&"'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='class_information.asp?page="&i&"&search="&request("search")&"'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='class_information.asp?page="&nowpage+1&"&search="&request("search")&"'>下一页</a>&nbsp;<a href='class_information.asp?page="&rs.pagecount&"&search="&request("search")&"'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</div>
</body>
</html>
