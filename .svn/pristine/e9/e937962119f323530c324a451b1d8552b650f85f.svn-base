<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>测试</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->  
	<link href="<%=basePath%>assets/global/css/shopping_m.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color:#eff0f2">
	<div class="head">
		<div class="nav"><a href="javascript:" style="color:#0e91fb;">${sessionScope.user.realName}，您好</a><a href="<%=basePath%>shopping/toShoppingList.do">首页</a></div>
		<div style="background-color:#1780ba;"><div class="logo">RICH<span>购物</span></div></div>
	</div>
	<div class="myorder">我的订单</div>
	
	<div class="myordertab">
		<ul class="myordertabhead">
			<c:if test="${status eq '0'}">
				<li onclick="change(0)" class="select">待付款</li>
				<li onclick="change(1)">已付款</li>
			</c:if>
			<c:if test="${status eq '1'}">
				<li onclick="change(0)">待付款</li>
				<li onclick="change(1)"  class="select">已付款</li>
			</c:if>
			<form action="<%=basePath%>shopping/toSelfOrderList.do" id="searchForm" method="post">
				<div class="ordersearch">
					<input type="text" placeholder="商品名称/订单号" name="queryContent" value="${queryContent}">
					<input type="hidden" id="status" name="status" value="${status}">
					<input class="input_submit" type="submit" value="搜索">
				</div>
			</form>
		</ul>
		<ul class="myordertabcon">
		<c:if test="${status eq '0'}">
			<li >
				<div class="con_head">
					
					<span class="s1 center">详情</span>
					<span class="s3 center">收货人</span>
					<span class="s3 center">总计</span>
					<span class="s3 center Response">全部状态</span>
					<span class="s3 center">操作</span>
				</div>
				<c:forEach items="${list }" var="order">
				<dl id="${order.id }">
					<p>${order.createTime } 订单号:${order.id }</p>
					<dd>	
						<span class="s1 center"><img src="<%=basePath %>${order.imgPath}" style="margin:10px;"><p>${order.goodsName}<em>${order.counts}</em></p></span>
						<span class="s3 center">${order.receiver}<i></i></span>
						<span class="s3 center">${order.amount}</span>
						<span class="s3 center Wait_payment Response">等待付款</span>
						<span class="s3 center">
							<em class="operate spanred" onclick="pay(${order.id },'${order.amount}','${order.goodsName}')">付款</em>
							<em class="operate cancel" onclick="cancelOrder(${order.id })">取消订单</em>
						</span>
					</dd>
				</dl>
				</c:forEach>
				
			</li>
			</c:if>
			<c:if test="${status eq '1'}">
			<li>
				<div class="con_head">
					
					<span class="s1 center">订单<em class="Response">详情</em></span>
					<span class="s3 center">收货人</span>
					<span class="s3 center">总计</span>
					<span class="s3 center"><em class="Response">全部</em>状态</span>
					
				</div>
				<c:forEach items="${list }" var="order">
					<dl>
						<p>${order.createTime } 订单号:${order.id }</p>
						<dd>	
							<span class="s1 center"><img src="<%=basePath %>${order.imgPath}" style="margin:10px;"><p>${order.goodsName}<em>${order.counts}</em></p></span>
							<span class="s3 center">${order.receiver}<i></i></span>
							<span class="s3 center">${order.amount}</span>
							<span class="s3 center Wait_payment">已付款</span>
						</dd>
					</dl>
				</c:forEach>
				
			</li>
			</c:if>
			
		</ul>
	</div>
	<form action="<%=basePath %>shopping/toPay.do" method="post" style="display:none" id="payForm">
		<input type="hidden" id="orderId" name="orderId">
		<input type="hidden" id="goodsName" name="goodsName">
		<input type="hidden" id="amount" name="amount">
	</form>
	<span style="clear:both;"></span>
	<%@include file="/public_module/public_footer.jsp" %>
	
</body>
<%@include file="/public_module/public_js.jsp" %>
<script type="text/javascript">
	$(function(){
		$(".myordertabhead li").on("click",function(){
			var ul_id=$(this).index();
			$(this).addClass("select").siblings().removeClass("select");
			$(".myordertabcon li").eq(ul_id).show().siblings().hide();
		})
		
	});
	function change(obj){
		$("#status").val(obj);
		$("#searchForm").submit();
	}
	function cancelOrder(orderId){
		if(confirm("您确定取消订单吗？")){
			$.ajax({
				type: "post",
				url: "<%=basePath%>shopping/cancelOrder.do",
				data:{
					orderId : orderId
					},
				success: function(data){
					if (data == "0"){
						alert("取消订单成功");
						$("#" + orderId).remove();
					}
				},
			});
		}else{
			return false;
		}
		
	}
	function pay(orderId, amount, goodsName){
		$("#orderId").val(orderId);
		$("#goodsName").val(goodsName);
		$("#amount").val(amount);
		$("#payForm").submit();
	}
</script>
</html>