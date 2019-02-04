<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>智慧校园服务费代充</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
		<input class="themes" type="hidden" value="<%=ThemePath%>">
	    <!-- 公共顶部开始-->
	    <%@ include file="/public_module/public_header.jsp"%>    
	    <!--公共顶部结束-->
	    <div class="clearfix"> </div>
	    <!-- 内容页开始 -->
	    <div class="page-container">
	        <!--主菜单开始-->
	        <%@include file="/public_module/public_menu.jsp"%>
	        <!--主菜单结束-->
	        <div class="page-content-wrapper">
	            <div class="page-content m_overflow_hidden m_page_content">
	            	<!-- 页面内容开始 -->
	            	<div class="col-md-12 col-sm-12 m_page_con">
	                <div class="page-bar m_margin_0_0_0_0">
	                    <ul class="page-breadcrumb">
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">智慧校园服务费</a><i class="fa fa-circle"></i></li>
	                        <li><span>智慧校园服务费代充</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">智慧校园服务费代充</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<r:right rightCode="replaceRechargeManager">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
											</li>
										</r:right>
									</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>智慧校园服务费代充</div>
	                            </div>
	                            <div class="portlet-body" id="orderMessage">
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                        <!-- 分页开始 -->
	                       <%--  <%@include file="/public_module/public_page.jsp" %> --%>
	                        <!-- 分页结束 -->
	                    </div>
	                </div>
	                </div>
	                <!--页面内容结束 -->
	            </div>
	        </div>
	        <!-- 亦信聊天开始 -->
	    	<%@ include file="/public_module/public_QQ.jsp" %>
	        <!-- 亦信聊天结束 -->
	    </div>
	    <!-- 内容页结束 -->
	    <!-- 底部开始 -->
	    <%@ include file="/public_module/public_footer.jsp" %>
	    <!-- 底部结束 -->
	    </body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
   	<div class="modal fade" id="small" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
	        <div class="modal-content">
				<div class="modal-header">
					 <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">短信购买</h4>
				</div>
				<div class="modal-body select_personnel">
					<div class="form-group m_overflow_hidden">
                        <label class="control-label col-md-2">查找人员：</label>
                        <div class="col-md-8">
                             <input type="text" id="name" class="form-control m_input">
                        </div>
                         <div class="col-md-2">
                             <input type="button" class="btn green" id="search" value="搜索">
                        </div>
                    </div>
                    <div class="form-group m_overflow_hidden">
                        <label class="control-label col-md-2">选择人员：</label>
                        <ul class="col-md-10 student_list" id="student">
                        </ul>
                    </div>
					<ul>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal" class="btn">取消</button>
					<button type="button" class="btn green" id="save">确定</button>
				</div>
				<input type="hidden" id="type" value="">
				<input type="hidden" id="productId" value="">
				<input type="hidden" id="count" value="">
			</div>
		</div>
	</div>
	<script>
		 jQuery(document).ready(function() {      
			loadSubMenu("messageManage"); 
			//选取当前菜单位置
			setActive("messageManage","replaceRecharge");   
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			//全选
			$(".all").on("click",function(){
				if($(this).hasClass("icon-ok")){
					$(this).removeClass("icon-ok");
					$(".select").removeClass("icon-ok");
					$(".num").text("0")
				}else{
					$(this).addClass("icon-ok");
					$(".select").addClass("icon-ok");
					$(".num").text($(".select.icon-ok").length);
				}
			})
			//单选
			$(".select").on("click",function(){
				if($(this).hasClass("icon-ok")){
					$(this).removeClass("icon-ok");
					$(".num").text($(".select.icon-ok").length);
				}else{
					$(this).addClass("icon-ok");
					$(".num").text($(".select.icon-ok").length);
				}
			})
			loadReplaceRecharge();
			//点击tab页切换角色
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadReplaceRecharge();
			});

			$("#save").on("click",function(){
				if($("#student").find(".select").length==0)
				{
					layer.msg("至少选择一个充值对象！");
					return;
				}
				//进入订单付款页面
				toOrderPay();
				$(this).attr({
					"data-toggle":"modal", 
				})
				$("#name").val("");
			})
			$("#cancel").on("click",function(){
				$("#name").val("");
			})
			
			$("#search").on("click",function(){
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				var content = $("#name").val();
				var orderMessageId = $("#productId").val();
				loadStudentByClazzId(orderMessageId,roleCode,content)
			})
		});

		function loadReplaceRecharge()
		{
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			$.ajax({
				type: "post",
				url: "<%=basePath%>replaceRecharge/loadReplaceRecharge.do",
				data:{roleCode : roleCode},
				success: function(data){
					var list = eval("(" + data + ")");
					var appendHtml = "";
					$.each(list,function(n,value){
						if((n==0)||(n%2==0&&n>=2)){
							appendHtml += '<div class="row">';
						}
							appendHtml += '<div class="col-md-6 col-sm-6">';
								if(value.type == 0){
									appendHtml += '<div class="replaceMonth">';
									appendHtml += '<h2>'+value.name+'</h2>';
									appendHtml += '<div class="info" style="cursor:pointer;" title="有效期：'+value.startTime+' 至 '+value.endTime+'">';
									appendHtml += '<b><i class="fa fa-envelope-o"></i></b>';
									appendHtml += '<p>';
									appendHtml += '<span>服务费：<em class="text-error">'+value.servicePrice+'</em>&nbsp元</span>';
									appendHtml += '<span>卡押金：<em class="text-error">'+value.cardPrice+'</em>&nbsp元</span>';
									appendHtml += '<span style="cursor:pointer;" title="'+value.startTime+' 至 '+value.endTime+'">有效期：'+value.startTime+' 至 '+value.endTime+'</span>';
									appendHtml += '</p>';
									appendHtml += '</div>';
									if("${status}"==1){//线上
									appendHtml += '<input type="button" class="btn red m_btn" data-toggle="modal" href="#small" onclick="getId(0,this,'+value.type+','+value.productId+')" value="购买" >';
									}else if("${status}"==0){//学校统一缴费
										appendHtml += '<input type="button" class="btn m_btn" value="学校统一收费" >';	
									}
									appendHtml += '<input type="hidden" class="product" value="'+value.productId+'">';
									appendHtml += '<input type="hidden" class="type" value="'+value.type+'">';
									appendHtml += '</div>';
								}else{
									appendHtml += '<div class="replaceNumber">';
									appendHtml += '<h2>'+value.name+'</h2>';
									appendHtml += '<div class="info">';
									appendHtml += '<b><i class="fa fa-envelope-o"></i></b>';
									appendHtml += '<p>';
									appendHtml += '<span>单条价格：<em class="text-error">'+value.servicePrice+'</em>&nbsp元/条</span>';
									appendHtml += '<span>卡押金：<em class="text-error">'+value.cardPrice+'</em>&nbsp元/条</span>';
									appendHtml += '<span>购买条数：<input type="text" id="counts" class="num_input" oldCount="0" value="0" name="count" oninput="onlyNonNegative(this,'+value.servicePrice+','+value.cardPrice+','+n+')" onkeyup="onlyNonNegative(this,'+value.servicePrice+','+value.cardPrice+','+n+')" ></span>';
									appendHtml += '<span>动态计费：<em class="text-error totalFeeForPerson" id="price_'+n+'">0.0</em>&nbsp元</span>';
									appendHtml += '</p>';
									appendHtml += '</div>';
									if("${status}"==1){//线上
									appendHtml += '<input type="button" class="btn red m_btn" onclick="getNum(0,this,'+value.type+','+value.productId+')" value="购买">';
									}else if("${status}"==0){//学校统一缴费
									appendHtml += '<input type="button" class="btn m_btn" value="学校统一收费" >';		
									}
									appendHtml += '	<input type="hidden" class="product" value="'+value.productId+'">';
									appendHtml += '	<input type="hidden" class="type" value="'+value.type+'">';
									appendHtml += '</div>';
								}
								appendHtml += '</div>';
						if(n==1|| (((n+1)%2==0)&&((n+1)>2))){
							appendHtml += '</div>';
						}

					});
					$("#orderMessage").html(appendHtml);
				},
			});
		}

		//加载学生列表
		function loadStudentByClazzId(orderMessageId,roleCode,content)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>replaceRecharge/loadStudentByClazzId.do",
				data:{
						orderMessageId : orderMessageId,
						roleCode : roleCode,
						content : content
					 },
				success: function(data){
					var list = eval("(" + data + ")");
					var appendHtml = "";
					$.each(list,function(n,value)
					{
						//if(value.type == undefined)
						//{	
							appendHtml += '<li class="no_select" id="'+value.userId+'" attr="'+value.realName+'">'+value.realName;
							$.each(value.parentList,function(m,parent)
							{
								appendHtml += '<em>(家长'+(m+1)+'：'+parent.parentname+')</em>';
							});
							appendHtml += '</li>';
						//}
						/* else
						{
							appendHtml += '<li class="selected" id="'+value.userId+'" attr="'+value.realName+'">'+value.realName;
							$.each(value.parentList,function(m,parent)
							{
								appendHtml += '<em>(家长'+(m+1)+'：'+parent.parentname+')</em>';
							});
							appendHtml += '</li>';
						} */
					});

					$("#student").html(appendHtml);
					 $("#student .no_select").on("click",function(){
							if($(this).hasClass("select")){
								$(this).removeClass("select");
							}else{
								$(this).addClass("select");
							}
					 })
				},
			});
		}
		
		//作用于弹框
		function getId(num,obj,type,productId){
			$("#type").val("");
			$("#productId").val("");
			$("#count").val("");
			if(type==1)
			{
				var count = $(obj).parents(".replaceNumber").find(".num_input").val();
				if(count=="" || count == 0)
				{
					layer.msg("代购数量不能小于1");
					return;
				}else if(count > 10000)
				{
					layer.msg("一次性最大只能代购10000条");
					return;
				}
				$("#count").val(count);
			}
			$("#type").val(type);
			$("#productId").val(productId);
			
			$(".page").removeAttr("style");
			$(".page"+num).show();
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			loadStudentByClazzId(productId,roleCode,null);
		}
		
		//作用于弹框
		function getNum(num,obj,type,productId){
			$("#type").val("");
			$("#productId").val("");
			$("#count").val("");
			if(type==1)
			{
				var count=$(obj).prev().find(".num_input").val();
				if(count==""||count==0){
					layer.msg("代购数量不能小于1");
				}else if(count > 10000)
				{
					layer.msg("一次性最大只能代购10000条");
					return;
				}else{
					$(obj).attr({
						"data-toggle":"modal", 
						"href":"#small"
					})
				};
				$("#count").val(count);
			}
			$("#type").val(type);
			$("#productId").val(productId);
			
			$(".page").removeAttr("style");
			$(".page"+num).show();
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			loadStudentByClazzId(productId,roleCode,null);
		}
		
		//1.去掉多余的小数点  
		//2.保证只能输入小数点或数字 
		function onlyNonNegative(obj,servicePrice,cardPrice,n) {
			var evt = window.event || arguments[0]; 
			if(evt.keyCode==39 || evt.keyCode==37){
				return;
			}
			var oldCount=$(obj).attr("oldCount");//原数量
			var newCount=$(obj).val();//新数量
			if($.trim(newCount)==''){
				 layer.tips("请输入购买数量",$(obj));
				  /* $(obj).val(oldCount);
				  $(obj).attr("old",oldCount);
				  var price=oldCount*servicePrice;
					  price+=cardPrice;
				  $("#price_"+n).text(price.toFixed(2));	 */
				 return;
			}
			 var reg = new RegExp("^[0-9]*$");
			 if(!reg.test(newCount)){
			     layer.tips("请输入正整数,且大于0",$(obj));
			     $(obj).val(oldCount);
			     return;
			 }
			 var price=newCount*servicePrice;
				  price+=cardPrice;
			  $(obj).val(newCount);
			  $(obj).attr("old",newCount);
			  $("#price_"+n).text(price.toFixed(2));
			
			/*  var inputChar = event.keyCode;  
			 //1.判断是否有多于一个小数点  
			 if(inputChar==190 ) {//输入的是否为.  
			  var index1 = obj.value.indexOf(".") + 1;//取第一次出现.的后一个位置  
			  var index2 = obj.value.indexOf(".",index1);  
			  while(index2!=-1) {  
			   //alert("有多个.");  
			     
			   obj.value = obj.value.substring(0,index2);  
			   index2 = obj.value.indexOf(".",index1);  
			  }  
			 }  
			 //2.如果输入的不是.或者不是数字，替换 g:全局替换  
			 obj.value = obj.value.replace(/[^(\d|.)]/g,"");  
			 if (typeof(obj.value) != "undefined" && !isNaN(obj.value) && obj.value != ""){
				 var totalFee = Math.round((parseFloat(obj.value) * parseFloat(price))*100)/100;
				 $(obj).parent().next().find(".totalFeeForPerson").text(totalFee); 
			 }else{
				 $(obj).parent().next().find(".totalFeeForPerson").text("0.0"); 
			 } */
		} 
		
		function toOrderPay()
		{
			var flag = true;
			var map = {};
			var html = '';
			$("#student").find(".select").each(function(n)
			{
				html += '<li>'+$(this).html()+'</li>';
		    	var key = $(this).attr("id");
				map[key] =$(this).attr("attr");
			});
			var type = $("#type").val();
			if(type == 1){
				var count= $("#count").val();
				if(count=="" || count == 0)
				{
					layer.msg("代购数量不能小于1");
					flag = false;
					return flag;
				}else if(count > 10000)
				{
					layer.msg("一次性最大只能代购10000条");
					flag = false;
					return flag;
				}
			}
			
			//询问框
			layer.confirm(
				'<div class="alert alert-danger"><b>您确定要为以下人员充值吗？</b></div><ul class="col-md-10 student_list">'+html + '</ul>', 
				{
				  btn: ['确定','取消'], //按钮
				 area: ['820px', 'auto'],
				}, function(){
					layer.closeAll();
					window.open("<%=basePath%>replaceRecharge/toOrderMessagePay.do?studentList=" +JSON.stringify(map)+ "&productId=" + $("#productId").val()+ "&count="+$("#count").val());
				}, function(){
				});
			
		}
	</script>
</html>