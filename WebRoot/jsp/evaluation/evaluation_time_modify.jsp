<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="utf-8" />

<title>修改评价时间</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<!-- BEGIN GLOBAL MANDATORY STYLES -->
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
	    <div class="page-container">
	      <!--主菜单开始-->
	      <%@include file="/public_module/public_menu.jsp"%>
		  <!--主菜单结束-->
	        <div class="page-content-wrapper">
				<div class="page-content m_overflow_hidden m_page_content">
<!-- 	            	页面内容开始 -->
	            	<div class="col-md-12 col-sm-12 m_page_con">/
	            	<div class="page-bar m_margin_0_0_0_0">
	                    <ul class="page-breadcrumb">
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">教学评价</a><i class="fa fa-circle"></i></li>
	                        <li><span>评价时间设定</span></li>
	                    </ul>
	                </div>
			 <div class="row">
				<div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >

						<div class="portlet-title">
                             <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">修改评价时间</span>
                                    </div>
                         </div>

						<div class="portlet-body">

							<form action="<%=basePath%>evaluation/doModifyEvaluationTime.do" id="submitForm" class="form-horizontal" method="post">
									<div class="form-body">
									
									<div class="form-group">
                                                <label class="control-label col-md-3">开始时间：</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input type="text" size="16" name="startTime" id="startTime" class="form-control" value="${startTime}" />  
													<span class="help-block" style="display: none;" id="startTimeHelp"></span>
                                                </div>
                                     </div>
									<div class="form-group">
                                                <label class="control-label col-md-3">开始时间：</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input type="text" name="endTime" id="endTime" class="m_input form-control" value="${endTime}" />   
													<span class="help-block" style="display: none;" id="endTimeHelp"></span>
                                                </div>
                                     </div>

									<div class="form-group">
                                           <label class="control-label col-md-3">允许评价年级：</label>
                                           <div class="col-md-9 col-lg-4">
                                               <select tabindex="1" name="gradeName" id="gradeSelect" class="form-control"></select>
                                           </div>
                                     </div>
									<div class="form-group">
                                           <label class="control-label col-md-3">允许评价班级：</label>
                                           <div class="col-md-9 col-lg-4">
                                               <select tabindex="1" name="clazzName" id="clazzSelect" class="form-control"></select>
                                           </div>
                                     </div>
									<div class="form-group">
                                                <label class="control-label col-md-3">评价类型：</label>
                                                <div class="col-md-9 col-lg-4 icheck-inline">
                                                   	<c:choose>
										<c:when test="${userType==1 }">
											<div class="controls"  >
												<label class="radio"> <input type="radio" name="type" value="1" checked="checked"/> 用于评论老师 </label> 
												<label class="radio"> <input type="radio" name="type" value="2" /> 用于评论学生</label>
											</div>
										</c:when>
										<c:when test="${userType==2 }">
											<div class="controls" >
												<label class="radio"> <input type="radio" name="type" value="1" /> 用于评论老师 </label> 
												<label class="radio"> <input type="radio" name="type" value="2" checked="checked" /> 用于评论学生</label>
											</div>
										</c:when>
										<c:otherwise>
											<div class="controls"  >
												<label class="radio"> <input type="radio" name="type" value="1" /> 用于评论老师 </label> 
												<label class="radio"> <input type="radio" name="type" value="2" /> 用于评论学生</label>
										   </div>
										</c:otherwise>
									</c:choose>
                                                </div>
                                            </div>

									     <div class="form-group">
                                                <label class="control-label col-md-3">选择模板：</label>
													<div class="controls">
									<table>
										<tr height="50">
												<c:if test="${evaluationClazzModelListSize > 0 }">
													<c:forEach var="e" items="${evaluationTemplates}" varStatus="status">
														<c:if test="${status.index>3&&status.index<5 }"><tr></c:if>
														<td align="center">
															<c:if test="${e.param == 1}">
																 <input type="checkbox" name="teachingfolderId" id="tt${e.id }" value="${e.id }" checked="checked" >选择模板<br>
															</c:if>
															<c:if test="${e.param == 0}">
																 <input type="checkbox" name="teachingfolderId" id="t${e.id }" value="${e.id }">选择模板<br>
															</c:if>
															<img alt="" src="../res/styles/menu/disk.png" style="cursor: pointer;"><br>
															<c:if test="${e.semester==1 }">
																  <span >上学期${e.name }</span>
															</c:if>
															<c:if test="${e.semester==2 }">
																 <span>下学期${e.name }</span>
															</c:if>
														</td>
													</c:forEach>
												</c:if>
												
												<c:if test="${evaluationClazzModelListSize == 0 }">
													<c:forEach var="e" items="${evaluationTemplates }" varStatus="status">
														<c:if test="${status.index>3&&status.index<5 }"><tr></c:if>
														<td align="center">
															<input type="checkbox" name="teachingfolderId" id="t${e.id }" value="${e.id }" >选择模板<br>
															<img alt="" src="../res/styles/menu/disk.png" style="cursor: pointer;"><br>
															<c:if test="${e.semester==1 }">
															   <span >上学期${e.name }</span>
															</c:if>
															<c:if test="${e.semester==2 }">
															  <span>下学期${e.name }</span>
															</c:if>
														</td>
													</c:forEach>
												</c:if>
										</tr>
									</table>
									</div>
                                   </div>

							</div>
							<div class="form-actions">
								<div class="row">
									<button type="button" id="submitButton" class="btn green" id="submitButton">保存 </button>
									<button type="button" class="btn" id="cancel">返回</button>
									<input type="hidden" value="${user.userId}" name="userId" />
									<input type="hidden" value="${timeId}" name="timeId" />
									<input type="hidden" value="" name="teachingfolderIds" id="teachingfolderIds"/>
									<input type="hidden" value="${gradeId}" name="gradeId" id="gradeId"/>
									<input type="hidden" value="${clazzId}" name="clazzId" id="clazzId"/>
								</div>
							</div>
							</form>
						</div>
					</div>

					<!-- END EXAMPLE TABLE PORTLET-->

				</div>

			</div>
			<!-- END PAGE CONTENT-->

		</div>
		</div>
		 	<!-- 亦信聊天开始 -->
        	<%@ include file="/public_module/public_QQ.jsp" %>
            <!-- 亦信聊天结束 -->
		</div>
	<!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
    <!-- 底部开始 -->
	 <%@ include file="/public_module/public_footer.jsp" %>
	 <!-- 底部结束 -->
	<script>

		jQuery(document).ready(function() {  
           

// 			App.init();3

			loadAllClazzList();

			loadAllGradeList();
			loadSubMenu("evaluationManager"); 
			//选取当前菜单位置
			setActive("evaluationManager","setEvaluationTimeManager");
			$('#startTime,#endTime').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			});	
			//表单提交
			$("#submitButton").click(function()
			{
				var status="";
				var checks=document.getElementsByName("teachingfolderId");
			 	for (var i=0; i<checks.length; i++) {
			 		if(checks[i].checked){ 
			        	 status+=checks[i].value+",";
			 		}
				 } 
				document.getElementById("teachingfolderIds").value=status;

				var teachingfolderIds = $("#teachingfolderIds").val();
				if(teachingfolderIds==""||teachingfolderIds=="undefind")
				{
					alert("请选择模板！如果没有可选模板，请去模板设定中添加……");
                }else{
					$("#submitForm").submit();
                }
			
			});	

		});
		

		//加载班级信息
		function loadAllClazzList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadClazzList.do",
				success: function(data)
				{
					var clazzList = $.parseJSON(data);

					//年级select页面html
					var clazzSelectHtml = '<option value="0">--请选择--</option>';
					
					$.each(clazzList, function(n, value)
					 {  
						clazzSelectHtml += '<option value="' + value.id + '">' +value.clazzName + '</option>';
          			 });
					$("#clazzSelect").html(clazzSelectHtml);

            		var clazzId = $("#clazzId").val();
          			
          			if (typeof(clazzId) == "undefined" || clazzId == "undefined")
					{
						$("#clazzSelect").val("0");
					}
					else
					{
						$("#clazzSelect").val(clazzId);
					}
				},
			});
		}

		//加载年级信息
		function loadAllGradeList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadGradeList.do",
				success : function(data) {
					var gradeList = $.parseJSON(data);

					//年级select页面html
					var gradeSelectHtml = '<option value="0">--请选择--</option>';

					$.each(gradeList, function(n, value) {
						gradeSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';
					});
					$("#gradeSelect").html(gradeSelectHtml);
					
					var gradeId = $("#gradeId").val();
          			
          			if (typeof(clazzId) == "undefined" || clazzId == "undefined")
					{
						$("#gradeSelect").val("0");
					}
					else
					{
						$("#gradeSelect").val(gradeId);
					}
				},
			});
		}

		//表单校验相关---end
	</script>

	<!-- END JAVASCRIPTS -->

	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-37564768-1' ]);
		_gaq.push([ '_setDomainName', 'keenthemes.com' ]);
		_gaq.push([ '_setAllowLinker', true ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://'
					: 'http://')
					+ 'stats.g.doubleclick.net/dc.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>
</body>

<!-- END BODY -->

</html>