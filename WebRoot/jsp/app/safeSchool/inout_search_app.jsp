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
	
		<form action="<%=basePath%>inout/toInoutListByHuxinId.do" class="form-horizontal" method="post">
			<span>师生类型</span>
			<ul id="type">
			    <c:choose>
			       <c:when test="<%=flag%>">
			            <li class="select" id="student">学生</li><li id="parent">家长</li>
			            <input type="hidden" class="val" id="ty" name="type" value="student">
			       </c:when>
			       <c:otherwise>
						<li class="select" id="teacher">教师</li><li id="student">学生</li><li id="parent">家长</li>
						<input type="hidden" class="val" id="ty" name="type" value="teacher">
			       </c:otherwise>
			    </c:choose>
			</ul>
			
			<span>进出状态</span>
			<ul id="inoutType">
				<li class="select" id="0">全部</li><li id="in">进</li><li id="out">出</li>
				<input type="hidden" id="inout" class="val" name="inoutType" value="0">
			</ul>
			
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
			<span>刷卡人/部门</span>
			<p><input type="text" name="queryContent"></p>
			<p>
				<button type="submit">查找</button>
			</p>
			
			<input type="hidden" name="schoolId" value="<%=schoolId%>">
			<input type="hidden" name="apiKey" value="<%=apiKey%>">
			<input type="hidden" name="roleCode" value="<%=roleCode%>">
			
		</form>
		
	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

   <script type="text/javascript">

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
   </script>

</html>