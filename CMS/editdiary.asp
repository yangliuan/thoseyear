<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim operate,list_id,formaction,pagetitle,pageshow,noshow,up_id
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
nameArray=Array("d_id","d_cid","d_title","d_tfont","d_tcolor","d_tsize","d_keywords","d_author","d_src","d_pic","content")
if operate="add" or operate="up" then
   for h=1 to Ubound(nameArray)
       valueArray(h)=trim(request.Form(nameArray(h)))
       if valueArray(h)="" then
	      alertInfo("内容不能为空，请输入齐全")
	   end if
   next
end if   
select case operate
       case ""
	   formaction="editdiary.asp?operate=add"
	   pagetitle="添加"
       
	   case "add"
	   addRecord "select * from [diary]",nameArray,valueArray
	   checkErr "添加日记","diarylist.asp"
	   
	   case "edit"
	   list_id=safeRequest(trim(request.Form("list_id")))
	   if list_id="" then
	   alertInfo("你未选中任何项目！")
	   end if
	   formaction="editdiary.asp?operate=up"
	   pagetitle="编辑"
	   editShow "select * from [diary] where d_id="&list_id,nameArray,valueArray
	  
	   case "up"
	   up_id=safeRequest(trim(request.Form("up_id")))
	   deleteFiles "select * from [diary] where d_id="&up_id,"d_pic",valueArray(9)'如果更日记图则删除原先的所有图
	
	   updateRecord "select * from [diary] where d_id="&up_id,nameArray,valueArray
	   checkErr "编辑日记","diarylist.asp"
	   
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
<script language="javascript" type="text/javascript" src="AienUpload/init.js"></script>
<script charset="utf-8" src="../Editor/kindeditor.js"></script>
<script charset="utf-8" src="../Editor/lang/zh_CN.js"></script>
<script charset="utf-8" src="../Editor/plugins/code/prettify.js"></script>
<script>
		KindEditor.ready(function(K) {
			var editor = K.create('textarea[name="content"]', {
				cssPath : '../Editor/plugins/code/prettify.css',
				uploadJson : '../Editor/upload_json.asp',
				fileManagerJson : '../Editor/file_manager_json.asp',
				allowFileManager : true,
				afterBlur : function() {
				this.sync();
				K.ctrl(document, 13, function() {
				K('form[name=editForm]')[0].submit();
				});
				K.ctrl(this.edit.doc, 13, function() {
				K('form[name=editForm]')[0].submit();
				});
				}
				});
			 prettyPrint();
              K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var arr=new Array();
								K.each(urlList, function(i, data) {
									arr[i]=data.url.replace("/Editor/..","")//替换掉多余部分，保留存储图片的相对路径
								});
								
								 K('#d_pic').val(arr.join(','));
								editor.hideDialog();
							}
						});
					});
				});	
				var colorpicker;
				K('#colorpicker').bind('click', function(e) {
					e.stopPropagation();
					if (colorpicker) {
						colorpicker.remove();
						colorpicker = null;
						return;
					}
					var colorpickerPos = K('#colorpicker').pos();
					colorpicker = K.colorpicker({
						x : colorpickerPos.x,
						y : colorpickerPos.y + K('#colorpicker').height(),
						z : 19811214,
						selectedColor : 'default',
						noColor : '无颜色',
						click : function(color) {
							K('#color').val(color);
							colorpicker.remove();
							colorpicker = null;
						}
					});
				});
				K(document).click(function() {
					if (colorpicker) {
						colorpicker.remove();
						colorpicker = null;
					}
				});
		        });

</script>

</head>

<body>
<form name="editForm" action="<%=formaction%>" method="post">

<div id="iframe-src">
  <h1><%=pagetitle%>日记</h1>
<div id="iframe-src-content">
<div id="myresume">
  <table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
    <tr>
      <td colspan="2">添加日记到：
 <select name="d_cid" class="select" >
        <%rs.open "select * from [diary_class]",conn,1,1
          if rs.bof then
          response.Write("<option value=''>请先添加日记分类</option>")
          end if
         while not rs.eof 
        %>
<option value="<%=rs("c_id")%>"<%if valueArray(1)=rs("c_id") then response.Write("selected") end if%>><%=rs("c_name")%></option>
        <%
         rs.movenext
            wend
         rs.close
       %>
