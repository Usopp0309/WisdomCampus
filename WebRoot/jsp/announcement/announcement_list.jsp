<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>公告展示</title>
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
	                        <li><a href="<%=basePath %>announcement/toAnnouncementList.do">信息中心</a><i class="fa fa-circle"></i></li>
	                        <li><span>公告展示</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">公告展示</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
								</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<c:if test="${sessionScope.user.type != 2}">
									<r:right rightCode="announcementAdd">
										<button class="btn btn-default" type="button" id="addAnnouncement">发布</button>
									</r:right>
								</c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择类型：</span>
                                    	<select class="form-control m_select" id="announcementSelect">
											<option value="0" selected="selected">最新公告</option>
											<option value="1">学校公告</option>
											<option value="2">部门公告</option>
											<option value="3">班级公告</option>
											<option value="4">系统公告</option>
										</select>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>公告展示</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_60">公告内容</th>
												<th class="m_width_10">发送类型</th>
												<th class="m_width_10 hidden-sm hidden-md">发布公告人</th>
												<th class="m_width_20">发布时间</th>
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
			loadSubMenu("informationPlatform");    
			//选取当前菜单位置
			setActive("informationPlatform","announcementShow");  
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			//加载初始化数据
			loadAnnouncementList(null, userId, roleCode, null);
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadAnnouncementList(null, userId, roleCode, null);
				//初始化select
				$("#announcementSelect").val('0');
			});

			//选择公告类型加载
			$("#announcementSelect").change(function(){
				//公告类型
				var type = $(this).val();
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				loadAnnouncementList(type, userId, roleCode, null);
			});

			//点击进入发布公告页面
			$("#addAnnouncement").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>announcement/toAddAnnouncement.do',{userId:userId,roleCode:roleCode});
			});
			
		});

		//加载公告页面
		function loadAnnouncementList(type, userId, roleCode, cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>announcement/loadAnnouncementList.do",
				data:{
						type : type,
						userId : userId,
						roleCode : roleCode,
						permissionCode : "announcementManager",
						cPage : cPage
					},
				error:function(){
					App.unblockUI(body);
				},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
           				appendHtml += '<td>' + value.content + '</td>';
						//根据类别加载发送类型
            			if (value.type == 0)
	            		{
            				appendHtml += '<td>最新公告</td>';
		            	}
            			else if (value.type == 1)
	            		{
            				appendHtml += '<td>学校公告</td>';
	            		}
            			else if (value.type == 2)
	            		{
            				appendHtml += '<td>部门公告</td>';
		            	}
            			else if (value.type == 3)
	            		{
            				appendHtml += '<td>班级公告</td>';
		            	}
            			else if (value.type == 4)
	            		{
            				appendHtml += '<td>系统公告</td>';
		            	}

            			appendHtml += '<td class="hidden-sm hidden-md">' + value.realName + '</td>';
            			var time = value.createTime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
            			appendHtml += '<td>' + time + '</td>';
           				appendHtml += '</tr>';
          			}); 
          		
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
          			if (null != cPage)
              		{
          				$("#currentPage").html(cPage);
              		}	
          			
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
						
			//跳转到首页
			var newCPageInt = returnCPageInt(type,cPageInt,totalPageInt);
			if(newCPageInt < 0){
				return;
			}else{
				cPageInt = newCPageInt;
			}	
			//公告类型
			var type = $("#announcementSelect").val();
			//用户ID
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			loadAnnouncementList(type, userId, roleCode, cPageInt);
			$("#currentPage").html(cPageInt);
		}
		
	</script>
</html>