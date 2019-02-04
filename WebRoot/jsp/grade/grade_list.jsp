<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>年级管理</title>
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
	                        <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>年级管理</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">年级管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
										<r:right rightCode="gradeManager">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
											</li>
										</r:right>
									</c:if>
								</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
		                        <c:if test="${sessionScope.user.type != 2}">
									<button class="btn btn-default" type="button" id="addGrade">增加</button>
								</c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索年级：</span>
	                         		<input type="text" class="m_input form-control" id="queryContent" placeholder="请输入学年或年级名称查询"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn design_btn" id="search">搜索</button>
									<input type="hidden" id="type" value="${sessionScope.user.type}"/>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>年级管理</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
												<th class="m_width_20">年级名称</th>
	                                            <th class="m_width_20">类型</th>
												<th class="m_width_20">入学年份</th>
												<th class="m_width_25">更新时间</th>
												<c:if test="${sessionScope.user.type != 2}">
													<th class="m_width_15">修改</th>
												</c:if>
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
	<script>
		jQuery(document).ready(function() { 
			loadSubMenu("schoolManager");    
			//选取当前菜单位置
			setActive("schoolManager","gradeManage");  
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			//加载初始化数据
			loadGradeList(userId, roleCode, null);
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadGradeList(userId, roleCode, null);	
			});
			
			//点击增加年级页面
			$("#addGrade").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>grade/toAddGrade.do',{userId:userId,roleCode:roleCode});
			});
				
			//条件查询
			$("#search").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				//查询条件
				loadGradeList(userId, roleCode, null);
			});
			//回车查询
			 $("body").keydown(function(event){
				 if(event.keyCode == "13"){
					$("#search").click();
					return false;
            	}
			});
			
		});
		

		//加载年级页面
		function loadGradeList(userId, roleCode, cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			var queryContent = $.trim($("#queryContent").val());
			$.ajax({
				type: "post",
				url: "<%=basePath%>grade/getGradeList.do",
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
						var type = value.type;
						if(type == '0'){
							appendHtml += '<td>' + value.name + '</td>';
							appendHtml += '<td>幼儿园</td>';
						}else if(type == '1'){
							appendHtml += '<td>' + value.name + '</td>';
							appendHtml += '<td>小学</td>';
						}else if(type == '2'){
							appendHtml += '<td>' + value.name + '</td>';
							appendHtml += '<td>初中</td>';
						}else if(type == '3'){
							appendHtml += '<td>' + value.name+ '</td>';
							appendHtml += '<td>高中</td>';
						}
            			appendHtml += '<td>' + value.createYear + '</td>';
            			var time = value.updateTime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
            			appendHtml += '<td>' + time + '</td>';
						if($("#type").val() != '2'){
            				appendHtml += '<td class="Response"><a href="javascript:;"  onclick="modifyGrade(' + value.id + ')" class="btn btn-sm update_btn">修改</a></td>';
						}
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		//点击修改年级权限页面
		function modifyGrade(gradeId){
			var userId = $("ul li.active").find('a').attr("attr1");	
			var roleCode = $("ul li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>grade/toModifyGrade.do',{roleCode:roleCode,gradeId:gradeId});
		};

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

			//用户ID
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
			loadGradeList(userId, roleCode, cPageInt);
			$("#currentPage").html(cPageInt);
		}
	</script>
</html>