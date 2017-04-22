<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>2 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>课表信息修改</title>
<style type="text/css">
.style3{
width: 550px;
height: 410px;
margin: 0px auto;
margin-bottom:20px;
border:1px solid #BBE1F1;
background-color: #EEFAFF;
background-image:url(images/dd1.jpg);
border:inset
}
</style>
</head>
<body>
<%set rs=server.CreateObject("Adodb.Recordset")
cid=request.QueryString("c_id")
did=request.QueryString("d_id")
arid=request.QueryString("ar_id")
crid=request.QueryString("cr_id")
tmid=request.QueryString("tmid")
sql="select *from t_arrange,t_course,t_term,t_dept where t_arrange.c_no=t_course.c_no and t_term.tm_id=t_arrange.tm_id and t_arrange.d_no=t_dept.d_no and (t_arrange.d_no='"&did&"') and cr_no='"&crid&"' and t_arrange.tm_id="&tmid&" and t_arrange.c_no='"&cid&"' and ar_week="&arid
rs.open sql,conn,3,1
if rs.bof or rs.eof then
    rs.close
	set rs=nothing
	response.write "没有符合条件的记录"
else
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
<form name="theForm"  action="arrange_information_edit_do.asp?d_id=<%=rs("t_arrange.d_no")%>&ar_id=<%=rs("ar_week")%>&tmid=<%=rs("t_arrange.tm_id")%>" method="post" class="style3">
<table align="center" width="100%" border="0">
<tr height="40px">
 <td colspan="2" align="center" ><h2>修改课表信息</h2></td>
</tr>
<tr height="36px">
 <td align="right" width="40%">课程号：</td> 
 <td align="left" width="60%"> <input type="text" name="cno" readonly ="readonly" value=<%=rs("t_arrange.c_no")%> > </td>
</tr>
<tr height="36px">
 <td align="right">课程名：</td> 
 <td align="left"> <input type="text" name="cname" readonly ="readonly" value=<%=rs("c_name")%> > </td>
</tr>
<tr height="36px">
 <td align="right">学期：</td> 
 <td align="left"> <input type="text" name="tterm" readonly ="readonly" value=<%=rs("tm_term")%> > </td>
</tr>
<tr height="36px">
 <td align="right">所属系：</td> 
 <td align="left"><input type="text" name="csname" readonly ="readonly" value=<%=rs("d_name")%> ></td>
</tr>
<tr height="36px">
 <td align="right">星期：</td> 
 <td align="left"><input type="text" name="arweek" readonly ="readonly" value=星期<%=fweek%>></td>
</tr>
<tr height="36px">
 <td align="right">教室编号：</td> 
 <td align="left"><input type="text" name="crno" value=<%=rs("cr_no")%> ><font color="#FF0000">*</font></td>
</tr>
<tr height="36px">
 <td align="right">上课时间：</td>
 <td align="left">
	  <label>
	      <%
            set rs2=server.CreateObject("Adodb.Recordset")
            sql="select *from t_stime order by st_no asc"
            rs2.open sql,conn,3,1
         %>
	   <select name="stno" id="stno" >
         <%'输出当前页面记录
          for i=0 to rs2.pagesize-1
         %>
          <option value=" <%=rs2("st_no")%>">第<%=rs2("st_no")%>节</option>
         <%
         rs2.movenext
         if rs2.eof then exit for
        next
		rs2.close
        %>
         </select>
		 </label><font color="#FF0000">*</font>
  </td>
</tr>
<tr height="36px">
  <td align="right">上课周：</td> 
  <td align="left"><input type="text" name="arweeks" value=<%=rs("ar_weeks")%> /><font color="#FF0000">*</font></td>
</tr>
<tr height="36px">
  <td align="center" colspan="2"><input name="Submit" type="submit" value="确定提交" /></td>
</tr>
</table>
</form>
<%
rs.close
set rs=nothing
end if
conn.close
set conn=nothing
%>
</body>
</html>

