<!--#include file="config/config.asp"-->
<!--#include file="config/function.asp"-->
<!--#include file="config/topweb.asp"-->
<%
DBopen("record/#step.mdb")
call config()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=valueArray(2)%></title>
<meta name="keywords" content="<%=valueArray(5)%>" />
<meta name="description" content="<%=valueArray(6)%>"/>
<link href="css/import.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/jscrollpane1.css" />
<link href="css/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
<!-- the mousewheel plugin -->
<script type="text/javascript" src="script/jquery.mousewheel.js"></script>
<!-- the jScrollPane script -->
<script type="text/javascript" src="script/jquery.jscrollpane.min.js"></script>
<script type="text/javascript" src="script/scroll-startstop.events.jquery.js"></script>
<script src="script/SpryTabbedPanels.js" type="text/javascript"></script>
<style type="text/css">
.jp-container{
	width: 678px;
	height: 490px;
	position: absolute;
	padding: 0px;
	font-family: "宋体";
	color: #FFF;
	margin: 0px;
	left: 28px;
	top: 34px;
	overflow: hidden;
	overflow-x:hidden;
	overflow-y:auto;
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
  <div id="diarylist">
  <p><span class="titleimg"><img src="images/nxn-rj.png" width="150" height="33" /></span><span class="localtion-nav">当前位置：首页->那些年的日记->日记列表</span></p>
  <div id="jp-container" class="jp-container">
   <span class="diaryclass">日记分类：</span> 
    <div id="TabbedPanels1" class="TabbedPanels">
    <ul class="TabbedPanelsTabGroup">
      <li class="TabbedPanelsTab" tabindex="0">全部</li>
     <%call dclassList()%>
    </ul>
    <div class="TabbedPanelsContentGroup">
      <div class="TabbedPanelsContent"><ul class="rjlist"><%call diaryAll()%></ul></div>
      <%call diaryList()%>
    </div>
  </div>
</div>
<script language="javascript" src="script/page-scroll.js" type="text/javascript"></script>
 <!-- end jp-container-->
  </div>
  <!--end diarylist-->
  <div id="readtop">
  <span class="titleimgr"><img src="images/tjrj.png" width="80" height="33" /></span>
  <div id="readtop-content">
    <%call readTop()%>
 
</div>
  <!--end readtop-content-->
  </div>
  <!--end readtop-->
</div>
<!--end mainbody-->
<div id="footbody">
<span class="copyright">©</span> <%=valueArray(1)%>|<%=valueArray(7)%><br/>&nbsp;&nbsp;|<a href="description.html" target="_blank">网站声明</a>|<a href="contact.asp" target="_blank">联系我</a>| 
</div>
<!--end footbody-->
</div>
<!--end layout-->

<script type="text/javascript">
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
</script>
</body>
</html>
<%DBclose()%>