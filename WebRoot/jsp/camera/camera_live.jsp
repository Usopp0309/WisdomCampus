<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>视频列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
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
	                        <li><a href="">视频直播</a><i class="fa fa-circle"></i></li>
	                        <li><span>视频列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">视频列表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>视频列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                            	<div class="row">
	                            		<div class="col-md-6 col-sm-6"><video src="http://richxvideo.b0.upaiyun.com/test.mp4" style="width:100%;" controls="controls" preload="preload"></video></div>
	                            		<div class="col-md-6 col-sm-6">
		                            		<div class="portlet light bordered">
												<div class="portlet-title">
				                                    <div class="caption">
				                                        <i class="icon-share font-dark"></i>
				                                        <span class="caption-subject font-dark bold uppercase">视频直播</span>
				                                    </div>
			                                	</div>
			                                	<div class="portlet-body">
			                                		<div class="row">
				                                		<div class="col-md-6 col-sm-6">
				                                			<img src="">
				                                			<p>1111</p>
				                                		</div>
				                                		<div class="col-md-6 col-sm-6">
				                                			<img src="">
				                                			<p>1111</p>
														</div>
			                                		</div>
			                                		<div class="row">
				                                		<div class="col-md-6 col-sm-6">
				                                			<img src="">
				                                			<p>1111</p>
														</div>
				                                		<div class="col-md-6 col-sm-6">
				                                			<img src="">
				                                			<p>1111</p>
														</div>
			                                		</div>
			                                	</div>
			                                </div>
										</div>
	                            	</div>
	                            	<div class="row">
		                            		<div class="portlet light bordered">
												<div class="portlet-title">
				                                    <div class="caption">
				                                        <i class="icon-share font-dark"></i>
				                                        <span class="caption-subject font-dark bold uppercase">视频分享</span>
				                                    </div>
			                                	</div>
			                                </div>
			                                <div class="portlet-body">
			                                		<div class="row">
				                                		<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
				                                		<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
				                                		<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
				                                		<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
			                                		</div>
			                                		<div class="row">
				                                		<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
				                                		<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
														<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
				                                		<div class="col-md-3 col-sm-3">
															<img src="">
				                                			<p>1111</p>
														</div>
			                                		</div>
			                                	</div>
	                            	</div>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                       <%--  <!-- 分页开始 -->
	                        <%@include file="/public_module/public_page.jsp" %>
	                        <!-- 分页结束 --> --%>
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
		jQuery(document).ready(function() {  
			loadSubMenu("liveCameraManager"); 
			//选取当前菜单位置
			setActive("liveCameraManager","liveCamera");  
			});
	</script>
</html>