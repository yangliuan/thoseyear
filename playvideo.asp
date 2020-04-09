<!--#include file="config/config.asp"-->
<!--#include file="config/function.asp"-->
<!--#include file="config/topweb.asp"-->
<%
dim operate,id,videoValue(4)
operate=safeInstr(request.QueryString("operate"))
id=request.QueryString("id")
if operate<>"play" or id=""  then
response.End()
else
id=safeRequest(id)
DBopen("record/#step.mdb")
call config()
call playVideo()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=valueArray(2)%></title>
<meta name="keywords" content="<%=valueArray(5)%>" />
<meta name="description" content="<%=valueArray(6)%>"/>
<link href="css/import.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.pro {
	font-family: "宋体";
	font-size: 12px;
	color: #333;
	text-decoration: none;
	margin: 0px;
	padding: 0px;
	float: left;
	height: 35px;
	width: 50%;
	display: block;
	text-align: left;
}
.next {
	font-family: "宋体";
	font-size: 12px;
	line-height: 35px;
	color: #333;
	text-decoration: none;
	text-align: right;
	display: block;
	margin: 0px;
	padding: 0px;
	float: left;
	height: 35px;
	width: 50%;
}
</style>
<script src="script/swfobject_modified.js" type="text/javascript"></script>
<script src="Scripts/swfobject_modified.js" type="text/javascript"></script>

</style>
</head>

<body>
<div id="layout">
<div id="topbody">网站名称：<%=valueArray(1)%>&nbsp;<a href="javascript:viod(0);" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('<%=valueArray(4)%>');return false;">设为首页</a><strong>|</strong><a href="javascript:window.external.Addfavorite('<%=valueArray(4)%>')">加入收藏</a></div>
<!--end topbody-->  
<div id="mainbody">

  <div id="navd">
    <div id="logo"><a href="<%=valueArray(4)%>" target="_self"><img src="<%=valueArray(3)%>" width="200" height="100" style="border:0px"/></a></div> 
     <div id="link"><a href="index.asp">[首页]</a>&nbsp;<a href="aboutme.asp" target="_self">[那些年的我]</a>&nbsp;<a href="mydiary.asp" target="_self">[那些年的日记]</a>&nbsp;<a href="myphoto.asp" target="_self">[那些年的相片]</a>&nbsp;<a href="myvideo.asp" target="_self">[那些年的影像]</a>&nbsp;<a href="contact.asp" target="_self">[联系我]</a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
  <!--end navd-->
  <div id="video-list">
  <span class="titleimg"><img src="images/myvideo.png" width="160" height="35" /></span><span id="localbg" class="localtion-nav">当前位置：首页->那些年的影像->影像放映</span>
  <div id="video-list-content">
   <h1><%=videoValue(2)%></h1>
   <div id="media">
<embed src="http://player.youku.com/player.php/Type/Folder/Fid/19520954/Ob/1/sid/<%=videoValue(3)%>/v.swf" width="799" type="application/x-shockwave-flash" height="450" quality="high" align="middle" allowScriptAccess="always" allowFullScreen="true" mode="transparent" wmode="transparent"></embed>
   </div>
   <!--end media-->
  </div>
  <div id="page"><span class="pro">上一部：<%call proPlay()%></span><span class="next">下一部：<%call nextPlay()%></span></div>
 <!-- end video-introduction-->
  </div>
  <!--end video-list-content-->
  </div>
  <!--end video-list->
</div>
<!--end mainbody-->
<div id="footbody">
<span class="copyright">©</span> <%=valueArray(1)%>|<%=valueArray(7)%><br/>&nbsp;&nbsp;|<a href="description.html" target="_blank">网站声明</a>|<a href="contact.asp" target="_blank">联系我</a>| </div>
<!--end footbody-->
</div>
<!--end layout-->
</body>
</html>
<%DBclose()
end if
%>