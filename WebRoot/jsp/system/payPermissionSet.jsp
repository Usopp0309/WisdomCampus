<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>智慧校园服务费设置</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<!--公共css开始-->
<%@ include file="/public_module/public_css_new.jsp"%>
<link
	href="<%=basePath%>assets/global/plugins/bootstrap-switch/css/bootstrapSwitch.css"
	rel="stylesheet" type="text/css" />
<!--公共css结束-->
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed"
	id="body">
	<input class="themes" type="hidden" value="<%=ThemePath%>">
	<!-- 公共顶部开始-->
	<%@ include file="/public_module/public_header.jsp"%>
	<!--公共顶部结束-->
	<div class="clearfix"></div>
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
							<li><a href="<%=basePath%>user/enterMain.do">首页</a><i
								class="fa fa-circle"></i></li>
							<li><a href="">系统管理</a><i class="fa fa-circle"></i></li>
							<li><span>服务费权限设置</span></li>
						</ul>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div
								class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0">
								<div class="portlet-title">
									<div class="caption">
										<i class=" icon-layers font-green"></i> <span
											class="caption-subject font-green sbold uppercase">服务费权限设置</span>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 col-sm-12">
										<!-- 添加功能菜单开始 -->
										<div class="portlet light form-fit m_margin_0_0_15_0">
											<div class="note note-success m_margin_15_0_0_0">
												<i style="color: red; font-size: 15px;">*</i>&nbsp;该功能的作用会对还没有购买服务费的家长起到部分功能使用限制
											</div>
										</div>
									</div>
									<div class="portlet-body">
										<form action="" class="form-horizontal" method="post"
											id="addForm">
											<div class="form-body">
												<div class="form-group">
													<label class="control-label col-md-3">设置权限内容：</label>
													<div class="col-md-9 col-lg-4">
														<select id="type" class="form-control"
															name="type" onchange="getOrderMessagePermissionDetail();">
															<c:forEach items="${list }" var="s">
															 <option value="${s.menuId }">${s.menuName }</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">是否限制权限：</label>
													<div class="col-md-9 col-lg-4">
														<div class="switch switch-large has-switch">
															<div class="switch-on switch-animate" id="switchType" onclick="offOrOn(this);">
																<input checked="" type="checkbox"><span
																	class="switch-left switch-large">限制</span><label
																	class="switch-large">&nbsp;</label><span
																	class="switch-right switch-large">不限制</span>
															</div>
														</div>
													</div>
												</div>
												<div class="form-group" id="form-group">
                                                <label class="control-label col-md-3 col-lg-3">限制年级：</label>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj" >
													</select>
                                                </div>
                                                <div class="col-md-1 col-lg-1">
                                                	<button type="button" class="btn default btn-block" id="add" style="display:block"><i class="fa fa-angle-right"></i></button>
													<button type="button" class="btn default btn-block" id="remove" style="display:block"><i class="fa fa-angle-left"></i></button>
  													<button type="button" class="btn green btn-block" id="addAll" style="display:block"><i class="fa fa-angle-double-right"></i></button>
  													<button type="button" class="btn green btn-block" id="removeAll" style="display:block"><i class="fa fa-angle-double-left"></i></button>
  												</div>
                                                <div class="col-md-4 col-lg-2" id="selectedObj_">
													<select class="form-control sms_select" multiple="multiple" id="selectedObj" name="selectedObj"></select>
                                                </div>
                                            </div>
											</div>

											<div class="row">
												<div class="col-md-offset-3 col-md-9"">
													<button type="button" class="btn green" id="submitButton">保存</button>
													<button type="button" class="btn" id="cancel"
														onclick="location.href='<%=basePath%>orderMessagePermission/toPayPermissionSet'">返回</button>
												</div>
												<div style="height: 400px;"></div>
											</div>
									</div>
								</div>
							</div>
						</div>
						<!--页面内容结束 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 亦信聊天开始 -->
	<%@ include file="/public_module/public_QQ.jsp"%>
	<!-- 亦信聊天结束 -->
	</div>
	<!-- 内容页结束 -->
	<!-- 底部开始 -->
	<%@ include file="/public_module/public_footer.jsp"%>
	<!-- 底部结束 -->
</body>
<!-- 公共js开始 -->
<%@ include file="/public_module/public_js.jsp"%>
<!-- 公共js结束 -->
<script src="<%=basePath%>assets/global/plugins/layer/layer.js"
	type="text/javascript"></script>
