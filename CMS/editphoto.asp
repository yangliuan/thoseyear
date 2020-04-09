<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim operate,list_id,formaction,pagetitle,pageshow,noshow,up_id
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
nameArray=Array("p_id","p_aid","p_name","p_big","p_description")
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
	   formaction="editphoto.asp?operate=add"
	   pagetitle="添加"
       
	   case "add"
	   addRecord "select * from [photo]",nameArray,valueArray
	   checkErr "添加照片","photolist.asp"
	   
	   case "edit"
	   list_id=safeRequest(trim(request.Form("list_id")))
	   if list_id="" then
	   alertInfo("你未选中任何项目！")
	   end if
	   formaction="editphoto.asp?operate=up"
	   pagetitle="编辑"
	   editShow "select * from [photo] where p_id="&list_id,nameArray,valueArray
	  
	   case "up"
	   up_id=safeRequest(trim(request.Form("up_id")))
	   deleteFile "select * from [photo] where p_id="&up_id,"p_big",valueArray(3)'如果更换照片图则删除原先的图
	   updateRecord "select * from [photo] where p_id="&up_id,nameArray,valueArray
	   checkErr "编辑照片","photolist.asp"
	   
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
//showRemote : false,//关闭网络图片 
imageUrl : K('#p_big').val(),                                
clickFn : function(txt12, title, width, height, border, align) {                                       
 K('#p_big').val(txt12);                                       
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
  <h1><%=pagetitle%>相片</h1>
<div id="iframe-src-content">

<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
  <tr>
    <td colspan="2">添加相片到：
      <select name="p_aid" class="select" >
        <%
  rs.open "select * from [album] order by a_time desc",conn,1,1
  if rs.bof then
  response.Write("<option value=''>请先添加相册</option>")
  end if
  while not rs.eof 
  %>
        <option value="<%=rs("a_id")%>" <%if valueArray(1)=rs("a_id") then response.Write("selected") end if%>><%=getSubString(rs("a_name"),4)%></option>
        <%
  rs.movenext
  wend
  rs.close
  %>
</select>
      相册</td>
    </tr>
  <tr>
    <td width="17%">相片名称：</td>
    <td width="83%"><input name="p_name" type="text" class="textform1" id="b_name" value="<%=valueArray(2)%>" /></td>
    </tr>
  <tr>
    <td>相片原图：</td>
    <td><input name="p_big" id="p_big" type="text" class="textform1"  value="<%=valueArray(3)%>" />&nbsp;<input name="image" type="button" class="uploadbutton" id="image" value="上传相片"  />&nbsp;<input class="uploadbutton" type='button' name='Submit' value='裁剪' onClick="if($('#p_big').val()==''){alert('请上传图片后再使用此功能');return false;}else{OpenImgCutWindow('',$('#p_big').val())}"></td>
  </tr>
  <tr>
    <td>相片描述：</td>
    <td><input name="p_description" type="text" class="textform1" value="<%=valueArray(4)%>" /></td>
  </tr>
  <%if valueArray(3)<>"" then
  response.Write("<tr><td>缩略图：</td><td><img  src='.."&valueArray(3)&"' width='316' height='170' /></td></tr>")
  end if
  %>
  </table>
<div id="submit-date"><input type="hidden" name="up_id" value="<%=list_id%>" /><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="photolist.asp">相片列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editphoto.asp" class="current">添加相片<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="albumlist.asp">相册列表<img src="style/img/classlist.png" width="60" height="40" /></a></li>
    <li><a href="editalbum.asp">添加相册<img src="style/img/add.png" width="60" height="40" /></a></li>
   </ul>
</div>



<div class="operate">
<ul class="dont">
    <li>全选<img src="style/img/allcheck.png" width="60" height="40" /></li>
    <li>删除<img src="style/img/del.png" width="60" height="40" /></li>
    <li>编辑<img src="style/img/editor.png" width="60" height="40" /></li>
    <li><a href="addphotos.asp">批量添加<img src="style/img/add.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->

</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
