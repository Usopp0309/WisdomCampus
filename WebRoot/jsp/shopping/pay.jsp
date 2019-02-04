<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>购物支付</title>
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
	<div class="pay" style="min-height:500px;">
		<h2>选择支付方式</h2>
		<ul class="pcontent">
			<li id="1"><img src="<%=basePath%>media/image_m/zhifubao.jpg"></li>
			<%-- <li id="2"><img src="<%=basePath%>media/image_m/yinlianzhifu.jpg"></li> --%>
			<li id="2"><img src="<%=basePath%>media/image_m/weixinzhifu.jpg"></li>
			 <li id="3"><img src="<%=basePath%>media/image_m/geren_zhifu.jpg"></li> 
		</ul>
	</div>
	<form action="" id="peyForm" method="post" target="_blank">
		<input size="30" type="hidden" name="WIDout_trade_no" id="orderId" value="${ordersId}" />
		<input size="30" type="hidden"  name="WIDsubject" id="goodsName" value="${goodsName }"/>
		<input size="30" type="hidden"  name="WIDtotal_fee" id="amount" value="${amount }"/>
	</form>
	<span style="clear:both;"></span>
	<%@include file="/public_module/public_footer.jsp" %>

</body>
<%@include file="/public_module/public_js.jsp" %>
<script type="text/javascript">
	$(function(){
		$(".pcontent li").on("click",function(){
			$(this).css({"border":"1px solid #1780ba"}).siblings().removeAttr("style");
			var pId = $(this).attr("id");
			if (pId == 1){//支付宝
				if (IsPC()==1){
					$("#peyForm").attr("action","<%=basePath%>/jsp/alipay/alipayapi.jsp");
					$("#peyForm").submit();
				}else if (IsPC()==2){
					window.richbook.onAliPay($("#goodsName").val(),$("#orderId").val(),$("#amount").val());//调用安卓手机支付宝客户端支付
				}else if (IsPC()==3){
					location.href="<%=basePath%>/jsp/IOSAliPay.jsp?goodsName="+$("#goodsName").val() + "&orderId="+$("#orderId").val() + "&amount="+$("#amount").val();
				}
			}else if(pId == 2){//微信
				if (IsPC()==1){
					$("#peyForm").attr("action","<%=basePath%>wcPayController/getUnifiedOrders.do");
					$("#peyForm").submit();
				}else if (IsPC()==2){
					window.richbook.onWxPay($("#goodsName").val(),$("#orderId").val(),$("#amount").val());//调用安卓手机微信客户端支付
				}else if (IsPC()==3){
					location.href="<%=basePath%>/jsp/IOSTecentPay.jsp?goodsName="+$("#goodsName").val() + "&orderId="+$("#orderId").val() + "&amount="+$("#amount").val();
				}
			}else if (pId == 3){//个人钱包
				$("#peyForm").attr("action","<%=basePath%>wallet/toPersonalWallet.do");
				$("#peyForm").submit();
			}
		})
	});
</script>
</html>