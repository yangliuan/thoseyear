// JavaScript Document 
//-------高亮显示导航
var  $c=function(array){var nArray = [];for (var i=0;i<array.length;i++) nArray.push(array[i]);return nArray;};
Array.prototype.each=function(func){
for(var i=0,l=this.length;i<l;i++) {func(this[i],i);};
};
document .getElementsByClassName=function(cn){
var hasClass=function(w,Name){
var hasClass = false;
w.className.split(' ').each(function(s){
if (s == Name) hasClass = true;
});
return hasClass;
}; 
var elems =document.getElementsByTagName("*")||document.all;
            var elemList = [];
           $c(elems).each(function(e){
if(hasClass(e,cn)){elemList.push(e);}
		   })
        return $c(elemList);
};		
function change_bg(obj){
var a=document.getElementsByClassName("class_nav")[0].getElementsByTagName("a");
for(var i=0;i<a.length;i++){a[i].className="";}
obj.className="current";
}
//表单根据参数跳转到不同的url
//act:url地址
//表单名字必须为formList
//-------------------------------------------------------
function changeAction(act)
{
  document.formList.action=act;
  document.formList.submit();
}
//-------------------------------------------------------
//复选框全选及取消
//sonName:要更改的复选框组的name
//cbAllId作为按钮使用的复选框的name
//-------------------------------------------------------
function ChkAllClick(sonName, cbAllId){
 var arrSon = document.getElementsByName(sonName);//复选框组
 var cbAll = document.getElementsByName(cbAllId);//作为按钮使用的复选框
 var tempState=cbAll.checked;//获取作为按钮的复选框的checked属性
 for(i=0;i<arrSon.length;i++) {
  if(arrSon[i].checked!=tempState)//如果按钮复选框与复选框组的checked属性不相同
           arrSon[i].click();//改变复选框组的checked属性
 }
}

//========单击编辑按钮时判断复选框个数不能大于1，大于1跳转到前一条历史地址，不大于1跳转到新地址
//checkName:复选框组的name
//historyUrl：出错前的地址
//newUrl：满足条件后的新地址
//num:两个值1,0;1：表示只能选中一条否则返回警告；2：表示可以选中两条以上的记录
//info:不同操作的提示信息。
function checkChecked(checkName,historyUrl,newUrl,num)
{
	
  var count=0;
  var arrName=document.getElementsByName(checkName);
  for(var i=0;i<arrName.length;i++)	
  	{if(arrName[i].checked)
		{count++;}
    }
	if (count==0)
    {
	 alert("你未选中任何项目！");
	 window.location.href=historyUrl;
	 
    }else 
	{
		
		switch(num)
	 { 
	       case 1:
		   if(count>1)
		   { alert("只能操作一条记录！");
		     window.location.href=historyUrl;
		   }
		   else
		   {
			changeAction(newUrl);
		   }
		   break;
		   
	       case 2:
		   changeAction(newUrl);
	       break;
		  }
	  }
}
//删除提示条目
function delChecked(checkName,historyUrl,newUrl)
{
 if(confirm("你确定要删除吗？"))
 {
  var count=0;
  var arrName=document.getElementsByName(checkName);
  for(var i=0;i<arrName.length;i++)	
  	{if(arrName[i].checked)
		{count++;}
    }
	if (count==0)
    {
	 alert("你未选中任何项目！");
	 window.location.href=historyUrl;
	 
    }
	else
	{changeAction(newUrl);}
 }
}