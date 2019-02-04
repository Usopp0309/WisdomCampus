<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<head>

	<title>成长档案03</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />


	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<link href="<%=basePath%>media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath%>media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath%>media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath%>media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath%>media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="<%=basePath%>media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<!-- <link href="<%=basePath%>media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/> -->

	<link href="<%=basePath%>media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<%=basePath%>media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/css/select2_metro.css" />
	<link rel="stylesheet" href="<%=basePath%>media/js_m/datetimepicker/jquery.datetimepicker.css" />
	
	<!-- END PAGE LEVEL STYLES -->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/css/bootstrap-fileupload.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>media/Template/archive_public.css" />
	<link href="" rel="stylesheet" type="text/css" media="screen" id="cssLink"/>
</head>
<script type="text/javascript">
	var path =window.parent.$("#path").val();
	</script>

<body class="overflow-y-hidden">
     
<div class="template_bg">
			<div class="container-fluid">

					<div class="row-fluid archive_bg">
						<div style="position: relative;">
						<a href="#static" data-toggle="modal"><i class="add_info archive03_add_01"></i></a>
						<img src="" class="archive03_img_01">
						<div class="archive03_info">
							<p><b>名称：</b><span id="realName"></span></p>
							<p><b>昵称：</b><span contentEditable=true id="nickName"></span></p>
							<p><b>生日：</b><span contentEditable=true id="birthDay"></span></p>
							<p><b>性别：</b><span contentEditable=true id="sex"></span></p>
							<p><b>生肖：</b><span contentEditable=true id="zoodiac"></span></p>
							<p><b>血型：</b><span contentEditable=true id="bloodType"></span></p>
							<p><b>爱好：</b><span contentEditable=true id="favorite"></span></p>
						</div>
							
						</div>
						
						<div class="archive_Actions actions3">
							<img src="<%=basePath%>media/Template/Save_btn.png"onclick="saveInfo()" style="cursor:pointer;">
						</div>
				</div>
				<div data-keyboard="false" data-backdrop="static" tabindex="-1" class="modal hide fade" id="static">
					<div class="modal-header">

						<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>

						<h3>上传照片</h3>

					</div>
					<div class="modal-body">

						<div class="row-fluid">
							<div class="span12">
										
								<div class="tabbable tabbable-custom">

									<ul class="nav nav-tabs">

										<li class="active"><a data-toggle="tab" href="#tab_1_1">从本地上传</a></li>

										<li><a data-toggle="tab" href="#tab_1_2">从相册选择</a></li>

									</ul>

								<div class="tab-content">

									<div id="tab_1_1" class="tab-pane active">
										<form action="#" class="form-horizontal" >

											<div class="fileupload fileupload-new" data-provides="fileupload" style="text-align:center;">

												<div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

													<img src="media/image/AAAAAA&amp;text=no+image" alt=""  id="priview"/>

												</div>

												<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 450px; max-height: 300px; line-height: 20px;"></div>
	
												<div>

													<span class="btn btn-file"><span class="fileupload-new">选择图片</span>
			
													<span class="fileupload-exists">修改图片</span>
			
													<input type="file" class="default" id="imgFile" name="file"/></span>
			
													<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除图片</a>

												</div>

											</div>

										</form>
										
										<div class="modal-footer">
											<button class="btn green"  type="button" onclick="saveImg()">提交</button>
											<input type="hidden" id="userDetailId" value="">
										</div>
									</div>
									<div id="tab_1_2" class="tab-pane">
										<div class="row-fluid">
											<div class="span12 form-horizontal">
												<div class="control-group">

													<label class="control-label" style="width:80px;text-align: center;">选择相册</label>
			
													<div class="controls" style="margin-left:80px;">
			
														<select name="category" class="span3 m-wrap" id="albumSelect" onchange="getImgList()">
															
															
			
														</select>
			
													</div>
			
												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span12">
												<ul class="select_img" id="photoList">
													
												</ul>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span12" style="text-align: right;">
												<button class="btn" data-dismiss="modal" class="close" type="button">取消</button>
											</div>
										</div>
									</div>

								</div>

							</div>
						</div>
					</div>
										
										
										
										
										
										
										
										
									</div>
								
									
								
								
								</div>
								</div>
	  <a class="tprev" href="<%=basePath %>jsp/growthArchives/archive01.jsp" target="archive_page"></a>
	  <a class="tnext" href="<%=basePath %>jsp/growthArchives/archive04.jsp" target="archive_page"></a>
								</div>
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="<%=basePath%>media/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>media/js/ajaxfileupload.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
	<script src="<%=basePath%>media/js/excanvas.min.js"></script>
	<script src="<%=basePath%>media/js/respond.min.js"></script>  
	<![endif]-->                    
