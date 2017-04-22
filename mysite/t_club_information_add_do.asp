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
<title>社团添加处理</title>
</head>

<body>
<%
cid=trim(request.Form("cno"))
if len(cid)<>3 then
    response.write"<script>alert('社团编号只能输入3位数字哦！');history.back(-1)</script>"
else
  cname=trim(request.Form("cname"))
  sno=trim(request.Form("sno"))
  if cid="" or cname="" or sno="" then
    response.Write"<script>alert('红色标注信息不能为空!');history.back(-1)</script>"
  else
    set rs1=server.CreateObject("Adodb.Recordset")
    sql="select * from t_student where s_no='"&sno&"'" 
    rs1.open sql,conn,3,1
    if rs1.eof or rs1.bof then
       rs1.close
	   set rs1=nothing
       response.Write"<script>alert('该学号不存在哦!');history.back(-1)</script>"
    else 
       rs1.close
      set rs1=nothing
      set rs2=server.CreateObject("Adodb.Recordset")
      sql="select * from t_club where s_no='"&sno&"'"
      rs2.open sql,conn,3,1
      if not(rs2.bof) or not rs2.eof then
	    rs2.close
		set rs2=nothing
        response.Write"<script>alert('该学号已成为别的社团的会长哦!');history.back(-1)</script>"
      else
        rs2.close
		set rs2=nothing
		set rs=server.CreateObject("Adodb.Recordset")
		sql="select * from t_club where cl_no='"&cid&"'"
        cid=""
        cname=""
        rs.open sql,conn,1,2
       if not rs.bof or not rs.eof then
	      rs.close
          set rs=nothing
	      response.write "<script>alert('此社团编号已存在！');history.back(-1)</script>"
        else
          rs.addnew
          rs("cl_no")=trim(request.Form("cno"))
          rs("cl_name")=trim(request.Form("cname"))
          rs("cl_date")=trim(request.Form("cdate"))
          rs("s_no")=trim(request.Form("sno"))
          rs("cl_brief")=trim(request.Form("cbrief"))
          rs.update
          rs.close
          set rs=nothing
          response.write"<script>alert('添加成功！');location.href='t_club_information_add.asp'</script>"
        end if
      end if
	 end if
   end if
end if
conn.close
set conn=nothing
%>
</body>
</html>
