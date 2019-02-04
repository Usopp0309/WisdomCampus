<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>成长档案-详情</title>

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
	<link rel="stylesheet" type="text/css" href="<%=basePath %>media/css/fancybox/jquery.fancybox-1.3.4.css" media="screen"></link>
	<link rel="stylesheet" href="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.css" />
	<link href="<%=basePath %>media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />

	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="<%=basePath %>media/image/favicon.ico" />
	
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body  class="page-header-fixed" id="body">
      

			<div class="container-fluid">

				<div class="row-fluid">

					<div class="span12">

						<ul class="breadcrumb">

							<li>

								<i class="icon-home"></i>

								<a href="javascript:;">首页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li>

								<a href="javascript:;">信息平台</a>
								<i class="icon-angle-right"></i>
							</li>
							
							<li>

								<a href="javascript:;">成长档案</a>
							</li>

						</ul>

					</div>

				</div>


				<div class="row-fluid">

					<div class="span12">
						
						
							<div class="tab-content">
								
								<div class="tab-pane active" id="tab_4">

									<div class="portlet box green">
			
										<div class="portlet-title">
											<div class="caption">成长档案</div>
										</div>
									
								
								</div>
									
									
								</div>
								
							</div>
						</div>
					</div>

				</div>

			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span3">
						<div class="archive_info">
							<img class="photo" src="<%=basePath %>media/image_m/head_photo.png">
							<div class="header"><img src="<%=basePath %>media/Template/info.png"></div>
							<p>幼儿名称:<span>${ga.realName }</span></p>
							<p>年级:<span>${ga.gradeName }</span></p>
							<p>班级:<span>${ga.clazzName }</span></p>
							<p>班主任:<span>${ga.leaderName }</span></p>
							<c:if test="${not empty ga.parentName }">
								<p>家长名称:<span>${ga.parentName }</span></p>
							</c:if>
							<c:if test="${ empty ga.parentName }">
								<p>家长名称:<span></span></p>
							</c:if>
							<p>模板详情:<span>${ga.templateName }</span></p>
							<input type="hidden" id="path"  value="${ga.path }">
							<input type="hidden" id="schoolName"  value="${ga.schoolName }">
							<input type="hidden" id="realName"  value="${ga.realName }">
							<input type="hidden" id="clazzName"  value="${ga.clazzName }">
							<input type="hidden" id="userId"  value="${ga.userId }">
							<input type="hidden" id="endDate"  value="${endDate }">
							<input type="hidden" id="growthId"  value="${growthId }">
						</div>
						<div class="archive_info" style="background-color:#eef8fd;margin:15px auto 0px;">
							<div class="header" style="background-color:#29abe2"><img src="<%=basePath %>media/Template/menu_list.png"></div>
							<ul id="page_list" class="page_list">
								<li><a class="active" href="<%=basePath %>jsp/growthArchives/archive01.jsp" target="archive_page">成长手册<i></i></a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive03.jsp" target="archive_page">宝贝小档案</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive04.jsp" target="archive_page">宝贝评价</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive05.jsp" target="archive_page">进园记录</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive06.jsp" target="archive_page">每日成长记录</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive07.jsp" target="archive_page">营养食谱</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive08.jsp" target="archive_page">多彩的幼儿园活动</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive09.jsp" target="archive_page">开心的一天</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive10.jsp" target="archive_page">我的作品展</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive11.jsp" target="archive_page">亲子活动</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive12.jsp" target="archive_page">我的幼儿园</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive13.jsp" target="archive_page">主题教学活动</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive14.jsp" target="archive_page">宝宝语录</a></li>
								<li><a href="<%=basePath %>jsp/growthArchives/archive15.jsp" target="archive_page">父母寄语</a></li>
							</ul>
						
						</div>
						<!-- <a href="" class="Output">导出档案</a> -->
					</div>
					<div class="span9">
						<iframe id="archive_page" name="archive_page" height="auto" style="width:100%;overflow:hidden"src="<%=basePath %>/jsp/growthArchives/archive01.jsp" onload="this.height=archive_page.document.body.scrollHeight;parent.document.getElementById('mainPage').style.height= document.body.scrollHeight + 'px';" scrolling="no" frameBorder="0"></iframe>
					
					</div>
					<input type="hidden" id="roleCode" value="${roleCode}">
				</div>
			</div>
				
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
	
	<script src="<%=basePath %>media/js/fancybox/jquery.fancybox-1.3.4.js"></script>  
	
	<script src="<%=basePath %>media/js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>  
	      
	<script type="text/javascript" src="<%=basePath %>media/js/My97DatePicker/WdatePicker.js"></script> 
	<script type="text/javascript" src="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=basePath %>media/js_m/public_js.js"></script> 
	<script src="<%=basePath %>media/js/app.js"></script>
	<script>
		
		jQuery(document).ready(function() {    
			
			App.init();
			//选择第一个tab
			$("#userTab li:first").addClass("active");
				
			$(".page_list li").on("click",function(){
				$(".page_list").find("a").removeAttr("class");
				$(".page_list li a").find("i").remove();
				 $(this).find("a").addClass("active"); 
				 $(this).find("a").append("<i></i>"); 
				})
		});
		function getRoleCode(){
			return $("#roleCode").val();
		}
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>