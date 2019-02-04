<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

<title>成长档案09</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<!-- BEGIN GLOBAL MANDATORY STYLES -->

<link href="<%=basePath%>media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath%>media/css/bootstrap-responsive.min.css"
	rel="stylesheet" type="text/css" />

<link href="<%=basePath%>media/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />

<link href="<%=basePath%>media/css/style-metro.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath%>media/css/style.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath%>media/css/style-responsive.css"
	rel="stylesheet" type="text/css" />

<!-- <link href="<%=basePath%>media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/> -->

<link href="<%=basePath%>media/css/uniform.default.css" rel="stylesheet"
	type="text/css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link href="<%=basePath%>media/css/pricing-tables.css" rel="stylesheet"
	type="text/css" />

<!-- END PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>media/css/select2_metro.css" />
<link rel="stylesheet"
	href="<%=basePath%>media/js_m/datetimepicker/jquery.datetimepicker.css" />

<!-- END PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>media/css/bootstrap-fileupload.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>media/Template/archive_public.css" />
<link href="" rel="stylesheet" type="text/css" media="screen"
	id="cssLink" />
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body  class="overflow-y-hidden">
      <div class="template_bg">

		<div class="container-fluid">


			<div class="row-fluid">
				<div class="archive_bg">
					<div class="archive_Actions actions9">
						<input type="hidden" id="page"> <input type="hidden"
							id="contentId"> <img onclick="save()"
							src="<%=basePath%>media/Template/Save_btn.png"
							style="cursor: pointer;"> <img onclick="newPage()"
							src="<%=basePath%>media/Template/add_btn.png"
							style="cursor: pointer;"> <img onclick="deleteContent()"
							src="<%=basePath%>media/Template/delect_btn.png"
							style="cursor: pointer;">
					</div>
					<a href="#static2" data-toggle="modal"><i
						class="add_info archive09_add_01"></i></a> <a href="#static1"
						data-toggle="modal"><i class="add_info archive09_add_02"></i></a>
					<img src="" class="archive09_img_01"> <img src=""
						class="archive09_img_02">
					<div class="list_page archive09page">
						<a href="javascript:goFirst()"><img
							src="<%=basePath%>media/Template/first.png"></a> <a
							href="javascript:goPre()"><img
							src="<%=basePath%>media/Template/pre.png"></a> <a
							href="javascript:goAfter()"><img
							src="<%=basePath%>media/Template/next.png"></a> <a
							href="javascript:goLast()"><img
							src="<%=basePath%>media/Template/end.png"></a>
					</div>
				</div>
			</div>
			<a class="tprev"
				href="<%=basePath %>jsp/growthArchives/archive08.jsp"
				target="archive_page"></a> <a class="tnext"
				href="<%=basePath %>jsp/growthArchives/archive10.jsp"
				target="archive_page"></a>
			<div data-keyboard="false" data-backdrop="static" tabindex="-1"
				class="modal hide fade" id="static1">
				<div class="modal-header">

					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button"></button>

					<h3>上传照片</h3>

				</div>
				<div class="modal-body">

					<div class="row-fluid">
						<div class="span12">

							<div class="tabbable tabbable-custom">

								<ul class="nav nav-tabs">

									<li class="active"><a data-toggle="tab" href="#tab_2_1">从本地上传</a></li>

									<li><a data-toggle="tab" href="#tab_2_2">从相册选择</a></li>

								</ul>

								<div class="tab-content">

									<div id="tab_2_1" class="tab-pane active">
										<form action="#" class="form-horizontal">

											<div class="fileupload fileupload-new"
												data-provides="fileupload" style="text-align: center;">

												<div class="fileupload-new thumbnail"
													style="width: 200px; height: 150px;">

													<img src="media/image/AAAAAA&amp;text=no+image" alt="" />

												</div>

												<div class="fileupload-preview fileupload-exists thumbnail"
													style="max-width: 450px; max-height: 300px; line-height: 20px;"
													id="priview1"></div>

												<div>

													<span class="btn btn-file"><span
														class="fileupload-new">选择图片</span> <span
														class="fileupload-exists">修改图片</span> <input type="file"
														class="default" id="imgFile1" name="file" /></span> <a href="#"
														class="btn fileupload-exists" data-dismiss="fileupload">删除图片</a>

												</div>

											</div>

										</form>

										<div class="modal-footer">
											<button class="btn green" type="button" onclick="saveImg(1)">提交</button>
											<input type="hidden" id="userDetailId" value="">
										</div>
									</div>
									<div id="tab_2_2" class="tab-pane">
										<div class="row-fluid">
											<div class="span12 form-horizontal">
												<div class="control-group">

													<label class="control-label"
														style="width: 80px; text-align: center;">选择相册</label>

													<div class="controls" style="margin-left: 80px;">

														<select name="category" class="span3 m-wrap"
															id="albumSelect1" onchange="getImgList(1)">


														</select>

													</div>

												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span12">
												<ul class="select_img" id="photoList1">
												</ul>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span12" style="text-align: right;">
												<button class="btn" data-dismiss="modal" class="close"
													type="button">取消</button>
											</div>
										</div>
									</div>

								</div>

							</div>
						</div>
					</div>

				</div>


			</div>
			<div data-keyboard="false" data-backdrop="static" tabindex="-1"
				class="modal hide fade" id="static2">
				<div class="modal-header">

					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button"></button>

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
										<form action="#" class="form-horizontal">

											<div class="fileupload fileupload-new"
												data-provides="fileupload" style="text-align: center;">

												<div class="fileupload-new thumbnail"
													style="width: 200px; height: 150px;">

													<img src="media/image/AAAAAA&amp;text=no+image" alt="" />

												</div>

												<div class="fileupload-preview fileupload-exists thumbnail"
													style="max-width: 450px; max-height: 300px; line-height: 20px;"
													id="priview2"></div>

												<div>

													<span class="btn btn-file"><span
														class="fileupload-new">选择图片</span> <span
														class="fileupload-exists">修改图片</span> <input type="file"
														class="default" id="imgFile2" name="file" /></span> <a href="#"
														class="btn fileupload-exists" data-dismiss="fileupload">删除图片</a>

												</div>

											</div>

										</form>

										<div class="modal-footer">
											<button class="btn green" type="button" onclick="saveImg(2)">提交</button>
											<input type="hidden" id="userDetailId" value="">
										</div>
									</div>
									<div id="tab_1_2" class="tab-pane">
										<div class="row-fluid">
											<div class="span12 form-horizontal">
												<div class="control-group">

													<label class="control-label"
														style="width: 80px; text-align: center;">选择相册</label>

													<div class="controls" style="margin-left: 80px;">

														<select name="category" class="span3 m-wrap"
															id="albumSelect2" onchange="getImgList(2)">


														</select>

													</div>

												</div>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span12">
												<ul class="select_img" id="photoList2">
												</ul>
											</div>
										</div>
										<div class="row-fluid">
											<div class="span12" style="text-align: right;">
												<button class="btn" data-dismiss="modal" class="close"
													type="button">取消</button>
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
	</div>
	<script src="<%=basePath%>media/js/jquery-2.1.1.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>media/js/jquery-ui-1.10.1.custom.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>media/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>media/js/ajaxfileupload.js"
		type="text/javascript"></script>
	<!--[if lt IE 9]>
	<script src="<%=basePath%>media/js/excanvas.min.js"></script>
	<script src="<%=basePath%>media/js/respond.min.js"></script>  
	<![endif]-->
	<script type="text/javascript"
		src="<%=basePath%>media/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript">
	var list ;
	var path =window.parent.$("#path").val();
	jQuery(document).ready(function(){
		$("#cssLink").attr("href","<%=basePath%>media/Template/"+ path +"/template.css");
		$(".archive_bg").prepend("<img class='img_model' src='<%=basePath%>media/Template/"+path+"/09.png'>");
		$(".archive09_img_01").attr("src","<%=basePath%>media/Template/"+path+"/add_img.png");
		$(".archive09_img_02").attr("src","<%=basePath%>media/Template/"+path+"/add_img.png")
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
		loadAlbum();
		
	});
	function loadImgs(){
		$.ajax({
			type: "post",
			url: "<%=basePath%>growth/getContentByGrowthIdAndType.do",
			data:{
					type : 0,
					growthId: window.parent.$("#growthId").val()
				},
			success: function(data){
				list = eval("(" + data + ")");
				$("#page").val(1);
				if (list != null){
					$.each(list,function(n,value){
							$("#contentId").val(value.id);
							$(".archive09_img_01").attr("src",value.firstImgPath);
							$(".archive09_img_02").attr("src",value.secondImgPath);
							return false;
					});
				}
				
			},
		});
	}
	function saveImg(index){
	$(".archive09_img_0"+index).attr("src",$("#priview"+index+" > img").attr("src"));
	$("#static"+index).modal("hide");
	}
	function save(){
		var growthId=window.parent.$("#growthId").val();
		$.ajaxFileUpload({
			url : '<%=basePath%>growth/saveContent.do',
			secureuri : false,
			fileElementId :[ 'imgFile1','imgFile2'],
			data:{
				growthId : growthId,
				type : 0,
				contentId : $("#contentId").val(),
				modal : 'happyDay',
				img1Path : $(".archive09_img_01").attr("src"),
				img2Path : $(".archive09_img_02").attr("src")
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
				$(".archive09_img_01").attr("src",value.firstImgPath);
				$(".archive09_img_02").attr("src",value.secondImgPath);
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
					$(".archive09_img_01").attr("src",value.firstImgPath);
					$(".archive09_img_02").attr("src",value.secondImgPath);
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
				$(".archive09_img_01").attr("src",value.firstImgPath);
				$(".archive09_img_02").attr("src",value.secondImgPath);
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
				$(".archive09_img_01").attr("src",value.firstImgPath);
				$(".archive09_img_02").attr("src",value.secondImgPath);
				return false;
			}
			
		});
	}
	function newPage(){
		$("#contentId").val("");
		$(".archive09_img_01").attr("src","<%=basePath%>media/Template/"+path+"/add_img.png");
		$(".archive09_img_02").attr("src","<%=basePath%>media/Template/"+path+"/add_img.png");
		$(".fileupload").reset();
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
				$("#albumSelect1").html(appendHtml);
				$("#albumSelect2").html(appendHtml);
				
			},
		});
	}
	function getImgList(index){
		var albumId = $("#albumSelect"+index).val();
		$.ajax({
			type: "post",
			url: "<%=basePath%>clazzAlbum/loadPhotoDetailByAlbumId.do",
				data : {
					albumId : albumId
				},
				success : function(data) {
					var map = $.parseJSON(data);
					var appendHtml = '';
					$.each(map.photoList,
							function(n, value) {
								appendHtml += '<li>';
								appendHtml += '<img src="' + value.photoPath
										+ '" onclick="setThisImg(' + index
										+ ',this)">';
								appendHtml += '</li>';
							});
					$("#photoList" + index).html(appendHtml);

				},
			});
		}
		function setThisImg(index, obj) {
			$(".archive09_img_0" + index).attr("src", obj.src);
			$("#static" + index).modal("hide");
		}
	</script>

	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-37564768-1' ]);
		_gaq.push([ '_setDomainName', 'keenthemes.com' ]);
		_gaq.push([ '_setAllowLinker', true ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://'
					: 'http://')
					+ 'stats.g.doubleclick.net/dc.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>
</body>

<!-- END BODY -->

</html>