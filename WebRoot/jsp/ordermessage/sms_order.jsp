<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
	<head>
	    <meta charset="utf-8" />
	    <title>智慧校园服务费</title>
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
		                        <li><span>智慧校园服务费</span></li>
		                    </ul>
		                </div>
	                	<h3 class="page-title">智慧校园服务费</h3>
	                	<div class="row">
	                    	<div class="col-md-12 col-sm-12">
		                    	<div class="m_margin_0_0_15_0">
		                    		<!-- 角色切换开始 -->
		                    		<ul class="nav nav-tabs sms_order_type"  id="userTab">
		                    			<li class="active"><a aria-expanded="true">个人</a></li>
										<r:right rightCode="schoolOrderMessage">
											<li class="school"><a aria-expanded="false">学校</a></li>
										</r:right>
		                            </ul>
		                    		<!-- 角色切换结束 -->
		                        </div>
		                        <!-- 页面搜索开始 -->
		                       	<div class="portlet box green m_margin_15_auto_0">
		                            <div class="portlet-title">
		                                <div class="caption">
		                                    <i class="fa fa-list"></i>智慧校园服务费
		                                </div>
		                            </div>
	                            	<div class="portlet-body m_overflow_hidden">
										<div class="sms_server" style="display:block" >
											<c:forEach items="${messageList}" var="product" varStatus="sta">
												<c:if test="${(sta.index==0) || (sta.index%2==0&&sta.index>=2) }">
													<div class="row">
												</c:if>
												<div class="col-md-6 col-sm-6">
													<div class="setMedal">
														<form class="form-horizontal" action="<%=basePath %>orderMessage/toOrderMessagePay.do" id="submitForm${sta.index}" target="_blank" method="post">
															<c:if test="${product.type==0}">
																<h2>${product.name}&nbsp;&nbsp;<span style="color: red;">应付金额：<em class="text-error">${product.price}</em>&nbsp元 </span></h2>
																<div class="info" style="cursor:pointer;" title="有效期：${product.startTime} 至 ${product.endTime}">
																	<b><i class="fa fa-envelope-o"></i></b>
																	<p>
						  											    <c:if test="${product.servicePrice>0}">
																		<span>服务费：<em class="text-error">${product.servicePrice}</em>&nbsp元
																		<c:if test="${product.isTeacher==0}">
																		<c:if test="${product.user.type==1}">(已购买)</c:if><c:if test="${product.user.type==0}">(未购买)</c:if>
																		</c:if>
																		<c:if test="${product.isTeacher==1}">
																		(教师子女,免服务费)
																		</c:if>
																		</span>
																		</c:if>
																		  <c:if test="${product.cardPrice>0}">
																		<span>卡押金：<em class="text-error">${product.cardPrice}</em>&nbsp元<c:if test="${product.user.cardPay==0}">(已支付)</c:if><c:if test="${product.user.cardPay==1}">(未支付)</c:if></span>
																		</c:if>
																		<span style="cursor:pointer;" title="${product.startTime} 至 ${product.endTime}">有效期：${product.startTime} 至  ${product.endTime}</span>
																		<span>学生姓名：${product.realName}(${product.clazzName})</span>
																	</p>
																</div>
															</c:if>
															<c:if test="${product.type==1}">
																<h2>产品：${product.name} &nbsp;<span style="color: red;">应付金额：<em class="text-error totalFeeForPerson" style="color: red;" id="price_${sta.index}">${product.price}</em>&nbsp元</span></h2>
																<div class="info">
																	<b><i class="fa fa-envelope-o"></i></b>
																	<p>
																	    <c:if test="${product.cardPrice>0}">
																	    <span>卡押金：<em class="text-error">${product.cardPrice}</em>&nbsp元/张<c:if test="${product.user.cardPay==0}">(已支付)</c:if><c:if test="${product.user.cardPay==1}">(未支付)</c:if></span>
																	    </c:if>
																	    <c:if test="${product.servicePrice>0}">
																		<span>服务费：<em class="text-error">${product.servicePrice}</em>&nbsp元/条
																		<c:if test="${product.isTeacher==0}">
																		<c:if test="${product.user.type==1}">(已购买)</c:if><c:if test="${product.user.type==0}">(未购买)</c:if>
																		</c:if>
																		<c:if test="${product.isTeacher==1}">
																		(教师子女,免服务费)
																		</c:if>
																		</span>
																		 <c:if test="${product.isTeacher==0&& product.user.type==0}">
																		<span>购买条数：<input value="1" type="text" name="count" old="1" id="count${sta.index}" oninput="onlyNonNegative(this,${product.servicePrice},${sta.index},${product.cardPrice},${product.user.cardPay})" onkeyup="onlyNonNegative(this,${product.servicePrice},${sta.index},${product.cardPrice},${product.user.cardPay})" class="num_input"></span>
																	 	</c:if> 
																		</c:if>
																		<span>学生姓名：${product.realName}(${product.clazzName})</span>
																	</p>
																</div>
															</c:if>
															<c:if test="${product.price>0}">
															<c:if test="${status==0}">
															<input type="button" class="btn m_btn" value="学校统一收费" >
															</c:if>
															<c:if test="${status==1}">
															   <input type="button" class="btn red m_btn" onclick="check(${sta.index},${product.type},${product.studentId})" value="购买" >
															</c:if>
															
															</c:if>
															<input type="hidden" name="id" value="${product.productId}">
															<input type="hidden" name="realName" value="${product.realName}">
															<input type="hidden" name="studentId" value="${product.studentId}">
														</form>
													</div>
												</div>
												<c:if test="${(sta.index==1) || (((sta.index+1)%2==0)&&((sta.index+1)>2))}">
													</div>
												</c:if>
											</c:forEach>
										</div>
									
									<r:right rightCode="schoolOrderMessage">
									<div class="school_con">
											<c:forEach items="${schoolmessageList}" var="product" varStatus="sta">
												<c:if test="${(sta.index==0) || (sta.index%2==0&&sta.index>=2) }">
													<div class="row">
												</c:if>
													<div class="col-md-6 col-sm-6">
														<div class="setMedal">
															<c:if test="${product.type==0}">
																<div class="customMonthForSchoolRange">
																	<h2>${product.name}</h2>
																	<div class="info">
																		<b><i class="fa fa-envelope-o"></i></b>
																		<p>
																			<span>服务费价格：<em class="text-error price">${product.price}</em>&nbsp元/月</span>
																			<span style="cursor:pointer;" title="自定义学校包月服务费,设置成功之后会显示在个人套餐中,生效时间从购买时间开始算起,方便家长购买,多买多优惠">服务费介绍：自定义学校包月服务费,设置成功之后会显示在个人套餐中,生效时间从购买时间开始算起,方便家长购买,多买多优惠</span>
																		</p>
																	</div>
																	<input type="button" class="btn green m_btn" data-toggle="modal" href="#small" onclick="getId(0,${product.productId})" value="自定义" >
																</div>
															</c:if>
															<c:if test="${product.type==1}">
																<div class="customnNumberForSchoolRange">
																	<h2>${product.name}</h2>
																	<div class="info">
																		<b><i class="fa fa-envelope-o"></i></b>
																		<p>
																			<span>服务费价格：<em class="text-error price">${product.price}</em>&nbsp元/条</span>
																			<span style="cursor:pointer;" title="购买单条条数服务于整个学校，直到用完为止">服务费介绍：购买单条条数服务于整个学校，直到用完为止</span>
																			<span> 剩余条数：<em class="text-error">${remainCount}</em>&nbsp条</span>
																		</p>
																	</div>
																	<input type="button" class="btn green m_btn" data-toggle="modal" href="#small" onclick="getId(1,${product.productId})" value="自定义" >
																</div>
															</c:if>
														</div>
													</div>
												<c:if test="${(sta.index==1) || (((sta.index+1)%2==0)&&((sta.index+1)>2))}">
													</div>
												</c:if>
											</c:forEach>
									</r:right>
									</div>
									</div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </div>
				<!-- 列表展现开始 -->
				<%-- <!-- 分页开始 -->
				<%@include file="/public_module/public_page.jsp" %>
				<!-- 分页结束 --> --%>
				<!--页面内容结束 -->
            </div>
        </div>
        <!-- 亦信聊天开始 -->
    	<%@ include file="/public_module/public_QQ.jsp" %>
        <!-- 亦信聊天结束 -->
	    <!-- 内容页结束 -->
	    <!-- 底部开始 -->
	    <%@ include file="/public_module/public_footer.jsp" %>
	    <!-- 底部结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
    <div class="modal fade" id="small" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="page page0" style="display:block">
			 <div class="modal-dialog modal-md">
		        <div class="modal-content">
					<div class="modal-body">
						<div class="setMeal_con">
							<form class="form-horizontal" action="<%=basePath %>orderMessage/doAddMessageFromSchoolCustom.do" id="customMonthSubmitFormForSchoolRange" method="post">
								<div class="modal_header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    				<h4 class="modal-title">学校短信数量服务</h4>
								</div>
								<div class="alert alert-danger m_margin_15_0">
                             		<p><span>服务费介绍：</span>自定义学校包月套餐,设置成功之后会显示在个人套餐中,生效时间从购买时间开始算起,方便家长购买,多买多优惠</p>
                             	</div>
                             	<div class="form-group">
                                    <label class="control-label col-md-3">套餐名称：</label>
                                    <div class="col-md-8">
                                    	<input type="text" class="form-control" id="orderMessageNamePage0" value="" readonly="readonly">
                                    </div>
                                </div>
                             	<div class="form-group">
                                    <label class="control-label col-md-3" >价格：</label>
                                    <div class="col-md-8">
                                    	<input type="text" class="form-control" id="orderMessagePricePage0" value="" readonly="readonly">
                                    </div>
                                </div>
                             	<div class="form-group">
                                    <label class="control-label col-md-3" >自定义名称：</label>
                                    <div class="col-md-8">
                                    	<input type="text" class="form-control" name="customName" id="orderMessageNameSelf" value="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3" >月数：</label>
                                    <div class="col-md-8">
                                    	<input name="customMonthCount"  type="text" class="form-control customMonthCount" oninput="onlyNonNegativeForSchoolRande(this,'page0')" onkeyup="onlyNonNegativeForSchoolRande(this,'page0')" contenteditable="true" placeholder="自定义">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3" >金额：</label>
                                    <div class="col-md-8">
                                    	<input type="num" class="form-control" id="totalFeeForSchoolNumPage0" placeholder="金额">
                                    </div>
                                </div>
								<div class="form-group">
                                    <label class="control-label col-md-3">适用范围：</label>
                                    <div class="col-md-8">
                                         <select class="form-control" tabindex="1" name="gradeIdList" id="gradeList">
										</select>
                                    </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="control-label col-md-3">选择对象：</label>
                                     <div class="col-md-4">
                                         <select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj"></select>															
                                     </div>
                                     <div class="col-md-1">
                                       	<button type="button" class="btn default btn-block" id="add" style="display:block"><i class="fa fa-angle-right"></i></button>
										<button type="button" class="btn default btn-block" id="remove" style="display:block"><i class="fa fa-angle-left"></i></button>
										<button type="button" class="btn green btn-block" id="addAll" style="display:block"><i class="fa fa-angle-double-right"></i></button>
										<button type="button" class="btn green btn-block" id="removeAll" style="display:block"><i class="fa fa-angle-double-left"></i></button>
									</div>
                                    <div class="col-md-4">
										<select class="form-control sms_select" multiple="multiple" id="selectedObj" name="selectedObj" ></select>
										<select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj1" style="display : none"></select>
                                    </div>
                                </div>
								<div class="modal_footer">
									<input type="button" class="btn red" onclick="checkCustomMonthForSchoolRange()"  value="保存">
									<button class="btn" data-dismiss="modal" type="button">取消</button>
								</div>
								<input class="customMonthProductId" type="hidden" name="id" value="">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="page page1">
		 	<div class="modal-dialog modal-md">
	       		<div class="modal-content">
					<div class="modal-body">
							<form class="form-horizontal" action="<%=basePath %>orderMessage/toOrderMessagePayForSchoolRange.do" id="customNumberFormForSchoolRange" target="_blank" method="post">
								<div class="modal_header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    				<h4 class="modal-title">自定义学校短信数量服务</h4>
								</div>
								<div class="modal_body form-horizontal">
									<div class="form-body">
                                        <div class="alert alert-danger m_margin_15_0">
                                       		<b>服务费介绍：购买单条条数服务于整个学校，直到用完为止</b> 
                                       	</div>
                                       	<div class="form-group">
                                            <label class="control-label col-md-2" >名称</label>
                                            <div class="col-md-8">
                                            	<input type="text" class="form-control" id="orderMessageName" value="" readonly="readonly">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-2" >价格</label>
                                            <div class="col-md-8">
                                            	<input type="text" class="form-control" id="orderMessagePrice" value="" readonly="readonly">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-2" >数量</label>
                                            <div class="col-md-8">
                                            	<div class="input-inline input-medium">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-cart-plus"></i>
                                                        </span>
                                                        <input type="num" class="form-control customNumber" placeholder="数目" name="customNumber" oninput="onlyNonNegativeForSchoolRande(this,'page1')" onkeyup="onlyNonNegativeForSchoolRande(this,'page1')"> </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-2" >金额</label>
                                            <div class="col-md-8">
                                            	<div class="input-inline input-medium">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-cny"></i>
                                                        </span>
                                                        <input type="num" class="form-control" id="totalFeeForSchoolNum" placeholder="金额"> </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
								</div>
								<div class="modal_footer">
									<input type="button" class="btn green m_btn" onclick="checkCustomNumberForSchoolRange()" value="购买" >
									<button class="btn" data-dismiss="modal" type="button">取消</button>
								</div>
								<input class="customNumberProductId" type="hidden" name="id" value="">
							</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>

		jQuery(document).ready(function() { 
			loadSubMenu("messageManage"); 
			//选取当前菜单位置
			setActive("messageManage","orderMessageManager");    
		   $(".sms_order_type li").on("click",function(){
				$(this).addClass("active").siblings().removeClass("active");
				if($(this).text()=='个人'){
					$(".sms_server").show();
					$(".school_con").removeAttr("style");
				}else{
					$(".school_con").show();
					$(".sms_server").removeAttr("style");
				}
		   });
		   //初始化选择年级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#gradeList").change(function(){
				//班级ID
				var gradeId = $(this).val().replace("G", "");
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (gradeId != 0)
				{
					$.ajax({
						type: "post",
						url: "<%=basePath%>baseData/getClazzListByGradeId.do",
						data:{
								gradeId : gradeId
							},
						success: function(data){
							var list = $.parseJSON(data);
							var appendHtml = '';
							$.each(list, function(n, value) {
		           				appendHtml += '<option value="C' + value.id + '">' + value.clazzName + '</option>';
		           			});  
		           			
							$("#toSelectObj").html(appendHtml);
		           			$("#toSelectObj1").html(appendHtml);
						},
					});
				}
				else
				{
					var appendHtml = $("#gradeList").html();

					$("#toSelectObj").html(appendHtml);
					$("#toSelectObj option[value='0']").remove();
					$("#toSelectObj1").html(appendHtml);
					$("#toSelectObj1 option[value='0']").remove();
				}
			});
         
			//将option从待发送对象移到发送对象的div中
			$("#toSelectObj").dblclick(function(){
           	var $options = $('#toSelectObj option:selected');//获取当前选中的项  
           	var $remove = $options.remove();//删除下拉列表中选中的项  
           	$remove.appendTo('#selectedObj');//追加给对方
           	
       		var i=0;
       		var length = $("#selectedObj option").length;
       		
       		while(i<length){
       			var j=i+1;
       			while(j<$("#selectedObj option").length){

       				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
           				$("#selectedObj option")[j].remove();
           				j++;   
       				}else{  
           				j++;   
       				}   
       			}  
       			i++;   
       		} 		
			});

			//将option从发送对象移到待发送对象的div中
			$("#selectedObj").dblclick(function(){
           	var $removeOptions = $('#selectedObj option:selected');  
           	$removeOptions.appendTo('#toSelectObj');//删除和追加可以用appendTo()直接
       		var i=0;
       		var length = $("#toSelectObj option").length;
       		
       		while(i<length){
       			var j=i+1;
       			while(j<$("#toSelectObj option").length){

       				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
           				$("#toSelectObj option")[j].remove();    
           				j++;   
       				}else{  
           				j++;   
       				}   
       			}  
       			i++;   
       		}             	
			});

			$('#add').click(function(){
	        	var $options = $('#toSelectObj option:selected');//获取当前选中的项  
	        	var $remove = $options.remove();//删除下拉列表中选中的项  
	        	$remove.appendTo('#selectedObj');//追加给对方
	        	
	    		var i=0;
	    		var length = $("#selectedObj option").length;
	    		
	    		while(i<length){
	    			var j=i+1;
	    			while(j<$("#selectedObj option").length){
	
	    				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
	        				$("#selectedObj option")[j].remove();   
	        				j++;   
	    				}else{  
	        				j++;   
	    				}   
	    			}  
	    			i++;   
	    		} 				
				
	
	    	});  
	      
	    	$('#remove').click(function(){  
	
	        	var $removeOptions = $('#selectedObj option:selected');  
	        	$removeOptions.appendTo('#toSelectObj');//删除和追加可以用appendTo()直接
	        	
	    		var i=0;
	    		var length = $("#toSelectObj option").length;
	    		
	    		while(i<length){
	    			var j=i+1;
	    			while(j<$("#toSelectObj option").length){
	
	    				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
	        				$("#toSelectObj option")[j].remove();    
	        				j++;   
	    				}else{  
	        				j++;   
	    				}   
	    			}  
	    			i++;   
	    		} 
	    	}); 
	      
	    	$('#addAll').click(function(){  
	        	var $options = $('#toSelectObj option');  
	        	$options.appendTo('#selectedObj');  
	        	$("#selectedObj option").attr("selected",true);
	    		var i=0;
	    		var length = $("#selectedObj option").length;
	    		
	    		while(i<length){
	    			var j=i+1;
	    			while(j<$("#selectedObj option").length){
	
	    				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
	        				$("#selectedObj option")[j].remove(); 
	        				j++;   
	    				}else{  
	        				j++;   
	    				}   
	    			}  
	    			i++;   
	    		}	
	        	
	    	});  
	      
	    	$('#removeAll').click(function(){ 
	        	var $options = $('#selectedObj option');  
	        	$options.appendTo('#toSelectObj'); 
	        	
	    		var i=0;
	    		var length = $("#toSelectObj option").length;
	    		
	    		while(i<length){
	    			var j=i+1;
	    			while(j<$("#toSelectObj option").length){
	
	    				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
	        				$("#toSelectObj option")[j].remove();    
	        				j++;   
	    				}else{  
	        				j++;   
	    				}   
	    			}  
	    			i++;   
	    		}          	 
	    	});
		   
		});
		 
		//作用于弹框
		function getId(num,productId){
			$(".page").removeAttr("style");
			$(".page"+num).show();
			var price;
			var name;
			if(num == 0){
			    //自定义月数套餐
				name = $(".customMonthForSchoolRange").find("h2").text();
				price = $(".customMonthForSchoolRange").find("p .price").text();
				$("#orderMessageNamePage0").val(name);
				$("#orderMessagePricePage0").val(price);
				$(".page0 .customMonthProductId").val(productId);
				//加载年级
				loadGradeList();
			}else if(num == 1){
			    //购买学校条数
				name = $(".customnNumberForSchoolRange").find("h2").text();
				price = $(".customnNumberForSchoolRange").find("p .price").text();
				$("#orderMessageName").val(name);
				$("#orderMessagePrice").val(price);

				$(".page1 .customNumberProductId").val(productId);
			}
		}
		function check(index,type,studentId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>orderMessage/checkOrderMessageByUserId.do",
				data:{
					studentId : studentId
				},
				success: function(data){
					var data = eval("(" + data + ")");
					var flag = data.flag;
					var result = data.result;
					if(flag)
					{
						layer.msg(result);
					}else
					{
						if(type==1)
						{
							var count = $("#count"+index).val();
							if(count=="" || count == 0)
							{
								layer.msg("购买数量不能小于1");
							}else if(count > 10000)
							{
								layer.msg("一次性最大只能购买10000条短信");
							}
							else
							{
								$("#submitForm"+index).submit();
							}
						}else
						{
							$("#submitForm"+index).submit();
						}
					}
				},
			});
		}

		function checkCustomNumberForSchoolRange()
		{
			var count = $(".page1").find(".customNumber").val();
			if(count=="" || count == 0)
			{
				layer.msg("购买数量不能小于1");
				return false;
			}else if(count > 500000)
			{
				layer.msg("一次性最大只能购买500000条短信");
				return false;
			}
		
			$("#customNumberFormForSchoolRange").submit();
		}
		
		function checkCustomMonthForSchoolRange()
		{
			var count = $(".page0").find(".customMonthCount").val();
			var name = $("#orderMessageNameSelf").val();
			if(count=="" || count == 0)
			{
				layer.msg("购买月数不能小于1");
				return false;
			}else if(count > 12)
			{
				layer.msg("一次性最大只能设置12个月的服务费");
				return false;
			}

			if(name=="" || name== null || typeof(name) == "undefined"){
				layer.msg("请输入自定义名称");
				return false;
			}
			
			if($("#selectedObj option").val()==null)
			{
				layer.msg("请至少选择一个发送对象！");
				return false;
			}
			var selectedValues = [];    
			$("#selectedObj option").each(function(){
			    selectedValues.push($(this).val()); 
			});
			$("#selectedObj").val(selectedValues);
			
			var l_=layer.confirm('确认保存设定的自定义包月套餐？', {
				  btn: ['确定','取消'] //按钮
				},function(){
					$("#customMonthSubmitFormForSchoolRange").submit();
				},function(){
				  layer.close(l_);
				});
			
		}

		//1.去掉多余的小数点  
		//2.保证只能输入小数点或数字 
		//this,${product.servicePrice},${sta.index},${product.cardPrice},${product.user.cardPay}
		function onlyNonNegative(obj,servicePrice,index,cardPrice,cardPay) {
			var evt = window.event || arguments[0]; 
			if(evt.keyCode==39 || evt.keyCode==37){
				return;
			}
			var oldCount=$(obj).attr("old");//原数量
			var newCount=$(obj).val();
			if($.trim(newCount)==''){
				  layer.tips("请输入购买数量",$(obj));
				 return;
			}
			 var reg = new RegExp("^[0-9]*$");
			 if(!reg.test(newCount)){
			     layer.tips("请输入正整数,且大于0",$(obj));
			     $(obj).val(oldCount);
			     return;
			 }
			 var price=newCount*servicePrice;
			 if(cardPay==1){
				  price+=cardPrice;
			  }
			  $(obj).val(newCount);	  $(obj).attr("old",newCount);
			  $("#price_"+index).text(price.toFixed(2));
			  
			/* 
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

		function onlyNonNegativeForSchoolRande(obj,parent) {
			var evt = window.event || arguments[0]; 
			 var inputChar = evt.keyCode;  
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
			 if(parent == 'page0'){
				 if(obj.value > 12){
					 layer.msg("一次性最大只能设置12个月的服务费！");
					 $(obj).val("");
					 return false;
				 }
				 var price = $("#orderMessagePricePage0").val();
				 if (typeof(obj.value) != "undefined" && !isNaN(obj.value) && obj.value != ""){
					 var totalFee = computationCost(obj.value,price);
					 $("#totalFeeForSchoolNumPage0").val(totalFee);
				 }else{
					 $("#totalFeeForSchoolNumPage0").val("0.0"); 
				 }
			 }else if(parent == 'page1'){
				 if(obj.value > 500001){
					 layer.msg("一次性只能购买500000条！");
					 $(obj).val(500000);
					 return false;
				 }
				 var price = $("#orderMessagePrice").val();
				 if (typeof(obj.value) != "undefined" && !isNaN(obj.value) && obj.value != ""){
					 var totalFee = Math.round((parseFloat(obj.value) * parseFloat(price))*100)/100;
					 $("#totalFeeForSchoolNum").val(totalFee); 
				 }else{
					 $("#totalFeeForSchoolNum").val("0.0"); 
				 }
			 }
			
		} 

		//计算自定义月份费用
		function computationCost(monthCount,price){
		   var oringTotalFee = Math.round((parseFloat(monthCount) * parseFloat(price))*100)/100;
       	   var totalFee = 0;
       	   if(monthCount > 0 && monthCount <=9){
       		   if (typeof(oringTotalFee) != "undefined" && !isNaN(oringTotalFee)){
       			   totalFee = oringTotalFee;
                  }
              }else{
           	   if (typeof(oringTotalFee) != "undefined" && !isNaN(oringTotalFee)){
       			   if(monthCount == 10){
       				   totalFee = oringTotalFee - Math.round((0.5 * parseFloat(price))*100)/100;
						   }else if(monthCount == 11){
							   totalFee = oringTotalFee - Math.round((0.5 * parseFloat(price))*100)/100;
						   }else if(monthCount == 12){
							   totalFee = oringTotalFee - Math.round((1 * parseFloat(price))*100)/100;
						   }
                  }
              }
			return totalFee;
		}
		
		function loadGradeList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadGradeList.do",
				data:{
					},
				success: function(data){
					var list = $.parseJSON(data);
					var appendHtml = '<option value="0">---请选择---</option>';
					$.each(list, function(n, value) {  
           				appendHtml += '<option value="G'+value.id+'">'+value.name+'</option>';
          			});
					
					$("#gradeList").html(appendHtml);
					//初始化带选框
           			var appendHtml = $("#gradeList").html();
					$("#toSelectObj").html(appendHtml);
					$("#toSelectObj option[value='0']").remove();
					$("#toSelectObj1").html(appendHtml);
					$("#toSelectObj1 option[value='0']").remove();
				},
			});
		}
	</script>
	</html>