<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%checkLogin("cmslogin.asp")%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
@import url("style/css/skin.css");
</style>

</head>

<body>

<div id="iframe-src">
<h1>服务器系统信息</h1>
<div id="iframe-src-content">
<table border=1 bordercolor="#FFFFFF" cellspacing=2 align=center class=list >
	<tr><td colspan="2">服务器的有关参数</td>
		<td colspan="2">组件支持有关参数</td>
	  </tr>
	
	<tr>
		<td width="15%">服务器名：</td>
		<td width="45%"><%=Request.ServerVariables("SERVER_NAME")%></td>
		<td width="20%">ADO 数据对像：</td>
		<td width="20%"><%=Get_ObjInfo("adodb.connection", 1)%></td>
	</tr>
	<tr>
		<td width="15%">服务器IP：</td>
		<td width="45%"><%=Request.ServerVariables("LOCAL_ADDR")%></td>
		<td width="20%">FSO 文本文件读写：</td>
		<td width="20%"><%=Get_ObjInfo("scripting.filesystemobject", 0)%></td>
	</tr>
	<tr>
		<td width="15%">服务器端口：</td>
		<td width="45%"><%=Request.ServerVariables("SERVER_PORT")%></td>
		<td width="20%">Stream 文件流：</td>
		<td width="20%"><%=Get_ObjInfo("Adodb.Stream", 0)%></td>
	</tr>
	<tr>
		<td width="15%">服务器时间：</td>
		<td width="45%"><%=Now()%></td>
		<td width="20%">Jmail 邮件收发：</td>
		<td width="20%"><%=Get_ObjInfo("JMail.SMTPMail", 1)%></td>
	</tr>
	<tr>
		<td width="15%">IIS版本：</td>
		<td width="45%"><%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
		<td width="20%">ASPmail 发信：</td>
		<td width="20%"><%=Get_ObjInfo("SMTPsvg.Mailer", 1)%></td>
	</tr>
	<tr>
		<td width="15%">服务器操作系统：</td>
		<td width="45%"><%=Request.ServerVariables("OS")%></td>
		<td width="20%">CDONTS 虚拟SMTP发信：</td>
		<td width="20%"><%=Get_ObjInfo("CDONTS.NewMail", 1)%></td>
	</tr>
	<tr>
		<td width="15%">脚本超时时间：</td>
		<td width="45%"><%=Server.ScriptTimeout%> 秒</td>
		<td width="20%">LyfUpload 上传组件：</td>
		<td width="20%"><%=Get_ObjInfo("LyfUpload.UploadFile", 1)%></td>
	</tr>
	<tr>
		<td width="15%">站点物理路径：</td>
		<td width="45%"><%=request.ServerVariables("APPL_PHYSICAL_PATH")%></td>
		<td width="20%">AspUpload 上传组件：</td>
		<td width="20%"><%=Get_ObjInfo("Persits.Upload.1", 1)%></td>
	</tr>
	<tr>
		<td width="15%">服务器CPU数量：</td>
		<td width="45%"><%=Request.ServerVariables("NUMBER_OF_PROCESSORS")%> 个</td>
		<td width="20%">SA-FileUp 上传组件：</td>
		<td width="20%"><%=Get_ObjInfo("SoftArtisans.FileUp", 1)%></td>
	</tr>
	<tr>
		<td width="15%" height="29">服务器脚本引擎：</td>
		<td width="45%"><%=ScriptEngine & "/" & ScriptEngineMajorVersion & "." & ScriptEngineMinorVersion & "." & ScriptEngineBuildVersion %></td>
		<td width="20%">AspJpeg 图像处理组件：</td>
		<td width="20%"><%=Get_ObjInfo("Persits.Jpeg",1)%></td>
	</tr>

	</table>

	


</div><!--end iframe-src-content-->

<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="systeminfo.asp" class="current" >系统信息<img src="style/img/info.png" width="60" height="40" /></a></li>
    <li><a href="systemconfig.asp" >网站设置<img src="style/img/config.png" width="60" height="40" /></a> </li>
    <li><a href="adminuser.asp">用户管理<img src="style/img/admin.png" width="60" height="40" /></a> </li>
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
</body>
</html>
