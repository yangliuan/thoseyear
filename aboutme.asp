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
<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
<!-- the mousewheel plugin -->
<script type="text/javascript" src="script/jquery.mousewheel.js"></script>
<!-- the jScrollPane script -->
<script type="text/javascript" src="script/jquery.jscrollpane.min.js"></script>
<script type="text/javascript" src="script/scroll-startstop.events.jquery.js"></script>
<style type="text/css">
.jp-container{
	width: 678px;
	height: 490px;
	position: absolute;
	overflow: hidden;
	padding: 0px;
	font-family: "宋体";
	color: #FFF;
	margin: 0px;
	left: 30px;
	top: 35px;
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
    <div id="Nxn-me"><span id="localbg" class="localtion-nav">当前位置：首页->那些年的我->个人简历</span>
    <%call showAboutMe()%>
    <span class="titleimg"><img src="images/Nxn-me.png" width="135" height="33" /></span>
         <div id="jp-container" class="jp-container">
         <span class="Nxn-me_photo"><img src="<%=r_value(1)%>" width="100" height="85" /></span>
        <ul>
        <li>姓名：<%=r_value(2)%></li>
        <li>性别：<%=r_value(3)%></li>
        <li>年龄：<%=r_value(4)%></li>
        <li>身高：<%=r_value(5)%></li>
        <li>居住地：<%=r_value(6)%></li>
        </ul>
        <ul>
        <li>所学专业：<%=r_value(7)%></li>
        <li>毕业院校：<%=r_value(8)%></li>
        <li>联系电话：<%=r_value(9)%></li>
        <li>联系邮箱：<%=r_value(10)%></li>
        <li>联系QQ号<%=r_value(11)%></li>
        </ul>
        <p>兴趣爱好：<br />&nbsp;&nbsp;&nbsp;&nbsp;<%=r_value(12)%></p>
        <p>自我评价：<br />&nbsp;&nbsp;&nbsp;&nbsp;<%=r_value(13)%>。</p>
        <p>座右铭：<br />&nbsp;&nbsp;&nbsp;&nbsp;<%=r_value(14)%></p>
        <p>受教育经历：<br />&nbsp;&nbsp;&nbsp;&nbsp;<%=r_value(15)%></p>
<p>工作经历：<br />&nbsp;&nbsp;&nbsp;&nbsp;<%=r_value(16)%></p>
<p>所学技能：<br />&nbsp;&nbsp;&nbsp;&nbsp;<%=r_value(17)%></p>                                                                             
         </div>
         <script language="javascript" src="script/page-scroll.js" type="text/javascript"></script>
     <!--  end jp-cntainer-->      
    </div>
  <!--  end Nxn-me --> 
  <div id="Hygq">
  <span class="titleimgr"><img src="images/nxn_rsgw.png" width="102" height="33" /></span>
  <div id="Hygq-content">
   <p><%=r_value(18)%></p>
   </div>
   <!--end Hygq-content-->
  </div>
  <!--end Hygq-->
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