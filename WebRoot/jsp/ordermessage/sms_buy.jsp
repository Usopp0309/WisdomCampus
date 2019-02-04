<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!-->

<html lang="en">
<!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

<title>短信套餐</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="<%=basePath %>media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<link href="<%=basePath %>media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="<%=basePath %>media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<link href="<%=basePath %>media/css/style-metro.css" rel="stylesheet" type="text/css" />

<link href="<%=basePath %>media/css/style.css" rel="stylesheet" type="text/css" />

<link href="<%=basePath %>media/css/style-responsive.css" rel="stylesheet" type="text/css" />

<!-- <link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color" /> -->

<link href="<%=basePath %>media/css/uniform.default.css" rel="stylesheet" type="text/css" />

<link href="<%=basePath %>media/css/skin.css" rel="stylesheet" type="text/css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link href="<%=basePath %>media/css/pricing-tables.css" rel="stylesheet" type="text/css" />

<!-- END PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css" href="<%=basePath %>media/css/select2_metro.css" />

<link rel="stylesheet" href="<%=basePath %>media/css/DT_bootstrap.css" />

<link href="<%=basePath %>media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
<!-- END PAGE LEVEL STYLES -->

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

	<div class="container-fluid">

		<div class="row-fluid">
			<div class="span12">
				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="#">首页</a> <iclass="icon-angle-right"></i></li>
					<li><a href="#">套餐</a> <i class="icon-angle-right"></i></li>
				</ul>
			</div>
		</div>

		<div class="row-fluid">

			<div class="span12">

				<div class="portlet box breadcrumb">

					<div class="portlet-title">
						<div class="caption jur_actions_color_666">短信套餐 </div>
					</div>

					<div class="portlet-body form">
						<div class="sms_server">
								<div class="span4">
								<a href="#static" data-toggle="modal">
										<div class="server_img">
											<img src="<%=basePath %>media/image_m/sms_server.png">
										</div>
										<div class="server_info">
												<p><span>价格：</span>11元</p>
												<p><span>产品：</span>11</p>
												<p><span>时间范围：</span>2016-6-10-2016-12-16</p>
										</div>
								</a>
								</div>
						
						</div>

					</div>

				</div>

			</div>

		</div>

	</div>
<div data-keyboard="false" data-backdrop="static" tabindex="-1" class="modal hide fade" id="static">
	<div class="modal-header">
		短信购买
	</div>
	<div class="modal-body select_personnel">
		<p><span>查找人员：</span><input type="text"><input type="button" value="搜索" style="line-height:28px;border:1px solid #666;color:#666;margin:0 0 0 15px;"></p>
			<ul>
				<li id="1" class="ok">陈凯1</li>
				<li id="2"class="ok">陈凯2</li>
				<li id="3">陈凯3</li>
				<li id="4"class="ok">陈凯4</li>
				<li id="5">陈凯1</li>
				<li id="6"class="ok">陈凯5</li>
				<li id="7">陈凯6</li>
			</ul>
	</div>
	<div class="modal-footer">

		<button type="button" data-dismiss="modal" class="btn">取消</button>

		<button type="button" data-dismiss="modal" class="btn green">确定</button>

	</div>

</div>
	<script src="<%=basePath %>media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/bootstrap.min.js" type="text/javascript"></script>
	
	<script src="<%=basePath %>media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.blockui.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="<%=basePath %>media/js/jquery.uniform.min.js" type="text/javascript"></script>

	<script type="text/javascript" src="<%=basePath %>media/js/jquery.gritter.js"></script>

	<script type="text/javascript" src="<%=basePath %>media/js/jquery.pulsate.min.js"></script>

	<script type="text/javascript" src="<%=basePath %>media/js/jquery.bootpag.min.js"></script>


	<script src="<%=basePath %>media/js/ui-general.js"></script>
	
	<script type="text/javascript" src="<%=basePath %>media/js_m/public_js.js"></script> 
	<script src="<%=basePath %>media/js/app.js"></script>
	
	<script>

		jQuery(document).ready(function() {       
		   $(".ok").on("click",function(){
				if($(this).hasClass("select")){
					$(this).removeClass("select");
				}else{
					$(this).addClass("select");
				}
			})
		});

		
	</script>

	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-37564768-1' ]);
		_gaq.push([ '_setDomainName', 'keenthemes.com' ]);
		_gaq.push([ '_setAllowLinker', true ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://'
					: 'http://')
					+ 'stats.g.doubleclick.net/dc.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>
</body>

<!-- END BODY -->

</html>