<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>发送信息</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<meta content="" name="description" />

	<meta content="" name="author" />

	<!-- BEGIN GLOBAL MANDATORY STYLES -->

	<link href="../media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

	<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="../media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="../media/css/select2_metro.css" />

	<link rel="stylesheet" href="../media/css/DT_bootstrap.css" />
	
	<link rel="stylesheet" href="../media/css/news.css" />
	
	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="../media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">


	<!-- BEGIN CONTAINER -->
		<!-- BEGIN PAGE -->

		<div class="page-content">


			<!-- BEGIN PAGE CONTAINER-->        

			<div class="container-fluid">

				<!-- BEGIN PAGE HEADER-->

				<div class="row-fluid">

					<div class="span12">

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<ul class="breadcrumb">

							<li>

								<i class="icon-home"></i>

								<a href="#">首页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li>

								<a href="#">师生信息</a>
								<i class="icon-angle-right"></i>
							</li>
							
							<li>

								<a href="#">学生信息</a>
							</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">

					<div class="span12">
						
						<div class="tabbable tabbable-custom boxless">
							<!-- 动态加载tab页 -->
							<ul class="nav nav-tabs" id="userTab">
								<c:forEach items="${sessionScope.user}" var="user">
									<c:if test="${user.roleId == 1 || user.roleId == 2 || user.roleId == 3}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${user.id}" attr2="${user.roleId}">${user.name}(${user.roleName})
											</a>
										</li>
									</c:if>
								</c:forEach>																						
							</ul>
						
							<div class="tab-content">
								
								<div class="tab-pane active" id="tab_4">

									<div class="portlet box blue">
			
										<div class="portlet-title">
											<div class="caption"><i class="icon-user"></i>学生信息</div>

										</div>
										
										<div class="portlet-body form">
											
											<form action="#" class="form-horizontal">
												
												<!-- select 开始 -->
												<div class="row-fluid">

													<div class="span4">

														<div class="control-group">

															<label class="control-label">学校:</label>

																<div class="controls">
			
																	<select class="medium m-wrap" tabindex="1" id="schoolSelect">
																	
																	</select>
			
																</div>

														</div>

													</div>

													<!--/span-->

													<div class="span4">

														<div class="control-group">

															<label class="control-label">年级:</label>

																<div class="controls">
			
																	<select class="medium m-wrap" tabindex="1" id="gradeSelect">
																	
																		<option value="0">--请选择--</option>
			
																	</select>
			
																</div>

														</div>

													</div>
													
													<div class="span4">

														<div class="control-group">

															<label class="control-label">班级:</label>

																<div class="controls">
			
																	<select class="medium m-wrap" tabindex="1" id="clazzSelect">
																	
																		<option value="0">--请选择--</option>
			
																	</select>
			
																</div>

														</div>

													</div>
													
													
													<!--/span-->

												</div>
												
												<!-- select 结束 -->
												
												<!-- 学校开始 -->
												<div class="row-fluid" id="schoolRow">
													
												</div>

												
												<!-- 学校结束 -->
												
												<!-- 年级开始 -->
												
												<div class="row-fluid" id="gradeRow" style="display:none;">
												
												</div>
												
												<!-- 年级结束 -->
												
												<!-- 班级开始 -->
												
												<div class="row-fluid" id="clazzRow" style="display: none;">
													
												</div>
												
												<!-- 班级结束 -->
												
												<!-- 教师开始 -->
												
												<div class="row-fluid" id="studentRow" style="display: none;">

													
												
													<div class="span3">
						
														<div class="news-blocks">
						
															<h3><a href="page_news_item.html">Google Glass Technology..</a></h3>
						
															<div class="news-block-tags">
						
																<strong>LA, USA</strong>
						
																<em>2 hours ago</em>
						
															</div>
						
															<p><img class="news-block-img pull-right" src="media/image/image5.jpg" alt="">At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident</p>
						
															<a href="page_news_item.html" class="news-block-btn">
						
															Read more
						
															<i class="m-icon-swapright m-icon-black"></i>                              
						
															</a>
						
														</div>
						
						
													</div>
													
													<div class="span3">
						
														<div class="news-blocks">
						
															<h3><a href="page_news_item.html">Google Glass Technology..</a></h3>
						
															<div class="news-block-tags">
						
																<strong>LA, USA</strong>
						
																<em>2 hours ago</em>
						
															</div>
						
															<p><img class="news-block-img pull-right" src="media/image/image5.jpg" alt="">At vero </p>
						
															<a href="page_news_item.html" class="news-block-btn">
						
															Read more
						
															<i class="m-icon-swapright m-icon-black"></i>                              
						
															</a>
						
														</div>
						
						
													</div>
												
												</div>
												<!-- 教师结束 -->
												
											</form>	
											
										</div>
										
										
									</div>
								</div>
								
							</div>
						</div>
					</div>

				</div>

				<!-- END PAGE CONTENT-->

			</div>

	<!-- END CONTAINER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->
	<script src="../media/js/jquery-2.1.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="../media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="../media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>

	<script src="media/js/excanvas.min.js"></script>

	<script src="media/js/respond.min.js"></script>  

	<![endif]-->                    

	<script src="../media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript" src="../media/js/select2.min.js"></script>

	<script type="text/javascript" src="../media/js/jquery.dataTables.min.js"></script>

	<script type="text/javascript" src="../media/js/DT_bootstrap.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->


	<script src="../media/js/table-advanced.js"></script>       
	<script src="../media/js/app.js"></script>

	<script>

		jQuery(document).ready(function() {    

			App.init();

			//初始化加载学校列表
			loadSchoolList();

			//进入学校选年级
			//两个入口 : 1.学校select; 2.点击学校row
			//入口1
			$("#schoolSelect").change(function(){
				var schoolId = $(this).val();

				//如果是--请选择--,加载全部学校,其他则加载年级信息
				if (schoolId == 0)
				{
					loadSchoolList();
					//初始化年级select和班级select
					initGradeSelect();
					initClazzSelect();
				}
				else
				{
					loadGradeList(schoolId);
				}
			});

			//入口2

			//进入年级选班级
			//两个入口 : 1.年级select; 2.点击年级row
			$("#gradeSelect").change(function(){
				//先选择学校
				var schoolId = $("#schoolSelect").val();
				if (schoolId == 0)
				{
					alert("请先选择学校!");
				}
				
				var gradeId = $(this).val();

				//如果是--请选择--,加载全部年级，其他则加载班级信息
				if (gradeId == 0)
				{
					loadGradeList(schoolId);
					//初始化班级select
					initClazzSelect();
				}
				else
				{
					loadClazzList(gradeId);
				}
				
			});

			//进入班级选学生
			//两个入口: 1.班级select; 2.点击班级row
			$("#clazzSelect").change(function(){
				//先选择年级
				var gradeId = $("#gradeSelect").val();
				if (gradeId == 0)
				{
					alert("请先选择年级!");
				}
				
				var clazzId = $(this).val();

				//如果是--请选择--,加载全部班级，其他则加载学生信息
				if (clazzId == 0)
				{
					loadClazzList(gradeId);
				}
				else
				{
					loadStudentList(clazzId);
				}
				
			});
						
		});

		//进入学校选年级入口2
		function schoolSelect(schoolId)
		{
			loadGradeList(schoolId);
			//设置schoolSelect的值
			$("#schoolSelect").val(schoolId);
		}

		//进入年级选班级入口2
		function gradeSelect(gradeId)
		{
			loadClazzList(gradeId);
			//设置gradeSelect的值
			$("#gradeSelect").val(gradeId);
		}

		//进入班级选学生入口2
		function clazzSelect(clazzId)
		{
			loadStudentList(clazzId);
			//设置clazzSelect的值
			$("#clazzSelect").val(clazzId);
		}

		//初始化年级select
		function initGradeSelect()
		{
			$("#gradeSelect").html('<option value="0">--请选择--</option>');
		}

		//初始化班级select
		function initClazzSelect()
		{
			$("#clazzSelect").html('<option value="0">--请选择--</option>');
		}
		
		//加载学校信息
		function loadSchoolList()
		{
			var rowCount = 0;
			$.ajax({
				type: "post",
				url: "<%=basePath%>school/selectAllSchoolList.do",
				success: function(data){
					var schoolList = eval("(" + data + ")");

					//学校select页面html
					var schoolSelectHtml = '<option value="0">--请选择--</option>';
						
					//学校row页面html
					var schoolRowHtml = '<div class="row-fluid">';
					$.each(schoolList, function(n, value) {  
						//select页面
						schoolSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';

						//row页面
						//解决row-fluid问题,row-fluid默认12栅，span3可以容纳4个，但是如果在里面放入的数量大于4个，
						//因为span元素有个margin-left,第二排会放不下四个，以此类推，会出现样式乱掉的问题
						//row页面
						schoolRowHtml += '<a class="icon-btn span3" onclick="schoolSelect(' + value.id + ')">';
						schoolRowHtml += '<i class="icon-home"><i></i></i>';
						schoolRowHtml += '<div>' + value.name + '</div>';
						schoolRowHtml += '</a>';
						rowCount ++;

						if (rowCount == 4)
						{
							schoolRowHtml += '</div>'
							schoolRowHtml += '<div class="row-fluid">';
							rowCount = 0;
						}
	          		});

	          		if (rowCount != 0)
		          	{
						schoolRowHtml += '</div>';
		          	}
					
          			$("#schoolSelect").html(schoolSelectHtml);
          			$("#schoolRow").html(schoolRowHtml);

          			//显示学校
					$("#schoolRow").show();
          			//隐藏年级
          			$("#gradeRow").hide();
          			//隐藏班级
          			$("#clazzRow").hide();
          			//隐藏学生
          			$("#studentRow").hide();          			
				},
			});
		}

		//加载年级信息
		function loadGradeList(schoolId)
		{
			var rowCount = 0;
			$.ajax({
				type: "post",
				url: "<%=basePath%>grade/selectGradeListBySchoolId.do",
				data:{
					schoolId : schoolId,
				},
				success: function(data){
					var gradeList = eval("(" + data + ")");

					//年级select页面html
					var gradeSelectHtml = '<option value="0">--请选择--</option>';

					//年级row页面html
					var gradeRowHtml = '<div class="row-fluid">';
					
					$.each(gradeList, function(n, value) {  
						//select页面
						gradeSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';

						//row页面
						gradeRowHtml += '<a class="icon-btn span3" onclick="gradeSelect(' + value.id + ')">';
						gradeRowHtml += '<i class="icon-sitemap"><i></i></i>';
						gradeRowHtml += '<div>' + value.name + '</div>';
						gradeRowHtml += '</a>';
						rowCount ++;

						if (rowCount == 4)
						{
							gradeRowHtml += '</div>'
							gradeRowHtml += '<div class="row-fluid">';
							rowCount = 0;
						}
	          		});

					if (rowCount != 0)
		          	{
						gradeRowHtml += '</div>';
		          	}

          			$("#gradeSelect").html(gradeSelectHtml);
          			$("#gradeRow").html(gradeRowHtml);
          			
					//显示年级
					$("#gradeRow").show();
          			//隐藏学校
          			$("#schoolRow").hide();
          			//隐藏班级
          			$("#clazzRow").hide();
          			//隐藏学生
          			$("#studentRow").hide();
				},
			});
		} 

		//加载班级信息
		function loadClazzList(gradeId)
		{
			var rowCount = 0;
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazz/selectClazzListByGradeId.do",
				data:{
					gradeId : gradeId,
				},
				success: function(data){
					var clazzList = eval("(" + data + ")");

					//年级select页面html
					var clazzSelectHtml = '<option value="0">--请选择--</option>';

					//年级row页面html
					var clazzRowHtml = '<div class="row-fluid">';
					
					$.each(clazzList, function(n, value) {  
						//select页面
						clazzSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';

						//row页面
						clazzRowHtml += '<a class="icon-btn span3" onclick="clazzSelect(' + value.id + ')">';
						clazzRowHtml += '<i class="icon-group"><i></i></i>';
						clazzRowHtml += '<div>' + value.name + '</div>';
						clazzRowHtml += '</a>';
						rowCount ++;

						if (rowCount == 4)
						{
							clazzRowHtml += '</div>'
							clazzRowHtml += '<div class="row-fluid">';
							rowCount = 0;
						}
	          		});

					if (rowCount != 0)
		          	{
						clazzRowHtml += '</div>';
		          	}

          			$("#clazzSelect").html(clazzSelectHtml);
          			$("#clazzRow").html(clazzRowHtml);
          			
          			//显示班级
          			$("#clazzRow").show();
          			//隐藏学校
          			$("#schoolRow").hide();
          			//隐藏年级
					$("#gradeRow").hide();
					//隐藏学生
          			$("#studentRow").hide();
				},
			});
		}

		//加载学生信息
		function loadStudentList(clazzId)
		{
			var rowCount = 0;
			$.ajax({
				type: "post",
				url: "<%=basePath%>student/selectStudentListByClazzId.do",
				data:{
					clazzId : clazzId
				},
				success: function(data){
					var studentList = eval("(" + data + ")");

					//学生row页面html
					var studentRowHtml = '<div class="row-fluid">';
					
					$.each(studentList, function(n, value) { 

						//row页面
						studentRowHtml += '<div class="span3">';
						studentRowHtml += '<div class="news-blocks">';
						studentRowHtml += '<h3><a href="#" onclick = "toDetail(' + value.id+ '  )">' + value.name + '</a></h3>';
						studentRowHtml += '<div class="news-block-tags">';
						studentRowHtml += '<strong>创建时间:</strong>';
						studentRowHtml += '<em>' + value.createTime + '</em>';
						studentRowHtml += '</div>';
						studentRowHtml += '<p><img class="news-block-img pull-right" src="media/image/image5.jpg" alt="">手机号:'+ value.username +'</p>';
						studentRowHtml += '<a class="news-block-btn" onclick = "toDetail(' + value.id+ '  )">';
						studentRowHtml += '查看详情';
						studentRowHtml += '<i class="m-icon-swapright m-icon-black"></i>';
						studentRowHtml += '</a>';
						studentRowHtml += '</div>';
						studentRowHtml += '</div>';

						
						rowCount ++;

						if (rowCount == 4)
						{
							studentRowHtml += '</div>'
							studentRowHtml += '<div class="row-fluid">';
							rowCount = 0;
						}
	          		});

					if (rowCount != 0)
		          	{
						studentRowHtml += '</div>';
		          	}

          			$("#studentRow").html(studentRowHtml);

          			//显示学生
          			$("#studentRow").show();
          			//隐藏班级
          			$("#clazzRow").hide();
          			//隐藏学校
          			$("#schoolRow").hide();
          			//隐藏年级
					$("#gradeRow").hide();
				},
			});
			
		}
		
		
		function toDetail(id)
		{
			standardPost('<%=basePath%>student/toStudentDetailView.do',{id:id});
		}
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>