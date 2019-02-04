<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">

<head>

	<title>进出校记录</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen"  id="cssLink"/>

	
</head>
<script type="text/javascript">
	var path =window.parent.$("#path").val();
	</script>
<body  class="overflow-y-hidden">
<div class="template_bg">
<input type="hidden" value="311" id="studentId"/>
	<div class="archive_bg">
					<c:if test="schoolId!=null&&schoolId!=''">
						<c:if test="cardCode!=null&&cardCode!=''">
							<img id="parentImg" src="<%=Cons.KINDERGARTENINOUTIMAGEBASEPATH%>${schoolId }/headImg/${cardCode }_parent.jpg" class="archive05_img_01">
							<img id="studentId" src="<%=Cons.KINDERGARTENINOUTIMAGEBASEPATH%>${schoolId }/headImg/${cardCode }.jpg" class="archive05_img_02">
						</c:if>
					</c:if>
					<div class="archive05_info" id="thisHtml">
						<a class="archive05_more" href="">查看更多>></a>
					</div>
					</div>
	  <a class="tprev" href="<%=basePath %>jsp/growthArchives/archive04.jsp" target="archive_page"></a>
	  <a class="tnext" href="<%=basePath %>jsp/growthArchives/archive06.jsp" target="archive_page"></a>		
			</div>	
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery(document).ready(function(){     
	$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
	$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/05.png'>");
	
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
		url: "<%=basePath%>inout/getInoutListAsStudent.do",
		data:{
			studentId : $("#userId",window.parent.document).val(),
			endDate : $("#endDate",window.parent.document).val()
		},
		success: function(data){
			var evaluateKindergarten = eval("(" + data + ")");
			$("#thisHtml").html();
			var html="";
			for(var i =evaluateKindergarten.length-1;i>evaluateKindergarten.length-5;i--){
				html += "<div class='info_list'>"+
							"<p>"+evaluateKindergarten[i].createTime+"</p>"+
							"<p><span>"+evaluateKindergarten[i].userName+"</span><span>"+evaluateKindergarten[i].itemName+"</span><span>"+evaluateKindergarten[i].code+"</span><span>"+evaluateKindergarten[i].positionName+"</span></p>"+
						"</div>";
			}
			if(evaluateKindergarten.length>0){
				html+="<a class='archive05_more' href='<%=basePath %>dormitory/toDormitoryInoutList.do' target='mainPage'>查看更多>></a>";
			}
			$("#thisHtml").html(html);
		}
	});
}
</script>

</body>

</html>