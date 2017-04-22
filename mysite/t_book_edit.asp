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
<title>图书信息编辑</title>
<style type="text/css">
.style3{
   width: 550px;
   height: 100%;
   margin: 0px auto;
   margin-bottom:20px;
   border:1px solid #BBE1F1;
   background-color: #EEFAFF;
   background-image:url(images/dd1.jpg);
   border:inset
}
</style>
<link href="style/style8.css" rel="stylesheet" type="text/css">
<SCRIPT src="javascript/AjaxImg.js" type=text/javascript></SCRIPT>
<script language="JavaScript">
var flag=false;
function DrawImage(ImgD){
   var image=new Image();
   image.src=ImgD.src;
   if(image.width>0 && image.height>0){
    flag=true;
    if(image.width/image.height>= 200/160){
     if(image.width>200){
     ImgD.width=200;
     ImgD.height=(image.height*200)/image.width;
     }else{
     ImgD.width=image.width;
     ImgD.height=image.height;
     }
     }
    else{
     if(image.height>160){
     ImgD.height=160;
     ImgD.width=(image.width*160)/image.height;
     }else{
     ImgD.width=image.width;
     ImgD.height=image.height;
     }
     }
    }

  }
</script>
</head>
<body>
<%set rs=server.CreateObject("Adodb.Recordset")
id=request.QueryString("id")
sql="select * from t_books where b_no="&id
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	response.write "没有符合条件的记录"
end if%>
<br>
<form name="theForm"  action="t_book_edit_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48">
   <td colspan="2" align="center" ><h2>修改图书信息</h2></td>
 </tr>
 <tr height="44">
   <td align="right" width="40%">图书编号：</td>
   <td align="left" width="60%"><input type="text" name="bno"  readonly="readonly"  value=<%=rs("b_no")%> /></td>
 </tr>
 <tr height="44">
   <td align="right">书名：</td>
   <td align="left"><input type="text" name="bname"   value=<%=rs("b_name")%> /></td>
 </tr>
 <tr height="44">
   <td align="right">作者：</td>
   <td align="left"><input name="aname" type="text"  value=<%=rs("b_author")%> /></td>
  </tr>
  <tr height="44">
   <td align="right">出版社：</td>
   <td align="left"><input type="text" name="bpress"  value=<%=rs("b_press")%> /></td>
  </tr>
  <tr height="44">
   <td align="right">出版日期：</td>
   <td align="left"><input type="text" name="bdate"  value=<%=rs("b_pb_date")%> /></td>
  </tr>
  <tr height="44">
    <td align="right">简介：</td>
	<td align="left"><textarea name="bbrief" cols="40" rows="5"><%=rs("b_brief")%></textarea></td>
  </tr>
  <tr height="44">
    <td align="right">图片：</td>
	<td align="left"><img src="<%=rs("b_picture")%>"></td>
  </tr>
  <tr height="44">
      <td align="center" colspan="2"><input name="Submit" type="submit" value="确定提交"></td>
  </tr>
  </table>
</form>

<form name="form1" method="post" action="" onSubmit="return CheckForm()" enctype="multipart/form-data">
	<div align="center"><span class="STYLE2">【上传图片】</span>　　　

	<input type=file name="file1">
    <input type=submit name="submit" value=" 提 交 ">
    </div>
</form>

<!--#include FILE="Boss123.Net.inc"--> 
<%
set upload=new upload_5xsoft
set file=upload.file("file1")
kzm=right(file.filename,4)
name="img/" & year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&kzm

   if file.fileSize>0 Then
    If kzm<>".gif" And kzm<>".jpg" Then
    response.Write("<script language=javascript>alert('只支持“.gif”和“.jpg”文件类型的图片上传！');history.go(-1)</script>")
	else		
		file.SaveAs Server.mappath(name)
			set rs=server.createobject("adodb.recordset")
			sql="select * from t_books where b_no="&id
			rs.open sql,conn,1,3
			rs("b_picture")=name
			rs.update
			rs.close
			set rs=nothing
			conn.close
			set rs=Nothing
response.write"<script>alert('上传成功！');</script>"

	End If
end If

set file=nothing
set upload=Nothing
%>




</body>
</html>
