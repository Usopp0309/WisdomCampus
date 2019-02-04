<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>电子课程表</title>
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
	                        <li><span>电子课程表设定</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">电子课程表设定</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:choose>
										       <c:when test="${roleList.roleCode == 'teacher' || roleList.roleCode == 'departManager' }">
													<li class="roleLi active"><a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}">${sessionScope.user.realName}(${roleList.roleName})</a>
													</li>
										       </c:when>
										       <c:otherwise>
										       		<c:choose>
											       		<c:when test="${schedule !=0 && roleList.roleCode == 'classLeader'}">
												           <li class="roleLi active"><a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}">${sessionScope.user.realName}(${roleList.roleName})</a>
															</li>
														</c:when>
														<c:otherwise>
												           <li class="roleLi"><a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}">${sessionScope.user.realName}(${roleList.roleName})</a>
															</li>
														</c:otherwise>
													</c:choose>
										       </c:otherwise>
										   </c:choose>
									   </c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                       		<c:if test="${schedule !=0 }">
							   		 <button class="btn btn-default" type="button" id="classCurriculum">班级课程表</button>
							   	</c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="#" class="form-horizontal">
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">开始时间：</span>
	                         		<input type="text" class="m_input form-control" name="startDate" id="startDate" readonly="readonly"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">结束时间：</span>
	                         		<input type="text" class="m_input form-control" name="endDate" id="endDate" readonly="readonly"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		 <button type="submit" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>电子课程表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
								<tr>
									<td class="bg">阶段</td>
									<td class="bg">起始时间</td>
									<c:forEach items="${weekList}" var="week">
										<td>${week.weekName}</td>
									</c:forEach>
								</tr>
								<c:if test="${times!=0 }">
								<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="cmt">
                                      <c:choose>
                                      	   <c:when test="${cmt.index==0}">
												<tr >
													<td class="bg" rowspan="${fn:length(curriculumMorningTimeList)}" align="center" valign="middle">上午</td>
													<td class="bg">${mt.beginTime}-${mt.endTime}</td>
													<c:choose>
													   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 0 }">
													      <c:forEach items="${mt.curriculumList}" var="ms">
															<td><p class="table_title">${ms.subjectName}</p><p>${ms.classroomName}</p></td>
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
		                                        <td class="bg">${mt.beginTime}-${mt.endTime}</td>
		                                        <c:choose>
												   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 0 }">
												      <c:forEach items="${mt.curriculumList}" var="ms2">
														<td><p class="table_title">${ms2.subjectName}</p><p>${ms2.classroomName}</p></td>
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
                                    
                                <c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="cat">
                                       <c:choose>
                                      	   <c:when test="${cat.index==0}">
		                                       <tr>
												<td colspan="9"  class="m_text_align_conter">休息时间</td>
											   </tr>
												<tr>
													<td class="bg" rowspan="${fn:length(curriculumAfternoonTimeList) }" align="center" valign="middle">下午</td>
													<td class="bg">${at.beginTime}-${at.endTime}</td>
													<c:choose>
													   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 0 }">
													      <c:forEach items="${at.curriculumList}" var="as">
															<td><p class="table_title">${as.subjectName}</p><p>${as.classroomName}</p></td>
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
		                                       <td class="bg">${at.beginTime}-${at.endTime}</td>
		                                       <c:choose>
													   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 1 }">
													      <c:forEach items="${at.curriculumList}" var="as2">
															<td><p class="table_title">${as2.subjectName}</p><p>${as2.classroomName}</p></td>
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
							    
							     <c:forEach items="${curriculumNightTimeList}" var="nt" varStatus="cnt">
									<c:choose>
                                      	   <c:when test="${cnt.index==0}">
		                                       <tr>
												<td colspan="9"  class="m_text_align_conter">休息时间</td>
											   </tr>
												<tr>
													<td class="bg" rowspan="${fn:length(curriculumNightTimeList)}" align="center" valign="middle">晚上</td>
													<td class="bg">${nt.beginTime}-${nt.endTime}</td>
													<c:choose>
													   <c:when test="${nt.curriculumList!=null && fn:length(nt.curriculumList) > 1 }">
													      <c:forEach items="${nt.curriculumList}" var="ns">
															<td><p class="table_title">${ns.subjectName}</p><p>${ns.classroomName}</p></td>
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
		                                        <td class="bg">${nt.beginTime}-${nt.endTime}</td>
		                                        <c:choose>
													   <c:when test="${nt.curriculumList!=null && fn:length(nt.curriculumList) > 1 }">
													      <c:forEach items="${nt.curriculumList}" var="ns2">
															<td><p class="table_title">${ns2.subjectName}</p><p>${ns2.classroomName}</p></td>
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
									<tr height="40px"><td style=" vertical-align:middle;" align="center" rowspan="4" class="bg">上午</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
					                <tr height="40px"> <td> </td> <td> </td>  <td> </td> <td> </td> <td> </td> <td> </td> <td> </td> <td></td></tr>
					                <tr height="40px"> <td> </td> <td> </td>  <td> </td> <td> </td> <td> </td> <td> </td> <td> </td><td></td> </tr>
					                <tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
					                <tr height="40px"><td colspan="9"  class="m_text_align_conter">休息时间</td></tr>
									<tr height="40px"> <td style=" vertical-align:middle;" align="center" rowspan="3" class="bg">下午</td> <td></td> <td></td> <td></td> <td></td><td></td><td></td><td></td><td></td></tr>
					                <tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
					                <tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
					                <tr height="40px"><td colspan="9"  class="m_text_align_conter">休息时间</td></tr>
									<tr height="40px"><td style=" vertical-align:middle;" align="center" rowspan="3" class="bg">晚上</td><td></td><td></td><td></td><td></td><td></td> <td></td> <td></td><td></td> </tr>
					               	<tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
					               	<tr height="40px"> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td><td></td> </tr>
							</c:if>
							</table>
							<input type="hidden" id="schedule" value="${schedule}"/>
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
			loadSubMenu("curriculum"); 
			//选取当前菜单位置
			setActive("curriculum","curriculumManager");   
			$('#startDate,#endDate').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			} );
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
				standardPost('<%=basePath%>curriculum/toSetCurriculum.do',{roleCode:roleCode});
			});


			
			//条件查询
			$("#search").click(function(){
				//页面初始化时候的数据加载
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = "teacher";
				//开始日期
				var startDate = $("#startDate").val();
				//结束日期
				var endDate = $("#endDate").val();
				var schedule = $("#schedule").val();
				if(!checkSplitDate(startDate,1) || !checkSplitDate(endDate,1)){
					layer.msg("请输入正确时间格式！");
				}else{
					standardPost('<%=basePath%>curriculum/toSetCurriculum.do',{roleCode:roleCode,startDate:startDate,endDate:endDate,clazzId:clazzId});
				}
				});
			
			$("#classCurriculum").on("click",function(){
				var roleCode = "classLeader";
		    	standardPost('<%=basePath%>curriculum/toSetCurriculum.do',{roleCode:roleCode});
			})

		});
		function checkSplitDate(date,type){
			var flag = true;
			var reg = /^[0-9]+$/;
			if(date !=null && date!=""){
				var strs = new Array();
				if(type == 1){
					strs = date.split("-");
				}else{
					strs = date.split(":");
				}
				for (i=0;i<strs.length ;i++ ) 
				{ 
					  if (!reg.test(strs[i])) {
						  flag = false;
					  }
					  
				} 
			}
			return flag;
		}
	</script>
</html>