<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>教师评价详情</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
</head>
<body id="body" style="background-color: #f7f7f7">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="history.go(-1);"></i>老师评价详情
	</div>
	<div class="evaluation_time">
		<c:if test="${not empty evaluateKindergarten.createTime}">
		<button class="btn" data-dismiss="modal" type="button">${evaluateKindergarten.createTime }</button>
		</c:if>
	</div>
	<form action="" method="post" id="submitForm">
		<ul class="evaluation_list">
			<div class="evaluation_header">
				<div class="header_title">
					<p>${student.realName }</p>
					<p>${clazzName }</p>
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

		})

	</script>

</html>