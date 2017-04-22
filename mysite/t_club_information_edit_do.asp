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
<head>
<!--#include file="conn.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学生信息编辑处理</title>
</head>

<body>
<%
id=trim(request.Form("cno"))
sno=trim(request.Form("sno"))
if sno="" then
   response.Write"<script>alert('学号不能为空哦!');history.back(-1)</script>"
else
   set rs1=server.CreateObject("Adodb.Recordset")
   sql="select * from t_student where s_no='"&sno&"'"
   rs1.open sql,conn,3,1
   if rs1.eof or rs1.bof then
      rs1.close
	  set rs1=nothing
      response.Write"<script>alert('该学号不存在哦!');history.back(-1)</script>"
   else 
      rs1.close
      set rs1=nothing
        set rs=server.CreateObject("Adodb.Recordset")
        sql="select * from t_club where cl_no='"&id&"'"
        rs.open sql,conn,1,2
        rs("cl_no")=trim(request.Form("cno"))
        rs("cl_name")=trim(request.Form("cname"))
        rs("cl_date")=trim(request.Form("cdate"))
        rs("s_no")=trim(request.Form("sno"))
        '  rs("cl_picture")=trim(request.Form("cpicture"))
        rs("cl_brief")=trim(request.Form("cbrief"))
        rs.update
        response.write"<script>alert('修改成功！');location.href='t_club_information.asp'</script>"
        rs.close
        set rs=nothing
	end if
end if 
conn.close
set conn=nothing
%>
  </div>
</div>
</html>
