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
<title>课表信息删除</title>
</head>
<body>
<%
set rs=server.CreateObject("Adodb.Recordset")
did=request.QueryString("d_id") '系编号
cid=request.QueryString("c_id") '课程编号
arid=request.QueryString("ar_id") '上课时间编号
tmid=request.QueryString("tmid") '学期编号
crid=request.QueryString("cr_id") '教室编号
sql="select * from t_arrange where d_no='"&did&"' and c_no='"&cid&"' and cr_no='"&crid&"' and tm_id="&tmid&" and ar_week="&arid
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	response.write"<script>alert('没有符合条件的记录！');location.href='arrange_information.asp'</script>"
else
sql = "delete from t_arrange where d_no='"&did&"' and c_no='"&cid&"' and cr_no='"&crid&"' and tm_id="&tmid&" and ar_week="&arid
	conn.execute(sql)
	conn.close
set conn=nothing
response.write"<script>alert('删除成功！');location.href='arrange_information.asp'</script>"
end if
%>
</body>
</html>
