<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - 订单列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>

<body id="body">
	<%@ include file="/public_module/header.jsp"%>
	<div class="manager_search_box">
		<div class="search_main">
			<button type="button" class="fa fa-search search_submit" id="search"></button>
			<input class="search_text" type="text" name="condition" id="condition" placeholder="请输入手机号、姓名、商品名..." value=""></input>
			<input type="hidden" name="status" id="status" value="">
		</div>
	</div>
	 <div class="richxManager">
			<h3 class="margin_top_15">购物订单</h3>
			<ul class="mtabs margin_top_15" id="orderTab">
				
			</ul>
			<h4 class="margin_top_15">购物列表</h4>
			<div class="con">
			<div class="tab-content">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th class="m_width_30">商品名</th>
							<th class="m_width_10">数量</th>
							<th class="m_width_10">收件人</th>
							<th class="m_width_10">收件电话</th>
							<th class="m_width_30">收件地址</th>
							<th class="m_width_10"> 操作</th>
						</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
					
				</table>	
			</div>
		</div>
		<%@include file="/public_module/public_page.jsp" %>
	</div>
	<div class="modal fade" id="static" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">信息提示</h4>
                </div>
                <div class="modal-body">
                	<div class="alert alert-danger text_align">
                    	<strong>确定发货后，买家将收到短信提醒，是否确定发货</strong>
                    </div>
					<input type="hidden" id="goodsName" name="goodsName"/>
					<input type="hidden" id="receiver" name="receiver">
					<input type="hidden" id="phone" name="phone">
					<input type="hidden" id="orderId" name="orderId">
				</div>
                <div class="modal-footer">
                    <button type="button" class="btn green" data-dismiss="modal" onclick="send()">确定</button>
                    <button type="button" class="btn" data-dismiss="modal">取消</button>
                </div>
			</div>
		</div>
	</div>
	<%@ include file="/public_module/public_footer.jsp" %>
	</body>
	<%@ include file="/public_module/public_js.jsp" %>
	<script type="text/javascript">
		$(function() {
			$(".mtabs li").eq(0).css({"border-right":"none"})
			//导航定位
			$(".menu_li a").removeClass("hover");
			$("#menu7").addClass("hover");
			loadOrdersList(1, null, null);
			//点击tab页加载
			$("#search").click(function(){
				var status = $("#status").val();
				var condition = $("#condition").val();
				loadOrdersList(status, condition, null);
			});
		})
		
		function changeStatus(obj){
			$("#status").val(obj);
			$("#condition").val("");
			loadOrdersList(obj, null, null);
		}
		function showModal(orderId,goodsName,receiver,phone){
			$("#orderId").val(orderId);
			$("#goodsName").val(goodsName);
			$("#receiver").val(receiver);
			$("#phone").val(phone);
			$('#static').modal('show');
		}
		
		function send(){
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>shopping/sendOrders.do",
				data:{
						orderId : $("#orderId").val(),
						goodsName : $("#goodsName").val(),
						receiver : $("#receiver").val(),
						phone : $("#phone").val()
				},
				success: function(data){
					var data = $.parseJSON(data);
					if (data.code == 0){
						window.location.reload();
					}else{
						alert(data.msg);
						$('#static').modal('hide');
					}
          			//解锁UI
          			App.unblockUI(body);
          			/* $(".search_box").css({"display":"none"}); */
				},
			});
		}
		
		function loadOrdersList(status, condition, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>shopping/getOrdersList.do",
				data:{
						status : status,
						condition : condition,
						page : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					$("#status").val(status);
					var appendHtml = '';
					var appendUlHtml = '';
					if(status == 1)
					{
						appendUlHtml += '<li class="active"><a href="javascript:changeStatus(1)">代发货订单</a></li>';
						appendUlHtml += '<li class=""><a href="javascript:changeStatus(3)">已发货订单</a></li>';
					}
					else
					{
						appendUlHtml += '<li ><a href="javascript:changeStatus(1)">代发货订单</a></li>';
						appendUlHtml += '<li class="active"><a href="javascript:changeStatus(3)">已发货订单</a></li>';
					}
					$("#orderTab").html(appendUlHtml);
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
           				appendHtml += '<td class="m_width_30">'+value.goodsName+'</td>';
           				appendHtml += '<td class="m_width_10">'+value.counts+'</td>';
           				appendHtml += '<td class="m_width_10">'+value.receiver+'</td>';
           				appendHtml += '<td class="m_width_10">'+value.phone+'</td>';
           				appendHtml += '<td class="m_width_30">'+value.address+'</td>';
           				if(status == 1)
           				{
           					appendHtml += '<td class="m_width_10">';
           					appendHtml += '<a href="javascript:showModal('+value.id+',\''+value.goodsName+'\',\''+value.receiver+'\',\''+value.phone+'\')">确定</a>';
           					appendHtml += '</td>';
           				}
           				else
       					{
           					appendHtml += '<td class="m_width_10">已发货</td>';
       					}

           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
				},
			});
		}
		
		//分页相关
		function jumpPage(type)
		{
			var cPage = $("#currentPage").html();
			var totalPage = $("#totalPage").html();

			var cPageInt = parseInt(cPage);
			var totalPageInt = parseInt(totalPage);
						
			var newCPageInt = returnCPageInt(type,cPageInt,totalPageInt);
			if(newCPageInt < 0){
				return;
			}else{
				cPageInt = newCPageInt;
			}	
			var status = $("#status").val();
			var condition = $("#condition").val();
			loadOrdersList(status, condition, cPageInt);
		    $("#currentPage").html(cPageInt);
		}
	</script>
</html>