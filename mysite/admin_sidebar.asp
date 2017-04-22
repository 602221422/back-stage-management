<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess") = ""or session("flag")<>"admin" then
  response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
</head>

<body>
<script language="JavaScript">
function setSHRow(iRow)
{
if(iRow.style.display != "none")
 {
   iRow.style.display="none";
 }
 else
 {
   iRow.style.display="block"
 }
}
</script>

<table width="184" border="0" cellpadding="0" cellspacing="0" class="sidebar_table" id="mytable">
<tr>
  <td>
   <ul >
     <li class="sidebar_li_0"><a href="admin_index.asp" target="_parent">后台首页</a></li>
     <li class="sidebar_li_2"><a href="admin_quit.asp" target="_parent" >退出后台</a></li>
   </ul>
  </td>
</tr>
<tr id="f1" >
  <td height="35" class="sidebar_nav" 
	<%if session("authority")=1 then%>
	  onclick="setSHRow(s1);"
	<%end if%>
  >信息录入</td>
</tr>
<tr id="s1" style="display:none">
 <td>
   <ul>
	 <li class="sidebar_li_1"><a href="stu_infor_add.asp" target="in">添加学生</a></li>
     <li class="sidebar_li_1"><a href="grade_infor_add.asp" target="in">录入成绩</a></li>
     <li class="sidebar_li_1"><a href="course_infor_add.asp" target="in">录入课程</a></li>
     <li class="sidebar_li_1"><a href="arrange_infor_add.asp" target="in">录入课表</a></li>
     <li class="sidebar_li_1"><a href="classroom_infor_add.asp" target="in">添加教室</a></li>
     <li class="sidebar_li_1"><a href="dept_infor_add.asp" target="in">添加系</a></li>
     <li class="sidebar_li_1"><a href="class_infor_add.asp" target="in">添加班级</a></li>	  
	 <li class="sidebar_li_1"><a href="term_infor_add.asp" target="in">添加学期</a></li>
 	 <li class="sidebar_li_1"><a href="t_club_information_add.asp" target="in">添加社团</a></li>
	 <li class="sidebar_li_1"><a href="new_ct_infor_add.asp" target="in">添加新闻类别</a></li>
   </ul>
 </td>
</tr>
<tr id="f2">
 <td height="35" class="sidebar_nav"
   <%if ((session("authority")>=1) and (session("authority")<=3)) then%>
    onclick="setSHRow(s2);"
   <%end if%>
 >信息管理</td>
</tr>
<tr id="s2" style="display:none">
 <td>
   <ul>
     <li class="sidebar_li_0"><a href="stu_information.asp" target="in">学生信息</a></li>
	 <li class="sidebar_li_0"><a href="course_information.asp" target="in">课程信息</a></li>
     <li class="sidebar_li_0"><a href="term_information.asp" target="in">学期信息</a></li>
	 <li class="sidebar_li_0"><a href="grade_information.asp" target="in">成绩管理</a></li>
     <li class="sidebar_li_0"><a href="classroom_information.asp" target="in">教室管理</a></li>
	 <li class="sidebar_li_0"><a href="arrange_information.asp" target="in">课表管理</a></li>
	 <li class="sidebar_li_0"><a href="class_information.asp" target="in">班级管理</a></li>
	 <li class="sidebar_li_0"><a href="dept_information.asp" target="in">系管理</a></li>	 
	 <li class="sidebar_li_0"><a href="manager_information.asp" target="in">管理员信息</a></li>
	 <li class="sidebar_li_0"><a href="t_club_information.asp" target="in">社团管理</a></li>
	 <li class="sidebar_li_0"><a href="electricity_information.asp" target="in">电费管理</a></li>
     <li class="sidebar_li_0"><a href="new_information.asp" target="in">工大新闻</a></li>
	 <li class="sidebar_li_0"><a href="found_lost_information.asp" target="in">寻物招领</a></li>
     <li class="sidebar_li_0"><a href="question_information.asp" target="in">提问管理</a></li>
     <li class="sidebar_li_0"><a href="t_book.asp" target="in">图书管理</a></li>
	 <li class="sidebar_li_0"><a href="exam_information.asp" target="in">等级考试项目</a></li>
   </ul>
 </td>
</tr>
<tr id="f3">
  <td height="35" class="sidebar_nav"
    <%if ((session("authority")>=1) and (session("authority")<=3)) then%>
	 onclick="setSHRow(s3);"
	<%end if%>
  >信息查询</td>
</tr>  
<tr id="s3" style="display:none"> 
  <td>
    <ul>
     <li class="sidebar_li_1"><a href="grade_inquire.asp" target="in">成绩查询</a></li>
     <li class="sidebar_li_1"><a href="arrange_inquire.asp" target="in">课表查询</a></li>
     <li class="sidebar_li_1"><a href="apply_inquire.asp" target="in">计算机报名查询</a></li>   
    </ul>    
  </td>
</tr>
<tr id="f4">
  <td height="35" class="sidebar_nav" 
   <%if ((session("authority")=1) or (session("authority")=4)) then%>
	  onclick="setSHRow(s4);"
   <%end if%>
  >社团信息</td>
</tr>  
<tr id="s4" style="display:none"> 
  <td>
    <ul>
     <li class="sidebar_li_0"><a href="t_club_member.asp" target="in">会员信息</a></li>
     <li class="sidebar_li_0"><a href="t_club_activity.asp" target="in">社团活动</a></li>
     <li class="sidebar_li_0"><a href="t_club_message.asp" target="in">聊天信息</a></li>   
    </ul>    
  </td>
</tr>
</table>
</body>
</html>
