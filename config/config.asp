<%@LANGUAGE="VBSCRIPT"%>
<%
Option Explicit '强制定义变量
Server.ScriptTimeout	= 5000 '脚本结束前最大运行时间
Response.ContentType	= "text/html;utf-8" '网页输出类型为 text/html;显示编码为utf-8
Response.Charset		= "utf-8"'js动态内容显示编码为utf-8
Session.CodePage		= 65001 'asp动态内容显示编码为utf-8
Response.Buffer			= true '设置页面缓冲开启
on error resume next
%>
