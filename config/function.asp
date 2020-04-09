<%
'======================================================
' 系统函数文件
' 请勿修改此文件任何信息,否则由此带来的麻烦请自己解决吧.嘿嘿！
' 请勿删下以下作者信息
' ======================================================




'======================================================
'建立数据库连接
'参数db为数据库路径
'======================================================
dim conn,db,rs
function DBopen(db)
 set conn=server.CreateObject("adodb.connection")
 set rs=server.CreateObject("adodb.recordset")
 conn.open "provider=microsoft.jet.oledb.4.0; data source="&server.MapPath(db)
end function 

'======================================================
'关闭数据库连接,并清空对象
'======================================================
function DBclose()
  set rs=nothing
  conn.close
  set conn=nothing
end function 


'======================================================
'addRecord()添加记录,editShow()显示记录，updateRecord()更新记录
'参数：
'nameArray存放字段名的数组,调用函数前需要将数组赋值字段名
'valueArray存放字段所对应值的数组
'e对应nameArray的下标
'调用例子：nameArray=Array("n","c","t","b","e","f","g","d","s","k")
'addRecord "select * from xx where id=1",nameArray,valueArrkay,9
'======================================================
dim nameArray,h,e,f_sql
dim valueArray(20)
function addRecord(f_sql,nameArray,valueArray)
 rs.open f_sql,conn,1,3
 rs.addnew
 for h=1 to ubound(nameArray)
 rs(nameArray(h))=valueArray(h)
 next
 rs.update
 rs.close
end function

function editShow(f_sql,nameArray,valueArray)
   rs.open f_sql,conn,1,1
   for h=1 to ubound(nameArray)
   valueArray(h)=rs(nameArray(h))
   next
   rs.close
end function

function updateRecord(f_sql,nameArray,valueArray)
   rs.open f_sql,conn,1,3
   for h=1 to ubound(nameArray)
   rs(nameArray(h))=valueArray(h)
   next
   rs.update
   rs.close
end function




'======================================================
'验证是否存在错误，提示信息并跳转到指定地址（用于对数据库操作的验证）
'stg返回的信息
'url跳转的目标地址
'======================================================
function checkErr(stg,url)
 if err.number=0 then
  response.Write("<script language='javascript'>alert('"+stg+"成功');window.location.href='"+url+"'</script>")
  response.end()
  else
  response.Write("<script language='javascript'>alert('"+stg+"失败,"+err.description+"');window.histroy.go(-1);</script>")
  response.End()
 end if
 err.clear
end function



'======================================================
'弹出提示错误信息,并返回
'======================================================
function alertInfo(str)
response.Write("<script language='javascript'>alert('"+str+"');window.history.go(-1)</script>")
response.End()
end function



'======================================================
'验证地址栏id参数是否为数字
'======================================================
function safeRequest(info)
if info<>"" then
  if not isnumeric(info) then
  response.Write("<script language='javascript'>alert('非法参数');history.go(-1);</script>")
  response.end()
  else
  safeRequest=info
  end if
else
  response.Write("<script language='javascript'>alert('非法参数');history.go(-1);</script>")
  response.end()
end if

end function




'======================================================
'检测是否存在特殊字符以及sql语句
'参数str 要检测的字符串
'======================================================
function safeInstr(str)
   dim strNum,strArray,i,str2
    if isnull(str) then
      exit function
    else
	   str2=str'备份要检测的字符串，因为检测过程会将数据更改
       strArray=Array("*","'","&","=","%","<",">","^","and","or","not","insert","select","update","delete")'非法字符
       for i=0 to UBound(strArray)
         strNum=Instr(Lcase(str),strArray(i))'检测字符串中是否存在指定的非法字符
         if strNum>0 then
            response.Write("<script language='javascript'>alert('存在非法字符');history.back();</script>")
            response.End()
		 else
		    str=str
         end if
		next
	safeInstr=str2'检测无非法字符后将原字符串返回	
	end if
end function 



'======================================================
'过滤html.保留<br/>,<p></p>
'======================================================
Function RemoveHTML(strHTML)
	on error resume next
	if inull(strHTML) = "" then
		RemoveHTML = ""
		exit function
	end if
	Dim objRegExp, Match, Matches
	strHTML=Replace(strHTML,"<br/>","{br|}")
	strHTML=Replace(strHTML,"<p>","{p|}")
	strHTML=Replace(strHTML,"</p>","{|p}")
	Set objRegExp = New Regexp
	objRegExp.IgnoreCase = False
	objRegExp.Global = True
	objRegExp.Pattern = "(\<.[^\>]+\>)"
	Set Matches = objRegExp.Execute(strHTML)
	For Each Match in Matches
		strHtml=Replace(strHTML,Match.Value,"")
	Next
    strHTML=Replace(strHTML,"{br|}","<br/>")
	strHTML=Replace(strHTML,"{p|}","<p>")
	strHTML=Replace(strHTML,"{|p}","</p>")
	RemoveHTML=strHTML
	Set objRegExp = Nothing
	if err.number <> 0 then RemoveHTML = ""
