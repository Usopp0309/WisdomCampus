<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>老师评价</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body" style="background-color: #f7f7f7">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>老师评价
<!-- 		<i class="fa fa-ellipsis-v icon_right"></i> -->
<!-- 		<ul class="submenu"> -->
<%-- 			<c:forEach items="${studentList}" var="user"  varStatus="status"> --%>
<%-- 				<li id="${user.userId}">${user.realName }</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul>							 -->
		
		
	</div>
	<div class="evaluation_time">
		<c:if test="${not empty studentScore.createTime}">
			<button class="btn" data-dismiss="modal" type="button">${studentScore.createTime }</button>
		</c:if>
	</div>
	
	<ul class="evaluation_list">
		
		<div class="evaluation_header">
			<div class="header_title">
				<p><span>姓名：</span>${student.realName }</p>
				<p><span>班级：</span>${clazz.clazzName }</p>
			</div>
			<input id="studentId" value="${student.userId }" style="display: none"/> 
		</div>
		<li style="margin:20px auto 0px;">
			<input id="conductStar" value="${studentScore.conductStar }" style="display: none"/> 
			<div class="num" id="conduct"><span>思想品德</span><p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></p></div>
			<textarea rows="" cols="" placeholder="评价" disabled="disabled">${studentScore.conduct }</textarea>
		</li>
		<li>
			<input id="sportStar" value="${studentScore.sportStar }" style="display: none"/>
			<div class="num" id="sport"><span>活泼度</span><p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></p></div>
			<textarea rows="" cols="" placeholder="评价" disabled="disabled">${studentScore.sport }</textarea>
		</li>
		<li>
			<input id="studyStar" value="${studentScore.studyStar }" style="display: none"/>
			<div class="num" id="study"><span>学习认识力</span><p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></p></div>
			<textarea rows="" cols="" placeholder="评价" disabled="disabled">${studentScore.study }</textarea>
		</li>
		<li>
			<input id="lifeStar" value="${studentScore.lifeStar }" style="display: none"/>
			<div class="num" id="life"><span>生活自理力</span><p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></p></div>
			<textarea rows="" cols="" placeholder="评价" disabled="disabled">${studentScore.life }</textarea>
		</li>
	</ul>	
	<div class="select_role">
		<dl>
			<c:if test="${roleListSize >1}">
				<dd class="role_more iconfont" data-toggle="modal" href="#static">&#xe601;</dd>
			</c:if>
			<dd class="role_search iconfont" id="search">&#xe602;</dd>
		</dl>
		<span class="role_img iconfont">&#xe600;</span>
	</div>
	 <div class="modal fade bs-modal-sm" id="static" tabindex="-1" role="dialog" aria-hidden="true">
	 <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	                <div class="modal-body">
		    <ul class="more_role_choose" id="moreRole">
		    	<li id="0">请选择角色</li>
		    	<c:forEach items="${roleList}" var="r">
			       <c:if test="${r.roleCode == 'admin'}">
				  	 <li id="${r.roleCode}">校管</li>
			       </c:if>
			       <c:if test="${r.roleCode == 'president'}">
				  	 <li id="${r.roleCode}">校长</li>
			       </c:if>
			       <c:if test="${r.roleCode == 'departManager'}">
				  	 <li id="${r.roleCode}">部门管理员</li>
			       </c:if>
			       <c:if test="${r.roleCode == 'classLeader'}">
				  	 <li id="${r.roleCode}">班主任</li>
			       </c:if>
			       <c:if test="${r.roleCode == 'teacher'}">
				  	 <li id="${r.roleCode}">教师</li>
			       </c:if>
			       <c:if test="${r.roleCode == 'student'}">
				  	 <li id="${r.roleCode}">学生</li>
			       </c:if>
			        <c:if test="${r.roleCode == 'parent'}">
				  	 <li id="${r.roleCode}">家长</li>
			       </c:if>
			   </c:forEach>
			</ul>
			</div>
			</div>
			</div>
	</div>
		
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	
	<script type="text/javascript">
		$(function(){
			//初始化星级数
			var conductStar = $("#conductStar").val();
			$("#conduct").find("i:lt("+ conductStar +")").css({"color":"#f96767"});

			var sportStar = $("#sportStar").val();
			$("#sport").find("i:lt("+ sportStar +")").css({"color":"#f96767"});

			var studyStar = $("#studyStar").val();
			$("#study").find("i:lt("+ studyStar +")").css({"color":"#f96767"});

			var lifeStar = $("#lifeStar").val();
			$("#life").find("i:lt("+ lifeStar +")").css({"color":"#f96767"});
			
			$(".fa-ellipsis-v").on("click",function(){
				$(".submenu").show();
			});
			$(".submenu li").on("click",function(){
				var id = $(this).attr("id");
				//当前页面的学生id
				var studentId = $("#studentId").val();
				if(studentId != id){
					standardPost('<%=basePath%>evaluateKindergarten/toChangeByStudentId.do',{studentId:id});
				}
			});

			$(".more_role_choose li").on("click",function(){
				var roleCode = $(this).attr("id")
				if(roleCode != 'parent' && roleCode != 'student'){
					window.location.href='<%=basePath%>evaluateKindergarten/getStudentList.do';
				}
			});
			
			$("#role").on("click",function(){
				$("#static").modal("show");
			});

			$("#search").on("click",function(){
				window.location.href= '<%=basePath%>evaluateKindergarten/toEvaluateParentSearchByApiKey.do';
			});
		})
	</script>

</html>