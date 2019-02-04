<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>导入课程表页面</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
	 	<link href="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
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
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="javascript:void(0);">电子课程表</a><i class="fa fa-circle"></i></li>
                            <li><span>导入课程表页面</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">导入课程表页面</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                        	<div class="m_margin_0_0_15_0">
                        		<ul class="nav nav-tabs">
                                    <li class="active">
												<a data-toggle="tab" aria-expanded="true">${sessionScope.user.realName}</a>
                                    </li>
                                </ul>
                            </div>
                            
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">课程表导入</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="<%=basePath%>curriculumImport/onUploadCurriculum.do" class="form-horizontal"  method="post" enctype="multipart/form-data" name="form" id="form" >
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">导入</label>
                                                <div class="col-md-4">
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new"> Select file </span>
                                                                <span class="fileinput-exists"> Change </span>
                                                                <input type="file" class="default" name="inputFile" id="inputFile"> </span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                	<a href="<%=basePath%>/templet/curriculum.xls">模板下载</a>
                                                </div>
                                                <div class="col-md-2">
                                                	${errorMsg}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green" onclick="su();">确定</button>
                                                    <button type="button" class="btn default" id="cancel">返回</button>
                                                    <input type="hidden" value="${userId}" name="userId"/>
													<input type="hidden" id="semesterId" name="semesterId" value="${semesterId}"/>
													<input type="hidden" id="clazzId" name="clazzId" value="${clazzId}"/>
													<input type="hidden" id="msg" name="msg" value="${msg}"/>
                                                </div>
                                            </div>
                                        </div>
                                           <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:choose>
									       <c:when test="${roleList.roleCode == 'admin' || roleList.roleCode == 'president' }">
												<input type="hidden" id="userId" name="userId" value="${user.userId}"/>
												<input type="hidden" id="roleCode" name="roleCode" value="${roleList.roleCode}"/>
									       </c:when>
									       <c:otherwise>
									           <input type="hidden" id="userId" name="userId" value=""/>
											   <input type="hidden" id="roleCode" name="roleCode" value=""/>
									       </c:otherwise>
									   </c:choose>
									</c:forEach>
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
		<script src="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
	<script type="text/javascript">

		$(function() {
			loadSubMenu("curriculum"); 
			//选取当前菜单位置
			setActive("curriculum","curriculumManager");
			$('#startDate,#endDate').datetimepicker(/* {
				format:'Y-m-d',
				timepicker:false
			} */);
			var msg = $("#msg").val();
			if(msg == "success")
			{
				//班级Id
				var clazzId = $("#clazzId").val();
				var roleCode = "classLeader";
				standardPost('<%=basePath%>curriculum/toSetCurriculum.do',{clazzId:clazzId,roleCode:roleCode});
			}
			
		});
		//点击返回inputFile
	    $("#cancel").on("click",function(){
			//班级Id
			var userId = $("#userId").val();
			var clazzId = $("#clazzId").val();
			var roleCode = $("#roleCode").val();
			if(userId == null || userId == ''){
				roleCode = "classLeader";
			}
				standardPost('<%=basePath%>curriculum/toSetCurriculum.do',{clazzId:clazzId,roleCode:roleCode});
		});
	   function su(){
			var inputFile =$("#inputFile").val();
			if(inputFile != null && inputFile != '' && inputFile != "undefined"){
				$("#form").submit();
				return true;
			}else{
				layer.msg('请选择课程表！');
				return false;
			}
	   }
	</script>
</html>