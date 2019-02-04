<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>今日活动</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>今日活动
	</div>  
	<div class="inout_list">
		<table class="activity">
			<thead>
				<tr>
					<th class="td_w" style="background-color:#F2CA06">阶段</th>
					<th class="td_w" style="background-color:#DA45B6">时间</th>
					<th class="td_w" style="background-color:#E67817">一</th>
					<th class="td_w" style="background-color:#E6677C">二</th>
					<th class="td_w" style="background-color:#68B92E">三</th>
					<th class="td_w" style="background-color:#6C609E">四</th>
					<th class="td_w" style="background-color:#01BADE">五</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${times == 0}">
					<tr>
						<td rowspan="4" class="prompt">上午</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="6" class="prompt">午餐+午睡</td>
					</tr>
					<tr>
						<td rowspan="3" class="prompt">下午</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</c:if>
				<c:if test="${times == 1}">
					<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="cmt">
                           <c:choose>
                               <c:when test="${cmt.index==0}">
									<tr >
										<td rowspan="${fn:length(curriculumMorningTimeList)}" align="center" valign="middle"><img src="<%=basePath %>assets/global/img/m_img/morning.png"></td>
										<td><p>${mt.beginTime}</p><p>${mt.endTime}</p></td>
										<c:choose>
										   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 1 }">
										      <c:forEach items="${mt.curriculumList}" var="ms" varStatus="msStat">
												<c:if test="${msStat.index<5}">
													<td>${ms.subjectName}</td>
												</c:if>
											  </c:forEach>
										   </c:when>
										   <c:otherwise>
										      <c:forEach items="${weekList}" varStatus="msStat2">
												 <c:if test="${msStat2.index<5}">
													<td></td>
												 </c:if>
											  </c:forEach>
										   </c:otherwise>
										</c:choose>
									</tr>
                               </c:when>
                               <c:otherwise>
                                   <tr>
	                                    <td><p>${mt.beginTime}</p><p>${mt.endTime}</p></td>
	                                    <c:choose>
										   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 1 }">
										      <c:forEach items="${mt.curriculumList}" var="ms2" varStatus="ms2Stat">
												<c:if test="${ms2Stat.index<5}">
													<td>${ms2.subjectName}</td>
												</c:if>
											  </c:forEach>
										   </c:when>
										   <c:otherwise>
										      <c:forEach items="${weekList}" varStatus="ms2Stat2">
												 <c:if test="${ms2Stat2.index<5}">
													<td></td>
												 </c:if>
											  </c:forEach>
										   </c:otherwise>
										</c:choose>
									</tr>
                               </c:otherwise>
                           </c:choose>
                    </c:forEach>
                             
                    <tr>
						<td align="center" valign="middle"></td>
						<td><p>${curriculumNoonTime.beginTime}</p><p>${curriculumNoonTime.endTime}</p></td>
						<td colspan="5" class="prompt">午餐+午休</td>
				    </tr>
                                 
                    <c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="cat">
                           <c:choose>
                           	   <c:when test="${cat.index==0}">
									<tr>
										<td rowspan="${fn:length(curriculumAfternoonTimeList) }" align="center" valign="middle"><img src="<%=basePath %>assets/global/img/m_img/afternoon.png"></td>
										<td><p>${at.beginTime}</p><p>${at.endTime}</p></td>
										<c:choose>
										   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 1 }">
										      <c:forEach items="${at.curriculumList}" var="as" varStatus="asStat">
										      	<c:if test="${asStat.index<5}">
													<td>${as.subjectName}</td>
												</c:if>
											  </c:forEach>
										   </c:when>
										   <c:otherwise>
										      <c:forEach items="${weekList}" varStatus="asStat2">
										      	 <c:if test="${asStat2.index<5}">
												     <td></td>
												 </c:if>
											  </c:forEach>
										   </c:otherwise>
										</c:choose>
									</tr>
                               </c:when>
                               <c:otherwise>
                                   <tr>
	                                    <td><p>${at.beginTime}</p><p>${at.endTime}</p></td>
	                                    <c:choose>
										    <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 1 }">
										      <c:forEach items="${at.curriculumList}" var="as2" varStatus="as2Stat">
										      	<c:if test="${as2Stat.index<5}">
													<td>${as2.subjectName}</td>
												</c:if>
											  </c:forEach>
										    </c:when>
										    <c:otherwise>
										      <c:forEach items="${weekList}" varStatus="as2Stat2">
										      	 <c:if test="${as2Stat2.index<5}">
													 <td></td>
												 </c:if>
											  </c:forEach>
										    </c:otherwise>
									    </c:choose>
                                 	</tr>
                               </c:otherwise>
                           </c:choose>
		    	    </c:forEach>
			    </c:if>
			 </tbody>
		</table>
		
		<form action="<%=basePath%>todayActivity/toTodayActivityHuXin.do" id="addForm" class="form-horizontal" method="post">
			<input type="hidden" id="roleCode" name="roleCode" value="${roleCode}"> 
			<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}"> 
			<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}"> 
			<input type="hidden" id="clazzId" value="${clazzId}"> 
			<input type="hidden" id="startDate" value="${startDate}"> 
			<input type="hidden" id="semesterId" value="${semesterId}"> 
		    <input type="hidden" id="apiKeyTimeOut" name="apiKeyTimeOut" value="${apiKeyTimeOut}">
		</form>
		
	</div>
	<div class="select_role">
		<dl>
			<c:if test="${roleListSize >1}">
				<dd class="role_more iconfont" data-toggle="modal" href="#static">&#xe601;</dd>
			</c:if>
			<r:right rightCode="todayActivityEdit">
				<c:if test="${roleCode!='parent' && roleCode!='student'}">
					<dd class="role_add iconfont" id="addTodayActivity">&#xe603;</dd>
				</c:if>
			</r:right>
			
			<r:right rightCode="todayActivityEdit">
				<c:if test="${times!=0 && (roleCode!='parent' && roleCode!='student')}">
					<dd class="role_add iconfont" id="editTodayActivity">&#xe603;</dd>
				</c:if>
			</r:right>
			<dd class="role_search iconfont" id="search">&#xe602;</dd>
		</dl>
		<span class="role_img iconfont">&#xe600;</span>
	</div>
	<div class="modal fade" id="static" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
	            <div class="modal-content">
	                <div class="modal-body">
						<ul class="more_role_choose" id="moreRole">
					    	<li id="0">请选择角色</li>
					    	<c:forEach items="${roleList}" var="r">
						       <c:if test="${r.roleCode == 'admin'}">
							  	 <li id="${r.roleCode}">校管</li>
						       </c:if>
						       <c:if test="${r.roleCode == 'president'}">
							  	 <li id="${r.roleCode}">校长</li>
						       </c:if>
						       <c:if test="${r.roleCode == 'departManager'}">
							  	 <li id="${r.roleCode}">部门管理员</li>
						       </c:if>
						       <c:if test="${r.roleCode == 'classLeader'}">
							  	 <li id="${r.roleCode}">班主任</li>
						       </c:if>
						       <c:if test="${r.roleCode == 'teacher'}">
							  	 <li id="${r.roleCode}">教师</li>
						       </c:if>
						       <c:if test="${r.roleCode == 'student'}">
							  	 <li id="${r.roleCode}">学生</li>
						       </c:if>
						        <c:if test="${r.roleCode == 'parent'}">
							  	 <li id="${r.roleCode}">家长</li>
						       </c:if>
						   </c:forEach>
						</ul>
					</div>
	            </div>
	        </div>
	</div>
	
		
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

	<script type="text/javascript">
		$(function() { 
			var timeOut = $("#apiKeyTimeOut").val();
			if(timeOut == '1')
			{
				alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
			}
		
			$(".more_role_choose li").on("click",function(){
				$("#roleCode").val($(this).attr("id"));
				var s=document.getElementById("addForm");
				s.submit();
			});
		
			$("#search").on("click",function(){
				var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				var roleCode = $("#roleCode").val();
				standardPost('<%=basePath%>todayActivity/toTodayActivitySearchAPP.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
			});
			
			$("#addTodayActivity").on("click",function(){
				var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				var roleCode = $("#roleCode").val();
				var clazzId = $("#clazzId").val();
				var startDate = $("#startDate").val();
				standardPost('<%=basePath%>todayActivity/toAddTodayActivityAPP.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode,clazzId:clazzId,startDate:startDate});
			});
			
			$("#editTodayActivity").on("click",function(){
				var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				var roleCode = $("#roleCode").val();
				var clazzId = $("#clazzId").val();
				var semesterId = $("#semesterId").val();
				var startDate = $("#startDate").val();
				standardPost('<%=basePath%>todayActivity/toEditTodayActivityAPP.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode,clazzId:clazzId,semesterId:semesterId,startDate:startDate});
				
			});
			
			$("#role").on("click",function(){
				$("#static").modal("show");
			});
		});
		
		function seturl(){
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var roleCode = $("#roleCode").val();
			standardPost('<%=basePath%>todayActivity/toTodayActivitySearchAPP.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
			
		}
	</script>
	</html>