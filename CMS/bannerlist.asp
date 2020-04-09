<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,i,list_id,operate
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
if operate="del" or operate="show" or operate="cancel" then
   list_id=request.Form("list_id")
   if list_id="" then
      alertInfo("你未选中任何项目！")
   else
   select case operate
          
		  case "del"   
			   deleteFile "select * from [banner] where b_id in("&list_id&")","b_pic",""'批量删除图片
               conn.execute "delete from [banner] where b_id in("&list_id&")"
               checkErr "删除","bannerlist.asp"
		  case "show"
		       conn.execute "update [banner] set b_show=true where b_id in("&list_id&")"
			   checkErr "首页显示","bannerlist.asp"
		  case "cancel"
		       conn.execute "update [banner] set b_show=false where b_id in("&list_id&")"
			   checkErr "取消显示","bannerlist.asp"
	
	end select	  
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
<h1>Banner列表</h1>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="list">
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="19%">图片名称</td>
    <td width="24%">缩略图</td>
    <td width="45%">图片描述</td>
    <td width="9%">首页显示</td>
  </tr>
   <%
	sql="select * from [banner] order by b_time desc"
	page 5,sql
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='5'>没有记录</td></tr>")
	end if
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
	%>
  <tr>
    <td height="75"><input type="checkbox" name="list_id" id="list_id" value="<%=rs("b_id")%>" /></td>
    <td height="75"><%=getSubString(rs("b_name"),16)%></td>
    <td height="75"><img  src="..<%=rs("b_pic")%>" width="170" height="70" alt="" /></td>
    <td height="75"><%=getSubString(rs("b_description"),40)%></td>
    <td height="75"><%if rs("b_show")=true then response.Write("显示") else response.Write("不显示") end if%></td>
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
    <li><a href="bannerlist.asp" class="current" >Banner列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li><a href="editbanner.asp" >添加Banner<img src="style/img/add.png" width="60" height="40" /></a> </li>
    <li><a href="#" onclick="checkChecked('list_id','bannerlist.asp','bannerlist.asp?operate=show',2)">首页显示<img src="style/img/show_yes.png" width="60" height="40" /></a> </li>
    <li><a href="#" onclick="checkChecked('list_id','bannerlist.asp','bannerlist.asp?operate=cancel',2)">取消显示<img src="style/img/show_no.png" width="60" height="40" /></a> </li>
   </ul>
</div>



<div class="operate">
<ul>
    <li><a href="#" id="ckall" onclick="ChkAllClick('list_id','ckall')" >全选<img src="style/img/allcheck.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="delChecked('list_id','bannerlist.asp','bannerlist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','bannerlist.asp','editbanner.asp?operate=edit',1)">编辑<img src="style/img/editor.png" width="60" height="40" /></a></li>
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
