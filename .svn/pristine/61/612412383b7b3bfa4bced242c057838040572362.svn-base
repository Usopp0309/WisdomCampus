<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=MnblP7QGUnaYv50psbrm3Dgt"></script>
	<title>巡更轨迹</title>
</head>
<body>
	<div id="allmap"></div>
	<input type="hidden" id="placeId" value="<%=request.getParameter("placeId")%>">
	<input type="hidden" id="userId" value="<%=request.getParameter("userId")%>">
	<input type="hidden" id="createDate" value="<%=request.getParameter("createDate")%>">
</body>
</html>
<!-- 公共js开始 -->
<%@ include file="/public_module/public_js.jsp" %>
<!-- 公共js结束 -->
<script type="text/javascript">
var dataMap = {};
var userId=$("#userId").val();
var createDate=$("#createDate").val();
var placeId=$("#placeId").val();
var map = new BMap.Map("allmap");
//百度地图API功能
$(function(){
	getPatrolDataByCreateDateAndUserId();
});
	//获取数据
	function getPatrolDataByCreateDateAndUserId(){
		$.ajax({
			type: "post",
			data:{
				placeId : placeId,
				userId : userId,
				createDate : createDate
				},
			dataType: "json",
			url: "<%=basePath%>patrol/getPatrolData.do",
			success: function(data){
				var pointArray = new Array();
				$.each(data.inoutList, function(n, value) {
					var postion = value.position;
					var lng = parseFloat(postion.split(",")[1]);//经度
					var lat = parseFloat(postion.split(",")[0]);//纬度
					pointArray[n] = new BMap.Point(lng, lat);
					var txt = "巡更地点:"+value.placeName;
					var flag = dataMap[lng+","+lat];
					if(typeof(flag) == "undefined" || flag == "undefined" || flag == null){
						txt += "<p>"+value.inoutTime+"</p>";
						dataMap[lng+","+lat]=txt;
					}else{
						flag += "<p>"+value.inoutTime+"</p>";
						dataMap[lng+","+lat]=flag;
					}
				});
				
				var lng = parseFloat(data.point.split(",")[1]);//经度
				var lat = parseFloat(data.point.split(",")[0]);//纬度
				var point = new BMap.Point(lng,lat);
				loadMap(pointArray,point);

				var rangeArray=data.schoolRange.split("@@##");
				polygon(rangeArray);
			}	
		});
	}
	//加载地图
	function loadMap(pointArray,point){
		map.centerAndZoom(point, 20);
		for(var i=0;i<pointArray.length;i++){
			addMarker(pointArray[i]);
		}
		//让所有点在视野范围内
		map.setViewport(pointArray);

		var polyline = new BMap.Polyline(pointArray, {strokeColor:"blue",//设置颜色 
			strokeWeight:3, //宽度
			strokeOpacity:0.5});//透明度
	 	map.addOverlay(polyline);
	}

	function addMarker(point){  // 创建图标对象 
        var myIcon = new BMap.Icon("https://developer.baidu.com/map/jsdemo/img/Mario.png", new BMap.Size(23, 50), {offset: new BMap.Size(10, 25)});  
        // 创建标注对象并添加到地图     
        var marker = new BMap.Marker(point, {icon: myIcon});      
        map.addOverlay(marker); 
		addInfo(marker,point);
    }
	
	function addInfo(marker,point){   // 添加点击事件和图标文件显示
		var lng = point.lng;
		var lat = point.lat;  
		var txt = dataMap[lng+","+lat];
	    marker.addEventListener("click", function(){
		    this.openInfoWindow(new BMap.InfoWindow(txt));
		});  
	} 
	
    function polygon(rangeArray) {//加载范围
        var pts = [];
        for(var i=0;i<rangeArray.length;i++){
        	var pt = new BMap.Point(parseFloat(rangeArray[i].split(",")[1]),parseFloat(rangeArray[i].split(",")[0]));
        	pts.push(pt);
		}
        ply = new BMap.Polygon(pts);

        //演示：将面添加到地图上
        map.addOverlay(ply);
    }
</script>