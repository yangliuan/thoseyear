<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,i,list_id,operate,album
if request.QueryString("album")="" then
album=0
else
album=safeRequest(int(trim(request.QueryString("album"))))
end if
if album=0 then
session("album")=0
sql="select * from [photo] order by p_time desc"
else
session("album")=album
sql="select * from [photo] where p_aid="&album&" order by p_time desc"
end if
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
if operate="del" then
   list_id=request.Form("list_id")
   if list_id="" then
      alertInfo("你未选中任何项目！")
   else
	  deleteFile "select * from [photo] where p_id in("&list_id&")","p_big",""'批量删除大图
      conn.execute "delete from [photo] where p_id in("&list_id&")"
      checkErr "删除","photolist.asp"	  
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
<h1>照片列表</h1><span class="selectlist">按相册查看：
<select name="select" class="selectstyle"  onchange="javascript:location='photolist.asp?album='+this.value">
  <option value="0" <%if session("album")=0 then response.Write("selected") end if%>>所有相册</option>
  <%
  rs.open "select * from [album] order by a_time desc",conn,1,1
  while not rs.eof
  %>
  <option value="<%=rs("a_id")%>" <%if session("album")=rs("a_id") then response.Write("selected") end if%>><%=getSubString(rs("a_name"),4)%></option>
  <%
  rs.movenext
  wend
  rs.close
  %>
  </select>
</span>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="list">
  <tr>
    <td width="4%">ID</td>
    <td width="29%">图片名称</td>
    <td width="19%">缩略图</td>
    <td width="48%">图片描述</td>
    </tr>
   <%
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
    <td height="75"><input type="checkbox" name="list_id" id="list_id" value="<%=rs("p_id")%>" /></td>
    <td height="75"><%=getSubString(rs("p_name"),25)%></td>
    <td height="75"><img  src="..<%=rs("p_big")%>" width="130" height="70" /></td>
    <td height="75"><%=getSubString(rs("p_description"),48)%></td>
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
    <li><a href="photolist.asp" class="current">照片列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editphoto.asp">添加照片<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="albumlist.asp" >相册列表<img src="style/img/classlist.png" width="60" height="40" /></a></li>
    <li><a href="editalbum.asp" >添加相册<img src="style/img/add.png" width="60" height="40" /></a></li>
   </ul>
</div>



<div class="operate">
<ul>
    <li><a href="#" id="ckall" onclick="ChkAllClick('list_id','ckall')" >全选<img src="style/img/allcheck.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="delChecked('list_id','photolist.asp','photolist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','photolist.asp','editphoto.asp?operate=edit',1)">编辑<img src="style/img/editor.png" width="60" height="40" /></a></li>
    <li><a href="../index.asp" target="_blank" >打开首页<img src="style/img/home_show.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->
</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
