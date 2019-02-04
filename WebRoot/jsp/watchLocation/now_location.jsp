<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->


<head>

	<title>校车轨迹</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<meta content="" name="description" />

	<meta content="" name="author" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<link href="<%=basePath %>media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>media/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>media/css/baiduCss/baiduMap.css" rel="stylesheet"/>
	<link href="<%=basePath %>media/metronic_css_m/baidu_map_m.css" rel="stylesheet"/>
</head>

<body>
	<div id="allmap"></div>
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>    
	<script src="<%=basePath %>media/js/baiduMap/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="http://api.map.baidu.com/api?v=2.0&ak=MnblP7QGUnaYv50psbrm3Dgt" type="text/javascript"></script>
<!-- <script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script> -->
	<script type="text/javascript" src="<%=basePath %>media/js_m/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=basePath %>media/js/baiduMap/SearchInfoWindow.js"></script>
	<script>
	var map = new BMap.Map("allmap");
	var geoc = new BMap.Geocoder();
	map.enableScrollWheelZoom(true);
	var carId='';
	var nowPoint='';
	$(function(){
		carId = GetQueryString("carId");
		nowPoint = GetQueryString("nowPoint");
		refreshMap();
	});
	function GetQueryString(name)
	{
	     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	     var r = window.location.search.substr(1).match(reg);
	     if(r!=null)return  unescape(r[2]); return null;
	}
	var timeId = setTimeout("refreshMap()", 3000);
	function refreshMap(){
		window.clearTimeout(timeId);
		$.ajax({
			type: "post",
			url: "<%=basePath%>locationInfo/getLocationInfoByCarId.do",
			data : {
				"carId" : carId
			},
			success : function(data) {
				var data = $.parseJSON(data);
				showLocation(data);
				timeId = setTimeout("refreshMap()", 3000);
			}
		});
	}
	var isShow = true;
	function showLocation(data){
		map.clearOverlays();
		//汽车的坐标点
		var carPoint = new BMap.Point(parseFloat(data.x),parseFloat(data.y)); // 创建标注
		var lableContentCar="";
		var addressCar = data.address;
		if(null==data.address||"undefined"==data.address){
			addressCar="地址暂无";
		}
		
		lableContentCar="<span name='setBorder'>校车位置："+addressCar+"</span>"+new Date(data.createTime).Format("yyyy-MM-dd hh:mm:ss");
		var labelCar = new BMap.Label(lableContentCar,{offset:new BMap.Size(20,-10)});
		addMarker(carPoint,labelCar,0);

		getLocation();
		
		if(isShow) map.centerAndZoom(carPoint, 14);
		isShow = false;
	}
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition,showError);
        }
    }
    var convertor = new BMap.Convertor();
    var point;
    function showPosition(position) {
        point = new BMap.Point(position.coords.longitude,position.coords.latitude);
       	convertor.translate([point], 1, 5, translateCallback);
    }
    var translateCallback = function (data){
       if(data.status === 0) {
    	 //手机的坐标点
   		var userPoint = data.points[0];
   		var userLableContent="";
		geoc.getLocation(userPoint, function(rs){
			var addComp = rs.addressComponents;
			address= addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
			lableContent="<span name='setBorder'>我的位置："+address+"</span>"+new Date().Format("yyyy-MM-dd hh:mm:ss");
	   		var label = new BMap.Label(lableContent,{offset:new BMap.Size(20,-10)});
	   		addMarker(userPoint,label,1);
	   		$("span[name='setBorder']").each(function(){
				if($(this).parent().attr("class")=="BMapLabel"){
					$(this).parent().css("border","1px solid gray");
				}
			});
		});
       }
     }
    
    function showError(error) {
        alert("定位失败，请打开定位开关后重试");
	}
	function getAddress(pt){
		var address="地址暂无";
		var geoc = new BMap.Geocoder();
		geoc.getLocation(pt, function(rs){
			var addComp = rs.addressComponents;
			address= addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
			$("#getAddress").val(address);
		});
	}
	// 编写自定义函数,创建标注
	function addMarker(point,label,isStartOrEnd){
		var myIcon;
		if(isStartOrEnd==1){
			myIcon = new BMap.Icon("<%=basePath %>media/image/lit.png", new BMap.Size(50,57));
		}
		marker = new BMap.Marker(point,{icon:myIcon});
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