<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>查看详情</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath %>assets/global/css/baiduCsscss/style.css" rel="stylesheet" type="text/css"/>
 	<link href="<%=basePath %>assets/global/css/baidu_map_m.css" rel="stylesheet"/>
</head>
	<body>
	<input id="name" type="hidden" value="${location.name }">
			<input id="userId" type="hidden" value="${userId }">
			<input id="userRealId" type="hidden" value="${userRealId }">
			<input id="carId" type="hidden" value="${carId }">
			<input id="createTime" type="hidden" value="${createTime }">
			<input id="roleCode" type="hidden" value="${roleCode }">
			<input id="isZoudu" type="hidden" value="${isZoudu }">
			<div class="location_search">
				<div class="row">
					<span>校车设备号：</span>
					<select id="carSelectId">
						<option selected="selected">${carId }</option>
					</select>
				</div>
				<div class="row">
					<input type="text" value="${createTime.substring(0,10) }" id="startTime" />
					<select id="timeSelect" ></select>
				</div>
<!-- 				<a id="isHide" style="display: none" href="javascript:window.history.go(-1)">返回</a> -->
			</div>
			<div id="allmap"></div>
	</body>
	<!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script src="<%=basePath %>assets/global/plugins/baiduMap/My97DatePicker/WdatePicker.js"type="text/javascript" ></script>
	<script src="http://api.map.baidu.com/api?v=2.0&ak=MnblP7QGUnaYv50psbrm3Dgt"type="text/javascript" ></script>
	<script src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"type="text/javascript" ></script>
	<script src="<%=basePath %>assets/global/plugins/baiduMap/SearchInfoWindow.js"type="text/javascript" ></script>
	<script type="text/javascript">
	var map = new BMap.Map("allmap");
	map.enableScrollWheelZoom(true);
	var isSorX=0;
	var isT=1;
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
	    if(isMobile) {
	        $("#isHide").hide();
	    }else{
	    	$("#isHide").show();
	    }
		var createTime =$("#createTime").val();
		var temp = "";
		setInterval(function(){
			  if($("#startTime").val() != createTime.substring(0,10)){
				  $("#startTime").change();
				  createTime = $("#startTime").val();
			  }
			},100);
		$("#startTime").bind("change",function(){
			isShow=true;
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
								options+="<option selected='selected' value='05:00,"+schoolBus[i].beginTime.split(" ")[1]+"'>上午时段</option>";
								options+="<option value='"+schoolBus[i].endTime.split(" ")[1]+",22:00'>下午时段</option>";
							}
							$("#timeSelect").html(options);
						}else{
							$("#timeSelect").html("<option value='0,0'>数据加载中</option>");
						}
					}
					if(isT==0){
						refreshMap();
					}
				}
			});
		});
		$("#startTime").change();
		var getDate = parseInt(createTime.split(" ")[1].replace(/:/g,""),10);
		$("#timeSelect option").each(function(){
			var minDate = parseInt(($(this).val().split(",")[0]).replace(/:/g,""),10);
			var maxDate = parseInt(($(this).val().split(",")[1]).replace(/:/g,""),10);
			if(minDate<=getDate&&getDate<=maxDate){
				$("#timeSelect option").removeAttr("selected");
				$(this).attr("selected",true);
			}
		});
		$("#timeSelect").bind("change",function(){
			isShow=true;
			var a = $(this).find("option:selected").val();
			if(a!=null && a!="undefined" && a!="null" && a!=""){
				refreshMap();
			}
		});
		refreshMap();
		isT = 0;
	});
	var timeId=setTimeout("refreshMap()", 3000);
	var dayDate;
	var startTime;
	var endTime;
	var carId;
	var roleCode;
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
		roleCode = $("#roleCode").val();
		carId = $("#carId").val();
		$.ajax({
			type: "post",
			url: "<%=basePath%>locationInfo/getLocationInfoByWatchId.do",
			data : {
				"userRealId" : $("#userRealId").val(),
				"carId" : carId,
				"createTime" : startTime,
				"endTime" : endTime,
				"userId" : $("#userId").val(),
				"roleCode" : roleCode
			},
			success : function(data) {
				var datas = $.parseJSON(data);
				var dateNow = new Date().Format("yyyy-MM-dd hh:mm:ss");
				if(comptime(endTime,dateNow)==1||comptime(endTime,dateNow)==0){
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
	}
	var isShow = true;
	var pointStart;
	var pointEnd;
	var realName;
	function deletePoint(name){
		var allOverlay = map.getOverlays();
		for (var i = 0; i < allOverlay.length -1; i++){
			if(allOverlay[i].getLabel().content.indexOf(name)>-1){
				map.removeOverlay(allOverlay[i]);
				return false;
			}
		}
	}
	// 编写自定义函数,创建标注
	function addMarker(point,lableContent,isStartOrEnd){
		var infoWindow = new BMap.InfoWindow(lableContent,{width:0,height:0,maxWidth:220});
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
		marker.addEventListener("click", function(){
			if(infoWindow.isOpen()){
				this.closeInfoWindow(infoWindow);
			}else{
		   		this.openInfoWindow(infoWindow);
			}
		});
		map.addOverlay(marker);
// 		marker.openInfoWindow(infoWindow);
	}
	//地图画点画线，参数datas:包含坐标点集合和打卡集合，参数status：1为正在行驶中，0为历史
	function showLocation(datas,status){
		// 百度地图API功能
		map.clearOverlays();
		//坐标点信息
		var pointList = datas.pointList;
		//学生打卡信息
		var busList = datas.busList;
		var timeSelectVal = $("#timeSelect option:selected").html();
		if(timeSelectVal=="上午时段"){
			isSorX=1;
		}else if(timeSelectVal=="下午时段"){
			isSorX=2;
		}
		//记录起始点坐标
		if (null != pointList && "" != pointList){
			if(pointList[0].x!="0"&&pointList[pointList.length-1].x!="0"&&pointList[0].x!=""&&pointList[pointList.length-1].x!=""){
				if(null!=pointList[0]&&""!=pointList[0]){
					pointStart = new BMap.Point(parseFloat(pointList[0].x),parseFloat(pointList[0].y));
				}
				if(null!=pointList[pointList.length-1]&&""!=pointList[pointList.length-1]){
					pointEnd = new BMap.Point(parseFloat(pointList[pointList.length-1].x),parseFloat(pointList[pointList.length-1].y));
				}
			}else{
				pointStart = new BMap.Point(118.78333,32.05000);
				pointEnd = new BMap.Point(118.79333,32.06000);
			}
		}else{
			pointStart = new BMap.Point(118.78333,32.05000);
			pointEnd = new BMap.Point(118.79333,32.06000);
		}
		//如果坐标点信息没有，那就什么都不显示
		var pointsInfo;
		if(null!=pointList&&""!=pointList){
			pointsInfo = new Array(pointList.length);
			//把坐标点转换成坐标对象，并放入数组中
			for(var i=0;i<pointList.length;i++){
				pointsInfo[i] = new BMap.Point(parseFloat(pointList[i].x),parseFloat(pointList[i].y));
			}
		}
		if(null!=busList&&busList.length>0){
			var iGet=0;
			//学生打卡点
			for(var i=0;i<busList.length;i++){
				var value = busList[i];
				//判断学生第一次打卡位置
				if(i==0){
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					var lableContent="";
					var address = value.address;
					if(null==value.address||"undefined"==value.address){
						address="地址暂无";
					}
					lableContent="<div class='bus_state'><p class='header'><span>"+value.realName+"</span><span class='blue'>已出发</span></p><p><span>班次："+value.position+"</span><span>时间："+value.createTime.substring(10,19)+"</span></p></div>";
					if(busList.length==1){
						if(isShow) map.centerAndZoom(userPoint, 14);
						isShow = false;
					}
					var isStart = 0;
					if(isSorX==2){
						isStart=1;
						lableContent="<div class='bus_state'><p class='header'><span>已出发</span></p><p>"+address+"</p></div>";
					}
					addMarker(userPoint,lableContent,isStart);
				//判断学生最后一次打卡位置
				}else if(i == busList.length-1){
					//判断是否在同一个地点多次打卡
					var userPoint = new BMap.Point(value.x,value.y); // 创建标注
					if(value.x != busList[i-1].x && value.y != busList[i-1].y){
						var lableContent="";
						var address = value.address;
						if(null==value.address||"undefined"==value.address){
							address="地址暂无";
						}
						lableContent="<div class='bus_state'><p class='header'><span>"+value.realName+"</span><span class='blue'>已到达</span></p><p class='shift'><span>班次："+value.position+"</span><span>时间："+value.createTime.substring(10,19)+"</span></p></div>";
						var isStart = 0;
						if(isSorX==1){
							isStart=2;
							lableContent="<div class='bus_state'><p class='header'><span>已到达</span></p><p>"+address+"</p></div>";
						}
						addMarker(userPoint,lableContent,isStart);
						if(null!=pointList&&""!=pointList){
							//画线
							var polyline = new BMap.Polyline(pointsInfo, {strokeColor:"green", strokeWeight:5, strokeOpacity:0.8});
							map.addOverlay(polyline);
						}
					//如果学生最后打卡坐标相同，表明学生未到校或未到家，此时显示校车位置
					}
					if(status==1){
						var userPoint1 = pointsInfo[pointsInfo.length-1];
						var lableContent="";
						var address = pointList[pointList.length-1].address;
						if(null==address||"undefined"==address){
							address="";
						}
						lableContent="<div class='bus_state'><p class='header'><span>"+new Date(pointList[pointList.length-1].createTime).Format("hh:mm:ss")+"</span><span class='blue'>校车正在运行"+"</span></p><p>"+address+"</p></div>";
						addMarker(userPoint1,lableContent,0);
					}
					if(isShow) map.centerAndZoom(userPoint, 14);
					isShow = false;
				}else{
					if(value.x == busList[i-1].x && value.y == busList[i-1].y){
						iGet++;
						if(iGet>30){
							var userPoint = new BMap.Point(value.x,value.y); // 创建标注
							var lableContent="";
							var address = value.address;
							if(null==value.address||"undefined"==value.address){
								address="地址暂无";
							}
							var isStart = 0;
							if(isSorX==2){
								isStart=1;
								lableContent="<div class='bus_state'><p class='header'><span>已出发</span></p><p><span>地点："+address+"</span></p></div>";
								addMarker(userPoint,lableContent,isStart);
							}
							if(isSorX==1){
								isStart=2;
								lableContent="<div class='bus_state'><p class='header'><span>已到达</span></p><p><span>地点："+address+"</span></p></div>"
								addMarker(userPoint,lableContent,isStart);
							}
						}
					}
				}
			}
		}
// 		alert(isShow);
// 		if(isShow) map.centerAndZoom(pointEnd, 14);
// 		isShow = false;
	}
	function getAddress(pt){
		var address="";
		var geoc = new BMap.Geocoder();
		geoc.getLocation(pointStart, function(rs){
			var addComp = rs.addressComponents;
			return addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
		});
		return address;
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
	function comptime(begin,end) {
	    var beginTime = begin;
	    var endTime = end;
	    var beginTimes = beginTime.substring(0, 10).split('-');
	    var endTimes = endTime.substring(0, 10).split('-');

	    beginTime = beginTimes[1] + '-' + beginTimes[2] + '-' + beginTimes[0] + ' ' + beginTime.substring(10, 19);
	    endTime = endTimes[1] + '-' + endTimes[2] + '-' + endTimes[0] + ' ' + endTime.substring(10, 19);

	    var a = (Date.parse(endTime) - Date.parse(beginTime)) / 3600 / 1000;
	    if (a < 0) {
	        return 1;
	    } else if (a > 0) {
	        return 2;
	    } else if (a == 0) {
	        return 0;
	    } else {
	        return 'exception'
	    }
	}
	</script>
</html>