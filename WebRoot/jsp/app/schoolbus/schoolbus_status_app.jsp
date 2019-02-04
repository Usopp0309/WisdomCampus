<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>校车当前位置</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>
	<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut }" />
	<input type="hidden" id="nowPoint" value="${nowPoint }" />
	<input type="hidden" id="roleCode" value="${roleCode }" />
	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>校车当前位置
			<%-- <a href="<%=basePath%>schoolbus/toSchoolbusOnListSearchAPP.do?apiKey=${apiKey}&schoolId=${schoolId}&roleCode=${roleCode}">
				<i class=" m_icon-search icon_right"></i>
			</a> --%>
	</div>
	
	
		<div class="private_search" style="margin-top:60px;" >
			<input  type="text" id="queryContent"><i onclick="loadSchoolBusOnList(0)" class="fa fa-search"></i>
		</div>
		<ul class="school_hus_status" id="contentList">
		</ul>
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
		<a href="#" id="op_all_save" class="op_all_save" onclick="loadSchoolBusOnList(1)">查看更多</a>
	
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script>

    $(function() {    
    	var timeOut = $("#apiKeyTimeOut").val();
		if(timeOut == '1')
		{
			alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
		}else{
			loadSchoolBusOnList(0);
		}
	});
  //加载校车当前位置列表
	function loadSchoolBusOnList(type)
	{
	    var body = $("#contentList");
		App.blockUI(body);
		$.ajax({
			type: "post",
			url: "<%=basePath%>schoolbus/toSchoolBusNowPointAPP.do",
			data:{
					queryContent : $("#queryContent").val(),
					roleCode : $("#roleCode").val(),
					permissionCode : "schoolBusOnManager",
					cPage : 1,
					nowPoint : $("#nowPoint").val()
				},
			success: function(data){
				var page = eval("(" + data + ")");
				var appendHtml = '';
				if(page.list.length==0){
					$(".null_con").show();
				}else{
					$(".null_con").hide();
				}
				if(type==0){
					for(var i=0;i<page.list.length&&i<5;i++){
						var value = page.list[i];
						appendHtml += '<li onclick="mapInfo(\''+value.carId+'\')"><div class="left"><p>'+value.carId+'</p><span><i class="icon-chevron-right"></i><b>';
						if(null!=value.address&&''!=value.address&&value.address!="undefined"){
							appendHtml += value.address;
						}else{
							appendHtml += "-";
						}
						appendHtml +='</b></span></div><div class="right"><span class="text">距离</span><span>约<b>'+(parseFloat(value.distanceKm)/1000).toFixed(2)+'</b>km</span></div></li>';
					}
				}else{
					$.each(page.list, function(n, value) {  
						appendHtml += '<li onclick="mapInfo(\''+value.carId+'\')"><div class="left"><p>'+value.carId+'</p><span><i class="icon-chevron-right"></i><b>';
						if(null!=value.address&&''!=value.address&&value.address!="undefined"){
							appendHtml += value.address;
						}else{
							appendHtml += "-";
						}
						appendHtml +='</b></span></div><div class="right"><span class="text">距离</span><span>约<b>'+(parseFloat(value.distanceKm)/1000).toFixed(2)+'</b>km</span></div></li>';
	      			}); 
				}
      			$(body).html(appendHtml);
      			App.unblockUI(body);
			}
		});
	}
	function mapInfo(carId){
		var nowPoint=$("#nowPoint").val();
		standardPost('<%=basePath%>jsp/watchLocation/now_location.jsp',{carId:carId,nowPoint:nowPoint});
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

</html>