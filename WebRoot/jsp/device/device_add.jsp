<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>添加读卡设备</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束-->
	 	<style type="text/css">
	 		#inoutTypeDiv{display:none}
	 	</style> 
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
                            <li><span>添加读卡设备</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">添加读卡设备</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>device/doAddDevice.do" id="submitForm" class="form-horizontal" method="post" >
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">设备号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="code"  id="code"  class="form-control"/>
											      	<span class="help-block" style="display: none;" id="codeHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">设备名称：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="name"  id="name"  class="form-control"/>
													<span class="help-block" style="display: none;" id="nameSpan"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">IP：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="ip"  id="ip"  class="form-control"/>
		                                        	<span class="help-block" style="display: none;" id="ipSpan"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">记录点类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="positionType" disabled="disabled" name="type">
														<c:if test="${type==1}">
															<option value="1">校门</option>
															<input type="hidden" name="positionType" value="${type}">
														</c:if>
														<c:if test="${type==2}">
															<option value="2">宿舍</option>
															<input type="hidden" name="positionType" value="${type}">
														</c:if>
														<c:if test="${type==3}">
															<option value="3">会议</option>
															<input type="hidden" name="positionType" value="${type}">
														</c:if>
														<c:if test="${type==4}">
															<option value="4">校车</option>
															<input type="hidden" name="positionType" value="${type}">
														</c:if>
														<%-- <c:if test="${type==5}">
															<option value="5">教室</option>
															<input type="hidden" name="positionType" value="${type}">
														</c:if> --%>
													</select>
													<span class="help-block" style="display: none;" id="positionTypeSpan"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">进出设定：</label>
                                                <div class="col-md-9 col-lg-4">
                                                       <label class="checkbox">
	
														<input type="checkbox" checked="checked" class="form-control" value="" id="isInout"/> 区分进出类型
				
														</label>
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
														<span class="help-block" id="inoutTypeSpan"></span>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green"  id="submitButton">保存</button>
                                                    <button type="button" class="btn" id="cancel">返回</button>
                                                    <input type="hidden" value="${user.userId}" name="userId"/>
													<input type="hidden" value="${placeId}" name="placeId" id="placeId"/>
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

		$(function() {  
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","placeManage"); 
			$("#inoutType").val(0);
			$("#inoutTypeDiv").show();
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
            
             //记录点类型验证
            $("#positionType").blur(function(){
                var positionType = $("#positionType").val();
                if(0 == positionType)
                {
		            layer.tips('请选择类型', '#positionType');
                }
            });
			//表单提交
			$("#submitButton").click(function()
			{
			    if(checkForm())
				{
			    	var indexlayer = layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
				    $("#submitForm").submit();
				}
			
			});	
			
		});
		
		
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
		function checkCode(code)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					code : code,
				},
				url: "<%=basePath%>device/docheckCode.do",
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
	</script>
	</html>