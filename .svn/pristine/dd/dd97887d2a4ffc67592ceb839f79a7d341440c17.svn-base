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
<link href="<%=basePath %>media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath %>media/css/bootstrap-responsive.min.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath %>media/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath %>media/css/style-metro.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath %>media/css/style.css" rel="stylesheet" type="text/css" />

<link href="<%=basePath %>media/css/style-responsive.css" rel="stylesheet"
	type="text/css" />

<!-- <link href="../media/css/default.css" rel="stylesheet" type="text/css"
	id="style_color" /> -->

<link href="<%=basePath %>media/css/uniform.default.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath %>media/css/skin.css" rel="stylesheet" type="text/css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link href="<%=basePath %>media/css/pricing-tables.css" rel="stylesheet"
	type="text/css" />

<!-- END PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css"
	href="<%=basePath %>media/css/select2_metro.css" />

<link rel="stylesheet" href="<%=basePath %>media/css/DT_bootstrap.css" />

	<link href="<%=basePath %>media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
<!-- END PAGE LEVEL STYLES -->

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">


		<div class="container-fluid">

			<!-- BEGIN PAGE HEADER-->

			<div class="row-fluid">

				<div class="span12">

					<!-- BEGIN PAGE TITLE & BREADCRUMB-->
					<ul class="breadcrumb">

						<li><i class="icon-home"></i> <a href="#">首页</a> <i
							class="icon-angle-right"></i></li>

						<li><a href="#">套餐</a> <i class="icon-angle-right"></i></li>

					</ul>

					

				</div>

			</div>

			<div class="row-fluid">

				<div class="span12">

					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- 动态加载tab页 -->

					<div class="portlet box breadcrumb">

						<div class="portlet-title">

							<div class="caption jur_actions_color_666">
							短信套餐
							</div>

						</div>



						<div class="portlet-body form">
							<form class="form-horizontal" action="#">
								<div class="sms_server">
									<div class="server_img">
									
									<img src="<%=basePath %>media/image_m/sms_server.png">
									</div>
									
									<div class="server_info">
										<p><span>价格：</span>50元</p>
										<p><span>产品：</span>短信学期包</p>
										<p><span>时间范围：</span>2016年03月01日-2016年07月01日</p>
										<input type="submit" value="立即购买">
									</div>
								</div>
							
							</form>

						</div>

					</div>

					<!-- END EXAMPLE TABLE PORTLET-->

				</div>

			</div>
			<!-- END PAGE CONTENT-->

		</div>

	<script src="../media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="../media/js/jquery-ui-1.10.1.custom.min.js"
		type="text/javascript"></script>

	<script src="../media/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../media/js/jquery.slimscroll.min.js"
		type="text/javascript"></script>

	<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.uniform.min.js" type="text/javascript"></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript" src="../media/js/jquery.gritter.js"></script>

	<script type="text/javascript" src="../media/js/jquery.pulsate.min.js"></script>

	<script type="text/javascript" src="../media/js/jquery.bootpag.min.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->


	<script src="../media/js/ui-general.js"></script>
	<script type="text/javascript" src="../media/js_m/public_js.js"></script> 
	<script src="../media/js/app.js"></script>
	<script>

		jQuery(document).ready(function() {       
		   // initiate layout and plugins
		   App.init();

		   var teacherId = $("#teacherId").val();
		   //加载已有的权限
		   loadHavePermission(teacherId)
		   //加载未有的权限
		   loadNotHavePermission(teacherId)

		 //加载基础数据
		  loadTeacherDetailForModify();
		  
		   //修改权限
		   $("#have_permission li").live("click",function(){
			   var _this=$(this);
			   var permissionCode=_this.attr("id");
			   $("#permissionCode").val(permissionCode);
			   
			   if(_this.hasClass("select")){
				   _this.removeClass("select");
				   $(".jur_Yes_none").hide();
			   }else{
				   _this.addClass("select");
				   $(".jur_Yes_none").show();
				   $("#selectDepartmentOrClazzHave").val("0");
				   $("#have_operation li").remove();
				   _this.siblings().removeClass("select");
			   }
		   })
		   
		   $("#have_operation li").live("click",function(){
			   
			   var _this=$(this);
			   if(_this.hasClass("select")){
				   _this.removeClass("select");
			   }else{
				   _this.addClass("select");
			   }
		   })
		   
		   $("#update_jur1").on("click",function(){

			   var _this=$("#have_operation li").not(".select");
			   var _select_num=new Array();
		   	      _select_num=_this;
			   var add_num=_this.size();
			   var ids = null;
			   if(add_num>0){
				   for(var i=0;i<_select_num.length;i++){
					   if(i==0)
					   {
						   ids =  _select_num[i].id;
						}else{
							ids += ","+_select_num[i].id;
						}
					   
				   }
			   }else{
				   alert("亲，您没有修改权限哦");
				   return;
			   }
			   

               var _this=$("#have_permission li.select");
			   
			   var permissionCode=_this.attr("id");

			   var del_text=_this.text();
			   var add_text="<li id="+permissionCode+">"+del_text+"</li>";
			   var teacherId = $("#teacherId").val();
			   
			   $.ajax({
					type: "POST",
					url: "<%=basePath%>permission/modifyPermission.do",
				 	processData:true,
				 	data:{
				 		teacherId : teacherId,
				 		permissionCode : permissionCode,
				 		ids : ids
					},
				 	success: function(data){
				 		alert("\""+del_text+"\"权限修改成功");
				 	}
				});
			   
		   })
		   //添加权限
		   $("#not_have_permission li").live("click",function(){
			   var _this=$(this);
			   if(_this.hasClass("select")){
				   _this.removeClass("select");
				   $(".jur_No_none").hide();
			   }else{
				   _this.addClass("select");
				   _this.siblings().removeClass("select");
				   $(".jur_No_none").show();
				   $("#selectDepartmentOrClazzNotHave").val("0");
				   $("#not_have_operation li").remove();
			   }
		   })
		   
		   $("#not_have_operation li").live("click",function(){
			   
			   var _this=$(this);
			   if(_this.hasClass("select")){
				   _this.removeClass("select");
			   }else{
				   _this.addClass("select");
			   }
		   })
		   
		   $("#jur_add").live("click",function(){
			   var _this=$("#not_have_operation li.select");
			   var _select_num=new Array();
			   	   _select_num=_this;
			   var add_num=_this.size();
			   var ids = null;
			   if(add_num>0){
				   for(var i=0;i<_select_num.length;i++){
					   if(i==0)
					   {
						   ids =  _select_num[i].id;
						}else{
							ids += ","+_select_num[i].id;
						}
					   
				   }
			   }else{
				   alert("您还没有选择权限");
				   return;
			   }
			   
			   var _this=$("#not_have_permission li.select");
			   
			   var permissionCode=_this.attr("id");

			   var del_text=_this.text();
			   var add_text="<li id="+permissionCode+">"+del_text+"</li>";
			   $(add_text).appendTo($("#have_permission"));
			   $("#not_have_permission li.select").remove();
			   $(".jur_No_none").hide();

			   var teacherId = $("#teacherId").val();
			   
			   $.ajax({
					type: "POST",
					url: "<%=basePath%>permission/addPermission.do",
				 	processData:true,
				 	data:{
				 		teacherId : teacherId,
				 		permissionCode : permissionCode,
				 		ids : ids
					},
				 	success: function(data){
				 		alert("\""+del_text+"\"权限添加成功");
				 	}
				});
			  
		   })
		  
		   //删除权限
		   $("#jur_delect").live("click",function(){
			   
			   var permissionCode=$("#have_permission li.select").attr("id");
			   
			   var del_text=$("#have_permission li.select").text();
			   var add_text="<li id="+permissionCode+">"+del_text+"</li>";
			   $(add_text).appendTo($("#not_have_permission"));
			   
			   $("#have_permission li.select").remove();
			   $(".jur_Yes_none").hide();

			   var teacherId = $("#teacherId").val();
			   
			   $.ajax({
					type: "POST",
					url: "<%=basePath%>permission/deletePermission.do",
				 	processData:true,
				 	data:{
				 		teacherId : teacherId,
				 		permissionCode : permissionCode
					},
				 	success: function(data){
				 		alert("\""+del_text+"\"权限删除成功");
				 	}
				});
		   })

		   //初始化选择框（已拥有）
			$("#selectDepartmentOrClazzHave").change(function(){
				//类型 部门 班级
				var type = $(this).val();

				var permissionCode = $("#permissionCode").val();

				var teacherId = $("#teacherId").val();

				 
				//type  1 表示部门   2表示班级
				if (type == 1)
				{
					$.ajax({
						type: "POST",
						url: "<%=basePath%>depart/getDepartmentList.do",
					 	processData:true,
					 	success: function(data){
					 		var departmentList = eval("(" + data + ")");
	
							var appendHtml = '';

							$.each(departmentList, function(n, value) {
								  
								appendHtml += '<li id="D' + value.id + '" class="select">' + value.departmentName + '</li>';
		           			}); 
		           			
							$("#have_operation").html(appendHtml);
							  $.ajax({
									type: "POST",
									url: "<%=basePath%>permission/loadClazzIdAndDepartIdByPermissionCodeAndUserId.do",
								 	processData:true,
								 	data:{
								 		teacherId : teacherId,
								 		permissionCode : permissionCode
									},
								 	success: function(data){
								 		var list = eval("(" + data + ")");
										$.each(list, function(n, value) {
			                                var departmentId = value.optDepartId
			                                
			                                if (typeof(departmentId) == "undefined" || departmentId == "undefined")
			                                {
			                                }else
			                                {
			                                	 departmentId = "D"+departmentId;
			                                	 $("#"+departmentId).removeClass("select");
			                                }    
					           			}); 
					           			
								 	}
								});
					 	}
					});
				}
				else if (type == 2)
				{

					$.ajax({
						type: "POST",
						url: "<%=basePath%>baseData/loadClazzList.do",
					 	processData:true,
					 	success: function(data){
					 		var departmentList = eval("(" + data + ")");
							var appendHtml = '';
							$.each(departmentList, function(n, value) {
								appendHtml += '<li id="C' + value.id + '" class="select">' + value.clazzName + '</li>';
		           			}); 
							$("#have_operation").html(appendHtml);
							$.ajax({
								type: "POST",
								url: "<%=basePath%>permission/loadClazzIdAndDepartIdByPermissionCodeAndUserId.do",
							 	processData:true,
							 	data:{
							 		teacherId : teacherId,
							 		permissionCode : permissionCode
								},
							 	success: function(data){
							 		var list = eval("(" + data + ")");
									$.each(list, function(n, value) {
		                                var clazzId = value.optClazzId
		                                if (typeof(clazzId) == "undefined" || clazzId == "undefined")
		                                {
		                                }else
		                                {
		                                	clazzId = "C"+clazzId;
		                                	 $("#"+clazzId).removeClass("select");
		                                }    
		                                
				           			}); 
				           			
							 	}
							});	
					 	}
					});
						
				}else 
				{
					$("#have_operation li").remove();
				}
			});

		   //初始化选择框(未拥有)
			$("#selectDepartmentOrClazzNotHave").change(function(){
				//类型 部门 班级
				var type = $(this).val();
				//type  1 表示部门   2表示班级
				if (type == 1)
				{
					$.ajax({
						type: "POST",
						url: "<%=basePath%>depart/getDepartmentList.do",
					 	processData:true,
					 	success: function(data){
					 		var departmentList = eval("(" + data + ")");
	
							var appendHtml = '';

							$.each(departmentList, function(n, value) {
								appendHtml += '<li id="D' + value.id + '" >' + value.departmentName + '</li>';
		           			}); 
		           			
							  $("#not_have_operation").html(appendHtml)
					 	}
					});
				}
				else if (type == 2)
				{

					$.ajax({
						type: "POST",
						url: "<%=basePath%>baseData/loadClazzList.do",
					 	processData:true,
					 	success: function(data){
					 		var departmentList = eval("(" + data + ")");
	
							var appendHtml = '';

							$.each(departmentList, function(n, value) {
								appendHtml += '<li id="C' + value.id + '">' + value.clazzName + '</li>';
		           			}); 
		           			
							$("#not_have_operation").html(appendHtml)
					 	}
					});			
				}
				else 
				{
					$("#not_have_operation li").remove();
				}
			});
		   
		});


		//加载教师详细信息
		function loadTeacherDetailForModify()
		{
			var teacherId = $("#teacherId").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>permission/getTeacherByIdForModifyPermission.do",
				data:{
					teacherId : teacherId
				},
				success: function(data)
				{
					
					var teacher = eval("(" + data + ")");
					$("#code").val(teacher.code);
					$("#realName").val(teacher.realName);

				},
			});
		}

		//加载已有的权限
		function loadHavePermission(teacherId)
		{
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>permission/getHavePermissionById.do",
				data:{
					    teacherId : teacherId
					},
				success: function(data){
					var permissionList = eval("(" + data + ")");

					var appendHtml_li='';
           			$.each(permissionList, function(n, value) {
           			    //select页面
						appendHtml_li += '<li id="' + value.permissionCode + '">' + value.permissionName + '</li>';
           			}); 

           			//初始化待选框
					$("#have_permission").html(appendHtml_li);
				},
			});

		}
		
		//加载未有的权限
		function loadNotHavePermission(teacherId)
		{
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>permission/getNotHavePermissionById.do",
						data : {
							teacherId : teacherId
						},
						success : function(data) {
							var permissionList = eval("(" + data + ")");

							var appendHtml_li = '';
							$
									.each(
											permissionList,
											function(n, value) {
												//select页面
												appendHtml_li += '<li id="' + value.permissionCode + '">'
														+ value.permissionName
														+ '</li>';
											});

							//初始化待选框
							$("#not_have_permission").html(appendHtml_li);
						},
					});

		}
	</script>

	<!-- END JAVASCRIPTS -->

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