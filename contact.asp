<!--#include file="config/config.asp"-->
<!--#include file="config/function.asp"-->
<!--#include file="config/topweb.asp"-->
<%
DBopen("record/#step.mdb")
call config()
call sendMessage()
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
<script language="javascript" type="text/javascript">
function ckmessage(){
	$('.error').html('&nbsp;&nbsp;正在发送留言...!');
	$('.error').show(300);	
	if ($('#m_name').val()==''){
		$('#m_name').focus();
		$('.error').html('&nbsp;&nbsp;请输入你的名字!');
		return;
	}
	if ($('#m_contact').val()==''){
		$('#m_contact').focus();
		$('.error').html('&nbsp;&nbsp;请输入你的联系方式!');
		return;
	}
	if ($('#m_title').val()==''){
		$('#m_title').focus();
		$('.error').html('&nbsp;&nbsp;请输入留言标题!');
		return;
	}
	if ($('#m_content').val()==''){
		$('#m_content').focus();
		$('.error').html('&nbsp;&nbsp;请输入留言内容!');
		return;
	}
	$.ajax({type:'POST',
		   url:'contact.asp?operate=send',
		   data:'m_name='+escape($('#m_name').val())+'&m_contact='+escape($('#m_contact').val())+'&m_title='+escape($('#m_title').val())+'&m_content='+escape($('#m_content').val()),
		   success:function(msg){
			   if(msg=='0'){alert('留言发送成功，请等待审核');window.location='contact.asp';}
			   else{$('.error').html('&nbsp;&nbsp;'+msg);$('.error').show();}
			   
		   }});
	
}
</script>
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


.error {
	margin: 0px;
	padding: 0px;
	height: 35px;
	width: 100%;
	font-family: "微软雅黑";
	font-size: 12px;
	line-height: 30px;
	font-weight: bold;
	color: #646C76;
}
.send a   {
	display: block;
	font-family: "微软雅黑";
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #646C76;
	text-decoration: none;
	height: 25px;
	width: 100%;
	text-align: center;
}
.titletxt {
	font-family: "宋体";
	line-height: 15px;
	color: #646C76;
	height: 15px;
	width: 130px;
	border: 1px solid #646C76;
}
.contenttxt {
	font-family: "宋体";
	font-size: 12px;
	line-height: 20px;
	color: #646C76;
	height: 100px;
	width: 190px;
	border: 1px solid #646C76;
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
    <div id="message-me"><span id="localbg" class="localtion-nav">当前位置：首页->联系我</span>
    <span class="titleimg"><img src="images/message-me.png" width="119" height="33" /></span>
         <div id="jp-container" class="jp-container">
         <%call messageList()%>
      </div>
         <script language="javascript" src="script/page-scroll.js" type="text/javascript"></script>
     <!--  end jp-cntainer-->      
    </div>
  <!--  end Nxn-me --> 
  <div id="contact-me">
  <span class="titleimgr"><img src="images/contact-me.png" width="69" height="33" /></span>
  <div id="contact-me-content">
    <form action="" method="post">
   <ul>
   <li>联系地址：<%=valueArray(8)%></li>   
   <li>联系电话：<%=valueArray(9)%></li>
   <li>联系邮箱：<%=valueArray(10)%></li>
   <li>QQ交谈：</li>
   <li><a target=blank href=tencent://message/?uin=<%=valueArray(11)%>&Site=自己&Menu=yes><img border="0" SRC=http://wpa.qq.com/pa?p=1:<%=valueArray(11)%>:1 alt="点击这里给我发消息"></a>&nbsp;</li>
   <li>&nbsp;</li>
   <li><strong>给我留言:</strong></li>
   <li>你的姓名：<input name="m_name" type="text" class="titletxt" id="m_name" /></li>
   <li>联系方式：<input name="m_contact" type="text" class="titletxt" id="m_contact" /></li>
   <li>留言标题：<input name="m_title" type="text" class="titletxt" id="m_title" /></li>
   <li>留言内容：</li>
   <li><textarea name="m_content" class="contenttxt" id="m_content"></textarea></li>
  <li><span class="send"><a href="javascript:void(0);"  onclick="ckmessage();">发送留言</a></span></li>
   
  </ul>
  <div class="error">&nbsp;&nbsp;</div>
  </form>
 
   
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