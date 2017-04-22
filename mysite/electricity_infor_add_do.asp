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
<title>添加班级提交</title>
</head>

<body>
<%
eno=trim(request.Form("eno"))             '寝室编号
ebalance=trim(request.Form("ebalance"))           '电费余额
if (eno="" or ebalance="")then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
	 set rs1=server.CreateObject("Adodb.Recordset")
	 sql="select *from t_electricity where e_no='"&eno&"'"
     rs1.open sql,conn,1,2
	 if rs1.eof and rs1.bof then
	    rs1.addnew
		rs1("e_no")=eno
        rs1("e_balance")=ebalance
        rs1.update
        response.write"<script>alert('添加成功！');location.href='electricity_infor_add.asp'</script>"
	    rs1.close
	    set rs1=nothing
	 else
	 	  response.write"<script>alert('该寝室编号已经存在！');history.back(-1)</script>"
          rs1.close
          set rs1=nothing
	 end if
conn.close
set conn=nothing
end if
eno=""
ebalance=""
%>
</body>
</html>
