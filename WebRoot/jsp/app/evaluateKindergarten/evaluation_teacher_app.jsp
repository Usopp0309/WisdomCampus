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
		<i class="  m_icon-return icon_left" onclick="history.go(-1);"></i>老师评价
		
	</div>
	<div class="evaluation_time">
		<c:if test="${not empty evaluateKindergarten.createTime}">
		<button class="btn" data-dismiss="modal" type="button">${evaluateKindergarten.createTime }</button>
		</c:if>
	</div>
	<input id="attr1" value="${attr1 }" style="display: none"/> 
	<form action="<%=basePath %>evaluateKindergarten/addEvaluation.do" method="post" id="submitForm">
		<ul class="evaluation_list">
			<div class="evaluation_header">
				<div class="header_title">
					<p><span>姓名：</span>${student.realName }</p>
					<p><span>班级：</span>${clazzName }</p>
				</div>
				<input id="clazzId" name="clazzId" value="${clazz.id }" style="display: none"/>
				<input id="studentId" name="studentId" value="${student.userId }" style="display: none"/> 
			</div>
			<li style="margin:20px auto 0px;">
				
				<div class="num" id="conduct" onclick="changeStar()">
				<span>思想品德</span>
				<input id="conductStar" name="conductStar" value="${evaluateKindergarten.conductStar }" style="display: none"/> 
				<p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></p></div>
				<textarea id="conductText" name="conductText" rows="" cols="" placeholder="评价">${evaluateKindergarten.conduct }</textarea>
			</li>
			<li>
				
				<div class="num" id="sport" onclick="changeStar()">
				<span>活泼度</span>
				<input id="sportStar" name="sportStar" value="${evaluateKindergarten.sportStar }" style="display: none"/>
				<p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i>
				</p></div>
				<textarea id="sportText" name="sportText" rows="" cols="" placeholder="评价">${evaluateKindergarten.sport }</textarea>
			</li>
			<li>
				
				<div class="num" id="study" onclick="changeStar()">
				<span>学习认识力</span>
				<input id="studyStar" name="studyStar" value="${evaluateKindergarten.studyStar }" style="display: none"/>
				<p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></p></div>
				<textarea id="studyText" name="studyText" rows="" cols="" placeholder="评价">${evaluateKindergarten.study }</textarea>
			</li>
			<li>
				
				<div class="num" id="life" onclick="changeStar()">
				<span>生活自理力</span>
				<input id="lifeStar" name="lifeStar" value="${evaluateKindergarten.lifeStar }" style="display: none"/>
				<p><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></p></div>
				<textarea id="lifeText" name="lifeText" rows="" cols="" placeholder="评价">${evaluateKindergarten.life }</textarea>
			</li>
		</ul>
	</form>
	<c:if test="${attr1 eq 'already' }">
				<p onclick="history.go(-1);" >
				<button class="footer_btn">取消</button>
				</p>
		</c:if>
		<c:if test="${attr1 eq 'no' }">
			<p onclick="submitForm()">
				<button class="footer_btn">保存</button>
			</p>
		</c:if>
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
			var attr1 = $("#attr1").val();
			if(attr1 == 'already'){
				//初始化星级数
				var conductStar = $("#conductStar").val();
				$("#conduct").find("i:lt("+ conductStar +")").css({"color":"#f96767"});

				var sportStar = $("#sportStar").val();
				$("#sport").find("i:lt("+ sportStar +")").css({"color":"#f96767"});

				var studyStar = $("#studyStar").val();
				$("#study").find("i:lt("+ studyStar +")").css({"color":"#f96767"});

				var lifeStar = $("#lifeStar").val();
				$("#life").find("i:lt("+ lifeStar +")").css({"color":"#f96767"});
			}

			$(".num i").on("click",function(){
				var eq_id=$(this).index()+1;
				var _this=$(this).parent();
				_this.find("i").removeAttr("style");
				_this.find("i:lt("+ eq_id +")").css({"color":"#f96767"});
				var id = _this.prev().attr("id");
				$("#"+id).val(eq_id);
			});

			$(".more_role_choose li").on("click",function(){
				var roleCode = $(this).attr("id");
				if(roleCode == 'parent' || roleCode == 'student'){
					window.location.href='<%=basePath%>evaluateKindergarten/toChangeByStudentId.do';
				}else{
					window.location.href='<%=basePath%>evaluateKindergarten/getStudentList.do';
				}
			});
			
			$("#role").on("click",function(){
				$("#static").modal("show");
			});

			$("#search").on("click",function(){
				var studentId = $("#studentId").val();
				var clazzId = $("#clazzId").val();
				standardPost('<%=basePath%>evaluateKindergarten/toEvaluateTimeSearchByApiKey.do',{studentId:studentId,clazzId:clazzId});
			});
		})
		
		function submitForm(){
			var conductText =  $('#conductText').val().trim();
			var sportText = $('#sportText').val().trim();
			var studyText = $('#studyText').val().trim();
			var lifeText = $('#lifeText').val().trim();
			if(conductText == '' || sportText == '' || studyText == '' || lifeText == ''){
				alert("请完全输入评价内容!");
			}else{
				if (confirm("您确认要提交表单吗？")){
					$("#submitForm").submit();
				}
			}
			
		}
		
	</script>

</html>