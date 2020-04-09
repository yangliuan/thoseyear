<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
DBopen("../record/#step.mdb")
nameArray=Array("config_id","web_name","web_title","web_logo","web_url","web_keywords","web_description","web_tcp","web_address","web_tel","web_email","web_qq","web_message")
editShow "select * from [system_config] where config_id=90511",nameArray,valueArray
if safeInstr(request.QueryString("operate"))="up" then
   for h=1 to Ubound(nameArray)
       valueArray(h)=safeInstr(request.Form(nameArray(h)))
       if valueArray(h)="" then
	      alertInfo("内容不能为空，请输入齐全")
	   end if
   next
    deleteFile "select * from [system_config] where config_id=90511","web_logo",valueArray(3)
    updateRecord "select * from [system_config] where config_id=90511",nameArray,valueArray
	 checkErr "网站设置","systemconfig.asp"
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
@import url("style/css/skin.css");
</style>
<link rel="stylesheet" href="../Editor/themes/default/default.css" />
<script language="javascript" type="text/javascript" src="../Editor/kindeditor.js"></script>
<script language="javascript" type="text/javascript" src="../Editor/lang/zh_CN.js"></script>
<script language="javascript" type="text/javascript">
KindEditor.ready(function(K) {       
 var editor = K.editor({                                                         
 uploadJson : '../Editor/upload_json.asp',        
 //指定上传文件的服务器端程序        
 fileManagerJson : '../Editor/file_manager_json.asp',       
  //指定浏览远程图片的服务器端        
  allowFileManager : true        
  });        
K('#image').click(function() {               
editor.loadPlugin('image', function() {                        
editor.plugin.imageDialog({
showRemote : false,//关闭网络图片                                
imageUrl : K('#web_logo').val(),                                
clickFn : function(txt12, title, width, height, border, align) {                                       
 K('#web_logo').val(txt12);                                       
  editor.hideDialog();                              
  } 
  });                
  });        
 });    

});</script>  
<script language="javascript" type="text/javascript" src="../script/common.js"></script>
<script language="javascript" type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
</head>

<body>
<form name="form" action="systemconfig.asp?operate=up" method="post">
<div id="iframe-src">
<h1>网站设置</h1>

<div id="iframe-src-content">
  <table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
    <tr>
      <td width="19%">网站名称：</td>
      <td width="81%"><input name="web_name" type="text" class="textform1" id="web_name"  value="<%=valueArray(1)%>"/></td>
    </tr>
     <tr>
      <td width="19%">网站标题：</td>
      <td width="81%"><input name="web_title" type="text" class="textform1" id="web_title" value="<%=valueArray(2)%>"/> 
      例：关键词1_关键词2_关键词3-公司名称</td>
    </tr>
    <tr>
      <td>网站LOGO：</td>
      <td><input name="web_logo" type="text" class="textform1" id="web_logo" value="<%=valueArray(3)%>"/>
        <input name="image" type="button" class="uploadbutton" id="image" value="上传LOGO" />&nbsp;LOGO图片尺寸：200x100px&nbsp;<input class="uploadbutton" type='button' name='Submit' value='裁剪' onClick="if($('#web_logo').val()==''){alert('请上传图片后再使用此功能');return false;}else{OpenImgCutWindow('',$('#web_logo').val())}"></td>
    </tr>
    <tr>
      <td>网站域名：</td>
      <td><input name="web_url" type="text" class="textform1" id="web_url" value="<%=valueArray(4)%>" />
        例：网络：http://www.fycd.com/ 或本地：http://127.0.0.1</td>
    </tr>
    <tr>
      <td>网站关键字：</td>
      <td><input name="web_keywords" type="text" class="textform1" id="web_keywords" value="<%=valueArray(5)%>" /> 
      例：关键词1，关键词2，关键词3</td>
    </tr>
    <tr>
      <td>网站描述：</td>
      <td><input name="web_description" type="text" class="textform1" id="web_description" value="<%=valueArray(6)%>" /></td>
    </tr>
    <tr>
      <td>网站备案号：</td>
      <td><input name="web_tcp" type="text" class="textform1" id="web_tcp"  value="<%=valueArray(7)%>"/></td>
    </tr>
    <tr>
      <td>联系地址：</td>
      <td><input name="web_address" type="text" class="textform1" id="web_address" value="<%=valueArray(8)%>" /></td>
    </tr>
    <tr>
      <td>联系电话：</td>
      <td><input name="web_tel" type="text" class="textform1" id="web_tel" value="<%=valueArray(9)%>" /></td>
    </tr>
    <tr>
      <td>联系邮箱：</td>
      <td><input name="web_email" type="text" class="textform1" id="web_email" value="<%=valueArray(10)%>" /></td>
    </tr>
    <tr>
      <td>联系qq:</td>
      <td><input name="web_qq" type="text" class="textform1" id="web_qq"  value="<%=valueArray(11)%>"/></td>
    </tr>
    <tr>
      <td>留言审核：</td>
      <td><input type="radio" name="web_message"  value="true" <%if valueArray(12)=true then response.Write("checked") end if%>/>需要审核
        
          <input type="radio" name="web_message"  value="false" <%if valueArray(12)=false then response.Write("checked") end if%>/>不需要审核
        </td>
    </tr>
  </table>
<div id="submit-date"><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下是导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="systeminfo.asp"  >系统信息<img src="style/img/info.png" width="60" height="40" /></a></li>
    <li><a href="systemconfig.asp"  class="current">网站设置<img src="style/img/config.png" width="60" height="40" /></a> </li>
    <li><a href="adminuser.asp" >用户管理<img src="style/img/admin.png" width="60" height="40" /></a> </li>
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
</form>
<%DBclose()%>
</body>
</html>
