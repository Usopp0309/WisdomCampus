<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>营养食谱</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<meta content="" name="description" />

	<meta content="" name="author" />

	<!-- BEGIN GLOBAL MANDATORY STYLES -->

	<link href="<%=basePath %>media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath %>media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath %>media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath %>media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath %>media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath %>media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<!-- <link href="<%=basePath %>media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/> -->

	<link href="<%=basePath %>media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<%=basePath %>media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="<%=basePath %>media/css/select2_metro.css" />

	<link rel="stylesheet" href="<%=basePath %>media/css/DT_bootstrap.css" />
	
	<!-- END PAGE LEVEL STYLES -->
	<link href="<%=basePath %>media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
	<link rel="stylesheet" href="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.css" />
	<link rel="shortcut icon" href="<%=basePath %>media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed" id="body">

     

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

								<a href="#">营养食谱</a>
								<i class="icon-angle-right"></i>
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
								<c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
									</c:if>
								</c:forEach>																						
							</ul>
						
							<div class="tab-content padding_0">
								
								<div class="tab-pane active" id="tab_4">

									<div class="portlet box green">
			
										<div class="portlet-title">
											
											<div class="caption"></i>营养食谱</div>
											
											<div class="tools">

												<a href="javascript:;" class="collapse"></a>

											</div>
											
										</div>
								
										<div class="portlet-body search_box">
											
											<!-- 查询表单begin -->
											<form action="<%=basePath%>check/loadTeacherCheckList.do" class="form-horizontal" method="post" style="margin: 0px">
												<div class="control-group margin-bottom_null">
													<div class="public_search_row">
														<div class="width_20">
														
														<span>选择班级:</span>
			
														<div class="input_s">
			
															<select class="public_input_s" id="departmentSelect" name="gradeId">
					
															</select>
														</div>
														
													</div>
														<div class="width_20">
															
														    	<span>选择时间:</span>
					
																<div class="input_s">
																	<input type="text" size="16" placeholder="开始时间" name="startTime" id="startTime"  class="public_input_s"/>
																	
																</div>
														</div>
														<div class="width_20">
															
														    	<span>搜索内容:</span>
					
																<div class="input_s">
																
																	<input type="text" placeholder="姓名、工号..." class="public_input_s" id="queryContent"/>
											
																</div>
														</div>
													</div>
													
													
													<div class="public_search_row">
													
														<button type="button" class="btn green f_right" id="search"><i class="fa fa-search"></i>查找</button>
													</div>
													</div>
												
											</form>
											
											<!-- 查询表单end -->
			
										</div>
										
									</div>
									<div class="row-fluid">
									<div class="span9 food_list"style="margin:0px auto;float:none;">
									<h2>每周营养食谱<a href="#static" data-toggle="modal">食物喜爱排名</a></h2>
									
									<div data-keyboard="false" data-backdrop="static" tabindex="-1" class="modal hide fade" id="static">
									<div class="modal-header">喜欢食物排名</div>
									<div class="modal-body">

										<div class="tabbable tabbable-custom">

											<ul class="nav nav-tabs">

												<li class="active"><a data-toggle="tab" href="#tab_1_1">早餐</a></li>

												<li><a data-toggle="tab" href="#tab_1_2">午餐</a></li>

												<li><a data-toggle="tab" href="#tab_1_3">加餐</a></li>

											</ul>

											<div class="tab-content">

												<div id="tab_1_1" class="tab-pane active">

													<div class="food_detail">
														<span class="num"><b class="num1">1</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
														<span class="num"><b class="num2">2</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
													<span class="num"><b class="num3">3</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
														<span class="num">1</span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>

												</div>

												<div id="tab_1_2" class="tab-pane">

													<div class="food_detail">
														<span class="num"><b class="num1">1</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
														<span class="num"><b class="num2">2</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
													<span class="num"><b class="num3">3</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
														<span class="num">1</span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>

												</div>

												<div id="tab_1_3" class="tab-pane">

													<div class="food_detail">
														<span class="num"><b class="num1">1</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
														<span class="num"><b class="num2">2</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
													<span class="num"><b class="num3">3</b></span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>
													<div class="food_detail">
														<span class="num">1</span>
														<span class="name">鱼香肉丝<em class="no1"></em></span>
														<span class="img"><img src=""></span>
														<span class="good"><i class="icon-thumbs-up">45</i></span>
													</div>

												</div>

											</div>

										</div>

									</div>

									<div class="modal-footer">

										<button class="btn" data-dismiss="modal" type="button">关闭</button>

										

									</div>

								</div>
									
									<table class="table table-bordered table-full-width" id="sample_1">
			
										<thead>
	
											<tr>
											
												<th></th>
	
												<th>早餐</th>
	
												<th>午餐</th>
															
												<th>加餐</th>
												
											</tr>
						
										</thead>
										<tbody id="tbody">
										<tr>
											
												<td>星期一</td>
	
												<td>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
	
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
															
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
												
											</tr>
											<tr>
											
												<td>星期二</td>
	
												<td>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
	
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
															
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
												
											</tr>
											<tr>
											
												<td>星期三</td>
	
												<td>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
	
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
															
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
												
											</tr>
											<tr>
											
												<td>星期四</td>
	
												<td>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
	
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
															
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
												
											</tr>
											<tr>
											
												<td>星期五</td>
	
												<td>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
	
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
															
												<td>
													<div class="food">
														<img src="">
													<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
													<div class="food">
														<img src="">
														<p><span>饼干</span><i class="icon-thumbs-up"></i></p>
													</div>
												</td>
												
											</tr>
										</tbody>
										
									</table></div>
									</div>
									
									
									
								</div>
								
							</div>
						</div>
					</div>

				</div>

				<!-- END PAGE CONTENT-->

			</div>

	<!-- END CONTAINER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, tdis will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->
	<script src="<%=basePath %>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="<%=basePath %>media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="<%=basePath %>media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>

	<script src="<%=basePath %>media/js/excanvas.min.js"></script>

	<script src="<%=basePath %>media/js/respond.min.js"></script>  

	<![endif]-->                    

	<script src="<%=basePath %>media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="<%=basePath %>media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript" src="<%=basePath %>media/js/select2.min.js"></script>

	<script type="text/javascript" src="<%=basePath %>media/js/jquery.dataTables.min.js"></script>

	<script type="text/javascript" src="<%=basePath %>media/js/DT_bootstrap.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->


	<script src="<%=basePath %>media/js/table-advanced.js"></script>  
	<script type="text/javascript" src="<%=basePath %>media/js/My97DatePicker/WdatePicker.js"></script>  
	<script type="text/javascript" src="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=basePath %>media/js_m/public_js.js"></script> 
	<script src="<%=basePath %>media/js/TableSorterV2.js"></script> 
	<script src="<%=basePath %>media/js/app.js"></script>
	<script>
		$(function(){
			$('#startTime').datetimepicker({format:'Y-m-d',timepicker:false});
			App.init();
			$("#tbody tr:eq('0')").css({"background-color":"#e4f6de"});
			$("#tbody tr:eq('1')").css({"background-color":"#dbefee"});
			$("#tbody tr:eq('2')").css({"background-color":"#eae6f5"});
			$("#tbody tr:eq('3')").css({"background-color":"#fbdfed"});
			$("#tbody tr:eq('4')").css({"background-color":"#fcf3e2"});
			$("#tbody tr:eq(0) td:eq(0)").css({"background-color":"#fff","color":"#8ac66c"});
			$("#tbody tr:eq(1) td:eq(0)").css({"background-color":"#fff","color":"#62bbb7"});
			$("#tbody tr:eq(2) td:eq(0)").css({"background-color":"#fff","color":"#a69ac8"});
			$("#tbody tr:eq(3) td:eq(0)").css({"background-color":"#fff","color":"#c4437c"});
			$("#tbody tr:eq(4) td:eq(0)").css({"background-color":"#fff","color":"#f2bf4c"});
			$(".table th:eq(1)").css({"color":"#62bbb5"});
			$(".table th:eq(2)").css({"color":"#f4bc4b"});
			$(".table th:eq(3)").css({"color":"#8ac66c"});
			$(".food i").on("click",function(){
				if($(this).attr("style")){
					$(this).removeAttr("style");
				}else{
					$(this).css({"color":"#f5bc4b"})
				}
				})
			$(".icon-thumbs-up").on("click",function(){
				var text_v=parseInt($(this).text())+1;
					$(this).text(text_v);
				})
			})
		

		
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>