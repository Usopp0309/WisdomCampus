<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>作息时间选人设定时间</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
        </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed">
    	<input class="themes" type="hidden" value="<%=basePath%>">
        <!-- 公共顶部开始-->
        <%@ include file="/public_module/public_header.jsp"%>    
        <!--公共顶部结束-->
        <div class="clearfix"> </div>
        <!-- 内容页开始 -->
        <div class="page-container">
            <!--主菜单开始-->
            <%@include file="/public_module/public_menu.jsp"%>
            <!--主菜单结束-->
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">作息时间</a><i class="fa fa-circle"></i></li>
                            <li><span>作息时间选人设定时间</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">修改作息时间表</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                   <form action="<%=basePath%>schedule/doScheduleObjectModify.do" id="modifySubmit" class="form-horizontal" method="post">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3" >起始日期</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input placeholder="开始日期" class="form-control" readonly="readonly" value="${liveingDate}" type="text" name="startDay" id="startDay">
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                <label class="control-label col-md-3" >结束日期</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input placeholder="结束日期" class="form-control" value="${liveingDate}" type="text" name="endDay" id="endDay">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">作用对象</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" disabled="disabled">
														<c:if test="${objectType ==0}">
															<option selected="selected" value="0">老师</option>
															<option value="1">学生</option>
														</c:if>
														<c:if test="${objectType ==1}">
															<option  value="0">老师</option>
															<option selected="selected" value="1">学生</option>
														</c:if>
													</select>
			                                    </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess"></label>
                                                <div class="col-md-9 col-lg-9">
                                                    <c:if test="${objectType ==0}">
												   		<div class="selectObject col-md-4 col-lg-3">
									                       	<p style="text-align: center;text-indent: 0px;">教师</p>
									                       	<ul class="scroller" style="height:260px">
									                       		<c:forEach items="${teacherList}" var="teacher">
										                       		<li id="${teacher.userId}"><i class="select-teacher fa fa-check"></i>${teacher.realName}</li>
									                       		</c:forEach>
									                       	</ul>
								                       </div>
												   </c:if>
												   <c:if test="${objectType ==1}">
												   		<div class="selectObject col-md-4 col-lg-3">
									                       	<p style="text-align: center;text-indent: 0px;">班级</p>
									                       	<ul class="scroller" style="height:260px">
									                       		<c:forEach items="${clazzList}" var="clazz">
										                       		<li id="${clazz.clazzId}" attr="${clazz.gradeId}"><i class="select-clazz fa fa-check"></i>${clazz.clazzName}</li>
									                       		</c:forEach>
									                       	</ul>
								                       </div>
												   </c:if>
                                            </div>
                                            </div>
                                            <input type="hidden" name="objectType" id="objectType" value="${objectType}">
											<input type="hidden" name="liveingDate" id="liveingDate" value="${liveingDate}">
											<input type="hidden" name="teacherList" id="teacherList" value="${teacherList}">
											<input type="hidden" name="clazzList" id="clazzList" value="${clazzList}">
											<input type="hidden" name="departIdOrGradeId" id="departIdOrGradeId" value="${departIdOrGradeId}">
											
											<input type="hidden" name="timeIdMap" id="timeIdMap" value="">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">时间单元</label>
                                                <div class="col-md-9">
                                                    <table class="table table-bordered table-hover schedule_time" id="scheduleTime"></table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
	                                                <button  type="button" class="btn green" id="save">保存</button>
													<button type="button" class="btn" id="cancel">返回</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- END FORM-->
                                </div>
                            </div>
                                </div>
                        </div>
                    </div>
                    </div>
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
		var allDayTimeWeekMap={};
		var amTimeWeekMap={};
		var pmTimeWeekMap={};
		var nightTimeWeekMap={};
		$(function(){  
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","scheduleManage");  
			$('#endDay').datetimepicker({
				 format:"Y-m-d" ,
			     timepicker:false
				});
			$('.time').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});   
			
			//保存
			$("#save").on("click",function(){
				if(checkForm())
				{
					var d_ = layer.msg('正在保存,请稍候。。。',{icon: 16,time:0,shade:0.3});
					$("#modifySubmit").submit();
				}
			})
			
			loadTimeList();
		})
		
		//加载时间段列表
		function loadTimeList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>schedule/getScheduleTimeListByStartDayAndEndDay.do",
				data:{
						startDay : $("#startDay").val(),
						endDay : $("#endDay").val()
					},
				success: function(data){
					var timeList = eval("(" + data + ")");
					var appendHtml = '';
					var type;
					$.each(timeList, function(n, value) 
					{
						if(n==0)
						{
							if(value.type==1)
							{
								appendHtml += '<tr><td colspan="4">上午</td></tr>';
							}
							else if(value.type==2)
							{
								appendHtml += '<tr><td colspan="4">下午</td></tr>';
							}
							else if(value.type==3)
							{
								appendHtml += '<tr><td colspan="4">晚上</td></tr>';
							}
						}
						else
						{
							if(type != value.type)
							{
								if(value.type==1)
								{
									appendHtml += '<tr><td colspan="4">上午</td></tr>';
								}
								else if(value.type==2)
								{
									appendHtml += '<tr><td colspan="4">下午</td></tr>';
								}
								else if(value.type==3)
								{
									appendHtml += '<tr><td colspan="4">晚上</td></tr>';
								}
							}
						}
						
						appendHtml += '<tr><td class="m_width_10"></td><td class="m_width_10">开始<span class="hidden-sm hidden-md">时间</span></td><td class="m_width_10">结束<span class="hidden-sm hidden-md">时间</span></td><td class="m_width_60">作用星期</td></tr>';
						appendHtml += '<tr attr="time'+value.type+'" id="'+value.id+'" >';
						appendHtml += '	<td><i class="td_row"></i></td>';
						appendHtml += '	<td>'+value.beginTime+'</td>';
						appendHtml += '	<td>'+value.endTime+'</td>';
						appendHtml += '	<td><p>'
										+'<span><i class="all_time"></i>全选</span>'
										+'<span><i id="mon" class="day"></i>周一</span>'
										+'<span><i id="tue" class="day"></i>周二</span>'
										+'<span><i id="wed" class="day"></i>周三</span>'
										+'<span><i id="thu" class="day"></i>周四</span>'
										+'<span><i id="fir" class="day"></i>周五</span>'
										+'<span><i id="sat" class="day"></i>周六</span>'
										+'<span><i id="sun" class="day"></i>周日</span>'
										+'</p></td>';
						appendHtml += '</tr>';
						type = value.type;
           			}); 
           			//初始化带选框
           			$("#scheduleTime").html(appendHtml);
           			
           			
           			$(".td_row").on("click",function(){
        				if($(this).hasClass("fa-check")){
        					$(this).removeClass("fa fa-check");
        					$(this).parent().parent().find("p").removeAttr("style");
        				}else{
        					$(this).addClass("fa fa-check");
        					$(this).parent().parent().find("p").show();
        				}
        			});
           			
           			//全选
        			$(".all_time").on("click",function(){
        				var tiemType = $(this).parent().parent().parent().parent().attr("attr");
        				if($(this).hasClass("fa-check")){
        					$(this).parent().parent().find(".day").each(function(){
        						if($(this).hasClass("fa-check"))
        						{
        							var text = $(this).parent().text();
        							if(tiemType == "time0")
               						{
                   						delete allDayTimeWeekMap[text];
               						}
                					else if(tiemType == "time1")
               						{
                						delete amTimeWeekMap[text];
                						
               						}else if(tiemType == "time2")
               						{
               							delete pmTimeWeekMap[text];
               							
               						}else if(tiemType == "time3")
               						{
               							delete nightTimeWeekMap[text];
               						}
        						}
        					});
        					$(this).removeClass("fa fa-check");
        					$(this).parent().parent().find("i").removeClass("fa fa-check");
        				}else{
        					if(tiemType == "time0")
       						{
        						checkMapContain(allDayTimeWeekMap,this,tiemType)
       						}
        					else if(tiemType == "time1")
       						{
        						checkMapContain(amTimeWeekMap,this,tiemType)
   								
       						}else if(tiemType == "time2")
       						{
       							checkMapContain(pmTimeWeekMap,this,tiemType)
   								
       						}else if(tiemType == "time3")
       						{
       							checkMapContain(nightTimeWeekMap,this,tiemType)
       						}
        				}
        			});
        			
           			//单选
           			$(".day").on("click",function(){
           				var tiemType = $(this).parent().parent().parent().parent().attr("attr");
           				var text = $(this).parent().text();
           				if($(this).hasClass("fa-check")){
           					$(this).removeClass("fa fa-check");
           					if(tiemType == "time0")
       						{
           						delete allDayTimeWeekMap[text];
       						}
        					else if(tiemType == "time1")
       						{
        						delete amTimeWeekMap[text];
        						
       						}else if(tiemType == "time2")
       						{
       							delete pmTimeWeekMap[text];
       							
       						}else if(tiemType == "time3")
       						{
       							delete nightTimeWeekMap[text];
       						}
           				}else{
           					if(tiemType == "time0")
       						{
           						if(text in allDayTimeWeekMap)
       							{
       								layer.msg("已有时间段选择"+text+",请勿重复选择");
       								return false;
       							}
           						else
       							{
           							allDayTimeWeekMap[text]=text;
       							}
       						}
        					else if(tiemType == "time1")
       						{
        						if(text in amTimeWeekMap)
       							{
       								layer.msg("上午已有时间段选择"+text+",请勿重复选择");
       								return false;
       							}
           						else
       							{
           							amTimeWeekMap[text]=text;
       							}
        						
       						}else if(tiemType == "time2")
       						{
       							if(text in pmTimeWeekMap)
       							{
       								layer.msg("下午已有时间段选择"+text+",请勿重复选择");
       								return false;
       							}
           						else
       							{
           							pmTimeWeekMap[text]=text;
       							}
       							
       						}else if(tiemType == "time3")
       						{
       							if(text in nightTimeWeekMap)
       							{
       								layer.msg("晚上已有时间段选择"+text+",请勿重复选择");
       								return false;
       							}
           						else
       							{
           							nightTimeWeekMap[text]=text;
       							}
       						}
           					
           					$(this).addClass("fa fa-check");
           				}
           			});
				},
			});

		}
		
		//判断星期map中是否包含某个周几
		function checkMapContain(map,obj,tiemType)
		{
			var mass = ""
			if("周一" in map)
			{
				mass += "周一,";
			}
			else
			{
				map["周一"]="周一";
				$(obj).addClass("fa fa-check");
				$(obj).parent().parent().find("#mon").addClass("fa fa-check");
			}
			if("周二" in map)
			{
				mass += "周二,";
			}
			else
			{
				map["周二"]="周二";
				$(obj).addClass("fa fa-check");
				$(obj).parent().parent().find("#tue").addClass("fa fa-check");
			}
			if("周三" in map)
			{
				mass += "周三,";
			}
			else
			{
				map["周三"]="周三";
				$(obj).addClass("fa fa-check");
				$(obj).parent().parent().find("#wed").addClass("fa fa-check");
			}
			if("周四" in map)
			{
				mass += "周四,";
			}
			else
			{
				map["周四"]="周四";
				$(obj).addClass("fa fa-check");
				$(obj).parent().parent().find("#thu").addClass("fa fa-check");
			}
			if("周五" in map)
			{
				mass += "周五,";
			}
			else
			{
				map["周五"]="周五";
				$(obj).addClass("fa fa-check");
				$(obj).parent().parent().find("#fir").addClass("fa fa-check");
			}
			if("周六" in map)
			{
				mass += "周六,";
			}
			else
			{
				map["周六"]="周六";
				$(obj).addClass("fa fa-check");
				$(obj).parent().parent().find("#sat").addClass("fa fa-check");
			}
			if("周日" in map)
			{
				mass += "周日,";
			}
			else
			{
				map["周日"]="周日";
				$(obj).addClass("fa fa-check");
				$(obj).parent().parent().find("#sun").addClass("fa fa-check");
			}
			
			if(mass != "")
			{
				if(tiemType == "time0")
				{
					layer.msg("已有时间段选择"+mass+"请勿重复选择");
				}
				else if(tiemType == "time1")
				{
					layer.msg("上午已有时间段选择"+mass+"请勿重复选择");
				}else if(tiemType == "time2")
				{
					layer.msg("下午已有时间段选择"+mass+"请勿重复选择");
				}else if(tiemType == "time3")
				{
					layer.msg("晚上已有时间段选择"+mass+"请勿重复选择");
				}
			}
			return true;
		}
		
		function checkForm()
		{
			var timeFlag = true;
			
			var timeIdMapArr = {};
			var weekFlag = false;
            var startDay=$("#startDay").val();			
            var endDay=$("#endDay").val();	
            if (!checkTimeLegal(startDay,endDay))
			{
				layer.tips('结束日期不能小于开始日期', '#endDay');
				return false;
			}
			$(".td_row").each(function(){
				var weekArr =  [];
				if($(this).hasClass("fa-check")){
					$(this).parent().parent().find(".day").each(function(){
						if($(this).hasClass("fa-check"))
						{
							weekArr.push($(this).parent().text());
							weekFlag = false;
						}
					});
					var timeId = $(this).parent().parent().attr("id");
					timeIdMapArr[timeId]=weekArr;
					timeFlag = false;
					var timeType = $(this).parent().parent().attr("attr");
				
					if(timeType == "time0" && Object.getOwnPropertyNames(allDayTimeWeekMap).length<7)
					{
						layer.msg('时间段对应的星期选择不完整');
						weekFlag = true;
						return false;
					}
					if(timeType == "time1" && Object.getOwnPropertyNames(amTimeWeekMap).length<7)
					{
						layer.msg('上午时间段星期选择不完整');
						weekFlag = true;
						return false;
					}
				 	if(timeType == "time2" && Object.getOwnPropertyNames(pmTimeWeekMap).length<7)
					{
				 		layer.msg('下午时间段星期选择不完整');
				 		weekFlag = true;
						return false;
					}
				 	if(timeType == "time3" && Object.getOwnPropertyNames(nightTimeWeekMap).length<7 )
					{
				 		layer.msg('晚上时间星期选择不完整');
				 		weekFlag = true;
						return false;
					}
					
				}
			});
			
			if(weekFlag)
			{
				return false;
			}
			if(timeFlag)
			{
				layer.msg('至少选择一个时间段');
				return false;
			}
			if(weekFlag)
			{
				layer.msg('请选择星期');
				return false;
			}
			
			$("#timeIdMap").val(JSON.stringify(timeIdMapArr));
			
			var objectType = $("#objectType").val();
			if(objectType == 0)//教师
			{
				getTeacherId();
				
			}
			else
			{
				
				getClazzList();
			}
			
			return true;
		}
		
		function getTeacherId()
		{
			var teacherMapArr = {};
			$(".select-teacher").each(function(){
				if($(this).hasClass("fa-check")){
					var teacherId = $(this).parent().attr("id");
					teacherMapArr[teacherId]=$(this).parent().attr("id").replace("T","");
				}
			});
			
			$("#teacherList").val(JSON.stringify(teacherMapArr));
		}
		function getClazzList()
		{
			var clazzList = new Array();
			$(".select-clazz").each(function(){
				if($(this).hasClass("fa-check")){
					var clazz = {};
					var clazzId = $(this).parent().attr("id");
					var gradeId = $(this).parent().attr("attr");
					clazz.clazzId = clazzId;
					clazz.gradeId = gradeId;
					clazzList.push(clazz);
				}
			});
			$("#clazzList").val(JSON.stringify(clazzList));
		}
		function checkTimeLegal(startTime, endTime)
		{

			var flg = false;
			var startDate = new Date(startTime);
			var endDate = new Date(endTime);

			if (startDate > endDate)
			{
				flg = false;
			}
			else
			{
                flg = true
			}	
			return flg;
		}
	</script>
</html>