<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>菜谱修改</title>

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

	<!-- <link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/> -->

	<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="../media/css/bootstrap-fileupload.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/jquery.gritter.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/chosen.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/select2_metro.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/jquery.tagsinput.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/clockface.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/bootstrap-wysihtml5.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/datepicker.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/timepicker.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/colorpicker.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/bootstrap-toggle-buttons.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/daterangepicker.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/datetimepicker.css" />

	<link rel="stylesheet" type="text/css" href="../media/css/multi-select-metro.css" />

	<link href="../media/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>
	
	<link rel="stylesheet" href="../media/js_m/datetimepicker/jquery.datetimepicker.css" />
	<link href="../media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">
       

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
								<a href="#">菜谱管理</a>
								<i class="icon-angle-right"></i>
							</li>
							
							<li>
								<a href="#">修改菜谱</a>
							</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->
				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">

					<div class="span12">

						<!-- BEGIN EXAMPLE TABLE PORTLET-->

						<div class="portlet box green">

							<div class="portlet-title">

								<div class="caption">修改菜谱</div>
							</div>
							
							<div class="portlet-body form">
								<form action="<%=basePath %>recipe/doModifyRecipe.do" class="form-horizontal" method="post" id="submitForm" enctype="multipart/form-data">

									<div class="row-fluid">

										<div class="span4 ">

											<div class="control-group">

												<label for="firstName" class="control-label">日期</label>

												<div class="controls input_s">
													<input name="recipeId" type="text"  class="m-wrap span6 public_input_s" style="display:none;" value="${recipe.id}" >
													<input type="text" size="16" placeholder="开始时间" name="pushDate" id="pushDate"  class="m-wrap span6 public_input_s" value="${recipe.pushDate}" disabled="disabled"/>
												</div>
											</div>

										</div>

										<!--/span-->

									</div>
									<c:forEach items="${recipe.breakfastList}" var="dish"  varStatus="status">
										<div class="row-fluid">
											<div class="span2 ">
	
												<div class="control-group">
												
													<c:if test="">
														
													</c:if> 
													<c:choose>
														<c:when test="${dish.picName ne '' && dish.picName ne null }">
															<img  src="<%=Cons.IMGBASEPATH%>${dish.picPath}" width="200" height="150">
														</c:when>
														<c:otherwise>
															<img src="<%=basePath %>media/image_m/pc_null.png">
														</c:otherwise>
													</c:choose>
												</div>
	
											</div>
											<div class="span3 ">
	
												<div class="control-group">
												
													    <label for="firstName" class="control-label">早餐</label>
												   		<div class="controls">
												   			<input name="breakfast_id${status.count}" type="text"  class="m-wrap span6" style="display:none;" value="${dish.id}" >
															<input name="breakfast${status.count}" id="breakfast${status.count}" type="text"  class="m-wrap span6" value="${dish.dishName}" >
														</div>

												</div>
	
											</div>
											<div class="span2 ">
	
												<div class="control-group">
												
														<span>点赞次数：${dish.praiseCount}</span>
	
												</div>
	
											</div>
											<!--/span-->
	
											<div class="span3 ">
	
												<div class="control-group">

															<label for="lastName" class="control-label">早餐照片</label>
			
															<div class="controls">
			
																<div class="fileupload fileupload-new" data-provides="fileupload">
			
																	<div class="input-append">
					
																		<div class="uneditable-input">
					
																			<i class="icon-file fileupload-exists"></i> 
					
																			<span class="fileupload-preview"></span>
					
																		</div>
					
																		<span class="btn btn-file">
					
																		<span class="fileupload-new">上传</span>
					
																		<span class="fileupload-exists">修改</span>
					
																		<input type="file" class="default"  name="breakfastPic${status.count}" value="test.png"/>
					
																		</span>
					
																		<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">移除</a>
					
																	</div>

																</div>
			
																<span class="help-block">800X600像素</span>
			
															</div>

												</div>
	
											</div>
	
											
										</div>									
									</c:forEach>
									<c:forEach items="${recipe.lunchList}" var="dish"  varStatus="status">
										<div class="row-fluid">
											<div class="span2 ">
	
												<div class="control-group">
												
													<c:choose>
														<c:when test="${dish.picName ne '' && dish.picName ne null }">
															<img  src="<%=Cons.IMGBASEPATH%>${dish.picPath}" width="200" height="150">
														</c:when>
														<c:otherwise>
															<img src="<%=basePath %>media/image_m/pc_null.png">
														</c:otherwise>
													</c:choose>
												
													
	
												</div>
	
											</div>
											<div class="span3 ">
	
												<div class="control-group">
												
													    <label for="firstName" class="control-label">午餐</label>
												   		<div class="controls">
												   			<input name="lunch_id${status.count}" type="text"  class="m-wrap span6" style="display:none;" value="${dish.id}" >
															<input name="lunch${status.count}" id="lunch${status.count}" type="text"  class="m-wrap span6" value="${dish.dishName}" >
														</div>

												</div>
	
											</div>
											<div class="span2 ">
	
												<div class="control-group">
												
														<span>点赞次数：${dish.praiseCount}</span>
	
												</div>
	
											</div>
											<!--/span-->
	
											<div class="span3 ">
	
												<div class="control-group">

															<label for="lastName" class="control-label">午餐照片</label>
			
															<div class="controls">
			
																<div class="fileupload fileupload-new" data-provides="fileupload">
			
																	<div class="input-append">
					
																		<div class="uneditable-input">
					
																			<i class="icon-file fileupload-exists"></i> 
					
																			<span class="fileupload-preview"></span>
					
																		</div>
					
																		<span class="btn btn-file">
					
																		<span class="fileupload-new">上传</span>
					
																		<span class="fileupload-exists">修改</span>
					
																		<input type="file" class="default"  name="lunchPic${status.count}"/>
					
																		</span>
					
																		<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">移除</a>
					
																	</div>

																</div>
			
																<span class="help-block">800X600像素</span>
			
															</div>

												</div>
	
											</div>
	
											
										</div>									
									</c:forEach>
									<c:forEach items="${recipe.snackList}" var="dish"  varStatus="status">
										<div class="row-fluid">
											<div class="span2 ">
	
												<div class="control-group">
													<c:choose>
														<c:when test="${dish.picName ne '' && dish.picName ne null }">
															<img  src="<%=Cons.IMGBASEPATH%>${dish.picPath}" width="200" height="150">
														</c:when>
														<c:otherwise>
															<img src="<%=basePath %>media/image_m/pc_null.png">
														</c:otherwise>
													</c:choose>
	
												</div>
	
											</div>
											<div class="span3 ">
	
												<div class="control-group">
												
													    <label for="firstName" class="control-label">下午茶</label>
												   		<div class="controls">
												   			<input name="snack_id${status.count}" type="text"  class="m-wrap span6" style="display:none;" value="${dish.id}" >
															<input name="snack${status.count}" id="snack${status.count}" type="text"  class="m-wrap span6" value="${dish.dishName}" >
														</div>

												</div>
	
											</div>
											<div class="span2 ">
	
												<div class="control-group">
												
														<span>点赞次数：${dish.praiseCount}</span>
	
												</div>
	
											</div>
	
											<div class="span3 ">
	
												<div class="control-group">

															<label for="lastName" class="control-label">下午茶照片</label>
			
															<div class="controls">
			
																<div class="fileupload fileupload-new" data-provides="fileupload">
			
																	<div class="input-append">
					
																		<div class="uneditable-input">
					
																			<i class="icon-file fileupload-exists"></i> 
					
																			<span class="fileupload-preview"></span>
					
																		</div>
					
																		<span class="btn btn-file">
					
																		<span class="fileupload-new">上传</span>
					
																		<span class="fileupload-exists">修改</span>
					
																		<input type="file" class="default"  name="snackPic${status.count}"/>
					
																		</span>
					
																		<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">移除</a>
					
																	</div>

																</div>
			
																<span class="help-block">800X600像素</span>
			
															</div>

												</div>
	
											</div>
	
											
										</div>									
									</c:forEach>
									<c:forEach items="${recipe.otherList}" var="dish"  varStatus="status">
										<div class="row-fluid">
										<div class="span2">
	
												<div class="control-group">
												
													
													<c:choose>
														<c:when test="${dish.picName ne '' && dish.picName ne null }">
															<img  src="<%=Cons.IMGBASEPATH%>${dish.picPath}" width="200" height="150">
														</c:when>
														<c:otherwise>
															<img src="<%=basePath %>media/image_m/pc_null.png">
														</c:otherwise>
													</c:choose>
												</div>
	
											</div>
											<div class="span3 ">
	
												<div class="control-group">
												
													    <label for="firstName" class="control-label">其他</label>
												   		<div class="controls">
												   			<input name="other_id${status.count}" type="text"  class="m-wrap span6" style="display:none;" value="${dish.id}" >
															<input name="other${status.count}" id="other${status.count}" type="text"  class="m-wrap span6" value="${dish.dishName}" >
														</div>

												</div>
	
											</div>
											<div class="span2 ">
	
												<div class="control-group">
												
														<span>点赞次数：${dish.praiseCount}</span>
	
												</div>
	
											</div>
											<!--/span-->
	
											<div class="span3 ">
	
												<div class="control-group">

															<label for="lastName" class="control-label">其他照片</label>
			
															<div class="controls">
			
																<div class="fileupload fileupload-new" data-provides="fileupload">
			
																	<div class="input-append">
					
																		<div class="uneditable-input">
					
																			<i class="icon-file fileupload-exists"></i> 
					
																			<span class="fileupload-preview"></span>
					
																		</div>
					
																		<span class="btn btn-file">
					
																		<span class="fileupload-new">上传</span>
					
																		<span class="fileupload-exists">修改</span>
					
																		<input type="file" class="default"  name="otherPic${status.count}"/>
					
																		</span>
					
																		<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">移除</a>
					
																	</div>

																</div>
			
																<span class="help-block">800X600像素</span>
			
															</div>

												</div>
	
											</div>
	
											
										</div>									
									</c:forEach>
									<div class="form-actions">

												<c:if test="${sessionScope.user.type != 2}">
												<button class="btn green" id="submitButton" type="submit" ><i class="icon-ok"></i> 保存</button>
												</c:if>
												<button type="button" class="btn" id="cancel">返回</button>
									</div>
									
								</form>
							</div>
						</div>

						<!-- END EXAMPLE TABLE PORTLET-->

					</div>
					
				</div>
				<!-- END PAGE CONTENT-->
				
				
				
			</div>


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
	
	<script type="text/javascript" src="../media/js/jquery.validate.min.js"></script>
	
	<script type="text/javascript" src="../media/js/My97DatePicker/WdatePicker.js"></script>       
	<script type="text/javascript" src="../media/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="../media/js_m/public_js.js"></script>
	<script type="text/javascript" src="../media/js_m/datetimepicker/jquery.datetimepicker.js"></script>  
	<script src="../media/js/app.js"></script>
	<script type="text/javascript">
	$(function(){
		$('#pushDate').datetimepicker({
			format:'Y-m-d',
			timepicker:false
		});
		$("#submitForm").validate();
		$('#pushDate').rules('add', {
			required : true,
			messages : {
				required : '食谱日期不能为空！',
			},
		});
		$('#breakfast1').rules('add', {
			required : true,
			messages : {
				required : '早餐名称不能为空！',
			},
		});
		$('#lunch1').rules('add', {
			required : true,
			messages : {
				required : '午餐名称不能为空！',
			},
		});
	})
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>