<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>学生评价查看</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<meta content="" name="description" />

	<meta content="" name="author" />

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

<!-- END HEAD -->

<!-- BEGIN BODY -->

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
<!-- 				<div class="row-fluid"> -->
					<div class="page-bar m_margin_0_0_0_0">

						<ul class="breadcrumb">
							<li> <i class="icon-home"></i> <a href="#">首页</a> <i class="fa fa-circle"></i> </li>
							<li> <a href="#">教学评价</a> <i class="fa fa-circle"></i> </li>
							<li> <a href="#">学生评价查看</a> </li>
						</ul>

					</div>
<!-- 				</div> -->
<!-- 				<h3 class="page-title">学生评价查看</h3> -->
				
				
				<div class="row">
					
					<div class="portlet-body form-horizontal" id="tab_4" >
						<div class="m_margin_0_0_15_0">
							<ul class="nav nav-tabs" id="userTab">
								<c:forEach items="${sessionScope.user.roleList}" var="roleList">
								     <c:if test="${roleList.roleCode eq 'president' || roleList.roleCode eq 'admin'}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
								     </c:if>
								</c:forEach>																						
							</ul>
						</div>
						

							<div class="tab-pane active" id="tab_4">
								
								<div class="portlet box light-grey">
									 <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">学生查看评价</span>
                                    </div>
                                </div>
										
									<div class="portlet-body">
									
									<div class="form-body">

										<label class="control-label col-md-3">班级查看：</label>

										<div class="form-group">				
											<form action="#" class="form-horizontal" method="post" style="margin: 0px">
												<div class="col-md-9 col-lg-4" >
													<select class="form-control" id="clazzSelect" name="clazzId"> </select>
												</div>
											</form>

										</div>

									</div>
										<div class="form-body">

													<label class="control-label col-md-3">评价查看：</label>

													<div class="form-group">	
													<ul class="templet_list">			
														<c:forEach var="e" items="${EvaluateClazz}" varStatus="status">
														<li>
															<img alt="" src="../media/image_m/disk.png" onclick="showpaper(${e.teachingfolderId})" style="cursor: pointer;">
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
										<div class="form-body">

													<label class="control-label col-md-3">学生评价：</label>

													<div class="form-group">	
													<ul class="templet_list">			
														<c:forEach var="t" items="${teacherevaluateform }" varStatus="start">
															<c:if test="${start.index<10 }">
																<li>
																	<c:if test="${paperid!=0 }">
																		<div>
																			<a href="javascript:void();" onclick="showex(${t.id })"><img src="../media/image_m/teacherTimeTable.png"></a>
																		</div>
																		<p>${t.realName }同学(${t.nums }/${allnums })</p>
																	</c:if>
																</li>
															</c:if>
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
			 <!-- 亦信聊天开始 -->
	    	<%@ include file="/public_module/public_QQ.jsp" %>
	        <!-- 亦信聊天结束 -->
		</div>
		</div>
		</div>
	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script>
<!-- 底部开始 -->
<%@ include file="/public_module/public_footer.jsp" %>
 <!-- 底部结束 -->
</body>

<!-- END BODY -->
  <!-- 公共js开始 -->
  <%@ include file="/public_module/public_js.jsp" %>
  <!-- 公共js结束 -->
<script>

		jQuery(document).ready(function() {    
			loadSubMenu("evaluationManager");
			 setActive("evaluationManager","studentEvaluationViewManager");
// 			App.init();

			//选择第一个tab
			$("#userTab li:first").addClass("active");

			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");

			loadAllClazzList(userId,"studentEvaluationViewManager")
			
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				
			});

			//初始化选择年级，如果select改动则将发送对象改为某个年级的所有学生的信息
			$("#clazzSelect").change(function(){
			
				//用户ID
				var userId = $("ul li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("ul li.active").find('a').attr("attr2");

				var clazzId = $("#clazzSelect").val();
				
				standardPost('<%=basePath%>evaluation/toStudentEvaluationView.do',{clazzId:clazzId});
			});
			
		});
		
		//加载班级级信息
		function loadAllClazzList(userId,permissionCode)
		{
			$.ajax({
				url: "<%=basePath%>baseData/loadClazzList.do",
				data:{
						userId : userId,
						permissionCode : permissionCode
					},
				success : function(data) {
					var clazzList = $.parseJSON(data);

					//班级select页面html
					var clazzSelectHtml = '<option value="0">--请选择--</option>';

					$.each(clazzList, function(n, value) {

						if (n == 0){
							clazzSelectHtml += '<option value="' + value.id + '"selected="selected">' + value.clazzName + '</option>';
						}else{
							clazzSelectHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}
						
					});
					$("#clazzSelect").html(clazzSelectHtml);

					var clazzId = ${clazzId};
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

		function showpaper(paperid)
		{
			standardPost('<%=basePath%>evaluation/toStudentEvaluationView.do',{clazzId:'+${clazzId}+',paperid:paperid});
		}

		function showt(c)
		{
			standardPost('<%=basePath%>evaluation/toStudentEvaluationViewDetail.do',{id:c});
		}

		function showex(exid)
		{
			standardPost('<%=basePath%>evaluation/toStudentEvaluationViewDetail.do',{id:exid});
		}
 </script>

</html>


