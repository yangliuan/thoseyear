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
   deleteFile "select * from [album] where a_id in("&list_id&")","a_pic",""'批量删除封面图
   deleteFile "select * from [album] where a_id in("&list_id&")","a_bg",""'批量删除背景图
   conn.execute "delete from [album] where a_id in("&list_id&")"
   deleteFile "select * from [photo] where p_aid in("&list_id&")","p_big",""''删除此ID所对应的相册下的所有照片原图
   conn.execute "delete from [photo] where p_aid in("&list_id&")"'删除此ID所对应的相册下所有记录
  
   checkErr "删除","albumlist.asp"
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
<h1>相册列表</h1>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="list">
  <tr>
    <td width="4%">ID</td>
    <td width="30%">相册名称</td>
    <td width="12%">封面图</td>
    <td width="54%">相册描述</td>
    </tr>
   <%
	sql="select * from [album] order by a_time desc"
	page 5,sql
	if rs.bof then
	response.Write("<tr><td colspan='4'>没有记录</td></tr>")
	end if
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
	%>
  <tr>
    <td height="75"><input type="checkbox" name="list_id" id="list_id" value="<%=rs("a_id")%>" /></td>
    <td height="75"><%=getSubString(rs("a_name"),25)%></td>
    <td height="75"><img  src="..<%=rs("a_pic")%>" alt="" width="70" height="70" /></td>
    <td height="75"><%=getSubString(rs("a_description"),48)%></td>
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
    <li><a href="photolist.asp">照片列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editphoto.asp">添加照片<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="albumlist.asp" class="current">相册列表<img src="style/img/classlist.png" width="60" height="40" /></a></li>
    <li><a href="editalbum.asp" >添加相册<img src="style/img/add.png" width="60" height="40" /></a></li>
   </ul>
</div>



<div class="operate">
<ul>
    <li><a href="#" id="ckall" onclick="ChkAllClick('list_id','ckall')" >全选<img src="style/img/allcheck.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="delChecked('list_id','albumlist.asp','albumlist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','albumlist.asp','editalbum.asp?operate=edit',1)">编辑<img src="style/img/editor.png" width="60" height="40" /></a></li>
    <li><a href="../myphoto.asp" target="_blank" >打开相册<img src="style/img/topweb.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->
</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
