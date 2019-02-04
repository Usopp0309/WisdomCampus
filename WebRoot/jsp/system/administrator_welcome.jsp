<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 </title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>
  
  <body>
	 <%@include file="/public_module/header.jsp" %>
	  <div class="Fill_Card" style="background:none">
		  <div class="welcome_box">
				<h3>超管您好！欢迎回来智慧校园！</h3>
				<p>有<span>${count}</span>个学校提交了学校认证，请<em class="Response">在规定时间内</em>及时处理</p>
				<a href="<%=basePath%>schoolApply/toSchoolApplyList.do" target="_self">马上处理</a>
			</div>
	  </div>
  	<%@include file="/public_module/public_footer.jsp" %>
  </body>
  	<%@include file="/public_module/public_js.jsp" %>
</html>
