<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>3 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>课表查询</title>
</head>

<frameset rows="80,*" frameborder="no" border="0" framespacing="0">
  <frame src="apply_inquire_top.asp" name="apply_top" scrolling="No" noresize="noresize" id="top" title="topFrame" />
  <frame src="apply_inquire_bottom.asp" name="apply_bottom" id="bottom" title="mainFrame" scrolling="yes"/>
</frameset>
<noframes><body>
</body>
</noframes></html>