</select>分类</td>
      </tr>
    <tr>
      <td width="10%">标题：</td>
      <td width="90%"><input name="d_title" type="text" class="textform1" id="d_title" value="<%=valueArray(2)%>" />
        
          <select name="d_tfont" id="d_tfont">
          <option value="" >标题字体</option>
          <option value="宋体" <%if valueArray(3)="宋体" then response.Write("selected") end if%>>宋体</option>
          <option value="黑体" <%if valueArray(3)="黑体" then response.Write("selected") end if%>>黑体</option>
          <option value="微软雅黑" <%if valueArray(3)="微软雅黑" then response.Write("selected") end if%>>微软雅黑</option>
         </select>
     
       <select name="d_tsize" id="d_tsize">
        <option value="">标题字号</option>
        <option value="9" <%if valueArray(5)="9" then response.Write("selected") end if%>>9px</option>
        <option value="10" <%if valueArray(5)="10" then response.Write("selected") end if%>>10px</option>
        <option value="12" <%if valueArray(5)="12" then response.Write("selected") end if%>>12px</option>
        <option value="14" <%if valueArray(5)="14" then response.Write("selected") end if%>>14px</option>
        <option value="16" <%if valueArray(5)="16" then response.Write("selected") end if%>>16px</option>
        <option value="18" <%if valueArray(5)="18" then response.Write("selected") end if%>>18px</option>
        <option value="24" <%if valueArray(5)="24" then response.Write("selected") end if%>>24px</option>
        <option value="32" <%if valueArray(5)="32" then response.Write("selected") end if%>>32px</option>
        </select>
        <input name="d_tcolor" type="text" class="colortxt" id="color" value="<%=valueArray(4)%>" /> <input type="button" class="uploadbutton" id="colorpicker" value="标题颜色" />
        
        </td>
    </tr>
    <tr>
      <td>关键字：</td>
      <td><input name="d_keywords" type="text" class="textform1" id="d_keywords" value="<%=valueArray(6)%>" /></td>
    </tr>
    <tr>
      <td>作者：</td>
      <td><input name="d_author" type="text" class="textform1" id="d_author" value="<%=valueArray(7)%>"/></td>
    </tr>
    <tr>
      <td>来源：</td>
      <td><input name="d_src" type="text" class="textform1" id="d_src" value="<%=valueArray(8)%>"/>
        <input name="button2" type="button" class="uploadbutton" id="button" value="本站" onclick="d_src.value='本站'" />
        <input name="button3" type="button" class="uploadbutton" id="button2" value="转载" onclick="d_src.value='转载'" /></td>
    </tr>
    <tr>
      <td>图片：</td>
      <td><textarea name="d_pic" class="diarytext" id="d_pic"><%=valueArray(9)%></textarea>
        <input name="J_selectImage" type="button" class="uploadbutton" id="J_selectImage" value="上传图片" />不需要添加图片时，请输入0</td>
    </tr>
    <tr>
      <td colspan="2">操作说明：<br/>1.上传图片：依次点击上传图片——>添加图片——>开始上传——>（进度条停止后)全部插入。<br/>2.上传图片后，点击编辑器的图片按钮——>网络图片——>图片空间，然后选择要插入的图片；如果需要插入网络图片，请在网络图片——>图片地址框中输入地址。例：http://www.xxx.com/sss/1.jpg<br/>3.请不要使用编辑器中的上传图片功能，因为无法保存图片路径。这样无法删除不需要的图片，从而浪费服务器存储空间后。<br/>4.更换片图时要先把不需要的图片路径删除，再上传新图片。<br/></td>
      </tr>
    <tr>
      <td colspan="2">内容：</td>
      </tr>
    <tr>
      <td height="300" colspan="2"><textarea name="content" style="width:100%; height:300px;visibility:hidden;"><%=valueArray(10)%></textarea></td>
      </tr>
    </table>
</div>
<!--end myresume-->
<div id="submit-date"><input type="hidden" name="up_id" value="<%=list_id%>" /><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="diarylist.asp">日记列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editdiary.asp" class="current">添加日记<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="dclasslist.asp" >日记分类<img src="style/img/classlist.png" width="60" height="40" /></a></li>
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
