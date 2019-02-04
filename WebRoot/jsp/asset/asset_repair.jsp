<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>资产维修</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath %>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css">
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
	                        <li><a href="<%=basePath%>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>资产报修</span></li>
	                    </ul>
	                </div>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">资产报修</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>asset/doAddAssetRepair.do" method="post" id="addForm" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-lg-3">报修人</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input class="form-control" disabled="disabled" name="realName" id="realName" value="${realName}" type="text">
                                                    <input type="hidden" name="userId" id="userId" value="${userId}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-lg-3">报修人手机号</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input class="form-control" disabled="disabled" name="phone" id="phone" value="${phone}" type="text">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-lg-3">报修类型</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="type">
		                                            </select>  
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-lg-3" for="inputSuccess">报修价格 </label>
                                                <div class="col-md-9 col-lg-4">
                                                	<input class="form-control" type="number" id="price">
												</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-lg-3" for="inputSuccess">问题描述 </label>
                                                <div class="col-md-9 col-lg-4">
                                                	<textarea class="form-control asset_depict" id="remark"></textarea>
												</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-lg-3">选择资产</label>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObjAsset"></select>
                                                </div>
                                                <div class="col-md-1 col-lg-1">
													<button type="button" class="btn default btn-block" id="addAsset" style="display:block"><i class="fa fa-angle-right"></i></button>
													<button type="button" class="btn default btn-block" id="removeAsset" style="display:block"><i class="fa fa-angle-left"></i></button>
  													<button type="button" class="btn green btn-block" id="addAllAsset" style="display:block"><i class="fa fa-angle-double-right"></i></button>
  													<button type="button" class="btn green btn-block" id="removeAllAsset" style="display:block"><i class="fa fa-angle-double-left"></i></button>
												</div>
												<div class="col-md-4 col-lg-2">	
													<select class="form-control sms_select" multiple="multiple" id="selectedObjAsset" name="selectedObjAsset"></select>
													<select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj1Asset" style="display : none"></select>	
												</div> 
                                            </div>
                                            <c:if test="${personnelType eq 'serviceman'}">
                                            	<div class="form-group" style="display: none">
                                            </c:if>
                                            <c:if test="${personnelType ne 'serviceman'}">
                                            	<div class="form-group">
                                            </c:if>
                                                <label class="control-label col-md-3 col-lg-3">维修人员</label>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObjRepair"></select>
                                                </div>
                                                <div class="col-md-1 col-lg-1">
													<button type="button" class="btn default btn-block" id="addRepair" style="display:block"><i class="fa fa-angle-right"></i></button>
													<button type="button" class="btn default btn-block" id="removeRepair" style="display:block"><i class="fa fa-angle-left"></i></button>
  													<button type="button" class="btn green btn-block" id="addAllRepair" style="display:block"><i class="fa fa-angle-double-right"></i></button>
  													<button type="button" class="btn green btn-block" id="removeAllRepair" style="display:block"><i class="fa fa-angle-double-left"></i></button>
												</div>
												<div class="col-md-4 col-lg-2">	
													<select class="form-control sms_select" multiple="multiple" id="selectedObjRepair" name="selectedObjRepair"></select>
													<select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj1Repair" style="display : none"></select>	
												</div> 
                                            </div>
                                             <h3 class="form-section">选择图片</h3>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-lg-3">图片</label>
                                                <div class="col-md-9 col-lg-6">
				                         			<div class="m_width_50 m_float_left">
														<div class="fileinput fileinput-new" data-provides="fileinput">
	                                                        <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
	                                                            <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""> </div>
	                                                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
	                                                        <div>
	                                                            <span class="btn default btn-file">
	                                                                <span class="fileinput-new">选文件</span>
	                                                                <span class="fileinput-exists">换一个</span>
	                                                                <input type="file" id="imgFile1" name="imgFile1"> </span>
	                                                            <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput">移除</a>
	                                                        </div>
	                                                    </div>
													</div>
				                         			<div class="m_width_50 m_float_left">
				                         				<div class="fileinput fileinput-new" data-provides="fileinput">
	                                                        <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
	                                                            <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""> </div>
	                                                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
	                                                        <div>
	                                                            <span class="btn default btn-file">
	                                                                <span class="fileinput-new">选文件</span>
	                                                                <span class="fileinput-exists">换一个</span>
	                                                                <input type="file" id="imgFile2" name="imgFile2"> </span>
	                                                            <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput">移除</a>
	                                                        </div>
	                                                    </div>
													</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<input type="hidden" id="personnelType" name="personnelType" value="${personnelType}">
                                                	<c:if test="${personnelType == 'leader'}">
                                                		<button type="button" class="btn green" onclick="saveDate()">通知维修</button>
                                                	</c:if>
                                                	<c:if test="${personnelType == 'serviceman'}">
                                                		<button type="button" class="btn green" onclick="saveDate()">提交审核</button>
                                                	</c:if>
                                                	<c:if test="${personnelType == 'repair'}">
                                                		<button type="button" class="btn green" onclick="saveDate()">保存</button>
                                                	</c:if>
                                                    <button type="button" class="btn default" id="cancel">返回</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- END FORM-->
                                </div>
                            </div>
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
    <script src="<%=basePath %>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
   <script type="text/javascript">
   $(function(){
	   //选取当前菜单位置
	 	 setActive("assetmanagement","assetRepair"); 
	 	 loadTyepList();
	 	 loadAssetList($("#type").val());
	 	 loadServicemanList($("#type").val());
	 	 $("#type").change(function(){
			var type = $(this).val();
			loadAssetList(type);
			loadServicemanList(type);
			$("#selectedObjAsset").empty(); 
			$("#selectedObjRepair").empty();
		 });
	 	//将option从待发送对象移到发送对象的div中
	 	$("#toSelectObjAsset").dblclick(function(){
	     	var $options = $('#toSelectObjAsset option:selected');//获取当前选中的项  
	     	var $remove = $options.remove();//删除下拉列表中选中的项  
	     	$remove.appendTo('#selectedObjAsset');//追加给对方
	 		var i=0;
	 		var length = $("#selectedObjAsset option").length;
	 		while(i<length){
	 			var j=i+1;
	 			while(j<$("#selectedObjAsset option").length){
	 				if($("#selectedObjAsset option")[i].value==$("#selectedObjAsset option")[j].value){
	     				$("#selectedObjAsset option")[j].remove();
	     				j++;   
	 				}else{  
	     				j++;   
	 				}   
	 			}  
	 			i++;   
	 		} 		
	 	});
	 	//将option从发送对象移到待发送对象的div中
	 	$("#selectedObjAsset").dblclick(function(){
	     	var $removeOptions = $('#selectedObjAsset option:selected');  
	     	$removeOptions.appendTo('#toSelectObjAsset');//删除和追加可以用appendTo()直接
	 		var i=0;
	 		var length = $("#toSelectObjAsset option").length;
	 		while(i<length){
	 			var j=i+1;
	 			while(j<$("#toSelectObjAsset option").length){
	 				if($("#toSelectObjAsset option")[i].value==$("#toSelectObjAsset option")[j].value){
	     				$("#toSelectObjAsset option")[j].remove();    
	     				j++;   
	 				}else{  
	     				j++;   
	 				}   
	 			}  
	 			i++;   
	 		}             	
	 	});
	 	$('#addAsset').click(function(){
	     	var $options = $('#toSelectObjAsset option:selected');//获取当前选中的项  
	     	var $remove = $options.remove();//删除下拉列表中选中的项  
	     	$remove.appendTo('#selectedObjAsset');//追加给对方
	 		var i=0;
	 		var length = $("#selectedObjAsset option").length;
	 		while(i<length){
	 			var j=i+1;
	 			while(j<$("#selectedObjAsset option").length){
	 				if($("#selectedObjAsset option")[i].value==$("#selectedObjAsset option")[j].value){
	     				$("#selectedObjAsset option")[j].remove();   
	     				j++;   
	 				}else{  
	     				j++;   
	 				}   
	 			}  
	 			i++;   
	 		} 				
	 	});  
	 	$('#remove').click(function(){  
	     	var $removeOptions = $('#selectedObjAsset option:selected');  
	     	$removeOptions.appendTo('#toSelectObjAsset');//删除和追加可以用appendTo()直接
	 		var i=0;
	 		var length = $("#toSelectObjAsset option").length;
	 		while(i<length){
	 			var j=i+1;
	 			while(j<$("#toSelectObjAsset option").length){
	 				if($("#toSelectObjAsset option")[i].value==$("#toSelectObjAsset option")[j].value){
	     				$("#toSelectObjAsset option")[j].remove();    
	     				j++;   
	 				}else{  
	     				j++;   
	 				}   
	 			}  
	 			i++;   
	 		} 
	 	}); 
	 	$('#addAllAsset').click(function(){  
	     	var $options = $('#toSelectObjAsset option');  
	     	$options.appendTo('#selectedObjAsset');  
	     	$("#selectedObjAsset option").attr("selected",true);
	 		var i=0;
	 		var length = $("#selectedObjAsset option").length;
	 		while(i<length){
	 			var j=i+1;
	 			while(j<$("#selectedObjAsset option").length){
	 				if($("#selectedObjAsset option")[i].value==$("#selectedObjAsset option")[j].value){
	     				$("#selectedObjAsset option")[j].remove(); 
	     				j++;   
	 				}else{  
	     				j++;   
	 				}   
	 			}  
	 			i++;   
	 		}	
	 	});  
	 	$('#removeAllAsset').click(function(){  
	     	var $options = $('#selectedObjAsset option');  
	     	$options.appendTo('#toSelectObjAsset'); 
	 		var i=0;
	 		var length = $("#toSelectObjAsset option").length;
	 		while(i<length){
	 			var j=i+1;
	 			while(j<$("#toSelectObjAsset option").length){
	 				if($("#toSelectObjAsset option")[i].value==$("#toSelectObjAsset option")[j].value){
	     				$("#toSelectObjAsset option")[j].remove();    
	     				j++;   
	 				}else{  
	     				j++;   
	 				}   
	 			}  
	 			i++;   
	 		}          	 
	 	}); 
	 	
	 	
	 	
	 	//将option从待发送对象移到发送对象的div中
		$("#toSelectObjRepair").dblclick(function(){
	    	var $options = $('#toSelectObjRepair option:selected');//获取当前选中的项  
	    	var $remove = $options.remove();//删除下拉列表中选中的项  
	    	$remove.appendTo('#selectedObjRepair');//追加给对方
			var i=0;
			var length = $("#selectedObjRepair option").length;
			while(i<length){
				var j=i+1;
				while(j<$("#selectedObjRepair option").length){
					if($("#selectedObjRepair option")[i].value==$("#selectedObjRepair option")[j].value){
	    				$("#selectedObjRepair option")[j].remove();
	    				j++;   
					}else{  
	    				j++;   
					}   
				}  
				i++;   
			} 		
		});

		//将option从发送对象移到待发送对象的div中
		$("#selectedObjRepair").dblclick(function(){
	    	var $removeOptions = $('#selectedObjRepair option:selected');  
	    	$removeOptions.appendTo('#toSelectObjRepair');//删除和追加可以用appendTo()直接
			var i=0;
			var length = $("#toSelectObjRepair option").length;
			while(i<length){
				var j=i+1;
				while(j<$("#toSelectObjRepair option").length){
					if($("#toSelectObjRepair option")[i].value==$("#toSelectObjRepair option")[j].value){
	    				$("#toSelectObjRepair option")[j].remove();    
	    				j++;   
					}else{  
	    				j++;   
					}   
				}  
				i++;   
			}             	
		});
		$('#addRepair').click(function(){
	    	var $options = $('#toSelectObjRepair option:selected');//获取当前选中的项  
	    	var $remove = $options.remove();//删除下拉列表中选中的项  
	    	$remove.appendTo('#selectedObjRepair');//追加给对方
			var i=0;
			var length = $("#selectedObjRepair option").length;
			while(i<length){
				var j=i+1;
				while(j<$("#selectedObjRepair option").length){
					if($("#selectedObjRepair option")[i].value==$("#selectedObjRepair option")[j].value){
	    				$("#selectedObjRepair option")[j].remove();   
	    				j++;   
					}else{  
	    				j++;   
					}   
				}  
				i++;   
			} 				
		});  
	  
		$('#removeRepair').click(function(){  

	    	var $removeOptions = $('#selectedObjRepair option:selected');  
	    	$removeOptions.appendTo('#toSelectObjRepair');//删除和追加可以用appendTo()直接
			var i=0;
			var length = $("#toSelectObjRepair option").length;
			while(i<length){
				var j=i+1;
				while(j<$("#toSelectObjRepair option").length){
					if($("#toSelectObjRepair option")[i].value==$("#toSelectObj option")[j].value){
	    				$("#toSelectObjRepair option")[j].remove();    
	    				j++;   
					}else{  
	    				j++;   
					}   
				}  
				i++;   
			} 
		}); 
		$('#addAllRepair').click(function(){  
	    	var $options = $('#toSelectObjRepair option');  
	    	$options.appendTo('#selectedObjRepair');  
	    	$("#selectedObjRepair option").attr("selected",true);
			var i=0;
			var length = $("#selectedObjRepair option").length;
			while(i<length){
				var j=i+1;
				while(j<$("#selectedObjRepair option").length){
					if($("#selectedObjRepair option")[i].value==$("#selectedObjRepair option")[j].value){
	    				$("#selectedObjRepair option")[j].remove(); 
	    				j++;   
					}else{  
	    				j++;   
					}   
				}  
				i++;   
			}	
		});  
		$('#removeAllRepair').click(function(){  
	    	var $options = $('#selectedObjRepair option');  
	    	$options.appendTo('#toSelectObjRepair'); 
			var i=0;
			var length = $("#toSelectObjRepair option").length;
			while(i<length){
				var j=i+1;
				while(j<$("#toSelectObjRepair option").length){
					if($("#toSelectObjRepair option")[i].value==$("#toSelectObjRepair option")[j].value){
	    				$("#toSelectObjRepair option")[j].remove();    
	    				j++;   
					}else{  
	    				j++;   
					}   
				}  
				i++;   
			}          	 
		}); 
	 	
	     $(".asset_depict").blur(function(){
	    	 var depict=$.trim($(".asset_depict").val());
	 		 if(depict==''){
	 			layer.tips('请输入问题', '.asset_depict');
	 			return;
	 		 }
		 });
	})
    
   var asset_tel='';asset_depict='';more_num=[];
   function validate()
   {
		asset_depict=$.trim($(".asset_depict").val());
		if(asset_depict==''){
			layer.tips('请输入问题', '.asset_depict');
			return false;
		}
		if($("#selectedObjAsset option").val()==null)
		{
			layer.tips('请至少选择一个资产','#selectedObjAsset');
			return false;
		}

		var price = $.trim($("#price").val());
		if(price !=null && price < 0 ){
			layer.tips('报修价格不能小于0','#price');
			return false;
		}
		if($("#personnelType").val() != 'serviceman'){
			if($("#selectedObjRepair option").val()==null)
			{
				layer.tips('请至少选择一个维修人员','#selectedObjRepair');
				return false;
			}
		}
		return true;
   }
   function saveDate()
   {
	   if(validate())
	   {
		   var selectedAssetValues = [];    
		   $("#selectedObjAsset option").each(function(){
			   selectedAssetValues.push($(this).val()); 
		   });
		   $("#selectedObjAsset").val(selectedAssetValues);
		   var selectedRepairValues = [];    
		   $("#selectedObjRepair option").each(function(){
			   selectedRepairValues.push($(this).val()); 
		   });
		   $("#selectedObjRepair").val(selectedRepairValues);
		   var servicemanArr = JSON.stringify(selectedRepairValues);
		   var assetArr = JSON.stringify(selectedAssetValues);
		   $.ajaxFileUpload({
				type:"post",
				secureuri : false,
				fileElementId :['imgFile1','imgFile2'],
				data:{
					realName : $("#realName").val(),
					userId : $("#userId").val(),
					phone : $("#phone").val(),
					type : $("#type").val(),
					price : $("#price").val(),
					remark : $("#remark").val(),
					personnelType : $("#personnelType").val(),
					servicemanArr :  $("#selectedObjRepair").val(),
					assetArr : $("#selectedObjAsset").val()
				},
				url:'<%=basePath%>asset/doAddAssetRepair.do',
				success:function(data){
					if(data){
						setTimeout(function(){
							layer.msg("资产报修添加成功",{icon:1,time:1000});
							location.href="<%=basePath%>asset/toAssetRepairList.do";
							layer.close(indexlayer);
						},1000);
					}else{
						layer.msg("资产报修添加失败",{icon:2,time:1000});	
					}
				}
			})	
	   }
	}
	
	function loadTyepList()
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/getAssetTypeList.do",
			data:{
			},
			success: function(data){
				var list = eval("(" + data + ")");
                var appendHtml = '';
				$.each(list, function(n, value) {  
       				appendHtml += '<option value="'+value.id+'">'+value.name+'</option>';
      			}); 
      			$("#type").html(appendHtml);
			},
		});
    }
	
	//根据报修类型加载资产
	function loadAssetList(type)
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/getAllAssetListByType.do",
			data:{
				 type : type
			},
			success: function(data){
				var list = eval("(" + data + ")");
				var appendHtml = '';
				$.each(list, function(n, value) {
       				appendHtml += '<option value="' + value.id + '">' + value.code + '   ' + value.name + '</option>';
       			}); 
       			//初始化带选框
				$("#toSelectObjAsset").html(appendHtml);
				$("#toSelectObjAsset option[value='0']").remove();
				$("#toSelectObj1Asset").html(appendHtml);
				$("#toSelectObj1Asset option[value='0']").remove();
			},
		});
	}
	//根据报修类型加载维修人员
	function loadServicemanList(type)
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/getAllServicemanListByType.do",
			data:{
				 type : type
			},
			success: function(data){
				var list = eval("(" + data + ")");
				var appendHtml = '';
				$.each(list, function(n, value) {
       				appendHtml += '<option value="' + value.servicemanId + '">' + value.serviceman + '</option>';
       			}); 
       			//初始化带选框
				$("#toSelectObjRepair").html(appendHtml);
				$("#toSelectObjRepair option[value='0']").remove();
				$("#toSelectObj1Repair").html(appendHtml);
				$("#toSelectObj1Repair option[value='0']").remove();
			},
		});
	}
	
	
   </script>
</html>