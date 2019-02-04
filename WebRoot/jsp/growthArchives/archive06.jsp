<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<html lang="en">


<head>

	<title>晨检记录</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen"  id="cssLink"/>
	
</head>
<script type="text/javascript">
	var path =window.parent.$("#path").val();
	</script>
<body class="overflow-y-hidden">
<div class="template_bg">
<input type="hidden" value="121" id="studentId"/>
      <div class="archive_bg">
		<div class="archive06_info" id="thisHtml">
		</div>
	</div>
  	  <a class="tprev" href="<%=basePath %>jsp/growthArchives/archive05.jsp" target="archive_page"></a>
	  <a class="tnext" href="<%=basePath %>jsp/growthArchives/archive07.jsp" target="archive_page"></a>
	</div>		
</body>
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	jQuery(document).ready(function(){     
		$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
		$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/06.png'>");
		
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
			url: "<%=basePath%>morningCheck/getDetailInfoByUserId.do",
			data:{
				userId : $("#userId",window.parent.document).val(),
				endDate : $("#endDate",window.parent.document).val()
			},
			success: function(data){
				var getDate = eval("(" + data + ")");
				var html = "";
				for(var i=0;i<getDate.length-1&&i<4;i++){
					html+="<div class='info_list'>"+
							  "<h2>"+getDate[i].createTime.substring(0,10)+"</h2>"+
							  "<p>体温："+getDate[i].temperature+"度</p>"+
							  "<p>精神："+getDate[i].spirit.replace(/@@##@@/g,'、')+"</p>"+
							  "<p>口腔："+getDate[i].oralCavity+"</p>"+
							  "<p>形象："+getDate[i].surface+"</p>"+
						  "</div>";
				}
				if(getDate.length>0){
					html+="<a class='archive05_more' href='<%=basePath %>morningCheck/toMorningCheckList.do' target='mainPage'>查看更多>></a>";
				}
				$("#thisHtml").html(html);
			}
		});
	}
	</script>
</html>