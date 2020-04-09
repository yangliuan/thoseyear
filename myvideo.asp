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
<link href="css/photo-style.css" rel="stylesheet" type="text/css" />
<link href="css/spacegallery.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="script/jquery-1.4.2.min.js" type="text/javascript"></script>
<script language="javascript" src="script/eye.js" type="text/javascript"></script>
<script language="javascript" src="script/spacegallery.js" type="text/javascript"></script>
<script language="javascript" src="script/xixi.js" type="text/javascript"></script>

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
  <div id="video-class">
  <span class="titleimg"><img src="images/myvideo.png" width="160" height="35" /></span><span id="localtionbg" class="localtion-nav">当前位置：首页->那些年的影像-视频专辑</span>
   <span class="huodie"></span>
       
      <div id=container>
       
        <div id=sub_col>
       <%call vclassInfo()%> 
        </div>
        <!--end sub_col-->
        <div id=main_col>
         <div id=gallery class=spacegallery>
        <%call vclassImg()%>  
          </div>
         <!--end gallery-->
       </div>
        <!--end main_col-->
      </div>
       
   <span class="tishi">点击图片可切换视频专辑↑</span>

  </div>
   <!--end photo-class-->
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