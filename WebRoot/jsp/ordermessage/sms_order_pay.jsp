<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
	<title>购物支付</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<%@ include file="/public_module/public_css_new.jsp"%>
	<link href="<%=basePath%>assets/global/css/shopping_m.css" rel="stylesheet" type="text/css" />
</head>



<body>
	<div class="head">
		<div class="nav"><a href="javascript:" style="color:#0e91fb;">${sessionScope.user.realName}，您好</a><a href="<%=basePath%>orderMessage/toOrderMessage.do">首页</a></div>
		<div style="background-color:#1780ba;"><div class="logo">RICH<span>短信套餐</span><span class="title">收银台</span></div></div>	
	</div>
	<div class="pinfo">
		<div class="pleft">商品：${goodsName }</div>
		<div class="pright">应付金额：<span>${amount }</span>元</div>
	</div>
	<div class="pay" style="min-height:500px;">
		<h2>选择支付方式</h2>
		<ul class="pcontent">
			<li id="1"><img style="width:100%;" src="<%=basePath%>assets/global/img/zhifubao.jpg"></li>
			<%-- <li id="2"><img src="<%=basePath%>media/image_m/yinlianzhifu.jpg"></li> --%>
			<li id="2"><img style="width:100%;" src="<%=basePath%>assets/global/img/weixinzhifu.jpg"></li>
			<%-- <li id="4"><img src="<%=basePath%>media/image_m/geren_zhifu.jpg"></li> --%>
		</ul>
	</div>
	<form action="" id="peyForm" method="post" target="_blank">
		<input size="30" type="hidden" name="WIDout_trade_no" id="orderId" value="${ordersId}" />
		<input size="30" type="hidden"  name="WIDsubject" id="goodsName" value="${goodsName }"/>
		<input size="30" type="hidden"  name="WIDtotal_fee" id="amount" value="${amount }"/>
	</form>
	<span style="clear:both;"></span>
	<%@ include file="/public_module/public_footer.jsp"%>

</body>
<%@ include file="/public_module/public_js.jsp"%>
<script type="text/javascript">
	$(function(){
		$(".pcontent li").on("click",function(){
			$(this).css({"border":"1px solid #ee1b21"}).siblings().removeAttr("style");
			var pId = $(this).attr("id");
			if (pId == 1){
				if (IsPC()==1){
					$("#peyForm").attr("action","<%=basePath%>/jsp/alipay/alipayapi.jsp");
					$("#peyForm").submit();
				}else{
					window.richbook.onAliPay($("#goodsName").val(),$("#orderId").val(),$("#amount").val());//调用手机支付宝支付
				}
			}else if(pId == 2){
				if (IsPC()==1){
					$("#peyForm").attr("action","<%=basePath%>wcPayController/getUnifiedOrders.do");
					$("#peyForm").submit();
				}else{
					window.richbook.onWxPay($("#goodsName").val(),$("#orderId").val(),$("#amount").val());//调用安卓手机微信客户端支付
				}
			}
		})
	});
</script>
</html>