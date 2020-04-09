<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,i,list_id,operate
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
if operate="del" then
   list_id=request.Form("list_id")
   if list_id="" then
      alertInfo("你未选中任何项目！")
   else
   deleteFile "select * from [diary_class] where c_id in("&list_id&")","c_page",""'批量删除图片
   deleteFile "select * from [diary_class] where c_id in("&list_id&")","c_read",""'批量删除图片
   conn.execute "delete from [diary_class] where c_id in("&list_id&")"
   
   deleteFiles "select * from [diary] where d_cid in("&list_id&")","d_pic",""'删除此ID所对应的日记分类下日记的所有图片
   conn.execute "delete from [diary] where d_cid in("&list_id&")"'删除此ID所对应的日记分类下所有日记
  
   checkErr "删除","dclasslist.asp"
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
<script language="javascript" type="text/javascript" src="../script/function.js" ></script>
</head>

<body>
<form name="formList" action="" method="post">
<div id="iframe-src">
<h1>日记分类列表</h1>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="list">
  <tr>
    <td width="4%">ID</td>
    <td width="47%">分类名称</td>
    <td width="27%">页面背景图</td>
    <td width="22%">文字层背景</td>
    </tr>
   <%
	sql="select * from [diary_class] order by c_time desc"
	page 5,sql
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='4'>没有记录</td></tr>")
	end if
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
	%>
  <tr>
    <td height="75"><input type="checkbox" name="list_id" id="list_id" value="<%=rs("c_id")%>" /></td>
    <td height="75"><%=getSubString(rs("c_name"),42)%></td>
    <td height="75"><img  src="..<%=rs("c_page")%>" width="125" height="70" /></td>
    <td height="75"><img  src="..<%=rs("c_read")%>" width="70" height="70" /></td>
    </tr>
   <%
	rs.movenext
	next
	%>
</table>




<div id="submit-date"><%writePage(Url_address("page"))%></div>
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
<ul>
    <li><a href="#" id="ckall" onclick="ChkAllClick('list_id','ckall')" >全选<img src="style/img/allcheck.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="delChecked('list_id','dclasslist.asp','dclasslist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','dclasslist.asp','editdclass.asp?operate=edit',1)">编辑<img src="style/img/editor.png" width="60" height="40" /></a></li>
    <li><a href="../mydiary.asp" target="_blank" >打开日记<img src="style/img/topweb.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->
</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
