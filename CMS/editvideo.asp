<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim operate,list_id,formaction,pagetitle,up_id
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
nameArray=Array("v_id","v_cid","v_title","v_youku_id","v_pic","v_description")
if operate="add" or operate="up" then
   for h=1 to Ubound(nameArray)
       valueArray(h)=safeInstr(trim(request.Form(nameArray(h))))
       if valueArray(h)="" then
	      alertInfo("内容不能为空，请输入齐全")
	   end if
   next
end if   
select case operate
       case ""
	   formaction="editvideo.asp?operate=add"
	   pagetitle="添加"
       case "add"
	   addRecord "select * from [video]",nameArray,valueArray
	   checkErr "添加视频","videolist.asp"
	   case "edit"
	   list_id=safeRequest(trim(request.Form("list_id")))
	   if list_id="" then
	   alertInfo("你未选中任何项目！")
	   end if
	   formaction="editvideo.asp?operate=up"
	   pagetitle="编辑"
	   editShow "select * from [video] where v_id="&list_id,nameArray,valueArray
	  
	   case "up"
	   up_id=safeRequest(trim(request.Form("up_id")))
	   deleteFile "select * from [video] where v_id="&up_id,"v_pic",valueArray(4)'如果更换图片则删除原先的图
	   updateRecord "select * from [video] where v_id="&up_id,nameArray,valueArray
	   checkErr "编辑视频","videolist.asp"
	   
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
imageUrl : K('#v_pic').val(),                                
clickFn : function(txt12, title, width, height, border, align) {                                       
 K('#v_pic').val(txt12);                                       
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
<form name="form" action="<%=formAction%>" method="post">
<div id="iframe-src">
<h1><%=pagetitle%>优酷视频</h1>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
  
  <tr>
      <td colspan="2">添加视频到：
 <select name="v_cid" class="select" >
        <%rs.open "select * from [video_class]",conn,1,1
          if rs.bof then
          response.Write("<option value=''>请先添加视频专辑</option>")
          end if
         while not rs.eof 
        %>
<option value="<%=rs("c_id")%>"<%if valueArray(1)=rs("c_id") then response.Write("selected") end if%>><%=rs("c_name")%></option>
        <%
         rs.movenext
            wend
         rs.close
       %>
</select>专辑</td>
      </tr>
  <tr>
    <td width="16%">视频标题：</td>
    <td width="84%"><input name="v_title" type="text" class="textform1" id="v_title" value="<%=valueArray(2)%>" /></td>
    </tr>
  <tr>
    <td>优酷ID编码：</td>
    <td><input name="v_youku_id" type="text" class="textform1" id="v_youku_id" value="<%=valueArray(3)%>"/></td>
    </tr>
    <tr>
    <td>视频缩略图：</td>
    <td><input name="v_pic" type="text" class="textform1" id="v_pic" value="<%=valueArray(4)%>"/>&nbsp;<input name="image" type="button" class="uploadbutton" id="image" value="上传图片"/>
      &nbsp;缩略图尺寸：427x207像素&nbsp;<input class="uploadbutton" type='button' name='Submit' value='裁剪' onClick="if($('#v_pic').val()==''){alert('请上传图片后再使用此功能');return false;}else{OpenImgCutWindow('',$('#v_pic').val())}"></td>
  </tr>
  <tr>
    <td>视频描述：</td>
    <td><input name="v_description" type="text" class="textform1" id="v_description" value="<%=valueArray(5)%>"/></td>
  </tr>
  <%if valueArray(4)<>"" then
  response.Write("<tr><td>封面图：</td><td><img  src='.."&valueArray(4)&"' width='427' height='207' /></td></tr>")
  end if
  %>
  </table>


<div id="submit-date"><input name="up_id" type="hidden" value="<%=list_id%>" /><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="videolist.asp" >视频列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editvideo.asp" class="current">添加视频<img src="style/img/add.png" width="60" height="40" /></a> </li>
     <li><a href="vclasslist.asp">视频专辑<img src="style/img/classlist.png" width="60" height="40" /></a></li>
    <li><a href="editvclass.asp" >添加专辑<img src="style/img/add.png" width="60" height="40" /></a></li>
   </ul>
</div>



<div class="operate">
<ul>
    <li class="dont">全选<img src="style/img/allcheck.png" width="60" height="40" /></li>
    <li class="dont">删除<img src="style/img/del.png" width="60" height="40" /></li>
    <li class="dont">编辑<img src="style/img/editor.png" width="60" height="40" /></li>
    <li class="dont">查看<img src="style/img/topweb.png" width="60" height="40" /></li>
</ul>
</div>
<!--end operate-->

</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