End Function


'======================================================
'删除指定文件
'参数sql 查询指定文件的路径的sql语句
'picWord 存储文件路径的字段名称
'srcNow直接删除时为空,修改替换文件时为更改后的文件路径
'======================================================

function deleteFile(sql,picWord,srcNow)
    dim oRs,fs
    set oRs=server.CreateObject("adodb.recordset")
	    oRs.open sql,conn,1,1'查询指定文件路径
		while not oRs.eof 
	    set fs=Server.CreateObject("scripting.FileSystemObject")
	    if oRs(""&picword&"")<>"" and oRs(""&picWord&"")<>srcNow then'如果路径不为空
		   if fs.FileExists(server.MapPath(".."&oRs(""&picword&""))) then'如果文件存在  
              fs.DeleteFile server.MapPath(".."&oRs(""&picword&""))'删除文件
	          '此处路径要根据调用本函数的文件和存储图片的相对位置决定。如：如果上传后返回的路径前不带/在此处要加上
		   end if
		else
		exit function   
		end if
		oRs.movenext
		wend
		oRs.close
    set oRs=nothing
    set fs=nothing
end function

'======================================================
'删除指定的批量文件
'参数sql 查询指定文件的路径的sql语句
'picWord 存储批量文件路径的字段名称,并且路径以","为分隔符
'srcNow直接删除时为空,修改替换文件时为更改后的文件路径
'======================================================

function deleteFiles(sql,picWord,srcNow)
    dim oRs,fs,words,p
    set oRs=server.CreateObject("adodb.recordset")
	    oRs.open sql,conn,1,1'查询指定文件路径
		while not oRs.eof 
	    set fs=Server.CreateObject("scripting.FileSystemObject")
	    if oRs(""&picword&"")<>"" and oRs(""&picWord&"")<>srcNow then'如果路径不为空
		  words=split( oRs(""&picword&""),",")
		  for each p in words
		   if fs.FileExists(server.MapPath(".."&p)) then'如果文件存在  
              fs.DeleteFile server.MapPath(".."&p)'删除文件
	          '此处路径要根据调用本函数的文件和存储图片的相对位置决定。如：如果上传后返回的路径前不带/在此处要加上
		   end if
		  next
		else
		exit function   
		end if
		oRs.movenext
		wend
		oRs.close
    set oRs=nothing
    set fs=nothing
end function
' ==========================================================
' 获取用户来源IP
' ==========================================================
Function UserIP() 
  dim Tempip
  Tempip = Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
  If Tempip = "" Then
    Tempip= Request.ServerVariables("REMOTE_ADDR") 
  End If
  UserIP = Tempip 
End Function 

' ==========================================================
' 获取字符串长度
' ==========================================================
function getStringLen(str)
	on error resume next       
	dim l,c,i,t
	l=len(str)
	t=l
	for i=1 to l
		c=asc(mid(str,i,1))
		if c>=128 or c<0 then t=t+1
	next		
	getStringLen=t	
	if err.number<>0 then err.clear
end function

function getlenstr(str,length)
	if length = 0 then 
		getlenstr = str
		exit function
	else
		getlenstr = getSubString(RemoveHTML(str),Length)
	end if
end function
' ==========================================================
' 截取字符串
' ==========================================================
function getSubString(str,Length)
	on error resume next   
	if Length = 0 then 
		getSubString = ""
		exit function
	end if    
	dim l,c,i,hz,en
	l=len(str)
	if l<length then
		getSubString=str
	else
		hz=0
		en=0
		for i=1 to l
			c=asc(mid(str,i,1))
			if c>=128 or c<0 then 
				hz=hz+1
			else
				en=en+1
			end if
	
			if en\2+hz>=length then
				exit for
			end if
		next		
		getSubString=left(str,i) & "..."
	end if
	if err.number<>0 then err.clear
end function


' ==========================================================
' 获取当前页带参数的地址，可任意调用。
' 参数 parameter 页码参数,地址不返回此参数.以防重复
' ==========================================================
Function Url_address(pagestr)
	Dim uAddress,ItemUrl,Mitem,Get_Url,get_c,getstr,urladdress
	uAddress = CStr(Request.ServerVariables("SCRIPT_NAME"))
	ItemUrl = ""
	If (Request.QueryString <> "") Then
		uAddress = uAddress & "?"
		For Each Mitem In Request.QueryString
			If LCase(MItem) <> LCase(pagestr) then
				ItemUrl = ItemUrl & MItem &"="& trim(Server.URLEncode(Request.QueryString(""&MItem&""))) & "&"
			end if
		Next
	end if
	Get_Url = uAddress & ItemUrl
	if LCase(right(Get_Url,3))<>"asp" then
		Get_Url=left(Get_Url,len(Get_Url)-1)
	end if
	urladdress = Get_Url
	if Instr(urladdress,"?")>0 then
		urladdress=urladdress&"&"
	Else
		urladdress=urladdress&"?"
	end if
	Url_address = urladdress
