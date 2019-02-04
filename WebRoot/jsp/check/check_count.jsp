<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>考勤统计</title>
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
	                        <li><a href="">师生考勤</a><i class="fa fa-circle"></i></li>
	                        <li><span>考勤统计</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">考勤统计</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user}" var="user">
									<c:if test="${user.roleId == 1 || user.roleId == 2 || user.roleId == 3 || user.roleId == 4  || user.roleId == 8}">
										<li class="roleLi">
											<a attr1="${user.id}" attr2="${user.roleId}">${user.name}(${user.roleName})
											</a>
										</li>
									</c:if>
								</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<button type="button" class="btn btn-default"><i class="icon-download-alt"></i>&nbsp;导出</button>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">统计类型：</span>
                                    <select class="form-control m_select" id="userType" name="userType">
										<option value="0">--请选择--</option>
										<option value="1">教师</option>
										<option value="2">学生</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">统计级别：</span>
	                         		<select class="form-control m_select" id="type" name="type">
																	
										<option value="0">--请选择--</option>
										
										<option value="1">全校</option>

										<option value="2">年级</option>

										<option value="3">个人</option>
									
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">统计周期：</span>
	                         		<select class="form-control m_select" id="periodType" name="periodType">
																	
										<option value="0">--请选择--</option>
										
										<option value="1">月</option>
										
										<option value="2">周</option>
										
										<option value="3">日</option>
									
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">编号：</span>
	                         		<input type="text" placeholder="请输入编号..." class="m_input form-control" name="code" id="code"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">名称：</span>
	                         		<input type="text" placeholder="请输入名称..." class="m_input form-control" id="name"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>考勤统计</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>时间</th>
												<th>编号</th>
												<th>名称</th>
												<th>迟到次数</th>
												<th>早退次数</th>
												<th>事假次数</th>
												<th>病假次数</th>
												<th>产假次数</th>
												<th>出差次数</th>
												<th>最早到校时间</th>
												<th>最迟离校时间</th>
												<th>在校时长</th>
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
			var roleId = $("ul li.active").find('a').attr("attr2");

			//初始化年级select
<%--			loadAllGradeList(userId, roleId);--%>
			
			//加载初始化数据
			loadTotalCheckList(null, null,
					null, null, null, userId, roleId, null);

			
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
<%--				var userId = $(this).attr("attr1");--%>
<%--				var roleId = $(this).attr("attr2");--%>
<%--				loadTeacherList(null, userId, roleId, null);--%>
			});

			$("#search").click(function(){

				var userId = $("ul li.active").find('a').attr("attr1");
				var roleId = $("ul li.active").find('a').attr("attr2");
				
				//年级ID
				var userType = $("#userType").val();
				//卡号
				var code = $("#code").val();
				//姓名
				var name = $("#name").val();
				//手机号码
				var type = $("#type").val();
				//电子卡号
				var periodType = $("#periodType").val();

				loadTotalCheckList(userType, code,
						name, type, periodType, userId, roleId, null);
			});
			
		});

		//根据学校ID加载该学校所有的年级数据
		function loadAllGradeList(userId, roleId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadGradeList.do",
				data:{
						userId : userId,
						roleId : roleId
					},
				success: function(data){
					var gradeList = eval("(" + data + ")");
					var appendHtml = '<option value="0">--请选择--</option>';
					$.each(gradeList, function(n, value) {  
           				appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
          			}); 
          			$("#gradeSelect").html(appendHtml);
				},
			});
		}

		
		//加载教师考勤页面
		//参数说明: userType:人员类型，1:教师，2:学生
		//		 type:统计类别，0:全校，1:年级，2:班级，3:个人
		//       periodType:统计类型，0:月，1:周，2:日
		//       code:编号，type=0时为学校编号，type=1时为学校编号，type=2时为班号，3时为工号或学号
		//       name:名称，参照code，对应的名称
		function loadTotalCheckList(userType, code,
						name, type, periodType, userId, roleId, cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>total/loadTotalCheckList.do",
				data:{
						userType : userType,
						type : type,
						periodType : periodType,
						code : code,
						name : name,
						userId : userId,
						roleId : roleId,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {    
						appendHtml += '<tr>';
           				appendHtml += '<td>' + value.period + '</td>';
            			appendHtml += '<td>' + value.code + '</td>';
            			appendHtml += '<td> '+ value.name+'</td>';
            			appendHtml += '<td>' + value.lateTimes + '</td>';
            			appendHtml += '<td>' + value.leaveTimes + '</td>';
            			appendHtml += '<td>' + value.affairLeave + '</td>';
            			appendHtml += '<td>' + value.sickLeave + '</td>';
            			appendHtml += '<td>' + value.maternityLeave + '</td>';
            			appendHtml += '<td>' + value.businessTrip + '</td>';
            			appendHtml += '<td>' + value.arrivalTime + '</td>';
            			appendHtml += '<td>' + value.leaveTime + '</td>';
            			appendHtml += '<td>' + value.hours + '</td>';
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
						
			var newCPageInt = returnCPageInt(type,cPageInt,totalPageInt);
			if(newCPageInt < 0){
				return;
			}else{
				cPageInt = newCPageInt;
			}


			//用户ID
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleId = $("ul li.active").find('a').attr("attr2");
<%--			loadTeacherList(type, userId, roleId, cPageInt);--%>
<%--			$("#currentPage").html(cPageInt);--%>

			//加载分页数据
			loadTotalCheckList(null, null,
					null, null, null, userId, roleId, cPageInt);
		}

	</script>
</html>