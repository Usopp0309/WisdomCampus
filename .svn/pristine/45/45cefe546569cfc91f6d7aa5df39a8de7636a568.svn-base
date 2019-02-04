<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>

<html lang="en">

<head>

<title>每日活动</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<link href="../media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<link href="../media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="../media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<link href="../media/css/style-metro.css" rel="stylesheet" type="text/css" />

<link href="../media/css/style.css" rel="stylesheet" type="text/css" />

<link href="../media/css/style-responsive.css" rel="stylesheet" type="text/css" />

<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css" />

<link href="../media/css/pricing-tables.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="../media/css/select2_metro.css" />

<link rel="stylesheet" href="../media/css/DT_bootstrap.css" />

<link rel="stylesheet" href="../media/js_m/datetimepicker/jquery.datetimepicker.css" />

<link href="../media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />

<link rel="shortcut icon" href="../media/image/favicon.ico" />

</head>

<body class="page-header-fixed" id="body">

	<div class="container-fluid">

		<div class="row-fluid">

			<div class="span12">

				<ul class="breadcrumb">
					<li><i class="icon-home"></i><a href="#">首页</a><i
						class="icon-angle-right"></i></li>
					<li><a href="#">每日活动</a><i class="icon-angle-right"></i></li>
					<li><a href="#">每日活动设定</a></li>
				</ul>

			</div>

		</div>

		<div class="row-fluid">

			<div class="span12">

				<div class="tab-content">

					<div id="tab_4" class="tab-pane active">

						<div class="portlet box green">

							<div class="portlet-title">
								<div class="caption">每日活动</div>
								<div class="tools"> <a class="expand toTeacherList" href="javascript:;"></a> </div>
							</div>

							<div class="portlet-body search_box">

								<div class="control-group margin-bottom_null">

									<div class="public_search_row">
										<div class="width_20">
											<a class="btn blue" id="cancel"><i class="icon-plus"></i>返回</a>
										</div>
								</div>

							</div>
						</div>
						
						</div>


						<div class="portlet-body">
							<p id="modifySu" style="text-align:center;font-size:16px;font-weight:bold;color:#0193DE;display:none">修改成功</p>
							<table class="table syllabus-activity" id="sample_1" >
								<tr class="activity_title">
									<td class="activitybg"><p>阶段</p><p>Phase</p></td>
									<td class="activitybg" colspan="2"><p>时间段</p><p>Time Bucket</p></td>
									<c:forEach items="${weekList}" var="week">
										<c:if test="${week.id == 1}"><td style="background: #E88E0E;"><p>${week.weekName}</p><p>Monday</p></td></c:if>
										<c:if test="${week.id == 2}"><td style="background: #D96F92;"><p>${week.weekName}</p><p>Tuesday</p></td></c:if>
										<c:if test="${week.id == 3}"><td style="background: #48AC5E;"><p>${week.weekName}</p><p>Wednesday</p></td></c:if>
										<c:if test="${week.id == 4}"><td style="background: #8E6EB8;"><p>${week.weekName}</p><p>Thursday</p></td></c:if>
										<c:if test="${week.id == 5}"><td style="background: #489AAC;"><p>${week.weekName}</p><p>Friday</p></td></c:if>
										<c:if test="${week.id == 6}"><td style="background: #DDC030;"><p>${week.weekName}</p><p>Saturday</p></td></c:if>
										<c:if test="${week.id == 7}"><td style="background: #6F45A6;"><p>${week.weekName}</p><p>Sunday</p></td></c:if>
									</c:forEach>
								</tr>
								<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="cmt">
                                      <c:choose>
                                      	   <c:when test="${cmt.index==0}">
												<tr >
													<td rowspan="${fn:length(curriculumMorningTimeList)}"  class="bg" align="center" valign="middle"><img src="<%=basePath %>media/image_m/morning.png"></td>
													<td class="time_st">
														<input value="${mt.beginTime}" class="title_input add_title" id="B${mt.id}"/>
													</td>
													<td class="time_st">
														<input value="${mt.endTime}" class="title_input add_title" id="E${mt.id}"/>
													</td>
												    <c:forEach items="${mt.curriculumList}" var="ms">
														<td><p class="table_title"><input class="activity" id="C${ms.id}" value="${ms.subjectName}"/></p></td>
													</c:forEach>
												</tr>
		                                    </c:when>
		                                    <c:otherwise>
		                                       <tr>
			                                        <td class="time_st">
			                                        	<input value="${mt.beginTime}" name="beginTimeAm" class="title_input add_title" id="B${mt.id}"/>
													</td>
													<td class="time_st">
														<input value="${mt.endTime}" name="endTimeAm" class="title_input add_title" id="E${mt.id}"/>
													</td>
												    <c:forEach items="${mt.curriculumList}" var="ms2">
														<td><p class="table_title"><input class="activity" id="C${ms2.id}" value="${ms2.subjectName}"/></p></td>
													</c:forEach>
												</tr>
		                                    </c:otherwise>
                                      </c:choose>
                                </c:forEach>
                                
                                <tr>
									<td class="bg" align="center" valign="middle"></td>
									<td class="time_st">
										<input value="${curriculumNoonTime.beginTime}" name="beginTimeAm" class="title_input add_title" id="B${curriculumNoonTime.id}"/>
									</td>
									<td class="time_st">
										<input value="${curriculumNoonTime.endTime}" name="endTimeAm" class="title_input add_title" id="E${curriculumNoonTime.id}"/>
									</td>
									<td colspan="7" class="lunch-noon">午餐+午休</td>
							    </tr>
                                    
                                <c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="cat">
                                       <c:choose>
                                      	   <c:when test="${cat.index==0}">
												<tr>
													<td rowspan="${fn:length(curriculumAfternoonTimeList) }"  class="bg" align="center" valign="middle"><img src="<%=basePath %>media/image_m/afternoon.png"></td>
													<td class="time_st">
														<input value="${at.beginTime}" name="beginTimePm" class="title_input add_title" id="B${at.id}"/>
													</td>
													<td class="time_st">
														<input value="${at.endTime}" name="endTimePm" class="title_input add_title" id="E${at.id}"/>
													</td>
											        <c:forEach items="${at.curriculumList}" var="as">
													  <td><p class="table_title"><input class="activity" id="C${as.id}" value="${as.subjectName}"/></p></td>
												    </c:forEach>
												</tr>
		                                    </c:when>
		                                    <c:otherwise>
		                                      <tr>
			                                       <td class="time_st">
			                                       		<input value="${at.beginTime}" name="beginTimePm" class="title_input add_title" id="B${at.id}"/>
			                                       </td>
			                                       <td class="time_st">
														<input value="${at.endTime}" name="endTimePm" class="title_input add_title" id="E${at.id}"/>
			                                       </td>
											       <c:forEach items="${at.curriculumList}" var="as2">
														<td><p class="table_title"><input class="activity" id="C${as2.id}" value="${as2.subjectName}"/></p></td>
												   </c:forEach>
		                                    	</tr>
		                                    </c:otherwise>
                                       </c:choose>
							    </c:forEach>
							</table>
							
							<input type="hidden" id="semesterId" name="semesterId" value="${semesterId}"/>
							<input type="hidden" id="startDay" name="startDay" value="${startDay}"/>
							<input type="hidden" id="roleCode" name="roleCode" value="${roleCode}"/>
							<input type="hidden" id="clazzId" name="clazzId" value="${clazzId}"/>
							<input type="hidden" id="parameter" name="parameter" value=""/>
						</div>

					</div>

				</div>

			</div>

		</div>

	</div>

	<script src="../media/js/jquery-2.1.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>

	<script src="../media/js/bootstrap.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.uniform.min.js" type="text/javascript"></script>

	<script type="text/javascript" src="../media/js/select2.min.js"></script>

	<script type="text/javascript" src="../media/js/jquery.dataTables.min.js"></script>

	<script type="text/javascript" src="../media/js/DT_bootstrap.js"></script>

	<script src="../media/js/table-advanced.js" type="text/javascript" ></script>

	<script src="../media/js/My97DatePicker/WdatePicker.js" type="text/javascript" ></script>
	
	<script src="../media/js_m/datetimepicker/jquery.datetimepicker.js" type="text/javascript" ></script>
	
	<script src="../media/js_m/public_js.js" type="text/javascript" ></script>
	
	<script src="../media/js/app.js" type="text/javascript" ></script>
	
	<script>

		jQuery(document).ready(function() {    
			$('.title_input').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});
		
			App.init();

			//点击取消
		    $("#cancel").on("click",function(){
		    	//开始日期
				var startDate = $("#startDay").val();
				//角色
				var roleCode = $("#roleCode").val();
				//班级Id
				var clazzId = $("#clazzList").val();
				
				standardPost('<%=basePath%>todayActivity/toTodayActivity.do',{roleCode:roleCode,clazzId:clazzId,startDate:startDate});
			})
			
			
			$('.add_title').blur(function(){
				var val = $(this).val();
				var param = $("#parameter").val();
				var timeId = $(this).attr("id");
				if(val!=param)
				{
					modifyTime(timeId,val);
				}
			});

		    $('.add_title').focus(function(){
			    $("#parameter").val($(this).val());
			    $("#modifySu").hide();
			});

		    $('.activity').blur(function(){
				var val = $(this).val();
				var cuId = $(this).attr("id").replace("C","");
				var param = $("#parameter").val();
				if(val!=param)
				{
					modifyActivityName(cuId,val);
				}
			});

		    $('.activity').focus(function(){
			    $("#parameter").val($(this).val());
			    $("#modifySu").hide();
			});
		    
		});

		//修改时间
		function modifyTime(timeId,time)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>todayActivity/modifyTime.do",
				data:{
						time : time,
						timeId : timeId
					},
				success: function(data){
					var data = eval("(" + data + ")");
					if(data)
					{
						$("#modifySu").show();
					}
					
				},
			});
		}
		
		//修改活动名称
		function modifyActivityName(activityId,activityName)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>todayActivity/modifyActivityName.do",
				data:{
						activityName : activityName,
						activityId : activityId
					},
				success: function(data){
					var data = eval("(" + data + ")");
					if(data)
					{
						$("#modifySu").show();
					}
					
				},
			});
		}
		
	</script>

	<!-- END JAVASCRIPTS -->

	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-37564768-1' ]);
		_gaq.push([ '_setDomainName', 'keenthemes.com' ]);
		_gaq.push([ '_setAllowLinker', true ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://'
					: 'http://')
					+ 'stats.g.doubleclick.net/dc.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>
</body>

<!-- END BODY -->

</html>