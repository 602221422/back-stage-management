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
<title>课表信息修改提交</title>
</head>
<body>
<%
crno=trim(request.Form("crno"))
arweeks=trim(request.Form("arweeks"))
if (crno="" or arweeks="")then
  response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
  set rs1=server.CreateObject("Adodb.Recordset")
  sql="select *from t_classroom where cr_no='"&crno&"'"
  rs1.open sql,conn,3,1
  if rs1.eof and rs1.bof then
    response.Write"<script>alert('该教室编号不存在！');history.back(-1)</script>"
	rs1.close
	set rs1=nothing
  else
    rs1.close
    set rs1=nothing
    cno=trim(request.Form("cno"))
    dno=request.QueryString("d_id")
	arweek=request.QueryString("ar_id")
	tmid=request.QueryString("tmid")
    crno=trim(request.Form("crno"))
    set rs=server.CreateObject("Adodb.Recordset")
    sql="select * from t_arrange where c_no='"&cno&"' and d_no='"&dno&"' and ar_week="&arweek&" and cr_no='"&crno&"'and tm_id="&tmid
    rs.open sql,conn,1,2
    rs("cr_no")=crno
    rs("ar_weeks")=arweeks
    rs("st_no")=trim(request.Form("stno"))
    rs.update
    response.write"<script>alert('修改成功！');location.href='arrange_information.asp'</script>"
    rs.close
    set rs=nothing
    conn.close
    set conn=nothing
	cno=""
	csno=""
	arweek=""
  end if
end if
crno=""
arweeks=""
%>
</body>
</html>
