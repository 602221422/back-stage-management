<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if session("guess")= "" or session("flag")<>"admin"then
	response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
 else if session("authority")>2 then
    response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
    end if
end if
%>
<!--#include file="conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>发布新闻</title>
<style type="text/css">
.style3{
   width: 550px;
   height: 100%;
   margin: 0px auto;
   margin-bottom:20px;
   border:1px solid #BBE1F1;
}
</style>

<script type="text/javascript" src="SimpleTextEditor.js"></script>
<link rel="stylesheet" type="text/css" href="SimpleTextEditor.css">
</head>
<body>
<%set rs=server.CreateObject("Adodb.Recordset")
sql="select * from t_club "
rs.open sql,conn,3,1
%>
<br>
<form name="theForm"  action="new_infor_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>发布新闻</h2></td>
 </tr>
  <tr height="44">
    <td align="left" >题 &nbsp;&nbsp; 目：<input type="text" name="title"/><font color="#FF0000">*</font></td>
  </tr>
  <tr height="44">
  <td align="left">来&nbsp;&nbsp; 源：<input name="source" type="text"/><font color="#FF0000">*</font></td>
  </tr>
  <tr height="44">
	  <td align="left">新闻类别：
	  			  <label>
	      <%
            set rs2=server.CreateObject("Adodb.Recordset")
            sql="select *from t_new_ct where ct_name<>'寻物' and ct_name<>'招领' order by ct_id asc"
            rs2.open sql,conn,3,1
         %>
	   <select name="ctid" id="ctid" >
         <%'输出当前页面记录
          for i=0 to rs2.pagesize-1
         %>
          <option value=" <%=rs2("ct_id")%>"><%=rs2("ct_name")%></option>
         <%
         rs2.movenext
         if rs2.eof then exit for
        next
		rs2.close
        %>
         </select>
		 </label>

	  </td>
  </tr>
  <tr height="44">
	  <td align="left">发布时间：<input type="text" name="ptime" readonly="readonly" value="<%=year(now)&"-"&month(now)&"-"&day(now)%>"></td>
  </tr>
  <tr height="44">
	  <td align="left">内 &nbsp;&nbsp;&nbsp;容：<textarea name="body" id="body" cols="40" rows="10"> </textarea></td>
  </tr>
      
        <script type="text/javascript">
        var ste = new SimpleTextEditor("body", "ste");
        ste.init();
        </script>

  <tr height="44">
      <td  align="center" colspan="2"><input name="Submit" type="submit" value="确定提交" onclick="ste.submit();"></td>
    </tr>
  </table>
</form>
</body>
</html>