<!--#include file="../config/config.asp"-->
<!--#include file="../config/function.asp"-->
<%
checkLogin("cmslogin.asp")
dim list_id,operate,m_reply,up_id
operate=safeInstr(request.QueryString("operate"))
if operate="" then
response.End()
end if
DBopen("../record/#step.mdb")
nameArray=Array("m_id","m_name","m_contact","m_title","m_content","m_reply","m_check","m_time")
if operate="reply" then
list_id=safeRequest(trim(request.Form("list_id")))
if list_id="" then
alertInfo("你未选中任何项目！")
end if
editShow "select * from [message] where m_id="&list_id,nameArray,valueArray
end if
if operate="up" then
up_id=trim(request.Form("up_id"))
m_reply=trim(request.Form("m_reply"))
if m_reply="" then
   alertInfo("请输入回复内容！")
 else
 rs.open "select * from [message] where m_id="&up_id,conn,1,3
 rs("m_reply")=m_reply
 rs.update
 rs.close
 checkErr "回复留言","messagelist.asp"
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
</head>

<body>
<form name="form" action="replymessage.asp?operate=up" method="post">
<div id="iframe-src">
<h1>回复留言</h1>
<div id="iframe-src-content">
<table border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="2" class="addlist">
  <tr>
    <td width="14%">留言人姓名：</td>
    <td width="86%"><%=valueArray(1)%></td>
  </tr>
  <tr>
    <td>留言人联系方式：</td>
    <td><%=valueArray(2)%></td>
  </tr>
  <tr>
    <td>留言标题：</td>
    <td><%=valueArray(3)%></td>
  </tr>
  <tr>
    <td height="90">留言内容</td>
    <td height="90"><%=valueArray(4)%></td>
  </tr>
    <tr>
    <td>留言时间：</td>
    <td><%=valueArray(7)%></td>
  </tr>
    <tr>
    <td>留言审核：</td>
    <td><%if valueArray(6)=true then response.Write("已审核") else response.Write("未审核") end if%></td>
  </tr>
  <tr>
    <td>回复留言：</td>
    <td height="90"><textarea name="m_reply" cols="45" rows="5" class="textform2" id="m_reply"><%=valueArray(5)%></textarea></td>
  </tr>

</table>
<div id="submit-date"><input name="up_id" type="hidden" value="<%=list_id%>" /><input name="button" type="submit" class="buttonform" value="保存" /></div>
</div>
<!--end-iframe-src-content-->


<!--以下导航和操作栏-->
<div id="left-nav" class="class_nav">
  <ul class="dont">
    <li>列表<img src="style/img/list.png" width="60" height="40" /></li>
    <li>添加<img src="style/img/add.png" width="60" height="40" /> </li>
    <li>分类<img src="style/img/classlist.png" width="60" height="40" /></li>
    <li>添加分类<img src="style/img/add.png" width="60" height="40" /></li>
   </ul>
</div>



<div class="operate">
<ul>
    <li class="dont">全选<img src="style/img/allcheck.png" width="60" height="40" /></li>
    <li class="dont">删除<img src="style/img/del.png" width="60" height="40" /></li>
    <li class="dont">编辑<img src="style/img/editor.png" width="60" height="40" /></li>
    <li class="dont">查看<img src="style/img/topweb.png" width="60" height="40" /></li>
</ul>
</div>
<!--end operate-->

</div>
<!--end iframe-src-->
</form>
<%DBclose()%>
</body>
</html>
