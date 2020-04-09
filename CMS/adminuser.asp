<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<!--#include file="../config/md5.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,oldpass,newpass,username,user_name,s_md5
sql="select * from [system_user] where s_id=90511"
DBopen("#step.mdb.asp")
rs.open sql,conn,1,3
username=rs("s_username")
s_md5=rs("s_md5")
if request.QueryString("operate")="edit" then
user_name=safeInstr(request.Form("user_name"))
oldpass=safeInstr(request.Form("oldpass"))
newpass=safeInstr(request.Form("newpass"))
if oldpass="" or newpass="" or user_name="" then
alertInfo("请输入用户名和[原][新]密码")
else if getStringLen(newpass)<6 then
alertInfo("新密码不能小于6个字符")
else if s_md5<>EnPas(md5(oldpass)) then
alertInfo("原密码错误请重新输入")
else
rs("s_username")=user_name
rs("s_md5")=EnPas(md5(newpass))
rs.update
rs.close
checkErr"修改密码","adminuser.asp"
end if
end if
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
<form name="form" action="adminuser.asp?operate=edit" method="post">
<div id="iframe-src">
<h1>管理员用户密码设置</h1>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
  <tr>
    <td width="12%">用户名：</td>
    <td width="88%"><input name="user_name" type="text" class="textform1" id="user_name"  value="<%=username%>"/></td>
  </tr>
  <tr>
    <td>原密码：</td>
    <td><input name="oldpass" type="password" class="textform1" id="oldpass" /></td>
  </tr>
  <tr>
    <td>新密码：</td>
    <td><input name="newpass" type="password" class="textform1" id="newpass" /></td>
  </tr>
  <tr>
    <td>说明：</td>
    <td>密码不能小于6个字符；用户名和密码不能包含特以下殊字符</td>
    </tr>
  <tr>
    <td colspan="2">"*","'",";","&","=","%","<",">","^","and","or","not","insert","select","update","delete"</td>
    </tr>
</table>
<div id="submit-date"><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="systeminfo.asp" >系统信息<img src="style/img/info.png" width="60" height="40" /></a></li>
    <li><a href="systemconfig.asp" >网站设置<img src="style/img/config.png" width="60" height="40" /></a> </li>
    <li><a href="adminuser.asp"  class="current">密码设置<img src="style/img/admin.png" width="60" height="40" /></a> </li>
    <li><a href="loglist.asp" >登陆日志<img src="style/img/log.png" width="60" height="40" /></a> </li>
   </ul>
</div>
<div class="operate">
<ul class="dont">
    <li>全选<img src="style/img/allcheck.png" width="60" height="40" /></li>
    <li>删除<img src="style/img/del.png" width="60" height="40" /></li>
    <li>编辑<img src="style/img/editor.png" width="60" height="40" /></li>
    <li>查看<img src="style/img/topweb.png" width="60" height="40" /></li>
</ul>
</div>
<!--end operate-->

</div>
<!--end iframe-src-->

</form>
<%DBclose()%>
</body>
</html>
