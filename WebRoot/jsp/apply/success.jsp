<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>智慧校园</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束--> 
<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<header class="header">
		<div class="top">
			<img src="<%=basePath%>assets/global/img/m_img/logo.png" style="display:block;float:left;height:35px;margin:2px 0 0 0"><span style="color:#fff;line-height:40px;font-size:16px;display:block;float:left;margin:0px 0 0 15px;">RichX 智慧校园</span>
			<ul class="apply_addmenu_li">
				<li style="float:left;width:20%"><a href="http://www.richx.cn/index.html" target="_blank"><span class="Response">关于</span>RICH</a></li>
				<li style="float:left;width:20%"><a href="http://wpa.qq.com/msgrd?v=3&uin=6949265&site=qq&menu=yes" target="_blank">在线咨询</a></li>
			</ul>
		</div>
	</header>
	<section id="page_2" class="main" style="display: block;">
		<img src="<%=basePath%>assets/global/img/m_img/State_2.jpg">
		<div class="send_box">
			<div class="text_con">
				<div class="Success_icon">
					<img src="<%=basePath%>assets/global/img/m_img/Success_icon.png">
				</div>
				<div class="sussecc_text">
					<h3>感谢注册！我们将尽快对您的信息进行审核，</h3>
					<p>
						我们将以邮件方式将审核结果发至您注册邮箱：<a href="" id="goemail"></a>
					</p>
					<p>请耐心等待&nbsp;&nbsp;&nbsp;<a href="<%=basePath%>apply/apply.do" ><strong>返回</strong></a></p>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/public_module/public_footer.jsp" %>
<p>      
</body>
	<%@ include file="/public_module/public_js.jsp" %>
</html>