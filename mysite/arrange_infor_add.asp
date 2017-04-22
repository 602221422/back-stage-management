<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>1 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>

<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>添加课表信息</title>
<style type="text/css">
.style3{
width: 550px;
height: 410px;
margin: 0px auto;
margin-bottom:20px;
border:1px solid #BBE1F1;
background-color: #EEFAFF;
background-image:url(images/dd1.jpg);
border:inset
}
</style>
</head>
<body>
<form name="theForm" action="arrange_infor_add_do.asp" method="post" class="style3" >
<table align="center" width="100%" border="0">
<tr height="48">
 <td colspan="2" align="center" ><h2>添加课表信息</h2></td>
</tr>
<tr height="44">
  <td align="right" width="40%">课程名称：</td>
  <td align="left" width="50%"><input type="text" name="cname"><font color="#FF0000">*</font></td>
</tr>
<tr height="44">
  <td align="right">教室编号：</td>
  <td align="left"><input name="crno" type="text"><font color="#FF0000">*</font></td>
</tr>
<tr height="44">
  <td align="right">学期：</td>
  <td align="left">
    <label>
      <%
        set rs2=server.CreateObject("Adodb.Recordset")
        sql="select tm_id,tm_term from t_term order by tm_id asc"
        rs2.open sql,conn,3,1
      %>
	  <select name="tmid" id="tmid" >
      <%'输出当前页面记录
        for i=1 to rs2.recordcount
      %>
      <option value=" <%=rs2("tm_id")%>"><%=rs2("tm_term")%></option>
      <%
       rs2.movenext
       if rs2.eof then exit for
       next
	   rs2.close
	   set rs2=nothing
      %>
      </select>
    </label><font color="#FF0000">*</font>
  </td>
</tr>
<tr height="44">
  <td align="right">院系：</td>
  <td align="left">
	<label>
	 <%
      set rs2=server.CreateObject("Adodb.Recordset")
      sql="select *from t_dept order by d_no asc"
      rs2.open sql,conn,3,1
     %>
	 <select name="did" id="did" >
     <%'输出当前页面记录
      for i=1 to rs2.recordcount
     %>
     <option value=" <%=rs2("d_no")%>"><%=rs2("d_name")%></option>
     <%
      rs2.movenext
      if rs2.eof then exit for
      next
	  rs2.close
	  set rs2=nothing
     %>
    </select>
   </label><font color="#FF0000">*</font>
 </td>
</tr height="44">
<tr>
  <td align="right">星期：</td>
  <td align="left">
  <select name="arweek" id="arweek">
   <option value="1">星期一</option>
   <option value="2">星期二</option>
   <option value="3">星期三</option>
   <option value="4">星期四</option>
   <option value="5">星期五</option>
   <option value="6">星期六</option>
   <option value="7">星期日</option>
  </select><font color="#FF0000">*</font>
  </td>
</tr>
<tr height="44">
  <td align="right">上课时间：</td>
  <td align="left">
    <label>
    <%
     set rs2=server.CreateObject("Adodb.Recordset")
     sql="select *from t_stime order by st_no asc"
     rs2.open sql,conn,3,1
    %>
	<select name="stno" id="stno" >
    <%'输出当前页面记录
     for i=1 to rs2.recordcount
    %>
     <option value=" <%=rs2("st_no")%>">第<%=rs2("st_no")%>节</option>
    <%
     rs2.movenext
     if rs2.eof then exit for
     next
	 rs2.close
	 set rs2=nothing
    %>
    </select>
   </label><font color="#FF0000">*</font>
 </td>
</tr>
<tr height="44">
 <td align="right">上课周数：</td>
 <td align="left"><input type="text" name="arweeks"><font color="#FF0000">*如（1-5周）</font></td>
</tr>
<tr height="44">
 <td colspan="2" align="center"><input name="Submit" type="submit" value="确定提交"></td>
</tr>
</table>
</form>
</body>
</html>
