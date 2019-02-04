<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>老师评价详情</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	 <link href="<%=basePath %>assets/pages/css/profile-2.min.css" rel="stylesheet" type="text/css" />       
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
		<input class="themes" type="hidden" value="<%=ThemePath%>">
	    <!-- 公共顶部开始-->
	    <%@ include file="/public_module/public_header.jsp"%>    
	    <!--公共顶部结束-->
	    <div class="clearfix"> </div>
	    <!-- 内容页开始 -->
	    <div class="page-container">
	        <!--主菜单开始-->
	        <%@include file="/public_module/public_menu.jsp"%>
	        <!--主菜单结束-->
	        <div class="page-content-wrapper">
	            <div class="page-content m_overflow_hidden m_page_content">
	            	<!-- 页面内容开始 -->
	            	<div class="col-md-12 col-sm-12 m_page_con">
	                <div class="page-bar m_margin_0_0_0_0">
	                    <ul class="page-breadcrumb">
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">幼儿园评价</a><i class="fa fa-circle"></i></li>
	                        <li><span>老师评价详情</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">老师评价详情</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="<%=basePath%>student/getStudentList.do" class="form-horizontal" method="post" style="margin: 5px">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择类型：</span>
	                                <select class="form-control m_select" id="evaluateKindergartenList"></select>
	                         	</div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>老师评价详情</div>
	                            </div>
	                            <div class="portlet-body m_overflow_hidden">
	                                <div class="col-md-6 col-sm-6 col-lg-5">
				                    	<div class="col-md-12 col-sm-12 profile">
				                    	<h4 class="m_padding_10_0">学生信息</h4>
				                    	<ul class="list-unstyled profile-nav">
			                                <li>
			                                    <img src="<%=basePath%>assets/global/img/m_img/Photo1.jpg">
			                                </li>
			                                <li>
			                                    <a href="javascript:;"><strang>姓名：</strang>${student.realName }</a>
			                                </li>
			                                <li>
			                                    <a href="javascript:;"><strang>班级：</strang>${clazzName }
			                                    </a>
			                                </li>
											<input id="studentId" value="${student.userId }"  style="display: none"/> 
			                            </ul>
										</div>
				                    </div>
				                    <div class="col-md-6 col-sm-6 col-lg-7">
					                    <div class="row_m">
											<em class="tiwen"></em>
											<div class="portlet-body">
												<h4 class="block">思想品德</h4>
												<div class="alert alert-success">
													<p>
														<i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
													</p>
													<textarea id="conductText" class="form-control" rows="3" cols="" disabled="disabled"></textarea>
												</div>
												<h4 class="block">活泼度</h4>
												<div class="alert alert-success">
													<p>
														<i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
													</p>
													<textarea id="sportText" class="form-control"  rows="3" cols=""disabled="disabled"></textarea>
													</div>
												<h4 class="block">学习认识力</h4>
												<div class="alert alert-success">
													<p>
														<i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
													</p>
													<textarea id="studyText" class="form-control" rows="3" cols=""  disabled="disabled"></textarea>
													</div>
												<h4 class="block">生活自理力</h4>
												<div class="alert alert-success">
													<p>
														<i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
													</p>
													<textarea id="lifeText" class="form-control"  rows="3" cols=""  disabled="disabled"></textarea>
												</div>
												<button type="button" class="btn green" id="back" onclick="history.go(-1);" style="margin-left: 45%;">返回</button>
												</div>
											</div>
											</div>
					                    </div>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                        <!-- 分页开始 -->
	                        <%@include file="/public_module/public_page.jsp" %>
	                        <!-- 分页结束 -->
	                    </div>
	                </div>
	                </div>
	                <!--页面内容结束 -->
	            </div>
	        </div>
	        <!-- 亦信聊天开始 -->
	    	<%@ include file="/public_module/public_QQ.jsp" %>
	        <!-- 亦信聊天结束 -->
	    </div>
	    <!-- 内容页结束 -->
	    <!-- 底部开始 -->
	    <%@ include file="/public_module/public_footer.jsp" %>
	    <!-- 底部结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function(){
			loadSubMenu("evaluateKindergarten"); 
			//选取当前菜单位置
			setActive("evaluateKindergarten","evaluateList");      
			var studentId = $("#studentId").val();
			loadEvaluateKindergartenList(studentId);

			var evaluateId = $("#evaluateKindergartenList").val();
			loadEvaluateKindergarten(evaluateId,studentId);
			
			//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#evaluateKindergartenList").change(function(){
				var evaluateId = $(this).val();
				var studentId = $("#studentId").val();
				loadEvaluateKindergarten(evaluateId,studentId);
			});	
		});

		// 加载该同学所有的最近评价列表
		function loadEvaluateKindergarten(evaluateId,studentId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>evaluateKindergarten/loadEvaluateKindergartenByEvaluateId.do",
				data:{
					evaluateId : evaluateId,
					studentId : studentId
					},
				success: function(data){
					var evaluateKindergarten = eval("(" + data + ")");
					$("#conductStar").val(evaluateKindergarten.conductStar);
					$("#sportStar").val(evaluateKindergarten.sportStar);
					$("#studyStar").val(evaluateKindergarten.studyStar);
					$("#lifeStar").val(evaluateKindergarten.lifeStar);
					$("#conductText").html(evaluateKindergarten.conduct);
					$("#sportText").html(evaluateKindergarten.sport);
					$("#studyText").html(evaluateKindergarten.study);
					$("#lifeText").html(evaluateKindergarten.life);

					//初始化星级数
					var conductStar = $("#conductStar").val();
					$("#conduct").find("i").css({"color":"#dbdbdb"});
					$("#conduct").find("i:lt("+ conductStar +")").css({"color":"#f96767"});

					$("#sport").find("i").css({"color":"#dbdbdb"});
					var sportStar = $("#sportStar").val();
					$("#sport").find("i:lt("+ sportStar +")").css({"color":"#f96767"});

					$("#study").find("i").css({"color":"#dbdbdb"});
					var studyStar = $("#studyStar").val();
					$("#study").find("i:lt("+ studyStar +")").css({"color":"#f96767"});

					$("#life").find("i").css({"color":"#dbdbdb"});
					var lifeStar = $("#lifeStar").val();
					$("#life").find("i:lt("+ lifeStar +")").css({"color":"#f96767"});
				},
			});
		}
		
		// 加载该同学所有的评价列表
		function loadEvaluateKindergartenList(studentId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>evaluateKindergarten/loadEvaluateKindergartenListByStudentId.do",
				data:{
					studentId : studentId
					},
				success: function(data){
					var evaluateKindergartenList = eval("(" + data + ")");
					
					var appendHtml = '<option value="0" selected="selected">---请选择---</option>';
					$.each(evaluateKindergartenList, function(n, value) {
						appendHtml += '<option value="' + value.id + '">' + value.createTime + '</option>';
           			});  
					 
           			$("#evaluateKindergartenList").html(appendHtml);
           			$("#evaluateKindergartenList").change();
				},
			});
		}
	</script>
</html>