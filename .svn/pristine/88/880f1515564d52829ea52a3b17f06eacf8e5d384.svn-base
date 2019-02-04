<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<meta charset="utf-8" />

	<title>Metronic | Visual Charts</title>

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
	
	<link href="../media/css/error.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<link rel="shortcut icon" href="../media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">


	<!-- BEGIN CONTAINER -->
		<!-- BEGIN PAGE -->

		<div class="page-content">

			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<div id="portlet-config" class="modal hide">

				<div class="modal-header">

					<button data-dismiss="modal" class="close" type="button"></button>

					<h3>portlet Settings</h3>

				</div>

				<div class="modal-body">

					<p>Here will be a configuration form</p>

				</div>

			</div>

			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<!-- BEGIN PAGE CONTAINER-->

			<div class="container-fluid">

				<!-- BEGIN PAGE HEADER-->

				<div class="row-fluid">

					<div class="span12">
						
						<br/>
						
						<ul class="breadcrumb">

							<li>

								<i class="icon-home"></i>

								<a href="index.html">校车管理</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li><a href="#">校车报表</a></li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN CHART PORTLETS-->


				<!-- END CHART PORTLETS-->

				<!-- BEGIN PIE CHART PORTLET-->
				
				<ul class="nav nav-tabs" id="userTab">
							<c:forEach items="${sessionScope.user}" var="user">
								<!-- 班主任,普通教师,学生  为相同权限,看到tab一样-->
								<c:if test="${user.roleId == 1 || user.roleId == 2 || user.roleId == 3}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${user.id}" attr2="${user.roleId}">${user.name}(${user.roleName})
											</a>
										</li>
									</c:if>
									<!-- 班主任,普通教师,家长,学生  为相同权限,看到tab一样-->
									<c:if test="${user.roleId == 8 ||user.roleId == 4}">
										<li class="roleLi">
											<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${user.id}" attr2="${user.roleId}">${user.name}(${user.roleName})
											</a>
										</li>																						
									</c:if>
							</c:forEach>
				</ul>

				<div class="row-fluid">

					<div class="span6" id="qxtj" >

						<div class="portlet box light-grey">

							<div class="portlet-title">

								<div class="caption"><i class="icon-reorder"></i>全校统计</div>

								<div class="tools">
								
									<a href="javascript:;" class="collapse fa fa-search"></a>
								
								</div>

							</div>

							<div class="portlet-body">
								<div class="row-fluid">
									<div class="span12">
									
										<div class="control-group span4">

											<label class="control-label">时间:</label>

											<div class="controls">

												<input type="text" size="16" name="time" onclick="WdatePicker()" id="time"  class="m-wrap"/>

											</div>

										</div>
										
										<div class="control-group span4">

											<label class="control-label" >进出宿舍:</label>

											<div class="controls">

												
												<select class="medium m-wrap" id="type" name="type">
                                                	
                                                	<option value="1" selected="selected">上校车</option>
													<option value="2">下校车</option>
												
												</select>

											</div>

										</div>
										
										
										<div class="control-group span4">
											<label class="control-label" >&nbsp;</label>

											<div class="controls">
	
												<button type="button" class="btn blue" id="search"><i class="fa fa-search"></i>查找</button>
												
											</div>

										</div>
										
									</div>
								</div>

							</div>
							<br>
							<div id="totalChart" class="chart"></div>
							
							<div class="row-fluid" id="totalNotFound" style="display:none;">

								<div class="span12 page-404">
			
									<div class="number">
			
										暂无数据
			
									</div>
			
									<div class="details">
			
										<h3>您好, 暂未发现统计数据.</h3>
			
										<p>
			
											系统无法查出当天的统计数据.<br />
			
											<a href="#">联系管理员</a>确认当天是否有统计数据.
			
										</p>
			
			
									</div>
			
								</div>
			
							</div>
							<br/>
						</div>

					</div>

					<div class="span6" id="ryfb">

						<div class="portlet box blue">

							<div class="portlet-title">

								<div class="caption"><i class="icon-reorder"></i>人员分布</div>
								
								<div class="tools">

								    <a href="javascript:;" class=""></a>

							    </div>
							</div>

							<div class="portlet-body" style="display:none;">

								

							</div>
							
						</div>
							<div id="groupChart" class="chart"></div>
							
							<div class="row-fluid" id="groupNotFound" style="display:none;">

								<div class="span12 page-404">
			
									<div class="number">
			
										暂无数据
			
									</div>
			
									<div class="details">
			
										<h3>您好, 暂未发现分组数据.</h3>
			
										<p>
			
											系统无法查出当天的分组数据.<br />
			
											<a href="#">联系管理员</a>确认当天是否有分组数据.
			
										</p>
			
			
									</div>
			
								</div>
			
							</div>
						<br/>
					</div>
					
					<div class="row-fluid" id="schoolBusAbnormalDetail" style="display:none;">	
					
					<div class="span12">
						
						<div class="portlet box green">

							<div class="portlet-title">

								<div class="caption"><i class="icon-reorder"></i>(<span id="itemName" style="color:red;"></span>)校车异常人员详情</div>

							</div>

							<div class="portlet-body">

								<table class="table table-bordered table-hover table-full-width">
		
									<thead>
			
										<tr>
			
											<th>姓名</th>
			
											<th>年级</th>
			
											<th>班级</th>
														
											<th>状态</th>
											
											<th>记录点</th>
											
											<th>打卡时间</th>
											
										</tr>
					
									</thead>
									
									<tbody id="tbody">
									
									</tbody>
								
								</table>

							</div>

						</div>
						
					
					</div>
				
				</div>

				</div>

			</div>

			<!-- BEGIN PAGE CONTAINER-->     

		</div>

		<!-- END PAGE --> 

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

	<script src="../media/js/jquery.flot.js"></script>

	<script src="../media/js/jquery.flot.resize.js"></script>

	<script src="../media/js/jquery.flot.pie.js"></script>

	<script src="../media/js/jquery.flot.stack.js"></script>

	<script src="../media/js/jquery.flot.crosshair.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->


	<script src="../media/js/charts.js"></script>   
	
	<script type="text/javascript" src="../media/js/My97DatePicker/WdatePicker.js"></script>  
	<script src="../media/js/app.js"></script>

	<script>
		jQuery(document).ready(function() {    
			App.init();
			
			reSetIframeHeight();
			
			//选择第一个tab
			$("#userTab li:first").addClass("active");
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleId = $("ul li.active").find('a').attr("attr2");
			if(roleId == 4)
			{
			   $("#groupNotFound").hide();
			   $("#totalNotFound").show();
			   $("#groupChart").hide();
			   $("#ryfb").hide();
			   document.getElementById("qxtj").className="span12"
			   loadTotalData(null, 1, userId, roleId);
			}else
			{ 
			   loadTotalData(null, 1, userId, roleId);
			   loadGroupData(null, 1, userId, roleId);
			}
			

			//查找全校统计
			$("#search").click(function(){
				$("#schoolBusAbnormalDetail").hide();
				
				var time = $("#time").val();
				var type = $("#type").val();
				
				if(roleId == 4)
			   {
			      $("#groupNotFound").hide();
			      $("#groupChart").hide();
			      $("#ryfb").hide();
			      document.getElementById("qxtj").className="span12"
			      loadTotalData(time, type, userId, roleId);
			   }else
			   { 
			     loadTotalData(time, type, userId, roleId);
				 loadGroupData(time, type, userId, roleId);
			   }
			});
		});

		//加载总数据
		function loadTotalData(time, type, userId, roleId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/loadTotalData.do",
				data:{
					time : time,
					userId : userId,
					roleId : roleId,
					type : type	
				},
				success: function(data){
					var total = eval("(" + data + ")");

					//未查询到统计数据
					if (null == total)
					{
						$("#totalChart").hide();
						$("#groupNotFound").show();
						$("#totalNotFound").show();
					}
					else
					{
						$("#totalNotFound").hide();
						$("#totalChart").show();
					}
					
					var studentSum = total.studentSum;
					var studentAbnormal = total.studentAbnormal;
					var studentNormal = studentSum - studentAbnormal;

					//初始化当天时间
					if (null == time)
					{
						$("#time").val(total.timeStamp);
					}
					
					var data = [];
					//未正常刷卡学生数量
		            data[0] = {
		           		label: "未刷卡 " + studentAbnormal + "人",
		                data: studentAbnormal
		            };
		            //正常刷卡学生数量
					data[1] = {
		           		label: "已刷卡 " + studentNormal + "人",
		                data: studentNormal
		            };
					if(roleId==4)
					{
		              // DEFAULT
					   $.plot($("#totalChart"), data, {
		            	  series: {
			                  pie: {
			                    show: true,
			                   },
			              },
			              grid: {
			                hoverable: true,
			                clickable: true
			              }
		               });
		            
					  $("#totalChart").bind("plotclick", pieClick);
		            }else
		            {
		              // DEFAULT
		              $.plot($("#totalChart"), data, {
			            series: {
			                pie: {
			                    show: true,
			                    radius: 1,
		                        label: {
		                            show: true,
		                            radius: 1,
		                            formatter: function (label, series) {
		                                return '<div style="font-size:8pt;text-align:center;padding:2px;color:black;">' + label + '<br/>' + Math.round(series.percent) + '%</div>';
		                            },
		                            background: {
		                                opacity: 0.8
		                            }
		                        }
			                }
			            }
		            });
		          }  
				},
			});
		}

		//加载分组数据
		function loadGroupData(time, type, userId, roleId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/loadGroupData.do",
				data:{
					time : time,
					userId : userId,
					roleId : roleId,
					type : type		
				},
				success: function(data){
					var groupList = eval("(" + data + ")");
					if (groupList.length == 0)
					{
						$("#groupChart").hide();
						$("#groupNotFound").show();
					}
					else
					{
						$("#groupNotFound").hide();
						$("#groupChart").show();
					}

					
					var data = [];

					$.each(groupList, function(n, value) {

						data[n] = {
							label : value.itemName,
			                data : value.studentAbnormal,
						};	 
          			}); 
					
		            // DEFAULT
					$.plot($("#groupChart"), data, {
		            	series: {
			                pie: {
			                    show: true,
			                },
			            },
			            grid: {
			                hoverable: true,
			                clickable: true
			            }
		            });

					$("#groupChart").bind("plotclick", pieClick);
				},
			});
		}
		

		function pieClick(event, pos, obj) 
		{
            if (!obj)
            {
            	return;
            }
			$("#schoolBusAbnormalDetail").show();
			var gradeName = obj.series.label;
			 
			if (gradeName.indexOf("已刷卡") > -1)
            { 
                $("#schoolBusAbnormalDetail").hide();
            	return;
            }
			$("#itemName").html(gradeName);

			var time = $("#time").val();
			var type = $("#type").val();
			var roleId = $("ul li.active").find('a').attr("attr2");
			var userId = $("ul li.active").find('a').attr("attr1");
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/loadDetailData.do",
				data:{
					gradeName : gradeName,
					time : time,
					userId : userId,
					roleId : roleId,
					type : type
				},
				success: function(data){
					var detailList = eval("(" + data + ")");
					var appendHtml = '';
					$.each(detailList, function(n, value) {
						appendHtml += '<tr>';
           				appendHtml += '<td width="15%">' + value.userName + '</td>';
            			appendHtml += '<td width="15%">' + value.gradeName + '</td>';
            			appendHtml += '<td width="15%">' + value.clazzName + '</td>';
            			var type = parseInt(value.type);
           				switch(type)
           				{ 
           					case 1 : 
           						appendHtml += '<td width="15%">上校车</td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td width="15%">下校车 </td>';
           						break; 
           					default : 
           						appendHtml += '<td width="15%"> 其他 </td>';
           						break;
           				} 
            			appendHtml += '<td width="15%">' + value.positionName + '</td>';
            			appendHtml += '<td width="25%">' + value.positionTime + '</td>';
           				appendHtml += '</tr>';
          			}); 
          			
					$("#tbody").html(appendHtml);
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
		            iframe.height = height + 100;
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
	</script>
	
	

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>