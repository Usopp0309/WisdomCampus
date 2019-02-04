<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>修改设备</title>
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
            <div class="page-content-wrapper">
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
                            <li><span>修改设备</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">修改设备</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>device/doModifyDevice.do" id="submitForm" class="form-horizontal" method="post">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">编号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="code" id="code" class="form-control"/>
										     		<input type="hidden" size="16" name="codeOrg" id="codeOrg" class="m-wrap span6"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">名称：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="name"  id="name" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">ip：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="ip"  id="ip" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">记录点类型:</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="positionType" name="positionType" >
														<option value="0">--请选择--</option>
														<option value="1">校门</option>
														<option value="2">宿舍</option>
														<option value="3">会议</option>
														<option value="4">校车</option>
													</select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">进出区分：</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input type="checkbox" class="form-control" value="" id="isInout"/> 不区分进出类型
                                            	</div>
                                            </div>
                                            <div class="form-group" id="inoutTypeDiv">
                                                <label class="control-label col-md-3">进出类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="inoutType" name="inoutType">
														<option value="0">--请选择--</option>
														<option value="1">进</option>
														<option value="2">出</option>
													</select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<input type="hidden" value="${deviceId}" name="deviceId" id="deviceId"/>
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

		jQuery(document).ready(function(){
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","placeManage");  
			loadDeviceDetail();
			$("#inoutType").val(0);
			//点击区分进出checkbox
			$("#isInout").click(function(){
				  //未选中则显示类型选择select
				if ($(this).is(":checked"))
				{
					$("#inoutTypeDiv").show();
					 //记录点类型验证
		            $("#inoutType").blur(function(){
		                var inoutType = $("#inoutType").val();
		                if(0 == inoutType)
		                {
				            layer.tips('请选择类型', '#inoutType');
		                }
		            });
				}
				//如果选中，表示不区分进出类型，隐藏进出类型选择select
				else
				{
				   $("#inoutType").val(0);
				   $("#inoutTypeDiv").hide();
				}
			});
			 //表单验证
            //设备号验证
            $("#code").blur(function(){
                var code = $("#code").val();
                if("" == code)
                {
		            layer.tips('设备号不能为空', '#code');
                }
                else if(checkCode(code))
                {
					layer.tips('设备号已存在', '#code');
				}else if(code.length>32){
					layer.tips('设备号最多32个字符', '#code');	
				}
            });
            
            //设备名称验证
            $("#name").blur(function(){
                var name =  $.trim($("#name").val());
                if("" == name)
                {
		            layer.tips('名称不能为空', '#name');
                }else if(name.length>32){
                	layer.tips('名称最多32个汉字', '#name');	
                }
            });
            //设备IP验证
            $("#ip").blur(function(){
                var ip = $.trim($("#ip").val());
                var nameMesage = "";
                if("" == ip)
                {
		            layer.tips('ip不能为空', '#ip');
                }else if(ip.length>64){
                	layer.tips('ip最多64个字符', '#ip');	
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

		//初始化数据
		function loadDeviceDetail()
		{
			$("#isInout").prop("checked",false);
			var deviceId = $("#deviceId").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>device/loadDeviceDetail.do",
				data:{
					deviceId : deviceId
				},
				success: function(data){
					var position = eval("(" + data + ")");
					$("#code").val(position.code);
					$("#codeOrg").val(position.code);
					$("#name").val(position.name);
					$("#ip").val(position.ip);
					$("#positionType").val(position.positionType);
					var inoutType = parseInt(position.inoutType);
        			switch(inoutType)
        			{ 
        				//不区分
        				case 0 : 
        					$("#isInout").prop("checked",false);
        					$("#inoutTypeDiv").hide();
        					break;
        				//进	 
        				case 1 : 
        					$("#isInout").prop("checked",true);
        					$("#inoutTypeDiv").show();
        					$("#inoutType").val(1);
        					break; 
						//出
            			case 2 : 
            				$("#isInout").prop("checked",true);
            				$("#inoutTypeDiv").show();
            				$("#inoutType").val(2);	
        					break; 
        				default : 
        					$("#isInout").prop("checked",false);
        					$("#inoutTypeDiv").hide();
        					break;
        			} 
				},
			});
		}
		
			
		//表单校验相关---begin
		
		function checkForm()
		{
			 //验证常量 
            var flagCode = false;
            var flagName = false;
            var flagIp = false;
            var flagPositionType = false;
            var flagIsInout = true;
            var flagInoutType = true;
            
			//部门编号
			var code = $("#code").val();
			var name = $("#name").val();
			var ip = $("#ip").val();
			var positionType = $("#positionType").val();
			//未输入部门编号
			if ("" == code)
			{
	            layer.tips('设备号不能为空', '#code');
				flagCode = false;
			}
			else if (checkCode(code))
			{
				layer.tips('设备编号已存在', '#code');
				flagCode = false;
			}else if(code.length>32){
				layer.tips('设备号最多32个字符', '#code');	
				flagCode = false;
			}
			else
			{
				flagCode = true;
			}
			
			//未输入部门名称
			if ("" == name)
			{
	             layer.tips('名称不能为空', '#name');
				 flagName = false;
			}else if(name.length>32){
            	layer.tips('名称最多32个汉字', '#name');	
            	flagName = true;
            }
			else
			{
				flagName = true;
			}
			
			if("" == ip)
            {
                layer.tips('ip不能为空', '#ip');
                flagIp = false;
            }else if(ip.length>64){
            	layer.tips('ip最多64个字符', '#ip');
            	 flagIp = false;
            }
            else
            {
               flagIp = true;
            }
            if ($("#isInout").is(":checked"))
			{
				$("#inoutTypeDiv").show();
				 //记录点类型验证
                var inoutType = $("#inoutType").val();
                var nameMesage = "";
                if(0 == inoutType)
                {
		            layer.tips('请选择类型', '#inoutType');
		            flagIsInout = false;
                    flagInoutType = false;
                  
                } else
                {
                   flagIsInout = true;
                   flagInoutType = true;
                }
			}
			//未选中则显示类型选择select
			else
			{
	           $("#inoutTypeDiv").hide();
	           flagPositionType=true;
			}    
			
			if (flagCode && flagIp && flagName && flagInoutType)
			{
				return true;
			}	
			else
			{
				return false;
			}
		
		}
		
		function checkCode(code,codeOrg)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					code : code,
					codeOrg : codeOrg
				},
				url: "<%=basePath%>device/checkCodeByModify.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此部门编号存在
					if ("success" == result.resultCode)
					{
						flag = true;
					}
					else
					{
						flag = false;
					}
					
				},
			});
			
			return flag;
		}
		
		
        //表单校验相关---end
		
	</script>
</html>