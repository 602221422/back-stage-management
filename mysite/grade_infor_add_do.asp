<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	if session("guess")= "" or session("flag")<>"admin"then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	 else if session("authority")>1 then
	     response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
     end if
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>成绩录入提交</title>
</head>

<body>
<%
sid=trim(request.Form("sno"))
cname=trim(request.Form("cname"))
cgrade=trim(request.Form("cgrade"))
cgpa=trim(request.Form("cgpa"))
tmid=request.Form("tmid")
if sid="" or cname="" or cgrade="" or cgpa="" tmid="" then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
  set rs2=server.CreateObject("Adodb.Recordset")
  sql="select s_no from t_student where s_no='"&sid&"'"
  rs2.open sql,conn,3,1
  if rs2.eof and rs2.bof then
     response.write"<script>alert('学号不存在！');history.back(-1)</script>"
	 rs2.close
     set rs2=nothing
  else
     set rs1=server.CreateObject("Adodb.Recordset")
	 sql="select c_no from t_course where c_name='"&cname&"'"
     rs1.open sql,conn,3,1
	 if rs1.eof and rs1.bof then
	    response.write"<script>alert('课程名不存在！');history.back(-1)</script>"
	 else
	   cno=rs1("c_no")
	   rs1.close
	   set rs1=nothing
       set rs=server.CreateObject("Adodb.Recordset")
       sql="select * from t_grade where s_no='"&sid&"' and c_no='"&cno&"'"
       rs.open sql,conn,1,2
	   if rs.eof and rs.bof then
	      rs.addnew
          rs("s_no")=trim(request.Form("sno"))
          rs("c_no")=cno
          rs("tm_id")=request.Form("tmid")
          rs("c_grade")=trim(request.Form("cgrade"))
          rs("c_gpa")=trim(request.Form("cgpa"))
          rs.update
          response.write"<script>alert('添加成功！');location.href='grade_infor_add.asp'</script>"
          rs.close
          set rs=nothing
          conn.close
          set conn=nothing
	    else
		  response.write"<script>alert('该成绩已经存在！');history.back(-1)</script>"
		end if
	 end if
  end if
end if
conn.close
set conn=nothing
%>
</body>
</html>
