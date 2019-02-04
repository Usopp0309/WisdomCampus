<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>请假审核</title>
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
	<div class="AuditLeave">
		<p>请假人：${leave.userName}</p>
		<p>请假日期：${leave.startTime}至${leave.endTime}</p>
		<p>请假类型：
		   	<c:if test="${leave.type == 0}"> 事假</c:if>
			<c:if test="${leave.type == 1}"> 病假 </c:if>
			<c:if test="${leave.type == 2}"> 产假 </c:if>
			<c:if test="${leave.type == 3}"> 出差 </c:if>
			<c:if test="${leave.type != 0 && leave.type != 1 && leave.type != 2 && leave.type != 3}">其他 </c:if>
		</p>
		<p>请假事由：${leave.remark}</p>
	</div>
	<form action="<%=basePath%>leave/doLeaveAudit.do" class="form-horizontal" method="post" style="text-align: center;">
		<ul class="refuse_b">
			<li class="select">允许</li>
			<li class="refuse">拒绝</li>
		</ul>
		<div style="clear:both"></div>	
		<textarea class="leave_textarea"  rows="5" name="auditRemark" style="display:none">拒绝理由</textarea>		
				
		<button type="submit" class="leave_add" id="auditBtn" style="width:90%" >确定 </button>
		
		<input type="hidden" value="${leave.id}" name="leaveId"/>
		<input type="hidden" value="${leave.applyUserId}" name="applyUserId"/>
		<input type="hidden" id="auditStatus" name="auditStatus" value="1">
		<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
		<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
	</form>

	
	
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->      
	
	<script type="text/javascript">

		$(function(){
			$(".refuse_b li").on("click",function(){
				
				if($(this).hasClass("refuse")){
					$("textarea[name='auditRemark']").show();
					$(this).addClass("select").siblings().removeClass("select");
					$("#auditStatus").val("2");
				}else{
					$("textarea[name='auditRemark']").hide();
					$(this).addClass("select").siblings().removeClass("select");
					$("#auditStatus").val("1");
				}
			})
			$("#cancel").click(function(){
				 window.location.href='javascript:history.go(-1);';
			});

			//审核select
			$("#auditStatus").change(function(){
				var auditStatus = parseInt($(this).val());
				switch (auditStatus)
				{
					//请审核
					case 0:
						//隐藏审核备注框
						$("#auditRemarkDiv").hide();
						//隐藏审核操作按钮
						$("#auditBtn").hide();						
						break;
					//允许
					case 1:
						//显示允许备注框
						$("#auditRemarkLabel").html("允许备注：");
						$("#auditRemarkDiv").show();
						//显示允许按钮
						$("#auditBtn").removeClass("red");
						$("#auditBtn").addClass("green");
						$("#auditBtnVal").html("允许");
						$("#auditBtnIcon").removeClass("icon-remove");
						$("#auditBtnIcon").addClass("icon-ok");
						$("#auditBtn").show();			
						break;
					//拒绝
					case 2:
						//显示拒绝备注框
						$("#auditRemarkLabel").html("拒绝备注：");
						$("#auditRemarkDiv").show();
						//显示拒绝按钮
						$("#auditBtn").removeClass("green");
						$("#auditBtn").addClass("red");
						$("#auditBtnVal").html("拒绝");
						$("#auditBtnIcon").removeClass("icon-ok");
						$("#auditBtnIcon").addClass("icon-remove");
						$("#auditBtn").show();			
						break;
				}
				
			});

		});

	</script>
</html>