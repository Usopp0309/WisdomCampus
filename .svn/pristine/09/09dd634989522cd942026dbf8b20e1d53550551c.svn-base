<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>成长档案-模板</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->      
 	<style type="text/css">
 		.template .template_li{border:2px solid #fff;cursor: pointer;}
 		.template .template_li img{max-width:100%;}
 		.template .template_li p{padding:10px 0;text-align: center;}
 	</style>  
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
	                        <li><a href="">电子动力成长档案</a><i class="fa fa-circle"></i></li>
	                        <li><span>成长档案-模板</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">成长档案-模板</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'classLeader' ||  roleList.roleCode eq 'parent'}">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
											</li>
										</c:if>
									</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>成长档案-模板</div>
	                            </div>
	                            <div class="portlet-body template">
	                                <c:forEach items="${templateList }" var="template" varStatus="sta">
	                                	<c:if test="${(sta.index==0)||(sta.index%4==0&&n>=4)}">
	                                		<div class="row">
	                                	</c:if>
											<div class="col-md-3 col-sm-3" index="${template.id }" ><div class="template_li"><img src='<%=basePath %>media/Template/${template.path }/01.png' /><p>${template.name }</p></div></div>
										<c:if test="${sta.index==3|| (((sta.index+1)%4==0)&&((sta.index+1)>4))}">
											</div>
										</c:if>
									</c:forEach>
	                            </div>
									<input type="button"  class="btn btn-md green m_margin_15_auto_0 m_display_block" value="应用" onclick="saveTemplate()">
									<input type="hidden" id="userId" value="${userId }">
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
	<script>
		$(function(){ 
			loadSubMenu("growthArchives"); 
			//选取当前菜单位置
			setActive("growthArchives","growth");    
			$(".template_li").on("click",function(){
					$(".template_li").removeAttr("style");
					$(this).css({"border":"2px solid #e7505a"});
			})
		})
	</script>
</html>