end function


' ==========================================================
' 一个加密的函数
' ==========================================================
Function EnPas(CodeStr)
	Dim CodeLen,CodeSpace,NewCode,cecr,cecb,cec
	CodeLen = 30
	CodeSpace = CodeLen - Len(CodeStr)
	If Not CodeSpace < 1 Then
		For cecr = 1 To CodeSpace
			CodeStr = CodeStr & Chr(21)
		Next
	End If
	NewCode = 1
	Dim Been
	For cecb = 1 To CodeLen
		Been = CodeLen + Asc(Mid(CodeStr,cecb,1)) * cecb
		NewCode = NewCode * Been
	Next
	CodeStr = NewCode
	NewCode = Empty
	For cec = 1 To Len(CodeStr)
		NewCode = NewCode & CfsCode(Mid(CodeStr,cec,3))
	Next
	For cec = 20 To Len(NewCode) - 18 Step 2
		EnPas = EnPas & Mid(NewCode,cec,1)
	Next
		EnPas = "QY-" & EnPas
End Function
Function CfsCode(Word)
	Dim cc
	For cc = 1 To Len(Word)
		CfsCode = CfsCode & Asc(Mid(Word,cc,1))
	Next
	CfsCode = Hex(CfsCode)
End Function

' ==========================================================
' 获取当前页文件名 不含任何路径哦
' ==========================================================
Function getFileName()
	Dim url
	url = Request.ServerVariables("SCRIPT_NAME")
	if instr(url,"/") > 0 then 
		url = mid(url,InStrRev(url,"/")+1)
	end if
	if instr(url,"?") > 0 then 
		url = mid(url,1,InStrRev(url,"?"))
	end if
	getFileName = url
End Function



' ============================================
' 格式化时间(显示)
' 参数：n_Flag
'	1:"yyyy-mm-dd hh:mm:ss"
'	2:"yyyy-mm-dd"
'	3:"hh:mm:ss"
'	4:"yyyy年mm月dd日"
'	5:"yyyymmdd"
'   6:"mm-dd"
' ============================================
Function Format_Time(s_Time, n_Flag)
	Dim y, m, d, h, mi, s
	Format_Time = ""
	If IsDate(s_Time) = False Then Exit Function
	y = cstr(right("00" & year(s_Time),2))
	m = cstr(right("00" & month(s_Time),2))
	d = cstr(right("00" & day(s_Time),2))
	h = cstr(right("00" & hour(s_Time),2))
	mi = cstr(right("00" & minute(s_Time),2))
	s = cstr(right("00" & second(s_Time),2))

	Select Case n_Flag
	Case 1
		' yyyy-mm-dd hh:mm:ss
		Format_Time = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
	Case 2
		' yyyy-mm-dd
		Format_Time = y & "-" & m & "-" & d
	Case 3
		' hh:mm:ss
		Format_Time = h & ":" & mi & ":" & s
	Case 4
		' yyyy年mm月dd日
		Format_Time = y & "年" & m & "月" & d & "日"
	Case 5
		' yyyymmdd
		Format_Time = y & m & d
	Case 6
		Format_Time = m & "-" & d
	case else
		Format_Time = y & "-" & m & "-" & d
	End Select
End Function
' ======================================================================================
' FormatTime 改进的Time格式化,EF
' s_Time 要格式化的日期
' s_Flag 格式,可以用如 "yyyy-mm-dd" "mm-dd"类似的自定义格式 [yyyy mm dd hh nn ss 年月日时分秒]
' 示例 FormatTime(date(),"yy-mm-dd hh:nn:ss")
' ======================================================================================
function FormatTime(s_Time,s_Flag)
	Dim y, m, d, h, mi, s, ReturnStr
	FormatTime = ""
	If IsDate(s_Time) = False Then Exit Function
	y = year(s_Time)
	m = month(s_Time)
	d = day(s_Time)
	h = hour(s_Time)
	mi = minute(s_Time)
	s = second(s_Time)
	
	ReturnStr = lcase(s_Flag)
	ReturnStr = replace(ReturnStr,"yyyy",y)
	ReturnStr = replace(ReturnStr,"yy",right(y,2))
	ReturnStr = replace(ReturnStr,"mm",right("00" & m,2))
	ReturnStr = replace(ReturnStr,"m",m)
	ReturnStr = replace(ReturnStr,"dd",right("00" & d,2))
	ReturnStr = replace(ReturnStr,"d",d)
	ReturnStr = replace(ReturnStr,"hh",right("00" & h,2))
	ReturnStr = replace(ReturnStr,"h",h)
	ReturnStr = replace(ReturnStr,"nn",right("00" & mi,2))
	ReturnStr = replace(ReturnStr,"n",mi)
	ReturnStr = replace(ReturnStr,"ss",right("00" & s,2))
	ReturnStr = replace(ReturnStr,"s",s)
	FormatTime = ReturnStr
