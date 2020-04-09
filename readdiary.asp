<!--#include file="config/config.asp"-->
<!--#include file="config/function.asp"-->
<!--#include file="config/topweb.asp"-->
<%
dim operate,id,diaryValue(12),dclassValue(5)
operate=safeInstr(request.QueryString("operate"))
id=request.QueryString("id")
if operate="read" and id<>""  then
id=safeRequest(id)
DBopen("record/#step.mdb")
call config()
call readDiary()
call readDclass()
else
response.End()
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=diaryValue(2)%></title>
<meta name="keywords" content="<%=diaryValue(6)%>" />
<meta name="description" content="<%=diaryValue(6)%>"/>
<link href="css/import.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/jscrollpane1.css" />
<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
<!-- the mousewheel plugin -->
<script type="text/javascript" src="script/jquery.mousewheel.js"></script>
<!-- the jScrollPane script -->
<script type="text/javascript" src="script/jquery.jscrollpane.min.js"></script>
<script type="text/javascript" src="script/scroll-startstop.events.jquery.js"></script>
<script language="javascript" src="script/page-scroll.js" type="text/javascript"></script>
<style>
#readdiary
{
	background-image: url(<%=dclassValue(2)%>);
	background-repeat: no-repeat;	
	
	}
.localtion-nav 
{   color: <%=diaryValue(4)%>;
	background-image: url(<%=dclassValue(3)%>);
	background-repeat: repeat;
	}	
	
.jp-container{
	width: 890px;
	height: 480px;
	overflow: hidden;
	margin: 0px;
	padding-top: 10px;
	position: absolute;
	background-image: url(<%=dclassValue(3)%> );
	background-repeat: repeat;
	top: 37px;
	right: 30px;
	padding-right: 20px;
	padding-left: 10px;
	text-align: left;
}

#jp-container h2 {
	font-family: <%=diaryValue(3)%>;
	color: <%=diaryValue(4)%>;
	font-size: <%=diaryValue(5)%>px;
	line-height: 32px;
	font-weight: bolder;
	text-align: center;
}
#jp-container h3 {
	font-family: "宋体";
	font-size: 12px;
	color:<%=diaryValue(4)%>;
	line-height: 25px;
	font-weight: normal;
	text-align: center;
	word-spacing: 20px;
}
#page {
	
	background-image:url(<%=dclassValue(3)%> );
	background-repeat: repeat;
	color: <%=diaryValue(4)%>;	 
	}
	.pro {
	display: block;
	margin: 0px;
	padding: 0px;
	float: left;
	width: 49%;
	height: 35px;
	text-align: left;
	text-indent: 1em;
	font-family: "宋体";
	font-size: 12px;
	line-height: 35px;
}
.pro a {
	color: <%=diaryValue(4)%>;
	text-decoration: none;
}
.pro a:hover {
	text-decoration: underline;
}
.next {
	text-align: right;
	display: block;
	margin: 0px;
	padding: 0px;
	float: left;
	width: 49%;
}
.next a {
	color: <%=diaryValue(4)%>;
	text-decoration: none;
}
.next a:hover {
	text-decoration: underline;
}
</style>
</head>

<body>
<div id="layout">
<div id="topbody">网站名称：<%=valueArray(1)%>&nbsp;<a href="javascript:viod(0);" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('<%=valueArray(4)%>');return false;">设为首页</a><strong>|</strong><a href="javascript:window.external.Addfavorite('<%=valueArray(4)%>')">加入收藏</a></div>
<!--end topbody-->  
<div id="mainbody">

  <div id="navd">
   <div id="logo"><a href="<%=valueArray(4)%>" target="_self"><img src="<%=valueArray(3)%>" width="200" height="100" style="border:0px"/></a></div> 
    <div id="link"><a href="index.asp">[首页]</a>&nbsp;<a href="aboutme.asp" target="_self">[那些年的我]</a>&nbsp;<a href="mydiary.asp" target="_self">[那些年的日记]</a>&nbsp;<a href="myphoto.asp" target="_self">[那些年的相片]</a>&nbsp;<a href="myvideo.asp" target="_self">[那些年的影像]</a>&nbsp;<a href="contact.asp" target="_self">[联系我]</a>&nbsp;&nbsp;&nbsp;&nbsp;</div></div>
  <!--end navd-->
  <div id="readdiary">
   <span class="titleimg"><img src="images/readdiary.png" width="120" height="33" /></span><span class="localtion-nav">当前位置：首页->那些年的日记-><%=dclassValue(1)%></span>
  
  <div id="jp-container" class="jp-container">
  <h2><%=getSubString(diaryValue(2),30)%></h2>
  <h3>作者：<%=getSubString(diaryValue(7),5)%>&nbsp;来源：<%=getSubString(diaryValue(8),10)%>&nbsp;时间：<%=FormatTime(diaryValue(11),"yyyy-mm-dd hh:nn")%></h3>
 <%=diaryValue(10)%>
  </div>
 
  <!--end jp-container-->
<div id="page"><span class="pro">上一篇：<%call proRead()%></span><span class="next">下一篇：<%call nextRead()%></span></div>
  </div>
  <!--end readdiary-->
  
</div>
<!--end mainbody-->
<div id="footbody">
<span class="copyright">©</span> <%=valueArray(1)%>|<%=valueArray(7)%><br/>&nbsp;&nbsp;|<a href="description.html" target="_blank">网站声明</a>|<a href="contact.asp" target="_blank">联系我</a>| 
</div>
<!--end footbody-->
</div>
<!--end layout-->
</body>
</html>
<%DBclose()%>
