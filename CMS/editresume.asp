<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
DBopen("../record/#step.mdb")
nameArray=Array("r_id","r_pic","r_name","r_sex","r_age","r_heigh","r_address","r_specialty","r_graduate","r_tel","r_email","r_qq","r_interest","r_assessment","r_motto","r_education","r_work","r_ability","r_recall")
editShow "select * from [resume] where r_id=23",nameArray,valueArray
if safeInstr(request.QueryString("operate"))="up" then
   for h=1 to Ubound(nameArray)
       valueArray(h)=trim(request.Form(nameArray(h)))
       if valueArray(h)="" then
	      alertInfo("内容不能为空，请输入齐全")
	   end if
   next
    deleteFile "select * from [resume] where r_id=23","r_pic",valueArray(1)
    updateRecord "select * from [resume] where r_id=23",nameArray,valueArray
	 checkErr "个人档案保存","editresume.asp"
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
imageUrl : K('#r_pic').val(),                                
clickFn : function(txt12, title, width, height, border, align) {                                       
 K('#r_pic').val(txt12);                                       
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
<form name="form" action="editresume.asp?operate=up" method="post">
<div id="iframe-src">
<h1>个人档案管理</h1>

<div id="iframe-src-content">
<div id="myresume">
<div class="r_pic"><img src="..<%if valueArray(1)<>"" then response.Write(valueArray(1)) end if%>" width="100" height="85" />
  </div>
  <table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
    <tr>
      <td width="12%">头像：</td>
      <td width="88%"><input name="r_pic" type="text" class="textform1" id="r_pic"  value="<%=valueArray(1)%>"/>&nbsp;<input name="image" type="button" class="uploadbutton" id="image" value="上传头像" />
        &nbsp;头像图片尺寸：100x85px&nbsp;<input class="uploadbutton" type='button' name='Submit' value='裁剪' onClick="if($('#r_pic').val()==''){alert('请上传图片后再使用此功能');return false;}else{OpenImgCutWindow('',$('#r_pic').val())}"></td>
    </tr>
    <tr>
      <td width="12%">姓名：</td>
      <td width="88%"><input name="r_name" type="text" class="textform1" id="r_name"  value="<%=valueArray(2)%>"/> 说明：以下文本域只能输入常用标点符号和文字 </td>
    </tr>
     <tr>
      <td width="12%">性别：</td>
      <td width="88%"><input name="r_sex" type="text" class="textform1" id="r_sex" value="<%=valueArray(3)%>" />&nbsp;不能包含"*","'","&","=","%","<",">","^"</td>
    </tr>
    <tr>
      <td>年龄：</td>
      <td><input name="r_age" type="text" class="textform1" id="r_age" value="<%=valueArray(4)%>"/>"and","or","not","insert","select","update","delete"等特殊字符</td>
    </tr>
    <tr>
      <td>身高：</td>
      <td><input name="r_heigh" type="text" class="textform1" id="r_heigh" value="<%=valueArray(5)%>" /></td>
    </tr>
    <tr>
      <td>居住地：</td>
      <td><input name="r_address" type="text" class="textform1" id="r_address" value="<%=valueArray(6)%>" /></td>
    </tr>
    <tr>
      <td>所学专业：</td>
      <td><input name="r_specialty" type="text" class="textform1" id="r_specialty" value="<%=valueArray(7)%>" /></td>
    </tr>
    <tr>
      <td>毕业院校：</td>
      <td><input name="r_graduate" type="text" class="textform1" id="r_graduate"  value="<%=valueArray(8)%>"/></td>
    </tr>
    <tr>
      <td>联系电话：</td>
      <td><input name="r_tel" type="text" class="textform1" id="r_tel" value="<%=valueArray(9)%>" /></td>
    </tr>
    <tr>
      <td>联系邮箱：</td>
      <td><input name="r_email" type="text" class="textform1" id="r_email" value="<%=valueArray(10)%>" /></td>
    </tr>
    <tr>
      <td>联系qq：</td>
      <td><input name="r_qq" type="text" class="textform1" id="r_qq" value="<%=valueArray(11)%>" />
       </td>
    </tr>
    <tr>
      <td height="90">兴趣爱好:</td>
      <td height="90"><textarea name="r_interest" class="textform2" id="r_interest"><%=valueArray(12)%></textarea></td>
    </tr>
    <tr>
      <td height="90">自我评价：</td>
      <td height="90"><textarea name="r_assessment" class="textform2" id="r_assessment"><%=valueArray(13)%></textarea></td>
    </tr>
    <tr>
      <td height="90">座右铭：</td>
      <td height="90"><textarea name="r_motto" class="textform2" id="r_motto"><%=valueArray(14)%></textarea></td>
    </tr>
    <tr>
      <td height="90">受教育经历：</td>
      <td height="90"><textarea name="r_education" cols="45" rows="5" class="textform2" id="r_education"><%=valueArray(15)%></textarea></td>
    </tr>
    <tr>
      <td height="90">工作经历：</td>
      <td height="90"><textarea name="r_work" cols="45" rows="5" class="textform2" id="r_work"><%=valueArray(16)%></textarea></td>
    </tr>
    <tr>
      <td height="90">擅长技能：</td>
      <td height="90"><textarea name="r_ability" cols="45" rows="5" class="textform2" id="r_ability"><%=valueArray(17)%></textarea></td>
    </tr>
     <tr>
      <td height="90">人生感悟：</td>
      <td height="90"><textarea name="r_recall" cols="45" rows="5" class="textform2" id="r_ability"><%=valueArray(18)%></textarea></td>
    </tr>
  </table>
</div>
<!--end myresume-->
<div id="submit-date"><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下是导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="editresume.asp" class="current">个人档案<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li class="dont">添加<img src="style/img/add.png" width="60" height="40" /></li>
    <li class="dont">分类<img src="style/img/classlist.png" width="60" height="40" /> </li>
    <li class="dont">添加分类<img src="style/img/add.png" width="60" height="40" /> </li>
   </ul>
</div>



<div class="operate">
<ul>
    <li class="dont">全选<img src="style/img/allcheck.png" width="60" height="40" /></li>
    <li class="dont">删除<img src="style/img/del.png" width="60" height="40" /></li>
    <li class="dont">编辑<img src="style/img/editor.png" width="60" height="40" /></li>
    <li><a href="aboutme.asp" target="_blank">查看<img src="style/img/topweb.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->

</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
