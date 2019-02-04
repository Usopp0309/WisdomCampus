<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>会议刷卡记录搜索</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>会议刷卡记录搜索
	</div>
	<div class="app_search">
	
	<form action="<%=basePath%>meetingInout/toMeetingInoutByHuxinId.do" class="form-horizontal" method="post">

		<span>出席状态</span>
		<ul id="status">
			<li class="select" id="all">全部</li><li id="0">正常</li><li id="1">迟到</li>
			<input type="hidden" class="val" name="status" value="all">
		</ul>
		<span>签到方式</span>
		<ul>
			<li class="select" id="1">wifi签到</li><li id="0">刷卡</li>
			<input type="hidden" class="val" name="inoutType" value="1">
		</ul>
		<span>会议名称</span>
		<p>
			<input type="text" name="queryContent" value="${queryContent }"></p>
		<p>
			<button type="submit">查找</button>
		</p>
		<input type="hidden" name="schoolId" value="${schoolId}">
		<input type="hidden" name="apiKey" value="${apiKey}">
	</form>
	</div>

		</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->  
	<script type="text/javascript">
	    
    </script>
</html>