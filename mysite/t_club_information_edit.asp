<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	if session("guess")= "" or session("flag")<>"admin"then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	 else if session("authority")>2 then
	     response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
     end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>社团信息编辑</title>
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
sql="select * from t_club where cl_no='"&id&"'"
rs.open sql,conn,3,1
if rs.bof or rs.eof then
	rs.close
	set rs=nothing
	response.write "没有符合条件的记录"
else
%>
<br>
<form name="theForm"  action="t_club_information_edit_do.asp" method="post" class="style3">
<table align="center" width="100%" border="0">
 <tr height="48px">
   <td colspan="2" align="center" ><h2>修改社团</h2></td>
 </tr>
 <tr height="44px">
   <td align="right">社团编号：</td>
   <td align="left"><input type="text" name="cno"  readonly="readonly" value=<%=rs("cl_no")%> /></td>
 </tr>
 <tr height="44px">
   <td align="right">社团名称：</td>
   <td align="left"><input name="cname" type="text" readonly="readonly" value=<%=rs("cl_name")%> /></td>
 </tr>
 <tr height="44px">
   <td align="right">社团创建日期：</td>
   <td align="left"><input type="text" name="cdate"  readonly="readonly" value=<%=rs("cl_date")%> /></td>
 </tr>
 <tr height="44px">
   <td align="right">会长学号：</td>
   <td align="left"><input type="text" name="sno" maxlength="9" onchange="if(/[^0-9]/g.test(this.value)){alert('学号只能输入9位数字哦！');this.value='';}" value=<%=rs("s_no")%> /></td>
 <tr height="44px">
   <td align="right">社团logo：</td>
   <td align="left"><img src="<%=rs("cl_picture")%>"></td>
 </tr>
 <tr height="44px">
    <td align="right">社团简介：</td>
	<td align="left"><textarea name="cbrief"> <%=rs("cl_brief")%></textarea></td>
 </tr>
 <tr height="44px">
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
<%
rs.close
set rs=nothing
end if
%>

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
			sql="select * from t_club where cl_no='"&id&"'"
			rs.open sql,conn,1,3
'			rs.addnew
			
			rs("cl_picture")=name
			rs.update
			rs.close
			set rs=nothing
			conn.close
			set rs=Nothing
'	Response.Redirect "t_club_information_edit_do.asp"	
response.write"<script>alert('上传成功！');</script>"

	End If
end If

set file=nothing
set upload=Nothing
%>
</body>
</html>
