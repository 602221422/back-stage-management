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
<title>图书添加</title>
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
<%set rs=server.CreateObject("Adodb.Recordset")
sql="select * from t_club "
rs.open sql,conn,3,1
%>
<br>
<form name="theForm"  action="t_book_add_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>添加图书</h2></td>
 </tr>
  <tr height="44">
  <td align="right" width="40%">书名：</td>
  <td align="left" width="60%"><input type="text" name="bname"    /></td>
  </tr>
  <tr height="44">
  <td align="right">作者：</td>
  <td align="left"><input name="aname" type="text"  /></td>
  </tr>
  <tr height="44">
      <td align="right">出版社：</td>
	  <td align="left"><input type="text" name="bpress"   /></td>
  </tr>
  <tr height="44">
      <td align="right">出版日期：</td>
	  <td align="left"><input type="text" name="bdate"   /></td>
  </tr>
  <tr height="44">
      <td align="right">简介：</td>
	  <td align="left"><textarea name="bbrief" cols="40" rows="4"> </textarea></td>
  </tr>
  <tr height="44">
      <td align="right">图片：</td>
	  <td align="left">请在图书表表修改选项里边进行添加。</td>
  </tr>
  <tr height="44">
      <td  align="center" colspan="2"><input name="Submit" type="submit" value="确定提交"></td>
    </tr>
  </table>
</form>



</body>
</html>
