<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>作息时间</title>
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
	                        <li><span>作息时间</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">作息时间</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
									<c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'president'}">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
											</li>
										</c:if>
									</c:forEach>																						
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<c:if test="${sessionScope.user.type != 2}">
									<button class="btn btn-default" type="button" id="add">添加</button>
								</c:if>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>作息时间</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                        <th>生效日期</th>
											<th>状态</th>
											<c:if test="${sessionScope.user.type != 2}">
												<th class="Response">操作</th>
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
	    <!-- 弹窗开始  大小参数：modal-lg, modal-sm-->
	    <div class="modal fade bs-modal-sm" id="small" tabindex="-1" role="dialog" aria-hidden="true">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">天窗标题</h4>
	                </div>
	                <div class="modal-body">弹窗主题</div>
	                <div class="modal-footer">
	                    <button type="button" class="btn dark btn-outline" data-dismiss="modal">确定</button>
	                    <button type="button" class="btn green">取消</button>
	                </div>
	            </div>
	            <!-- /.modal-content -->
	        </div>
	        <!-- /.modal-dialog -->
	    </div>
	    <!-- 弹窗结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function() { 
			loadSubMenu("schoolManager");   
			//选取当前菜单位置
			setActive("schoolManager","scheduleManage");  
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			//加载初始化数据
			loadScheduleList(userId, roleCode, null);

			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadScheduleList(userId, roleCode, null);
			});

			//点击进入添加页面
			$("#add").click(function(){
				var userId = $("ul li.active").find('a').attr("attr1");	
				var roleCode = $("ul li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>schedule/toAddSchedule.do',{userId:userId,roleCode:roleCode});
			});
		});

		
		//加载作息时间列表
		function loadScheduleList(userId, roleCode, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>schedule/loadScheduleList.do",
				data:{
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
						
						//生效时间
           				appendHtml += '<td>' + value.liveingDate + '</td>';

						//状态
           				var status = parseInt(value.status);
           				switch(status)
           				{ 
           					case 0 : 
           						appendHtml += '<td>上课</td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td><span style=\"color:red\">休息</span></td>';
           						break; 
           					default : 
           						appendHtml += '<td>上课</td>';
           						break;
           				}
           				if ($("#type").val() != '2'){
           					appendHtml += "<td class='Response'><a href='javascript:;' class='btn btn-sm green' onclick='editSchedule(\"" + value.liveingDate + "\")'>修改</a></td>";
           					
           					
           				}
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
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

			//用户ID
			var userId = $("ul li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("ul li.active").find('a').attr("attr2");
			loadScheduleList(userId, roleCode, cPageInt);
			$("#currentPage").html(cPageInt);
		}

		//进入作息时间修改页面
		function editSchedule(liveingDate)
		{
			var userId = $("ul li.active").find('a').attr("attr1");	
			var roleCode = $("ul li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>schedule/toEditSchedule.do',{userId:userId,roleCode:roleCode,liveingDate:liveingDate});
		}
	</script>
</html>