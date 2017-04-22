
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
<link href="style/style7.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%
Flag="无"
if session("authority")=1 then
   Flag="一级【能添加、修改、删除、查看】"
 else if session("authority")=2 then
       Flag="二级【能修改、删除、查看】"
   else if session("authority")=3 then
         Flag="三级【能查看】"
	 else if session("authority")=4 then
	       Flag="四级【只能进社团信息】"
		  end if
		end if
	end if
end if 
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="86" class="header_bg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
       <td height="86" class="header_bg2"><%=session("guess")%>(权限：<%=Flag%>)</td>
      </tr>
    </table>
   </td>
  </tr>
  </tr>
</table>
</body>
</html>
