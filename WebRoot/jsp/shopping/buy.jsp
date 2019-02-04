<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>购物下单</title>
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
		<div style="background-color:#1780ba;"><div class="logo">RICH<span>购物</span></div></div>
	</div>
	<div class="buy">
	<div class="b_head">
	<div class="bleft"><c:forEach items="${goods.list }" var="goodsDetail" varStatus="satus"> 
		<c:if test="${satus.index eq 0 }"><img src="<%=basePath%>${goodsDetail.imgPath }" id="img${goodsDetail.id}"></c:if> 
		<c:if test="${satus.index ne 0 }"><img src="<%=basePath%>${goodsDetail.imgPath }" id="img${goodsDetail.id}" style="display:none"></c:if> 
		</c:forEach></div>
	<div class="bright">
	<h2>${goods.name }</h2>
	<form action="<%=basePath %>shopping/toShoppingPay.do" id="submitForm" method="post">
	<div class="Price">价格 ：<c:forEach items="${goods.list }" var="goodsDetail1" varStatus="satus1">
		<c:if test="${satus1.index eq 0 }"><span id="price${goodsDetail1.id}"> ￥${goodsDetail1.price } </span></c:if>
		<c:if test="${satus1.index ne 0 }"><span id="price${goodsDetail1.id}" style="display:none"> ￥${goodsDetail1.price } </span></c:if>
		</c:forEach></div>
	<input type="hidden" name="price" id="price">
	<c:if test="${goods.list!=null && fn:length(goods.list) > 1 }">
		<div class="format"><span>规格：</span><ul class="pcontent">
		<c:forEach items="${goods.list }" var="goodsDetail2" varStatus="satus2">
			<c:if test="${satus2.index eq 0 }"><li id="${goodsDetail2.id }" style="border:1px solid #158ff2"></c:if>
			<c:if test="${satus2.index ne 0 }"><li id="${goodsDetail2.id }"></c:if>
			${goodsDetail2.specifications }</li>
		</c:forEach>
		</ul></div>
		<input type="hidden" value="" name="detailId" id="detailId">
	</c:if>
	<c:if test="${goods.list!=null && fn:length(goods.list) <= 1 }">
		<c:forEach items="${goods.list }" var="goodsDetail4" varStatus="satus4">
			<input type="hidden" value="${goodsDetail4.id }" name="detailId">
		</c:forEach>
	</c:if>
	
	<div class="b_info"><span>数量：</span><p><i class="reduce">-</i><i class="num_input num_a" style="margin:0px 10px;"type="text">1</i><input type="hidden" id="saleNum" name="saleNum" value="1"><i class="add">+</i>件</p></div>
	<div class="b_info"><span>收件人：</span><p><input name="name" id="name" type="text" class="num_input span3"></p></div>
	<div class="b_info"><span>手机号码：</span><p><input name="phone" id="phone" type="text" class="num_input span3"></p></div>
	<div class="b_info"><span>收货地址：</span><p><input type="text" name="address" id="address" class="num_input span6"></p></div>
	<div class="b_info"><span>备 注：</span><p><textarea rows="" cols="3" class="num_input span6" name="remark"></textarea></p></div>
	<input type="submit" class="btn" value="立即购买">
	<input type="hidden" name="goodsName" value="${goods.name }">
	</form>
	</div>
	</div>
	<div class="suggest">
		<ul>
			<li>商品介绍</li>
		</ul>
		
			<c:forEach items="${goods.list }" var="goodsDetail3" varStatus="satus3"> 
			<c:if test="${satus3.index eq 0 }"><div class="suggest_con" id="suggest${goodsDetail3.id}">${goodsDetail3.introduction}</div></c:if> 
			<c:if test="${satus3.index ne 0 }"><div class="suggest_con" id="suggest${goodsDetail3.id}" style="display:none">${goodsDetail3.introduction}</div></c:if> 
			</c:forEach>
		
	</div>
	</div>
	
	<span style="clear:both;"></span>
	<%@include file="/public_module/public_footer.jsp" %>
</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
<script type="text/javascript" src="<%=basePath%>assets/global/plugins/jquery.validate.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#detailId").val($(".pcontent li:first").attr("id"));
		$("#price").val($(".Price span:first").text())
		//选择类型
		$(".pcontent li").on("click",function(){
			$(this).css({"border":"1px solid #158ff2"}).siblings().removeAttr("style");
			var detailId = $(this).attr("id");
			$("#detailId").val(detailId);
			$("#price").val($("#price" + detailId).text());
			$("img[id*='img']").hide();
			$("#img" + detailId).show();
			$("span[id*='price']").hide();
			$("#price" + detailId).show();
			$("div[id*='suggest']").hide();
			$("#suggest" + detailId).show();
		})
		//选择数量
		$(".add").on("click",function(){
			var val=parseInt($(".num_a").text())+1;
			$(".num_a").text(val);
			$("#saleNum").val(val);
		})
		$(".reduce").on("click",function(){
			if($(".num_a").text()>1){
				var val=parseInt($(".num_a").text())-1;
				$(".num_a").text(val);
				$("#saleNum").val(val);
			}
		})
		$('#submitForm').validate({
			
		})
		$('#name').rules('add', {
			required : true,
			messages : {
				required : '名称不能为空！',
			},
		});
		$('#address').rules('add', {
			required : true,
			messages : {
				required : '地址不能为空！',
			},
		});
		$('#phone').rules('add', {
			required : true,
			messages : {
				required : '手机号不能为空！',
			},
		});
		
		$.validator.addMethod(
				'phone',
				function(value, element) {
					var tel = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
					return this.optional(element)
							|| (tel.test(value));
				}, '请输入正确的手机号！');
	})
</script>
</html>