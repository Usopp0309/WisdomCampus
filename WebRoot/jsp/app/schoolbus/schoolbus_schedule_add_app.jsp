<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>新增时间</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>新增时间
	</div>
	<div class="app_apply_leave schedule_add">
	
	<form action="" method="post">
	<span>开始日期：</span>
	<p>
		<input class="leave_add_input" placeholder="开始日期" readonly="readonly" name="startTime" id="startday" type="text">
	</p>
	<span>结束日期：</span>
	<p>
		<input class="leave_add_input" readonly="readonly" placeholder="结束日期" name="endTime" id="endday" type="text">
	</p>
	<span>上午上学下车：</span>
	<p><input class="leave_add_input" readonly="readonly" placeholder="开始时间" name="starttime" id="starttime" type="text"></p>
	<span>上午放学上车车：</span>
	<p><input class="leave_add_input" readonly="readonly" placeholder="结束时间" name="endtime" id="endtime" type="text"></p>
	<span>下午上学下车：</span>
	<p><input class="leave_add_input" readonly="readonly" placeholder="开始时间" name="starttime" id="starttime" type="text"></p>
	<span>下午放学上车：</span>
	<p><input class="leave_add_input" readonly="readonly" placeholder="结束时间" name="endtime" id="endtime" type="text"></p>
	
	<button type="submit" class="leave_add">确定</button>
	</form>
	</div>
	

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 


</html>