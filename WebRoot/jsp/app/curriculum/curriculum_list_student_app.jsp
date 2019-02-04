<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>电子课程表</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>电子课程表
	</div>
	<div class="app_search">
	
	<table width="100%" class="teachtable">
		<tbody>
			<tr>
				<td class="bg"></td>
				<td class="bg">一</td>
				<td class="bg">二</td>
				<td class="bg">三</td>
				<td class="bg">四</td>
				<td class="bg">五</td>
				<td class="bg">六</td>
				<td class="bg">日</td>
			</tr>
			<c:if test="${times!=0 }">
			<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="cmt">
				<tr class="set_bg">
					<td><p>${mt.beginTime}</p><p>-</p><p>${mt.endTime}</p></td>
					<c:choose>
					   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 1 }">
					      <c:forEach items="${mt.curriculumList}" var="ms">
							<td>
								<a href="#select_type" data-toggle="modal" onclick="a('${ms.subjectName}','${ms.subjectsUserName}','${ms.classroomName}')">
									<p><b>${ms.subjectName}</b></p>
									<p>${ms.subjectsUserName}</p>
									<p>${ms.classroomName}</p>
								</a>	
							</td>
						  </c:forEach>
					   </c:when>
					   <c:otherwise>
					      <c:forEach items="${weekList}">
							 <td></td>
						  </c:forEach>
					   </c:otherwise>
					</c:choose>
				</tr>
            </c:forEach>
            
             <c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="cat">
             	<c:if test="${cat.index==0}">
	             	<tr>
						<td colspan="8">休息时间</td>
					</tr>
             	</c:if>
                <tr class="set_bg">
	                <td><p>${at.beginTime}</p><p>-</p><p>${at.endTime}</p></td>
	                <c:choose>
						<c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 1 }">
							<c:forEach items="${at.curriculumList}" var="as">
								<td>
									<a href="#select_type" data-toggle="modal" onclick="a('${as.subjectName}','${as.subjectsUserName}','${as.classroomName}')">
										<p><b>${as.subjectName}</b></p>
										<p>${as.subjectsUserName}</p>
										<p>${as.classroomName}</p>
									</a>
								</td>
							</c:forEach>
						</c:when>
						<c:otherwise>
							 <c:forEach items="${weekList}">
								<td></td>
							</c:forEach>
						</c:otherwise>
				 </c:choose>
              	</tr>
		    </c:forEach>
		    
		    <c:forEach items="${curriculumNightTimeList}" var="nt" varStatus="cnt">
             	<c:if test="${cnt.index==0}">
	             	<tr>
						<td colspan="8">休息时间</td>
					</tr>
             	</c:if>
                <tr class="set_bg">
	                <td><p>${nt.beginTime}</p><p>-</p><p>${nt.endTime}</p></td>
	                <c:choose>
						<c:when test="${nt.curriculumList!=null && fn:length(nt.curriculumList) > 1 }">
							<c:forEach items="${nt.curriculumList}" var="ns">
								<td>
									<a href="#select_type" data-toggle="modal" onclick="a('${ns.subjectName}','${ns.subjectsUserName}','${ns.classroomName}')">
										<p><b>${ns.subjectName}</b></p>
										<p>${ns.subjectsUserName}</p>
										<p>${ns.classroomName}</p>
									</a>
								</td>
							</c:forEach>
						</c:when>
						<c:otherwise>
							 <c:forEach items="${weekList}">
								<td></td>
							</c:forEach>
						</c:otherwise>
				 </c:choose>
              	</tr>
		    </c:forEach>
			</c:if>
			<c:if test="${times==0 }">
					<tr height="8%">
						<td style="vertical-align: middle;" align="center" rowspan="4"  class="bg">上午</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td colspan="8">休息时间</td>
					</tr>
					<tr height="8%">
						<td style="vertical-align: middle;" align="center" rowspan="3"
							class="bg">下午</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td colspan="8">休息时间</td>
					</tr>
					<tr height="8%">
						<td style="vertical-align: middle;" align="center" rowspan="3"
							class="bg">晚上</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr height="8%">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</c:if>
		</tbody>
	</table>
	
	<form action="<%=basePath%>curriculum/toSetCurriculumHuXin.do"  id="addForm" class="form-horizontal" method="post">
				
		<input type="hidden" id="roleCode" name="roleCode" value="${roleCode}">
		<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
		<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
		<input type="hidden" id="clazzId"  value="${clazzId}">
		<input type="hidden" id="startDate" value="${startDate}">
		<input type="hidden" id="startTime" value="${startTime}">
		<input type="hidden" id="endDate"  value="${endDate}">
		<input type="hidden" id="endTime"  value="${endTime}">
		<input type="hidden" id="apiKeyTimeOut" name="apiKeyTimeOut" value="${apiKeyTimeOut}">
	</form>
	
	</div>
	
	<div class="select_role">
		<dl>
			<c:if test="${roleListSize >1}">
				<dd class="role_more iconfont" data-toggle="modal" href="#static">&#xe601;</dd>
			</c:if>
			<dd class="role_search iconfont" id="search">&#xe602;</dd>
			<c:if test="${schedule !=0 }">
				<dd class="m_icon-timetable" id="submenu"></dd>
			</c:if>
		</dl>
		<span class="role_img iconfont">&#xe600;</span>
	</div>
	 <div class="modal fade bs-modal-sm" id="static" tabindex="-1" role="dialog" aria-hidden="true">
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
		})
	
		$("#search").on("click",function(){
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var roleCode = $("#roleCode").val();
			standardPost('<%=basePath%>curriculum/toCurriculumListSearchTwoAPP.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
			})
		
		$("#role").on("click",function(){
			$("#static").modal("show");
		})
		
	});
	
	$(function(){
		$(".set_bg td:odd").css("background-color","#e7f4fd");
	})
	
	function seturl()
	{
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var roleCode = $("#roleCode").val();
		standardPost('<%=basePath%>curriculum/toCurriculumListSearchTwoAPP.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
		}
	
	function a(subjectName,subjectsUserName,classroomName)
	{
		$("#sub").text("科目："+subjectName);
		$("#name").text("代课老师："+subjectsUserName);
		$("#classroom").text("教室："+classroomName);
	}
		
	   
	</script>
</html>