<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,i,list_id
DBopen("#step.mdb.asp")
if request.QueryString("operate")="del" then
   list_id=request.Form("list_id")
   if list_id="" then
      alertInfo("你没选中任何项目！")
   else
      conn.execute "delete from [login_record] where l_id in("&list_id&")"
      checkErr "删除","loglist.asp"
   end if 
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
@import url("style/css/skin.css");
</style>
<script language="javascript" type="text/javascript" src="../script/function.js" ></script>
</head>

<body>
<form name="formList" action="" method="post">
<div id="iframe-src">
<h1>登陆日志管理</h1>
<div id="iframe-src-content">
  <table border="1" bordercolor="#FFFFFF"cellpadding="0" cellspacing="2" class="list">
    <tr>
      <td width="4%">&nbsp;</td>
      <td width="32%">登陆用户名</td>
      <td width="32%">登陆IP</td>
      <td width="32%">登陆时间</td>
    </tr>
    <%
	sql="select * from [login_record]"
	page 13,sql
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='4'>没有记录</td></tr>")
	end if
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
	%>
    <tr>
      <td><input type="checkbox" name="list_id" id="checkbox" value="<%=rs("l_id")%>" /></td>
      <td><%=rs("l_username")%></td>
      <td><%=rs("l_ip")%></td>
      <td><%= FormatTime(rs("l_time"),"yy-mm-dd hh:nn:ss")%></td>
    </tr>
    <%
	rs.movenext
	next
	%>
  </table>
  <div id="submit-date"><%writePage(Url_address("page"))%></div>
</div>

<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="systeminfo.asp" >系统信息<img src="style/img/info.png" width="60" height="40" /></a></li>
    <li><a href="systemconfig.asp" >网站设置<img src="style/img/config.png" width="60" height="40" /></a> </li>
    <li><a href="adminuser.asp" >用户管理<img src="style/img/admin.png" width="60" height="40" /></a> </li>
    <li><a href="loglist.asp" class="current">登陆日志<img src="style/img/log.png" width="60" height="40" /></a> </li>
   </ul>
</div>



<div class="operate">
<ul>
    <li><a href="#" id="ckall" onclick="ChkAllClick('list_id','ckall')" >全选<img src="style/img/allcheck.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="delChecked('list_id','loglist.asp','loglist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
   
    <li class="dont">编辑<img src="style/img/editor.png" width="60" height="40" /></li>
    <li class="dont">查看<img src="style/img/topweb.png" width="60" height="40" /></li>
</ul>
</div>
<!--end operate-->
</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
