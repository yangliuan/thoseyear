
var obj=null;
var picobj=null;
function OpenThenSetValue(Url,Width,Height,WindowObj,SetObj,pic){
	if (document.all){
	var ReturnStr=showModalDialog(Url,WindowObj,'dialogWidth:'+Width+'pt;dialogHeight:'+Height+'pt;status:no;help:no;scroll:no;status:0;help:0;scroll:0;');
	if (ReturnStr!='' && ReturnStr!=undefined){SetObj.value=ReturnStr;SetObj.focus();
	 if (pic!=''&& pic!=undefined){$("#"+pic).attr("src",ReturnStr);}
	}
	return ReturnStr;
	}else{
	 obj=SetObj;
	 picobj=pic;
	 Width=Width+180;
	 Height=Height+80;
	 window.open(Url,'newWin','modal=yes,width='+Width+',height='+Height+',resizable=no,scrollbars=no');
	}
}


function OpenImgCutWindow(installdir,photourl){
	OpenImgCutWindows(installdir,photourl,$('#PhotoUrl')[0]);
}
function OpenImgCutWindows(installdir,photourl,obj){
	OpenThenSetValue(installdir+'ImgCut.asp?photourl='+photourl,680,380,window,obj);
}

