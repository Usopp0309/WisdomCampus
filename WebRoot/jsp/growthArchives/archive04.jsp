<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>

<html lang="en"> 

<head>

	<title>教师评价</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen" id="cssLink"/>
	<link href="<%=basePath%>media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="<%=basePath%>media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
</head>
<script type="text/javascript">
	var path =window.parent.$("#path").val();
	</script>
<body class="overflow-y-hidden">
<div class="template_bg">
<div class="archive_bg">
					
					<div class="archive04" contenteditable="true">
							<ul class="evaluation_list">
								<li>
									<input id="conductStar" value="" style="display: none"/> 
									<div class="num" id="conduct">
										<p><span>品德</span>
											<i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i>
										</p>
									</div>
									<div id="conductText" class="span6 m-wrap archive04_info"></div>
								</li>
								<li>
									<input id="sportStar" value="" type="hidden"/>
									<div class="num" id="sport">
									
									<p>
									<span>体育</span>
										<i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i>
									</p>
									</div>
									<div id="sportText" class="span6 m-wrap archive04_info"></div>
								</li>
								<li>
									<input id="studyStar" value="" style="display: none"/>
									<div class="num" id="study">
									<p>
									<span>学习</span>
										<i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i>
									</p>
									</div>
									<div id="studyText" class="span6 m-wrap archive04_info" ></div>
								</li>
								<li>
									<input id="lifeStar" value="" style="display: none"/>
									<div class="num" id="life">
									<p>
									<span>生活</span>
										<i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i><i class="icon-heart"></i>
									</p>
									</div>
									<div id="lifeText" class="span6 m-wrap archive04_info"></div>
								</li>
							</ul>
					</div>
					
					</div>
      <a class="tprev" href="<%=basePath %>jsp/growthArchives/archive03.jsp" target="archive_page"></a>
	  <a class="tnext" href="<%=basePath %>jsp/growthArchives/archive05.jsp" target="archive_page"></a>
		
			</div>
	</body>	
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery(document).ready(function(){     
	$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
	$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/04.png'>");
	
	loadThisPage();
	$(".template_bg a").on("click",function(){
		var val=$(this).attr("href");
		$("#page_list li",parent.document).each(function(){
			$(this).find("a").removeAttr("class");
			$(this).find("a").find("i").remove();
			if($(this).find("a").attr("href")==val){
				$(this).find("a").addClass("active"); 
				$(this).find("a").append("<i></i>");
			}
		});
	})
	
})
function loadThisPage(){
	$.ajax({
		type: "post",
		url: "<%=basePath%>evaluateKindergarten/toEvaluateDetailByUserId.do",
		data:{
			studentId : $("#userId",window.parent.document).val(),
			endDate : $("#endDate",window.parent.document).val()
		},
		success: function(data){
			var evaluateKindergarten = eval("(" + data + ")");
			$("#conductStar").val(evaluateKindergarten.conductStar);
			$("#sportStar").val(evaluateKindergarten.sportStar);
			$("#studyStar").val(evaluateKindergarten.studyStar);
			$("#lifeStar").val(evaluateKindergarten.lifeStar);
			$("#conductText").html(evaluateKindergarten.conduct);
			$("#sportText").html(evaluateKindergarten.sport);
			$("#studyText").html(evaluateKindergarten.study);
			$("#lifeText").html(evaluateKindergarten.life);

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
	});
}

</script>
</html>