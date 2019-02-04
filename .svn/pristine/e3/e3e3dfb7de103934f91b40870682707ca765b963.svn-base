<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="utf-8" />

<title>评价列表</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<!-- 
<link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color" /> -->
<%@ include file="/public_module/public_css_new.jsp"%>

    
    
     <style>
	        .templet_list{
	            min-height: 200px;
			    border: 1px solid #e6e7eb;
			    padding: 0px;
			    margin: 0px;
			    overflow: hidden; 
	       } 
	</style>
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
	        <!-- 页面内容开始 -->
			<div class="col-md-12 col-sm-12 m_page_con">
			<div class="page-bar m_margin_0_0_0_0">
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="#">首页</a> <i class="icon-angle-right"></i></li>
					<li><a href="#">教学评价</a> <i class="icon-angle-right"></i></li>
					<li><a href="#">评价列表</a></li>
				</ul>
		   </div>
		   
		<div class="row">
			<div class="col-md-12 col-sm-12">

<!-- 			<div class="span12"> -->
<!-- 				<div class="portlet box green"> -->
					<div class="m_margin_0_0_15_0">
							<!-- 动态加载tab页 -->
							<ul class="nav nav-tabs" id="userTab">
								<c:forEach items="${sessionScope.user.roleList}" var="roleList">
								     <c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'president'}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
								     </c:if>
								</c:forEach>																						
							</ul>
						</div>
					<div class="portlet-body form-horizontal" id="tab_4">
							<div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0">
							
								<div class="portlet-title">
                           			<div class="caption">
                                       <i class=" icon-layers font-green"></i>
                                       <span class="caption-subject font-green sbold uppercase">智慧校园评价模板选择</span>
                                  	</div>
	                        	</div>
							
				<div class="portlet-body">
					<div class="form-body">
					<div class="portlet-body evaluate_list">
						<ul class="templet_list">
							<c:forEach var="e" items="${evaluationClazzModelList }" varStatus="status">
								<li align="center">
								    <div class="a1">
										<a href="javascript:void();" onclick="showpaper(${e.teachingfolderId},${e.evaluatetimeId})">
											<img src="../media/image_m/teacherTimeTable.png">
										</a>
									</div>
									<c:if test="${e.semester==1 }">
										 <p>上学期${e.name }</p>
									</c:if>
									<c:if test="${e.semester==2 }">
										<p>下学期${e.name }</p>
									</c:if>
								</li>
							</c:forEach>
						</ul>
						 
					</div>
				</div>
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
	<!-- 底部开始 -->
    <%@ include file="/public_module/public_footer.jsp" %>
    <!-- 底部结束 -->
    <!-- 公共js开始 -->
	<%@ include file="/public_module/public_js.jsp" %>
	<!-- 公共js结束 -->
</body>
<!-- END BODY -->
<script type="text/javascript"> var _gaq = _gaq || []; _gaq.push([ '_setAccount', 'UA-37564768-1' ]); _gaq.push([ '_setDomainName', 'keenthemes.com' ]); _gaq.push([ '_setAllowLinker', true ]); _gaq.push([ '_trackPageview' ]); (function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })();
</script>

	<script>
	jQuery(document).ready(function() {  
// 			App.init(); 
			loadSubMenu("evaluationManager");
			setActive("evaluationManager","evaluationListManager");
			
		});

		function showpaper(teachingfolderId,evaluatetimeId)
		{
			standardPost('<%=basePath%>evaluation/toEvaluationListDetail.do',{paperid:teachingfolderId,timeid:evaluatetimeId});
		}
	</script>
</html>