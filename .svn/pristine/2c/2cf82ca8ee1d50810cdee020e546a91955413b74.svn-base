<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>校车时间添加</title>
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
                            <li><a href="">信息平台</a><i class="fa fa-circle"></i></li>
                            <li><span>校车时间添加</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">校车时间添加</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>schoolbusSchedule/doAddSchoolBusSchedule.do" id="addForm" class="form-horizontal" method="post">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">开始时间：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="startDay" id="startDay" class="form-control"/>
													<span class="help-block" style="display: none;" id="startDayHelp"></span> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">结束时间</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="endDay" id="endDay"  class="form-control "/>
													<span class="help-block" style="display: none;" id="endDayHelp"></span> 
                                                </div>
                                            </div>
                                            <h3 class="form-section">上午上学时间<input value="morningOnSchoolBus" id="morningOffSchoolBus" name="timeCheckBox" type="checkbox"></h3>
                                            <div class="form-group" style="display:none;" id="morningOffSchoolBusStartGroup">
                                                <label class="control-label col-md-3">校车时间：</label>
                                                <div  class="col-md-2 col-lg-2">
													<input class="form-control" type="text" id="morningOffSchoolBusStart" name="morningOffSchoolBusStart"/>
											    	<span class="help-block" id="morningOffSchoolBusStartHelp"></span>
												</div>
												<div class="col-md-1 col-lg-1">--</div>
												<div class="col-md-2 col-lg-2">
													<input class="form-control" type="text" name="morningOffSchoolBusEnd" id="morningOffSchoolBusEnd"/>
												    <span class="help-block" id="morningOffSchoolBusEndHelp"></span>
												</div>
                                            </div>
                                            <h3 class="form-section">上午放学时间<input type="checkbox" value="morningOnSchoolBus" id="morningOnSchoolBus" name="timeCheckBox"/> </h3>
                                            <div class="form-group" id="morningOnSchoolBusStartGroup" style="display:none;">
                                                <label class="control-label col-md-3">校车时间：</label>
                                                <div class="col-md-2 col-lg-2">
													<input class="form-control" type="text" id="morningOnSchoolBusStart" name="morningOnSchoolBusStart"/>
											    	<span class="help-block" id="morningOnSchoolBusStartHelp"></span>
												</div>
												<div class="col-md-1 col-lg-1">--</div>
												<div class="col-md-2 col-lg-2">
													<input class="form-control" type="text" name="morningOnSchoolBusEnd" id="morningOnSchoolBusEnd"/>
											    	<span class="help-block" id="morningOnSchoolBusEndHelp"></span>
												</div>
	                                            </div>
                                            <h3 class="form-section">下午上学时间<input type="checkbox" value="afternoonOffSchoolBus" id="afternoonOffSchoolBus" name="timeCheckBox"/></h3>
                                            <div class="form-group" id="afternoonOffSchoolBusStartGroup" style="display: none;">
                                                <label class="control-label col-md-3">校车时间 </label>
                                                <div class="col-md-2 col-lg-2">
													<input class="form-control" type="text" id="afternoonOffSchoolBusStart" name="afternoonOffSchoolBusStart"/>
											    	<span class="help-block" id="afternoonOffSchoolBusStartHelp"></span>
												</div>
												<div class="col-md-1 col-lg-1">--</div>
												<div class="col-md-2 col-lg-2">
													<input class="form-control" type="text" id="afternoonOffSchoolBusEnd" name="afternoonOffSchoolBusEnd"/>
											    	<span class="help-block" id="afternoonOffSchoolBusEndHelp"></span>
												</div>
                                            </div>
                                            <h3 class="form-section">下午放学时间<input type="checkbox" value="afternoonOnSchoolBus" id="afternoonOnSchoolBus" name="timeCheckBox"/> </h3>
                                            <div class="form-group" id="afternoonOnSchoolBusStartGroup" style="display: none;">
                                                <label class="control-label col-md-3">校车时间</label>
                                                <div class="col-md-2 col-lg-2">
													<input class="form-control" type="text" id="afternoonOnSchoolBusStart" name="afternoonOnSchoolBusStart"/>
											    	<span class="help-block" id="afternoonOnSchoolBusStartHelp"></span>
												</div>
												<div class="col-md-1 col-lg-1">--</div>
												<div class="col-md-2 col-lg-2">
													<input class="form-control" type="text" id="afternoonOnSchoolBusEnd" name="afternoonOnSchoolBusEnd"/>
											    	<span class="help-block" id="afternoonOnSchoolBusEndHelp"></span>
												</div>
                                            </div>
                                            <input type="hidden" value="${user.userId}" name="userId"/>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green" id="save">新增</button>
                                                    <button type="button" class="btn" onclick="history.go(-1);">返回</button>
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

			$(document).ready(function() {
			loadSubMenu("schoolBusManage"); 
			//选取当前菜单位置
			setActive("schoolBusManage","schoolBusSchedule");  
			$('#startDay,#endDay').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			});
			$('#morningOffSchoolBusStart,#morningOffSchoolBusEnd,#morningOnSchoolBusStart,#morningOnSchoolBusEnd,#afternoonOffSchoolBusStart,#afternoonOffSchoolBusEnd,#afternoonOnSchoolBusStart,#afternoonOnSchoolBusEnd').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});

			//结束时间
			$("#endDay").blur(function(){
				var endDay = $("#endDay").val();
				//未输入结束时间
				var startDay = $("#startDay").val();
				
				if ("" == endDay)
				{
					layer.tips('结束时间不能为空', '#endDay');
				}
				else if("" != endDay && "" != startDay)
				{
                    if(!checkTimeLegal(startDay, endDay))
                    {
    					layer.tips('开始时间不能大于结束时间', '#endDay');
                    }   
				}	
			}); 
			
			//监听上午上学下车
			$('#morningOffSchoolBus').click(function() { 
				if($(this).is(":checked"))
			   	{
				   	$("#morningOffSchoolBusStartGroup").show();
			   	}
				else
				{
					$("#morningOffSchoolBusStartGroup").hide();
				}
			}); 
			
			//监听上午回家上车
			$('#morningOnSchoolBus').click(function() { 
				if($(this).is(":checked"))
			   	{
				   	$("#morningOnSchoolBusStartGroup").show();
				   	
			   	}
				else
				{
					$("#morningOnSchoolBusStartGroup").hide();
				   	
				}
			}); 

			//监听下午上学下车
			$('#afternoonOffSchoolBus').click(function() { 
				
				if($(this).is(":checked"))
			   	{
				   	$("#afternoonOffSchoolBusStartGroup").show();
			   	}
				else
				{ 
					$("#afternoonOffSchoolBusStartGroup").hide();
				   	
				}
				
			});
			
			//监听下午回家上车
			$('#afternoonOnSchoolBus').click(function() { 
				if($(this).is(":checked"))
			   	{
				   	$("#afternoonOnSchoolBusStartGroup").show();
				   	
			   	}
				else
				{
					$("#afternoonOnSchoolBusStartGroup").hide();
				   	
				}
			}); 
			
			
			//表单提交
			$("#save").click(function(){
				if (checkForm())
				{
					$("#addForm").submit();
				}
			});
			
		});

		function checkTimeLegal(startDay, endDay)
		{

			var flg = false;
			var startDate = new Date(startDay);
			var endDate = new Date(endDay);

			if (startDate > endDate)
			{
				flg = false;
			}
			else
			{
                flg = true
			}	
			return flg;
	   }
		function checkForm()
		{
            //验证常量
            var morningOffSchoolBusStartFlag = true;
            var morningOffSchoolBusEndFlag = true;
            var morningOnSchoolBusStartFlag = true;
            var morningOnSchoolBusEndFlag = true;
            var afternoonOffSchoolBusStartFlag = true;
            var afternoonOffSchoolBusEndFlag = true;
            var afternoonOnSchoolBusStartFlag = true;
            var afternoonOnSchoolBusEndFlag = true;
            var startFlag = true;
            var dayFlag = true;
             
			var morningOffSchoolBusStart = $("#morningOffSchoolBusStart").val();
			var morningOffSchoolBusEnd = $("#morningOffSchoolBusEnd").val();
			var morningOnSchoolBusStart = $("#morningOnSchoolBusStart").val();
			var morningOnSchoolBusEnd = $("#morningOnSchoolBusEnd").val();
			var afternoonOffSchoolBusStart = $("#afternoonOffSchoolBusStart").val();
			var afternoonOffSchoolBusEnd = $("#afternoonOffSchoolBusEnd").val();
			var afternoonOffSchoolBusStart = $("#afternoonOffSchoolBusStart").val();
			var afternoonOffSchoolBusEnd = $("#afternoonOffSchoolBusEnd").val();

			var endDay = $("#endDay").val();
			//未输入结束时间
			var startDay = $("#startDay").val();
			
			if ("" == morningOffSchoolBusStart &&"" == morningOnSchoolBusStart &&"" == afternoonOffSchoolBusStart &&"" == afternoonOffSchoolBusStart )
			{
				 layer.msg('至少选择一个开始时间段');
				startFlag = false;
			}
			else
			{
				startFlag = true;
			}

			if ("" == endDay || "" == startDay )
			{
				 layer.msg('请选择开始日期，结束日期');
				dayFlag = false;
			}
			else
			{
				dayFlag = true;
			}
            
			//未输入开始时间
			if ("" == morningOffSchoolBusStart && morningOffSchoolBusEnd !="")
			{
				layer.tips('请输入对应的开始时间', '#morningOffSchoolBusEnd');
				morningOffSchoolBusEndFlag = false;
			}
			else
            {
				morningOffSchoolBusEndFlag = true;    
             }
			//未输入开始时间
			if ("" == morningOnSchoolBusStart && morningOnSchoolBusEnd !="")
			{
				layer.tips('请输入对应的开始时间', '#morningOffSchoolBusEnd');
				morningOnSchoolBusEndFlag = false;
			}
			else
            {
				morningOnSchoolBusEndFlag = true;    
             }
			//未输入开始时间
			if ("" == afternoonOffSchoolBusStart && afternoonOffSchoolBusEnd !="")
			{
				layer.tips('请输入对应的开始时间', '#morningOffSchoolBusEnd');
				afternoonOffSchoolBusEndFlag = false;
			}
			else
            {
				afternoonOffSchoolBusEndFlag = true;    
             } 
			//未输入开始时间
			if ("" == afternoonOnSchoolBusStart && afternoonOnSchoolBusEnd !="")
			{
				layer.tips('请输入对应的开始时间', '#morningOffSchoolBusEnd');
				afternoonOnSchoolBusEndFlag = false;
			}
			else
            {
				afternoonOnSchoolBusEndFlag = true;    
             }       

	        if(startFlag && dayFlag && morningOffSchoolBusEndFlag && morningOnSchoolBusEndFlag && afternoonOffSchoolBusEndFlag && afternoonOnSchoolBusEndFlag) 
	        {
                return true;
		    }
	        else
	        {
                return false;
			}   


		}
	</script>
	</html>