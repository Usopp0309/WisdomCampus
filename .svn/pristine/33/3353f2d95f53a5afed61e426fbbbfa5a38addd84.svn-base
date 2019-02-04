<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>教师考勤统计</title>
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
	                        <li><a href="javascript:void(0);">考勤统计</a><i class="fa fa-circle"></i></li>
	                        <li><span>教师考勤统计列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">教师考勤统计列表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    <div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs">
										<li class="active"><a>教师统计</a></li>
										<li><a href="<%=basePath %>check/toCheckReportStudent.do" target="_self">学生统计</a></li>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light bordered search_box">
		                         <div class="row">
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<span class="m_span">选择时间：</span>
		                         		<input type="text"  name="startTime" id="startTime"  class="form-control m_input"/>
		                         	</div>
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<span class="m_span">部门：</span>
		                         		<select class="m_select form-control"  id="departmentSelect" name="departmentId"></select>
					                </div>
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<button type="button" class="btn green" id="search">查找</button>
										<input type="hidden" value="" name="checkStatus" id="checkStatus"/>
		                         	</div>
		                         </div>
	                        </div>
	                     
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>考勤统计</div>
	                            </div>
	                            <div class="portlet-body m_overflow_hidden">
										<c:if test="${type eq 0 }">
												<div id="firstDiv">
													<div class="col-md-12 col-sm-12 col-lg-6 m_text_align_conter">
														
												 		<div id="amChart" class="chart" style="height: 600px;"></div>
														<div class="row " id="amNotFound" style="display:none;">
															<img src="<%=basePath%>assets/global/img/m_img/am.png">
														</div>
													</div>
											  	</div>
												<div class="col-md-12 col-sm-12 col-lg-6 m_text_align_conter">
												 	<div id="pmChart" class="chart" style="height: 600px;"></div>
													<div class="row" id="pmNotFound" style="display:none;">
															<img src="<%=basePath%>assets/global/img/m_img/pm.png">
													</div>
												</div>
											
										</c:if>
										<c:if test="${type eq 1 }">
											<div  id="secondDiv">
												<div class="col-md-12 col-sm-12 col-lg-12">
												 	<div id="totalChart" style="width: 600px;height:600px;"></div>
													<div class="row m_text_align_conter" id="totalNotFound" style="display:none;">
															<img src="<%=basePath%>assets/global/img/null_img.jpg">
													</div>
												</div>
											</div>
										</c:if>	
								
							<div class="row">
								<div class="col-md-12 col-sm-12 col-lg-12" id="inoutAbnormalDetail" style="display:none;">
		                            <div class="note note-success">
	                                        <h3>(<span id="itemName" class="font-red-mint"></span>)人员详情</h3>
	                                    </div>
									<table class="table table-bordered table-hover">
										<thead>
											<tr>
												<th>部门</th>
												<th>工号</th>
												<th>姓名</th>
												<th>状态</th>
												<th>刷卡时间</th>
											</tr>
										</thead>
										<tbody id="tbody">
										</tbody>
									</table>
									<!-- 分页开始 -->
				                        <%@include file="/public_module/public_page.jsp" %>
				                    <!-- 分页结束 -->
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
</html>
	<script src="<%=basePath%>assets/global/plugins/echarts.js"></script>
	<script src="<%=basePath%>assets/pages/flot/attendance.js"></script>
	<script type="text/javascript">
		var totalChart;
	    var amChart;
	    var pmChart;
	    var amTotalDataList = new Attendance();
	    var pmTotalDataList = new Attendance();
	    var totalDataList = new Attendance();
	    var list = null;
	    var paramsValue = null;
	    var paramsName = null;
		$(function(){
			loadSubMenu("attendance"); 
			//选取当前菜单位置
			setActive("attendance","attendanceReport");      
			$('#startTime').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			});
			var myDate=new Date();
			var m=myDate.getMonth()+1;
			var d=myDate.getDate();
			m=m<10?"0"+m:m;
			d=d<10?"0"+d:d;
			$("#startTime").val(myDate.getFullYear()+"-"+m+"-"+d);

			//初始化部门select
			loadDepartmentList(); 

			//初始化图表
			if(${type} == 0){
				amChart = echarts.init(document.getElementById('amChart'));
				pmChart = echarts.init(document.getElementById('pmChart'));
				loadAmTotalData();
				loadPmTotalData();

				//加载点击事件
				amChart.on('click', function (params) {
					var value = params.value;
					var name = params.name;
					paramsValue = params.value;
					paramsName = params.name;
					pieClick(${type},value,name,null);
		    	});
				pmChart.on('click', function (params) {
					var value = params.value;
					var name = params.name;
					paramsValue = params.value;
					paramsName = params.name;
					pieClick(${type},value,name,null);
		    	});
			}else{
				totalChart = echarts.init(document.getElementById('totalChart'));
				loadTotalData();

				//加载点击事件
				totalChart.on('click', function (params) {
					var value = params.value;
					var name = params.name;
					paramsValue = params.value;
					paramsName = params.name;
					pieClick(${type},value,name,null);
		    	});
			}
			
			
			
			//查找全校统计
			$("#search").click(function(){
				if(${type} == 0){
					loadAmTotalData();
					loadPmTotalData();
				}else{
					loadTotalData();
				}

			});
			
			//导出数据
			$("#export").click(function(){
				
				//开始时间
				var startTime = $("#startTime").val();
				//结束时间
				var endTime = $("#endTime").val();
				//部门ID
				var departmentId = $("#departmentSelect").val();
				//查询内容
				var queryContent = encodeURI(encodeURI($("#queryContent").val()));
				//用户ID
				var userId = $("ul li.active").find('a').attr("attr1");
				//角色ID
				var roleId = $("ul li.active").find('a').attr("attr2");
				
				var list = null;
				
				var type = $("#depart").val();
				if (type== 5)
	            { 
	               list = amTotalDataList._getOnWorkNormalList();
	            }
				else if (type== 2)
	            { 
	               list = amTotalDataList._getLatelList();
	            }
				else if (type== 3)
	            { 
	               list = amTotalDataList._getLeavelList();
	            }
				else if (type== 4)
	            { 
	               list = amTotalDataList._getOffWorkNormalList();
	            }
				else if (type== 1)
	            { 
	               list = amTotalDataList._getAbsenteeismList();
	            }
				else if (type== 6)
	            { 
	               list = amTotalDataList._getAbnormalInList();
	            }
				else if (type== 7)
	            { 
	               list = amTotalDataList._getAbnormalOutList();
	            }
				else if (type== 11)
	            { 
	               list = pmTotalDataList._getOnWorkNormalList();
	            }
				else if (type== 12)
	            { 
	               list = pmTotalDataList._getOffWorkNormalList();
	            }
				else if (type== 9)
	            { 
	               list = pmTotalDataList._getLatelList();
	            }
				else if (type== 10)
	            { 
	               list = pmTotalDataList._getLeavelList();
	            }
				else if (type== 8)
	            { 
	               list = pmTotalDataList._getAbsenteeismList();
	            }
				else if (type== 13)
	            { 
	               list = pmTotalDataList._getAbnormalInList();
	            }
				else if (type== 14)
	            { 
	               list = pmTotalDataList._getAbnormalOutList();
	            }
				else if (type== 22)
	            { 
	               list = totalDataList._getOnWorkNormalList();
	            }
				else if (type== 23)
	            { 
	               list = totalDataList._getLatelList();
	            }
				else if (type== 24)
	            { 
	               list = totalDataList._getLeavelList();
	            }
				else if (type== 25)
	            { 
	               list = totalDataList._getOffWorkNormalList();
	            }
				else if (type== 26)
	            { 
	               list = totalDataList._getAbsenteeismList();
	            }
				else if (type== 27)
	            { 
	               list = totalDataList._getAbnormalInList();
	            }
				else if (type== 28)
	            { 
	               list = totalDataList._getAbnormalOutList();
	            }
	            var jsonObj =  JSON.stringify(list);
	            
				//standardPost('<%=basePath%>check/doExportExcelTeacherRecord.do',{userId:userId,roleId:roleId,departmentId:departmentId,queryContent:queryContent,jsonObj:jsonObj});
				$.ajax({
				type: "post",
				url: "<%=basePath%>check/doExportExcelTeacherRecord.do",
				data:{
						jsonObj : jsonObj,
						roleId : roleId,
						userId : userId,
						departmentId : departmentId,
						queryContent : queryContent
					},
				success: function(data){
					window.location.href="<%=basePath%>temp/excel/kaoqintongji.xls";
				},
			  });
			});

		});
		
		//加载部门列表
		function loadDepartmentList()
		{
			$.ajax({
				type: "post",
				async:false,
				url: "<%=basePath%>depart/getDepartList.do",
				data:{
					permissionCode : "attendanceStatisticsManager"
					},
				success: function(data){
					var departmentList = eval("(" + data + ")");
					var appendHtml = '<option value="all">--请选择--</option>';
					$.each(departmentList, function(n, value) {
           				appendHtml += '<option value="' + value.id + '">' + value.departmentName + '</option>';
           			}); 
           			$("#departmentSelect").html(appendHtml);
				},
			});
		}
		
		//加载总数据
		//time 时间
		//type 0:早退  1:迟到
		function loadTotalData()
		{
			var time = $("#startTime").val();
			var departmentId = $("#departmentSelect").val();
			var departmentName = $("#departmentSelect option:selected").text();
			if(departmentId == 'all'){
				departmentName = '全体教职工';
			}
			$("#inoutAbnormalDetail").hide();
			var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			$.ajax({
				type: "post",
				url: "<%=basePath%>check/loadTotalData.do",
				data:{
					time : time,
					departmentId : departmentId	
				},
				success: function(data){
					var total = $.parseJSON(data);
					totalDataList._setOnWorkNormalList(total.onWorkNormalList);
					totalDataList._setOffWorkNormalList(total.offWorkNormalList);
					totalDataList._setLatelList(total.latelList);
					totalDataList._setLeavelList(total.leavelList);
					totalDataList._setAbsenteeismList(total.absenteeismList);
					totalDataList._setAbnormalInList(total.abnormalInList);
					totalDataList._setAbnormalOutList(total.abnormalOutList);
					
					var onWorkNormalCount = total.onWorkNormalList.length;//正常上班人数
					var offWorkNormalCount = total.offWorkNormalList.length;//正常下班人数
					var latelCount = total.latelList.length;//迟到人数
					var leavelCount = total.leavelList.length;//早退人数
					var absenteeismCount = total.absenteeismList.length;//旷工人数
					var abnormalInCount = total.abnormalInList.length;//非正常进
					var abnormalOutCount = total.abnormalOutList.length;//非正常出
					var sum = total.sum;//学校总人数
					var other = sum-onWorkNormalCount-latelCount-absenteeismCount;//学校总人数
					if(other<0){
					     other = 0;
					}
					
					
					//未查询到统计数据
					if (onWorkNormalCount == 0&&offWorkNormalCount == 0&&latelCount == 0&&leavelCount == 0&&absenteeismCount == 0)
					{
						$("#totalNotFound").show();
						$("#totalChart").hide();
					}
					else
					{
						$("#totalChart").show();
						$("#totalNotFound").hide();
					     var option = {
						    	 title:{
						    		 text: '['+departmentName+']考勤统计',
						    	     subtext: '',
						    	     x:'center'
							    	     },
						         tooltip: {
						             show: true,
						             formatter: "{a} <br/>{b} : {c} ({d}%)"
						         },
						         legend: {
						        	 orient: 'vertical',
						             left: 'right',
						        	 data: ['正常上班','迟到','正常下班','早退','旷工']
						         },
						         series : [
						             {
						            	 name: '考勤统计',
								            type: 'pie',
								            radius: '50%',
								            data:[
								                {value:onWorkNormalCount, name:'正常上班'},
								                {value:latelCount, name:'迟到'},
								                {value:offWorkNormalCount, name:'正常下班'},
								                {value:leavelCount, name:'早退'},
								                {value:absenteeismCount, name:'旷工'},
								            ],
						             }
						         ]
						     };
						     // 为echarts对象加载数据 
						     totalChart.setOption(option); 
					}
					layer.close(indexlayer);
				},
			});
		}
		
		//加载总数据(上午)
		//time 时间
		//type 0:早退  1:迟到
		function loadAmTotalData()
		{
			var time = $("#startTime").val();
			var departmentId = $("#departmentSelect").val();
			var departmentName = $("#departmentSelect option:selected").text();
			if(departmentId == 'all'){
				departmentName = '全体教职工';
			}
			$("#inoutAbnormalDetail").hide();
			var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			$.ajax({
				type: "post",
				url: "<%=basePath%>check/loadAmTotalData.do",
				data:{
					time : time,
					departmentId : departmentId		
				},
				success: function(data){
					var total = $.parseJSON(data);
					amTotalDataList._setOnWorkNormalList(total.onWorkNormalList);
					amTotalDataList._setOffWorkNormalList(total.offWorkNormalList);
					amTotalDataList._setLatelList(total.latelList);
					amTotalDataList._setLeavelList(total.leavelList);
					amTotalDataList._setAbsenteeismList(total.absenteeismList);
					amTotalDataList._setAbnormalInList(total.abnormalInList);
					amTotalDataList._setAbnormalOutList(total.abnormalOutList);
					
					var amOnWorkNormalCount = total.onWorkNormalList.length;//正常上班人数
					var amOffWorkNormalCount = total.offWorkNormalList.length;//正常下班人数
					var amLatelCount = total.latelList.length;//迟到人数
					var amLeavelCount = total.leavelList.length;//早退人数
					var amAbsenteeismCount = total.absenteeismList.length;//旷工人数
					var amAbnormalInCount = total.abnormalInList.length;//非正常进
					var amAbnormalOutCount = total.abnormalOutList.length;//非正常出
					var sum = total.sum;//学校总人数
					var other = sum-amOnWorkNormalCount-amLatelCount-amAbsenteeismCount;//学校总人数
					if(other<0){
					     other = 0;
					}
					
					
					//未查询到统计数据
					if (amOnWorkNormalCount == 0&&amOffWorkNormalCount == 0&&amLatelCount == 0&&amLeavelCount == 0&&amAbsenteeismCount == 0)
					{
						$("#amNotFound").show();
						$("#amChart").hide();
					}
					else
					{
						$("#amChart").show();
						$("#amNotFound").hide();
						var option = {
						    	 title:{
						    		 text: '['+departmentName+']上午考勤统计',
						    	     subtext: '',
						    	     x:'center'
							    	     },
						         tooltip: {
						             show: true,
						             formatter: "{a} <br/>{b} : {c} ({d}%)"
						         },
						         legend: {
						        	 orient: 'vertical',
						             left: 'left',
						        	 data: ['上午正常上班','上午迟到','上午正常下班','上午早退','上午旷工']
						         },
						         series : [
						             {
						            	 name: '考勤统计',
								            type: 'pie',
								            radius: '50%',
								            data:[
								                {value:amOnWorkNormalCount, name:'上午正常上班'},
								                {value:amLatelCount, name:'上午迟到'},
								                {value:amOffWorkNormalCount, name:'上午正常下班'},
								                {value:amLeavelCount, name:'上午早退'},
								                {value:amAbsenteeismCount, name:'上午旷工'},
								            ],
						             }
						         ]
						     };
						     // 为echarts对象加载数据 
						     amChart.setOption(option); 
					}
					layer.close(indexlayer);
				},
			});
		}

		//加载总数据(下午)
		//time 时间
		//type 
		function loadPmTotalData()
		{
			var time = $("#startTime").val();
			var departmentId = $("#departmentSelect").val();
			var departmentName = $("#departmentSelect option:selected").text();
			if(departmentId == 'all'){
				departmentName = '全体教职工';
			}
			$("#inoutAbnormalDetail").hide();
			var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			$.ajax({
				type: "post",
				url: "<%=basePath%>check/loadAmTotalData.do",
				data:{
					time : time,
					departmentId : departmentId		
				},
				success: function(data){
					var total = $.parseJSON(data);
					pmTotalDataList._setOnWorkNormalList(total.onWorkNormalList);
					pmTotalDataList._setOffWorkNormalList(total.offWorkNormalList);
					pmTotalDataList._setLatelList(total.latelList);
					pmTotalDataList._setLeavelList(total.leavelList);
					pmTotalDataList._setAbsenteeismList(total.absenteeismList);
					pmTotalDataList._setAbnormalInList(total.abnormalInList);
					pmTotalDataList._setAbnormalOutList(total.abnormalOutList);
					
					var pmOnWorkNormalCount = total.onWorkNormalList.length;//正常上班人数
					var pmOffWorkNormalCount = total.offWorkNormalList.length;//正常下班人数
					var pmLatelCount = total.latelList.length;//迟到人数
					var pmLeavelCount = total.leavelList.length;//早退人数
					var pmAbsenteeismCount = total.absenteeismList.length;//旷工人数
					var pmAbnormalInCount = total.abnormalInList.length;//非正常进
					var pmAbnormalOutCount = total.abnormalOutList.length;//非正常出
					var sum = total.sum;//学校总人数
					
					
					//未查询到统计数据
					if (pmOnWorkNormalCount == 0&&pmOffWorkNormalCount == 0&&pmLatelCount == 0&&pmLeavelCount == 0&&pmAbsenteeismCount == 0)
					{
						$("#pmNotFound").show();
						$("#pmChart").hide();
					}
					else
					{
						$("#pmChart").show();
						$("#pmNotFound").hide();
						var option = {
						    	 title:{
						    		 text: '['+departmentName+']下午考勤统计',
						    	     subtext: '',
						    	     x:'center'
							    	     },
						         tooltip: {
						             show: true,
						             formatter: "{a} <br/>{b} : {c} ({d}%)"
						         },
						         legend: {
						        	 orient: 'vertical',
						             left: 'left',
						        	 data: ['下午正常上班','下午迟到','下午正常下班','下午早退','下午旷工']
						         },
						         series : [
						             {
						            	 name: '考勤统计',
								            type: 'pie',
								            radius: '50%',
								            data:[
								                {value:pmOnWorkNormalCount, name:'下午正常上班'},
								                {value:pmLatelCount, name:'下午迟到'},
								                {value:pmOffWorkNormalCount, name:'下午正常下班'},
								                {value:pmLeavelCount, name:'下午早退'},
								                {value:pmAbsenteeismCount, name:'下午旷工'},
								            ],
						             }
						         ]
						     };
						     // 为echarts对象加载数据 
						     pmChart.setOption(option); 
					}
					layer.close(indexlayer);
				},
			});
		}

		//图形点击事件
		function pieClick(type,value,name,cPage) 
		{
			if(type == 0){
				if (name.indexOf("上午正常上班") > -1)
	            { 
	               $("#checkStatus").val("5");
	               list = amTotalDataList._getOnWorkNormalList();
	            }
				else if (name.indexOf("上午正常下班") > -1)
	            { 
	               $("#checkStatus").val("4");
	               list = amTotalDataList._getOffWorkNormalList();
	            }
				else if (name.indexOf("上午迟到") > -1)
	            { 
	               $("#checkStatus").val("2");
	               list = amTotalDataList._getLatelList();
	            }
				else if (name.indexOf("上午早退") > -1)
	            { 
	               $("#checkStatus").val("3");
	               list = amTotalDataList._getLeavelList();
	            }
				else if (name.indexOf("上午旷工") > -1)
	            { 
	               $("#checkStatus").val("1");
	               list = amTotalDataList._getAbsenteeismList();
	            }
				else if (name.indexOf("上午非正常进") > -1)
	            { 
	               $("#checkStatus").val("6");
	               list = amTotalDataList._getAbnormalInList();
	            }
				else if (name.indexOf("上午非正常出") > -1)
	            { 
	               $("#checkStatus").val("7");
	               list = amTotalDataList._getAbnormalOutList();
	            }
				else if (name.indexOf("下午正常上班") > -1)
	            { 
	               $("#checkStatus").val("11");
	               list = pmTotalDataList._getOnWorkNormalList();
	            }
				else if (name.indexOf("下午正常下班") > -1)
	            { 
	               $("#checkStatus").val("12");
	               list = pmTotalDataList._getOffWorkNormalList();
	            }
				else if (name.indexOf("下午迟到") > -1)
	            { 
	               $("#checkStatus").val("9");
	               list = pmTotalDataList._getLatelList();
	            }
				else if (name.indexOf("下午早退") > -1)
	            { 
	               $("#checkStatus").val("10");
	               list = pmTotalDataList._getLeavelList();
	            }
				else if (name.indexOf("下午旷工") > -1)
	            { 
	               $("#checkStatus").val("8");
	               list = pmTotalDataList._getAbsenteeismList();
	            }
				else if (name.indexOf("下午非正常进") > -1)
	            { 
	               $("#checkStatus").val("13");
	               list = pmTotalDataList._getAbnormalInList();
	            }
				else if (name.indexOf("下午非正常出") > -1)
	            { 
	               $("#checkStatus").val("14");
	               list = pmTotalDataList._getAbnormalOutList();
	            }
	            
				else if (name.indexOf("其他") > -1)
	            { 
	               $("#inoutAbnormalDetail").hide();
	               return ;
	            }
			}else if (type == 1){
				if (name.indexOf("正常上班") > -1)
	            { 
	               $("#checkStatus").val("22");
	               list = totalDataList._getOnWorkNormalList();
	            }
				else if (name.indexOf("正常下班") > -1)
	            { 
	               $("#checkStatus").val("25");
	               list = totalDataList._getOffWorkNormalList();
	            }
				else if (name.indexOf("迟到") > -1)
	            { 
	               $("#checkStatus").val("23");
	               list = totalDataList._getLatelList();
	            }
				else if (name.indexOf("早退") > -1)
	            { 
	               $("#checkStatus").val("24");
	               list = totalDataList._getLeavelList();
	            }
				else if (name.indexOf("旷工") > -1)
	            { 
	               $("#checkStatus").val("26");
	               list = totalDataList._getAbsenteeismList();
	            }
				else if (name.indexOf("非正常进") > -1)
	            { 
	               $("#checkStatus").val("27");
	               list = totalDataList._getAbnormalInList();
	            }
				else if (name.indexOf("非正常出") > -1)
	            { 
	               $("#checkStatus").val("28");
	               list = totalDataList._getAbnormalOutList();
	            }
				else if (name.indexOf("其他") > -1)
	            { 
	               $("#inoutAbnormalDetail").hide();
	               return ;
	            }
			}
	        $("#inoutAbnormalDetail").show();
			$("#itemName").html(name+' '+value + '人');

			if(cPage == null || cPage == ''){
				if(value == 0){
					cPage = 0;
				}else{
					cPage = 1;
				}
			}
			var pageSize = 50;
			var totalPage = value%pageSize == 0?parseInt(value/pageSize):parseInt(value/pageSize) + 1;
			$("#currentPage").html(cPage);
			$("#totalPage").html(totalPage);		
	      	var startIndex = (cPage -1)*pageSize;
	      	var appendHtml = '';
	      	for(var i = 0; i<pageSize;i++){
				var value = list[startIndex];
				if(value != null){
					appendHtml += '<tr>';
			       	appendHtml += '<td>' + value.gradeName + '</td>';
			        appendHtml += '<td>' + value.code + '</td>';
			        appendHtml += '<td> '+ value.name +'</td>';
			        appendHtml += '<td> '+ value.statusName +'</td>';						 
			       	appendHtml += '<td>' + value.createDate + '</td>';
			      	appendHtml += '</tr>';
				}
				startIndex = parseInt(startIndex) + 1;
	        }
			$("#tbody").html(appendHtml);
		
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

			pieClick(${type},paramsValue,paramsName,newCPageInt);
			$("#currentPage").html(cPageInt);
		}
	</script>
	</html>