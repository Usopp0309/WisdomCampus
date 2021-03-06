<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>部门管理</title>
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
	                        <li><span>部门管理</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">部门管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
										 	<r:right rightCode="departManager">
													<li class="roleLi">
														<a  attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
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
								   <r:right rightCode="departAdd">
										<button class="btn btn-default" type="button" id="addDEepartment">增加部门</button>
						           </r:right>
								</c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>部门管理</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_20">部门编号</th>
												<th class="m_width_20">部门名称</th>
												<th class="m_width_15 hidden-sm hidden-md">管理员</th>
												<th class="m_width_25">创建时间</th>
												<th class="m_width_20">操作</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="tbody">
	                                       
	                                    </tbody>
	                                </table>
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
	<script>

		jQuery(document).ready(function() { 
			loadSubMenu("schoolManager");
			//选取当前菜单位置
			setActive("schoolManager","departManage");  
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			//初始化加载部门列表
			loadDepartList(userId, roleCode);
			
			//点击进入增加部门页面
			$("#addDEepartment").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>depart/toAddDepartment.do',{userId:userId,roleCode:roleCode});
			});
				
		});
		
		
	
	
		//加载部门列表
		function loadDepartList(userId, roleCode)
		{
			var rowCount = 0;
			$.ajax({
				type: "post",
				data:{
						userId : userId,
						roleCode : roleCode,
						
					},
				url: "<%=basePath%>depart/getDepartList.do",
				success: function(data){
					var departList = eval("(" + data + ")");
					var departRowHtml = '';
					$.each(departList, function(n, value) {  
						departRowHtml += '<tr>';
						if (value.code == null){
							departRowHtml += '<td></td>';
						}else{
							departRowHtml += '<td>' + value.code +'</td>';
						}
						
						departRowHtml += '<td class="hidden-sm hidden-md"><a href="javascript:depart_detialSelect(' + value.id + ')" target="_self">' + value.departmentName+ '</a></td>';
						if (value.id != 0 && value.leaderName != null){
							departRowHtml += '<td>' + value.leaderName + '</td>';
						}else{
							departRowHtml += '<td></td>';
						}
						var time = value.createTime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
						departRowHtml += '<td>' + time + '</td>';
						if (value.id != 0){
							departRowHtml += '<td><c:if test="${sessionScope.user.type != 2}"><r:right rightCode="departModify"><a href="javascript:modifyDepartment(' + value.id + ',' + value.leaderId + ')" target="_self" class="btn btn-sm edit_btn">编辑</a> </r:right><r:right rightCode="departDelete"><a href="javascript:deleteDepartment(' + value.id + ')" target="_self" class="btn btn-sm delete_btn">删除</a></r:right></c:if> </td>';
						}else{
							departRowHtml += '<td> </td>';
						}
						departRowHtml += '</tr>';
						
						rowCount ++;

						
	          		});

	          		if (rowCount != 0)
		          	{
	          			departRowHtml += '</tr>';
		          	}
					
          			$("#tbody").html(departRowHtml);
          			
          			//显示部门
					$("#departRow").show();
					
				},
			});
		}

		//点击修改部门权限页面
		function modifyDepartment(id,leaderId){
			var userId = $("#userTab li.active").find('a').attr("attr1");	
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>depart/toModifyDepartment.do',{userId:userId,roleCode:roleCode,id:id,leaderId:leaderId});
		};

		function deleteDepartment(id){
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			layer.confirm('是否删除改部门？', {
				  btn: ['是','否'] //按钮
				}, function(){
					$.ajax({
						type: "post",
						url: "<%=basePath%>depart/doDeleteDepartment.do",
						data:{
							deparid : id
						},
						success: function(data){
	                        	var result=eval("("+data+')');
	                        	if(result){
	                        		layer.msg('删除部门成功',{icon:1,time:1000});
		                        	}
								loadDepartList(userId, roleCode);
						}	
					});
				});
		}
		
		function depart_detialSelect(id)
		{  
			standardPost('<%=basePath%>depart/depart_detialSelect.do',{id:id});
		}
		
		
	</script>
</html>