<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>实施定位</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body id="body">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>实时定位
			<a href="<%=basePath %>locationInfo/getUserList.do">
				<i class="itext icon_right">管理</i>
			</a>							
		<input id="longitude" type="hidden" value="${location.longitude }">
		<input id="latitude" type="hidden" value="${location.latitude }">
		<input id="name" type="hidden" value="${location.name }">
		<input type="hidden" name="watchId" id="watchId" value="${location.watchId }">
	</div>
	<div id="allmap"></div>

</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

	<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	map.enableScrollWheelZoom(true);
	showLocation($("#longitude").val(),$("#latitude").val());
	
	var timeId = setTimeout("refreshMap()", 10000) ;
	function refreshMap(){
		window.clearTimeout(timeId);
		$.ajax({
			type: "post",
			url: "<%=basePath%>locationInfo/getLocationInfoByWatchId.do",
					data : {
						watchId : $("#watchId").val()
					},
					success : function(data) {
						var datas = $.parseJSON(data);
						showLocation(datas.longitude, datas.latitude);
						timeId = setTimeout("refreshMap()", 10000);
					},
					complete: function(){
						
					}
				});
	}
	function showLocation(longitude,latitude){
		
		map.clearOverlays();   
		var point;
		if (longitude != "" && latitude != "" ){
			point = new BMap.Point(parseFloat(longitude),parseFloat(latitude));
		}else{
			point = new BMap.Point(118.78333,32.05000);
		}
		map.centerAndZoom(point, 18);
		var marker = new BMap.Marker(point);  // 创建标注
		map.addOverlay(marker);              // 将标注添加到地图中

		var label = new BMap.Label($("#name").val(),{offset:new BMap.Size(20,-10)});
		marker.setLabel(label);
	}
	</script>

</html>