end function

'=========================================================
'查询分页函数（分为两部分）
'设置部分page(pageNum,sql)
'参数pageNum 每页显示的记录条数 ；sql 要查询的sql语句
'输出部分writePage("fileName")
'参数fileName,当前页的url地址（带参数的）
'具体调用方法：
'set rs=server.CreateObject("adodb.recordset")
'call page(pageNum,sql)
'for i=1 to rs.pagesize
'if rs.eof then exit for
'end if
'循环体输入的内容
'rs.movenext 
'next
'call writePage(fileName)
'========================================================= 
dim pre,last,intpage,pageNo'定义全局变量
function page(pageNum,sql) '设置部分
   rs.PageSize = pageNum
   rs.CursorLocation = 3'对应服务器端游标,默认值为3.因此可不设置
   rs.open sql,conn,1,1
   pre = true
   last = true
   pageNo = trim(Request.QueryString("page"))
   'pageNo = Request("page")
   if len(pageNo) = 0 then
      intpage = 1
      pre = false
   else
     if cint(pageNo) =< 1 then
        intpage = 1
        pre = false
     else
       if cint(pageNo) >= rs.PageCount then
          intpage = rs.PageCount
          last = false
       else
          intpage = cint(pageNo)
       end if
     end if
    end if
    if not rs.eof then
       rs.AbsolutePage = intpage
    end if
end function

function writePage(fileName)'输出部分
  on error resume next
   response.Write("<table width='100%' height='25' align='center' cellpadding='0' cellspacing='0'><tr>")
if rs.pagecount > 0 then
   response.Write("<td width='15%' align='left'  height='25'>当前页"&intpage&"/"&rs.PageCount&"</td>")
else
   response.Write("<td width='42%' align='left' height='24'></td>")
end if
   response.Write("<td width='43%' align='right' height='24'>") 
   response.Write("<a href='"&fileName&"page=1'>首页</a>|") 
if pre then
   response.Write("<a href='"&fileName& "page="&intpage -1&"'>上页</a>|")
end if
if last then
   response.Write("<a href='"&fileName&"page="&intpage +1&"'>下页</a>|")
end if
   response.Write("<a href='"& fileName & "page="& rs.PageCount &"'>尾页</a>|&nbsp;转到第")
   response.Write("<select id='zt' name='sel_page' onChange='javascript:location=this.options[this.selectedIndex].value;' style='font-size: 10px'>")

for i = 1 to rs.PageCount
    if i = intpage then
       response.Write("<option value='" &fileName& "page="& i &"'selected>"&i&" </option>")
    else
       response.Write("<option value='"&fileName& "page="& i &"'>"& i &"</option>")
    end if
next
   response.Write("</select> 页</td>")
   response.Write("</tr></table>")
end function 
'======================================================================================
'登陆权限验证
'url,登陆页文件名
'======================================================================================
function checkLogin(url)
 if session("checkLogin")<>true then
  response.Write("<script language='javascript'>alert('你还未登录或者系统超时，请登录');window.location.href='"+url+"';</script>")     
  response.End()
 end if
end function
'=================================================================================================================================
'判断服务器支持的asp组件函数
'obj,为组件名称，ver参数是1.
'=================================================================================================================================
Function Get_ObjInfo(obj, ver)
	On Error Resume Next
	Dim objTest, sTemp
	Set objTest = Server.CreateObject(obj)
	If Err.Number <> 0 Then
		Err.Clear
		Get_ObjInfo = "<font class=red><b>×</b></font>&nbsp;<font class=gray>不支持</font>"
	Else
		sTemp = ""
		If ver = 1 Then
			sTemp = objTest.version
			If IsNull(sTemp) Then sTemp = objTest.about
			sTemp = Replace(sTemp, "Version", "")
			sTemp = "&nbsp;<font class=tims><font class=blue>" & sTemp & "</font></font>"
		End If
		Get_ObjInfo = "<b>√</b>&nbsp;<font class=gray>支持</font>" & sTemp
	End If
	Set objTest = Nothing
	If Err.Number <> 0 Then Err.Clear
End Function

%>