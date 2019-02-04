<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->
<head>

	<meta charset="utf-8" />

	<title>接受留言查看</title>

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

	<link href="../media/css/bootstrap-tag.css" rel="stylesheet" type="text/css" />

	<link href="../media/css/bootstrap-wysihtml5.css" rel="stylesheet" type="text/css" />

	<link href="../media/css/jquery.fancybox.css" rel="stylesheet" />

	<link href="../media/css/bootstrap-wysihtml5.css"  rel="stylesheet" type="text/css" />

	<!-- BEGIN:File Upload Plugin CSS files-->

	<link href="../media/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" >

	<!-- END:File Upload Plugin CSS files-->     

	<link href="../media/css/inbox.css" rel="stylesheet" type="text/css" />

	<link href="../media/css/timeline.css" rel="stylesheet" type="text/css"/>
	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="../media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed" >

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

							<li><a href="#">留言</a></li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<div class="row-fluid inbox">

					<div class="span1">

					</div>
						<div class="span10">

							<!-- BEGIN PORTLET-->

							<div class="portlet">

								<div class="portlet-body">

										<ul class="chats" >
											<li class="in">

												<img class="avatar" alt="" src="../media/image/avatar2.jpg" />

												<div class="message">

													<span class="arrow"></span>

													<a href="#" class="name">${onlineMessageDetail.senderName }</a>

													<span class="datetime"> 发送于： ${onlineMessageDetail.createTime }</span>

													<span class="body">

													${onlineMessageDetail.content }

													</span>

												</div>

											</li>

										</ul>


								</div>

							</div>

							<!-- END PORTLET-->
				</div>

			</div>
	</div>
			<!-- END PAGE CONTAINER-->    

	<!-- END CONTAINER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	<script src="../media/js/jquery-2.1.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="../media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="../media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>

	<script src="../media/js/excanvas.min.js"></script>

	<script src="../media/js/respond.min.js"></script>  

	<![endif]-->   

	<script src="../media/js/breakpoints.min.js" type="text/javascript"></script>  

	<script src="../media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="../media/js/bootstrap-tag.js" type="text/javascript" ></script> 

	<script src="../media/js/jquery.fancybox.pack.js" type="text/javascript" ></script>

	<script src="../media/js/wysihtml5-0.3.0.js" type="text/javascript" ></script> 

	<script src="../media/js/bootstrap-wysihtml5.js" type="text/javascript" ></script>

	<!-- BEGIN:File Upload Plugin JS files-->

	<script src="../media/js/jquery.ui.widget.js"></script>

	<!-- The Templates plugin is included to render the upload/download listings -->

	<script src="../media/js/tmpl.min.js"></script>

	<!-- The Load Image plugin is included for the preview images and image resizing functionality -->

	<script src="../media/js/load-image.min.js"></script>

	<!-- The Canvas to Blob plugin is included for image resizing functionality -->

	<script src="../media/js/canvas-to-blob.min.js"></script>

	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->

	<script src="../media/js/jquery.iframe-transport.js"></script>

	<!-- The basic File Upload plugin -->

	<script src="../media/js/jquery.fileupload.js"></script>

	<!-- The File Upload file processing plugin -->

	<script src="../media/js/jquery.fileupload-fp.js"></script>

	<!-- The File Upload user interface plugin -->

	<script src="../media/js/jquery.fileupload-ui.js"></script>

	<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->

	<!--[if gte IE 8]><script src="../media/js/jquery.xdr-transport.js"></script><![endif]-->

	<!-- END:File Upload Plugin JS files-->

	<!-- END PAGE LEVEL PLUGINS -->


	<script src="../media/js/inbox.js"></script>    
	<script src="../media/js/app.js"></script>      

	<script>

		jQuery(document).ready(function() {       

		   // initiate layout and plugins

		   App.init();
		   Inbox.init();

		});
		
		
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->
</html>
