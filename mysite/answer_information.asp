<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查看回答</title>
<link href="style/style1.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
*{border:1;margin:1;border:1;list-style:none;}
UL {LIST-STYLE-TYPE: none;padding:0px;margin:0px;}
LI {FONT-SIZE: larger; COLOR: #333; LINE-HEIGHT: 1.5em; FONT-FAMILY: "微软雅黑", Arial, Verdana;}
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
sql="select * from t_question where q_no="&request("id")
rs.open sql,conn,3,1
%>
    <h3>问题：<%=rs("q_name")%>(<%=rs("q_date")%>)</h3>
  </div>
  <div id="tab2">
<%
rs.close
set rs=nothing
%>
  <div style="height:400px">
<%
set rs=server.CreateObject("Adodb.Recordset")
sql="select *from t_answer where q_no="&request("id")
rs.open sql,conn,3,1
if not(rs.eof) then
%>
回答：(<%=rs.recordcount%>条)<br>
<%
  for i=1 to rs.recordcount 
%>
  第<%=i%>条:<%=rs("a_content")%>&nbsp;&nbsp;<%=rs("a_date")%><a href="answer_information_del.asp?qid=<%=rs("q_no")%>&aid=<%=rs("a_id")%>">[删除]</a><br><br>
<%
  rs.movenext
  if rs.eof then exit for
  next
else
%>
回答：(0条)<br>
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
<input type="button" class="btns" onclick="location='question_information.asp'"   onMouseOver="this.style.backgroundPosition='left -40px'" onMouseOut="this.style.backgroundPosition='left top'"  value="返回"  />
</div>
</body>
</html>
