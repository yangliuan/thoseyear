<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim operate,list_id,formaction,pagetitle,pageshow,noshow,up_id
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
nameArray=Array("c_id","c_name","c_description","c_pic")
if operate="add" or operate="up" then
   for h=1 to Ubound(nameArray)
       valueArray(h)=safeInstr(request.Form(nameArray(h)))
       if valueArray(h)="" then
	      alertInfo("内容不能为空，请输入齐全")
	   end if
   next
end if   
select case operate
       case ""
	   formaction="editvclass.asp?operate=add"
	   pagetitle="添加"
       case "add"
	   addRecord "select * from [video_class]",nameArray,valueArray
	   checkErr "添加视频专辑","vclasslist.asp"
	   case "edit"
	   list_id=safeRequest(trim(request.Form("list_id")))
	   if list_id="" then
	   alertInfo("你未选中任何项目！")
	   end if
	   formaction="editvclass.asp?operate=up"
	   pagetitle="编辑"
	   editShow "select * from [video_class] where c_id="&list_id,nameArray,valueArray
	  
	   case "up"
	   up_id=safeRequest(trim(request.Form("up_id")))
	   deleteFile "select * from [video_class] where c_id="&up_id,"c_pic",valueArray(3)'如果更换图片则删除原先的图
	   updateRecord "select * from [video_class] where c_id="&up_id,nameArray,valueArray
	   
	   checkErr "编辑视频专辑","vclasslist.asp"
	   
end select
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
imageUrl : K('#c_pic').val(),                                
clickFn : function(txt12, title, width, height, border, align) {                                       
 K('#c_pic').val(txt12);                                       
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
<form name="form" action="<%=formaction%>" method="post">

<div id="iframe-src">
  <h1><%=pagetitle%>视频专辑</h1>
<div id="iframe-src-content">

<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
  <tr>
    <td width="13%">专辑名称：</td>
    <td width="87%"><input name="c_name" type="text" class="textform1" id="c_name" value="<%=valueArray(1)%>" /></td>
    </tr>
  <tr>
    <td>专辑描述：</td>
    <td><input name="c_description" type="text" class="textform1" id="c_description" value="<%=valueArray(2)%>" /></td>
    </tr>
  <tr>
    <td>专辑封面图：</td>
    <td><input name="c_pic" type="text" class="textform1" id="c_pic" value="<%=valueArray(3)%>" />&nbsp;<input name="image" type="button" class="uploadbutton" id="image" value="上传图片"  />
      &nbsp;封面图尺寸：350x300px&nbsp;<input class="uploadbutton" type='button' name='Submit' value='裁剪' onClick="if($('#c_pic').val()==''){alert('请上传图片后再使用此功能');return false;}else{OpenImgCutWindow('',$('#c_pic').val())}"></td>
  </tr>
  <%if valueArray(3)<>"" then
  response.Write("<tr><td>封面图：</td><td><img  src='.."&valueArray(3)&"' width='292' height='250' /></td></tr>")
  end if
  %>
  </table>
<div id="submit-date"><input type="hidden" name="up_id" value="<%=list_id%>" /><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="videolist.asp">视频列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editvideo.asp">添加视频<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="vclasslist.asp">视频专辑<img src="style/img/classlist.png" width="60" height="40" /></a></li>
    <li><a href="editvclass.asp" class="current">添加专辑<img src="style/img/add.png" width="60" height="40" /></a></li>
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
