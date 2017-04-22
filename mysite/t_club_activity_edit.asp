<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")=1 or session("authority")=4 then
    else
	response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>社团活动编辑</title>
<style type="text/css">
.style3{
width: 550px;
height: 100%;
margin: 0px auto;
margin-bottom:20px;
border:1px solid #BBE1F1;
background-color: #EEFAFF;
}
</style>
<script type="text/javascript" src="SimpleTextEditor.js"></script>
<link rel="stylesheet" type="text/css" href="SimpleTextEditor.css">

</head>
<body>
<%set rs=server.CreateObject("Adodb.Recordset")
id=request.QueryString("id")
sql="select * from t_new,t_club where t_new.source=t_club.cl_name and nid="&id
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	rs.close
	set rs=nothing
	response.write "没有符合条件的记录"
else
%>
<br>
<form name="theForm"  action="t_club_activity_edit_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
<tr height="48px">
 <td colspan="2" align="center" ><h2>修改社团活动</h2></td>
</tr>
<tr height="48px">
 <td >
 <input type="hidden" name="id"  readonly="readonly" value=<%=rs("nid")%> /></td>
</tr>
<tr height="44px">
 <td >社团名称：
 <input type="text" name="cno"  readonly="readonly" value=<%=rs("cl_name")%> /></td>
</tr>
<tr height="44px">
 <td>发布时间：
 <input name="ctime" type="text" value=<%=rs("ptime")%> readonly="readonly" /></td>
</tr>
<tr height="44">
 <td >活动内容：
 <textarea name="body" id="body" cols="40" rows="10"><%=rs("body")%> </textarea>
</tr>
<script type="text/javascript">
        var ste = new SimpleTextEditor("body", "ste");
        ste.init();
        </script>
<tr height="44px">
 <td align="center" colspan="2"><input name="Submit" type="submit" value="确定提交" onclick="ste.submit();"></td>
</tr>
</table>
</form>
<%
rs.close
set rs=nothing
end if
conn.close
set conn=nothing
%>

</body>
</html>
