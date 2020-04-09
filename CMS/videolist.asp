<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,i,list_id,operate,vclass
if request.QueryString("album")="" then
vclass=0
else
vclass=safeRequest(int(trim(request.QueryString("vclass"))))
end if
if vclass=0 then
session("vclass")=0
sql="select * from [video] order by v_time desc"
else
session("vclass")=vclass
sql="select * from [video] where v_cid="&video&" order by v_time desc"
end if
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
if operate="del" then
   list_id=request.Form("list_id")
   if list_id="" then
      alertInfo("你未选中任何项目！")
   else
	  deleteFile "select * from [video] where v_id in("&list_id&")","v_pic",""'批量删除大图
      conn.execute "delete from [video] where v_id in("&list_id&")"
      checkErr "删除","videolist.asp"	  
   end if
end if%>
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
<h1>视频列表</h1><span class="selectlist">按视频专辑查看：
<select name="select" class="selectstyle"  onchange="javascript:location='videolist.asp?vclass='+this.value">
  <option value="0" <%if session("vclass")=0 then response.Write("selected") end if%>>所有专辑</option>
  <%
  rs.open "select * from [video_class] order by c_time desc",conn,1,1
  while not rs.eof
  %>
  <option value="<%=rs("c_id")%>" <%if session("vclass")=rs("c_id") then response.Write("selected") end if%>><%=getSubString(rs("c_name"),4)%></option>
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
    <td width="25%">视频名称</td>
    <td width="22%">缩略图</td>
    <td width="49%">视频描述</td>
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
    <td height="75"><input type="checkbox" name="list_id" id="list_id" value="<%=rs("v_id")%>" /></td>
    <td height="75"><%=rs("v_title")%></td>
    <td height="75"><img  src="..<%=rs("v_pic")%>" width="144" height="70" alt="" /></td>
    <td height="75"><%=rs("v_description")%></td>
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
    <li><a href="videolist.asp" class="current" >视频列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editvideo.asp">添加视频<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="vclasslist.asp">视频专辑<img src="style/img/classlist.png" width="60" height="40" /></a></li>
    <li><a href="editvclass.asp">添加专辑<img src="style/img/add.png" width="60" height="40" /></a></li>
   </ul>
</div>



<div class="operate">
<ul>
    <li><a href="#" id="ckall" onclick="ChkAllClick('list_id','ckall')" >全选<img src="style/img/allcheck.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="delChecked('list_id','videolist.asp','videolist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','videolist.asp','editvideo.asp?operate=edit',1)">编辑<img src="style/img/editor.png" width="60" height="40" /></a></li>
    <li><a href="#" >打开视频<img src="style/img/topweb.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->
</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
