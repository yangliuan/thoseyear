<%
'=================================================================================================================================
'前端配置文件
'=================================================================================================================================
'=================================================================================================================================
'网站信息
sub config()
nameArray=Array("config_id","web_name","web_title","web_logo","web_url","web_keywords","web_description","web_tcp","web_address","web_tel","web_email","web_qq","web_message")
editShow "select * from [system_config] where config_id=90511",nameArray,valueArray
end sub

'=================================================================================================================================
'banner显示
sub showBanner()
 rs.open "select top 5 * from [banner] where b_show=true order by b_time desc",conn,1,1
  if rs.bof then
  response.Write("<li><img class='cubeRandom' src='images/nobanner.gif'/></li>")
  else 
   while not rs.eof
     response.Write("<li><img alt='"&rs("b_description")&"' class='cubeRandom' src='"&rs("b_pic")&"'/></li>")
     rs.movenext
   wend
  end if                 
rs.close
end sub


'=================================================================================================================================
'最新日记列表
sub showIndexDiary()
rs.open "select top 5 * from [diary] order by d_time desc",conn,1,1
if rs.eof then
response.Write("<a href='#'><li>数据库中没有记录<span></span></li></a>")
else
 while not rs.eof 
  response.Write("<a href='readdiary.asp?operate=read&id="&rs("d_id")&"' target='_blank'><li>"&getSubString(rs("d_title"),10)&"<span> "&FormatTime(rs("d_time"),"yyyy-mm-dd")&"</span></li></a>") 
  rs.movenext
 wend
 end if
 rs.close 
end sub
'=================================================================================================================================
'最新照片列表
sub showIndexPhoto()
rs.open "select top 5 * from [photo] order by p_time desc",conn,1,1
if rs.eof then
response.Write("<li><img src='images/nophoto.gif' width='316' height='170'/></li>")
else
 while not rs.eof 
  response.Write("<li><a href='"&rs("p_big")&"' rel='single'  class='pirobox' title='"&rs("p_description")&"' style='margin:0 10px 0 0;'><img src='"&rs("p_big")&"' width='316' height='170'/></a></li>") 
  rs.movenext
 wend
 end if
 rs.close 
end sub


'=================================================================================================================================
'那些年的我
dim r_value(20)
sub showAboutMe()
dim r_name
r_name=Array("r_id","r_pic","r_name","r_sex","r_age","r_heigh","r_address","r_specialty","r_graduate","r_tel","r_email","r_qq","r_interest","r_assessment","r_motto","r_education","r_work","r_ability","r_recall")
   rs.open "select * from [resume] where r_id=23",conn,1,1
   for h=1 to ubound(r_name)
   r_value(h)=rs(r_name(h))
   next
   rs.close
end sub

'=================================================================================================================================
'mydiary页显示
'================================================================================================================================
 sub dclassList()'日记分类列表    
	 rs. open "select * from [diary_class]",conn,1,1
	 if rs.bof then
	 response.Write("<li class='TabbedPanelsTab' tabindex='0'>没有添加日记分类</li>")
	 else
	 while not rs.eof
	 response.Write("<li class='TabbedPanelsTab' tabindex='0'>"&getSubString(rs("c_name"),5)&"</li>")
	 rs.movenext
	 wend
	 end if
	rs.close
end sub 

sub diaryAll()'所有日记
    rs.open "select * from [diary] order by d_time desc",conn,1,1
    if rs.bof then
	response.Write("<li>没有日记</li>")
	else
	while not rs.eof
	response.Write("<a href='readdiary.asp?operate=read&id="&rs("d_id")&"'><li>"&getSubString(rs("d_title"),20)&"<span class='date'>"&FormatTime(rs("d_time"),"yyyy-mm-dd")&"</span></li></a>")
    rs.movenext
    wend
	end if
	rs.close
end sub

