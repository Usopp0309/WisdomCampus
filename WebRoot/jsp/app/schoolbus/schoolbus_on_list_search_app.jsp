<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<%
String apiKey=request.getParameter("apiKey");
String schoolId =request.getParameter("schoolId");
String roleCode =request.getParameter("roleCode");
%>
<!DOCTYPE html>
<head>
	<title>校车记录搜索</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
	
<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>校车记录搜索
	</div>
	<div class="app_search">
	
	<form action="<%=basePath%>schoolbus/toSchoolBusOnListByHuxinId.do" class="form-horizontal" method="post">
	<span>类型选择</span>
	<ul>
		<li class="select" id="1">学生</li><li id="2">家长</li><li id="3">司机</li>
		<input type="hidden" class="val" name="type" value="1">
	</ul>
	
	<c:if test="${roleCode != 'student'}">
		<span>选择班级</span>
		<p>	
			<a href="#select_type2" data-toggle="modal">
				<input type="text"readonly="readonly" class="clazz_show" value="全部">
				<input type="hidden" readonly="readonly" class="clazz" name="clazzId" value="">
			</a>
		</p>
	</c:if>
	<span>卡号/拥有者</span>
	<p><input type="text" name="queryContent"></p>
	<p>
		<button type="submit">查找</button>
	</p>
	
	<input type="hidden" name="schoolId" value="${schoolId }">
	<input type="hidden" name="apiKey" value="${apiKey}">
	<input type="hidden" name="roleCode" value="${roleCode}">
	
	</form>
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
			    
		  		$(".clazz_type").on("click",function(){
				  	var text=$(".leave_clazz li[style]").text();
				  	var id=$(".leave_clazz li[style]").attr("id");
				  	$(".clazz_show").val(text);
				  	$(".clazz").attr("value", id);
		  		})
		  })
	</script>

</html>