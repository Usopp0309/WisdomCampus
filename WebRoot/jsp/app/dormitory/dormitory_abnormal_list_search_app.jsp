<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>宿舍异常搜索</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>宿舍异常搜索
	</div>
	<div class="app_search">
	
	<form action="<%=basePath%>dormitory/toDormitoryAbnormalDetailListByHuxinId.do" class="form-horizontal" method="post">
	
		<span>状态类型</span>
		<p>	
			<a href="#select_type" data-toggle="modal">
				<input type="text"readonly="readonly" class="type_show" value="出宿舍已刷卡">
				<input type="hidden"readonly="readonly" class="type" name="type" value="1">
			</a>
		</p>
		
		<span>选择班级</span>
		<p>	
			<a href="#select_type2" data-toggle="modal">
				<input type="text"readonly="readonly" class="clazz_show" value="全部">
				<input type="hidden"readonly="readonly" class="clazz" name="clazzId" value="">
			</a>
		</p>
		
		<span>开始日期</span>
		<p>
			<input readonly="readonly" name="startDate" id="startDate" type="text">
		</p>
		<span>结束日期</span>
		<p>
			<input readonly="readonly"  name="endDate" id="endDate" type="text">
		</p>
			<span>开始时间</span>
		<p>
			<input readonly="readonly" name="startTime" value="00:00" class="time" type="text">
		</p>
		<span>结束时间</span>
		<p>
			<input readonly="readonly"  name="endTime" value="23:59" class="time" type="text">
		</p>
		
		<span>卡号/拥有者/地点</span>
		<p><input type="text" name="queryContent"></p>
		<p>
			<button type="submit">查找</button>
		</p>
		
		<input type="hidden" name="schoolId" value="${schoolId }">
		<input type="hidden" name="apiKey" value="${apiKey}">
		<input type="hidden" name="roleCode" value="${roleCode}">
	
	</form>
	
	</div>
		<div data-keyboard="false" data-backdrop="select_type" tabindex="-1" class="modal hide fade" id="select_type" style="display: none; margin-top: 8%;" aria-hidden="true">
		<div class="modal-body">
			<h2 class="modal_h2">选择类型</h2>
			<ul class="leave_type">											
			<li id="1">出宿舍已刷卡</li>
			<li id="2">出宿舍未刷卡</li>
			<li id="3">进宿舍已刷卡</li>
			<li id="4">进宿舍未刷卡</li>
			</ul>
		</div>
		<input type="hidden" value="${userId}" name="userId" id="userId"/>
		<div class="modal-footer">
			<button class="leave_add leave_type_sub" data-dismiss="modal" type="button">确定</button>
		</div>
		
	</div>
	<div data-keyboard="false" data-backdrop="select_type2" tabindex="-1" class="modal hide fade" id="select_type2" style="display: none; margin-top: 8%;" aria-hidden="true">
		<div class="modal-body">
			<h2 class="modal_h2">选择班级</h2>
			<ul class="leave_clazz">
				<li id="" class="select">全部</li>
				 <c:forEach items="${clazzList }" var="c">
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
			     $(".leave_type li").on("click",function(){
			    	$(this).css({"background-color":"#168ff2","color":"#fff"}).siblings().removeAttr("style");
			    })
			    
			    $(".leave_type_sub").on("click",function(){
				  	var text=$(".leave_type li[style]").text();
				  	var id=$(".leave_type li[style]").attr("id");
				  	$(".type_show").val(text);
				  	$(".type").attr("value", id);
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
		    startYear: currYear-10, //开始年份
		    endYear: currYear + 10 //结束年份
		};
		var optDateTime = $.extend(opt['datetime'], opt['default']);
		var optTime = $.extend(opt['time'], opt['default']);
		$("#startDate,#endDate").mobiscroll($.extend(opt['date'], opt['default']));
		$(".time").mobiscroll(optTime).time(optTime);
	</script>

</html>