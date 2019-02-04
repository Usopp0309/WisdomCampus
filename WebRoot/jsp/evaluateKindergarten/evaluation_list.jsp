<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>老师评价</title>
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
	                        <li><a href="">幼儿园评价</a><i class="fa fa-circle"></i></li>
	                        <li><span>老师评价</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">老师评价</h3>
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
								<input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}"/>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="<%=basePath%>student/getStudentList.do" class="form-horizontal" method="post">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择班级：</span>
	                         		<select class="form-control m_select" id="clazzList"></select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">搜索</button>
	                         	</div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>老师评价</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>学号</th>
											    <th>姓名</th>
											    <th>班级名称</th>
												<th>最近评论时间</th>
												<th>操作</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="tbody">
	                                      
	                                    </tbody>
	                                </table>
	                                <r:right rightCode="addEvaluateKindergarten"><input type="hidden" id="hasAddPriv"></input></r:right>
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
			loadSubMenu("evaluateKindergarten"); 
			//选取当前菜单位置
			setActive("evaluateKindergarten","evaluateList");   
			//页面初始化时候的数据加载
			var userId = $("#userId").val();
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			//加载班级信息
			loadclazzList(userId,roleCode);
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadclazzList(userId,roleCode);
			});

			//条件查询
			$("#search").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				//查询条件
				var queryContent = $("#queryContent").val();
				//班级ID
				var clazzId = $("#clazzList").val().replace("C", "");
				var clazzIds='';
				$('#clazzList option').each(function () {
				    var $option = $(this);
				    var value = $option.val().replace("C","");
				    clazzIds+=value+',';
				});
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (clazzId != 0)
				{
					loadStudentList(clazzId,clazzIds, queryContent, userId, roleCode, null);
				}
				else
				{
					loadStudentList(0,clazzIds, queryContent, userId, roleCode, null);
				}
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});	
			
			//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#clazzList").change(function(){
				//查询条件
				var queryContent = $("#queryContent").val();	
				var clazzIds='';
				$('#clazzList option').each(function () {
				    var $option = $(this);
				    var value = $option.val().replace("C","");
				    if(value != '0'){
				    	clazzIds+=value+',';
					}
				});	
				//班级ID
				var clazzId = $(this).val().replace("C","");
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (clazzId != 0)
				{
					loadStudentList(clazzId,clazzIds, queryContent, userId, roleCode, null);
				}
				else
				{
					loadStudentList(0,clazzIds, queryContent, userId, roleCode, null);
				}	
			});			
			
		});
		
		// 加载班级列表
		function loadclazzList(userId,roleCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>evaluateKindergarten/loadClazzList.do",
				data:{
						userId : userId,
						roleCode : roleCode
					},
				success: function(data){
					var clazzList = eval("(" + data + ")");
					
					var appendHtml = '<option value="C0" selected="selected">---请选择---</option>';
					$.each(clazzList, function(n, value) {
						appendHtml += '<option value="C' + value.id + '">' + value.clazzName + '</option>';
           			});  
					 
           			$("#clazzList").html(appendHtml);
           			$("#clazzList").change();
				},
			});
		}
		
		//加载学生页面
		function loadStudentList(clazzId,clazzIds, queryContent, userId, roleCode, cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			var hasAddPriv = false;
			if ($("#hasAddPriv").length > 0){
				hasAddPriv = true;
			}else{
				hasAddPriv = false;
			}
			$.ajax({
				type: "post",
				url: "<%=basePath%>evaluateKindergarten/getStudentListInPC.do",
				data:{
						clazzId : clazzId,
						clazzIds : clazzIds,
					    queryContent : queryContent,
						userId : userId,
						roleCode : roleCode,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					//解锁UI
          			App.unblockUI(body);
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						
						appendHtml += '<tr>';
						var code = value.code;
						if(code == null || code == "undefined"){
							code = '';
						}
            			appendHtml += '<td>' + code + '</td>';
            			appendHtml += '<td>' + value.realName + '</td>';
            			appendHtml += '<td>' + value.clazzName + '</td>';
            			if (typeof(value.createTime) == "undefined")
            			{
            				appendHtml += '<td></td>';
                		}else{
                			appendHtml += '<td>' + value.createTime + '</td>';
                        }
            			var studentId = value.studentId;
            			if (hasAddPriv){
                			if(roleCode == 'student' || roleCode == 'parent'){
                				appendHtml += '<td><a href="javascript:;" onclick="detailEvaluate(' + value.userId + ')">评价详情</a></td></td>';
                        	}else{
                        		if (typeof(studentId) == "undefined")
                    			{
                            		appendHtml += '<td><a href="javascript:;" onclick="detailEvaluate(' + value.userId + ')">评价详情&nbsp<a href="javascript:;" class="edit" onclick="addEvaluate(' + value.userId + ')">添加评价</a></td>';
                            	}else{
                            		appendHtml += '<td><a href="javascript:;" onclick="detailEvaluate(' + value.userId + ')">评价详情</td>';
                                }
                            }
            			}else{
            				appendHtml += '<td><a href="javascript:;" onclick="detailEvaluate(' + value.userId + ')">评价详情</a></td></td>';
                    	}
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
				},
			});
		}

		
		//点击进入学生评价详情
		function detailEvaluate(studentId)
		{
			standardPost('<%=basePath%>evaluateKindergarten/toEvaluateDetail.do',{studentId:studentId});
		}

		//点击进入添加学生评价详情
		function addEvaluate(studentId)
		{
			standardPost('<%=basePath%>evaluateKindergarten/toAddEvaluate.do',{studentId:studentId});
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
			//查询条件
			var queryContent = $("#queryContent").val();	
			var clazzIds='';
			$('#clazzList option').each(function () {
			    var $option = $(this);
			    var value = $option.val().replace("C","");
			    if(value != '0'){
			    	clazzIds+=value+',';
				}
			});	
			//班级ID
			var clazzId = $("#clazzList").val().replace("C", "");
			
			var userId = $("#userTab li.active").find('a').attr("attr1");	
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			//clazzId为0表示选择所有班级，不为0表示选择某个班级
			if (clazzId != 0)
			{
				loadStudentList(clazzId,clazzIds, queryContent, userId, roleCode, null);
			}
			else
			{
				loadStudentList(0,clazzIds, queryContent, userId, roleCode, null);
			}
			$("#currentPage").html(cPageInt);
		}
	</script>
</html>