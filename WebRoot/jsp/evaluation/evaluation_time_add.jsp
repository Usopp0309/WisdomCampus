<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>添加评价时间</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
	 <style>
        .control-label{
            float: left;
		    width: 160px;
		    padding-top: 5px;
		    text-align: right;
        }
        .templet_list{
            min-height: 200px;
		    border: 1px solid #e6e7eb;
		    padding: 0px;
		    margin: 0px;
		    overflow: hidden;
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
            <div class="page-content-wrapper">
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="#">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">教学评价</a><i class="fa fa-circle"></i></li>
                            <li><span>添加评价时间</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">添加评价时间</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>evaluation/doAddEvaluationTime.do"  id="submitForm" class="form-horizontal" method="post">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">开始时间：</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input type="text" size="16" name="startTime" id="startTime" class="form-control" /> 
													<span class="help-block" style="display: none;" id="startTimeHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">结束时间：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="endTime" id="endTime" class="form-control" /> 
													<span class="help-block" style="display: none;" id="endTimeHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">评价年级</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select tabindex="1" name="gradeName" id="gradeSelect" class="form-control"></select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">评价班级</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="clazzName" tabindex="1" id="clazzSelect"></select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">评价类型：</label>
                                                <div class="col-md-9 col-lg-4 icheck-inline">
                                                   <label class="radio"> <input type="radio" class="form-control" name="type" value="1" /> 用于评论老师 </label> 
												   <label class="radio"> <input type="radio" class="form-control" name="type" value="2" /> 用于评论学生</label>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择模板</label>
<!--                                                 <label class="control-label"> 选择模板: </label> -->
													<div class="controls">
														<ul class="templet_list">
															<c:forEach var="e" items="${evaluationTemplates }" varStatus="status">
																<c:if test="${status.index>3&&status.index<5 }"><tr></c:if>
																<li>
																<input type="checkbox" name="teachingfolderId" value="${e.id }" >选择模板<br>
																<img alt="" src="../res/styles/menu/disk.png" style="cursor: pointer;"><br>
																<c:if test="${e.semester==1 }">
																<span >上学期${e.name }</span>
																</c:if>
																<c:if test="${e.semester==2 }">
																<span>下学期${e.name }</span>
																</c:if>
																</li>
															</c:forEach>
														</ul>
													</div>
<!--                                                 <div class="col-md-9 col-lg-4"> -->
<!--                                                     <select id="tt" name="teachingfolderId" class="form-control"> -->
<%-- 	                                                    <c:forEach var="e" items="${evaluationTemplates }" varStatus="status"> --%>
<%-- 															<c:if test="${e.semester==1 }"> --%>
<%-- 													 			<option value="${e.id }">上学期${e.name }</option> --%>
<%-- 															</c:if> --%>
<%-- 															<c:if test="${e.semester==2 }"> --%>
<%-- 													 			<option value="${e.id }">下学期${e.name }</option> --%>
<%-- 															</c:if> --%>
<%-- 														</c:forEach> --%>
                                                   
<!--                                                     </select> -->
<!--                                                 </div> -->
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green"id="submitButton">保存</button>
                                                    <button type="button" class="btn" id="cancel">返回</button>
                                                    <input type="hidden" value="${user.userId}" name="userId" />
													<input type="hidden" value="" name="teachingfolderIds" id="teachingfolderIds"/>
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
			loadSubMenu("evaluationManager"); 
			//选取当前菜单位置
			setActive("evaluationManager","setEvaluationTimeManager");  
			$('#startTime,#endTime').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			});
			loadAllClazzList(0);

			loadAllGradeList();
			
			//年级改变班级也对应的改变
			$("#gradeSelect").change(function(){
				//班级ID
				var gradeId = $(this).val();
				var userId = $("ul li.active").find('a').attr("attr1");	
				var roleId = $("ul li.active").find('a').attr("attr2");
				loadAllClazzList(gradeId);
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
				var teachingfolderId = $("#teachingfolderId").val();
				if(teachingfolderIds==""||teachingfolderIds=="undefind")
				{
					alert("请选择模板！如果没有可选模板，请去模板设定中添加……");
                }else{
					$("#submitForm").submit();
                }
			
			});	
		});
		//加载班级信息
		function loadAllClazzList(gradeId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/getClazzListByGradeId.do",
				data:{
					gradeId : gradeId
				},
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
				},
			});
		}
	</script>
</html>