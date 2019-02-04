<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>编辑电子课程表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->  
 		 <style type="text/css">
 	 		.select2-container{ 
		 		float: left; 
			 	width: 100% !important; 
 		 	} 
	 	</style>      
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
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
	                        <li><a href="javascript:void(0);">电子课程表</a><i class="fa fa-circle"></i></li>
	                        <li><span>电子课程表编辑</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">电子课程表编辑</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                            </div>
	                         <form action="<%=basePath%>curriculum/toSaveCurriculum.do" class="form-horizontal" name="defform" method="post" id="saveCurriculum">
	                            <div class="portlet-body">
									<div class="portlet light form-fit bordered search_box">
				                         <div class="row m_margin_10_auto">
				                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15" id="classDiv" style="display: none;">
				                                <span class="m_span">选择班级：</span>
				                                <select class="m_input form-control" id="clazzList" onchange="searchData();" >
				                                </select>
				                                <span class="m_span">选择时间段：</span>
				                                <select class="m_input form-control" id="semesterIds" onchange="searchData();" >
				                                <c:forEach items="${semesters}" var="semester" varStatus="cmt">
	                                                	<option value="${semester.id }">${semester.beginDate }--${semester.endDate }</option>
	                               				</c:forEach>
				                                </select>
				                                <a  class="btn green" id="deleteB" onclick="deleteCurSem();" >删除</a>
				                         	</div>
		                         		</div>
	                        	  </div>
							<table class="table table-bordered table-hover" >
								<tr>
									<td class="bg m_width_30">起始时间</td>
									<c:forEach items="${weekList}" var="week">
										<td  class="bg m_width_10">${week.weekName}</td>
									</c:forEach>
								</tr>
								<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="cmt">
                                      <c:choose>
                                      	   <c:when test="${cmt.index==0}">
												<tr >
													<td class="bg"> ${mt.beginTime}-${mt.endTime}</td>
													 <c:choose>
													   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 0 }">
													        <c:forEach items="${mt.curriculumList}" var="ms">
															  <td data-toggle="modal" href="#small">
															    <input readonly="readonly"  class="form-control"  name="subjects" id="subjects${cmt.index}"  
															          onclick="opendivshow(${mt.id},${ms.weekId},${semesterId},${ms.id},'${ms.subjectName}','${ms.subjectsUser}','${ms.classroomId}')"
															          value="${ms.subjectName} ${ms.subjectsUserName} ${ms.classroomName}" />
															  </td>
														    </c:forEach>
													   </c:when>
													   <c:otherwise>
													        <c:forEach items="${weekList}" var="mw">
															   <td data-toggle="modal" href="#small">
																   		<input readonly="readonly" class="form-control"  name="subjects"  id="subjects${cmt.index}"  onclick="opendivshow(${mt.id},${mw.id},${semesterId},0,'',0,0)"/>
															   </td>
														    </c:forEach>
													   </c:otherwise>
													 </c:choose>
												</tr>
		                                    </c:when>
		                                    <c:otherwise>
		                                       <tr>
		                                       		<td  class="bg">${mt.beginTime}-${mt.endTime}</td>
											        <c:choose>
													   <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 0 }">
													        <c:forEach items="${mt.curriculumList}" var="ms2">
															  <td data-toggle="modal" href="#small">
															     <input readonly="readonly"  class="form-control" name="subjects" id="subjects${cmt.index}" 
															          onclick="opendivshow(${mt.id},${ms2.weekId},${semesterId},${ms2.id},'${ms2.subjectName}','${ms2.subjectsUser}','${ms2.classroomId}')"
															          value="${ms2.subjectName} ${ms2.subjectsUserName} ${ms2.classroomName}" />
															  </td>
														    </c:forEach>
													   </c:when>
													   <c:otherwise>
													        <c:forEach items="${weekList}" var="mw2">
															   <td data-toggle="modal" href="#small">
															     <input readonly="readonly"  class="form-control" name="subjects" id="subjects${cmt.index}"  onclick="opendivshow(${mt.id},${mw2.id},${semesterId},0,'',0,0)"/>
															   </td>
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
												<td colspan="8" class="m_text_align_conter">休息时间</td>
											   </tr>
												<tr>
													<td class="bg">${at.beginTime}-${at.endTime}</td>
											       	<c:choose>
													   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 0 }">
													        <c:forEach items="${at.curriculumList}" var="as">
															  <td data-toggle="modal" href="#small">
															      <input readonly="readonly" name="subjects" class="form-control" id="subjects${cat.index}" 
															             onclick="opendivshow(${at.id},${as.weekId},${semesterId},${as.id},'${as.subjectName}','${as.subjectsUser}','${as.classroomId}')"
															             value="${as.subjectName} ${as.subjectsUserName} ${as.classroomName}" />
															  </td>
														    </c:forEach>
													   </c:when>
													   <c:otherwise>
													        <c:forEach items="${weekList}" var="aw">
															   <td data-toggle="modal" href="#small">
															       <input readonly="readonly" name="subjects" class="form-control" id="subjects${cat.index}"  onclick="opendivshow(${at.id},${aw.id},${semesterId},0,'',0,0)"/>
															   </td>
														    </c:forEach>
													   </c:otherwise>
													 </c:choose>
												</tr>
		                                    </c:when>
		                                    <c:otherwise>
		                                       <tr>
		                                       		<td class="bg">${at.beginTime}-${at.endTime}</td>
											        <c:choose>
													   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 0 }">
													        <c:forEach items="${at.curriculumList}" var="as2">
															  <td data-toggle="modal" href="#small">
															    <input readonly="readonly" name="subjects" class="form-control" id="subjects${cat.index}"  
															           onclick="opendivshow(${at.id},${as2.weekId},${semesterId},${as2.id},'${as2.subjectName}','${as2.subjectsUser}','${as2.classroomId}')"
															           value="${as2.subjectName} ${as2.subjectsUserName} ${as2.classroomName}" />
															  </td>
														    </c:forEach>
													   </c:when>
													   <c:otherwise>
													        <c:forEach items="${weekList}" var="aw2">
															   <td data-toggle="modal" href="#small">
															   <input readonly="readonly" name="subjects" class="form-control" id="subjects${cat.index}"  onclick="opendivshow(${at.id},${aw2.id},${semesterId},0,'',0,0)"/></td>
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
												<td colspan="8" class="m_text_align_conter">休息时间</td>
											   </tr>
												<tr>
													<td class="bg">${nt.beginTime}-${nt.endTime}</td>
											        <c:choose>
													   <c:when test="${nt.curriculumList!=null && fn:length(nt.curriculumList) > 0 }">
													        <c:forEach items="${nt.curriculumList}" var="ns">
															  <td data-toggle="modal" href="#small">
																 <input readonly="readonly" class="form-control" name="subjects" id="subjects${cnt.index}"  
																     onclick="opendivshow(${nt.id},${ns.weekId},${semesterId},${ns.id},'${ns.subjectName}','${ns.subjectsUser}','${ns.classroomId}')"
																 	 value="${ns.subjectName} ${ns.subjectsUserName} ${ns.classroomName}" />
															  </td>
														    </c:forEach>
													   </c:when>
													   <c:otherwise>
													        <c:forEach items="${weekList}" var="nw">
															   <td data-toggle="modal" href="#small">
															   <input readonly="readonly" class="form-control" name="subjects" id="subjects${cnt.index}"  onclick="opendivshow(${nt.id},${nw.id},${semesterId},0,'',0,0)"/></td>
														    </c:forEach>
													   </c:otherwise>
													 </c:choose>
												</tr>
		                                    </c:when>
		                                    
		                                    <c:otherwise>
		                                       <tr>
		                                       		<td class="bg">${nt.beginTime}-${nt.endTime}</td>
											        <c:choose>
													   <c:when test="${nt.curriculumList!=null && fn:length(nt.curriculumList) > 0 }">
													        <c:forEach items="${nt.curriculumList}" var="ns2">
															  <td data-toggle="modal" href="#small">
																 <input readonly="readonly" name="subjects" id="subjects${cnt.index}" 
																    onclick="opendivshow(${nt.id},${ns2.weekId},${semesterId},${ns2.id},'${ns2.subjectName}','${ns2.subjectsUser}','${ns2.classroomId}')"
																    value="${ns2.subjectName} ${ns2.subjectsUserName} ${ns2.classroomName}" />
															  </td>
														    </c:forEach>
													   </c:when>
													   <c:otherwise>
													        <c:forEach items="${weekList}" var="nw2">
															   <td data-toggle="modal" href="#small">
															   <input readonly="readonly" name="subjects" id="subjects${cnt.index}"  onclick="opendivshow(${nt.id},${nw2.id},${semesterId},0,'',0,0)"/></td>
														    </c:forEach>
													   </c:otherwise>
													 </c:choose>
												</tr>
		                                    </c:otherwise>
                                     </c:choose>
								</c:forEach>
							</table>
							   <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:choose>
									       <c:when test="${roleList.roleCode == 'admin' || roleList.roleCode == 'president' }">
												<input type="hidden" id="userId" name="userId" value="${user.userId}"/>
												<input type="hidden" id="roleCode" name="roleCode" value="${roleList.roleCode}"/>
												<input type="hidden" id="userName" name="userName" value="${user.userId}"/>
									       </c:when>
									       <c:otherwise>
									           <input type="hidden" id="userId" name="userId" value=""/>
											   <input type="hidden" id="roleCode" name="roleCode" value=""/>
											   <input type="hidden" id="userName" name="userName" value=""/>
									       </c:otherwise>
									   </c:choose>
									</c:forEach>
							<input type="hidden" id="semesterId" name="semesterId" value="${semesterId}"/>
							<input type="hidden" id="clazzId" name="clazzId" value="${clazzId}"/>
							<input type="hidden" id="timeId" name="timeId" value=""/>
							<input type="hidden" id="weekId" name="weekId" value=""/>
							<input type="hidden" id="id" name="id" value=""/>
							
							<div id="curriculum" ></div>
							<!-- 弹窗开始  大小参数：modal-lg, modal-sm-->
						    <div class="modal fade" id="small" role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-md">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">电子课程表编辑</h4>
						                </div>
						                <div class="modal-body form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">科目名称</label>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control" name="subjectName" id="subjectName">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">代课老师</label>
                                                <div class="col-md-8">
                                                    <select class="form-control select2me m_select asset_person" name="subjectTeacher" id="subjectTeacher"> </select>
                                                </div>
                                                <input type="hidden" name="respSubject" id="respSubject">
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">上课地点</label>
                                                <div class="col-md-8">
                                                    <select class="form-control" name="classroom" id="classroomSelect"> </select>
                                                </div>
                                            </div>
                                        </div>
										</div>
						                <div class="modal-footer">
						                    <button type="button" class="btn green" data-dismiss="modal" onclick="show()">确定</button>
						                    <button type="button" class="btn" data-dismiss="modal">取消</button>
						                </div>
						            </div>
						        </div>
						    </div>
						    
						    <!-- 弹窗结束 -->
						</form>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
						<botton style="background-color:#f0f0f0;width:100px;" class="btn btn-sm" id="cancel">返回</botton>
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
		$(function() {  
			loadSubMenu("curriculum"); 
			//选取当前菜单位置
			setActive("curriculum","curriculumManager");
			$('#startDate,#endDate').datetimepicker(/* {
				format:'Y-m-d',
				timepicker:false
			} */);
			subjectTeacherList(null);
			classroomNameList(null)
			var userId = $("#userId").val();
			var roleCode = $("#roleCode").val();
			var userName = $("#userName").val();
			if(userName != null && userName != ''){
				$("#classDiv").css("display","block");
			}
			if(userId != null && userId != ''){
				loadclazzList(userId, "curriculumManager",roleCode);
			}else{
				$("#clazzList").attr("style","display: none;");
			}
			//点击确定保存
		    $("#save").on("click",function()
		    {
		    	$("#editCurriculum").submit();
			})
			
			//点击返回
		    $("#cancel").on("click",function(){
				//班级Id
				var userId = $("#userId").val();
				var clazzId = $("#clazzId").val();
				var roleCode = $("#roleCode").val();
				if(userId == null || userId == ''){
					roleCode = "classLeader";
				}
					standardPost('<%=basePath%>curriculum/toSetCurriculum.do',{clazzId:clazzId,roleCode:roleCode});
			})
			
			
			$("#subjectTeacher").change(function(){
				
				//学期Id
				var semesterId = $("#semesterId").val();
				//时间Id
				var timeId = $("#timeId").val();
				//星期Id
				var weekId = $("#weekId").val();
				// 教师Id
				var teacherId = $("#subjectTeacher").val();
				
				checkTeacher(semesterId,timeId,weekId,teacherId);
			});
			
			$("#classroomSelect").change(function(){
				
				//学期Id
				var semesterId = $("#semesterId").val();
				//时间Id
				var timeId = $("#timeId").val();
				//星期Id
				var weekId = $("#weekId").val();
				//教室Id
				var classroomId = $("#classroomSelect").val();
				
				checkClassroom(semesterId,timeId,weekId,classroomId);
			});

		});
		
		function opendivshow(timeId,weekId,semesterId,id,subjectName,subjectsUserId,classroomId){
			$("#timeId").val(timeId);
			$("#weekId").val(weekId);
			$("#semesterId").val(semesterId);
			$("#id").val(id);
			$("#subjectName").val(subjectName);
			var teacherId ;
			if(subjectsUserId == "")
			{
				subjectsUserId = "0";
				teacherId = parseInt(subjectsUserId);
			}else{
				teacherId = parseInt(subjectsUserId);
			}
			$("#subjectTeacher").val(teacherId);
			var r = $('#subjectTeacher option:selected').text();
			$("#select2-subjectTeacher-container").attr("title",r);
  			$("#select2-subjectTeacher-container").text(r);
			
			var cid ;
			if(classroomId == "")
			{
				classroomId = "0";
				cid = parseInt(classroomId);
			}else{
				cid = parseInt(classroomId);
			}
			$("#classroomSelect").val(cid);
			$("#select2-classroomSelect-container").attr("title",r);
  			$("#select2-subjectTeacher-container").text(r);
			//openDivPage('400','200','1','编辑课程表');
		}
		
		function show(){
			var subjectName = $("#subjectName").val();
			var subjectTeacher = $("#subjectTeacher").val();
			if(subjectName == "")
			{
				layer.msg('科目名称不能为空！');
			}else if(subjectName.length>20){
				layer.msg('请简述科目名称！');
			}else
			{
				var a=document.getElementById("saveCurriculum");
				a.action="<%=basePath%>curriculum/toSaveCurriculum.do";
				a.submit();
			}
		}
		

