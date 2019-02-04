<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>发送信息</title>

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

								<a href="#">系统管理</a>
								<i class="icon-angle-right"></i>
							</li>
							
							<li>

								<a href="#">在线审核申请</a>
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
						<!-- BEGIN EXAMPLE TABLE PORTLET-->
						
						<ul class="nav nav-tabs" id="userTab">
 							<c:forEach items="${sessionScope.user}" var="user">
							 <%--  班主任,普通教师,学生  为相同权限,看到tab一样--%>
 								<c:if test="${user.roleId == 3 || user.roleId == 1 || user.roleId == 2 }">
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
											<div class="caption"><i class="icon-user"></i>在线审核申请</div>

											<div class="actions">
		
												<a href="#" class="btn blue" id="" style="display:none;">
													<i class="icon-plus"></i> 审核申请
												</a>
												
											</div>
			
										</div>
										
										<div class="portlet-body">
										  <table class="table table-bordered table-hover table-full-width" id="sample_1">
		
											<thead>
		
												<tr>
		
													<th width="30%">申请人</th>
		
													<th width="10%">类型</th>
		
													<th width="10%">状态</th>
													
													<th width="10%">班级</th>
													
													<th width="10%">年级</th>
													
													<th width="30%">更新时间</th>
		
												</tr>
												
											</thead>
		
											<tbody id="tbody">
		
											</tbody>
		
										</table>
		
									</div>

								</div>
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
			loadCardApplyAudit(null, userId, roleId, null);
			
			
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleId = $(this).attr("attr2");
				loadStudentList(null, userId, roleId, null);
				//加载增加按钮
				loadAddBtn(roleId);	
				loadModifyBtn(roleId);		
			});
			
		});

		//加载审核申请列表
		function loadCardApplyAudit (type, userId, roleId, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>cardApply/loadCardApplyAuditList.do",
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
           				appendHtml += '<tr>';
						//申请人
           				appendHtml += '<td width="30%">' + value.name + '</td>';
						//类型
						var typeResult = parseInt(value.cardtype);
						switch(typeResult)
           				{ 
           					case 0 : 
           						appendHtml += '<td width="10%">新卡补办</td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td width="10%">遗失补办</td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td width="10%">退卡申请</td>';
           						break; 
           					case 3 : 
           						appendHtml += '<td width="10%">冻结申请</td>';
           						break; 	
           					default : 
           						appendHtml += '<td width="10%">其他</td>';
           						break;
           				}
           				//appendHtml += '<td width="10%">' + value.type + '</td>';
						//状态
           				var result = parseInt(value.auditstatus);
           				switch(result)
           				{ 
           					case 0 : 
           						appendHtml += '<td width="10%">未审核</td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td width="10%">审核通过</td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td width="10%">审核未通过</td>';
           						break; 
           					default : 
           						appendHtml += '<td width="10%">其他</td>';
           						break;
           				}
           				 
						//班级
           				appendHtml += '<td width="30%">' + value.clazzName + '</td>';
						//年级           				
           			
           				if(undefined==value.gradeid)
           				{
           				    appendHtml += '<td width="10%"></td>';
           				}
           				else
           				{
           				    appendHtml += '<td width="10%">' + value.gradeName + '</td>';
           				}
						//更新时间
           				appendHtml += '<td width="10%">' + value.createTime + '</td>';
           				
           				appendHtml += '</tr>';
           				
          			}); 
          			$("#tbody").html(appendHtml);
          			reSetIframeHeight();
          			try
          			{
          				App.unblockUI(el);	
              		}
              		catch(e)
              		{
                  	}
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

			//用户ID
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleId = $("ul li.active").find('a').attr("attr2");
			loadCardApplyAudit(type, userId, roleId, cPageInt);
			$("#currentPage").html(cPageInt);
		}

		//加载师生选择select
		function loadTchStuSelect(roleId)
		{
			//如果是系统管理员，超级管理员，校长，班主任则有发布权限
			var roleIdInt = parseInt(roleId);

			switch(roleIdInt)
			{ 
				case 1 : 
					$("#tchStuType").show();
					break; 
				case 2 : 
					$("#tchStuType").show(); 
					break; 
				case 3 : 
					$("#tchStuType").show(); 
					break; 
				case 4 : 
					$("#tchStuType").show();
					break; 
				case 5 : 
					$("#tchStuType").hide();
					break; 
				case 6 : 
					$("#tchStuType").hide();
					break; 
				case 7 : 
					$("#tchStuType").hide();
					break; 
				default : 
					$("#tchStuType").hide();
					break;
			} 
		}
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>