<script type="text/javascript" src="<%=basePath%>media/js/bootstrap-fileupload.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){     
	$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
	$(".archive03_img_01").before("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/03.png'>");
	$(".archive03_img_01").attr("src","<%=basePath%>media/Template/"+path+"/add_img.png")
	loadInfo();
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
	loadAlbum();
	
});
function loadAlbum(){
	var roleCode = window.parent.getRoleCode();
	
	$.ajax({
		type: "post",
		url: "<%=basePath%>clazzAlbum/getAlbum4Growth.do",
		data:{
			studentId : window.parent.$("#userId").val()
			},
		success: function(data){
			var data = eval("(" + data + ")");
			var appendHtml = '<option value="">请选择...</option>';
			$.each(data,function(n,value){
				appendHtml += '<option value="'+value.albumId + '">' + value.albumName + '</option>';
			});
			$("#albumSelect").html(appendHtml);
			
		},
	});
}
function loadInfo(){
	$.ajax({
		type: "post",
		url: "<%=basePath%>growth/getInfo.do",
		data:{
				userId : window.parent.$("#userId").val(),
				growthId: window.parent.$("#growthId").val()
			},
		success: function(data){
			var data = eval("(" + data + ")");
			$("#realName").text(window.parent.$("#realName").val());
			if (data != null){
				$("#nickName").text(data.nickName);
				$("#birthDay").text(data.birthday);
				if (data.sex == 0){
					$("#sex").text("男");
				}else{
					$("#sex").text("女");
				}
				$("#zoodiac").text(data.zoodiac);
				$("#bloodType").text(data.bloodType);
				$("#favorite").text(data.favorite);
				$("#userDetailId").val(data.id);
				$(".archive03_img_01").attr("src",data.imgPath);
			}
			
		},
	});
}

function saveInfo(){
	var growthId=window.parent.$("#growthId").val();
	var userId=window.parent.$("#userId").val();
	var zoodiac = $("#zoodiac").text();
	var bloodType = $("#bloodType").text();
	var favorite = $("#favorite").text();
	var nickName = $("#nickName").text();
	var birthDay = $("#birthDay").text();
	var imgPath = $(".archive03_img_01").attr("src");
	var sex = $("#sex").text();
	if (sex.indexOf("男") != -1){
		sex = 0;
	}else{
		sex = 1;
	}
	$.ajaxFileUpload({
		url : '<%=basePath%>growth/saveDetailInfo.do',
		secureuri : false,
		fileElementId :[ 'imgFile'],
		data:{
			detailId : $("#userDetailId").val(),
			userId : userId,
			zoodiac : zoodiac,
			bloodType : bloodType,
			favorite : favorite,
			nickName : nickName,
			birthDay : birthDay,
			sex : sex,
			imgPath : imgPath
			
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
function saveImg(){
	
	$(".archive03_img_01").attr("src",$(".fileupload-preview > img").attr("src"));
	$("#static").modal("hide");
}
function getImgList(){
	var albumId = $("#albumSelect").val();
	$.ajax({
		type: "post",
		url: "<%=basePath%>clazzAlbum/loadPhotoDetailByAlbumId.do",
		data:{
			albumId : albumId
			},
		success: function(data){
			var map = $.parseJSON(data);
			var appendHtml = '';
			$.each(map.photoList, function(n, value) {
				appendHtml += '<li>';
				appendHtml += '<img src="'+value.photoPath +'" onclick="setThisImg(this)">';
				appendHtml += '</li>';
   			}); 
			$("#photoList").html(appendHtml);
			
		},
	});
}
function setThisImg(obj){
	$(".archive03_img_01").attr("src",obj.src);
	$("#static").modal("hide");
}
</script>
<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script>
</body>
</html>