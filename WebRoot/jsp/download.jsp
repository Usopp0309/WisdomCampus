<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head lang="en">
    <meta charset="UTF-8">
    <title>亦信下载</title>
    <style type="text/css">
        .main{text-align: center}
        p{padding:0px;margin:0px;display: inline-block;border: 0px;}
        p img, .popup img{max-width: 100%;padding:0px;margin:0px;border: 0px;}
        .popup{background:url("<%=basePath%>assets/global/img/downloadimg/bg.png") repeat;position: absolute;top:0px;left:0px;}
    </style>
</head>
<body>
<div class="main">
    <div name="popup" class="popup"><img src="<%=basePath%>assets/global/img/downloadimg/app.png"></div>

<%--     <p><a id="download" href="http://121.199.27.191:18086/huxin/app/YiXin.apk"><img src="<%=basePath%>assets/global/img/downloadimg/appup.png"></a></p> --%>
<p><a id="download" href="http://o9fisdspi.bkt.clouddn.com/download/app/YiXin.apk"><img src="<%=basePath%>assets/global/img/downloadimg/appup.png"></a></p>

</div>
</body>
<script src="<%=basePath%>assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
var u = navigator.userAgent, app = navigator.appVersion;
var browser = {
	versions : function() {
		return {
			trident : u.indexOf('Trident') > -1, //IE内核
			presto : u.indexOf('Presto') > -1, //opera内核
			webKit : u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
			gecko : u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
			mobile : !!u.match(/AppleWebKit.*Mobile.*/)
					|| !!u.match(/AppleWebKit/), //是否为移动终端
			ios : !!u.match(/(i[^;]+;(U;)? CPU.+Mac OS X)/), //ios终端
			android : u.indexOf('Android') > -1
					|| u.indexOf('Linux') > -1, //android终端或者uc浏览器
			iPhone : u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
			iPad : u.indexOf('iPad') > -1, //是否iPad
			webApp : u.indexOf('Safari') == -1
		//是否web应该程序，没有头部与底部
		};
	}(),
	language : (navigator.browserLanguage || navigator.language)
			.toLowerCase()
	}
/* 	 document.writeln("<BR/>语言版本: "+browser.language);
 document.writeln(" <BR/>是否为移动终端: " + browser.versions.mobile);
 document.writeln(" <BR/>ios终端: " + browser.versions.ios);
 document.writeln(" <BR/>android终端: " + browser.versions.android);
 document.writeln(" <BR/>是否为iPhone: " + browser.versions.iPhone);
 document.writeln(" <BR/>是否iPad: " + browser.versions.iPad);
 document.writeln(navigator.userAgent); */

    //判断是否是微信
	var ua = navigator.userAgent.toLowerCase(); 
	
	if(ua.match(/MicroMessenger/i)=="micromessenger") { 
		$(".popup").css({"height":$(document).height(),"width":$(document).width()});
		$(".popup img").css({"width":$(document).width()});
	}else{
		$(".popup img").hide();
		if (browser.versions.ios) {
			$("#download").attr("href","https://itunes.apple.com/cn/app/yi-xin/id1091569829?mt=8");
			document.getElementById("download").click();
		} else if (browser.versions.android) {
			document.getElementById("download").click();
		}
	}

</script>

</html>