sub diaryList()'根据分类顺序显示日记列表
 dim ds
 set ds=server.CreateObject("adodb.recordset") 
 ds.open "select * from [diary_class]",conn,1,1
    while not ds.eof'外部循环开始
	response.Write("<div class='TabbedPanelsContent'><ul class='rjlist'>")
	rs.open "select * from [diary] where d_cid="&ds("c_id")&" order by d_time desc",conn,1,1
	if rs.bof then
	response.Write("<li>没有日记</li>")
	else
    do while not rs.eof
    response.Write("<a href='readdiary.asp?operate=read&id="&rs("d_id")&"'><li>"&getSubString(rs("d_title"),20)&"<span class='date'>"&FormatTime(rs("d_time"),"yyyy-mm-dd")&"</span></li></a>")
    rs.movenext
    loop'内部循环结束
	end if
	rs.close
	response.Write("</ul></div>")
	ds.movenext
	wend'外部循环结束
	ds.close
end sub

sub readTop()'推荐阅读
    rs.open "select top 1 * from [diary] where d_read=true",conn,1,1
	response.Write("<b>"&getSubString(rs("d_title"),8)&"</b>")
	response.Write("<p><a href='readdiary.asp?operate=read&id="&rs("d_id")&"' class='readme' target='_blank'>READ ME</a></p>" )
	response.Write(rs("content"))
	rs.close
end sub


'=================================================================================================================================
'日记阅读页
'=================================================================================================================================

sub readDiary()'日记内容
dim diaryName 
diaryName=Array("d_id","d_cid","d_title","d_tfont","d_tcolor","d_tsize","d_keywords","d_author","d_src","d_pic","content","d_time")
   rs.open "select * from [diary] where d_id="&id,conn,1,1
   for h=1 to ubound(diaryName)
   diaryValue(h)=rs(diaryName(h))
   next
   rs.close
end sub

sub readDclass()'日记分类信息
dim dclassName 
dclassName=array("c_id","c_name","c_page","c_read")
rs.open "select * from [diary_class] where c_id="&diaryValue(1),conn,1,1
   for h=1 to ubound(dclassName)
   dclassValue(h)=rs(dclassName(h))
   next
rs.close
end sub

sub proRead()'上一篇
rs.open "select top 1 d_id,d_title from [diary] where d_cid="&diaryValue(1)&" and d_id<"&id&" order by d_id desc",conn,1,1
if rs.bof then
response.Write "<a>此分类中已经没有日记了</a>"
else
response.Write "<a href='readdiary.asp?operate=read&id="&rs("d_id")&"' target='_self'>"&getSubString(rs("d_title"),9)&"</a>"
end if
rs.close
end sub

sub nextRead()'下一篇
rs.open "select top 1 d_id,d_title from [diary] where d_cid="&diaryValue(1)&" and d_id>"&id&" order by d_id asc",conn,1,1
if rs.bof then
response.Write "<a>此分类中已经没有日记了</a>"
else
response.Write "<a href='readdiary.asp?operate=read&id="&rs("d_id")&"' target='_self'>"&getSubString(rs("d_title"),9)&"</a>"
end if
rs.close
end sub

'=================================================================================================================================
'相册页
'================================================================================================================================
sub albumInfo()'相册信息
dim i,a
rs.open "select * from album",conn,1,1
if rs.bof then
response.Write("<div class='a1'><h2>没有添加相册</h2></div>")
 else
i=1

while not rs.eof
a="a"&i
response.Write "<div class='"&a&"'>"&vbcrlf
response.Write "<h2>相册名称"&chr(58)&getSubString(rs("a_name"),5)&"</h2>"&vbcrlf
response.Write "<p>创建时间"&chr(58)&FormatTime(rs("a_time"),"yyyy-mm-dd")&"</p>"&vbcrlf
response.Write "<p>描述"&chr(58)&"<br/>&nbsp;&nbsp;&nbsp;&nbsp;"&getSubString(rs("a_description"),46)&"</p>"&vbcrlf
response.Write "<p><a href='photowall.asp?operate=open&id="&rs("a_id")&"' target='_blank'>打开相册</a></p>"&vbcrlf
response.Write "</div>"
i=i+1
rs.movenext
wend 
end if
rs.close  
end sub	


