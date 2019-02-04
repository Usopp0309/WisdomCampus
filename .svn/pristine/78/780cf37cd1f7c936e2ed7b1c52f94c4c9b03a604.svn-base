<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">

<head>

	<title>每日活动</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen"  id="cssLink"/>

</head>
<script type="text/javascript">
	var path =window.parent.$("#path").val();
	</script>
<body class="overflow-y-hidden">
<div class="template_bg">
<div class="archive_bg">
					<div class="archive08">
					<table id="dataTable">
					<thead>
						<tr>
							<th>时间段</th>
							<th>活动内容</th>
						</tr>
					</thead>
						<tbody id="tbody">
						</tbody>
					</table>
					</div>
					</div>
	  <a class="tprev" href="<%=basePath %>jsp/growthArchives/archive07.jsp" target="archive_page"></a>
	  <a class="tnext" href="<%=basePath %>jsp/growthArchives/archive09.jsp" target="archive_page"></a>
</div>
</body>
<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function(){
	$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
	$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/08.png'>");
	
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
	});
	
})
function loadThisPage(){
	$.ajax({
		type: "post",
		url: "<%=basePath%>curriculum/getCurriculumController.do",
		data:{
				userId : $("#userId",window.parent.document).val(),
				endDate : $("#endDate",window.parent.document).val()
			},
		success: function(data){
			var getData = eval('('+data+')');
			var html="";
			for(var i=0;i<getData.length;i++){
				html+="<tr>"+
							"<td class='info_list_left'>"+getData[i].beginTime+"-"+getData[i].endTime+"</td>"+
							"<td class='info_list_right'>"+getData[i].subjectName+"</td>"+
						"</tr>";
			}
			if(getData.length>0){
				$("#dataTable").after("<a class='archive08_more' href='<%=basePath %>curriculum/toSetCurriculum.do' target='mainPage'>查看更多>></a>");
			}
				$("#tbody").html(html);
		}
	});
}
</script>
</html>