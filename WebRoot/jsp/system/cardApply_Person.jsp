<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - 补卡申请</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@include file="/public_module/header.jsp" %>
		<div class="manager_search_box">
			<div class="search_main">
				<button type="button" class="fa fa-search search_submit" onclick="getData(1);"></button>
				<input class="search_text" type="text" id="realName" placeholder="请输入申请人名称,手机号码..." value=""></input>
			</div> 
		</div>
		<div class="richxManager">
			<h3 class="margin_top_15"><a class="type" style="padding-right: 20px;" href="<%=basePath%>cardApply/toCardApplyAuditList.do">学校补办卡</a> <a href="<%=basePath%>cardApply/toCardApplyPerson.do" class="type type_select" style="padding-left:20px;border-left:2px solid #e4e4e4">个人补办卡</a></h3>
			<ul class="mtabs margin_top_15" id="tabs_">
					<li class="active"><a href="javascript:void(0);" onclick="showList(0,this);" style="cursor: pointer;">待审批</a></li>
					<li><a href="javascript:void(0);" onclick="showList(1,this);">已审批</a></li>
			</ul>
			<h4 class="margin_top_15">补办卡列表</h4>
			<div class="con">
				<div class="tab-content">
				<div class="tab-pane active" id="tab_1_1">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th class="m_width_15">申请人</th>
								<th class="m_width_15">订单状态</th>
								<th class="m_width_20">申请人电话</th>
								<th class="m_width_10">缴费</th>
								<th class="m_width_25">申请时间</th>
								<th class="m_width_15">操作</th>
							</tr>
						</thead>
						<tbody id="accordion0">
						</tbody>
					</table>
				</div>
				<div class="tab-pane" id="tab_1_2">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th class="m_width_15">申请人</th>
								<th class="m_width_15">订单状态</th>
								<th class="m_width_15">申请人电话</th>
								<th class="m_width_10">缴费</th>
								<th class="m_width_20">申请时间</th>
								<th class="m_width_10">审核状态</th>
								<th class="m_width_15">操作</th>
							</tr>
						</thead>
						<tbody id="accordion1">
						</tbody>
					</table>
				</div>
				</div>
			</div>
			<%@include file="/public_module/public_page.jsp" %>
		</div>
		<input value="" type="hidden" id="status_">
	<%@include file="/public_module/public_footer.jsp" %>
	</body>
	<%@include file="/public_module/public_js.jsp" %>
	
	<script type="text/javascript">
		$(function() {
			$(".menu_li a").removeClass("hover");
			$("#menu1").addClass("hover");
			$(".mtabs li").eq(0).css({"border-right":"none"});
			$("#status_").val(0);
			//导航定位
			$(".menu_li a").removeClass("hover");
			$("#menu1").addClass("hover");
			getData(1);
		});
		function showList(type,obj){
			$("#tabs_").find("li").removeClass("active");
			$(obj).parent().addClass("active");
			//待审核
			if(type==0){
			$("#tab_1_1").show();	
			$("#tab_1_2").hide();
			}else{//已审核
			$("#tab_1_1").hide();	
			$("#tab_1_2").show();	
			}
			$("#status_").val(type);
			getData(1);
		}
		function getData(page)
		{
			var type=$("#status_").val();
			var realName=$("#realName").val();
			var status=0;
			if(type!=0){
				status="1,2";	
			}
			$.ajax({
				type: "post",
				url: "<%=basePath%>cardApply/getReissuedcardPerson.do",
				data:{
					"realName" : realName,
					"status" : status,
					"page" : page
				},
				dataType:"json",
				success: function(data) 
				{
					$("#currentPage").html(data.currentPage);
					$("#totalPage").html(data.totalPage);
				    if(data.isPermission){
				    	var list=data.list;
				    	if(status==0){
				    		if(list.length>0)
				    		{
					    		status0Data(list);	
				    		}
				    	}else{
				    		if(list.length>0){
					    		status1Data(list);	
				    		}	
				    	}
				    	
				    }else{
				    	layer.msg("您没有权限访问",{icon:4,time:2500});
				    }
				}
			});	
			
		}
		 function status0Data(data){
			 var html='';
			for(var i=0;i<data.length;i++)
 			{
				html+='<tr>';
				html+='<td>'+data[i].applyUserName+'</td>';
				////状态：0待支付 1支付成功 2支付失败 3完成 4付款一部分
				if(data[i].orderStatue==0){
				html+='<td>待支付</td>';
				}else if(data[i].orderStatue==1){
				html+='<td>支付成功</td>';
				}else if(data[i].orderStatue==2){
				html+='<td>支付失败</td>';	
				}else if(data[i].orderStatue==3){
				html+='<td>完成</td>';	
				}else if(data[i].orderStatue==4){
				html+='<td>付款一部分</td>';	
				}
				html+='<td>'+data[i].phone+'</td>';
				html+='<td>'+data[i].orderMoney+'</td>';
				html+='<td>'+data[i].applyTime+'</td>';
				html+='<td><a class="detal">查看详情</a></td>';
				html+='</tr>';
				html+='<tr class="persionner_info">';
				html+='<td colspan="6" class="m_padding_0">';
				html+='<div style="border:1px solid #1490f4">';
				html+='<table class="table table-bordered">';
				html+='<tr>';
				html+='<td class="active">补办人：</td>';
				html+='<td>'+data[i].realName+'</td>';
				html+='<td class="active">学号</td>';
				html+='<td>'+data[i].code+'</td>';
				html+='<td class="active">所属学校：</td>';
				html+='<td>'+data[i].schoolName+'</td>';
				html+='</tr>';
				html+='<tr>';
				//类型 0:补卡 1:办卡
				if(data[i].type==0){
					html+='<td class="active">类型</td>';
					html+='<td>补卡</td>';
				}else{
					html+='<td class="active">类型</td>';
					html+='<td>办卡</td>';
				}
				html+='<td class="active">所属班级：</td>';
				html+='<td>'+data[i].userInfo+'</td>';
				html+='<td class="active">更新时间：</td>';
				html+='<td>'+data[i].updateTime+'</td>';
				html+='</tr>';
				html+='<tr>';
				if(typeof(data[i].remark)!="undefined"){
					html+='<td class="active">备注</td>';
					html+='<td colspan="3">'+data[i].remark+'</td>';
				}else{
					html+='<td class="active">备注</td>';
					html+='<td colspan="3"></td>';
				}
			
				html+='<td class="active">照片</td>';
				var imgsrc="";
				if(data[i].attachPath=='' || data[i].attachPath==null || typeof(data[i].attachPath)=="undefined"){
				}else{
				imgsrc='<img style="height:130px" src="<%=Cons.IMGBASEPATH%>'+data[i].attachPath+'">';
				}
				html+='<td>'+imgsrc+'</td>';
				html+='</tr>';
				html+='<tr>';
				html+='<td  class="text_align" colspan="6">';
				html += '<c:if test="${sessionScope.user.username eq \'sysadmin\'}">'
				html+='<button class="btn green btn-sm" onclick="passRefuse('+data[i].id+',1,'+data[i].applyUserId+',\''+data[i].schoolId+'\')">通过</button>';
				html+='<button class="btn btn-sm" onclick="passRefuse('+data[i].id+',2,'+data[i].applyUserId+',\''+data[i].schoolId+'\')">拒绝</button>';
				html += '</c:if>'
				html+='</td>';
				html+='</tr>';
				html+='<tr>';
				html+='<td  class="text_align" colspan="6">';
				html+='</td>';
				html+='</tr>';
				html+='</table>';
				html+='</div>';
				html+='</td>';
				html+='</tr>';
 			}
			$("#accordion0").html(html);
			//显示详情
  			$(".detal").on("click",function(){
  				if($(this).hasClass("open")){
  					$(this).parent().parent().next(".persionner_info").hide();
  					$(this).removeClass("open")
  				}else{
  					$(this).addClass("open")
  					$(".persionner_info").removeAttr("style");
  					$(this).parent().parent().next(".persionner_info").show();
  				}
  			})
		}
		 function status1Data(data){
			var html='';
			for(var i=0;i<data.length;i++)
   			{
				html+='<tr>';
				html+='<td>'+data[i].applyUserName+'</td>';
				////状态：0待支付 1支付成功 2支付失败 3完成 4付款一部分
				if(data[i].orderStatue==0){
				html+='<td>待支付</td>';
				}else if(data[i].orderStatue==1){
				html+='<td>支付成功</td>';
				}else if(data[i].orderStatue==2){
				html+='<td>支付失败</td>';	
				}else if(data[i].orderStatue==3){
				html+='<td>完成</td>';	
				}else if(data[i].orderStatue==4){
				html+='<td>付款一部分</td>';	
				}
				html+='<td>'+data[i].phone+'</td>';
				html+='<td>'+data[i].orderMoney+'</td>';
				html+='<td>'+data[i].applyTime+'</td>';
				if(data[i].auditstatus==1)
				{
					html+='<td>已通过</td>';
				}else{
					html+='<td>已拒绝</td>';	
				}
				html+='<td><a class="detal">查看详情</a></td>';
				html+='</tr>';
				html+='<tr class="persionner_info">';
				html+='<td colspan="7" class="m_padding_0">';
				html+='<div style="border:1px solid #1490f4">';
				html+='<table class="table table-bordered">';
				html+='<tr>';
				html+='<td class="active">补办人：</td>';
				html+='<td>'+data[i].realName+'</td>';
				html+='<td class="active">学号</td>';
				html+='<td>'+data[i].code+'</td>';
				html+='<td class="active">所属学校：</td>';
				html+='<td colspan="2">'+data[i].schoolName+'</td>';
				html+='</tr>';
				html+='<tr>';
				//类型 0:补卡 1:办卡
				if(data[i].type==0){
					html+='<td class="active">类型</td>';
					html+='<td>补卡</td>';
				}else{
					html+='<td class="active">类型</td>';
					html+='<td>办卡</td>';
				}
				html+='<td class="active">所属班级：</td>';
				html+='<td>'+data[i].userInfo+'</td>';
				html+='<td class="active">更新时间：</td>';
				html+='<td  colspan="2" >'+data[i].updateTime+'</td>';
				html+='</tr>';
				html+='<tr>';
				if(typeof(data[i].remark)!="undefined"){
					html+='<td class="active">备注</td>';
					html+='<td colspan="3">'+data[i].remark+'</td>';
				}else{
					html+='<td class="active">备注</td>';
					html+='<td colspan="3"></td>';
				}
			
				html+='<td class="active">照片</td>';
				var imgsrc="";
				if(data[i].attachPath=='' || data[i].attachPath==null || typeof(data[i].attachPath)=="undefined"){
				}else{
				imgsrc='<img style="height:130px" src="<%=Cons.IMGBASEPATH%>'+data[i].attachPath+'">';
				}
				html+='<td colspan="2">'+imgsrc+'</td>';
				html+='</tr>';
				html+='</table>';
				html+='</div>';
				html+='</td>';
				html+='</tr>';
   			}
			$("#accordion1").html(html);
			//显示详情
  			$(".detal").on("click",function(){
  				if($(this).hasClass("open")){
  					$(this).parent().parent().next(".persionner_info").hide();
  					$(this).removeClass("open")
  				}else{
  					$(this).addClass("open")
  					$(".persionner_info").removeAttr("style");
  					$(this).parent().parent().next(".persionner_info").show();
  				}
  			})
		}
		//通过
		function passRefuse(id,type,applyUserId,schoolId){
			var content = "确定通过补办卡申请?";
			if(type == 1){
				content = "确定【通过】补办卡申请?";
			}else{
				content = "确定【拒绝】补办卡申请? 拒绝之后会将购买成功的补办卡费用退还到申请人的亦信钱包中。";
			}
			var ll=layer.confirm(content, {
				  btn: ['确定','取消'] //按钮
				}, function(){
				 layer.close(ll);
				 var indexlayer = layer.msg('正在处理数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
				 $.ajax({
						type: "post",
						url: "<%=basePath%>cardApply/modifyReissuedcardPerson.do",
						data:{
							"id" : id,
							"status" : type,
							"applyUserId":applyUserId,
							"schoolId":schoolId
							 },
							 dataType:"json",
							success: function(data) 
							{
								layer.close(indexlayer);
							    if (data=="0"){
							    	layer.msg("处理失败！",{icon:2,time:1000});
							    }else{
							    	layer.msg("处理成功！",{icon:1,time:1000});
							    	window.location.reload();
							    }
							   
							}
					});
				}, function(){
				 
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
			getData(cPageInt);
		    $("#currentPage").html(cPageInt);
		}
		
	</script>
</html>