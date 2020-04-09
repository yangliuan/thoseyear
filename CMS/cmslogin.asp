<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<!--#include file="../config/md5.asp"-->
<%
if request.QueryString("act") = "login" then
	dim username,userpass,getcode,s_username,s_md5
	username = safeInstr(trim(request.Form("username")))
	userpass = safeInstr(trim(request.Form("userpass")))
	getcode = safeInstr(trim(request.Form("getcode")))
	if getcode <> Session("GetCode") then
		Session("GetCode") = ""
		response.Write("验证码错误!")
		response.End()
	end if
	if username = "" or  userpass = "" then
		response.Write("用户名和密码不能为空!")
		response.End()
	end if
	
   DBopen("#step.mdb.asp")
     rs.open "select * from [system_user] where s_id=90511",conn,1,1
     s_username=rs("s_username")
	 s_md5=rs("s_md5")
	 rs.close
     if username<>s_username or EnPas(md5(userpass))<>s_md5 then
        response.Write("用户名或密码错误!")
		response.End()
     else
	    session("adminName")=username
        session("checkLogin")=true
	    response.Write("0") //登录成功
	 end if
   if session("checkLogin")=true then    '登陆成功后记录登陆日志
      rs.open"select * from [login_record]",conn,1,3
      rs.addnew
      rs("l_username")=session("adminname")
      rs("l_ip")=UserIp()
      rs.update
      rs.close
    end if
	 DBclose
	 response.End()
end if

%>
<!DOCTYPE html PUBLIC "-//W3C//DD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理系统登录</title>
<script language="javascript" type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
<style type="text/css">
<!--
body {
	margin: 0px;
	padding: 0px;
	background-image: url(../images/body_bg.gif);
}
#ipt {
	height: 593px;
	width: 649px;
	padding: 0px;
	background-image: url(style/img/login-bg.png);
	background-repeat: no-repeat;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
	position: relative;
}
#title {
	position: absolute;
	left: 167px;
	top: 241px;
	font-family: "微软雅黑";
	font-size: 24px;
	font-weight: bold;
	color: #999;
}
.login {
	position: absolute;
	width: 432px;
	height: 95px;
	right: 125px;
	bottom: 190px;
}
.login p {
	margin: 0px;
	padding: 0px;
	width: 100%;
	text-align: center;
	height: 25px;
	font-family: "宋体";
	font-size: 12px;
	color: #999;
	line-height: 25px;
}
.logintextform {
	height: 12px;
	width: 130px;
	background-color: #FEFEDC;
	border: 1px solid #999;
	font-family: "宋体";
	font-size: 12px;
	line-height: 12px;
	color: #999;
}
.codetextform {
	font-family: "宋体";
	font-size: 12px;
	line-height: 12px;
	color: #999;
	text-align: center;
	height: 12px;
	width: 87px;
	background-color: #FEFEDC;
	border: 1px solid #999;
}
#codeimg {
	padding: 0px;
	line-height: 25px;
	margin: 0px;
	height: 24px;
}
.gobutton {
	position: absolute;
	left: 295px;
	top: 429px;
	font-family: "微软雅黑";
	font-size: 20px;
	color: #999;
	text-decoration: none;
	font-weight: bold;
}
.error {
	position: absolute;
	left: 228px;
	top: 391px;
	width: 165px;
	font-family: "微软雅黑";
	font-size: 12px;
	height: 27px;
	line-height: 25px;
	text-align: center;
	color: #666;
}
-->
</style>
</head>

<body id="lg">
<div id="login">
<script language="javascript" type="text/javascript">
function cklogin(){
	$('.error').html('&nbsp;&nbsp;正在登陆...!');
	$('.error').show(300);	
	if ($('#UserName').val()==''){
		$('#UserName').focus();
		$('.error').html('&nbsp;&nbsp;用户名不能为空!');
		return;
	}
	if ($('#UserPass').val()==''){
		$('#UserPass').focus();
		$('.error').html('&nbsp;&nbsp;密码不能为空!');
		return;
	}
	if ($('#GetCode').val()==''){
		$('#GetCode').focus();
		$('.error').html('&nbsp;&nbsp;验证码不能为空!');
		return;
	}
	$.ajax({type:'POST',
		   url:'cmslogin.asp?act=login',
		   data:'username='+escape($('#UserName').val())+'&userpass='+escape($('#UserPass').val())+'&getcode='+escape($('#GetCode').val()),
		   success:function(msg){
			   if(msg=='0'){window.location='cmsdefault.asp';}
			   else{$('.error').html('&nbsp;&nbsp;'+msg);$('.error').show();}
			   if(msg=='验证码错误!'){$('#codeimg').attr('src','../config/getcode.asp?'+Math.random());}
		   }});
	
}
function KeyDown()
{
    if (event.keyCode == 13)
    {
        event.returnValue=false;
        event.cancel = true;
        cklogin();
    }
}
</script>
<form>
<div id="ipt">

<div id="title">那些年的足迹内容管理系统</div>
  <div class="login">
        <p><label>用户名：</label><input name="UserName" type="text" class="logintextform" id="UserName" />
        </p>
        <p><label>密　码：</label><input name="UserPass" type="password" class="logintextform" id="UserPass" />
          </p>
        <p><label>验证码：</label><input name="GetCode" type="text" class="codetextform" id="GetCode" onkeydown="KeyDown()" />
          
        <img src="../config/getcode.asp?" name="codeimg" height="25" id="codeimg" onclick="this.src+=Math.random();" border="0" align="absmiddle" /></p>
   </div> <!--end login-->
   <a href="javascript:void(0);" onclick="cklogin();" class="gobutton">登陆</a>
   <div class="error"></div>
 </div>
 <!--end ipt-->
         
</form> 
</div>
<%DBclose()%>
</body>
</html>
