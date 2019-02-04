<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>老师评价搜索（家长）</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>老师评价搜索
	</div>
	<div class="app_search">
	
		<form action="<%=basePath%>evaluateKindergarten/toSearchEvaluateByEvaluateId.do" class="form-horizontal" method="post">
			<span>小孩名称</span>
			<ul id="studentName">
				<c:forEach items="${studentList}" var="user" varStatus="status">
						<c:if test="${status.index == 0}">
							<li id="${user.userId}" class="select">${user.realName }</li>
						</c:if>
						<c:if test="${status.index != 0}">
							<li id="${user.userId}">${user.realName }</li>
						</c:if>
				</c:forEach>
				<input id="studentId" type="hidden" name="studentId" value="">
			</ul>
			
			<span>选择评价日期</span>
			<ul id="startTime">
			</ul>
			<input id="evaluateId" type="hidden" name="evaluateId" value="">
			<p style="clear: both">
				<button type="submit">查找</button>
			</p>
		</form>
		
	</div>
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

   <script type="text/javascript">

	    $(function() {   
			var studentId = $("#studentName li.select").attr("id");
			$("#studentId").val(studentId);
			loadEvaluateKindergartenList(studentId);

			$("#studentName li").on("click",function(){
				$(this).siblings("input").val($(this).attr("id"));
				$(this).addClass("select").siblings().removeAttr("class");
				var studentId = $("#studentId").val();
				loadEvaluateKindergartenList(studentId);
			});
		});
	    
		// 加载该同学所有的评价列表
		function loadEvaluateKindergartenList(studentId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>evaluateKindergarten/loadEvaluateKindergartenListByStudentId.do",
				data:{
					studentId : studentId
					},
				success: function(data){
					var evaluateKindergartenList = eval("(" + data + ")");
					var appendHtml = '';
					if(evaluateKindergartenList.length > 0){
						$.each(evaluateKindergartenList, function(n, value) {
							if(n == 0){
								appendHtml += '<li id="'+value.id+'" class="select" onclick="evaluateClick('+value.id+')">'+value.createTime+'</li>';
								$("#evaluateId").val(value.id);
							}else{
								appendHtml += '<li id="'+value.id+'" onclick="evaluateClick('+value.id+')">'+value.createTime+'</li>';
							}				
							
	           			});
					}else{
						appendHtml += '<li>还未评价</li>';
						$("#evaluateId").val("");
					}
           			$("#startTime").html(appendHtml);
				},
			});
		}	

		//选择时间的点击事件
		function  evaluateClick(evaluateId){
			$("#"+evaluateId).addClass("select").siblings().removeAttr("class");
			$("#evaluateId").val(evaluateId);
		}   
		
   </script>

</html>