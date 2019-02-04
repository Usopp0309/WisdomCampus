<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<meta charset="utf-8" />

	<title>添加教室</title>

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
	<link href="../media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />

	<link rel="shortcut icon" href="../media/image/favicon.ico" />

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

							<li>

								<i class="icon-home"></i>

								<a href="#">首页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li>
								<a href="#">电子课程表管理</a>
								<i class="icon-angle-right"></i>
							</li>
							
							<li>
								<a href="#">教室管理</a>
							</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->
				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">

					<div class="span12">

						<!-- BEGIN EXAMPLE TABLE PORTLET-->

						<div class="portlet box green">

							<div class="portlet-title">

								<div class="caption">添加</div>
								
							</div>
							
							<div class="portlet-body form">
							
								<form action="<%=basePath%>classroom/toSaveClassroom.do" id="submitForm" class="form-horizontal" method="post" >
									
									<div class="control-group" id="nameGroup">

										<label class="control-label">教室名称:</label>
	
										<div class="controls">
											
											<input type="text" size="16" name="name"  id="name"  class="m-wrap span6"/>
													
											<span class="help-block" style="display: none;" id="nameHelp"></span>
													
										</div>
	
									</div>
										

									<div class="form-actions">
										<button type="button" id="submitButton" class="btn green" id="submitButton">保存</button>
										<button type="button" class="btn" id="cancel">返回</button>
									</div>
									
								</form>
							</div>
						</div>

						<!-- END EXAMPLE TABLE PORTLET-->

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
	
	<script type="text/javascript" src="../media/js/My97DatePicker/WdatePicker.js"></script>       
	<script type="text/javascript" src="../media/js_m/public_js.js"></script>
	<script src="../media/js/app.js"></script>
	<script>

		$(function() {  
           
			

            //表单验证
            $("#name").blur(function(){
                var name = $("#name").val();
                var nameMesage = "教室名称不能为空";
                if("" == name)
                {
                    $("#nameGroup").addClass("error");
                    $("#nameHelp").show();
		            $("#nameHelp").html(nameMesage);
                   
                }
                else if(checkName(name))
                {
					$("#nameGroup").addClass("error");
					$("#nameHelp").show();
					$("#nameHelp").html("教室名称已存在");
				}
				else
				{
					$("#nameGroup").removeClass("error");
					$("#nameHelp").hide();
				}
               
            });
            
			//表单提交
			$("#submitButton").click(function()
			{
			    if(checkForm())
				{
				    $("#submitForm").submit();
				}
			
			});	
			
		});
		
		
		//表单校验相关---begin
		
		function checkForm()
		{
			 //验证常量 
            var flagName = false;
		
			//教室名称
			var name = $("#name").val();
			
			//未输入部门编号
			if ("" == name)
			{
				$("#nameGroup").addClass("error");
                $("#nameHelp").show();
	            $("#nameHelp").html("教室名称不能为空");
			
				flagCode = false;
			}
			else if (checkName(name))
			{
				$("#nameGroup").addClass("error");
				$("#nameHelp").show();
				$("#nameHelp").html("教室名称已存在");
				
				flagName = false;
			}
			else
			{
				$("#nameGroup").removeClass("error");
				$("#nameHelp").hide();
				
				flagName = true;
			}
			
			if (flagName)
			{
				return true;
			}	
			else
			{
				return false;
			}
		
		}

		
		function checkName(name)
		{
			
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					name : name
				},
				url: "<%=basePath%>classroom/checkClassroom.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//名称存在
					if ("success" == result.resultCode)
					{
						flag = true;
					}
					else
					{
						flag = false;
					}
					
				},
			});
			
			return flag;
		}
		
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>