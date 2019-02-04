<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>添加老师评价</title>
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
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">幼儿园评价</a><i class="fa fa-circle"></i></li>
	                        <li><span>添加老师评价</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">添加老师评价</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                        <!-- 页面搜索开始 -->
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>添加老师评价</div>
	                            </div>
	                            <div class="portlet-body m_overflow_hidden">
	                            <form action="<%=basePath %>evaluateKindergarten/doAddEvaluation.do" method="post" id="submitForm">
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
													<input id="clazzId" name="clazzId" value="${student.clazzId }" style="display: none"/>
													<input id="studentId" name="studentId" value="${student.userId }" style="display: none"/> 
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
													<textarea id="conductText" name="conductText" class="form-control" rows="3" cols="" placeholder="输入评价内容..."></textarea>
												</div>
												<h4 class="block">活泼度</h4>
												<div class="alert alert-success">
													<p>
														<i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
													</p>
													<textarea id="sportText" name="sportText" class="form-control"  rows="3" cols="" placeholder="输入评价内容..."></textarea>
													</div>
												<h4 class="block">学习认识力</h4>
												<div class="alert alert-success">
													<p>
														<i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
													</p>
													<textarea id="studyText"  name="studyText" class="form-control" rows="3" cols="" placeholder="输入评价内容..."></textarea>
													</div>
												<h4 class="block">生活自理力</h4>
												<div class="alert alert-success">
													<p>
														<i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
													</p>
													<textarea id="lifeText" name="lifeText" class="form-control"  rows="3" cols="" placeholder="输入评价内容..."></textarea>
												</div>
												<button type="button" class="btn green" id="back" onclick="submitForm();" style="margin-left: 45%;">确定</button>
												<button type="button" class="btn green" id="back" onclick="history.go(-1);" style="margin-left: 45%;">返回</button>
												</div>
											</div>
											</div>
										</form>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
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
	<script type="text/javascript">

		$(function() {
			loadSubMenu("evaluateKindergarten"); 
			//选取当前菜单位置
			setActive("evaluateKindergarten","evaluateList");   
			var studentId = $("#studentId").val();
			
			$("#save").on("click",function(){
				var conductText = $("#conductText").val().trim();
				var sportText = $("#sportText").val().trim();
				var studyText = $("#studyText").val().trim();
				var lifeText = $("#lifeText").val().trim();
				if(conductText == '' || sportText == '' || studyText == '' || lifeText == ''){
					alert("请完全输入评价内容!");
				}else{
					submitForm();
				}
				
			});

			$(".num i").on("click",function(){
				var eq_id=$(this).index()+1;
				var _this=$(this).parent();
				_this.find("i").removeAttr("style");
				_this.find("i:lt("+ eq_id +")").css({"color":"#f96767"});
				var id = _this.prev().attr("id");
				$("#"+id).val(eq_id);
			});
		});

		function submitForm(){
			if (confirm("您确认要提交评价吗？")){
				$("#submitForm").submit();
			}
		}
	</script>
</html>