<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>请假申请</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="history.go(-1);"></i>请假申请
	</div>
	<div class="app_search">

		<form action="<%=basePath%>leave/doAddLeaveApp.do"
			class="form-horizontal" method="post" id="saveForm">

			<span>请假人：</span>
			<p>
				<a href="#select_UserId" data-toggle="modal"> <input
					class="leave_User_Id_show" readonly="readonly" type="text"
					placeholder="选择请假人"> <input name="applyUserId"
					class="leave_User_Id" type="hidden" id="applyUserId">
				</a>
			</p>



			<span>请假开始时间：</span>
			<p>
				<input placeholder="开始日期" readonly="readonly" name="startTime"
					id="startday" type="text">
			</p>


			<span>请假结束时间：</span>
			<p>
				<input readonly="readonly" placeholder="结束日期" name="endTime"
					id="endday" type="text">
			</p>


			<!--  <span>起始时间：</span>
		     <p><input readonly="readonly" placeholder="开始时间" name="starttime" id="starttime" type="text"></p>
		
		
			<span>结束时间：</span>
			 <p><input readonly="readonly" placeholder="结束时间" name="endtime" id="endtime" type="text"></p> -->


			<span>请假类型：</span>
			<p>
				<a href="#select_type" data-toggle="modal"> <input
					class="leave_type_input_show" readonly="readonly" type="text"
					placeholder="选择类型"> <input name="type"
					class="leave_type_input" type="hidden" id="leaveType">
				</a>
			</p>


			<span>审核人：</span>
			<p>
				<a href="#select_auditId" data-toggle="modal"> <input
					class="leave_audit_Id_show" readonly="readonly" type="text"
					placeholder="选择类型"> <input name="auditId" value="0"
					class="leave_audit_Id" type="hidden" id="auditId">
				</a>
			</p>


			<span style="border: none;">请假缘由：</span>

			<p>
				<textarea name="remark" id="remark" rows="" cols=""
					style="height: 50px;">请假缘由</textarea>
			</p>
			<p>
				<button type="button" id="applyBtn" name="applyBtn" value="申请">申请</button>
			</p>

			<input type="hidden" id="roleCode" name="roleCode"
				value="${roleCode}"> <input type="hidden" id="apiKey"
				name="apiKey" value="${apiKey}"> <input type="hidden"
				id="schoolId" name="schoolId" value="${schoolId}">
		</form>
	</div>

	<div data-keyboard="false" data-backdrop="static" tabindex="-1"
		class="modal hide fade" id="select_UserId"
		style="display: none; margin-top: 8%;" aria-hidden="true">
		<div class="modal-body">
			<h2 class="modal_h2">选择请假人</h2>
			<ul class="leave_UserId" id="applyPersonSelect">
			</ul>
		</div>

		<div class="modal-footer">
			<button class="leave_add leave_User_sub" data-dismiss="modal"
				type="button">确定</button>
		</div>

	</div>

	<div data-keyboard="false" data-backdrop="static" tabindex="-1"
		class="modal hide fade" id="select_auditId"
		style="display: none; margin-top: 8%;" aria-hidden="true">
		<div class="modal-body">
			<h2 class="modal_h2">选择审核人</h2>
			<ul class="leave_auditId" id="auditSelect">
			</ul>
		</div>

		<div class="modal-footer">
			<button class="leave_add leave_audit_sub" data-dismiss="modal"
				type="button">确定</button>
		</div>

	</div>

	<div data-keyboard="false" data-backdrop="static" tabindex="-1"
		class="modal hide fade" id="select_type"
		style="display: none; margin-top: 8%;" aria-hidden="true">
		<div class="modal-body">
			<h2 class="modal_h2">选择类型</h2>
			<ul class="leave_type">
				<li id="0">事 假</li>
				<li id="1">病 假</li>
				<li id="2">产 假</li>
				<li id="3">出 差</li>
				<li id="4">其 他</li>

			</ul>
		</div>
		<input type="hidden" value="${userId}" name="userId" id="userId" />
		<div class="modal-footer">
			<button class="leave_add leave_type_sub" data-dismiss="modal"
				type="button">确定</button>
		</div>

	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">
		$(function() {    
			$("#cancel").click(function(){
				 window.location.href='javascript:history.go(-1);';   
			});
			
			$("#applyBtn").click(function(){
				submitForm();
			})
			var userId = $("#userId").val();
			var roleCode = $("#roleCode").val();

			getApplyPerson(roleCode,userId);
			
			//申请人改变 对应的审核人也将会改变（主要针对一个家长有多个小孩）
			$("#applyPersonSelect").change(function(){
				var personId = $("#applyPersonSelect").val();
				getAuditPerson(roleCode,personId);
			});

		});

		function submitForm(){
			if(check()){
				$("#saveForm").submit();
			}
			
		}
		//加载申请人
		function getApplyPerson(roleCode,userId)
		{ 
			$.ajax({
				async: false,
				type: "post",
				url: "<%=basePath%>leave/getApplyPerson.do",
				data:{
					roleCode : roleCode,
					userId : userId
				},	
				success: function(data){
					var applyPerson = eval("(" + data + ")");
					var applyPersonSelectHtml = '<li id="0">选择请假人</li>';

					$.each(applyPerson, function(n, value) {  
						//select页面
						applyPersonSelectHtml += '<li id="' + value.userId + '">' + value.realName +' </li>';
                         
	          		});

          			$("#applyPersonSelect").html(applyPersonSelectHtml);
          			 $(".leave_UserId").on("click","li",function(){
         		    	$(this).css({"background-color":"#168ff2","color":"#fff"}).siblings().removeAttr("style");
         		    	var text=$(".leave_UserId li[style]").text();
        		    	var id=$(".leave_UserId li[style]").attr("id");
        		    	$(".leave_User_Id_show").val(text);
        		    	$(".leave_User_Id").attr("value", id);
         		    })
				},
			});
		} 
		
		//加载审核人
		function getAuditPerson(roleCode,applyPersonId)
		{ 
			$.ajax({
				type: "post",
				url: "<%=basePath%>leave/getAuditPerson.do",
				data:{
					roleCode : roleCode,
					applyPersonId : applyPersonId
				},	
				success: function(data){
					var auditPerson = eval("(" + data + ")");
					
					//年级select页面html
					var auditPersonSelectHtml = '<li id="0">--请选择--</li>';

					$.each(auditPerson, function(n, value) {  
						//select页面
						auditPersonSelectHtml += '<li id="' + value.userId + '">' + value.realName +' </li>';
                         
	          		});

          			$("#auditSelect").html(auditPersonSelectHtml);
          			$(".leave_auditId li").on("click",function(){
	       		    	$(this).css({"background-color":"#168ff2","color":"#fff"}).siblings().removeAttr("style");
	       		    	var text=$(".leave_auditId li[style]").text();
	       		    	var id=$(".leave_auditId li[style]").attr("id");
	       		    	$(".leave_audit_Id_show").val(text);
	       		    	$(".leave_audit_Id").attr("value", id);
	       		    })
				},
			});
		} 

	    function check(){
// 	        var startTime = $("#starttime").val();
// 	        var endTime = $("#endtime").val();
	        var remark = $("#remark").val();
	        var applyUserId = $("#applyUserId").val();
	        var startDay = $("#startday").val();
	        var endDay = $("#endday").val();
	        var leaveType = $("#leaveType").val();
	        var auditId = $("#auditId").val();
	        
	        if ("" == applyUserId){
	        	showTip("申请人不能为空");
		            
		            return false;
		       }
	        if ("" == startDay){
	        	showTip("请假开始日期不能为空");
	            
	            return false;
	        }
	        if ("" == endDay){
	        	showTip("请假结束日期不能为空");
	            
	            return false;
	        }
// 	        if ("" == startTime){
// 	        	showTip("起始时间不能为空");
	            
// 	            return false;
// 	        }
	      
// 	        if ("" == endTime){
// 	        	showTip("结束时间不能为空");
// 	            return false;
// 	        }
	        
	        if ("" == remark){
	        	showTip("请假事由不能为空");
	            return false;
	        }
	      
	        if ("" == leaveType){
	        	showTip("请假类型不能为空");
	            
	            return false;
	        }
	        if ("0" == auditId){
	        	showTip("审核人不能为空");
	            
	            return false;
	        }
	        var flag = false;
	        if (!compareCalendar(startDay, endDay)){
	        	showTip("请假开始日期不能大于结束日期");
	            return false;
	        }else{
	        	flag = true;
	        }
	        return true;
	    }
	    
	    $(function () {
			var opt={};
			var currYear = (new Date()).getFullYear();
			opt.date = {preset : 'date'};
			opt.datetime = {preset : 'datetime'};
			opt.time = {preset : 'time'};
			opt.default = {
				theme: 'android-ics light', //皮肤样式
		        display: 'modal', //显示方式 
		        mode: 'scroller', //日期选择模式
				dateFormat: 'yy-mm-dd',
				lang: 'zh',
				dateOrder:'yymmdd', //面板中日期排列格式
				showNow: true,
				nowText: "当前",
		        startYear: currYear, //开始年份
		        endYear: currYear + 10 //结束年份
			};

		 
		  	var optDateTime = $.extend(opt['datetime'], opt['default']);
		  	var optTime = $.extend(opt['time'], opt['default']);
		  	$("#startday,#endday").mobiscroll(optDateTime).datetime(optDateTime);
			/* $("#startday,#endday").mobiscroll($.extend(opt['date'], opt['default']));
		    $("#starttime,#endtime").mobiscroll(optTime).time(optTime); */
		    
		    $(".leave_type li").on("click",function(){
		    	$(this).css({"background-color":"#168ff2","color":"#fff"}).siblings().removeAttr("style");
		    	var text=$(".leave_type li[style]").text();
		    	var id=$(".leave_type li[style]").attr("id");
		    	$(".leave_type_input_show").val(text);
		    	$(".leave_type_input").attr("value", id);
		    })
		   
		     
		    
		    
		    
		     $(".leave_User_sub").on("click",function(){
		    	var text=$(".leave_UserId li[style]").text();
		    	var id=$(".leave_UserId li[style]").attr("id");
		    	$(".leave_User_Id_show").val(text);
		    	$(".leave_User_Id").attr("value", id);
		    	
		    	var roleCode = $("#roleCode").val();
				getAuditPerson(roleCode,id);
		    })
		    
	    });
	   
	</script>
</html>