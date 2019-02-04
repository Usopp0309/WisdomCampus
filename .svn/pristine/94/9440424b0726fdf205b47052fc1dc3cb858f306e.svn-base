<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<%
   String  apiKey=request.getParameter("apiKey");
   String schoolId =request.getParameter("schoolId");
   String roleCode =request.getParameter("roleCode");
   boolean flag = false;
   if(roleCode.equals("parent") || roleCode.equals("student"))
   {
	   flag = true;  
   }
 %>
<head>
	<title>进出记录搜索</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body>
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>进出记录搜索
	</div>
	<div class="app_search">
	
		<form action="<%=basePath%>morningCheck/toMorningCheckListByApiKey.do" class="form-horizontal" method="post">
			<span>选择阶段</span>
			<ul id="gradeSelect">
			    
			    
			</ul>
			
			<span>选择班级</span>
			<ul id="classSelect">
				 
				 
			</ul>
			<input type="hidden" class="val" id="clazzId" name="clazzId" value="">
			<span>开始日期</span>
			<p>
				<input readonly="readonly" name="startDate" id="startDate" type="text">
			</p>
			<span>结束日期</span>
			<p>
				<input readonly="readonly"  name="endDate" id="endDate" type="text">
			</p>
				<span>开始时间</span>
			<p>
				<input readonly="readonly" name="startTime" value="00:00" class="time" type="text">
			</p>
			<span>结束时间</span>
			<p>
				<input readonly="readonly"  name="endTime" value="23:59" class="time" type="text">
			</p>
			<span>名称</span>
			<p><input type="text" name="queryContent"></p>
			<p>
				<button type="submit">查找</button>
			</p>
			<input type="hidden" name="schoolId" value="<%=schoolId%>">
			<input type="hidden" name="apiKey" value="<%=apiKey%>">
			
		</form>
		
	</div>
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->  
   <script type="text/javascript">
	    $(function() {
	    	loadGradeList();
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
			var optDateTime = $.extend(opt['datetime'], opt['default']);
		  	var optTime = $.extend(opt['time'], opt['default']);
		    /*$("#startday,#endday").mobiscroll(optDateTime).datetime(optDateTime);*/
		    $("#startDate,#endDate").mobiscroll($.extend(opt['date'], opt['default']));
		    $(".time").mobiscroll(optTime).time(optTime);
	    });
	  //加载年级信息
		function loadGradeList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/getGradeList.do",
				success: function(data){
					var gradeList = eval("(" + data + ")");

					//年级select页面html
					var gradeSelectHtml = '';

					$.each(gradeList, function(n, value) {  
						//select页面
						var type = value.type;
						if(type == 0){
							gradeSelectHtml += '<li onclick="loadClass(' + value.id + ')">' + value.name + '</li>';
						}else if(type == 1){
							gradeSelectHtml += '<li onclick="loadClass(' + value.id + ')">' + value.name + '</li>';
						}else if(type == 2){
							gradeSelectHtml += '<li onclick="loadClass(' + value.id + ')">' + value.name + '</li>';
						}else if(type == 3){
							gradeSelectHtml += '<li onclick="loadClass(' + value.id + ')">' + value.name + '</li>';
						}
	          		});

          			$("#gradeSelect").html(gradeSelectHtml);
          			
				},
			});
		} 
	  function loadClass(gradeId){
		  $.ajax({
				type: "post",
				url: "<%=basePath%>baseData/getClazzListByGradeId4App.do",
				data:{
					gradeId : gradeId
				},
				success:function(data){
					var clazzList = eval("(" + data + ")");
					
					//年级select页面html
					var clazzSelectHtml = '';

					$.each(clazzList, function(n, value) {
						//select页面
						clazzSelectHtml += '<li onclick="setClassId(' + value.id + ')">' + value.clazzName + '</li>';
					
	          		});

        			$("#classSelect").html(clazzSelectHtml);
        			
				},
			});
	  }
	  function setClassId(clazzId){
		  $("#clazzId").val(clazzId);
	  }
   </script>
</html>