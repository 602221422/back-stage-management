<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>删除回答</title>
</head>
<body>
<%
set rs=server.CreateObject("Adodb.Recordset")
qid=request.QueryString("qid")
aid=request.QueryString("aid")
sql="select * from t_answer where a_id="&aid
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	response.write"<script>alert('没有符合条件的记录！');location.href='answer_information.asp?Id="&qid&"'</script>"
else
sql = "delete from t_answer where a_id="&aid
	conn.execute(sql)
	conn.close
set conn=nothing
response.write"<script>alert('删除成功！');location.href=f='answer_information.asp?Id="&qid&"'</script>"
end if
%>
</body>
</html>
