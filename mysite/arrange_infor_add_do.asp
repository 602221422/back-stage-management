<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	if session("guess")= "" or session("flag")<>"admin"then
		response.write"<script>alert('未登录，请先登录！');location.href='index.html'</script>"
	 else if session("authority")>1 then
	     response.write"<script>alert('权限不够！');location.href='admin_index.asp'</script>"
     end if
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加课表信息提交</title>
</head>

<body>
<%
cname=trim(request.Form("cname"))             '课程名称
crid=trim(request.Form("crno"))           '教室编号
arweeks=trim(request.Form("arweeks"))     '上课周
did=trim(request.Form("did"))           '系编号
arweek=trim(request.Form("arweek"))       '星期
tmid=trim(request.Form("tmid"))  '星期编号
if (cname="" or crid="" or arweeks="" or did="" or tmid="")then
    response.write"<script>alert('数据不完整！');history.back(-1)</script>"
else 
  set rs2=server.CreateObject("Adodb.Recordset")
  sql="select c_no from t_course where c_name='"&cname&"'"
  rs2.open sql,conn,3,1
  if rs2.eof and rs2.bof then
     response.write"<script>alert('该课程名称不存在！');history.back(-1)</script>"
	 rs2.close
     set rs2=nothing
  else
     cid=rs2("c_no")
	 rs2.close
     set rs2=nothing
	 set rs1=server.CreateObject("Adodb.Recordset")
	 sql="select cr_no from t_classroom where cr_no='"&crid&"'"
     rs1.open sql,conn,3,1
	 if rs1.eof and rs1.bof then
	    response.write"<script>alert('该教室编号不存在！');history.back(-1)</script>"
	    rs1.close
	    set rs1=nothing
	 else
	   rs1.close
	   set rs1=nothing
       set rs=server.CreateObject("Adodb.Recordset")
	   sql="select *from t_arrange where c_no='"&cid&"' and d_no='"&did&"' and ar_week="&arweek&" and cr_no='"&crid&"'"
       rs.open sql,conn,1,2
	   if rs.eof and rs.bof then
	      rs.addnew
          rs("c_no")=cid
          rs("d_no")=did
          rs("ar_week")=arweek
          rs("cr_no")=crid
          rs("tm_id")=trim(request.Form("tmid"))
		  rs("d_no")=did
		  rs("ar_weeks")=arweeks
		  rs("st_no")=trim(request.Form("stno"))
          rs.update
          response.write"<script>alert('添加成功！');location.href='arrange_infor_add.asp'</script>"
          rs.close
          set rs=nothing
          conn.close
          set conn=nothing
	    else
		  rs.close
          set rs=nothing
		  response.write"<script>alert('该课程安排已经存在！');history.back(-1)</script>"
		end if
	 end if
  end if
end if
conn.close
set conn=nothing
cid=""             '课程号
crid=""         '教室编号
arweeks=""     '上课周
csid=""          '班级编号
arweek=""      '星期
dno=""
%>

</body>
</html>