sub albumImg()'相册封面图
dim i,a
 rs.open "select * from album",conn,1,1
	    if rs.bof then
		response.Write("<img class='a1' src='images/noalbum.gif' width='350' height='300'")
	    else
	    i=1
	    while not rs.eof
	    a="a"&i
	  
       response.Write "<img class='"&a&"' src='"&rs("a_pic")&"' width='350' height='300'  />"
	  
		i=i+1
		rs.movenext
		wend 
		end if
		rs.close  	
end sub
'=================================================================================================================================
'照片墙页
dim photoWallBG
sub albumBg()'显示相册背景图
rs.open "select * from [album] where a_id="&id,conn,1,1
photoWallBG=rs("a_bg")
rs.close
end sub


sub photoWall()'相片列表
 sql="select * from [photo] where p_aid="&id
    page 9,sql
	if rs.eof and rs.bof then
	response.Write("<li><span class='wallimg'><a><img src='images/nophoto1.gif' width='275' height='130'/></a></span></li>")
	end if
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if
response.Write "<li><span class='wallimg'>"&vbcrlf
response.Write "<a href='"&rs("p_big")&"' rel='gallery' class='pirobox_gall' title='"&rs("p_description")&"' style='margin:0 10px 0 0;'>"&vbcrlf
response.Write "<img src='"&rs("p_big")&"' width='275' height='130'/>"&vbcrlf
response.Write "</a></span></li>" 
   rs.movenext
   next
  end sub
  
  
  
'================================================================================================================================
'联系页
'===============================================================================================================================   
sub messageList()'留言列表
		 dim sql
		 if valueArray(12)=true then
		 sql="select * from message where m_check=true order by m_time desc"
		 else 
		 sql="select * from message order by m_time desc"
		 end if 
		 rs.open sql,conn,1,1
		 if rs.bof then
		 response.Write("<ul><li>没有留言</li></ul>")
		 else
		 while not rs.eof
		 response.Write "<ul class='messagelist'>"&vbcrlf
		 response.Write "<li><span class='titlefont'>标题"&chr(58)&getSubString(rs("m_title"),20)&"</span></li>"&vbcrlf
		 response.Write "<li>内容"&chr(58)&rs("m_content")&"</li>"&vbcrlf
		 response.Write "<li><span class='titlefont'>来自"&chr(58)&getSubString(rs("m_name"),8)&"的留言&nbsp;时间"&chr(58)&FormatTime(rs("m_time"),"yyyy-mm-dd hh:nn")&"</span></li>"&vbcrlf
		 if isnull(rs("m_reply"))=true then
		 response.Write "<li><span class='reply'>站长回复"&chr(58)&"未回复</span></li>"&vbcrlf
		 else
		 response.Write "<li><span class='reply'>站长回复"&chr(58)&rs("m_reply")&"</span></li>"&vbcrlf
		 end if
		 response.Write "</ul>"
		 rs.movenext
		 wend
		 end if
		 rs.close
	 end sub
	 
	 
	 
sub sendMessage()'提交留言
if request.QueryString("operate")="send" then
dim m_name,m_contact,m_title,m_content
m_name=safeInstr(trim(request.Form("m_name")))
m_contact=safeInstr(trim(request.Form("m_contact")))
m_title=safeInstr(trim(request.Form("m_title")))
m_content=safeInstr(trim(request.Form("m_content")))
if m_name="" or m_contact="" or m_title="" or m_content="" then 
response.Write("内容不能为空,请输入齐全！")
else
rs.open"select * from message",conn,1,3
rs.addnew
rs("m_name")=m_name
rs("m_contact")=m_contact
rs("m_title")=m_title
rs("m_content")=m_content
rs.update
response.Write("0")
response.End()
end if
end if
end sub

