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
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
<title>成绩查询</title>
</head>
<body>
<div class="content">
<div class="mainbar">
<%
set rs=server.CreateObject("Adodb.Recordset")
exid=trim(request.Form("exid"))
if exid="" then
 response.Write("请选择科目！")
else
  sql="select *from t_exam,t_student,t_apply where t_student.s_no=t_apply.s_no and t_exam.ex_id=t_apply.ex_id and t_apply.ex_id='"&exid&"' order by ex_name asc"
  rs.open sql,conn,3,1
  if rs.eof then
    response.Write("目前还没有同学报名哦!")
	rs.close
  else
%>
          <p><table width="100%"  border="1" cellpadding="0" cellspacing="0" class="main_table">
		   <tr class="main_tr" height="10%">
		    <td width="9%" height="30"><div align="center"><font color="#3366FF"><b>项目名称</b></font></div></td>
			<td width="8%" height="30"><div align="center"><font color="#3366FF"><b>报名人</b></font></div></td>
		    <td width="8%" height="30"
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
			><div align="center"><font color="#3366FF"><b>操作</b></font></div></td>
		  </tr>
<%'输出当前页面记录
for i=1 to rs.recordcount
%>
   <tr height="30" >
		<td><div align="center"><%=rs("ex_name")%></div></td>
		<td><div align="center"><%=rs("s_name")%></div></td>
        <td><div align="center"
            <%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <%end if%>    
		 ><a target="in" href="apply_information_del.asp?exId=<%=rs("t_apply.ex_id")%>&sId=<%=rs("t_apply.s_no")%>">删除</a></div></td>
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
conn.close
set conn=nothing
%>
</body>
</html>
