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
		<i class="m_icon-return icon_left"
			onclick="window.richbook.onFinish();"></i>今日活动
	</div>

	<div class="inout_list">

		<div class="portlet-body">
		
			<form action="<%=basePath%>todayActivity/saveTodayActivityByapiKey.do" class="form-horizontal" name="defform" method="post" id="saveCurriculumTime">
				<div class="activity_time app_search">
					<table class="activity">
						<thead>
							<tr>
								<th class="td_w" style="background-color: #F2CA06">开始</th>
								<th class="td_w" style="background-color: #DA45B6">结束</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2" class="prompt">上午</td>
							</tr>
							<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="mtindex">
								<tr class="morning time">
									<td class="bg">
										<input class="title_input add_title"  value="${mt.beginTime}" name="startTime" id="B${mt.id}"/>
									</td>
									<td class="bg">
										<input value="${mt.endTime}" name="endTime" class="title_input add_title" id="E${mt.id}"/>
									</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="2" class="prompt">午餐+午睡</td>
							</tr>
							<tr class="noon time">
								<td class="bg">
									<input value="${curriculumNoonTime.beginTime}" class="title_input add_title" name="startTime" id="B${curriculumNoonTime.id}" />
								</td>
								<td class="bg">
									<input value="${curriculumNoonTime.endTime}" name="endTime" class="title_input add_title" id="E${curriculumNoonTime.id}" /> 
								</td>
							</tr>
							<tr>
								<td colspan="2" class="prompt">下午</td>
							</tr>
							<c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="atindex">
								<tr class="afternoon time">
									<td class="bg">
										<input value="${at.beginTime}" class="title_input add_title" name="startTime" id="B${at.id}" />
									</td>
									<td class="bg">
										<input value="${at.endTime}" name="endTime" class="title_input add_title" id="E${at.id}" /> 
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<a class="m_btn" id="saveTime">确定作息时间</a>
				</div>
				
				<div class="activity_con">
					<table class="activity">
						<thead>
							<tr>
								<th class="td_w" style="background-color: #E67817">一</th>
								<th class="td_w" style="background-color: #E6677C">二</th>
								<th class="td_w" style="background-color: #68B92E">三</th>
								<th class="td_w" style="background-color: #6C609E">四</th>
								<th class="td_w" style="background-color: #01BADE">五</th>
							</tr>
						</thead>
						<tbody id="activityTbody">
							<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="mtindex">
								<tr class="afternoon-tr">
									<c:forEach items="${mt.curriculumList}" var="ms" varStatus="msindex">
										<c:if test="${msindex.index<5}">
											<td>
												<a href="#static" onclick="inputSub('${ms.id}','${ms.subjectName }')" data-toggle="modal">
													<input id="sub${ms.id}"  value="${ms.subjectName }"/>
												</a>
											</td>
										</c:if>
									</c:forEach>
								</tr>
							</c:forEach>
							<tr id="noon1">
								<td colspan="5" class="lunch-noon">午餐+午休</td>
							</tr>
							<c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="atindex">
								<tr class="afternoon-tr">
									<c:forEach items="${at.curriculumList}" var="as" varStatus="asindex">
										<c:if test="${asindex.index<5}">
											<td>
												<a href="#static" onclick="inputSub('${as.id}','${as.subjectName }')" data-toggle="modal">
													<input id="sub${as.id}" value="${as.subjectName }"/>
												</a>
											</td>
										</c:if>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<a class="m_btn" id="saveActivity">确定</a>
					<input type="hidden" name="clazzId" id="clazzId" value="${clazzId}">
					<input type="hidden" name="roleCode" id="roleCode" value="${roleCode}"> 
					<input type="hidden" name="apiKey" id="apiKey" value="${apiKey}"> 
					<input type="hidden" name="schoolId" id="schoolId" value="${schoolId}">
					<input type="hidden" name="userId" id="userId" value="${userId}">
					<input type="hidden" name=startDate id="startDate" value="${startDate}">
				</div>
			</form>
		</div>
			
	</div>
	
	<div data-keyboard="false" data-backdrop="static" tabindex="-1" class="modal hide fade" id="static" style="display: none;" aria-hidden="true">
		<div class="modal-header">
			<p>每日活动</p>
		</div>
		<div class="modal-body">
			<textarea id="subjectName" style="display: block;height: 150px;margin: 0 auto;padding: 5px;resize: none;width: 95%;"></textarea>
		</div>
		<input type="hidden" name="subId" id="subId" value="">
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" id="editSub" type="button">确定</button>
			<button class="btn" data-dismiss="modal" type="button">取消</button>
		</div>
	</div>

		
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">

		$(function() {   

			var opt={};
			var currYear = (new Date()).getFullYear();
			opt.date = {preset : 'date'};
			opt.datetime = {preset : 'datetime'};
			opt.time = {preset : 'time'};
			opt.default = {
				theme: 'android-ics light', //皮肤样式
		        display: 'modal', //显示方式 
		        mode: 'scroller', //日期选择模式
				dateFormat: 'yyyy-mm-dd',
				lang: 'zh',
				showNow: true,
				nowText: "当前",
		        startYear: currYear-10, //开始年份
		        endYear: currYear + 10 //结束年份
			};
		  	var optTime = $.extend(opt['time'], opt['default']);
		    $(".add_title").mobiscroll(optTime).time(optTime);
		    
			$("#saveTime").on("click",function(){
				var arrList = new Array();
				$(".time").each(function(n){
					var info = {id:'', beginTime:'', endTime:'' };
					var beginTime = $(this).find("input[name ='startTime']").val();
					var endTime = $(this).find("input[name ='endTime']").val();
					var id = $(this).find("input[name ='endTime']").attr("id").replace("E","");
					info.id = id;
					info.beginTime = beginTime;
					info.endTime = endTime;
					arrList[n] = info;
				})
				
				$.ajax({
					url:"<%=basePath %>todayActivity/modifyTimeForApp.do",
					type:"post",
					async:false,
					data:{
						infoList : JSON.stringify(arrList)
						},
					success:function(data){
						var data = eval("(" + data + ")");
						if(data)
						{
							
						}
					}
				});

				$(".activity_con").addClass("m_margin_block");
				$(".activity_time").addClass("m_margin_none");
				$("#sday").text($("#startDay").val());
				$("#eday").text($("#endDay").val());
				
			})
			
			//点击确定保存
		    $("#saveActivity").on("click",function()
		    {
		    	var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				var roleCode = $("#roleCode").val();
				var clazzId = $("#clazzId").val();
				var startDate = $("#startDate").val();
				standardPost('<%=basePath%>todayActivity/toTodayActivityHuXin.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode,clazzId:clazzId,startDate:startDate});
		        
			})
			
			//点击确定按钮保存活动名称
		    $("#editSub").on("click",function(){
		    	$("#sub"+$("#subId").val()).val($("#subjectName").val());
		    	$.ajax({
					type: "post",
					url: "<%=basePath%>todayActivity/modifyActivityName.do",
					data:{
							activityName : $("#subjectName").val(),
							activityId : $("#subId").val()
						},
					success: function(data){
						var data = eval("(" + data + ")");
						if(data)
						{
						}
					},
				});
			})

		});

		function inputSub(id,subjectName)
		{
			$("#subId").val(id);
			$("#subjectName").val(subjectName);
		}

		
	</script>
</html>