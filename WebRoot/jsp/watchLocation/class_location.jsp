<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->


<head>
	<title>校车轨迹</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<link href="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>media/css/baiduCss/baiduMap.css" rel="stylesheet"/>
	<link href="<%=basePath %>media/metronic_css_m/baidu_map_m.css" rel="stylesheet"/>
</head>

<body>
			<input id=leaderId type="hidden" value="${bus.userId }">
			<input id=createTime type="hidden" value="${bus.createTime }">
			<input id=endTime type="hidden" value="${bus.endTime }">
			<input id="isZoudu" type="hidden" value="${isZoudu }">
			<div class="location_search">
				<div class="row">
					<input type="text" id="userName" value="${name }"/>
					<a href="javascript:void(0)" onclick="refreshMap()"/><i class="fa fa-search"></i>查找</a>
				</div>
				<div class="row">
					<select id="carSelectId" style="width:175px;">
					<option selected="selected" id="all" value="all">全部</option>
					<c:forEach items="${busList}" var="bus">
						<option id="${bus.position }">${bus.position }</option>
					</c:forEach>
					</select>
				</div>
				<div class="row">
					<input type="text" value="${createTime.substring(0,10) }" id="startTime" />
					<select id="timeSelect"></select>
				</div>
<!-- 				<a id="isHide" style="display: none" href="javascript:window.history.go(-1)">返回</a> -->
			</div>
			<div id="allmap"></div>
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>    
	<script type="text/javascript" src="<%=basePath %>media/js/baiduMap/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=MnblP7QGUnaYv50psbrm3Dgt"></script>
	<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
	<script type="text/javascript" src="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=basePath %>media/js/baiduMap/SearchInfoWindow.js"></script>
	<script type="text/javascript" src="<%=basePath %>media/js_m/public_js.js"></script>
	<script>
	var map = new BMap.Map("allmap");
	map.enableScrollWheelZoom(true);
	var isNow = false;
	var pointOrLine=0;
	var position="";
	$(function(){
		$('#startTime').datetimepicker({format:'Y-m-d',timepicker:false});
		$(".location p").on("click",function(){
			$(this).parent().find("ul").show();
		});
		$(".location p").find("em").text($(".location ul li:first").find("em").text());
		$(".location ul li").on("click",function(){
			/* $(this).parent().siblings("p").find("img").attr("src",$(this).find("img").attr("src")); */
			$(this).parent().siblings("p").find("em").text($(this).find("em").text());
			$("#watchId").val($(this).attr("id"));
			$(this).parent().hide();
		})
		var ua = navigator.userAgent;
		var ipad = ua.match(/(iPad).*OS\s([\d_]+)/),
	    isIphone = !ipad && ua.match(/(iPhone\sOS)\s([\d_]+)/),
	    isAndroid = ua.match(/(Android)\s+([\d.]+)/),
	    isMobile = isIphone || isAndroid;
	    if(isMobile){
	        $("#isHide").hide();
	    }else{
	    	$("#isHide").show();
	    }

	    //加载时间段
	    var getTime = "${createTime }";
	    var createTime = "${createTime }";
	    setInterval(function(){
			  if($("#startTime").val() != getTime.substring(0,10)){
				  $("#startTime").change();
				  getTime = $("#startTime").val();
			  }
			},1000);
	    $("#startTime").bind("change",function(){
			isShow=true;
			isNow=false;
			$.ajax({
				type: "post",
				async: false,
				url: "<%=basePath%>schedule/getScheduleByDate.do",
				data:{
					liveingDate : ($("#startTime").val()).substring(0,10)
				},
				success: function(data){
					var schoolBus = eval("(" + data + ")");
					if($("#isZoudu").val()=="false"){
						$("#timeSelect").html("<option value='00:00,23:59'>全天</option>");
					}else{
						var options;
						if(schoolBus.length!=0){
							for(var i=0;i<schoolBus.length;i++){
								if(createTime == schoolBus[i].beginTime){
									options+="<option selected='selected' value='05:00,"+schoolBus[i].beginTime.split(" ")[1]+"'>上午时段</option>";
									isNow = true;
								}else{
									options+="<option value='05:00,"+schoolBus[i].beginTime.split(" ")[1]+"'>上午时段</option>";
								}
								if(createTime == schoolBus[i].endTime){
									options+="<option selected='selected' value='"+schoolBus[i].endTime.split(" ")[1]+",22:00'>下午时段</option>";
									isNow = true;
								}else{
									options+="<option value='"+schoolBus[i].endTime.split(" ")[1]+",22:00'>下午时段</option>";
								}
							}
							$("#timeSelect").html(options);
						}else{
							$("#timeSelect").html("<option value='0,0'>数据加载中</option>");
						}
					}
				}
			});
			refreshMap();
		});
	    $("#startTime").change();
		//选择时间段后
	    $("#timeSelect").bind("change",function(){
			isShow=true;
			var a = $(this).find("option:selected").val();
			if(a!=null && a!="undefined" && a!="null" && a!=""){
				var carId = $("#carSelectId option:selected").val();
				if(null!=carId&&""!=carId&&"all"!=carId&&"undefined"!=carId){
					pointOrLine=1;
				}else{
					pointOrLine=0;
				}
				//画点
				refreshMap();
			}
		});
		//选择某一段校车后
	    $("#carSelectId").bind("change",function(){
			var a = $(this).find("option:selected").val();
			if(a!=null && a!="undefined" && a!="null" && a!="all" && a!=""){
				pointOrLine = 1;
				position = a;
				//画线
			}else if(a=="all"){
				pointOrLine=0;
				position="";
			}
			refreshMap();
		});
	});
	var timeId=setTimeout("refreshMap()", 3000);
	var startTime;
	var endTime;
	function refreshMap(){
		window.clearTimeout(timeId);
		
		var dayDate = ($("#startTime").val()).substring(0,10);
		var optionDate = $("#timeSelect option:selected").val();
		if(null==optionDate||optionDate==""){ 
			optionDate="00:00,00:00";
		}
		var times = optionDate.split(",");
		for(var i=0;i<times.length;i++){
			times[i]+=":00";
		}
		startTime = dayDate+" "+times[0];
		endTime = dayDate+" "+times[1];
		if(pointOrLine==0){
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/getSchoolBusPoint.do",
				data : {
					"userId" : $("#leaderId").val(),
					"createTime" : startTime,
					"endTime" : endTime,
					"userName" : $("#userName").val(),
					"position" : position
				},
				success : function(data) {
					var datas = $.parseJSON(data);
					if(isNow){
						//判断是否在行驶中：1为行驶中，0位历史
						showLocation(datas,1);
						timeId = setTimeout("refreshMap()", 3000);
					}else{
						showLocation(datas,0);
					}
				},
				complete: function(){
					
				}
			});
		}else if(pointOrLine==1){
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/getSchoolBusClassPoint.do",
				data : {
					"userId" : $("#leaderId").val(),
					"createTime" : startTime,
					"endTime" : endTime,
					"userName" : $("#userName").val(),
					"position" : position
				},
				success : function(data) {
					var datas = $.parseJSON(data);
					if(isNow){
						//判断是否在行驶中：1为行驶中，0位历史
						showLocationLine(datas,1);
						timeId = setTimeout("refreshMap()", 3000);
					}else{
						showLocationLine(datas,0);
					}
				},
				complete: function(){
					
				}
			});
		}
	}
	var pointStart;
	var pointEnd;
	//地图画点，参数datas:包含坐标点集合和打卡集合，参数status：1为正在行驶中，0为历史
	function showLocation(datas,status){
		// 百度地图API功能
		map.clearOverlays();
		//学生打卡信息
		var pointBusList = datas.pointBusList;
		//校车列表
		var busList = datas.busList;
		//加载校车列表
		if(null!=busList&&busList.length>0){
			$("#carSelectId").html("<option selected='selected' value='all'>全部</option>");
			for(var i=0;i<busList.length;i++){
				$("#carSelectId").append("<option value='"+busList[i].position+"'>"+busList[i].position+"</option>");
			}
		}
		var isSorX=0;
		var timeSelectVal = $("#timeSelect option:selected").html();
		if(timeSelectVal=="上午时段"){
			isSorX=1;
		}else if(timeSelectVal=="下午时段"){
			isSorX=2;
		}
		//校车最后一次运行坐标点(实时)
		var endPointList = datas.pointList;
		//是否有学生刷卡信息
		if(null!=pointBusList&&pointBusList.length>0){
			//记录起始点坐标
			if(pointBusList[0].x!="0"&&pointBusList[pointBusList.length-1].x!="0"&&pointBusList[0].x!=""&&pointBusList[pointBusList.length-1].x!=""){
				if(null!=pointBusList[0]&&""!=pointBusList[0]){
					pointStart = new BMap.Point(parseFloat(pointBusList[0].x),parseFloat(pointBusList[0].y));
				}
				if(null!=pointBusList[pointBusList.length-1]&&""!=pointBusList[pointBusList.length-1]){
					pointEnd = new BMap.Point(parseFloat(pointBusList[pointBusList.length-1].x),parseFloat(pointBusList[pointBusList.length-1].y));
				}
			}else{
				pointStart = new BMap.Point(118.78333,32.05000);
				pointEnd = new BMap.Point(118.79333,32.06000);
			}
			//学生打卡点
			//记录相同地点下车的人员
			var lableContent="";
			var infoContent = "";
			var samePoint;
			for(var i=0;i<pointBusList.length;i++){
				var value = pointBusList[i];
				//判断学生第一次打卡位置
				if(i==0){
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					var address = value.address;
					if(null==value.address||"undefined"==value.address){
						address="";
					}
					lableContent= "<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
					infoContent= "<div class='bus_state'><p class='header'><span>时间："+value.createTime.substring(10,19)+"</span><span class='blue'>已出发</span></p><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
					var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
					var isStart = 0;
					addMarker(userPoint,label,infoContent,isStart); 
				//下车
				}else if(i==pointBusList.length-1){
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					var address = value.address;
					if(null==value.address||"undefined"==value.address){
						address="";
					}
					//判断是否在同一个地点多次打卡
					if(value.x != pointBusList[i-1].x && value.y != pointBusList[i-1].y){
						//如果坐标点和上一个不同，则把上一个坐标点的多个人员的信息集合写进去
						if(lableContent!=null&&lableContent!=""&&null!=samePoint){
							var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
							addMarker(samePoint,null,infoContent,0);
						}
						var infoContent1 = "<div class='bus_state'><p class='header'><span>时间："+value.createTime.substring(10,19)+"</span><span class='blue'>已出发</span></p><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
						var lableContent1="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
						var label = new BMap.Label(lableContent1,{offset:new BMap.Size(1,-24)});
						var isStart = 0;
						addMarker(userPoint,label,infoContent1,isStart);
					//如果学生最后打卡坐标相同，则对相同人员的信息进行累加显示
					}else{
						samePoint = userPoint;
						lableContent+="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
						infoContent += "<div class='bus_state'><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
						var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
						var isStart = 0;
						addMarker(samePoint,null,infoContent,isStart);
					}
				}else{
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					var address = value.address;
					if(null==value.address||"undefined"==value.address){
						address="";
					}
					//判断是否在同一个地点多次打卡
					if(value.x != pointBusList[i-1].x && value.y != pointBusList[i-1].y){
						//如果坐标点和上一个不同，则把上一个坐标点的多个人员的信息集合写进去
						if(lableContent!=null&&lableContent!=""&&null!=samePoint){
							var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
							addMarker(samePoint,null,infoContent,0);
						}
						samePoint = userPoint;
						infoContent = "<div class='bus_state'><p class='header'><span>时间："+value.createTime.substring(10,19)+"</span><span class='blue'>已出发</span></p><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
						lableContent="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
					//如果学生最后打卡坐标相同，则对相同人员的信息进行累加显示
					}else{
						samePoint = userPoint;
						lableContent+="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
						infoContent += "<div class='bus_state'><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
					}
				}
			}
		}else{
			pointStart = new BMap.Point(118.78333,32.05000);
			pointEnd = new BMap.Point(118.79333,32.06000);
		}
		if(status==1){
			for(var i=0;i<endPointList.length;i++){
				var value = endPointList[i];
				var userPoint = new BMap.Point(value.x,value.y); // 创建标注
				var address = value.address;
				if(null==value.address||"undefined"==value.address){
					address="";
				}
				var lableContent1=value.createTime+"&nbsp;校车运行中"+"<br/>"+address;
				var label = new BMap.Label(lableContent1,{offset:new BMap.Size(20,-10)});
				addMarker(userPoint,label,0,0);
			}
		}
		$("span[name='setBorder']").each(function(){
			$(this).parent().css("border","1px solid gray");
		});
		if(isShow) map.centerAndZoom(pointEnd, 14);
		isShow = false;
	}
	//地图画线，参数datas:包含坐标点集合和打卡集合，参数status：1为正在行驶中，0为历史
	function showLocationLine(datas,status){
		// 百度地图API功能
		map.clearOverlays();
		//学生打卡信息
		var pointBusList = datas.pointBusList;
		//校车最后一次运行坐标点(实时)
		var pointList = datas.pointList;
		//是否有学生刷卡信息
		if(null!=pointBusList&&pointBusList.length>0){
			//记录起始点坐标
			if(pointBusList[0].x!="0"&&pointBusList[pointBusList.length-1].x!="0"&&pointBusList[0].x!=""&&pointBusList[pointBusList.length-1].x!=""){
				if(null!=pointBusList[0]&&""!=pointBusList[0]){
					pointStart = new BMap.Point(parseFloat(pointBusList[0].x),parseFloat(pointBusList[0].y));
				}
				if(null!=pointBusList[pointBusList.length-1]&&""!=pointBusList[pointBusList.length-1]){
					pointEnd = new BMap.Point(parseFloat(pointBusList[pointBusList.length-1].x),parseFloat(pointBusList[pointBusList.length-1].y));
				}
			}else{
				pointStart = new BMap.Point(118.78333,32.05000);
				pointEnd = new BMap.Point(118.79333,32.06000);
			}
			//学生打卡点
			//记录相同地点下车的人员
			var lableContent="";
			var infoContent="";
			var samePoint;
			var isSorX=0;
			var timeSelectVal = $("#timeSelect option:selected").html();
			if(timeSelectVal=="上午时段"){
				isSorX=1;
			}else if(timeSelectVal=="下午时段"){
				isSorX=2;
			}else if(timeSelectVal=="全天"){
				isSorX=3;
			}
			for(var i=0;i<pointBusList.length;i++){
				var value = pointBusList[i];
				//判断学生第一次打卡位置
				if(i==0){
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					var address = value.address;
					if(null==value.address||"undefined"==value.address){
						address="";
					}
					infoContent = "<div class='bus_state'><p class='header'><span>时间："+value.createTime.substring(10,19)+"</span><span class='blue'>已出发</span></p><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";;
					lableContent="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
					var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
					var isStart = 0;
					addMarker(userPoint,label,infoContent,isStart);
					//判断学生最后一次打卡位置
				}else if(i==pointBusList.length-1){
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					var address = value.address;
					if(null==value.address||"undefined"==value.address){
						address="";
					}
					//判断是否在同一个地点多次打卡
					if(value.x != pointBusList[i-1].x && value.y != pointBusList[i-1].y){
						//如果坐标点和上一个不同，则把上一个坐标点的多个人员的信息集合写进去
						if(lableContent!=null&&lableContent!=""&&null!=samePoint){
							var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
							addMarker(samePoint,label,infoContent,0);
							infoContent="";
							lableContent="";
						}
						var infoContent1 = "<div class='bus_state'><p class='header'><span>时间："+value.createTime.substring(10,19)+"</span><span class='blue'>已出发</span></p><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
						var lableContent1="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
						var label = new BMap.Label(lableContent1,{offset:new BMap.Size(1,-24)});
						var isStart = 0;
						addMarker(userPoint,label,infoContent1,isStart);
					//如果学生最后打卡坐标相同，则对相同人员的信息进行累加显示
					}else{
						samePoint = userPoint;
						lableContent+="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
						infoContent += "<div class='bus_state'><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
						var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
						var isStart = 0;
						addMarker(samePoint,null,infoContent,isStart);
					}
				//下车
				}else{
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					var address = value.address;
					if(null==value.address||"undefined"==value.address){
						address="";
					}
					//判断是否在同一个地点多次打卡
					if(value.x != pointBusList[i-1].x && value.y != pointBusList[i-1].y){
						//如果坐标点和上一个不同，则把上一个坐标点的多个人员的信息集合写进去
						if(lableContent!=null&&lableContent!=""&&null!=samePoint){
							var label = new BMap.Label(lableContent,{offset:new BMap.Size(1,-24)});
							addMarker(samePoint,null,infoContent,0);
							infoContent="";
							lableContent="";
						}
						samePoint = userPoint;
						
						infoContent = "<div class='bus_state'><p class='header'><span>时间："+value.createTime.substring(10,19)+"</span><span class='blue'>已出发</span></p><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";;
						lableContent="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
// 						var label = new BMap.Label(lableContent1,{offset:new BMap.Size(1,-24)});
// 						addMarker(userPoint,label,infoContent1,0);
					//如果学生最后打卡坐标相同，则对相同人员的信息进行累加显示
					}else{
						samePoint = userPoint;
						
						infoContent += "<div class='bus_state'><p class='shift'><span>班次："+value.position+"</span><span>"+value.realName+"</span></p></div>";
						lableContent+="<span name='setBorder'>"+value.realName.substring(0,1)+"</span>";
					}
				}
			}
			if(null!=pointList&&pointList.length>0){
				var pointsInfo = new Array(pointList.length);
				//把坐标点转换成坐标对象，并放入数组中
				for(var i=0;i<pointList.length;i++){
					pointsInfo[i] = new BMap.Point(parseFloat(pointList[i].x),parseFloat(pointList[i].y));
				}
				var userPoint1 = new BMap.Point(pointList[0].x,pointList[0].y); // 创建标注
				var userPoint2 = new BMap.Point(pointList[pointList.length-1].x,pointList[pointList.length-1].y); // 创建标注
				var address1 = pointList[0].address;
				if(null==address1||"undefined"==address1||""==address1){
					address1="地址暂无";
				}
				var address2 = pointList[pointList.length-1].address;
				if(null==address2||"undefined"==address2||""==address2){
					address2="地址暂无";
				}
				var label1 = null;
				var label2 = null;
				var lableContent1=0;
				var lableContent2=0;
				lableContent1="<div class='bus_state'><p class='header'><span>已出发</span></p><p class='shift'><span>班次："+address1+"</span></p></div>";
				if(status==1){
					lableContent2="<div class='bus_state'><p class='header'><span>运行中</span></p><p class='shift'><span>班次："+address1+"</span></p></div>";
				}else{
					lableContent2="<div class='bus_state'><p class='header'><span>已到达</span></p><p class='shift'><span>班次："+address1+"</span></p></div>";
				}
				var isStart1 = 0;
				var isStart2 = 0;
				if(isSorX==2){
					isStart1=1;
					label1=null;
					
					lableContent1="<div class='bus_state'><p class='header'><span>已出发</span></p><p class='shift'><span>班次："+address1+"</span></p></div>";
				}else if(isSorX==1){
					isStart2=2;
					label2=null;
					lableContent2="<div class='bus_state'><p class='header'><span>已到达</span></p><p class='shift'><span>班次："+address2+"</span></p></div>";
				}else if(isSorX==3){
					isStart1=1;
					label1=null;
					lableContent1="<div class='bus_state'><p class='header'><span>已出发</span></p><p class='shift'><span>班次："+address1+"</span></p></div>";
					isStart2=2;
					label2=null;
					lableContent2="<div class='bus_state'><p class='header'><span>已到达</span></p><p class='shift'><span>班次："+address2+"</span></p></div>";
				}
				addMarker(userPoint1,label1,lableContent1,isStart1); 
				addMarker(userPoint2,label2,lableContent2,isStart2); 
				var polyline = new BMap.Polyline(pointsInfo, {strokeColor:"green", strokeWeight:5, strokeOpacity:0.8});
				map.addOverlay(polyline);
			}
		}else{
			pointStart = new BMap.Point(118.78333,32.05000);
			pointEnd = new BMap.Point(118.79333,32.06000);
		}
		$("span[name='setBorder']").each(function(){
			$(this).parent().css("border","1px solid gray");
		});
		if(isShow) map.centerAndZoom(pointEnd, 14);
		isShow = false;
	}
	// 编写自定义函数,创建标注
	function addMarker(point,label,content,isStartOrEnd){
		var marker;
		if(isStartOrEnd==0){
			marker = new BMap.Marker(point);
		}else{
			var myIcon;
			if(isStartOrEnd==1){
				myIcon = new BMap.Icon("<%=basePath %>media/image/start.png", new BMap.Size(50,57));
			}else if(isStartOrEnd==2){
				myIcon = new BMap.Icon("<%=basePath %>media/image/end.png", new BMap.Size(50,57));
			}
			marker = new BMap.Marker(point,{icon:myIcon});
		}
		if(content!=0){
			var infoWindow = new BMap.InfoWindow(content,{width:0,height:0,maxWidth:220});
			marker.addEventListener("click", function(){
				if(infoWindow.isOpen()){
					this.closeInfoWindow(infoWindow);
				}else{
			   		this.openInfoWindow(infoWindow);
				}
			});
		}
		map.addOverlay(marker);
		marker.setLabel(label);
	}
	Date.prototype.Format = function(fmt)   
	{ //author: meizz   
	  var o = {   
	    "M+" : this.getMonth()+1,                 //月份   
	    "d+" : this.getDate(),                    //日   
	    "h+" : this.getHours(),                   //小时   
	    "m+" : this.getMinutes(),                 //分   
	    "s+" : this.getSeconds(),                 //秒   
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	    "S"  : this.getMilliseconds()             //毫秒   
	  };   
	  if(/(y+)/.test(fmt))   
	    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	  for(var k in o)   
	    if(new RegExp("("+ k +")").test(fmt))   
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	  return fmt;   
	}
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>