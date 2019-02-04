<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>视频设备添加</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
        </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
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
            <div class="page-content-wrapper">
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="<%=basePath %>camera/toCameraManager.do">视频直播</a><i class="fa fa-circle"></i></li>
                            <li><span>视频设备添加</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">视频设备添加</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>camera/doAddCamera.do" id="submitForm" class="form-horizontal" method="post" >
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">设备编码：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="cameraCode"  id="cameraCode"  class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">设备名称：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="cameraName"  id="cameraName"  class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">设备密码：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="password"  id="password"  class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">地点名称：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="placeId" name="placeId"></select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="type" name="type">
														<option value= "0" selected="selected">公用</option>
														<option value= "1">私用</option>
														<option value= "2">全校</option>
													</select>
                                                </div>
                                            </div>
                                            <h3 class="form-section">设置时间</h3>
                                            
                                            <div class="form-group">
                                                <label class="control-label col-md-3">开始日期：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text"  readonly="readonly" name="startDay" id="startDay" class="day form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">结束日期：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text"  readonly="readonly" name="endDay" id="endDay" class="day form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">开始时间：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text"  readonly="readonly" name="startTime" id="startTime" class="time form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">结束时间：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text"readonly="readonly" name="endTime" id="endTime" class="time form-control"/>
                                                </div>
                                            </div>
                                            
                                            <input type="hidden" id="pId" value="${placeId}">
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
        </div>
        <!-- 内容页结束 -->
        <!-- 底部开始 -->
        <%@ include file="/public_module/public_footer.jsp" %>
        <!-- 底部结束 -->
    </body>
        <!-- 公共js开始 -->
        <%@ include file="/public_module/public_js.jsp" %>
        <!-- 公共js结束 -->
	<script>

		jQuery(document).ready(function() { 
			loadSubMenu("liveCameraManager"); 
			//选取当前菜单位置
			setActive("liveCameraManager","cameraManager");
			$('.day').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			}); 
			$('.time').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			}); 

			loadPlaceList();
            //设备编码校验
            $("#cameraCode").blur(function(){
                var cameraCode = $.trim($("#cameraCode").val());
                if("" == cameraCode)
                {
		            layer.tips('设备编码不能为空', '#cameraCode');
                }else if(cameraCode.length>50){
                	 layer.tips('设备编码最多50个字符', '#cameraCode');	
                }
            });
            //设备编码校验
            $("#cameraName").blur(function(){
                var cameraName = $.trim($("#cameraName").val());
                if("" == cameraName)
                {
		            layer.tips('设备名称不能为空', '#cameraName');
                }else if(cameraName.length>50){
                	 layer.tips('设备名称最多50个字符', '#cameraName');	
                }
            });
            //设备密码校验
            $("#password").blur(function(){
                var password = $.trim($("#password").val());
                if("" == password)
                {
		            layer.tips('设备密码不能为空', '#password');
                }else if(password.length>50){
                	layer.tips('最多50个字符', '#password');	
                }
               
            });

            //结束日期校验
            $("#endDay").blur(function(){
                var startDay = $("#startDay").val();
                var endDay = $("#endDay").val();
                var start = new Date(startDay.replace("-", "/").replace("-", "/"))
                var end = new Date(endDay.replace("-", "/").replace("-", "/"))
                if(startDay!="" && endDay!="" && start>end)
                {
		            layer.tips('结束日期不能晚于开始日期', '#endDay');
                }
                
            });
            
            //结束日期校验
            $("#startDay").blur(function(){
                var startDay = $("#startDay").val();
                var endDay = $("#endDay").val();
                var start = new Date(startDay.replace("-", "/").replace("-", "/"))
                var end = new Date(endDay.replace("-", "/").replace("-", "/"))
                if(startDay!="" && endDay!="" && start>end)
                {
		            layer.tips('结束日期不能晚于开始日期', '#endDay');
                }
                
            });
             //记地点类型验证
            $("#placeId").blur(function(){
                var placeId = $("#placeId").val();
                if(0 == placeId)
                {
		            layer.tips('请选择地点', '#placeId');
                }
                
            });
            var startTime = $.trim($("#startTime").val());
            var endTime =  $.trim($("#endTime").val());
            $("#startTime").blur(function(){
                if("" == startTime)
                {
		            layer.tips('请输入开始时间', '#startTime');
                }else if(startTime!="" && endTime!=""){
                	startTime=startTime.replace(":","");
                	endTime=endTime.replace(":","");
                	if(startTime>=endTime){
                		 layer.tips('结束时间不能早于结束时间', '#endTime');	
                	}
                }
            });
            $("#endTime").blur(function(){
                if("" == endTime)
                {
		            layer.tips('请输入结束时间', '#endTime');
                }else if(startTime!="" && endTime!=""){
                	startTime=startTime.replace(":","");
                	endTime=endTime.replace(":","");
                	if(startTime>=endTime){
                		 layer.tips('结束时间不能早于结束时间', '#endTime');	
                	}
                }
            });
			//表单提交
			$("#submitButton").click(function()
			{
			    if(checkForm())
				{
				    $("#submitForm").submit();
				}
			
			});	
		});
		
		//表单校验相关---begin
		
		function checkForm()
		{
			 //验证常量 
            var cameraCodeFlag = false;
            var passwordFlag = false;
            var placeIdFlag = false;
            var timeFlag = false;
            //设备编码校验
              var cameraCode = $.trim($("#cameraCode").val());
              if("" == cameraCode)
              {
                  layer.tips('设备编码不能为空', '#cameraCode');
                  cameraCodeFlag = false;
              }else{
                  cameraCodeFlag = true;
              }
                //设备名称
              var cameraName = $.trim($("#cameraName").val());
              if("" == cameraName)
              {
                 layer.tips('设备名称不能为空', '#cameraName');
                 return false;
              }else if(cameraName.length>50){
              	 layer.tips('设备名称最多50个字符', '#cameraName');
              	 return false;
              }
              
             //设备密码校验
              var password = $.trim($("#password").val());
              if("" == password)
              {
            	  layer.tips('设备密码不能为空', '#password');
            	  passwordFlag = false;
              }else if(password.length>50){
              	layer.tips('最多50个字符', '#password');	
              }
              else
              {
                  passwordFlag = true;
              }
            
             //记地点类型验证
              var placeId = $.trim($("#placeId").val());
              if(0 == placeId)
              {
                  layer.tips('请选择地点', '#placeId');
                  placeIdFlag = false;
              }
              else
              {
                 placeIdFlag = true;
              }

              var startDay = $("#startDay").val();
              var endDay = $("#endDay").val();
              var startTime = $.trim($("#startTime").val());
              var endTime = $.trim($("#endTime").val());
              var start = new Date(startDay.replace("-", "/").replace("-", "/"));
              var end = new Date(endDay.replace("-", "/").replace("-", "/"));
              if(startDay!="" && endDay!="" && start>end)
              {
		          layer.tips('结束日期不能晚于开始日期', '#endDay');
		          timeFlag = false;
              }
              else
              {
                 timeFlag = true;
              }
			  if(startTime==""){
				  layer.tips('请输入开始时间', '#startTime'); 
				  return false;
			  }else if(startTime!="" && endTime!=""){
              	startTime=startTime.replace(":","");
            	endTime=endTime.replace(":","");
            	if(startTime>=endTime){
            		 layer.tips('结束时间不能早于结束时间', '#endTime');
            		 return false;
            	}
            }
			  if(endTime==""){
				  layer.tips('请输入结束时间', '#endTime'); 
				  return false;
			  }else if(startTime!="" && endTime!=""){
              	startTime=startTime.replace(":","");
            	endTime=endTime.replace(":","");
            	if(startTime>=endTime){
            		 layer.tips('结束时间不能早于结束时间', '#endTime');
            		 return false;
            	}
            }
			  
			  if (cameraCodeFlag && passwordFlag && placeIdFlag && timeFlag)
			  {
				return true;
			  }	
			  else
			  {
				return false;
			  }
		}
		//加载记录点页面
		function loadPlaceList()
		{
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>camera/getPlaceList.do",
				data:{
				},
				success: function(data){
					var list = eval("(" + data + ")");
					var appendHtml = '<option value="0">---请选择---</option>';
					$.each(list, function(n, value) {  
						appendHtml += '<option value="'+value.id+'">'+value.name+'</option>';
          			}); 
          			$("#placeId").html(appendHtml);
          			
	       			var pId = $("#pId").val();
	      			if (pId != "" && pId != undefined)
					{
						$("#placeId").val(pId);
					}
          			
				},
			});
			App.unblockUI(body);
		}
	
	</script>
</html>