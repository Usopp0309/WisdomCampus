<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>老师评价时间筛选</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>评价时间筛选
	</div>
	<div class="app_search">
	
		<form action="<%=basePath%>evaluateKindergarten/getEvaluateDetailByEvaluateId.do" class="form-horizontal" method="post">
			<span>评价时间列表</span>
			<ul id="evaluateTimeList">
			    <c:forEach items="${evaluateKindergartenList}" var="evaluate" varStatus="status">
						<c:if test="${status.index == 0}">
							<li id="${evaluate.id}" class="select">${evaluate.createTime }</li>
						</c:if>
						<c:if test="${status.index != 0}">
							<li id="${evaluate.id}">${evaluate.createTime }</li>
						</c:if>
				</c:forEach>
				<input id="evaluateId" type="hidden" name="evaluateId" value="">
			</ul>
			<input id="studentId" type="hidden" name="studentId" value="${studentId }">
			<input id="clazzId" type="hidden" name="clazzId" value="${clazzId }">
			<p>
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
			var evaluateId = $("#evaluateTimeList li.select").attr("id");
			$("#evaluateId").val(evaluateId);
	
			$("#evaluateTimeList li").on("click",function(){
				$(this).siblings("input").val($(this).attr("id"));
				$(this).addClass("select").siblings().removeAttr("class");
			});
		});
   </script>

</html>