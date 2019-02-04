<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>会议搜索</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>会议搜索
	</div>
	<div class="app_search">
	
	<form action="<%=basePath%>meeting/toMeetingDetail.do" class="form-horizontal" method="post">
		<span>状态</span>
		<p>
			<a href="#select_type" data-toggle="modal">
				<input type="text"readonly="readonly" class="department_show" value="点击选择状态">
				<input type="hidden"readonly="readonly" class="department" name="attenStatus" value="4">
			</a>
		</p>

		<span>参会人</span>
		<p>
			<input  name="queryContent" type="text">
		</p>
		<p>
			<button type="submit">查找</button>
		</p>
	    <input type="hidden" id="meetingId" name="meetingId" value="${meetingId}">
		<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
		<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
	</form>
	</div>
	<div data-keyboard="false" data-backdrop="select_type" tabindex="-1" class="modal hide fade" id="select_type" style="display: none; margin-top: 8%;" aria-hidden="true">
		<div class="modal-body">
			<h2 class="modal_h2">选择类型</h2>
			<ul class="leave_type">
				<li id="4">全部</li>
				<li id="0">正常出勤</li>
				<li id="1">迟到</li>	
				<li id="3">缺勤</li>
			</ul>
		</div>
		<input type="hidden" value="${userId}" name="userId" id="userId"/>
		<div class="modal-footer">
			<button class="leave_add leave_type_sub" data-dismiss="modal" type="button">确定</button>
		</div>
		
	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->  
	
	 <script type="text/javascript">
	    $(function(){
	    	  $(".leave_type li").on("click",function(){
			    	$(this).css({"background-color":"#168ff2","color":"#fff"}).siblings().removeAttr("style");
			    })
			     $(".leave_UserId li").on("click",function(){
			    	$(this).css({"background-color":"#168ff2","color":"#fff"}).siblings().removeAttr("style");
			    })
			    $(".leave_type_sub").on("click",function(){
		    	var text=$(".leave_type li[style]").text();
		    	var id=$(".leave_type li[style]").attr("id");
		    	$(".department_show").val(text);
		    	$(".department").attr("value", id);
		    })
		    })
   </script>



</html>