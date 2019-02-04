<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>老师评价班级筛选</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>班级筛选
	</div>
	<div class="app_search">
	
		<form action="<%=basePath%>evaluateKindergarten/getStudentList.do" class="form-horizontal" method="post">
			<span>班级列表</span>
			<ul id="clazzList">
			    <c:forEach items="${clazzList}" var="clazz" varStatus="status">
						<c:if test="${status.index == 0}">
							<li id="${clazz.id}" class="select">${clazz.clazzName }</li>
						</c:if>
						<c:if test="${status.index != 0}">
							<li id="${clazz.id}">${clazz.clazzName }</li>
						</c:if>
				</c:forEach>
				<input id="clazzId" type="hidden" name="clazzId" value="">
			</ul>
			<p style="clear: both">
				<button type="submit">查找</button>
			</p>
			
		</form>
		
	</div>

	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	</body>

   <script type="text/javascript">
	   $(function() {   
			var clazzId = $("#clazzList li.select").attr("id");
			$("#clazzId").val(clazzId);
			$("#clazzList li").on("click",function(){
				$(this).siblings("input").val($(this).attr("id"));
				$(this).addClass("select").siblings().removeAttr("class");
			});
		});
   </script>

</html>