<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
Response.Charset= "utf-8"
Response.Expires = 0
Dim Pic:Pic = Request.QueryString("p")
If isnull(pic) Then
 response.Write "<script>alert('您没有上传图片');window.close();</script>"
ElseIf instr(lcase(pic),".gif")=0 and instr(lcase(pic),".jpg")=0 and instr(lcase(pic),".png")=0 and instr(lcase(pic),".jpeg")=0 Then
 response.Write "<script>alert('非图片文件!');window.close();</script>"
ElseIf left(lcase(pic),4)="http" and instr(lcase(pic),"://")=0 Then
 response.Write "<script>alert('非本站图片不能处理!');window.close();</script>"
End If
Dim PointX:PointX = cint(request("x"))
Dim PointY:PointY = cint(request("y"))	
Dim CutWidth:CutWidth = cint(request("w"))
Dim CutHeight:CutHeight = cint(request("h"))	
Dim PicWidth:PicWidth = cint(request("pw"))
Dim PicHeight:PicHeight = cint(request("ph"))

on error resume next
Set Jpeg = Server.CreateObject("Persits.Jpeg")
if err then 
 err.clear
 response.Write "<script>alert('服务器没有安装aspJpeg组件!');</script>"
end if
Jpeg.Open Server.MapPath(Pic)

'缩放切割图片
Jpeg.Width = PicWidth
Jpeg.Height = PicHeight
Jpeg.Crop PointX, PointY, CutWidth + PointX, CutHeight + PointY
Jpeg.Quality=80
Jpeg.Save Server.MapPath(pic)        '保存图片到磁盘并替换原图
if err=0 then
response.Write "<script>alert('图片裁切成功!');top.close();</script>"
response.End()
end if
%>
