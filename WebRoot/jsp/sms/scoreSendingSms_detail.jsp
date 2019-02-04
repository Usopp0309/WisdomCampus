<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>发送成绩详情查看22</title>

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

	<link href="../media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="../media/css/select2_metro.css" />

	<link rel="stylesheet" href="../media/css/DT_bootstrap.css" />
	

	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="../media/image/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="../media/css/fancybox/jquery.fancybox-1.3.4.css" media="screen"></link>
	<link href="../media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
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

								<a href="#">信息平台</a>
								<i class="icon-angle-right"></i>
							</li>
							
							<li>

								<a href="#">发送成绩详情</a>
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
						
							<div class="tab-content">
								
								<div class="tab-pane active" id="tab_4">

									<div class="portlet box green">
			
										<div class="portlet-title">
											<div class="caption">发送成绩详情</div>
											<div class="tools">

												<a href="javascript:;" class="collapse"></a>

											</div>
										</div>
									<div class="portlet-body search_box">
										
										<!-- 查询表单begin -->
										<form action="" class="form-horizontal" method="post">
											<div class="row-fluid">
											
												<div class="span12">
												
													<div class="control-group margin-bottom_null">

														<div class="controls"   style="margin-left: 0px">
	
															<input type="text" placeholder="请输入短信内容,接收人....." class="m-wrap medium" id="queryContent"/>
	
															<button type="button" class="btn blue" id="search"><i class="fa fa-search"></i>&nbsp;查找</button>
															
															<button type="reset" class="btn light-grey"><i class="icon-remove"></i>&nbsp;重置</button>
														</div>

													</div>
														
												</div>
											</div>
											
										</form>
										<!-- 查询表单end -->
									</div>
								</div>
									<table class="table table-striped table-bordered table-hover"  id="table">
			
											<thead>
			
												<tr>
			
													<th width="40%">短信内容</th>
			
													<th width="15%">手机号码</th>
													
													<th width="15%">接收人</th>

													<th width="15%">发送状态</th>
													
													<th width="15%">发送时间</th>
			
												</tr>
			
											</thead>
			
											<tbody id="tbody">
			
											</tbody>
			
									</table>
									<input type="hidden" value="${id}" id="messageId">
									<div class="pagination pagination-right">
										<ul>
											<li>
												<a href="javascript:;" onclick="jumpPage('first')" title="首页">
													&laquo; 首页
												</a> 
											</li>
											<li>
												<a href="javascript:;" onclick="jumpPage('previous')" title="上一页">
													上一页
												</a>
											</li>
												
											<li>
												<a>
													<span id="currentPage"></span>/<span id="totalPage"></span>
												</a>
											</li>	
											<li>
												<a href="javascript:;" onclick="jumpPage('next')" title="下一页">
													下一页
												</a>
											</li>
											<li> 
												<a href="javascript:;" onclick="jumpPage('last')" title="末页">
													末页&raquo;
												</a>
											</li>
					
										</ul>
									</div>
								</div>
								
							</div>
						</div>
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
	
	<script src="../media/js/fancybox/jquery.fancybox-1.3.4.js"></script>  
	
	<script src="../media/js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>  
	<script type="text/javascript" src="../media/js_m/public_js.js"></script>
	<script src="../media/js/app.js"></script>
	<script>

		jQuery(document).ready(function() {    

			App.init();

			var id=$("#messageId").val();
			//输入查询短信内容
			var queryContent = $("#queryContent").val();

			//加载初始化数据
			loadScoreSendingSmsDetail(id,queryContent,null);
			
			//查找数据
			$("#search").click(function(){
				
				var id=$("#messageId").val();
				//输入查询短信内容
				var queryContent = $("#queryContent").val();

				loadScoreSendingSmsDetail(id,queryContent,null);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;	
            	}
			});
		});

		
		//加载信息列表
		function loadScoreSendingSmsDetail(messageId, queryContent,cPage)
		{
		
			var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>sms/loadScoreSendingSmsDetail.do",
				data:{
					    messageId : messageId,
						queryContent : queryContent,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					
					$("#currentPage").html(page.currentPage);
					
					$("#totalPage").html(page.totalPage);
					
					var appendHtml = '';
					
					$.each(page.list, function(n, value) { 
						 
						if (n%2 == 0)
						{
							appendHtml += '<tr style="background-color: #ededed">';
						}
						else
						{
							appendHtml += '<tr>';
						};
						//短信内容
           				appendHtml += '<td width="40%">' + value.content + '</td>';
						//手机号码
           				appendHtml += '<td width="15%">' + value.phone + '</td>';
						//接收人
           				appendHtml += '<td width="15%">' + value.receiverName + '</td>';
           				
						//发送状态 
           				var status = parseInt(value.status);
           				
           				switch(status)
           				{ 
           					case 0 : 
           						appendHtml += '<td width="15%">发送成功</td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td width="15%">发送失败</td>';
           						break; 
           				}		
           				//发送时间
           				appendHtml += '<td width="15%">' + value.createTime + '</td>';
						
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			
          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		//分页相关
		function jumpPage(type)
		{
			var cPage = $("#currentPage").html();
			var totalPage = $("#totalPage").html();

			var cPageInt = parseInt(cPage);
			var totalPageInt = parseInt(totalPage);
			var newCPageInt = returnCPageInt(type,cPageInt,totalPageInt);
			if(newCPageInt < 0){
				return;
			}else{
				cPageInt = newCPageInt;
			}



				//import表的主键
				var id=$("#messageId").val();
				//输入查询条件
				var queryContent = $("#queryContent").val();
				loadScoreSendingSmsDetail(id,queryContent,cPageInt);
				$("#currentPage").html(cPageInt);
		}

		
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>