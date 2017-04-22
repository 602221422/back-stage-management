<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>3 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻查看</title>
<link href="style/style1.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
*{border:1;margin:1;border:1;list-style:none;}
UL {LIST-STYLE-TYPE: none;padding:0px;margin:0px;}
LI {FONT-SIZE: 12px; COLOR: #333; LINE-HEIGHT: 1.5em; FONT-FAMILY: "微软雅黑", Arial, Verdana;}
.hide {DISPLAY: none}
</style>

<style>
img { border:0px; vertical-align:middle; padding:0px; margin:0px; }
input, button { font-family:"Arial", "Tahoma", "微软雅黑", "雅黑"; border:0; vertical-align:middle; margin:8px; line-height:18px; font-size:14px }
.btns { width:100px; height:30px; background:url("images/bg11.jpg") no-repeat left top; color:#FFF; }
</style>

</head>

<body>
<div id="tab1">
  <div id="tab_top">
<%
set rs=server.CreateObject("Adodb.Recordset")
sql="select * from t_new,t_new_ct where t_new.ct_id=t_new_ct.ct_id and nid="&request("id")
rs.open sql,conn,3,1
%>
    <h3><%=rs("title")%></h3>
  </div>
  <div id="tab2">
  <div align="center">来源：<%=rs("source")%></div>
  <div align="right">发布时间：<%=rs("ptime")%></div>
  <div style="height:400px">
  <%=rs("body")%><br>
  <%
rs.close
set rs=nothing
%>
<%
set rs=server.CreateObject("Adodb.Recordset")
sql="select *from t_student,t_comment where t_student.s_no=t_comment.region and nid="&request("id")
rs.open sql,conn,3,1
if not(rs.eof) then
%>
评论：(<%=rs.recordcount%>条)<br>
<%
  for i=1 to rs.recordcount 
%>
  第<%=i%>条:<%=rs("content")%>&nbsp;&nbsp;&nbsp;&nbsp;<%=rs("s_name")%>&nbsp;&nbsp;<%=rs("ptime")%><a href="comment_information_del.asp?nid=<%=rs("nid")%>&cid=<%=rs("cid")%>">[删除]</a><br><br>
<%
  rs.movenext
  if rs.eof then exit for
  next
else
%>
评论：(0条)<br>
<%
end if
rs.close
set rs=nothing
conn.close
set conn=nothing

%>
  </div>
</div>
<div align="center">
<input type="button" class="btns" onclick="location='new_information.asp'"   onMouseOver="this.style.backgroundPosition='left -40px'" onMouseOut="this.style.backgroundPosition='left top'"  value="返回"  />
</div>
</body>
</html>
