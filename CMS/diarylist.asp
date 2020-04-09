<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,i,list_id,operate,dclass
if request.QueryString("dclass")="" then
dclass=0
else
dclass=safeRequest(int(trim(request.QueryString("dclass"))))
end if
if dclass=0 then
session("dclass")=0
sql="select * from [diary] order by d_time desc"
else
session("dclass")=dclass
sql="select * from [diary] where d_cid="&dclass&" order by d_time desc"
end if
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
if operate="del" or operate="top" then
   list_id=request.Form("list_id")
   if list_id="" then
      alertInfo("你未选中任何项目！")
   end if
    if operate="del" then
      deleteFiles "select * from [diary] where d_id in("&list_id&")","d_pic",""'删除此条新闻的所有图片
      conn.execute "delete from [diary] where d_id in("&list_id&")"
      checkErr "删除","diarylist.asp"	  
   end if
   if operate="top" then
     conn.execute "update [diary] set d_read=false"
	 conn.execute "update [diary] set d_read=true where d_id="&list_id
	 checkErr "置顶","diarylist.asp"
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
<form action="" method="post" enctype="application/x-www-form-urlencoded" name="formList">
<div id="iframe-src">
<h1>日记列表</h1><span class="selectlist">按分类查看：
<select name="select" class="selectstyle"  onchange="javascript:location='diarylist.asp?dclass='+this.value">
  <option value="0" <%if session("dclass")=0 then response.Write("selected") end if%>>所有分类</option>
  <%
  rs.open "select * from [diary_class]",conn,1,1
  while not rs.eof
  %>
  <option value="<%=rs("c_id")%>" <%if session("dclass")=rs("c_id") then response.Write("selected") end if%>><%=rs("c_name")%></option>
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
    <td width="3%">ID</td>
    <td width="56%">日记标题</td>
    <td width="13%">作者</td>
    <td width="22%">发表时间</td>
    <td width="6%">置顶</td>
    </tr>
   <%
    page 13,sql
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='4'>没有记录</td></tr>")
	end if
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
	%>
  <tr>
    <td><input type="checkbox" name="list_id" id="list_id" value="<%=rs("d_id")%>" /></td>
    <td><%=getSubString(rs("d_title"),10)%></td>
    <td><%=getSubString(rs("d_author"),3)%></td>
    <td><%=FormatTime(rs("d_time"),"yy-mm-dd hh:nn:ss")%></td>
    <td><%if rs("d_read")=true then response.Write("是") else response.Write("否") end if%></td>
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
    <li><a href="#" onclick="delChecked('list_id','diarylist.asp','diarylist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','diarylist.asp','editdiary.asp?operate=edit',1)">编辑<img src="style/img/editor.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','diarylist.asp','diarylist.asp?operate=top',1)">置顶<img src="style/img/home_show.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->
</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
