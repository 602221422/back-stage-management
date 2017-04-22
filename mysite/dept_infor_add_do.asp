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
<title>添加班级提交</title>
</head>

<body>
<%
did=trim(request.Form("dno"))             '班级编号
dname=trim(request.Form("dname"))           '班级名称
if (did="" or dname="")then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
  set rs2=server.CreateObject("Adodb.Recordset")
  sql="select d_no from t_dept where d_no='"&did&"'"
  rs2.open sql,conn,3,1
  if not(rs2.eof and rs2.bof) then
     response.write"<script>alert('该系编号已经存在！');history.back(-1)</script>"
	 rs2.close
     set rs2=nothing
  else
     rs2.close
     set rs2=nothing
	 set rs1=server.CreateObject("Adodb.Recordset")
	 sql="select *from t_dept where d_name='"&dname&"'"
     rs1.open sql,conn,1,2
	 if rs1.eof and rs1.bof then
	    rs1.addnew
		rs1("d_no")=did
		rs1("d_name")=dname
        rs1.update
        response.write"<script>alert('添加成功！');location.href='dept_infor_add.asp'</script>"
	    rs1.close
	    set rs1=nothing
	 else
	 	  response.write"<script>alert('该系名称已经存在！');history.back(-1)</script>"
          rs1.close
          set rs1=nothing
	 end if
  end if
end if
conn.close
set conn=nothing
csid=""
csname=""
dno=""
%>

</body>
</html>
