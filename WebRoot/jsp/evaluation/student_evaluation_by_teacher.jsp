<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="utf-8" />

<title>已评或未评教师</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<link href="../media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<link href="../media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="../media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<link href="../media/css/style-metro.css" rel="stylesheet" type="text/css" />

<link href="../media/css/style.css" rel="stylesheet" type="text/css" />

<link href="../media/css/style-responsive.css" rel="stylesheet" type="text/css" />

<!-- <link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color" /> -->

<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css" />

<link rel="shortcut icon" href="../media/image/favicon.ico" />

<link rel="stylesheet" type="text/css" href="../res/styles/opendiv.css" />
<link href="../media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
		
</head>

<body class="page-header-fixed">

		<div class="container-fluid">

			<div class="row-fluid">

				<div class="span12">

					<ul class="breadcrumb">

						<li><i class="icon-home"></i> <a href="#">首页</a> <i class="icon-angle-right"></i></li>

						<li><a href="#">教学评价</a> <i class="icon-angle-right"></i></li>

						<li><a href="#">已评或未评学生</a></li>

					</ul>

				</div>

			</div>

			<div class="row-fluid">

				<div class="span12">

					<div class="portlet box green">

						<div class="portlet-title">

							<div class="caption">已评或未评学生</div>

						</div>

						<div class="portlet-body evaluate">
							<h1>查看老师评价情况</h1>
							<ul>
								<c:forEach var="t" items="${tlist }" varStatus="start">	
									<li>
										<p>${t.realName }老师</p>
										<span>已评论过</span>
									</li>
								</c:forEach>
							</ul>
							
					   </div>
						
					</div>

				</div>

			</div>

		</div>
	
	
	<script src="../media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>

	<script src="../media/js/bootstrap.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script>
	
	<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.uniform.min.js" type="text/javascript"></script>

	<script type="text/javascript" src="../media/js/select2.min.js"></script>

	<script type="text/javascript" src="../media/js/jquery.dataTables.min.js"></script>

	<script type="text/javascript" src="../media/js/DT_bootstrap.js"></script>


	<script src="../media/js/table-advanced.js"></script>

	<script type="text/javascript" src="../media/js/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript" src="../res/scripts/jquery/jquery-1.3.2.min.js"></script>
	
    <script type="text/javascript" src="../res/scripts/jquery/jquery-ui-1.7.2.custom.min.js"></script>
    
	<script type="text/javascript" src="../res/scripts/jquery/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="../res/scripts/jquery/jquery.form.js"></script>
	
	<script type="text/javascript" src="../res/scripts/opendiv.js"></script>
	
	<script type="text/javascript" src="../res/scripts/jquery/jquery.min.js"></script>
	
	<script type="text/javascript" src="../res/scripts/jquery/jquery.gvChart-0.1.min.js"></script>
	
	<script src="../res/scripts/highcharts.js"></script>

	<script type="text/javascript" src="../media/js_m/public_js.js"></script>
	<script src="../media/js/app.js"></script>
	<script>

		jQuery(document).ready(function() {  
			App.init();

		});

	</script>

	<script type="text/javascript">
		var _gaq = _gaq || []; _gaq.push([ '_setAccount', 'UA-37564768-1' ]); _gaq.push([ '_setDomainName', 'keenthemes.com' ]); _gaq.push([ '_setAllowLinker', true ]); _gaq.push([ '_trackPageview' ]);
		(function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })();
	</script>
</body>

</html>