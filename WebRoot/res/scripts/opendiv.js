function openDivPage(width,height,i,title){
	$("#title_span").html(title);
	$("#windownbg" + i).css({
		height:$(document).height()+"px",
		zindex: 999901
	})
	var width = width >= 950 ? this.width = 950 : this.width = width;
	var height = height >= 527 ? this.height = 527 : this.height = height;
	$("#windownbg" + i).show();
	$("#windownbg" + i).animate({
				opacity : "0.5"
			}, "normal");
	$("#windown-box" + i).show();
	
	if (height >= 527) {
		$("#windown-title" + i).css({
					width : (parseInt(width) + 22) + "px"
				});
		$("#windown-content" + i).css({
					width : (parseInt(width) + 17) + "px",
					height : height + "px"
				});
	} else {
		$("#windown-title" + i).css({
					width : (parseInt(width) + 10) + "px"
				});
		$("#windown-content" + i).css({
					width : width + "px",
					height : height + "px"
				});
	}
	var cw = document.documentElement.clientWidth, ch = document.documentElement.clientHeight, est = document.documentElement.scrollTop;
	var _version = $.browser.version;
	if (_version == 6.0) {
		$("#windown-box" + i).css({
					left : "50%",
					top : (parseInt((ch) / 2) + est) + "px",
					marginTop : -((parseInt(height) + 53) / 2) + "px",
					marginLeft : -((parseInt(width) + 32) / 2) + "px",
					zIndex : "999999"
				});
	} else {
		$("#windown-box" + i).css({
					left : "50%",
					top : "50%",
					marginTop : -((parseInt(height) + 53) / 2) + "px",
					marginLeft : -((parseInt(width) + 32) / 2) + "px",
					zIndex : "999999"
				});
	};
	var drag = 'true';
	var Drag_ID = document.getElementById("windown-box" + i),DragHead = document.getElementById("windown-title" + i);
		
	var moveX = 0,moveY = 0,moveTop,moveLeft = 0,moveable = false;
		if ( _version == 6.0 ) {
			moveTop = est;
		}else {
			moveTop = 0;
		}
	var	sw = Drag_ID.scrollWidth,sh = Drag_ID.scrollHeight;
		DragHead.onmouseover = function(e) {
			if(drag == "true"){DragHead.style.cursor = "move";}else{DragHead.style.cursor = "default";}
		};
		DragHead.onmousedown = function(e) {
		if(drag == "true"){moveable = true;}else{moveable = false;}
		e = window.event?window.event:e;
		var ol = Drag_ID.offsetLeft, ot = Drag_ID.offsetTop-moveTop;
		moveX = e.clientX-ol;
		moveY = e.clientY-ot;
		document.onmousemove = function(e) {
				if (moveable) {
				e = window.event?window.event:e;
				var x = e.clientX - moveX;
				var y = e.clientY - moveY;
					if ( x > 0 &&( x + sw < cw) && y > 0 && (y + sh < ch) ) {
						Drag_ID.style.left = x + "px";
						Drag_ID.style.top = parseInt(y+moveTop) + "px";
						Drag_ID.style.margin = "auto";
						}
					}
				}
		document.onmouseup = function () {moveable = false;};
		Drag_ID.onselectstart = function(e){return false;}
	}
	$("#windown-content" + i).attr("class","windown-cont");
	$("#windown-close" + i).click(function() {
		closeOpenDivPage(i);
	});
}

function closeOpenDivPage(i){
$("#windownbg"+i).hide();
$("#windown-box"+i).fadeOut("slow",function(){$(this).hide();});
}
