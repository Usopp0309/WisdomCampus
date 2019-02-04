<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>校车报警异常</title>

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

<body class="page-header-fixed" id="body">


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

								<a href="#">校车管理</a>
								<i class="icon-angle-right"></i>
							</li>
							
							<li>

								<a href="#">校车异常</a>
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
							<c:forEach items="${sessionScope.user.roleList}" var="roleList">
								<li class="roleLi">
									<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
									</a>
								</li>
							</c:forEach>
						</ul>
						
						<div class="tab-content">

							<div class="tab-pane active" id="tab_4">
					            <div class="portlet box light-grey">
			
									<div class="portlet-title">
										
										<div class="caption"><i class="icon-user"></i>校车异常</div>
										
										<div class="tools">

											<a href="javascript:;" class="collapse fa fa-search"></a>

										</div>
										
									</div>
								
									<div class="portlet-body" >
										
										<!-- 查询表单begin -->
										<form action="#" class="form-horizontal" method="post">
											
											 <label class="control-label" style="margin-left: -100px" id="tchStuTypeLabel">师生类型:</label>
	
											<div class="controls" style="margin-left: -100px">

												<select class="medium m-wrap" id="tchStuType">

													<option value="0" selected="selected">全部</option>
													
													<option value="1">教师</option>

													<option value="2">学生</option>

												</select>

											</div>

											<div class="controls" style="margin-left: -10px">
												  

												<input type="text" placeholder="拥有者、短信内容..." class="m-wrap medium" id="queryContent"/>
												
												<button type="button" class="btn blue" id="search"><i class="fa fa-search"></i>查找</button>
											    
											    <button type="reset" class="btn green" id="export"><i class="icon-share-alt"></i>&nbsp;导出</button>

											</div>
											
										</form>
										
										<!-- 查询表单end -->
		
									</div>
									
								</div>
								
									
									
								
									
								<div class="portlet-body">
									
									<table class="table table-bordered table-hover table-full-width" id="sample_1">
	
										<thead>
	
											<tr>
	
												<th width="15%">持有者</th>
	
												<th width="15%">类型</th>
	
												<th width="55%">短信内容</th>
												
												<th width="15%">创建时间</th>
	
											</tr>
											
										</thead>
	
										<tbody id="tbody">
	
										</tbody>
	
									</table>
	
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
			var roleCode = $("ul li.active").find('a').attr("attr2");
	
			//加载初始化数据   
			loadSchoolBusAbnormalList(null, null, userId, roleCode, null);
	        loadAllGradeList(userId, roleCode);
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleId = $(this).attr("attr2");R
				loadSchoolBusAbnormalList(null, null, userId, roleCode, null);

				
				//初始化select
				$("#tchStuType").val('0');
			});
			
			//条件查询
			$("#search").click(function(){

				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				//短信内容
				var queryContent = $("#queryContent").val();
				//时间
				//var time = $("#time").val();
				//姓名
				//var name = $("#name").val();
				//师生类型
				var type = $("#tchStuType").val();
				
				loadSchoolBusAbnormalList(queryContent, type, userId, roleCode, null);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;	
            	}
			});
			
			//导出数据
			$("#export").click(function(){
				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				//短信内容
				var queryContent = $("#queryContent").val();
				//时间
				//var time = $("#time").val();
				//姓名
				//var name = $("#name").val();
				//类型
				var type = $("#tchStuType").val();
				
				standardPost('<%=basePath%>schoolbusAbnormal/doExportExcel.do',{queryContent:queryContent,type:type,userId:userId,roleCode:roleCode});
				});
			
		});
		
		//根据学校ID加载该学校所有的年级数据
		function loadAllGradeList(userId, roleCode)
		{
		    
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadGradeList.do",
				data:{
					},
				success: function(data){
					var gradeList = eval("(" + data + ")");
					var appendHtml = '<option value="0">--请选择--</option>';
					$.each(gradeList, function(n, value) {  
           				appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
          			}); 
          			$("#gradeSelect").html(appendHtml);
				},
			});
		}
		
		

		//加载异常报警列表
		function loadSchoolBusAbnormalList(queryContent, type, userId, roleCode, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbusAbnormal/loadSchoolBusAbnormalList.do",
				
				data:{
				        queryContent : queryContent,
				        type : type,
						userId : userId,
						roleCode : roleCode,
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
						}	
						//持有者
           				appendHtml += '<td width="15%">' + value.userName + '</td>';
						//类型
						var type = parseInt(value.type);

			            switch(type)
			             { 
			             case 1:
           				     appendHtml += '<td width="15%">上校车未刷卡</td>';
           				     break;
           				 case 2:
           				     appendHtml += '<td width="15%">下校车未刷卡 </td>';
                             break;
                         default :  
                             appendHtml += '<td width="15%"> 未知异常  </td>';   
                             break;
           				 } 
						//短信内容
						if (value.message == undefined)
						{
							appendHtml += '<td width="55%"></td>';
						}
						else
						{
           					appendHtml += '<td width="55%">' + value.message + '</td>';
						}
						//创建时间
           				appendHtml += '<td width="15%">' + value.createTime + '</td>';
           				
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			reSetIframeHeight();
          			
          			//解锁UI
          			App.unblockUI(body);
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

			//师生类型
			var tchStuType = $("#tchStuType").val();
			var queryContent = $("#queryContent").val();
			//用户ID
			var userId = $("ul li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("ul li.active").find('a').attr("attr2");
			loadSchoolBusAbnormalList(queryContent, tchStuType, userId, roleCode, cPageInt)
			$("#currentPage").html(cPageInt);
		}

		//加载师生选择select
		function loadTchStuSelect(roleCode)
		{
			//如果是系统管理员，超级管理员，校长，班主任则有发布权限
			var roleCode = parseInt(roleCode);

			if(roleCode=="parent" || roleCode=="student")
			{
				$("#tchStuType").hide();
			} 
			else
			{
				$("#tchStuType").show(); 
			}
		}
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>