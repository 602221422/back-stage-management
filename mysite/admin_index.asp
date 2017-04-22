
<%
	if session("guess") = ""or session("flag")<>"admin" then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
</head>
<frameset rows="86,*" framespacing="0" frameborder="no" border="0">
  <frame src="admin_header.asp" scrolling="no" noresize="noresize">
  <frameset cols="201,*">
    <frame src="admin_sidebar.asp"  >
    <frame src="admin_main.html" scrolling="yes" noresize="noresize" name="in">
  </frameset>
</frameset>
<noframes><body>
</body></noframes>
</html>
