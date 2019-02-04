<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>添加作息时间</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>添加作息时间<i class="itext icon_right">保存</i>
	</div>
	<div class="schedule_add">
	<form action="" class="" method="post">
		<p>设置日期</p>
		<span>开始日期</span>
		<input type="text" readonly="readonly" id="startday">
		<span>结束日期</span>
		<input type="text" readonly="readonly" id="endday">
		<p>设置时间</p>
		
		<div class="tabbable tabbable-custom">

			<ul class="nav nav-tabs">

				<li class="active"><a data-toggle="tab" href="#tab_1_1">整天</a></li>

				<li><a data-toggle="tab" href="#tab_1_2">分段</a></li>

			</ul>

			<div class="tab-content">

				<div id="tab_1_1" class="tab-pane active">
					<span>开始时间</span>
					<input type="text" readonly="readonly" class="time">
					<span>结束时间</span>
					<input type="text" readonly="readonly" class="time">
				</div>

				<div id="tab_1_2" class="tab-pane">

					<div id="accordion1" class="accordion">

						<div class="accordion-group">
	
							<div class="accordion-heading">
	
								<a href="#collapse_1" data-parent="#accordion1" data-toggle="collapse" class="accordion-toggle collapsed">
	
								上午
	
								</a>
	
							</div>
	
							<div class="accordion-body collapse" id="collapse_1" style="height: 0px;">
	
								<span>开始时间</span>
								<input type="text" readonly="readonly" class="time">
								<span>结束时间</span>
								<input type="text" readonly="readonly" class="time">
	
							</div>
	
						</div>

						<div class="accordion-group">

							<div class="accordion-heading">

								<a href="#collapse_2" data-parent="#accordion1" data-toggle="collapse" class="accordion-toggle">

								下午

								</a>

							</div>

							<div class="accordion-body collapse" id="collapse_2" style="height: 0px;">

								<span>开始时间</span>
								<input type="text" readonly="readonly" class="time">
								<span>结束时间</span>
								<input type="text" readonly="readonly" class="time">

							</div>

						</div>

						<div class="accordion-group">

							<div class="accordion-heading">

								<a href="#collapse_3" data-parent="#accordion1" data-toggle="collapse" class="accordion-toggle">

								晚上

								</a>

							</div>

							<div class="accordion-body collapse" id="collapse_3" style="height: 0px;">

								<span>开始时间</span>
								<input type="text" readonly="readonly" class="time">
								<span>结束时间</span>
								<input type="text" readonly="readonly" class="time">

							</div>

						</div>

					</div>

				</div>

				

			</div>

		</div>
	</form>
	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">
		//初始化时间插件
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
	        startYear: currYear, //开始年份
	        endYear: currYear + 10 //结束年份
		};
		var optDateTime = $.extend(opt['datetime'], opt['default']);
	  	var optTime = $.extend(opt['time'], opt['default']);
	    /*$("#startday,#endday").mobiscroll(optDateTime).datetime(optDateTime);*/
	    $("#startday,#endday").mobiscroll($.extend(opt['date'], opt['default']));
	    $(".time").mobiscroll(optTime).time(optTime);
	</script>
	

</html>