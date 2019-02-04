<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>增加智慧校园服务费</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
		
	 	<!--公共css结束--> 
        </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed">
    	<input class="themes" type="hidden" value="<%=basePath%>">
        <!-- 公共顶部开始-->
        <%@ include file="/public_module/public_header.jsp"%>    
        <!--公共顶部结束-->
        <div class="clearfix"> </div>
        <!-- 内容页开始 -->
        <div class="page-container">
            <!--主菜单开始-->
            <%@include file="/public_module/public_menu.jsp"%>
            <!--主菜单结束-->
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">系统管理</a><i class="fa fa-circle"></i></li>
                            <li><span>增加校园服务费</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">增加校园服务费</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>replaceRecharge/doAddMessage.do" id="submitForm" class="form-horizontal" method="post" >
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">服务对象</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="rangeObject" name="rangeObject">
														<option value= "1" selected="selected">个人</option>
														<option value= "0">学校</option>
													</select>
                                                </div>
                                            </div>
                                            <div class="form-group" id="nameGroup">
                                                <label class="control-label col-md-3" for="inputError">名称</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="name" id="name" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group" id="priceGroup">
                                                <label class="control-label col-md-3" for="inputSuccess">服务费(元/人)</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" placeholder="服务费(没有输入0)" name="servicePrice" id="price" onkeyup="clearNoNum(this)" class="form-control"/>
                                            	</div>
                                            </div>
                                            <div class="form-group" id="priceGroup">
                                                <label class="control-label col-md-3">卡押金(元/张)</label>
                                                <div class="col-md-9 col-lg-4">
                                                 <input type="text" placeholder="卡押金(没有输入0)" name="cardPrice" id="cardPrice" value="${message.cardPrice }" onkeyup="clearNoNum(this)" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">套餐类型</label>
                                                <div class="col-md-9 col-lg-4">
                                                       <select class="form-control" id="type" name="type">
															<option value= "0" selected="selected">时间段</option>
															<option value= "1">单条</option>
														</select>
                                                </div>
                                            </div>
                                            <div class="form-group" id="startTimeGroup">
                                                <label class="control-label col-md-3">开始时间</label>
                                                <div class="col-md-9 col-lg-4">
                                                      <input type="text" size="16" readonly="readonly" name="startTime" id="startTime" class="day form-control"/>
                                                	  <span class="help-inline" style="display: none;" id="startTimeSpan"></span>
                                                </div>
                                            </div>
                                            <div class="form-group" id="endTimeGroup">
                                                <label class="control-label col-md-3">结束时间</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<input type="text" size="16" readonly="readonly" name="endTime" id="endTime" class="day form-control"/>
                                                	<span class="help-inline" style="display: none;" id="endTimeSpan"></span>
                                                </div>
                                            </div>
                                            <div class="form-group" id="gradeGroup">
                                               <label class="control-label col-md-3">适用范围</label>
                                               <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" tabindex="1" name="gradeIdList" id="gradeList">
													</select>
                                               </div>
                                            </div>
                                            <div class="form-group" id="objectGroup">
                                                <label class="control-label col-md-3">选择对象</label>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj"></select>															
                                                </div>
                                                <div class="col-md-1 col-lg-1">
                                                	<button type="button" class="btn default btn-block" id="add" style="display:block"><i class="fa fa-angle-right"></i></button>
													<button type="button" class="btn default btn-block" id="remove" style="display:block"><i class="fa fa-angle-left"></i></button>
  													<button type="button" class="btn green btn-block" id="addAll" style="display:block"><i class="fa fa-angle-double-right"></i></button>
  													<button type="button" class="btn green btn-block" id="removeAll" style="display:block"><i class="fa fa-angle-double-left"></i></button>
  												</div>
                                                <div class="col-md-4 col-lg-2">
													<select class="form-control sms_select" multiple="multiple" id="selectedObj" name="selectedObj" ></select>
													<select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj1" style="display : none"></select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
	                                                <button type="button" class="btn green" id="submitButton">保存</button>
													<button type="button" class="btn" id="cancel">返回</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                                </div>
                        </div>
                    </div>
                    </div>
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
	<script type="text/javascript">

		$(function() {  
			loadSubMenu("systemManage"); 
			//选取当前菜单位置
			setActive("systemManage","serviceFee");  
			$('.day').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			}); 
			$('.time').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			}); 

			//加载年级
			loadGradeList();
            //名称校验
            $("#name").blur(function(){
                var name = $("#name").val();
                if("" == name)
                {
		            layer.tips('名称不能为空', '#name');
                } 
            });

            //设备密码校验
            $("#price").blur(function(){
                var price = $("#price").val();
                if("" == price)
                {
		            layer.tips('服务费不能为空', '#price');
                }
                clearNoNum(this);
            });
            //卡押金
            $("#cardPrice").blur(function(){
                var price = $("#cardPrice").val();
                if("" == price)
                {
		            layer.tips('卡押金不能为空', '#cardPrice');
                }
                clearNoNum(this);
            });
            
            //套餐类型选择点击时间
            $("#type").click(function(){
                var type = $("#type").val();
                if(type==0)
                {
                    $("#startTimeGroup").show();
                    $("#endTimeGroup").show();
                }
                else
                {
                	$("#startTimeGroup").hide();
                    $("#endTimeGroup").hide();
                }
            });
            
            //服务对应是学校时不显示适用范围
            $("#rangeObject").click(function(){
                var rangeObject = $("#rangeObject").val();
                if(rangeObject==0)
                {
                    $("#gradeGroup").hide();
                    $("#objectGroup").hide();
                }
                else
                {
                	$("#gradeGroup").show();
                	$("#objectGroup").show();
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
	    	
	    	//表单提交
			$("#submitButton").click(function()
			{
				var price=$.trim($("#price").val());
				var cardPrice=$.trim($("#cardPrice").val());
				if(price==''){
				 layer.tips("请输入服务费",$("#price"));
				 return;	
				}else if(cardPrice==''){
					 layer.tips("请输入卡押金",$("#cardPrice"));
					 return;	
				}
				var rangeObject = $("#rangeObject").val();
                if(rangeObject==1)
                {
                	if($("#selectedObj option").val()==null)
    				{
    					layer.tips('请至少选择一个发送对象！', '#rangeObject');
    					return false;
    				}
    				var selectedValues = [];    
    				$("#selectedObj option").each(function(){
    				    selectedValues.push($(this).val()); 
    				});
    				$("#selectedObj").val(selectedValues);
                }
	                
			    if(checkForm())
				{
				    $("#submitForm").submit();
				    layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
				}
			
			});	
	    	
	    	
		});
		//验证价格只能输入小数和整数
		function clearNoNum(obj)
	    {
	        //先把非数字的都替换掉，除了数字和.
	        obj.value = obj.value.replace(/[^\d.]/g,"");
	        //必须保证第一个为数字而不是.
	        obj.value = obj.value.replace(/^\./g,"");
	        //保证只有出现一个.而没有多个.
	        obj.value = obj.value.replace(/\.{2,}/g,".");
	        //保证.只出现一次，而不能出现两次以上
	        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	        //保证.只有两位小数
	        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,"$1$2.$3");
	        
	    }
		
		//表单校验相关---begin
		function checkForm()
		{
			 //验证常量 
            var nameFlag = false;
            var priceFlag = false;
            var startTimeFlag = false;
            var endTimeFlag = false;
            
            var name = $("#name").val();
            if("" == name)
            {
          		layer.tips('名称不能为空', '#name');
          		nameFlag = false;
            } 
            else
            {
                nameFlag = true;
            }
            
            var price = $("#price").val();
            if("" == price)
            {
            	layer.tips('价格不能为空', '#price');
            	priceFlag = false;
            }
            else
            {
                priceFlag = true;
            }

            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            var start = new Date(startTime.replace("-", "/").replace("-", "/"))
            var end = new Date(endTime.replace("-", "/").replace("-", "/"))

            var type = $("#type").val();
            if(type==0)
            {
            	if(startTime =="" && endTime =="")
                {
               		layer.tips('开始日期不能为空', '#startTime');
                	startTimeFlag = false;
               		layer.tips('结束日期不能为空', '#endTime');
                	endTimeFlag = false;
                	 
                } else if(startTime =="" && endTime !="")
                {
               		layer.tips('开始日期不能为空', '#startTime');
                	startTimeFlag = false;
                    endTimeFlag = true;
                }
                else if(startTime !="" && endTime =="")
                {
               		layer.tips('结束日期不能为空', '#endTime');
                	endTimeFlag = false;
                    startTimeFlag = true;
                }  
                else if(startTime!="" && endTime!="" && start>end)
                {
               		layer.tips('结束日期不能晚于开始日期', '#endTime');
               		layer.tips('结束日期不能晚于开始日期', '#endTime');
               		startTimeFlag = false;
                    endTimeFlag = false;
                }
                else
                {
                    startTimeFlag = true;
                    endTimeFlag = true;
                }  
            }
            else
            {
            	startTimeFlag = true;
                endTimeFlag = true;
            }
            
           
		  	if (nameFlag && priceFlag && startTimeFlag && endTimeFlag)
			{
				return true;
			}	
		  	else
		  	{
				return false;
		  	}
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