<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
if safeInstr(request.QueryString("act"))="loginout" then
session("adminName")=""
session("checkLogin")=""
response.Write("<script language='javascript'>window.close()</script>")
response.End()
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>那些年的足迹内容管理系统</title>
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	background-image: url(../images/body_bg.gif);
	background-repeat: repeat;
}
.topweb {
	font-family: "宋体";
	font-size: 12px;
	height: 30px;
	position: absolute;
	left: 10px;
	top: 0px;
}
.topweb a {
	color: #FFF;
	font-family: "宋体";
	font-size: 12px;
	font-weight: normal;
	text-decoration: none;
}
.topweb a:hover {
	color: #FF9999;
	text-decoration: underline;
}


#layout {
	padding: 0px;
	height: 768px;
	width: 1004px;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
}
#topbody {
	margin: 0px;
	padding: 0px;
	height: 290px;
	width: 100%;
	background-image: url(style/img/topbg.jpg);
	background-repeat: no-repeat;
	position: relative;
}
#mainbody {
	margin: 0px;
	padding: 0px;
	height: 520px;
	width: 100%;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
}
#footbody {
	margin: 0px;
	padding: 0px;
	height: 30px;
	width: 100%;
	background-color: #670001;
}
#mainbody iframe {
	margin: 0px;
	padding: 0px;
	height: 100%;
	width: 100%;
	overflow: hidden;
	overflow-x: hidden;
	overflow-y: hidden;
}
#log {
	margin: 0px;
	padding: 0px;
	height: 30px;
	width: 100%;
	position: absolute;
	left: 0px;
	top: 0px;
	right: 0px;
	background-color: #670100;
	font-family: "微软雅黑";
	font-size: 14px;
	line-height: 30px;
	font-weight: bold;
	color: #FFF;
	text-align: center;
}
#c-nav {
	background-color: #670100;
	position: absolute;
	height: 40px;
	width: 100%;
	left: 0px;
	right: 0px;
	bottom: 0px;
	margin: 0px;
	padding: 0px;
}

.class_nav  ul {
	PADDING: 0px;
	DISPLAY: block;
	LIST-STYLE-TYPE: none;
	HEIGHT: 25px;
	COLOR: #ffffff;
	margin-top: 7.5px;
	margin-right: auto;
	margin-bottom: auto;
	margin-left: auto;
	border-left-width: 1px;
	border-left-style: solid;
	border-left-color: #FFF;
	width: 656px;
}
.class_nav  li {
	BORDER-RIGHT: #ffffff 1px solid;
	DISPLAY: block;
	FLOAT: left;
	HEIGHT: 25px;
	margin: 0px;
	padding: 0px;
}
.class_nav   li   a {
	DISPLAY: block;
	COLOR: #ffffff;
	LINE-HEIGHT: 22px;
	TEXT-DECORATION: none;
	padding-top: 1px;
	padding-right: 15px;
	padding-bottom: 0;
	padding-left: 15px;
	font-family: "宋体";
	font-size: 12px;
	margin: 0px;
}
.class_nav   li   a:hover {
	BACKGROUND-COLOR: #A20000;
	TEXT-DECORATION: underline;
}
.current{
	background-color: #A20000;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-right-style: none;
	border-bottom-style: solid;
	border-left-style: none;
	border-top-color: #FFF;
	border-right-color: #FFF;
	border-bottom-color: #FFF;
	border-left-color: #FFF;
}
#date {
	position: absolute;
	top: 220px;
	left: 766px;
	height: 25px;
	width: auto;
	font-family: "微软雅黑";
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #600;
}
span.loginout {
}
.loginout {
	position: absolute;
	height: 30px;
	top: 0px;
	right: 10px;
}
.loginout a {
	color: #FFF;
	font-size: 12px;
	font-family: "宋体";
	font-weight: normal;
	text-decoration: none;
}
.loginout a:hover {
	color: #FF9999;
	text-decoration: underline;
}
</style>
<script language="javascript" type="text/javascript" src="../script/function.js"></script>
</head>

<body>
<div id="layout">
<div id="topbody">
<div id="log"><span class="topweb"><a href="../index.asp" target="_blank">网站首页</a></span>你好，管理员：<%=session("adminName")%>，欢迎你登陆<span class="loginout"><a href="cmsdefault.asp?act=loginout" target="_self">安全退出</a></span></div><!--end log-->
<div id="date">服务器时间：<%=FormatTime(now(),"yyyy-mm-dd hh:nn")%></div>
<div id="c-nav" class="class_nav">
<ul>
    <li><a href="welcome.asp" target="mainFrame" class="current" onclick="change_bg(this)">系统首页</a></li>
    <li><a href="systeminfo.asp" target="mainFrame" onclick="change_bg(this)">系统设置</a> </li>
    <li><a href="bannerlist.asp" target="mainFrame" onclick="change_bg(this)">Banner管理</a> </li>
    <li><a href="editresume.asp" target="mainFrame" onclick="change_bg(this)">个人档管理</a> </li>
    <li><a href="diarylist.asp" target="mainFrame" onclick="change_bg(this)">日记管理</a> </li>
    <li><a href="photolist.asp" target="mainFrame" onclick="change_bg(this)">照片管理</a> </li>
    <li><a href="videolist.asp" target="mainFrame" onclick="change_bg(this)">视频管理</a> </li>
    <li><a href="messagelist.asp" target="mainFrame" onclick="change_bg(this)">留言管理</a> </li>
</ul>
</div><!--end c-nav-->
</div><!--end topbody-->
<div id="mainbody"><iframe src="welcome.asp" name="mainFrame" id="mainFrame" scrolling="no" frameborder="0"></iframe></div><!--end mainbody-->
<div id="footbody"></div><!--end footbody-->
</div>
<!--end layout-->
</body>
</html>
