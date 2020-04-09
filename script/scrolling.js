scrollVertical.prototype.scrollArea=null;      
scrollVertical.prototype.scrollMsg=null;       
scrollVertical.prototype.unitHeight=0;         
scrollVertical.prototype.msgHeight=0;          
scrollVertical.prototype.copyMsg=null;         
scrollVertical.prototype.scrollValue=0;       
scrollVertical.prototype.scrollHeight=0;      
scrollVertical.prototype.isStop=true;         
scrollVertical.prototype.isPause=false;        
scrollVertical.prototype.scrollTimer=null;   
scrollVertical.prototype.speed=2000;  

scrollVertical.prototype.play = function(o){
    var s_msg = o.scrollMsg;
    var c_msg = o.copyMsg;
    var s_area = o.scrollArea;
    var msg_h = o.msgHeight;
    
    var anim = function(){
        if (o.scrollTimer) {
            clearTimeout(o.scrollTimer);
        }
        if (o.isPause) {
            o.scrollTimer = setTimeout(anim, 10);
            return;
        }
        if (msg_h - o.scrollValue <= 0) {
            o.scrollValue = 0;
        }
        else {
            o.scrollValue += 1;
            o.scrollHeight += 1;
        }
        if (o.isMoz) { 
            s_area.scrollTop = o.scrollValue;
        }
        else { 
            s_msg.style.top = -1 * o.scrollValue + "px";
            c_msg.style.top = (msg_h - o.scrollValue) + "px";
        }
        if (o.scrollHeight % s_area.offsetHeight == 0) {
            o.scrollTimer = setTimeout(anim, o.speed);
        }
        else {
            o.scrollTimer = setTimeout(anim, 10);
        }
    };
    anim();
};

function scrollVertical(disp, msg, tg){
    if (typeof(disp) == 'string') {
        this.scrollArea = document.getElementById(disp);
    }
    else {
        this.scrollArea = disp;
    }
    if (typeof(msg) == 'string') {
        this.scrollMsg = document.getElementById(msg);
    }
    else {
        this.scrollMsg = msg;
    }
    
    var s_msg = this.scrollMsg;
    var s_area = this.scrollArea;
	
    if (!tg) {
        var tg = 'li';
    }
    
    this.unitHeight = s_msg.getElementsByTagName(tg)[0].offsetHeight;
    this.msgHeight = this.unitHeight * s_msg.getElementsByTagName(tg).length;
	
	s_msg.style.position = "absolute";
	s_msg.style.top = 0;
	s_msg.style.left = 0;
	
    var copydiv = document.createElement('div');
    copydiv.id = s_area.id + "_copymsgid";
    copydiv.innerHTML = s_msg.innerHTML;
	copydiv.style.height = this.msgHeight + "px";
    s_area.appendChild(copydiv);
	copydiv.style.position = "absolute";
	copydiv.style.top = this.msgHeight + "px";
	copydiv.style.left = 0;
    
    this.copyMsg = copydiv;
    this.play(this);
}

function ScrollNews(scrollContainer, scrollContent, rowTag){
	this.Container = scrollContainer;
	this.Content = scrollContent;
	this.rowTag = rowTag;
	this.scroll();
}
ScrollNews.prototype.scroll = function(){
	var News = new scrollVertical(this.Container, this.Content, this.rowTag);
	News.speed = 4000;
	News.isPause = true;
	
	var timer = setTimeout(function(){
		if (timer) {
			clearTimeout(timer);
		}
		News.isPause = false;
	}, 2000);
	
	News.scrollArea.onmouseover = function(){
		News.isPause = true;
	}
	News.scrollArea.onmouseout = function(){
		News.isPause = false;
	}
};