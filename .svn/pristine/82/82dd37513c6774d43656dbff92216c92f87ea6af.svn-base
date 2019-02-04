<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">

<script type="text/javascript">
	var path =window.parent.$("#path").val();
	</script>
<head>

	<title>成长档案02</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen" id="cssLink"/>
	
</head>

<body class="overflow-y-hidden">
   <div class="template_bg">
	<div class="archive_bg">
		
		<div class="archive02_info">
			<a href="<%=basePath %>jsp/growthArchives/archive03.jsp">宝贝小档案</a>
			<a href="<%=basePath %>jsp/growthArchives/archive04.jsp">宝贝评价</a>
			<a href="<%=basePath %>jsp/growthArchives/archive05.jsp">进园记录</a>
			<a href="<%=basePath %>jsp/growthArchives/archive06.jsp">每日成长记录</a>
			<a href="<%=basePath %>jsp/growthArchives/archive07.jsp">营养食谱</a>
			<a href="<%=basePath %>jsp/growthArchives/archive08.jsp">多彩的幼儿园活动</a>
			<a href="<%=basePath %>jsp/growthArchives/archive09.jsp">开心的一天</a>
			<a href="<%=basePath %>jsp/growthArchives/archive10.jsp">我的作品展</a>
			<a href="<%=basePath %>jsp/growthArchives/archive11.jsp">亲子活动</a>
			<a href="<%=basePath %>jsp/growthArchives/archive12.jsp">我的幼儿园</a>
			<a href="<%=basePath %>jsp/growthArchives/archive13.jsp">主题教学活动</a>
			<a href="<%=basePath %>jsp/growthArchives/archive14.jsp">宝宝语录</a>
			<a href="<%=basePath %>jsp/growthArchives/archive15.jsp">父母寄语</a>
		</div>
	</div>
	  <a class="tprev" href="<%=basePath %>jsp/growthArchives/archive01.jsp" target="archive_page"></a>
	  <a class="tnext" href="<%=basePath %>jsp/growthArchives/archive03.jsp" target="archive_page"></a>
	</div>
</body>
<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	
	$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
	$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/02.png'>");
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
</script>
</html>