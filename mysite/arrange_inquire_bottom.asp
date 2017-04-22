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
tmid=trim(request.Form("tmid"))
did=trim(request.Form("did"))
if tmid="" or did="" then
 response.Write("请选择学期和班级！")
else
  sql="select c_name,ar_week,ar_weeks,cr_no,st_no from t_arrange,t_course where t_arrange.c_no=t_course.c_no and d_no='"&did&"' and  tm_id="&tmid&" order by st_no asc"
  rs.open sql,conn,3,1
  if rs.eof then
    response.Write("该课程表还没做哦!")
	rs.close
  else
    set rs1=server.CreateObject("Adodb.Recordset")
    sql1="select *from t_stime order by st_no asc"
    rs1.open sql1,conn,3,1
%>
          <p><table width="100%"  border="1" cellpadding="0" cellspacing="0" class="main_table">
		   <tr class="main_tr" height="10%">
		    <td width="7%" height="30"><div align="center"><font color="#3366FF"><b></b></font></div></td>
		    <td width="9%" height="30"><div align="center"><font color="#3366FF"><b>星期一</b></font></div></td>
			<td width="8%" height="30"><div align="center"><font color="#3366FF"><b>星期二</b></font></div></td>
		    <td width="8%" height="30"><div align="center"><font color="#3366FF"><b>星期三</b></font></div></td>
		    <td width="8%" height="30"><div align="center"><font color="#3366FF"><b>星期四</b></font></div></td>
			<td width="8%" height="30"><div align="center"><font color="#3366FF"><b>星期五</b></font></div></td>
		    <td width="8%" height="30"><div align="center"><font color="#3366FF"><b>星期六</b></font></div></td>
			<td width="8%" height="30"><div align="center"><font color="#3366FF"><b>星期日</b></font></div></td>
		  </tr>
		  
<%
execute("dim arrTwoDim("&rs1.recordcount&",7)")  '解析为常量
for i=1 to rs.recordcount
 arrTwoDim(rs("st_no"),rs("ar_week"))=arrTwoDim(rs("st_no"),rs("ar_week"))+"<br>"+""&rs("c_name")&"<br>"&rs("ar_weeks")&"<br>"&rs("cr_no")&""
 rs.movenext
if rs.eof then exit for
next
rs.close

%>

<%'第几节课
for i=1 to rs1.recordcount
%>
		 <tr height="40">
		    <td><div align="center">第<%=rs1("st_no")%>节<br><%=rs1("st_time")%></div></td>
	      <%'星期的上课信息
		  for j=1 to 7
           %>
		    <td><div align="center"><%=arrTwoDim(i,j)%></div></td>		
			<%
			if j=7 then exit for
		   next
			%>
		    </tr>
<%
next
%> 
		  </table>

<%
rs1.close

end if
end if
set conn=nothing
%>
</p>
</div>
</div>
</body>
</html>
