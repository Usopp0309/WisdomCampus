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
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
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
                                                    <select class="form-control" id="departmentSelect" name="departmentSelect"></select>
													<input type="hidden" name="departmentId" id="departmentId" value="${patrol.departmentId}"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">巡查人员</label>
                                                <div class="col-md-4">
                                                    <select class="form-control" id="teacherSelect" name="teacherSelect"></select>
													<input type="hidden" name="userId" id="userId" value="${patrol.userId}"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">巡查地点</label>
                                                <div class="col-md-4">
                                                    <select class="form-control" id="placeSelect" name="placeSelect"></select>
													<input type="hidden" name="placeId" id="placeId" value="${patrol.placeId}"/>
												</div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" onclick="check()" class="btn design_btn">确定</button>
                                                    <button type="button" class="btn back_btn" id="cancel">取消</button>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="patrolId" id="patrolId" value="${patrol.id}"/>
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
			setActive("safeSchool","patrol"); 
			$(function(){
				loadDepartmentList();
				$("#departmentSelect").change(function(){
					var departmentId=$("#departmentSelect").val();
					loadTeacherListByDepartmentId(departmentId);
				});

				loadPlaceList();
			});
			
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
						var departmentId = $("#departmentId").val();
						$.each(departmentList, function(n, value) {
								if(departmentId == value.id){
									appendHtml += '<option value="' + value.id + '" selected="selected">' + value.departmentName + '</option>';
								}else{
									appendHtml += '<option value="' + value.id + '">' + value.departmentName + '</option>';
								}
			      				
			      			}); 
			      		$("#departmentSelect").html(appendHtml);
			      		var departmentId=$("#departmentSelect").val();
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
						var userId = $("#userId").val();
						$.each(teacherList, function(n, value) {
							if(userId == value.userId){
								appendHtml += '<option value="' + value.userId + '" selected="selected">' + value.realName + '</option>';
							}else{
								appendHtml += '<option value="' + value.userId + '">' + value.realName + '</option>';
							}
			      				
			      			}); 
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
						var placeId = $("#placeId").val();
						$.each(placeList, function(n, value) {
							if(value.id == placeId){
								appendHtml += '<option value="' + value.id + '" selected="selected">' + value.name + '</option>';
							}else{
								appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
							}
			      			}); 
			      		$("#placeSelect").html(appendHtml);
					},
				});
			}

			function check(){
				var patrolId = $("#patrolId").val();
				var departmentId=$("#departmentSelect").val();
				var userId = $("#teacherSelect").val();
				var placeId = $("#placeSelect").val();
				var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
				$.ajax({
					type: "post",
					url: "<%=basePath%>patrol/doUpdatePatrol.do",
					data:{
						departmentId : departmentId,
						userId : userId,
						placeId : placeId,
						patrolId : patrolId
						},
					success: function(data){
						var flag = eval("(" + data + ")");
						layer.close(indexlayer);
						if(flag){
							layer.msg('修改成功');
							window.location.href = "<%=basePath %>patrol/toPatrolList.do";
						}else{
							layer.msg('修改失败，请稍后重试');
						}
					},
				});
			}
	</script>
</html>