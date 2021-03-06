<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>今日活动搜索</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
</head>
<body>
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>今日活动搜索
	</div>  
	<div class="app_search">
		<form action="<%=basePath%>todayActivity/toTodayActivityHuXin.do" class="form-horizontal" method="post">
			<span>开始日期</span>
			<p>
				<input readonly="readonly" name="startDate" id="startDate" type="text">
			</p>
			
			<span>选择班级</span>
			<p>	
				<a href="#select_type2" data-toggle="modal">
					<input type="text"readonly="readonly" class="clazz_show" value="点击选择班级">
					<input type="hidden" readonly="readonly" class="clazz" name="clazzId" value="">
				</a>
			</p>
			
			<p>
				<button type="submit">查找</button>
			</p>
			
			<input type="hidden" name="schoolId" value="${schoolId}">
			<input type="hidden" name="apiKey" value="${apiKey}">
			<input type="hidden" name="roleCode" value="${roleCode}">
		</form>
	</div>
	
	<div data-keyboard="false" data-backdrop="select_type2" tabindex="-1" class="modal hide fade" id="select_type2" style="display: none; margin-top: 8%;" aria-hidden="true">
		<div class="modal-body">
			<h2 class="modal_h2">选择班级</h2>
			<ul class="leave_clazz">
				 <c:forEach items="${clazzList }" var="c" >
			    	<li id="${c.id }">${c.clazzName}</li>
			    </c:forEach>
			</ul>
		</div>
		<input type="hidden" value="${userId}" name="userId" id="userId"/>
		<div class="modal-footer">
			<button class="leave_add clazz_type" data-dismiss="modal" type="button">确定</button>
		</div>
		
	</div> 
	
			
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">
		$(function(){
			  $(".leave_clazz li").on("click",function(){
			    	$(this).css({"background-color":"#168ff2","color":"#fff"}).siblings().removeAttr("style");
			    })
			    
		  		$(".clazz_type").on("click",function(){
				  	var text=$(".leave_clazz li[style]").text();
				  	var id=$(".leave_clazz li[style]").attr("id");
				  	$(".clazz_show").val(text);
				  	$(".clazz").attr("value", id);
		  		})
		 })
		 var opt={};
			var currYear = (new Date()).getFullYear();
			opt.date = {preset : 'date'};
			opt.default = {
				theme: 'android-ics light', //皮肤样式
		        display: 'modal', //显示方式 
		        mode: 'scroller', //日期选择模式
				dateFormat: 'yyyy-mm-dd',
				lang: 'zh',
				showNow: true,
				nowText: "当前",
		        startYear: currYear-10, //开始年份
		        endYear: currYear + 10 //结束年份
			};
			var optDateTime = $.extend(opt['datetime'], opt['default']);
		    $("#startDate,#endDate").mobiscroll($.extend(opt['date'], opt['default']));
	</script>
</html>