<script>
        var gradeData=null;
		$(function(){
			loadSubMenu("systemManage"); 
			//选取当前菜单位置
			setActive("systemManage","serviceFee");    
			
			loadGradeList();
			getOrderMessagePermissionDetail();
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
	    	//表单提交
			$("#submitButton").click(function()
			{       
				    var type=$("#type").val();
				    if(type==""){
				     layer.tips('请选择类型！', '#type');	
				     return false;	
				    }
				    //0不限制， 1限制
				    var switchType=0;
				    if($("#switchType").hasClass("switch-on")){
				    	switchType=1;
				    }else{
				    	switchType=0;
				    }
                	if(switchType==1 && (typeof($("#selectedObj option"))=="undefined" ||$("#selectedObj option").length==0))
    				{
    					layer.tips('请至少选择一个发送对象！', '#selectedObj');
    					return false;
    				}
    				var selectedValues = [];    
    				$("#selectedObj option").each(function(){
    				    selectedValues.push($(this).val()); 
    				});
    				if(switchType==0){
    					selectedValues=[];	
    				}
    				save(selectedValues.join(","),switchType);
				    //layer.msg("正在保存数据……",{icon:10,time:5000,shade:0.4});
			});	
		});
		function getOrderMessagePermissionDetail(){
			var menuId=$("#type").val();
			//0不限制， 1限制
		    var switchType=0;
		    if($("#switchType").hasClass("switch-on")){
		    	switchType=1;
		    }else{
		    	switchType=0;
		    }
		    $("#selectedObj option").each(function(){
			    $(this).remove(); 
			});
		    
		    if(menuId!=""){
		    	$.ajax({
					type: "post",
					url: "<%=basePath%>orderMessagePermission/getOrderMessagePermissionDetail.do",
					dataType:"json",
					data:{"menuId":menuId},
					success: function(data){
						var appendHtml = '';
						var omp=data.orderMessagePermission;
						$.each(data.list, function(n, value) {
	           				appendHtml += '<option value="' + value.gradeId + '">' + value.gradeName + '</option>';
	           			});
						$("#toSelectObj").html(gradeData);
						 $("#toSelectObj option").each(function(){
							 for(var i=0;i<data.list.length;i++){
								 if(data.list[i].gradeId==$(this).val()){
			           					$(this).remove();	
			           			}
							 }     
	    				}); 
						$("#selectedObj").html(appendHtml);
						if(omp.status==0){//不限制
							$("#switchType").removeClass("switch-on");
							$("#switchType").addClass("switch-off");
							$("#form-group").hide();
						}else if(omp.status==1){//限制
							$("#switchType").removeClass("switch-off");
							$("#switchType").addClass("switch-on");
							$("#form-group").show();
							//$("#toSelectObj").html(gradeData);
						}
						
						//alert(JSON.stringify(data));//
					},
				});	
		    }
		}
		function save(content,status){
			var indexlayer = layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			var menuId=$("#type").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>orderMessagePermission/doOrderMessagePermissionDetail.do",
				dataType:"json",
				data:{"menuId":menuId,"status":status,"strContent":content},
				success: function(data){
				 if(data=="1"){
					 layer.msg("保存成功",{icon:1,time:1000});
				 }else{
					 layer.msg("保存失败",{icon:2,time:1000});	 
				 }
				 layer.close(indexlayer);
				},
			});
		}
		//获得年级
		function loadGradeList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadGradeList.do",
				dataType:"json",
				data:{},
				success: function(data){
					var appendHtml = '';
					$.each(data, function(n, value) {
           				appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
           			});  
					$("#toSelectObj").html(appendHtml);
					gradeData=appendHtml;
				},
			});
		}
		//开关设置
		function offOrOn(obj){
			if(!$(obj).hasClass("switch-on")){
				$(obj).removeClass("switch-off");
				$(obj).addClass("switch-on");
				$("#form-group").show();
			}else{
				$(obj).removeClass("switch-on");
				$(obj).addClass("switch-off");
				$("#form-group").hide();
			}
			var menuId=$("#type").val();
			//0不限制， 1限制
		    var switchType=0;
		    if($("#switchType").hasClass("switch-on")){
		    	switchType=1;
		    }else{
		    	switchType=0;
		    }
		    $("#selectedObj option").each(function(){
			    $(this).remove(); 
			});
			$.ajax({
				type: "post",
				url: "<%=basePath%>orderMessagePermission/getOrderMessagePermissionDetail.do",
				dataType:"json",
				data:{"menuId":menuId},
				success: function(data){
					var appendHtml = '';
					var omp=data.orderMessagePermission;
					if(omp.status==0 && switchType==1){
						$("#toSelectObj").html(gradeData);	
					}else if(omp.status==1){
						$.each(data.list, function(n, value) {
	           				appendHtml += '<option value="' + value.gradeId + '">' + value.gradeName + '</option>';
	           			});
						$("#toSelectObj option").each(function(){
							 for(var i=0;i<data.list.length;i++){
								 if(data.list[i].gradeId==$(this).val()){
			           					$(this).remove();	
			           			}
							 }     
	    				}); 
						$("#selectedObj").html(appendHtml);
					}
				}
			});	
		    
			//getOrderMessagePermissionDetail();
		}
	</script>
</html>