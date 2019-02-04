<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>校园一卡通信息总览</title>
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
	                <%@include file="/public_module/public_config.jsp" %>
	                    <ul class="page-breadcrumb">
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">校园一卡通</a><i class="fa fa-circle"></i></li>
	                        <li><span>校园一卡通信息总览</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">校园一卡通信息总览</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
											</li>
								</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">添加账号</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">删除账号</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">添加电子卡</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">删除电子卡</button>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择内容：</span>
                                    <input type="text" placeholder="卡号、姓名……" class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>校园一卡通信息总览</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>卡号</th>
												<th>持卡人</th>
												<th>最近消费金额</th>
												<th>余额</th>
												<th>时间</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="tbody">
	                                       
	                                    </tbody>
	                                </table>
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
	<script type="text/javascript">
		$(function() {    
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
	
			//加载初始化数据   
			loadInformationList(null, userId, roleCode, null);
			
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				
				loadInformationList(null, userId, roleCode, null);

			});
			
			//条件查询
			$("#search").click(function(){

				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				var queryContent = $("#queryContent").val();

				loadInformationList(queryContent, userId, roleCode, null);
				
			});
			
		});
		
		
		

		//加载宿舍异常报警列表
		function loadInformationList(queryContent, userId, roleCode, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>ykt/getYktTotalInformationList.do",
				
				data:{
				        queryContent : queryContent,
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
						appendHtml += '<tr>';
						//持有者
           				appendHtml += '<td>' + value.fCardNo + '</td>';
           				appendHtml += '<td>' + value.fName + '</td>';
           				appendHtml += '<td>' + value.fL_Cons + '</td>';
           				appendHtml += '<td>' + value.fL_Money + '</td>';
           				appendHtml += '<td>' + value.createtime + '</td>';
           				
           				appendHtml += '</tr>';
          			});
          			 
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
				},
			});
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

			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
				
			//短信内容
			var queryContent = $("#queryContent").val();
				
			loadInformationList(queryContent, userId, roleCode, cPageInt);
			
			$("#currentPage").html(cPageInt);
		}

	</script>
</html>