<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim sql,i,list_id,operate
DBopen("../record/#step.mdb")
operate=safeInstr(request.QueryString("operate"))
if operate="del" or operate="check" or operate="cancel" then
   list_id=request.Form("list_id")
   if list_id="" then
      alertInfo("你未选中任何项目！")
   else
   select case operate
          
		  case "del"   
			   conn.execute "delete from [message] where m_id in("&list_id&")"
               checkErr "删除","messagelist.asp"
		  case "check"
		       conn.execute "update [message] set m_check=true where m_id in("&list_id&")"
			   checkErr "审核","messagelist.asp"
		  case "cancel"
		       conn.execute "update [message] set m_check=false where m_id in("&list_id&")"
			   checkErr "取消审核","messagelist.asp"
	
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
<h1>留言列表</h1>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="list">
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="11%">留言人</td>
    <td width="48%">留言标题</td>
    <td width="22%">留言时间</td>
    <td width="8%">审核</td>
    <td width="8%">回复 </td>
    </tr>
   <%
	sql="select * from [message] order by m_time desc"
	page 13,sql
	if rs.eof and rs.bof then
	response.Write("<tr><td colspan='6'>没有记录</td></tr>")
	else
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
	%>
  <tr>
    <td><input type="checkbox" name="list_id" id="list_id" value="<%=rs("m_id")%>" /></td>
    <td><%=rs("m_name")%></td>
    <td><%=rs("m_title")%></td>
    <td><%=FormatTime(rs("m_time"),"yy-mm-dd hh:nn")%></td>
    <td><%if rs("m_check")=true then response.Write("已审核") else response.Write("未审核") end if%></td>
    <td><%if rs("m_reply")<>"" then response.Write("已回复") else response.Write("未回复") end if%></td>
    </tr>
   <%
	rs.movenext
	next
	end if
	%>
</table>




<div id="submit-date"><%writePage(Url_address("page"))%></div>
</div>
<!--end-iframe-src-content-->




<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul>
    <li><a href="messagelist.asp" class="current" >留言列表<img src="style/img/list.png" width="60" height="40" /></a></li>
    <li class="dont">添加<img src="style/img/add.png" width="60" height="40" /></li>
    <li><a href="#" onclick="checkChecked('list_id','messagelist.asp','messagelist.asp?operate=check',2)">审核<img src="style/img/show_yes.png" width="60" height="40" /></a> </li>
    <li><a href="#" onclick="checkChecked('list_id','messagelist.asp','messagelist.asp?operate=cancel',2)">取消审核<img src="style/img/show_no.png" width="60" height="40" /></a> </li>
   </ul>
</div>



<div class="operate">
<ul>
    <li><a href="#" id="ckall" onclick="ChkAllClick('list_id','ckall')" >全选<img src="style/img/allcheck.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="delChecked('list_id','messagelist.asp','messagelist.asp?operate=del')">删除<img src="style/img/del.png" width="60" height="40" /></a></li>
    <li><a href="#" onclick="checkChecked('list_id','messagelist.asp','replymessage.asp?operate=reply',1)">查看并回复<img src="style/img/reply.png" width="60" height="40" /></a></li>
    <li><a href="../contact.asp" target="_blank" >打开留言页<img src="style/img/home_show.png" width="60" height="40" /></a></li>
</ul>
</div>
<!--end operate-->
</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
