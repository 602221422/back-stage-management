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
<title>课表信息</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="content">
<div class="mainbar" style="height:350px">
<%
set rs=server.CreateObject("Adodb.Recordset")
action=cint(request.QueryString("action"))
if action<>1 then
tmid=trim(request.Form("tmid"))             '学期编号
did=trim(request.Form("did"))             '班级编号
noorname=trim(request.Form("noorname"))             '课程号或课程名
else 
tmid=trim(request.QueryString("tmid"))
did=trim(request.QueryString("did"))
noorname=trim(request.QueryString("noorname"))
end if
if noorname="请输入课程号或课程名" then
   noorname=""
end if
if tmid="" and did="" then
    sql="select * from t_course,t_dept,t_term,t_arrange where t_course.c_no=t_arrange.c_no and t_dept.d_no=t_arrange.d_no and t_term.tm_id=t_arrange.tm_id and (c_name like '%"&noorname&"%' or t_arrange.c_no='"&noorname&"') order by t_arrange.tm_id asc"
 else if tmid="" then
      sql="select * from t_course,t_dept,t_term,t_arrange where t_course.c_no=t_arrange.c_no and t_dept.d_no=t_arrange.d_no and t_term.tm_id=t_arrange.tm_id and (c_name like '%"&noorname&"%' or t_arrange.c_no='"&noorname&"') and t_arrange.d_no='"&did&"' order by t_arrange.tm_id asc"
      else if did="" then
	      sql="select * from t_course,t_dept,t_term,t_arrange where t_course.c_no=t_arrange.c_no and t_dept.d_no=t_arrange.d_no and t_term.tm_id=t_arrange.tm_id and (c_name like '%"&noorname&"%' or t_arrange.c_no='"&noorname&"')and  t_arrange.tm_id="&tmid&" order by t_arrange.tm_id asc"
		  else if tmid<>"" and did<>"" then
		      sql="select * from t_course,t_dept,t_term,t_arrange where t_course.c_no=t_arrange.c_no and t_dept.d_no=t_arrange.d_no and t_term.tm_id=t_arrange.tm_id and (c_name like '%"&noorname&"%' or t_arrange.c_no='"&noorname&"')  and t_arrange.d_no='"&did&"' and t_arrange.tm_id="&tmid&" order by t_arrange.tm_id asc"
               end if
		end if
	end if
end if
rs.open sql,conn,3,1
if rs.eof then
response.Write("目前没有课程记录!")
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
            <td width="10%"height="30"><div align="center"><strong><font color="#3366FF">课程号</font></strong></div></td>
		    <td width="15%" height="30"><div align="center"><font color="#3366FF"><b>课程名</b></font></div></td>
			<td width="15%" height="30"><div align="center"><font color="#3366FF"><b>学期</b></font></div></td>
		    <td width="15%" height="30"><div align="center"><font color="#3366FF"><b>院系</b></font></div></td>
			<td width="10%" height="30"><div align="center"><font color="#3366FF"><b>教室编号</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>星期</b></font></div></td>
			<td width="5%" height="30"><div align="center"><font color="#3366FF"><b>第几节</b></font></div></td>
		    <td width="10%" height="30"><div align="center"><font color="#3366FF"><b>上课周</b></font></div></td>
			 <td width="5%" height="30"
			 <%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <% end if %>    
			 ><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		    <td width="5%" height="30"
			<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <% end if %>    
			><div align="center"><strong><font color="#3366FF">操作</font></strong></div></td>
		  </tr>
<%'输出当前页面记录
for i=0 to rs.pagesize-1
if rs("ar_week")=1 then
   fweek="一"
  else if rs("ar_week")=2 then
     fweek="二"
	 else if rs("ar_week")=3 then
	   fweek="三"
	   else if rs("ar_week")=4 then
	     fweek="四"
		 else if rs("ar_week")=5 then
		   fweek="五"
		    else if rs("ar_week")=6 then
			 fweek="六"
			  else if rs("ar_week")=7 then
			   fweek="七"
			   end if
			 end if
			end if
		 end if
		end if
	end if
end if
%>
<tr height="30" >

		    <td><div align="center"><%=rs("t_arrange.c_no")%></div></td>
			<td><div align="center"><%=rs("c_name")%></div></td>
		    <td><div align="center"><%=rs("tm_term")%></div></td>
		    <td><div align="center"><%=rs("d_name")%></div></td>
			<td><div align="center"><%=rs("cr_no")%></div></td>
			<td><div align="center">星期<%=fweek%></div></td>
			<td><div align="center">第<%=rs("st_no")%>节</div></td>
			<td><div align="center"><%=rs("ar_weeks")%></div></td>
		    <td
			<%
			 if session("authority")>2 then
			 %>
		     style="display:none"
			  <% end if %>    
			><div align="center"><a href="arrange_information_edit.asp?c_id=<%=rs("t_arrange.c_no")%>&d_id=<%=rs("t_arrange.d_no")%>&ar_id=<%=rs("ar_week")%>&tmid=<%=rs("t_arrange.tm_id")%>&cr_id=<%=rs("cr_no")%>" target="in">修改</a></div></td>
		    <td
			<%
			 if(session("authority")<>1) then
			 %>
			  style="display:none"
			  <% end if %>    
			><div align="center"><a href="arrange_information_del.asp?c_id=<%=rs("t_arrange.c_no")%>&d_id=<%=rs("t_arrange.d_no")%>&ar_id=<%=rs("ar_week")%>&tmid=<%=rs("t_arrange.tm_id")%>&cr_id=<%=rs("cr_no")%>" target="in">删除</a></div></td>
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
response.Write("<a href='arrange_information_bottom.asp?page=1&tmid="&tmid&"&did="&did&"&noorname="&noorname&"&action=1'>首页</a>&nbsp;<a href='arrange_information_bottom.asp?tmid="&tmid&"&did="&did&"&noorname="&noorname&"&page="&nowpage-1&"&action=1'>上一页</a>&nbsp;")
end if
%>
第
<%
for i=1 to rs.pagecount
if i=nowpage then
response.Write("<span>"&i&"</span>&nbsp;")
else
response.Write("<a href='arrange_information_bottom.asp?tmid="&tmid&"&did="&did&"&noorname="&noorname&"&page="&i&"&action=1'>"&i&"</a>&nbsp;")
end if
next
%>
页
<%
if nowpage<>rs.pagecount then
response.Write("<a href='arrange_information_bottom.asp?tmid="&tmid&"&did="&did&"&noorname="&noorname&"&page="&nowpage+1&"&action=1'>下一页</a>&nbsp;<a href=arrange_information_bottom.asp?tmid="&tmid&"&did="&did&"&noorname="&noorname&"&page="&rs.pagecount&"&action=1'>尾页</a>")
end if
end if
rs.close
set conn=nothing
%>
</div>
</body>
</html>
