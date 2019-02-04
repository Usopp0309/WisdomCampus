<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="UTF-8"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>公告展示</title>

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

	<link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

	<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="../media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="../media/css/select2_metro.css" />

	<link rel="stylesheet" href="../media/css/DT_bootstrap.css" />

	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="../media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">


	<!-- BEGIN CONTAINER -->
		<!-- BEGIN PAGE -->

		<div class="page-content">


			<!-- BEGIN PAGE CONTAINER-->        

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

								<a href="#">公告展示</a>
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
							<ul class="nav nav-tabs" id="userTab" style="display: none">
								<c:forEach items="${sessionScope.user}" var="user">
									<c:if test="${user.roleId == 1 || user.roleId == 2 || user.roleId == 3}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${user.id}" attr2="${user.roleId}">${user.name}(${user.roleName})
											</a>
										</li>
									</c:if>
									<!-- 班主任,普通教师,家长,学生  为相同权限,看到tab一样-->
									<c:if test="${user.roleId == 4 || user.roleId == 5 || user.roleId == 6 || user.roleId == 7}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${user.id}" attr2="${user.roleId}">${user.name}(${user.roleName})
											</a>
										</li>																						
									</c:if>
								</c:forEach>																						
							</ul>
							<div class="tab-content">
								
								<div class="tab-pane active" id="tab_4">

									<div class="portlet box green">
			
										<div class="portlet-title">
											<div class="caption"><i class="icon-reorder"></i>公告展示</div>
			
										</div>
								
										<div class="portlet-body">
											<div class="caption">
												<select class="layout-option form-control " id="announcementSelect">
													<option value="0" selected="selected">最新公告</option>
													<option value="1">学校公告</option>
													<option value="2">班级公告</option>
													<option value="3">系统公告</option>
												</select>
											</div>
											<div style=" position: relative;background: url(../media/image/board.png) no-repeat; display:block; width: 985px;">
												<table cellspacing="" cellpadding="0" border="0" style="width: auto;WORD-BREAK: break-all; WORD-WRAP: break-word">
                                            		<tr height="100">
														<td>&nbsp;</td>
													</tr>
                                                    <tr>
														<td>
															<div style="position: relative;overflow: hidden; overflow-y:scroll; height: 450px; width: 965px;">
																<table border="0" cellspacing="0" cellpadding="0" style="width: 955px;height: auto; margin-left: 10px;">
																		<tr height="30">
																			<td colspan="4">&nbsp;</td>
																		</tr>
																		<tr height="80">
																			<td width="30">&nbsp;</td>
																			<td width="350" colspan="2" id="content">
																			</td>
																			<td width="30">&nbsp;</td>
																		</tr>
																		<tr height="20">
																			<td width="10">&nbsp;</td>
																			<td width="350" colspan="2" align="right" id="username">
																			</td>
																			<td width="30">&nbsp;</td>
																		</tr>
																		<tr height="20">
																			<td width="10">&nbsp;</td>
																			<td width="350" colspan="2" align="right" id="date">
																			</td>
																			<td width="30">&nbsp;</td>
																		</tr>
																		<tr>
																		<td colspan="4" align="center">
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
																						<a >
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
																		</td>
																		</tr>
																</table>
															</div>
														</td>
														
                                                    </tr>
                                                    <tr>
                                                    
                                                    </tr>
                                                    
												</table>
											</div>
										</div>
											
									</div>
								</div>
								
							</div>
						</div>
					</div>

				</div>

				<!-- END PAGE CONTENT-->

			</div>

	<!-- END CONTAINER -->

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
	<script src="../media/js/app.js"></script>

	<script>
		jQuery(document).ready(function() {    

			App.init();
			
			//选择第一个tab
			$("#userTab li:first").addClass("active");
			
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleId = $("ul li.active").find('a').attr("attr2");

			//加载初始化数据
			loadAnnouncementList(null, userId, roleId, null);


			//选择公告类型加载
			$("#announcementSelect").change(function(){
				//公告类型
				var type = $(this).val();
				//用户ID
				var userId = $("ul li.active").find('a').attr("attr1");
				var roleId = $("ul li.active").find('a').attr("attr2");
				loadAnnouncementList(type, userId, roleId, null);
			});

		});

		//加载公告页面
		function loadAnnouncementList(type, userId, roleId, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>announcement/loadAnnouncementListByType.do",
				data:{
						type : type,
						userId : userId,
						roleId : roleId,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) { 
					appendHtml1 ='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="font-family:微软雅黑;color: black; " size="4">'+value.content+'</font>';
					appendHtml2 ='<font style="font-family:微软雅黑;color: black;color: black;" size="4">'+value.userName+'</font>';
					appendHtml3 ='<font style="font-family:微软雅黑;color: black;" size="4">'+value.createtime+'</font>'
          			}); 
          			
          			$("#content").html(appendHtml1);
          			$("#username").html(appendHtml2);
          			$("#date").html(appendHtml3);
          			reSetIframeHeight();
				},
			});
		}


		//iframe加载相关
		var iframeLoaded = function (iframe) 
		{
		    if (iframe.src.length > 0) 
			{
		        if (!iframe.readyState || iframe.readyState == "complete") 
			    {
		            var bHeight = 
		            iframe.contentWindow.document.body.scrollHeight;
		            var dHeight = 
		            iframe.contentWindow.document.documentElement.scrollHeight;
		            var height = Math.max(bHeight, dHeight);
		            iframe.height = height;
		        }
		    }
		}
		//分页时重新设置 iframe 高度 ； 修改后：iframe.name = iframe.id
		var reSetIframeHeight = function()
		{
		    try 
		    {
		        var oIframe = parent.document.getElementById(window.name);
		        oIframe.height = 100;
		        iframeLoaded(oIframe);
		    }
		    catch (err)
		    {
		        try 
		        {
		        	parent.document.getElementById(window.name).height = 1000;
		        }
		        catch (err2) 
		        {
			    }
		    }
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
			//公告类型
			var type = $("#announcementSelect").val();
			//用户ID
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleId = $("ul li.active").find('a').attr("attr2");
			loadAnnouncementList(type, userId, roleId, cPageInt);
			$("#currentPage").html(cPageInt);
		}

		
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>