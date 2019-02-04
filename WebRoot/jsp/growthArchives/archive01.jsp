<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">
<head>

	<title>成长档案01</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen"  id="cssLink"/>
	<script type="text/javascript">
	var path =window.parent.$("#path").val();
	</script>
</head>


<body class="overflow-y-hidden">
<div class="template_bg">
	   <div class="archive_bg">
		<div class="archive01_info">
			<p class="p1" >幼儿园：<span id="schoolName"></span></p>
			<p class="p2" >姓名：<span id="realName"></span></p>
			<p class="p3">班级：<span id="clazzName"></span></p>
		</div>
	  </div>
	  <%-- <a class="tprev" href="<%=basePath %>jsp/growthArchives/archive01.jsp" target="archive_page"></a> --%>
	  <a class="tnext" href="<%=basePath %>jsp/growthArchives/archive03.jsp" target="archive_page"></a>
</div>			
	


</body>
<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery(document).ready(function() {     
	
	$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
	$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/01.png'>");
	$("#schoolName").text(window.parent.$("#schoolName").val());
	$("#realName").text(window.parent.$("#realName").val());
	$("#clazzName").text(window.parent.$("#clazzName").val());
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
	
});
	
</script>
</html>