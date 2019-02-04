<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>发送成绩短信历史查看</title>

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

								<a href="#">成绩发送记录</a>
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
										<c:if test="${roleList.roleCode ne 'student' && roleList.roleCode ne 'parent' && roleList.roleCode ne 'other'}">
											<li class="roleLi">
												<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>	
						
							<div class="tab-content">
								
								<div class="tab-pane active" id="tab_4">

									<div class="portlet box green">
			
										<div class="portlet-title">
											<div class="caption">成绩发送记录</div>
											<div class="tools">

												<a href="javascript:;" class="collapse"></a>

											</div>
										</div>
									<div class="portlet-body search_box">
										
										<!-- 查询表单begin -->
										<form action="" class="form-horizontal" method="post">
											
											
											<div class="control-group margin-bottom_null">
												<div class="width_20">
													<input type="text" placeholder="短信内容、发送人..." class="m-wrap medium" id="queryContent"/>
													
													<button type="button" class="btn blue" id="search"><i class="fa fa-search"></i>&nbsp;查找</button>
													
													<button type="reset" class="btn light-grey"><i class="icon-remove"></i>&nbsp;重置</button>
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
			
													<th width="15%">发送人</th>
			
													<th width="15%">发送时间</th>
			
													<th width="15%" >发送状态</th>

													<th width="15%">查看详情</th>
			
												</tr>
			
											</thead>
			
											<tbody id="tbody">
			
											</tbody>
			
									</table>
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
			
			//选择第一个tab
			$("#userTab li:first").addClass("active");

			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");


			//输入查询短信内容
			var queryContent = $("#queryContent").val();

			//加载初始化数据
			loadSmsList(userId, roleCode,queryContent,null);
			//点击tab页加载
			$(".roleTab").click(function(){

				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadSmsList(userId, roleCode,null,null,null);
			});
			
			//查找数据
			$("#search").click(function(){
				
				//输入查询条件
				var queryContent = $("#queryContent").val();
				//用户ID
				var userId = $("ul li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("ul li.active").find('a').attr("attr2");

				loadSmsList(userId, roleCode,queryContent,null);
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
		function loadSmsList(userId, roleCode, queryContent,cPage)
		{
		
			var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>sms/getScoreSendingSmsList.do",
				data:{
						userId : userId,
						roleCode : roleCode,
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
						}	;
						//短信内容
           				appendHtml += '<td width="45%" style="max-width:260px;word-break:break-all;text-align:left">' + value.content + '</td>';
						//发送人
           				appendHtml += '<td width="10%">' + value.senderName + '</td>';
						//发送时间
           				appendHtml += '<td width="10%">' + value.sentTime + '</td>';
						//发送状态
           				var result = parseInt(value.result);
           				
           				switch(result)
           				{ 
           					case 0 : 
           						appendHtml += '<td width="10%">发送成功</td>';
           						break; 
           					case 6 : 
           						appendHtml += '<td width="10%">短信内容为空</td>';
           						break; 
           					case 7 : 
           						appendHtml += '<td width="10%">号码为空</td>';
           						break; 
           					case 99 : 
           						appendHtml += '<td width="10%">系统内部错误</td>';
           						break; 
           					default : 
           						appendHtml += '<td width="10%">待发送</td>';
           						break;
           				} 

           				//查看详情
           				appendHtml += '<td width="15%"><a href="javascript:;"class="edit" onclick="aduitLeave(' + value.id +','+value.type + ')">详情</a></td>';
						
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			
          			//解锁UI
          			App.unblockUI(body);
          			/* $(".search_box").css({"display":"none"}); */
          			if (null != cPage)
              		{
          				$("#currentPage").html(cPage);
              		}
          			
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

				//输入查询条件
				var queryContent = $("#queryContent").val();
				//用户ID
				var userId = $("ul li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("ul li.active").find('a').attr("attr2");

				loadSmsList(userId, roleCode,queryContent,cPageInt);
				$("#currentPage").html(cPageInt);
		}
		
		function aduitLeave(id,type)
		{
		    standardPost('<%=basePath%>sms/toSmsDetailView.do',{id:id,type:type});
		}

		
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>