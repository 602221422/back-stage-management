<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="conn.asp"-->
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>3 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>搜索</title>
</head>
<body>
<div align="right" style="height:35px">
<br>
<form id="theForm" name="theForm" method="post" action="stu_information_bottom.asp" target="stu_bottom">
  班级：
  	  <label>
	      <%
            set rs2=server.CreateObject("Adodb.Recordset")
            sql="select cs_no,cs_name from t_class order by cs_no asc"
            rs2.open sql,conn,3,1
         %>
	   <select name="csid" id="csid" >
	     <option value="">请选择</option>
         <%'输出当前页面记录
          for i=1 to rs2.recordcount
         %>
          <option value=" <%=rs2("cs_no")%>"><%=rs2("cs_name")%></option>
         <%
         rs2.movenext
         if rs2.eof then exit for
        next
		rs2.close
		set rs2=nothing
        %>
      </select>
  </label>
<label>
<input name="noorname" class="inputsearch" value="请输入学号或姓名" type="text" onclick="this.value=''"  onblur="if(this.value=='')this.value='请输入学号或姓名';"/>
</label>
<label>
<input type="submit" name="Submit" value="提交" />
</label>
</form>
<br>
<hr width="100%%" size="3" color="#0099FF" />
</div>
<p>&nbsp;</p>
</body>
</html>
