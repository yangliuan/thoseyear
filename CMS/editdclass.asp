<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim operate,list_id,formaction,pagetitle,pageshow,noshow,up_id
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
nameArray=Array("c_id","c_name","c_page","c_read")
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
	   formaction="editdclass.asp?operate=add"
	   pagetitle="添加"
       case "add"
	   addRecord "select * from [diary_class]",nameArray,valueArray
	   checkErr "添加日记分类","dclasslist.asp"
	   case "edit"
	   list_id=safeRequest(trim(request.Form("list_id")))
	   if list_id="" then
	   alertInfo("你未选中任何项目！")
	   end if
	   formaction="editdclass.asp?operate=up"
	   pagetitle="编辑"
	   editShow "select * from [diary_class] where c_id="&list_id,nameArray,valueArray
	  
	   case "up"
	   up_id=safeRequest(trim(request.Form("up_id")))
	   deleteFile "select * from [diary_class] where c_id="&up_id,"c_page",valueArray(2)'如果更换图片则删除原先的图
	   deleteFile "select * from [diary_class] where c_id="&up_id,"c_read",valueArray(3)'如果更换图片则删除原先的图
	   updateRecord "select * from [diary_class] where c_id="&up_id,nameArray,valueArray
	   
	   checkErr "编辑日记分类","dclasslist.asp"
	   
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
imageUrl : K('#c_page').val(),                                
clickFn : function(txt12, title, width, height, border, align) {                                       
 K('#c_page').val(txt12);                                       
  editor.hideDialog();                                
  } 
  });                
  });        
 });    
  K('#image1').click(function() {               
editor.loadPlugin('image', function() {                        
editor.plugin.imageDialog({ 
showRemote : false,                               
imageUrl : K('#c_read').val(),                                
clickFn : function(txt12, title, width, height, border, align) {                                       
 K('#c_read').val(txt12);                                       
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
  <h1><%=pagetitle%>日记分类</h1>
<div id="iframe-src-content">

<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
  <tr>
    <td width="14%">分类名称：</td>
    <td width="86%"><input name="c_name" type="text" class="textform1" id="c_name" value="<%=valueArray(1)%>" /></td>
    </tr>
  <tr>
    <td>阅读页面背景图：</td>
    <td><input name="c_page" type="text" class="textform1" id="c_page" value="<%=valueArray(2)%>" />&nbsp;<input name="image" type="button" class="uploadbutton" id="image" value="上传图片" />
      &nbsp;背景图尺寸：980x550px&nbsp;<input class="uploadbutton" type='button' name='Submit' value='裁剪' onClick="if($('#c_page').val()==''){alert('请上传图片后再使用此功能');return false;}else{OpenImgCutWindow('',$('#c_page').val())}"></td>
    </tr>
  <tr>
    <td>文字层背景：</td>
    <td><input name="c_read" type="text" class="textform1" id="c_read" value="<%=valueArray(3)%>" />&nbsp;<input name="image1" type="button" class="uploadbutton" id="image1" value="上传图片"  />
      &nbsp;封面图尺寸：10x10px透明png图&nbsp;<input class="uploadbutton" type='button' name='Submit' value='裁剪' onClick="if($('#c_read').val()==''){alert('请上传图片后再使用此功能');return false;}else{OpenImgCutWindow('',$('#c_read').val())}"></td>
  </tr>
  <tr>
    <td colspan="2">说明：通过设置文字层背景和字体颜色，可以使背景图片和字体颜色相同时也能正常阅读</td>
    </tr>
  <%if valueArray(2)<>"" then
  response.Write("<tr><td>页面背景图：</td><td><img  src='.."&valueArray(2)&"' width='445' height='250' /></td></tr>")
  end if
  %>
  </table>
<div id="submit-date"><input type="hidden" name="up_id" value="<%=list_id%>" /><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="diarylist.asp">日记列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editdiary.asp">添加日记<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="dclasslist.asp" class="current">日记分类<img src="style/img/classlist.png" width="60" height="40" /></a></li>
    <li><a href="editdclass.asp" >添加分类<img src="style/img/add.png" width="60" height="40" /></a></li>
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
