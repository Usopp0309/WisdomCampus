<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
<head>
	<title>视频详情</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link href="<%=basePath%>media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/font-awesome-4.4.0/css/font-awesome.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath%>media/css/select2_metro.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>media/css/DT_bootstrap.css" rel="stylesheet"/>
	<link href="<%=basePath %>media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body class="page-header-fixed camera_live">
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="#">首页</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>
								<a href="#">视频直播</a>
								<i class="icon-angle-right"></i>
							</li>
							<li>
								<a href="#">视频详情</a>
							</li>
						</ul>
					</div>
				</div>
					<h3>学校主教学楼</h3>
				<div class="row-fluid">
					<div class="span9">
						<video src="http://richxvideo.b0.upaiyun.com/test.mp4" style="width:100%;" controls="controls" preload="preload"></video>
						<p>分享到：<a href=""><img src="<%=basePath%>media/image_m/yixin.png"></a></p>
					</div>
					<div class="span3">
						<h3 style="background-color:#f2f2f2">视频信息</h3>
						<h4>学校主教学楼</h4>
						<p><span>描述</span>南京西门学校主教学楼</p>
					</div>
				</div>
			</div>
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="<%=basePath%>media/js/bootstrap.min.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
	<script src="media/js/excanvas.min.js"></script>
	<script src="media/js/respond.min.js"></script>  
	<![endif]-->                    
	<script src="<%=basePath%>media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="<%=basePath%>media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<script src="<%=basePath%>media/js/select2.min.js" type="text/javascript" ></script>
	<script src="<%=basePath%>media/js/jquery.dataTables.min.js" type="text/javascript" ></script>
	<script src="<%=basePath%>media/js/DT_bootstrap.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/table-advanced.js"></script>
	<script src="<%=basePath%>media/js/My97DatePicker/WdatePicker.js" type="text/javascript" ></script>       
	<script src="<%=basePath%>media/js_m/public_js.js" type="text/javascript"></script> 
	<script src="<%=basePath%>media/js/app.js" type="text/javascript"></script>
	<script>
		jQuery(document).ready(function() {    
			});
	</script>
<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>
</html>