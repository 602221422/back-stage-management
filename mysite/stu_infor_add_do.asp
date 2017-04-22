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
<title>添加课表信息提交</title>
</head>

<body>
<%
sno=trim(request.Form("sno"))             '学号
if len(sno)<>9 then
    response.write"<script>alert('学号只能输入9位数字哦！');history.back(-1)</script>"
else
sname=trim(request.Form("sname"))           '姓名
spassword=trim(request.Form("spassword"))     '初始密码
ssex=trim(request.Form("ssex"))           '性别
sage=trim(request.Form("sage"))       '年龄
csid=trim(request.Form("csid"))       '班级编号
sphone=trim(request.Form("sphone"))       '联系电话
if (sno="" or sname="" or sage="" or csid="")then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else
  set rs=server.CreateObject("Adodb.Recordset")
  sql="select *from t_class where cs_no='"&csid&"'"
  rs.open sql,conn,3,1
  did=rs("d_no")     '所在系编号
  rs.close
  set rs=nothing
 
  set rs=server.CreateObject("Adodb.Recordset")
  sql="select *from t_student where s_no='"&sno&"'"
  rs.open sql,conn,1,2
  if rs.eof and rs.bof then
     rs.addnew
     rs("s_no")=sno
     rs("s_name")=sname
     rs("s_password")=spassword
     rs("s_sex")=ssex
     rs("s_age")=sage
     rs("d_no")=did
     rs("cs_no")=csid
	 rs("s_phone")=sphone
     rs.update
	 rs.close
     set rs=nothing
     response.write"<script>alert('添加成功！');location.href='stu_infor_add.asp'</script>"
  else
	 rs.close
     set rs=nothing
     response.write"<script>alert('该学号已存在！');history.back(-1)</script>"
  end if
end if
conn.close
set conn=nothing
sname=""          '姓名
spassword=""     '初始密码
ssex=""         '性别
sage=""      '年龄
did=""       '所在系编号
csid=""       '班级编号
sphone=""      '联系电话
end if
sno=""            '学号
%>
</body>
</html>
