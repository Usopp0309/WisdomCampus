<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>钱包支付</title>
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
	<div class="pinfo">
		<div class="pleft">商品：${goodsName }</div>
		<div class="pright">应付金额：<span>${amount }</span>元</div>
	</div>
	
	<div class="pay personalWallet" style="min-height:500px;">
		<p class="title"><b><i></i>个人支付</b><span><label>钱包余额：</label>￥${balance }</span><span class="span_right">支付<b>${amount }</b>元</span></p>
	
		<p style="font-size:16px;font-weight:bold;">支付密码：</p><input type="password" name="passWord"  id="passWord">
		<p>请输入6位支付密码</p>
		<p>如未设置请前往<b>亦信-我的钱包</b>中进行操作</p>
		<input type="hidden" name="orderId" value="${orderId }" id="orderId">
		<input type="hidden" name="goodsName" value="${goodsName }" id="goodsName">
		<input type="button" class="pay" onclick="pay()"  value="确认支付">
	</div>
	<span style="clear:both;"></span>
	<%@include file="/public_module/public_footer.jsp" %>

</body>
	<%@include file="/public_module/public_footer.jsp" %>

<script type="text/javascript">
	function pay(){
		$.ajax({
			type: "post",
			url: "<%=basePath%>wallet/pay.do",
			data:{
				orderId : $("#orderId").val(),
				passWord : $("#passWord").val(),
				goodsName : $("#goodsName").val()
				},
			success: function(data){
				data = $.parseJSON(data);
				if (data.code == "0"){
					alert("支付订单成功!");
					window.location.href("<%=basePath%>jsp/shopping/success.jsp");
				}else{
					alert(data.msg);
				}
				
			},
		});
	}
</script>
</html>