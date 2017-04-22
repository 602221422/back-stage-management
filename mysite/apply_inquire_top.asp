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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>

<body>
<br>
<form id="theForm" name="theForm" method="post" action="apply_inquire_bottom.asp" target="apply_bottom">
  科目：
  	  <label>
	      <%
            set rs2=server.CreateObject("Adodb.Recordset")
            sql="select *from t_exam order by ex_id asc"
            rs2.open sql,conn,3,1
         %>
	   <select name="exid" id="exid" >
	     <option value="">请选择</option>
         <%'输出当前页面记录
          for i=1 to rs2.recordcount
         %>
          <option value=" <%=rs2("ex_id")%>"><%=rs2("ex_name")%></option>
         <%
         rs2.movenext
         if rs2.eof then exit for
        next
		rs2.close
        %>
      </select>
  </label>

      <label>
      <input type="submit" name="Submit" value="提交" />
      </label>
</form>
<br>
<hr width="100%%" size="3" color="#0099FF" />
<p>&nbsp;</p>
</body>
</html>
