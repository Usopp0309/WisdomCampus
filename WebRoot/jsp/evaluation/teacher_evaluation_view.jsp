<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

 <html lang="en"> 

<head>

	<title>教师评价查看</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<meta content="" name="description" />

	<meta content="" name="author" />
	<!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->   
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
	            
<!-- 				<div class="row-fluid"> -->
					<div class="page-bar m_margin_0_0_0_0">
						<ul class="breadcrumb">
							<li> <a href="#">首页</a>  <i class="fa fa-circle"></i> </li>

							<li> <a href="#">教学评价</a> <i class="fa fa-circle"></i> </li>
							
							<li> <a href="#">教师评价查看</a> </li>

						</ul>
					</div>

<!-- 				</div> -->
<!-- 				 <h3 class="page-title">教师评价查看</h3> -->
<!-- 					<div class="col-md-12 col-sm-12"> -->
					<!-- 角色切换 -->
						<div class="row">

							<div class="portlet-body form-horizontal" id="tab_4" >
								
								<div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0">
									<div class="portlet-title">
                             			<div class="caption">
	                                        <i class=" icon-layers font-green"></i>
	                                        <span class="caption-subject font-green sbold uppercase">教师评价查看</span>
                                    	</div>
                        			 </div>
									<div class="portlet-body">
									<div class="form-body">
										<div class="form-group">
													<label class="control-label col-md-3">班级查看：</label>
													<div class="col-md-9 col-lg-4">
														<form action="#" class="form-horizontal" method="post" style="margin: 0px">
															<div class="controls" style="margin-left: 0px">
																<select class="form-control" id="clazzSelect" name="clazzId"> </select>
															</div>
														</form>
													</div>
										 </div>
										 
										 <div class="form-group">

													<label class="control-label col-md-3">选择模板：</label>

													<div class="col-md-9 col-lg-4">
														<ul class="templet_list">
														
														<c:forEach var="e" items="${EvaluateClazz}" varStatus="status">
															<c:if test="${status.index>3&&status.index<5 }"><tr></c:if>
															<li>
																<img alt="" src="../res/styles/menu/disk.png" onclick="showpaper(${e.teachingfolderId})" style="cursor: pointer;">
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
										 
										 <div class="form-group">

													<label class="control-label col-md-3">选择教师：</label>

													<div class="col-md-9 col-lg-4">
														<ul class="templet_list">
														<c:forEach var="t" items="${teacherevaluateform }" varStatus="start">
																<c:if test="${start.index<10 }">
																	<li>
																		<c:if test="${paperid==0 }">
														 					<div>
																				<a href="javascript:void();" onclick="showt(${t.id })"><img src="../res/styles/menu/teacherTimeTable.png"></a>
																			</div>
																				<p>${t.clazzName }${t.subjectName }老师(${t.nums }/${allnums })<p>
																		</c:if>
																		<c:if test="${paperid!=0 }">
																			<div>
																				<a href="javascript:void();" onclick="showex(${t.id })"><img src="../res/styles/menu/teacherTimeTable.png"></a>
																			</div>
																				<p>${t.clazzName}${t.subjectName }老师(${t.nums }/${allnums })</p>
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
<!-- 					</div> -->
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
<!-- END BODY -->
	</body>
	  <!-- 公共js开始 -->
      <%@ include file="/public_module/public_js.jsp" %>
      <!-- 公共js结束 -->
	<script>

		jQuery(document).ready(function() {    

// 			App.init();
			loadSubMenu("evaluationManager");
			 setActive("evaluationManager","teacherEvaluationViewManager");
			//选择第一个tab
			$("#userTab li:first").addClass("active");

			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");

			//初始化班级select
			loadAllClazzList(userId,"teacherEvaluationViewManager");
			
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
				
				standardPost('<%=basePath%>evaluation/toTeacherEvaluationView.do',{clazzId:clazzId});
			});
			$("#back").click(function (){
				history.back() 
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
			standardPost('<%=basePath%>evaluation/toTeacherEvaluationView.do',{clazzId:'+ ${clazzId}+'},{paperid:paperid});
		}

		function showt(c)
		{
			standardPost('<%=basePath%>evaluation/toTeacherEvaluationViewDetail.do',{id:c});
		}

		function showex(exid)
		{
			standardPost('<%=basePath%>evaluation/toTeacherEvaluationViewDetail.do',{id:exid});
		}
 </script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>


</html>