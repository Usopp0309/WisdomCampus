<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>部门人员详细</title>
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
	                        <li><span>部门人员详细</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">部门人员详细</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<r:right rightCode="departManager">
											<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
												<li class="roleLi">
													<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
													</a>
												</li>
											</c:if>
										</r:right>
									</c:forEach>
	                            </ul>
	                            <input type="hidden" id="departmentId" value="${id}"/>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        
							<!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<c:if test="${sessionScope.user.type != 2}">
	                                  <r:right rightCode="departAdd">
	                                  	<c:if test="${param.id !=0 }"> 
										<button class="btn btn-default" type="button" id="departAddMember">增加部门人员</button>
										
										</c:if>
									 </r:right>	
									 <r:right rightCode="createDepartGroup">
										<button class="btn btn-default" type="button" id="createDepartGroup">一键创建亦信部门群</button>
										<button class="btn btn-default" type="button" id="delDepartGroup">删除亦信部门群</button>
									 </r:right>
								 </c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">查找：</span>
	                         		<input type="text"class="m_input form-control" id="queryContent" placeholder="请输入工号，姓名,手机号查询"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
									<input type="hidden" id="type" value="${sessionScope.user.type}"/>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>部门人员详细</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th >部门编号</th>
												<th>部门名称</th>
												<th >工号</th>
												<th>姓名</th>
												<th>联系电话</th>
												<th>角色</th>
												<c:if test="${sessionScope.user.type != 2}">
													<c:if test="${param.id !=0 }"> 
													   <th class="Response">修改</th>
													</c:if>
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
			setActive("schoolManager","departManage");  
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
			var departmentId = $("#departmentId").val();
			//查询部门人员 
			var queryContent = $("#queryContent").val();
			
			loadDepartDetailList(departmentId,queryContent,1);
			
			//加载增加按钮
			$("#departAddMember").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				var departmentId = $("#departmentId").val();
				standardPost('<%=basePath%>depart/toAddDepartmDetail.do',{departmentId:departmentId,userId:userId,roleCode:roleCode});
			});
			
			//一键创建亦信部门群
			$("#createDepartGroup").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				var departmentId = $("#departmentId").val();
				if(confirm('确认创建部门群？')){
					//创建群时，判断部门里面有没有人， 没有人不让建群 
					createDepartGroup(departmentId);
				}				
			});
			$("#delDepartGroup").click(function(){
				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				var departmentId = $("#departmentId").val();
				if(confirm('确认删除部门群？')){
					//创建群时，判断班级里面有没有人， 没有人不让建群 
					delDepartGroup(departmentId);
				}
			});
			
			//查找数据
			$("#search").click(function(){
				
				//查询部门人员 
				var departmentId = $("#departmentId").val();
			    var queryContent = $("#queryContent").val();

				loadDepartDetailList(departmentId,queryContent,1);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});			
			
		});

		//创建部门群
		function createDepartGroup(departmentId){
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>depart/createDepartGroup.do",
				data:{departmentId : departmentId},
				success : function(data){
					var result = eval("(" + data + ")");
					layer.msg(result);
					//解锁UI
          			App.unblockUI(body);
				}
			});
		}

		//删除部门群
		function delDepartGroup(departmentId){
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>depart/delDepartGroup.do",
				data:{departmentId : departmentId},
				success : function(data){
					var flag = eval("(" + data + ")");
					if(flag){
						layer.msg("部门群组删除成功");
					}else{
						layer.msg("部门群组删除失败，请稍后重试");
					}
					//解锁UI
          			App.unblockUI(body);
					
				}
			});
		}
		
		//加载部门详情列表
		function loadDepartDetailList(departmentId,queryContent,cPage){
			var body = $("#body");
			
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>depart/loadDepartDetailList.do",
				data:{
					    departmentId : departmentId,
						queryContent : queryContent,
						cPage : cPage
					},
				success: function(data){
				    
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
           				
						appendHtml += '<tr>';
						if (null == value.departmentCode)
						{
							appendHtml += '<td></td>';
						}
						else
						{
							appendHtml += '<td>' + value.departmentCode + '</td>';
						}		
           				
            			appendHtml += '<td>' + value.departmentName + '</td>';
            			appendHtml += '<td>' + value.code + '</td>';
            			appendHtml += '<td>' + value.realName + '</td>';
            			appendHtml += '<td>' + value.phone + '</td>';
            			appendHtml += '<td>' + value.roleName + '</td>';

            			var departmentId = $("#departmentId").val();
            			if(departmentId != 0 && $("#type").val() != '2')
                		{
            			   appendHtml += '<td><r:right rightCode="departDeleteMember"><a onclick="deleteTeacherById(' + value.userId + ')">删除</a></r:right></td>';
                    	}
           				appendHtml += '</tr>';
            			
          			}); 
          			
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
				},
			});
		
		}

		//点击删除部门人员
		function deleteTeacherById(userId){
			//部门id
			var departmentId = $("#departmentId").val();
			//询问框
			var ll=layer.confirm('确定要删除？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
			 layer.close(ll);
			 var indexlayer = layer.msg('正在删除,请稍候。。。',{icon: 16,time:0,shade:0.3});
			 $.ajax({
					type: "post",
					url: "<%=basePath%>depart/deleteTeacherById.do",
					data:{
						departmentId : departmentId,
						userId : userId
					},
					success: function(data){
						layer.close(indexlayer);
						var page = eval("(" + data + ")");
						if(page ==  1)
						{
                         layer.alert("该老师目前只属于此部门，已移动至教师未分组中");
                         loadDepartDetailList(departmentId,null, null);
						}	
						loadDepartDetailList(departmentId,null, null);
					}
				});
			}, function(){
			 
			});
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
			var departmentId = $("#departmentId").val();
			//查询部门人员 
			var queryContent = $("#queryContent").val();
			loadDepartDetailList(departmentId,queryContent,cPageInt);
			
			$("#currentPage").html(cPageInt);
		}
	</script>
</html>