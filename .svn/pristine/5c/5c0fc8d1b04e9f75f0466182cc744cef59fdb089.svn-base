<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>

	<title>成长档案15</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen"  id="cssLink"/>

	
</head>

<body class="overflow-y-hidden">
      <div class="template_bg">
			<div class="archive_bg">
			<div class="archive_Actions actions15">
						<input type="hidden" id="page">
						<input type="hidden" id="contentId">
						<img onclick="save()" src="<%=basePath%>media/Template/Save_btn.png" style="cursor:pointer;">
						<img onclick="newPage()" src="<%=basePath%>media/Template/add_btn.png" style="cursor:pointer;">
						<img onclick="deleteContent()" src="<%=basePath%>media/Template/delect_btn.png" style="cursor:pointer;">
					</div>
				<div class="archive15_info">
					<p contenteditable="true" id="content"></p>
				</div>
			</div>
			<a class="tprev" href="<%=basePath %>jsp/growthArchives/archive14.jsp" target="archive_page"></a>
		</div>
</body>
<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/ajaxfileupload.js" type="text/javascript"></script>
	<script type="text/javascript">
var list ;
var path =window.parent.$("#path").val();
jQuery(document).ready(function(){
	$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
	$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/15.png'>");
	loadImgs();
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
	
});
function loadImgs(){
	$.ajax({
		type: "post",
		url: "<%=basePath%>growth/getContentByGrowthIdAndType.do",
		data:{
				type : 6,
				growthId: window.parent.$("#growthId").val()
			},
		success: function(data){
			list = eval("(" + data + ")");
			$("#page").val(1);
			if (list != null){
				$.each(list,function(n,value){
						$("#contentId").val(value.id);
						$("#content").text(value.content);
						return false;
				});
			}
			
		},
	});
}
function save(){
	var growthId=window.parent.$("#growthId").val();
	$.ajaxFileUpload({
		url : '<%=basePath%>growth/saveContent.do',
		secureuri : false,
		fileElementId :[ ],
		data:{
			growthId : growthId,
			type : 6,
			contentId : $("#contentId").val(),
			content:$("#content").text(),
			modal : 'childrenLanuage'
		},
		dataType : 'json',
		success : function(d, status) {
			var data = eval('(' + d + ')');
			if (data == "0"){
				alert("保存成功！");
			}
		},
		error : function(data, status, e) {
			alert(e);
		}

	}) 
}
function goFirst(){
	$("#page").val(1);
	if (list.length > 0){
		$.each(list,function(n,value){
			$("#contentId").val(value.id);
			$("#content").text(value.contnet);
			return false;
	});
	}

}
function goPre(){
	var page = $("#page").val();
	var pageInt = parseInt(page);
	if (pageInt > 1){
		pageInt = pageInt -1;
		$("#page").val(pageInt);
		$.each(list,function(n,value){
			if (n==pageInt-1){
				$("#contentId").val(value.id);
				$("#content").text(value.contnet);
				return false;
			}
			
		});
	}
}
function goAfter(){
	var page = $("#page").val();
	var pageInt = parseInt(page);
	
	pageInt = pageInt +1;
	$("#page").val(pageInt);
	$.each(list,function(n,value){
		if (n==pageInt-1){
			$("#contentId").val(value.id);
			$("#content").text(value.contnet);
			return false;
		}
		
	});
	
}
function goLast(){
	pageInt = list.length;
	$("#page").val(pageInt);
	$.each(list,function(n,value){
		if (n==pageInt-1){
			$("#contentId").val(value.id);
			$("#content").text(value.contnet);
			return false;
		}
		
	});
}
function newPage(){
	$("#contentId").val("");
	$("#content").text("");
}
function deleteContent(){
	$.ajax({
		type: "post",
		url: "<%=basePath%>growth/deleteContent.do",
		data:{
				contentId : $("#contentId").val()
			},
		success: function(data){
			var data = eval("(" + data + ")");
			if (data=='0'){
				alert("删除成功");
				loadImgs();
			}
		},
	});
}
</script>
</html>