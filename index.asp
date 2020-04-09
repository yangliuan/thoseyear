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
<link href="css/slideshow.css" rel="stylesheet" type="text/css" />
<link href="css/css_pirobox/style_1/pstyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="script/jquery.min.js"></script>
<script type="text/javascript" src="script/jquery-ui-1.8.2.custom.min.js"></script>
<script type="text/javascript" src="script/pirobox_extended.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$().piroBox_ext({
	piro_speed : 700,
		bg_alpha : 0.5,
		piro_scroll : true // pirobox always positioned at the center of the page
	});
});
</script>
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
  <!--end nav-->
  <div id="banner">
  <!--特效开始-->
   <div id="yc-mod-slider">
        <div class="wrapper">
            <div id="slideshow" class="box_skitter fn-clear">
                <ul>
                   <%call showBanner()%>
                </ul>
            </div>
            <script type="text/javascript" src="script/slideshow.js"></script>
        </div>
    </div>
    <!--特效结束-->
 </div>
  <!--end banner-->
  <div id="ixcontent">
    <div id="ix_rj_list">
    <h1 class="intitle">最新日记<span class="more"><a href="mydiary.asp" target="_self">More>></a></span></h1>
    <div class="rjlist-content">
    <ul>
    <%call showIndexDiary()%>
   </ul>
   <span class="biaoyu">Who came will leaving any traces</span>
    </div>
    </div>
    <!--end ix_rj_list-->
    <div id="ix_photo_list">
    <h1 class="intitle">最新相片<span class="more"><a href="myphoto.asp" target="_self">More>></a></span></h1>
   <!--photoshow-border-->
   <div id="photoshow_border">
   
    <div id="scrollimg">
   <div id="scrollimg_con">
      <ul>
		<%call showIndexPhoto()%>
	  </ul>
				
   </div>
    </div>	
 <script language="javascript" type="text/javascript" src="script/scrolling.js"></script>   
<script language="javascript" type="text/javascript">
var myScroll = new ScrollNews('scrollimg','scrollimg_con','li');
</script>
 </div>
   <!--end photoshow-border-->
    </div>
    <!--end ix_photo_list-->
    <div id="ix_aboutme">
    <h1 class="intitle">关于我<span class="more"><a href="aboutme.asp" target="_self">More>></a></span></h1>
     <!--    ix_aboutme_list-->
    <%showAboutMe()%>
    <div id="ix_aboutme_list"><span class="aboutme_photo"><img src="<%=r_value(1)%>" width="100" height="85"/></span>
    <ul>
    <li>姓名：<%=r_value(2)%></li>
    <li>性别：<%=r_value(3)%></li>
    <li>年龄：<%=r_value(4)%></li>
    <li>座右铭:</li>
    <li>&nbsp;&nbsp;&nbsp;&nbsp;<%=r_value(14)%></li>
    </ul>
    </div>  
     <!--   end  ix_aboutme_list-->
    </div>
    <!--end ix_aboutme-->
  </div>
  <!--end ixcontent-->
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