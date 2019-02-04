<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>校务巡查</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
	 	<style type="text/css">
 	 		.select2-container{ 
		 		float: left; 
			 	width: 100% !important; 
 		 	} 
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
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content m_overflow_hidden m_page_content">
                	
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
	                        <li><a href="<%=basePath%>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="<%=basePath%>inout/toInoutList.do">平安校园</a><i class="fa fa-circle"></i></li>
                            <li><span>校务巡查设置</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">校务巡查设置</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                        	<div class="m_margin_0_0_15_0">
                        		<ul class="nav nav-tabs">
                                    <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<r:right rightCode="patrol">
											<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
												<li class="roleLi">
													<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
												</li>
											</c:if>
										</r:right>
									</c:forEach>
                                </ul>
                            </div>
                            
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">校务巡查设置</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="#" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">所属部门</label>
                                                <div class="col-md-4">
                                                    <select class="form-control" id="departmentSelect" name="departmentId"></select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">巡查人员</label>
                                                <div class="col-md-4">
                                                    <select  class="form-control select2me m_select" id="teacherSelect" name="teacherSelectId"></select>
                                                </div>
                                                <input type="hidden" name="teacherName" id="teacherName">
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">巡查地点</label>
                                                <div class="col-md-4">
                                                    <select class="form-control select2me m_select" id="placeSelect" name="placeSelectId"></select>
												</div>
												<input type="hidden" name="placeName" id="placeName">
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">巡查日期</label>
                                                <div class="col-md-4">
                                                    <div class="input-group input-large date-picker input-daterange">
		                                                <input type="text" id="startDate" class="form-control" name="startDate">
		                                                <span class="input-group-addon" >至</span>
		                                                <input type="text" class="form-control" id="endDate" name="endDate">
			                                        </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">巡查时间点</label>
                                                <div class="col-md-4">
                                                    <div class="input-group input-large date-picker input-daterange">
		                                                <input type="text" class="form-control time" id="startTime" name="startTime">
		                                                <span class="input-group-addon">至</span>
		                                                <input type="text" class="form-control time" id="endTime" name="endTime">
			                                        </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" onclick="check()" class="btn green">确定</button>
                                                    <button type="button" class="btn default" id="cancel">取消</button>
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
   
   <script type="text/javascript">
   	$(function(){
   	    //选取当前菜单位置
   		setActive("safeSchool","patrol"); 
   		$('#startDate,#endDate').datetimepicker({
			 format:"Y-m-d" ,
		     timepicker:false
			});
		$('.time').datetimepicker({
			datepicker:false,
			format:'H:i',
			step:5
		});   
		loadDepartmentList();

		$("#departmentSelect").change(function(){
			var departmentId=$("#departmentSelect").val();
			loadTeacherListByDepartmentId(departmentId);
		});

		loadPlaceList();
		
   	})
   	
   	//加载部门列表
	function loadDepartmentList()
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>depart/getDepartList.do",
			data:{
				permissionCode : "patrolModify"
				},
			success: function(data){
				var departmentList = eval("(" + data + ")");
				var appendHtml = '';
				$.each(departmentList, function(n, value) {
          				appendHtml += '<option value="' + value.id + '">' + value.departmentName + '</option>';
          			}); 
          		var departmentId=$("#departmentId").val();//值
          		if(departmentId==""||departmentId==null){
          			departmentId = departmentList[0].id;//Id
          			$("#departmentName").val(departmentList[0].departmentName);
          		}
          		$("#departmentSelect").html(appendHtml);
          		loadTeacherListByDepartmentId(departmentId);
			},
		});
	}

   	//根据部门id加载教师列表
	function loadTeacherListByDepartmentId(departmentId)
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>patrol/loadTeacherListByDepartmentId.do",
			data:{
				departmentId : departmentId
				},
			success: function(data){
				var teacherList = eval("(" + data + ")");
				var appendHtml = '';
				$.each(teacherList, function(n, value) {
          				appendHtml += '<option value="' + value.userId + '">' + value.realName + '</option>';
          			}); 
          		var teacherSelectId=$("#teacherSelectId").val();
          		if(teacherSelectId==""||teacherSelectId==null){
          			teacherSelectId = teacherList[0].userId;
          			$("#teacherName").val(teacherList[0].realName);
          		}
          		var teacherName=$("#teacherName").val();
          		$("#teacherSelect").change(function(){
    				$("#teacherName").val($('#teacherSelect option:selected').text());
    			});
          		$("#teacherName").val(teacherName);
          		$("#select2-teacherSelect-container").attr("title",teacherName);
          		$("#select2-teacherSelect-container").text(teacherName);
          		$("#teacherSelect").html(appendHtml);
			},
		});
	}

	//加载地点列表
	function loadPlaceList(){
		$.ajax({
			type: "post",
			url: "<%=basePath%>patrol/getPatrolPlaceList.do",
			data:{
				type:1
				},
			success: function(data){
				var placeList = eval("(" + data + ")");
				var appendHtml = '';
				$.each(placeList, function(n, value) {
          				appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
          			});
				var placeSelectId=$("#placeSelectId").val();
          		if(placeSelectId==""||placeSelectId==null){
          			placeSelectId = placeList[0].id;
          			$("#placeName").val(placeList[0].name);
          		}
          		var placeName=$("#placeName").val();
          		$("#placeSelect").change(function(){
    				$("#placeName").val($('#placeSelect option:selected').text());
    			});
          		$("#placeName").val(placeName);
          		$("#select2-placeSelect-container").attr("title",placeName);
          		$("#select2-placeSelect-container").text(placeName);
          		$("#placeSelect").html(appendHtml);
			},
		});
	}

	function check(){
		var departmentId=$("#departmentSelect").val();
		var userId = $("#teacherSelect").val();
		var placeId = $("#placeSelect").val();
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();

		if(typeof(startDate) == "undefined" || startDate == ""){
			layer.tips('巡查日期不能为空', '#startDate');
	        return false;
		}

		if(typeof(endDate) == "undefined" || endDate == "")
		{
			layer.tips('巡查日期为空', '#endDate');
	        return false;
		}
		if(typeof(startTime) == "undefined" || startTime == "")
		{
			layer.tips('巡查时间点不能为空', '#startTime');
	        return false;
		}
		if(typeof(endTime) == "undefined" || endTime == "")
		{
			layer.tips('巡查时间点不能为空', '#endTime');
	        return false;
		}
		
		var startDateMill = (new Date(startDate)).getTime();
		var endDateMill = (new Date(endDate)).getTime();
		if(endDateMill < startDateMill ){
			layer.tips('巡查结束日期不能小于开始日期', '#endDate');
	        return false;
		}
		var startTimeMill = (new Date(startDate+' '+startTime)).getTime();
		var endTimeMill = (new Date(startDate+' '+endTime)).getTime();
		if(endTimeMill < startTimeMill){
			layer.tips('巡查结束时间点不能小于开始时间点', '#endTime');
	        return false;
		}
		var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
		$.ajax({
			type: "post",
			url: "<%=basePath%>patrol/doAddPatrol.do",
			data:{
				departmentId : departmentId,
				userId : userId,
				placeId : placeId,
				startDate : startDate,
				endDate : endDate,
				startTime : startTime,
				endTime : endTime
				},
			success: function(data){
				var flag = eval("(" + data + ")");
				layer.close(indexlayer);
				if(flag){
					layer.msg('添加成功');
					window.location.href = "<%=basePath %>patrol/toPatrolList.do";
				}else{
					layer.msg('添加失败，请稍后重试');
				}
			},
		});
	}
   </script>
</html>