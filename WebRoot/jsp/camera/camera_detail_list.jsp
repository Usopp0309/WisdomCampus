<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>摄像头配置查看</title>

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

	<!-- <link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/> -->

	<link href="<%=basePath %>media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<%=basePath %>media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="<%=basePath %>media/css/select2_metro.css" />

	<link rel="stylesheet" href="<%=basePath %>media/css/DT_bootstrap.css" />

	<!-- END PAGE LEVEL STYLES -->
	<link href="<%=basePath %>media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css"/>
	
	<link rel="shortcut icon" href="<%=basePath %>media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed" id="body">

<div class="container-fluid">
	<!-- BEGIN PAGE HEADER-->
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li><i class="icon-home"></i><a href="#">首页</a><i class="icon-angle-right"></i></li>
				<li><a href="#">视频直播</a><i class="icon-angle-right"></i></li>
				<li><a href="#">摄像头配置查看</a></li>
			</ul>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="tab-content">
				<div class="portlet box green">
						<div class="portlet-title">
							<div class="caption">摄像头配置查看</div>
						</div>
						<div class="portlet-body search_box">
							<form action="" class="form-horizontal" method="post">
								<div class="control-group margin-bottom_null">
									<div class="public_search_row">
										<div class="width_20">
											<span>摄像头名称:</span>
											<div class="input_s">
												<select class="public_input_s" id="cameraList" style="">
											    </select>
											</div>
										</div>
										<div class="width_20">
											<button type="button" class="btn green"><i class="fa fa-search"></i>搜索</button>
										</div>
									</div>
								</div>
							</form>
					    </div>
				    </div>
					<div class="portlet-body video_manage">	
						<p>摄像机配置信息</p>
						<div class="portlet-body">
							<table class="table table-bordered table-hover table-full-width" id="sample_1">
								<thead>
									<tr>
										<th>地点名称</th>
										<th>摄像头编码</th>
										<th>摄像头名称</th>
										<th>类型</th>
										<th>开始日期</th>
										<th>结束日期</th>
										<th>使用时间段</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody id="tbody">
									<tr>
										<td>${camera.placeName}</td>
										<td>${camera.cameraCode}</td>
										<c:if test="${camera.cameraName == undefined}">
											<td></td>
										</c:if>
										<c:if test="${camera.cameraName != undefined}">
											<td>${camera.cameraName}</td>
										</c:if>
										<c:if test="${camera.type == 0}">
											<td>公用</td>
										</c:if>
										<c:if test="${camera.type == 1}">
											<td>私用</td>
										</c:if>
										<c:if test="${camera.type == 2}">
											<td>全校</td>
										</c:if>
										<c:if test="${camera.startDay == undefined}">
											<td></td>
										</c:if>
										<c:if test="${camera.startDay != undefined}">
											<td>${camera.startDay}</td>
										</c:if>
										<c:if test="${camera.endDay == undefined}">
											<td></td>
										</c:if>
										<c:if test="${camera.endDay != undefined}">
											<td>${camera.endDay}</td>
										</c:if>
										<td>${camera.startTime}——${camera.endTime}</td>
										<td>${camera.createTime}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<ul class="unstyled inline sidebar-tags" id="userOrClass">
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
							<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>
						</ul>
				
					</div>
					
				</div>
			</div>
		</div>

	</div>
				
	<input type="hidden" id="userId" value="${userId }">
	<input type="hidden" id="roleCode" value="${roleCode}">
	<input type="hidden" id="cameraId" value="${camera.cameraId}">
	<input type="hidden" id="type" value="${camera.type}">
	<script src="<%=basePath %>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="<%=basePath %>media/js/bootstrap.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="<%=basePath %>media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<script src="<%=basePath %>media/js/select2.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.dataTables.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/DT_bootstrap.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/table-advanced.js" type="text/javascript"></script>
	       
	<script src="<%=basePath %>media/js_m/public_js.js" type="text/javascript"></script> 
	
	<script src="<%=basePath %>media/js/TableSorterV2.js" type="text/javascript"></script>  
	
	<script src="<%=basePath %>media/js/app.js" type="text/javascript"></script>
	
	<script src="<%=basePath%>assets/global/plugins/layer/layer.js" type="text/javascript"></script>
	
	<script>

		jQuery(document).ready(function() {    

			App.init();

			$(".tags").on("click",function(){
				$(this).remove();
			})
				
			var userId = $("#userId").val();	
			var roleCode = $("#roleCode").val();	
			loadCameraList(userId,roleCode);	
			loadCameraUserClass($("#cameraId").val(),$("#type").val());	
				
		});

		//加载所有能看的摄像头list
		function loadCameraList(userId,roleCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>camera/getAllCameraListByUserIdRoleCode.do",
				data:{
						userId : userId,
						roleCode : roleCode
					},
				success: function(data){

					var cameraList = eval("(" + data + ")");
					
					var appendHtml = '<option value="0">---请选择---</option>';
					$.each(cameraList, function(n, value) {
						appendHtml += '<option value="' + value.cameraId + '">' + value.cameraCode
						if(value.cameraName != "" && value.cameraName != undefined)
						{
							appendHtml +=  '(' + value.cameraName + ')'
						}
						appendHtml +=  '</option>';
           			});  
					 
           			$("#cameraList").html(appendHtml);
           			var cameraId = $("#cameraId").val();
         			if (cameraId == undefined || cameraId == "" || cameraId == 0)
				    {
					    $("#cameraList").val("0");
				    }
				    else
				    {
					   $("#cameraList").val(cameraId);
				    }
				},
			});
		}
		
		//加载所有能看的摄像头list
		function loadCameraUserClass(cameraId,type)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>camera/getAllCameraListByUserIdRoleCode.do",
				data:{
						cameraId : cameraId
						type : type
					},
				success: function(data){

					var cameraList = eval("(" + data + ")");
					
					var appendHtml = '';
					$.each(cameraList, function(n, value) {
						
						appendHtml += '<li><a class="tags"> 哈哈哈1<i class="icon-remove"></i></a></li>';
           			});  
					 
           			$("#userOrClass").html(appendHtml);
				},
			});
		}
		
	

	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>