<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim operate,pic,p_big,p,p_name,p_aid
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
if operate="adds" then
pic=trim(request.Form("pic"))
p_aid=trim(request.Form("p_aid"))
if p_aid="" then
alertInfo("请选择相册")
else if pic="" then
alertInfo("请上传照片")
else
rs.open "select * from photo",conn,1,3
p_big=split(pic,",")
for each p in p_big
rs.addnew
rs("p_aid")=p_aid
rs("p_name")="未编辑"
rs("p_big")=p
rs("p_description")="无描述"
rs.update
next
rs.close
checkErr "批量添加照片","photolist.asp"
end if	   
end if
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
K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var arr=new Array();
								K.each(urlList, function(i, data) {
									arr[i]=data.url.replace("/Editor/..","")//替换掉多余部分，保留存储图片的相对路径
								});
								
								 K('#pic').val(arr.join(','));
								editor.hideDialog();
							}
						});
					});
				});	
});</script>   
</head>

<body>
<form action="addphotos.asp?operate=adds" method="post" name="form">

<div id="iframe-src">
  <h1>批量添加照片</h1>
<div id="iframe-src-content">

<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
  <tr>
    <td colspan="2">添加照片到：
      <select name="p_aid" class="select" >
        <%
  rs.open "select * from [album] order by a_time desc",conn,1,1
  if rs.bof then
  response.Write("<option value=''>请先添加相册</option>")
  end if
  while not rs.eof 
  %>
        <option value="<%=rs("a_id")%>"><%=getSubString(rs("a_name"),4)%></option>
        <%
  rs.movenext
  wend
  rs.close
  %>
</select>
      相册</td>
    </tr>
  <tr>
    <td width="17%">照片原图：</td>
    <td width="83%"><textarea name="pic" class="textform2" id="pic"></textarea><br/>照片尺寸：无限制</td>
  </tr>
  <tr>
    <td height="30" colspan="2" align="center"><input name="J_selectImage" type="button" class="uploadbutton" id="J_selectImage" value="批量上传照片"/></td>
    </tr>
</table>
<div id="submit-date"><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="photolist.asp">照片列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editphoto.asp" class="current">添加照片<img src="style/img/add.png" width="60" height="40" /></a> </li>
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