// 		function colsedivs(){
// 			//学期Id
// 			var semesterId = $("#semesterId").val();
// 			//班级Id
// 			var clazzId = $("#clazzId").val();
<%-- 			standardPost('<%=basePath%>curriculum/toClassLeaderEditCurriculum.do',{semesterId:semesterId,clazzId:clazzId}); --%>
// 		}
		
		
		// 校验教师是否存在
		function checkTeacher(semesterId,timeId,weekId,teacherId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>curriculum/checkTeacher.do",
				data : {
					semesterId : semesterId,
					timeId : timeId,
					weekId : weekId,
					teacherId : teacherId
				},
				success : function(data) {

					var result = eval("(" + data + ")");
					
					if ("success" == result.resultCode)
					{
						alert("该教师在此时间已有课程，请重新选择！");
						$("#subjectTeacher").val(0);
					}
				},
			});
		}
		
		// 校验教室是否存在
		function checkClassroom(semesterId,timeId,weekId,classroomId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>curriculum/checkClassroom.do",
				data : {
					semesterId : semesterId,
					timeId : timeId,
					weekId : weekId,
					classroomId : classroomId
				},
				success : function(data) {

					var result = eval("(" + data + ")");
					
					if ("success" == result.resultCode)
					{
						alert("该教室在此时间已被占用，请重新选择！");
						
						$("#classroomSelect").val(0);
					}
				},
			});
		}
		
		// 加载教师列表
		function subjectTeacherList(name)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>curriculum/getSubjectTeacherList.do",
				data : {
					name:name
				},
				success : function(data) {
					var teacherList = eval("(" + data + ")");
					var appendHtml = '<option value="0">---请选择---</option>';
					$.each(teacherList, function(n, value) {
						appendHtml += '<option value="' + value.userId + '">' + value.realName + '</option>';
					});
					$("#subjectTeacher").html(appendHtml);
					
	      			$("#subjectTeacher").val(name);
	      			
	      			var respSubject = $('#subjectTeacher option:selected').text();
	      			if(respSubject == "")
	   				{
	      				$("#subjectTeacher").val("");
	      				respSubject="---请选择---";
	   				}
	      			$("#subjectTeacher").change(function(){
	    				$("#respSubject").val($('#subjectTeacher option:selected').text());
	    			});
	      			$("#respSubject").val(respSubject);
	      			$("#select2-subjectTeacher-container").attr("title",respSubject);
	      			$("#select2-subjectTeacher-container").text(respSubject);
				},
			});
		}
		
		// 加载教室列表
		function classroomNameList(name)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>curriculum/getclassroomNameList.do",
				data : {
					name:name
				},
				success : function(data) {

					var classroomList = eval("(" + data + ")");

					var appendHtml = '<option value="0">---请选择---</option>';
					$.each(classroomList, function(n, value) {
						appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
					});
					$("#classroomSelect").html(appendHtml);
				},
			});
		}
		function searchData(){
			//页面初始化时候的数据加载
			var clazzId = $("#clazzList").val();
			var semesterId = $("#semesterId").val();
			standardPost('<%=basePath%>curriculum/toClassLeaderEditCurriculum.do',{semesterId:semesterId,clazzId:clazzId});
			
		}
		function searchData1(){
			//页面初始化时候的数据加载
			var clazzId = $("#clazzList").val();
			var semesterId = $("#semesterIds").val();
			standardPost('<%=basePath%>curriculum/toClassLeaderEditCurriculum.do',{semesterId:semesterId,clazzId:clazzId});
			
		}
		function deleteCurSem(){
			var semesterId = $("#semesterIds").val();
			var clazzId = $("#clazzList").val();
			
			if(semesterId == null || semesterId == ''){
				layer.msg('没有对应的数据', { icon: 0});
			}else{
				
				layer.msg('你确定要删除吗？', {
					  time: 0 //不自动关闭
					  ,btn: ['确定', '取消']
					  ,yes: function(index){
					    layer.close(index);
					    
						$.ajax({
							type: "post",
							url: "<%=basePath%>curriculum/deleteCurriculumByClazzIdAndSemesterId.do",
							data : {
								semesterId : semesterId,
								clazzId : clazzId

							},
							success : function(data) {

								var ret = eval("(" + data + ")");
								if(ret==1){
									 layer.msg('删除成功', { icon: 1});
									standardPost('<%=basePath%>curriculum/toSetCurriculum.do',{});
								}else{
									 layer.msg('删除失败', { icon: 2});
								}					
							},
						});
					  }
				
					});
			}
		
		
		}
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

					var appendHtml='';
					$.each(clazzList, function(n, value) {
						appendHtml += '<option value="' + value.id + '">'
								+ value.clazzName + '</option>';
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
					
				},
			});
		}
	</script>

	</html>