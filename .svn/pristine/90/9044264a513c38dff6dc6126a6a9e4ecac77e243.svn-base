<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>每日活动</title>
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
	                        <li><a href="">电子课程表</a><i class="fa fa-circle"></i></li>
	                        <li><span>每日活动</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">每日活动</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<li class="roleLi" id="${roleList.roleCode}">
										<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}">${sessionScope.user.realName}(${roleList.roleName})</a>
									</li>
								</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<r:right rightCode="todayActivityEdit">
								   <c:if test="${times!=0 && (roleCode!='parent' && roleCode!='student')}">
										<button class="btn btn-default" type="button"  id="editTodayActivity">编辑</button>
								   </c:if>
								</r:right>
								<r:right rightCode="todayActivityEdit">
									<c:if test="${roleCode!='parent' && roleCode!='student'}">
										<button class="btn btn-default" type="button"  id="addTodayActivity">创建每日活动</button>
									</c:if>
								</r:right>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择班级：</span>
	                                <select class="form-control m_select" id="clazzList"> </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择日期：</span>
	                         		<input type="text" class="m_input form-control" name="startDate" id="startDate" />
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		 <button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>每日活动</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                            	<table class="table table-bordered table-hover" >
									<tr class="activity_title">
										<td class="activitybg">时间段</td>
										<c:forEach items="${weekList}" var="week">
											<c:if test="${week.id == 1}"><td>${week.weekName}</td></c:if>
											<c:if test="${week.id == 2}"><td>${week.weekName}</td></c:if>
											<c:if test="${week.id == 3}"><td>${week.weekName}</td></c:if>
											<c:if test="${week.id == 4}"><td>${week.weekName}</td></c:if>
											<c:if test="${week.id == 5}"><td>${week.weekName}</td></c:if>
											<c:if test="${week.id == 6}"><td>${week.weekName}</td></c:if>
											<c:if test="${week.id == 7}"><td>${week.weekName}</td></c:if>
										</c:forEach>
									</tr>
									<c:if test="${times!=0 }">
										<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="cmt">
		                                      <c:choose>
		                                      	   <c:when test="${cmt.index==0}">
														<tr>
 															<td class="time_st">${mt.beginTime}-${mt.endTime}</td>
															<c:choose>
															   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 1 }">
															      <c:forEach items="${mt.curriculumList}" var="ms">
																	<td><p class="table_title">${ms.subjectName}</p></td>
																  </c:forEach>
															   </c:when>
															   <c:otherwise>
															      <c:forEach items="${weekList}">
																	 <td></td>
																  </c:forEach>
															   </c:otherwise>
															</c:choose>
														</tr>
				                                    </c:when>
				                                    <c:otherwise>
				                                       <tr>
				                                        <td class="time_st">${mt.beginTime}-${mt.endTime}</td>
				                                        <c:choose>
														   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 1 }">
														      <c:forEach items="${mt.curriculumList}" var="ms2">
																<td><p class="table_title">${ms2.subjectName}</p></td>
															  </c:forEach>
														   </c:when>
														   <c:otherwise>
														      <c:forEach items="${weekList}">
																 <td></td>
															  </c:forEach>
														   </c:otherwise>
														</c:choose>
														</tr>
				                                    </c:otherwise>
		                                      </c:choose>
		                                </c:forEach>
		                                
		                                <tr>
											<td class="time_st">${curriculumNoonTime.beginTime}-${curriculumNoonTime.endTime}</td>
											<td colspan="7" class="lunch-noon">午餐+午休</td>
									    </tr>
		                                <c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="cat">
		                                       <c:choose>
		                                      	   <c:when test="${cat.index==0}">
														<tr>
															<td class="time_st">${at.beginTime}-${at.endTime}</td>
															<c:choose>
															   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 1 }">
															      <c:forEach items="${at.curriculumList}" var="as">
																	<td><p class="table_title">${as.subjectName}</p></td>
																  </c:forEach>
															   </c:when>
															   <c:otherwise>
															      <c:forEach items="${weekList}">
																	 <td></td>
																  </c:forEach>
															   </c:otherwise>
															</c:choose>
														</tr>
				                                    </c:when>
				                                    <c:otherwise>
				                                      <tr>
				                                       <td class="time_st">${at.beginTime}-${at.endTime}</td>
				                                       <c:choose>
															   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 1 }">
															      <c:forEach items="${at.curriculumList}" var="as2">
																	<td><p class="table_title">${as2.subjectName}</p></td>
																  </c:forEach>
															   </c:when>
															   <c:otherwise>
															      <c:forEach items="${weekList}">
																	 <td></td>
																  </c:forEach>
															   </c:otherwise>
															</c:choose>
				                                    	</tr>
				                                    </c:otherwise>
		                                       </c:choose>
									    </c:forEach>
									     
									</c:if>
									<c:if test="${times==0 }">
										<tr height="40px"> <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						                <tr height="40px"> <td> </td> <td> </td>  <td> </td> <td> </td> <td> </td> <td> </td> <td> </td> <td></td></tr>
						                <tr height="40px"> <td> </td> <td> </td>  <td> </td> <td> </td> <td> </td> <td> </td> <td> </td><td></td> </tr>
						                <tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
						                <tr height="40px"> <td style=" vertical-align:middle;" align="center" class="bg"></td><td colspan="7" class="lunch-noon">午餐+午休</td></tr>
										<tr height="40px"><td></td> <td></td> <td></td> <td></td><td></td><td></td><td></td><td></td></tr>
						                <tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
						                <tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
									</c:if>
								
								</table>
								<input type="hidden" id="semesterId" name="semesterId" value="${semesterId}"/>
								<input type="hidden" id="startDay" name="startDay" value="${startDay}"/>
								<input type="hidden" id="roleCode" name="roleCode" value="${roleCode}"/>
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
			loadSubMenu("dailyActivities"); 
			//选取当前菜单位置
			setActive("dailyActivities","todayActivity");     
			$('#startDate').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			} );
			//如果是主菜单进入 选择第一个tab为默认  不是选择对应的roleCode为默认
			var role = $("#roleCode").val();
			if(role =="")
			{
				//选择第一个tab
				$("#userTab li:first").addClass("active");
			}else
			{
				$("#"+role).addClass("active");
			}

			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				standardPost('<%=basePath%>todayActivity/toTodayActivity.do',{roleCode:roleCode});
			});

			loadclazzList(userId, "curriculumManager",roleCode);

			//点击创建每日活动
		    $("#addTodayActivity").on("click",function(){
		    	//班级Id
				var clazzId = $("#clazzList").val();
				//角色
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
	    		standardPost('<%=basePath%>todayActivity/toAddTodayActivity.do',{clazzId:clazzId,roleCode:roleCode});
			})
			
			//点击编辑
		    $("#editTodayActivity").on("click",function(){
		    	
		    	//开始日期
				var startDay = $("#startDay").val();
				//班级Id
				var semesterId = $("#semesterId").val();
				//班级Id
				var clazzId = $("#clazzList").val();
				//角色
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
		    	standardPost('<%=basePath%>todayActivity/toEditTodayActivity.do',{semesterId:semesterId,startDay:startDay,clazzId:clazzId,roleCode:roleCode});
			})

			
			//条件查询
			$("#search").click(function(){

				//页面初始化时候的数据加载
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				
				//开始日期
				var startDate = $("#startDate").val();
				
				//班级Id
				var clazzId = $("#clazzList").val();

		    	standardPost('<%=basePath%>todayActivity/toTodayActivity.do',{startDate:startDate,clazzId:clazzId,roleCode:roleCode});
				
			});
		});


		// 加载班级列表
		function loadclazzList(userId, permissionCode,roleCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>curriculum/loadClazzList.do",
				data : {
					userId : userId,
					permissionCode : permissionCode,
					roleCode : roleCode

				},
				success : function(data) {

					var clazzList = eval("(" + data + ")");

					var appendHtml ='';
					$.each(clazzList, function(n, value) {
						appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
					});

					$("#clazzList").html(appendHtml);
					
					var clazzId = ${clazzId};
					if (typeof(clazzId) == "undefined" || clazzId == "undefined")
					{
						$("#clazzList").val("0");
					}
					else
					{
						$("#clazzList").val(clazzId);
					}

					$("#pclazzname").find("span").text($("#clazzList option:selected").text());
					
				},
			});
		}
	</script>
</html>