'================================================================================================================================='视频专辑页
'=================================================================================================================================
sub vclassInfo()'视频专辑信息
dim i,a
rs.open "select * from video_class",conn,1,1
if rs.bof then
response.Write("<div class='a1'><h2>没有添加视频专辑</h2></div>")
 else
i=1

while not rs.eof
a="a"&i
response.Write "<div class='"&a&"'>"&vbcrlf
response.Write "<h2>专辑名称"&chr(58)&getSubString(rs("c_name"),12)&"</h2>"&vbcrlf
response.Write "<p>创建时间"&chr(58)&FormatTime(rs("c_time"),"yyyy-mm-dd")&"</p>"&vbcrlf
response.Write "<p>描述"&chr(58)&"<br/>&nbsp;&nbsp;&nbsp;&nbsp;"&getSubString(rs("c_description"),46)&"</p>"&vbcrlf
response.Write "<p><a href='videolist.asp?operate=video&id="&rs("c_id")&"' target='_blank'>打开专辑</a></p>"&vbcrlf
response.Write "</div>"
i=i+1
rs.movenext
wend 
end if
rs.close  
end sub	


sub vclassImg()'专辑封面图
dim i,a
 rs.open "select * from video_class",conn,1,1
	    if rs.bof then
		response.Write("<img class='a1' src='images/noalbum.gif' width='350' height='300'")
	    else
	    i=1
	    while not rs.eof
	    a="a"&i
	  
        response.Write "<img class='"&a&"' src='"&rs("c_pic")&"' width='350' height='300'  />"
	  
		i=i+1
		rs.movenext
		wend 
		end if
		rs.close  	
end sub

  
 sub videoList()'视频列表
 sql="select * from [video] where v_cid="&id
    page 4,sql
	if rs.eof and rs.bof then
	response.Write("<li><a><span class='playimg'></span><img src='images/nophoto1.gif' width='427' height='207'/><span class='playtitle'>没有添加视频</span></a></li>")
	end if
    for i=1 to rs.pagesize
	if rs.eof then 
	exit for
	end if

response.Write "<li><a href='playvideo.asp?operate=play&id="&rs("v_id")&"' target='_blank'><span class='playimg'><img src='images/playimg.png' width='50' height='35'/></span>"&vbcrlf
response.Write "<img src='"&rs("v_pic")&"' width='427' height='207'/>"&vbcrlf
response.Write "<span class='playtitle'>"&rs("v_title")&"</span></a></li>" 
   rs.movenext
   next
  end sub
'=================================================================================================================================
'视频播放页
'=================================================================================================================================
sub playVideo()'视频播放
dim videoName 
videoName=Array("v_id","v_cid","v_title","v_youku_id","v_description")
   rs.open "select * from [video] where v_id="&id,conn,1,1
   for h=1 to ubound(videoName)
   videoValue(h)=rs(videoName(h))
   next
   rs.close
end sub



sub proPlay()'播放上一篇
rs.open "select top 1 v_id,v_title from [video] where v_cid="&videoValue(1)&" and v_id<"&id&" order by v_id desc",conn,1,1
if rs.bof then
response.Write "<a>此专辑中已经没有视频了</a>"
else
response.Write "<a href='playvideo.asp?operate=play&id="&rs("v_id")&"' target='_self'>"&getSubString(rs("v_title"),9)&"</a>"
end if
rs.close
end sub

sub nextPlay()'播放下一篇
rs.open "select top 1 v_id,v_title from [video] where v_cid="&videoValue(1)&" and v_id>"&id&" order by v_id asc",conn,1,1
if rs.bof then
response.Write "<a>此专辑中已经没有视频了</a>"
else
response.Write "<a href='playvideo.asp?operate=play&id="&rs("v_id")&"' target='_self'>"&getSubString(rs("v_title"),9)&"</a>"
end if
rs.close
end sub
%>