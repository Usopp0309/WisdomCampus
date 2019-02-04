<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>晨检详情</title>
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
	                        <li><a href="">平安校园</a><i class="fa fa-circle"></i></li>
	                        <li><span>晨检详情</span></li>
	                    </ul>
	                </div>
	                <div class="row m_padding_15_0_0_0">
	                    <div class="col-md-6 col-sm-6 col-lg-4">
	                    	<div class="col-md-12 col-sm-12 profile">
	                    	<h4 class="m_padding_10_0">学生信息</h4>
	                    	<ul class="list-unstyled profile-nav">
                                <li>
                                    <img src="<%=Cons.KINDERGARTENINOUTIMAGEBASEPATH%>${schoolId }/headImg/${mc.cardCode}.jpg" class="img-responsive pic-bordered">
                                </li>
                                <li>
                                    <a href="javascript:;"><strang>姓名：</strang>${mc.name }</a>
                                </li>
                                <li>
                                    <a href="javascript:;"><strang>班级：</strang>${mc.clazzName }
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;"><strang>电话：</strang>${mc.parentPhone }</a>
                                </li>
                                <li>
                                    <a href="javascript:;"><strang>班主任：</strang>${mc.leaderName }</a>
                                </li>
                            </ul>
                            <h4 class="m_padding_10_0">晨检老师</h4>
	                    	<ul class="list-unstyled profile-nav">
                                <li>
                                    <img src="<%=Cons.KINDERGARTENINOUTIMAGEBASEPATH%>${schoolId }/headImg/${mc.teacherCardCode}.jpg" class="img-responsive pic-bordered">
                                </li>
                                <li>
                                    <a href="javascript:;"><strang>晨检老师：</strang>${mc.teacherName }</a>
                                </li>
                                <li>
                                    <a href="javascript:;"><strang>电话：</strang>${mc.teacherPhone}</a>
                                </li>
                            </ul>
							</div>
	                    </div>
	                    <div class="col-md-6 col-sm-6 col-lg-8">
	                    <div class="row_m">
							<em class=tiwen></em>
							<div class="portlet-body">
								<h4 class="block">体温</h4>
								<div class="alert alert-success"><strong>正常体温范围值：</strong>36.5度-37.5度  <i>${mc.temperature }度</i></div>
								<h4 class="block">精神</h4>
								<div class="alert alert-success">${mc.spirit }</div>
								<h4 class="block">口腔</h4>
								<div class="alert alert-success">${mc.oralCavity }</div>
								<h4 class="block">形象</h4>
								<div class="alert alert-success">${mc.surface }</div>
							</div>
							</div>
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
</html>
	<script>
		$(function(){
			loadSubMenu("safeSchool"); 
			//选取当前菜单位置
			setActive("safeSchool","morningCheck");  
			$('#startTime').datetimepicker({
				 format:"Y-m-d H:i:s" 
			});
		})
	</script>
</html>