<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>钱包</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
	<link href="<%=basePath%>assets/global/css/shopping_m.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="head">
		<div class="nav"><a href="javascript:" style="color:#0e91fb;">${sessionScope.user.realName}，您好</a><a href="<%=basePath%>shopping/toShoppingList.do">首页</a></div>
		<div style="background-color:#1780ba;"><div class="logo">RICH<span>购物</span><span class="title">收银台</span></div></div>	
	</div>
	
	
	<div class="pay pay_success" style="min-height:500px;margin:60px auto 0px;">
		<p><i class="icon-ok"></i>您已成功付款</p>
		<input class="success_input" type="button" onclick="pay()"  value="关闭窗口">
	</div>
	<span style="clear:both;"></span>
	<%@include file="/public_module/public_footer.jsp" %>
</body>
	<%@include file="/public_module/public_js.jsp" %>
	
<script type="text/javascript">
	
	function pay(){
		window.close();
	}
</script>
</html>