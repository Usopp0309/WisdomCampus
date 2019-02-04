<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>学生考勤搜索</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>学生考勤搜索
	</div>
	<div class="app_search">
	
		<form action="<%=basePath%>check/toStudentCheckListByHuxinId.do" class="form-horizontal" method="post">
			<span>选择班级</span>
			<p>	
				<a href="#small" data-toggle="modal">
					<input type="text"readonly="readonly" class="clazz_show" value="点击选择班级">
					<input type="hidden" readonly="readonly" class="clazz" name="clazzId" value="">
				</a>
			</p>
			<span>选择日期</span>
			<p>
				<input readonly="readonly" name="createDate" id="createDate" type="text">
			</p>
			<span>姓名/学号</span>
			<p><input type="text" name="queryContent"></p>
			<p>
				<button type="submit">查找</button>
			</p>
			
			<input type="hidden" name="schoolId" value="${schoolId }">
			<input type="hidden" name="apiKey" value="${apiKey}">
			<input type="hidden" name="roleCode" value="${roleCode}">
		
		</form>
	</div>
	
	<div class="modal fade" id="small" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">选择班级</h4>
                </div>
                <div class="modal-body">
					<ul class="leave_clazz">
						<li id="" class="select">全部</li>
						 <c:forEach items="${clazzList }" var="c">
					    	<li id="${c.id }">${c.clazzName}</li>
					    </c:forEach>
					</ul>
				</div>
                <div class="modal-footer">
                	<input type="hidden" value="${userId}" name="userId" id="userId"/>
					<button class="leave_add clazz_type" data-dismiss="modal" type="button">确定</button>
                </div>
            </div>
        </div>
	</div>

			
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	
	<script type="text/javascript">
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
	    /*$("#startday,#endday").mobiscroll(optDateTime).datetime(optDateTime);*/
	    $("#createDate").mobiscroll($.extend(opt['date'], opt['default']));
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
		  
	</script>



</html>