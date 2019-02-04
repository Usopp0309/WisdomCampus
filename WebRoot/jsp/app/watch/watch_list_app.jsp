<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>设备管理</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>设备管理
									
		
	</div>
	<ul class="watch_list">
		<c:forEach items="${list }" var="userWatch">
			<li id="${userWatch.watchId}"><span class="li_con"><em class="name">${userWatch.name}</em><em>设备号：${userWatch.watchId}</em></span><span class="li_right"><i class="icon-ok"></i></span></li>
		</c:forEach>
		<p onclick="addDevice()"><i class="icon-plus-sign"></i>添加设备</p>
	</ul>
	<form action="<%=basePath%>locationInfo/showLocationInfo4App.do" method="poset" id="showLocationForm">
		<input type="hidden" id="watchId" name="watchId">
	</form>
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	
	<script type="text/javascript">
		$(function(){
			$(".watch_list li").on("click",function(){
				$(".watch_list").find(".icon-ok").removeClass("select");
				$(this).find(".icon-ok").addClass("select");
				$("#watchId").val($(this).attr("id"));
				$("#showLocationForm").submit();
			})
		});
		function addDevice(){
			window.location.href="<%=basePath%>locationInfo/toAddUserWatchLink.do";
		}
	</script>
	

</html>