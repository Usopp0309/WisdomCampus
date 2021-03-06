<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
	<title>相册列表</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
<%-- 	<link href="<%=basePath %>assets/global/plugins/album/styles/bootstrap.min.css" rel="stylesheet" type="text/css"/> --%>
	<link href="<%=basePath %>assets/global/plugins/album/styles/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
<%-- 	<link href="<%=basePath %>assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/> --%>
	<link href="<%=basePath %>assets/pages/scripts/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/style.css" rel="stylesheet" type="text/css"/>
	
	<link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="<%=basePath %>assets/global/plugins/album/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/album/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/global/plugins/font-awesome/css/font-awesome.css" rel="stylesheet"  type="text/css"/>
	<link href="<%=basePath%>assets/global/plugins/album/styles/photo_Slideshow.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/global/css/system_m.css" rel="stylesheet" type="text/css" media="screen"/>
<%@ include file="/public_module/public_css_new.jsp"%>
	<link href="<%=basePath %>assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>assets/global/plugins/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>assets/global/plugins/album/styles/albunm.css" rel="stylesheet" type="text/css" />
    
    
    
    <style>
        .page-container{
            background:#34495e;
        }
        .page-content{
            margin-left:185px;
            padding:0 35px;
        }
        .container-fluid{
            padding:0;
        }
        .first_Response{
            margin-left:150px;
        }
        .button_first{
            background-color: #f5f5f5;
		    color: #6F6C6C;
		    padding: 7px 14px;
		    margin: 0 0 0 15px;
        }
        .photo_message,.photo_end{
            color: #666;
		    float: left;
		    font-size: 14px;
		    margin: 15px auto;
		    padding: 7px 0;
		    text-align: center;
		    width: 100%;
		    cursor: pointer;
        }
        .page-footer{
            background-color:#f2f2f2 !important;
        }
        .breadcrumb{
            padding: 8px 15px;
		    margin: 0 0 20px;
		    list-style: none;
		    background-color: #f5f5f5;
        }
        .addmenuUl{
			border:none !important;
			margin:0 !important;
		}
		.addmenuUl > li > a{
			border-left:none !important;
		    border-bottom:none !important;
		    border-right:none !important;
		}
		.addmenuUl > li.active {
		    margin-top: 0px;
		    position: relative;
		    border-top: 3px solid rgb(209, 38, 16) !important;
		}
		.tabbable-custom.boxless > .tab-content{
		    padding:0;
		    border-top:none;
		}
		.navbar .nav>li>a{
		    text-shadow:0 0 0 #000 !important;
		}
        @media (max-width: 991px){
	        .page-content{
	            margin-left:0 !important;
	        }
        }
	</style>

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
	<input class="themes" type="hidden" value="<%=ThemePath%>">
    <!-- 公共顶部开始-->
    <%@ include file="/public_module/public_header.jsp"%>    
    <!--公共顶部结束-->
    <div class="clearfix"> </div>
    <!-- 内容页开始 -->
	<div class="page-container">
	        <!--主菜单开始-->
	        <%@include file="/public_module/public_menu.jsp"%>
	        <!--主菜单结束-->
		<div class="container-fluid">
	        <div class="page-content m_overflow_hidden m_page_content">
			<!-- BEGIN PAGE HEADER-->
	    
			<div class="row-fluid">
	
				<div class="span12">
	
					<ul class="breadcrumb">
						<li><i class="icon-home"></i><a href="#">首页</a><i class="icon-angle-right"></i></li>
						<li><a href="#">相册</a><i class="icon-angle-right"></i><a href="">相册详情</a></li>
					</ul>
	
				</div>
	
			</div>
	
			<div class="row-fluid">
	
				<div class="span12">
					
					<div class="tabbable tabbable-custom boxless">
						<!-- 动态加载tab页 -->
						<ul class="nav nav-tabs addmenuUl" id="userTab">
							<c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<li class="roleLi" id="${roleList.roleCode}">
										<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
										</a>
									</li>
									
							</c:forEach>																						
	<%-- 						<input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}"/>	 --%>
	<%-- 						<input type="hidden" name="schoolId" id="schoolId" value="${sessionScope.user.schoolId}"/>	 --%>
						</ul>
					
						<div class="tab-content padding_0">
							
							<div class="tab-pane active" id="tab_4">
	
								<div class="portlet box green">
	
									<!-- 页面搜索开始 -->
			                        <div class="portlet light form-fit bordered search_box">
			                        <div class="portlet-title addmenu-title">
			                                <div class="caption">班级相册</div>
			                        </div>
			                       	<form action="#" class="form-horizontal">
			                         <div class="row m_margin_10_auto">
			
			                         	<div class="col-md-5 col-sm-5 col-lg-4 m_margin_top-15">
			                         		<span class="m_span">选择年级：</span>
			                         		<select class="form-control m_select" id="gradeList">
											</select>
			                         	</div>
			                         	<div class="col-md-5 col-sm-5 col-lg-4 m_margin_top-15">
			                         		<span class="m_span">选择班级：</span>
			                         		<select class="form-control m_select" id="clazzList">
		                                        <option>选择班级</option>
		                                    </select>
			                         	</div>
			                   <!--      	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
			                         		  <button type="submit" class="btn green">搜索</button>
			                         	</div>
			                     --> 
			                     <button type="button" class="btn blue f_right m_margin_top-15" id="search" style="position: relative;right:480px;top:9px;height:31px;"><i class="icon-search"></i>查找</button>
			                         </div>
			                         </form>
			                        </div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
	
			</div>
			
			
			
			<div class="row-fluid photo">
				<div class="tabbable tabbable-custom">
					<ul class="nav nav-tabs">
		
						<li onclick="toAlbnum()" style="cursor: pointer;">相册</li>
		
						<li class="active Back">照片</li>
		
					</ul>
				</div>
<!-- 				qweqew -->
				<div class="span12" style="margin:20px 0 0;background-color:#f4f4f4">
				
	<!-- 				<span style="position:absolute;top:280px;" id="albumPhotoOne"> -->
	<!-- 					<a href="#static" data-toggle="modal" class=" btn blue" onclick="getid(1,450)" style="padding: 5px 20px 5px 10px;font-size:11pt;">上传照片</a> -->
	<!-- 					<a href="#static" data-toggle="modal" class=" btn" onclick="getid(2,150)" style="padding: 5px 20px 5px 10px;font-size:11pt;">创建相册</a> -->
	<!-- 				</span>		 -->
					
					<ul class="photo_list_detail" id="ul">
					</ul>
					<input id="nextPage" type="text" value="" style="display:none;" />
				</div>		
			</div>
		</div>			
			</div>
		</div>
		
		
	<div class="modal fade bs-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
	     <div class="modal-dialog modal-lg" style="width: 1000px;">
	<!--  <div class="modal fade1" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" > -->
          	<div class="modal-content">
					<div class="modal-header" >
					 
					<span class="albumName"></span>
						<i style="position: absolute; top: 10px; right: 10px; display: block; color: #ccc; font-size: 16px; cursor: pointer;"
							data-dismiss="modal" class="icon-remove"></i>
					</div>
					<div class="modal-body" style="max-height: 600px !important;">
						<div class="row"  style="height:500px;">
							<div class="col-md-12 col-sm-12">
								<div class="photo_show">
									<span id="prev" class="btn prev" style="display: none"></span>
									<span id="next" class="btn next" style="display: none"></span>
									<span id="prevTop" class="btn prev fa fa-angle-left"></span>
									<span id="nextTop" class="btn next fa fa-angle-right"></span>
								<div id="picBox" class="picBox">
									<ul class="cf">
									</ul>
								</div>
		
								<div id="listBox" class="listBox">
									<ul class="cf">
									</ul>
								</div>
		
								</div>
								<div class="v_show_info">
									<div class="photo_detail_header1">
										<img src="">
										<div class="photo_detail_info1" style="font-size:12px;">
											<p>
												<b>《</b><b class="albumName"></b><b>》</b>相册描述
											</p>
											<p>
												<b class="createUserName"></b>于<b class="createTime"></b>创建
											</p>
										</div>
									</div>
									<textarea class="m_textarea" rows="" cols="" id="photoTextarea"></textarea>
									<button class="photo_button_first">发表</button>
									<div class="show_bbs"></div>
								</div>
							</div>
						</div>
					</div>
<!-- 					<div class="modal-footer"> -->
<!-- 						<button type="button" id="upload" class="btn green">确定</button> -->
<!-- 						<button type="button" data-dismiss="modal" class="btn">关闭</button>                             -->
<!-- 					</div> -->
				</div>
      </div>
	</div>

	
	
	<!-- 		</div> -->
<!-- 	</div> -->
	<input type="hidden" name="gradeId" id="gradeId" value="${gradeId}">
	<input type="hidden" name="clazzId" id="clazzId" value="${clazzId}">
	<input type="hidden" name="roleCode" id="roleCode" value="${roleCode}">
	<!-- 底部开始 -->
	    <%@ include file="/public_module/public_footer.jsp" %>
	    <!-- 底部结束 -->
</body>
<!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->	
<%-- 	<script src="<%=basePath %>assets/global/plugins/fancybox/lib/jquery-1.10.1.min.js" type="text/javascript"></script> --%>
<%-- 	<script src="<%=basePath %>assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>  --%>
<%-- 	<script src="<%=basePath %>assets/global/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script> --%>
<%-- 	<script src="<%=basePath %>assets/global/plugins/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>  --%>
<%-- 	<script src="<%=basePath %>assets/global/plugins/album/scripts/bootstrap.min.js" type="text/javascript"></script> --%>
<%-- 	<script type="text/javascript" src="<%=basePath %>assets/global/plugins/datetimepicker/jquery.datetimepicker.js"></script> --%>
	<!--[if lt IE 9]>
	<script src="<%=basePath %>media/js/excanvas.min.js"></script>
	<script src="<%=basePath %>media/js/respond.min.js"></script>  
	<![endif]-->   
<%-- 	<script src="<%=basePath %>assets/global/plugins/album/js/layer/layer.js" type="text/javascript"></script> --%>
	
<%-- 	<script src="<%=basePath %>assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script> --%>
<%-- 	<script src="<%=basePath %>assets/global/plugins/jquery.cookie.min.js" type="text/javascript"></script> --%>
	<script src="<%=basePath %>assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script>
	<script src="<%=basePath %>assets/global/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/tmpl.min.js" type="text/javascript"></script>
	
	<script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/load-image.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/canvas-to-blob.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.iframe-transport.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload.js" type="text/javascript"></script>
	
	<script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-ui.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/pages/scripts/form-fileupload.js" type="text/javascript"></script>
	
<%-- 	<script src="<%=basePath%>assets/global/plugins/public_js.js" type="text/javascript"></script> --%>
<%-- 	<script src="<%=basePath %>assets/global/scripts/app.js" type="text/javascript"></script> --%>
<%-- 	<script src="<%=basePath%>assets/global/plugins/album/scripts/ajaxfileupload.js" type="text/javascript"></script> --%>
	
	<script src="<%=basePath%>assets/global/plugins/public_js.js" type="text/javascript"></script>
	<script>

		

		var oNav = document.querySelectorAll('.nav-item'); 
		for (var i=0;i<oNav.length;i++ )
		{
			oNav[i].ifCheck = false;                        
			oNav[i].nowClass = oNav[i].className;            
			oNav[i].onclick = function(){
			    for(var j=0;j<oNav.length;j++){
			    	oNav[j].children[1].style.display = "none";
			    	oNav[j].className = "nav-item";
				};
		         if(this.ifCheck){                         
		            this.className = this.nowClass;
		            $(this).find('.sub-menu').slideUp("slow");         
			    }else{
		            this.className += ' open';
		            $(this).find('.sub-menu').slideDown("slow");                 
		            }                                      
		        this.ifCheck = !this.ifCheck;              
		    };
		};

		
// 	   $('.icon-remove').click(function(){
// 	        $(this).parent().parent().parent().hide();
// 	       });
		$(function(){
			 loadSubMenu("clazzPhotoAlbumManager");
			 setActive("clazzPhotoAlbumManager","clazzPhotoAlbum");
			$('#startTime').datetimepicker({
				 lang:"ch",
				 format:"Y-m-d H:i:s" 
			});
// 			App.init();
			//选择第一个tab
			$("#userTab li:first").addClass("active");
			//选择传输过来的roleCode
			var roleCode_trans = $("#roleCode").val();
			$("#"+roleCode_trans).addClass("active")
			
			FormFileUpload.init();
		
			//切换角色
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadGrade(userId,roleCode);
				var clazzId = $("#clazzList").val();
			    getUploadRecordsList(clazzId,null);
			});
			
			//年级改变对应的班级也会改变
		    $("#gradeList").change(function(){
		    	var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				var gradeId = $("#gradeList").val();
				$("#ul").html("");
				loadClazzByGradeId(userId,roleCode,gradeId);
			});

		  	//年级改变对应的班级也会改变
		    $("#clazzList").change(function(){
		    	$("#ul").html("");
				var clazzId = $("#clazzList").val();
				getUploadRecordsList(clazzId,null);
			});

			var userId = $("#userTab li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			if(userId !=null && userId !='' && roleCode !=null && roleCode !=''){
				loadGrade(userId,roleCode);
			}
			
			

		    var clazzId = $("#clazzList").val();
		    (clazzId,null);
		  

			$(".b_true2").on("click",function(){
				$(".add_photo").eq("0").show();
				$(".add_photo").eq("1").hide();
			})
			$(".photo_list li").on("click",function(){
				$(".photo_list").hide();
				$(".photo_detail").show();
			})
			$(".photo_detail_info i").on("click",function(){
				$(".describe").show(500);
			})
			$(".describe").mouseleave(function(){
				$(this).hide(500);
			})
			$(".photo_detail li").hover(function(){
				$(this).find(".Actions").show();
			},function(){
				$(this).find(".Actions").hide();
			})
			
			/* $(".next a").click(function() {
				nextscroll()
			}); */
// 			$(".m_zan").on("click",function(){
// 				var v_var=parseInt($(this).text())+1;
// 				$(this).text(v_var);
// 			})
			$(".m_bbs").on("click",function(){
				$(".m_textarea").focus(); 
			});
			$(".photo_message").live("click",function(){
				$(".photo_message").remove();
			   	var clazzId = $("#clazzList").val();
				var currentPage = parseInt($("#nextPage").val())+1;
				getUploadRecordsList(clazzId,currentPage);
			});
			
			$(".photo_button_first").on("click",function(){
				var _textarea = $(this).prev();
				var photoId = $("#listBox .cf").find(".on").attr("id");						
				var commentReplyId = 0;
				var parentId = 0;
				var textareaText = _textarea.val();
				addPhotoComment(commentReplyId,parentId,photoId,textareaText);
				_textarea.val("");
			});

		})
		
		
		function getid(num,height,recordsId,photoId){
//       	$(".modal_page,.m_modal_body,#static,modal-body").removeAttr("style");
			$(".page"+num).css({"top":'-100px'});
			$(".page"+num).css({"width":'1000px'});
			$(".page"+num).css({"padding":'0'});
			$(".photoUl").remove();
			$(".photoLike").remove();  
			if(num == 3){
				$('#myModal').modal('show');
			}
			App.blockUI(body); 
		$.ajax({
			type: "post",
			url: "<%=basePath%>clazzPhoto/getPhotoListDetailByRecordsId.do",
			data:{
					recordsId : recordsId
				},
			success: function(data){
				
				var map = eval("(" + data + ")");
				if(map.photoList != null){
					if(map.photoList.length > 0){
						var appendHtml = '';
						var appendHtml1 = '';
						var appendHtml_praise = '';
						var appendHtml_comment = '';
						var appendHtml_ul = '';

						if(map.album.headImg=="" || map.album.headImg=="head/avatar_default.png" || map.album.headImg==undefined)
						{
							$(".photo_detail_header").find('img').attr('src','<%=basePath%>assets/global/img/m_img/head_photo.png');
						}else
						{
							$(".photo_detail_header").find('img').attr('src','<%=Cons.HEADIMGBASEPATH%>'+map.album.headImg);
						}
						$(".albumName").text(map.album.albumName);
						$(".createUserName").text(map.album.createUserName);
						$(".createTime").text(map.album.createTime);
						
						$.each(map.photoList, function(n, photo) {
							var photoId_tmp = photo.photoId;
							var commentList = photo.commentList;
							var commentMap = photo.commentMap;
							var commentSubMap = photo.commentSubMap;
							var praiseList = photo.praiseList;
							
							appendHtml += '<li id="photo'+photo.photoId+'"><img src="'+photo.photoPath+'"/><span>'+photo.photoName+'</span></li>';
							if(n == 0){
								appendHtml1 += '<li class="arr2" id="'+photo.photoId+'"><img src="'+photo.photoPath+'"/></li>';
							}else{
								appendHtml1 += '<li class="arr2" id="'+photo.photoId+'"><img src="'+photo.photoPath+'"/></li>';
							}
							if(n == 0){
								appendHtml_comment += '<dl id="photod'+photo.photoId+'" style="display:block" class="'+photo.photoId+'">';
							}else{
								appendHtml_comment += '<dl id="photod'+photo.photoId+'" class="'+photo.photoId+'">';
							}
								$.each(commentList, function(cn, comment) {
									appendHtml_comment += '<dd class="photodd">';
										if(comment.headImg=="" || comment.headImg=="head/avatar_default.png" || comment.headImg==undefined)
										{
											appendHtml_comment += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
										}else
										{
											appendHtml_comment += '<img src="<%=Cons.HEADIMGBASEPATH%>'+comment.headImg +'">';
										}
										appendHtml_comment += '<div class="bbs_info">';
											appendHtml_comment += '<p><span><a href="javascript:;">'+comment.commentUserName+'</a></span><span>:</span>'+comment.content+'</p>';
											appendHtml_comment += '<p id="photop'+comment.commentId+'"><span>'+comment.createTime+'</span><i attr1='+comment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i></p>';
												var commentSubList = commentSubMap[comment.commentId];
												if(commentSubList != null){
													$.each(commentSubList, function(cn, subComment) {
														appendHtml_comment += '<div class="bbs_list" id="subPhotoComment'+subComment.commentId+'">';
															if(subComment.headImg=="" || subComment.headImg=="head/avatar_default.png" || subComment.headImg==undefined)
															{
																appendHtml_comment += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
															}else
															{
																appendHtml_comment += '<img src="<%=Cons.HEADIMGBASEPATH%>'+subComment.headImg +'">';
															}
															appendHtml_comment += '<div class="Response_info">';
															appendHtml_comment += '<p><span><a href="javascript:;">'+subComment.commentUserName+'</a>回复<a href="javascript:;">'+subComment.commentReplyUserName+'</a>:</span>'+subComment.content+'</p>';
																appendHtml_comment += '<p><span>'+subComment.createTime+'</span><i attr1='+subComment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i></p>';
																appendHtml_comment += '</div>';
															appendHtml_comment += '</div>';
														});
												}
										appendHtml_comment += '</div>';
									appendHtml_comment += '</dd>';
								});
							appendHtml_comment += '</dl>'

							if(n == 0){
								appendHtml_praise += '<div class="Like photoLike" id="photoPraiseTotal'+photo.photoId+'"><i class="icon-thumbs-up"></i>';
							}else{
								appendHtml_praise += '<div class="Like photoLike" style="display:none" id="photoPraiseTotal'+photo.photoId+'"><i class="icon-thumbs-up"></i>';
							}
								$.each(praiseList, function(pn, praise) {
									appendHtml_praise += '<span id="photoPraise'+praise.commentId+'">'+praise.commentUserName+'</span>';
								});
							appendHtml_praise += '</div>';
							
							if(n == 0){
								appendHtml_ul += '<ul class="photoUl" id="ul'+photo.photoId+'">';
							}else{
								appendHtml_ul += '<ul class="photoUl" style="display:none" id="ul'+photo.photoId+'">';
							}
							if(praiseList != null){
								appendHtml_ul += '<li style="cursor: pointer;" class="m_zan icon-thumbs-up" onclick= "addPhotoPraise('+photo.photoId+')"><a href="javascript:;">赞</a>(<span id="photoPraiseCount'+photo.photoId+'">'+praiseList.length+'</span>)</li>';
							}else{
								appendHtml_ul += '<li style="cursor: pointer;" class="m_zan icon-thumbs-up" onclick= "addPhotoPraise('+photo.photoId+')"><a href="javascript:;">赞</a>(<span id="photoPraiseCount'+photo.photoId+'">0</span>)</li>';
							}
							if(commentList != null){
								
								appendHtml_ul += '<li style="cursor: pointer;" class="m_bbs icon-comment" onclick="textareaFocus(\'photoTextarea\')"><a href="javascript:;">评论</a>(<span id="photoCommentCount'+photo.photoId+'">'+commentList.length+'</span>)</li>';
							}else{
								appendHtml_ul += '<li style="cursor: pointer;" class="m_bbs icon-comment" onclick="textareaFocus(\'photoTextarea\')"><a href="javascript:;">评论</a>(<span id="photoCommentCount'+photo.photoId+'">0</span>)</li>';
							}
								appendHtml_ul += '<a href="'+photo.photoPath+'?attname='+photo.photoName+'.jpg"><li class="icon-download-alt">下载</li><a>';
							appendHtml_ul += '</ul>';
								
						});
						$(".picBox .cf").html(appendHtml);
						$(".listBox .cf").html(appendHtml1);
						$(".show_bbs").html(appendHtml_comment);
						$("#photoTextarea").before(appendHtml_ul);
						$(".show_bbs").before(appendHtml_praise);
						$("#listBox").find("#"+photoId+"").addClass("on");

						loadSinglePhoto($("#photo"+photoId).index());
						
						//加载点击事件
						$(".photodd .icon-comment").on("click",function(){
							var  photoId = $(this).parents("dl").attr("id").replace("photod", "");
							var commentReplyId = $(this).attr("attr1");
							var parentId = $(this).attr("attr2");
							debugger;
							var text ='';
							if($("#photoText"+commentReplyId).length>0){
								 
							}else{
								text="<textarea id='photoText"+commentReplyId+"' class='photo_add_textarea' placeholder='我也来评论下。。。'></textarea><button class='photo_button_second' attr1 ='"+commentReplyId+"' attr2='"+parentId+"' attr3='"+photoId+"' onclick='addPhotoComment("+commentReplyId+","+parentId+","+photoId+","+null+")'>发表</button>";
							}
							$(".photo_add_textarea").remove();
							$(".photo_button_second").remove();
							$(this).parent().parent().append(text);
						})
						
					}else{
						$(".picBox .cf").html("");
						$(".listBox .cf").html("");
						$(".show_bbs").html(""); 
					}
				}else{
					$(".picBox .cf").html("");
					$(".listBox .cf").html("");
					$(".show_bbs").html("");
				}
				$("#ul").parent().css({"display":"block"});
			}
		});
		/*num：page,height：弹窗高,id*/
		
		App.unblockUI(body);
		$(".page"+num+"").show();
		$(".page"+num+"").siblings().hide();
		letDivCenter("#static");
		if(num == 3){
// 			$("#myModal").attr("style","padding-right:600px;")
		}
		
	}
		


	function loadSinglePhotoDetail(photoId) {
		$(".show_bbs dl").removeAttr("style");	
		$(".show_bbs").find("."+photoId+"").show();
		//点赞人数
		$(".photoLike").hide();
		$("#photoPraiseTotal"+photoId).show();

		$(".photoUl").hide();
		$("#ul"+photoId).show();
	}


	
	//进入照片页面3333333
	function toAlbnum()
	{
		var gradeId = $("#gradeList").val();
		var clazzId = $("#clazzList").val();
		var roleCode = $("ul li.active").find('a').attr("attr2");
		standardPost('<%=basePath%>clazzAlbum/toAlbnum.do',{gradeId:gradeId,clazzId:clazzId,roleCode:roleCode});
	}
	
	//根据userId roleCode 加载年级
	function loadGrade(userId,roleCode)
	{
		var gradeId = null;
			$.ajax({
				type: "post",
				async : false,
				url: "<%=basePath%>clazzAlbum/loadGrade.do",
				data:{
						userId : userId,
						roleCode : roleCode
					},
				success: function(data){

					var gradeList = eval("(" + data + ")");
					
					var appendHtml = '';
					$.each(gradeList, function(n, value) {
						if (n == 0)
						{
							gradeId = value.id;
							appendHtml += '<option selected="selected" value="' + value.id + '">' + value.name + '</option>';
						}else{
							appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
						}
						
	       			});  
					 
	       			$("#gradeList").html(appendHtml);
	       			var gId = $("#gradeId").val();
	      			if (gId != "")
					{
	      				gradeId = gId;
						$("#gradeList").val(gId);
					}
				},
			});

			loadClazzByGradeId(userId,roleCode,gradeId);
	}


	//根据userId roleCode gradeId加载年级
	function loadClazzByGradeId(userId,roleCode,gradeId)
	{
		$.ajax({
				type: "post",
				async : false,
				url: "<%=basePath%>clazzAlbum/loadClazzByGradeId.do",
				data:{
						userId : userId,
						roleCode : roleCode,
						gradeId : gradeId
					},
				success: function(data){

					var clazzList = eval("(" + data + ")");
					
					var appendHtml = '';
					$.each(clazzList, function(n, value) {
						if (n == 0){
							appendHtml += '<option selected="selected" value="' + value.id + '">' + value.clazzName + '</option>';
						}else{
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}
						
	       			});  
					 
	       			$("#clazzList").html(appendHtml);
	       			var clazzId = $("#clazzId").val();
	      			if (clazzId != "")
					{
						$("#clazzList").val(clazzId);
						$("#clazzId").val("");
					}
	       			$("#clazzList").change();
				},
			});
	}

	//获取上传记录
	function getUploadRecordsList(clazzId,cPage){

		var body = $("#body");
		App.blockUI(body); 
		//这里是加载那些人能看到删除按钮
		var userId = $("#userTab li.active").find('a').attr("attr1");
		var roleCode = $("#userTab li.active").find('a').attr("attr2");
		$.ajax({
			type: "post",
			url: "<%=basePath%>clazzPhoto/getUploadRecords.do",
			data:{
					clazzId : clazzId,
					cPage : cPage
				},
			success: function(data){
				var pages = eval("(" + data + ")");
				var currentPage = pages.currentPage;
				$("#nextPage").val(currentPage);
				if(pages.list != null){
					
					if(pages.list.length > 0){
						var appendHtml = '';
						$.each(pages.list, function(n, value) {
							var photoList = value.photoList;
							var commentList = value.commentList;
							var commentMap = value.commentMap;
							var commentSubMap = value.commentSubMap;
							var praiseList = value.praiseList;
							appendHtml += '<li id="li'+value.recordsId+'">';
								appendHtml += '<em>'+value.createTime+'</em>';
								appendHtml += '<div class="photo_list_detail_info">';
									appendHtml += '<div class="photo_list_detail_info_header">';
										if(value.headImg=="" || value.headImg=="head/avatar_default.png" || value.headImg==undefined)
										{
											appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
										}else
										{
											appendHtml += '<img src="<%=Cons.HEADIMGBASEPATH%>'+value.headImg +'">';
										}
										
										appendHtml += '<p><b style="margin:0px;">'+value.uploadUserName+'</b></p>';
										appendHtml += '<p>上传<b>'+photoList.length+'</b>张照片到<b>'+value.albumName+'</b></p>';
									appendHtml += '</div>';
									appendHtml += '<div class="photo_list_detail_info_con">';
										appendHtml += '<div class="img">';
												$.each(photoList, function(pn, photo) {
													if(pn < 10){
														appendHtml += '<a  onclick="getid(3,500,'+value.recordsId+','+photo.photoId+')">';
														appendHtml += '<img src="'+photo.photoPath+'">';
														appendHtml += '</a>';
													}
												});
											
										appendHtml += '</div>';
										if(praiseList != null && commentList != null){
											if(userId == value.uploadUserId){
												appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">'+praiseList.length+'</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">'+commentList.length+'</span>)</span><span onclick= "deleteUploadRecords('+value.recordsId+')"><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
											}else{
												if(roleCode == 'admin' || roleCode == 'chairman' || roleCode == 'president' || roleCode == 'classLeader'){
													appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')" ><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">'+praiseList.length+'</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">'+commentList.length+'</span>)</span><span  onclick= "deleteUploadRecords('+value.recordsId+')"><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
												}else{
													appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')" ><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">'+praiseList.length+'</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">'+commentList.length+'</span>)</span></p>';
												}
											}
										}else if(praiseList != null && commentList == null){
											if(userId == value.uploadUserId){
												appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')" ><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">'+praiseList.length+'</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">0</span>)</span><span onclick= "deleteUploadRecords('+value.recordsId+')" ><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
											}else{
												if(roleCode == 'admin' || roleCode == 'chairman' || roleCode == 'president' || roleCode == 'classLeader'){
													appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')" ><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">'+praiseList.length+'</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">0</span>)</span><span onclick= "deleteUploadRecords('+value.recordsId+')"><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
												}else{
													appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">'+praiseList.length+'</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">0</span>)</span></p>';
												}
											}
										}else if(praiseList == null && commentList != null){
											if(userId == value.uploadUserId){
												appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">0</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">'+commentList.length+'</span>)</span><span onclick= "deleteUploadRecords('+value.recordsId+')"><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
											}else{
												if(roleCode == 'admin' || roleCode == 'chairman' || roleCode == 'president' || roleCode == 'classLeader'){
													appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">0</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">'+commentList.length+'</span>)</span><span onclick= "deleteUploadRecords('+value.recordsId+')"><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
												}else{
													appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">0</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">'+commentList.length+'</span>)</span></p>';
												}
											}
										}else{
											if(userId == value.uploadUserId){
												appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">0</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">0</span>)</span><span onclick= "deleteUploadRecords('+value.recordsId+')"><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
											}else{
												if(roleCode == 'admin' || roleCode == 'chairman' || roleCode == 'president' || roleCode == 'classLeader'){
													appendHtml += '<p><span onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">0</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">0</span>)</span><span onclick= "deleteUploadRecords('+value.recordsId+')"><i class="icon-trash"></i><a href="javascript:;">删除</a></span></p>';
												}else{
													appendHtml += '<p><span  onclick= "addPraise('+value.recordsId+')"><i class="icon-thumbs-up"></i><a href="javascript:;">赞</a>(<span id="praiseCount'+value.recordsId+'">0</span>)</span><span onclick="textareaFocus(\'textarea'+value.recordsId+'\')"><i class="icon-comment"></i><a href="javascript:;">评论</a>(<span id="commentCount'+value.recordsId+'">0</span>)</span></p>';
												}
											}
										}
										
										appendHtml += '<div class="Like" id="praiseTotal'+value.recordsId+'"><i class="icon-thumbs-up"></i>';
												$.each(praiseList, function(pn, praise) {
													appendHtml += '<span id="praise'+praise.commentId+'">'+praise.commentUserName+'</span>';
												});
										appendHtml += '</div>';
										appendHtml += '<dl class="dl'+cPage+'" id="d'+value.recordsId+'">';
											$.each(commentList, function(cn, comment) {
													appendHtml += '<dd id="dd'+comment.commentId+'">';
														if(comment.headImg=="" || comment.headImg=="head/avatar_default.png" ||  comment.headImg==undefined)
														{
															appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
														}else
														{
															appendHtml += '<img src="<%=Cons.HEADIMGBASEPATH%>'+comment.headImg +'">';
														}
														
														appendHtml += '<div class="bbs_info">';
															appendHtml += '<p><span><a href="javascript:;">'+comment.commentUserName+'</a></span><span>:</span>'+comment.content+'</p>';
															
															if(userId == value.uploadUserId){
																appendHtml += '<p id="p'+comment.commentId+'"><span>'+comment.createTime+'</span><i attr1='+comment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i><span><i onclick="deleteComment('+comment.commentId+','+comment.commentId+')" class="icon-trash"></i></span></p>';
															}else{
																if(roleCode == 'admin' || roleCode == 'chairman'  || roleCode == 'president' || roleCode == 'classLeader'){
																	appendHtml += '<p id="p'+comment.commentId+'"><span>'+comment.createTime+'</span><i attr1='+comment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i><span><i onclick="deleteComment('+comment.commentId+','+comment.commentId+')" class="icon-trash"></i></span></p>';
																}else{
																	appendHtml += '<p id="p'+comment.commentId+'"><span>'+comment.createTime+'</span><i attr1='+comment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i></p>';
																}
															}
															var commentSubList = commentSubMap[comment.commentId];
															if(commentSubList != null){
																$.each(commentSubList, function(cn, subComment) {
																	appendHtml += '<div class="bbs_list" id="subComment'+subComment.commentId+'">';
																		if(subComment.headImg=="" || subComment.headImg=="head/avatar_default.png" || subComment.headImg==undefined)
																		{
																			appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
																		}else
																		{
																			appendHtml += '<img src="<%=Cons.HEADIMGBASEPATH%>'+subComment.headImg +'">';
																		}
																		appendHtml += '<div class="Response_info">';
																			appendHtml += '<p><span><a href="javascript:;">'+subComment.commentUserName+'</a>回复<a href="javascript:;">'+subComment.commentReplyUserName+'</a>:</span>'+subComment.content+'</p>';
																			if(userId == value.uploadUserId){
																				appendHtml += '<p><span>'+subComment.createTime+'</span><i attr1='+subComment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i><i onclick="deleteComment('+subComment.commentId+','+comment.commentId+')" class="icon-trash"></i></p>';
																			}else{
																				if(roleCode == 'admin' || roleCode == 'chairman' || roleCode == 'president' || roleCode == 'classLeader'){
																					appendHtml += '<p><span>'+subComment.createTime+'</span><i attr1='+subComment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i><i onclick="deleteComment('+subComment.commentId+','+comment.commentId+')" class="icon-trash"></i></p>';
																				}else{
																					appendHtml += '<p><span>'+subComment.createTime+'</span><i attr1='+subComment.commentId+' attr2='+comment.commentId+' class="icon-comment"></i></p>';
																				}
																			}
																		appendHtml += '</div>';
																	appendHtml += '</div>';
																	});
															}
														appendHtml += '</div>';
													appendHtml += '</dd>';
											});
										appendHtml += '</dl>';
									appendHtml += '</div>';
								appendHtml += '</div>';
							appendHtml += '<div class="first_Response"><textarea id="textarea'+value.recordsId+'" class="span5"  placeholder="我也来评论下。。。"></textarea>';
							appendHtml += '<button  id="button'+value.recordsId+'" attr1="'+value.uploadUserId+'" onclick="addComment_tmp('+value.recordsId+')" class="button_first">发表</button></div>';
							appendHtml += '</li>';
		      			});
						$("#ul").append(appendHtml);
						$("#ul").after("<div class='photo_message'>加载下一页</div>");

						
						$(".bbs_info p").hover(function(){
								$(this).find(".icon-trash").css({"display":"inline-block"});
							},function(){
							$(this).find(".icon-trash").removeAttr("style");
							})
						$(".Response_info p").hover(function(){
							$(this).find(".icon-trash").css({"display":"inline-block"});
							},function(){
								$(this).find(".icon-trash").removeAttr("style");
							})
							
							
						//加载点击事件
						$(".dl"+cPage).find(".icon-comment").on("click",function(){
							var recordsId = $(this).parents("dl").attr("id").replace("d","");
							var commentReplyId = $(this).attr("attr1");
							var parentId = $(this).attr("attr2");
							var text='';
							if($("#Text"+commentReplyId).length>0){
							}else{
								text="<div class='add_bbs_dateil'><textarea id='Text"+commentReplyId+"' class='add_textarea' placeholder='我也来评论下。。。'></textarea><button class='button_second' attr1 ='"+commentReplyId+"' attr2='"+parentId+"' onclick='addComment("+commentReplyId+","+parentId+","+recordsId+","+null+")'>发表</button></div>";
							}
							$(".add_textarea").remove();
							$(".button_second").remove();
							$(this).parent().parent().append(text);
						});
						
// 						$("ul .button_first").on("click",function(){
// 							
// 							var _textarea = $(this).prev();
// 							var _input = _textarea.parent().prev();
// 							var commentReplyId = 0;
// 							var parentId = 0;
// 							var recordsId = _input.val();
// 							var textareaText = _textarea.val();
// 							addComment(commentReplyId,parentId,recordsId,textareaText);
// 							_textarea.val("");
// 						});
					} else{
						$("#ul").after("<div class='photo_end'>已经到最后一页</div>");
					}
				}else{
					$("#ul").after("<div class='photo_end'>已经到最后一页</div>");
				}
      			//解锁UI
      			App.unblockUI(body);
			},
		});
	}

	//点击评论  评论输入框获取焦点
	function textareaFocus(id){
		$("#"+id).focus();
	}
	
	//用于解决多次出发click事件
	function addComment_tmp(recordsId){
		var _button = $("#button"+recordsId);
		var _textarea = _button.prev();
		var commentReplyId = 0;
		var parentId = 0;
		var textareaText = _textarea.val();
		addComment(commentReplyId,parentId,recordsId,textareaText);
		_textarea.val("");
	}
	//对上传记录评论
	function addComment(commentReplyId,parentId,recordsId,textareaText){
		//用于保存评论		
		if(textareaText == null){
			textareaText = $("#Text"+commentReplyId).val();
		}
		if(textareaText.trim() == ''){
			alert("请输入评价");
			return false;
		}
		//这里是加载那些人能看到删除按钮
		var userId = $("ul li.active").find('a').attr("attr1");
		var roleCode = $("ul li.active").find('a').attr("attr2");
		var uploadUserId = $("#button"+recordsId).attr("attr1");
		//TODO
		$.ajax({
			type: "post",
			url: "<%=basePath%>clazzPhoto/addComment.do",
			data:{
					commentReplyId : commentReplyId,
					parentId : parentId,
					recordsId : recordsId,
					textareaText : textareaText
				},
			success: function(data){
				//保存成功
				var recordsComment = eval("(" + data + ")");
				var recordsComment_reply = recordsComment.recordsComment;
				var _div = '';
				if(parentId != '0'){
					_div += '<div class="bbs_list" id="subComment'+recordsComment.commentId+'" >';
					if(recordsComment.headImg=="" || recordsComment.headImg=="head/avatar_default.png" || recordsComment.headImg==undefined)
					{
						_div += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
					}else
					{
						_div += '<img src="<%=Cons.HEADIMGBASEPATH%>'+recordsComment.headImg +'">';
					}
					_div += '<div class="Response_info">';
					_div += '<p><span><a href="javascript:;">'+recordsComment.commentUserName+'</a>回复<a href="javascript:;">'+recordsComment_reply.commentUserName+'</a>:</span>'+recordsComment.content+'</p>';
					if(userId == uploadUserId){
						_div += '<p><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+parentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i><i onclick="deleteComment('+recordsComment.commentId+','+parentId+')" class="icon-trash"></i></p>';
					}else{
						if(roleCode == 'admin' || roleCode == 'chairman' || roleCode == 'president' || roleCode == 'classLeader'){
							_div += '<p><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+parentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i><i onclick="deleteComment('+recordsComment.commentId+','+parentId+')" class="icon-trash"></i></p>';
						}else{
							_div += '<p><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+parentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i></p>';
						}
					}
					_div += '</div>';
					if(commentReplyId != parentId){
						$("#subComment"+commentReplyId).after(_div);
					}else{
						$("#p"+parentId).after(_div);
					}
					
					$(".add_textarea").remove();
					$(".button_second").remove();
				}else{
					_div += '<dd id="dd'+recordsComment.commentId+'">';
						if(recordsComment.headImg=="" || recordsComment.headImg=="head/avatar_default.png" || recordsComment.headImg==undefined)
						{
							_div += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
						}else
						{
							_div += '<img src="<%=Cons.HEADIMGBASEPATH%>'+recordsComment.headImg +'">';
						}
						_div += '<div class="bbs_info">';
							_div += '<p><span><a href="javascript:;">'+recordsComment.commentUserName+'</a></span><span>:</span>'+recordsComment.content+'</p>';
							if(userId == uploadUserId){
								_div += '<p id="p'+recordsComment.commentId+'"><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+recordsComment.commentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i><i onclick="deleteComment('+recordsComment.commentId+','+recordsComment.commentId+')" class="icon-trash"></i></p>';
							}else{
								if(roleCode == 'admin' || roleCode == 'chairman' || roleCode == 'president' || roleCode == 'classLeader'){
									_div += '<p id="p'+recordsComment.commentId+'"><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+recordsComment.commentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i><i onclick="deleteComment('+recordsComment.commentId+','+recordsComment.commentId+')" class="icon-trash"></i></p>';
								}else{
									_div += '<p id="p'+recordsComment.commentId+'"><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+recordsComment.commentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i></p>';
								}
							}
						_div += '</div>';
					_div += '</dd>';
					$("#d"+recordsId).append(_div);

					//评论数量
					var commentCount = parseInt($("#commentCount"+recordsId).text())+1;
					$("#commentCount"+recordsId).text(commentCount);
					
				}
				$(".bbs_info p").hover(function(){
						$(this).find(".icon-trash").css({"display":"inline-block"});
					},function(){
					$(this).find(".icon-trash").removeAttr("style");
					})
				$(".Response_info p").hover(function(){
						$(this).find(".icon-trash").css({"display":"inline-block"});
					},function(){
						$(this).find(".icon-trash").removeAttr("style");
					})
				//加载点击事件(仅仅只是对添加的icon绑定点击事件)
				 $("dl #icon"+recordsComment.commentId).on("click",function(){
						var recordsId = $(this).parents("dl").attr("id").replace("d","");
						var commentReplyId = $(this).attr("attr1");
						var parentId = $(this).attr("attr2");
						var text='';
						if($("#Text"+commentReplyId).length>0){
						}else{
							text="<div class='add_bbs_dateil'><textarea id='Text"+commentReplyId+"' class='add_textarea' placeholder='我也来评论下。。。'></textarea><button class='button_second' attr1 ='"+commentReplyId+"' attr2='"+parentId+"' onclick='addComment("+commentReplyId+","+parentId+","+recordsId+","+null+")'>发表</button></div>";
						}
						$(".add_textarea").remove();
						$(".button_second").remove();
						$(this).parent().parent().append(text);
					});
			},
		});
		
	}

	//对单个图片评论
	function addPhotoComment(commentReplyId,parentId,photoId,textareaText){
				//用于保存评论		
				if(textareaText == null){
					textareaText = $("#photoText"+commentReplyId).val();
				}
				if(textareaText.trim() == ''){
					layer.alert('请输入评论', {
					    skin: 'layui-layer-lan'
					    ,closeBtn: 0
					  });
					return false;
				}
				
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzPhoto/addPhotoComment.do",
					data:{
							commentReplyId : commentReplyId,
							parentId : parentId,
							photoId : photoId,
							textareaText : textareaText
						},
					success: function(data){
						//保存成功
						var recordsComment = eval("(" + data + ")");
						var recordsComment_reply = recordsComment.recordsComment;
						var _div = '';
						if(parentId != '0'){
							_div += '<div class="bbs_list" id="subPhotoComment'+recordsComment.commentId+'" >';
							
							if(recordsComment.headImg=="" || recordsComment.headImg=="head/avatar_default.png" || recordsComment.headImg==undefined)
							{
								_div += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
							}else
							{
								_div += '<img src="<%=Cons.HEADIMGBASEPATH%>'+recordsComment.headImg +'">';
							}
							
							_div += '<div class="Response_info">';
							_div += '<p><span><a href="javascript:;">'+recordsComment.commentUserName+'</a>回复<a href="javascript:;">'+recordsComment_reply.commentUserName+'</a>:</span>'+recordsComment.content+'</p>';
							_div += '<p><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+parentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i></p>';
							_div += '</div>';
							_div += '</div>';
							if(commentReplyId != parentId){
								$("#subPhotoComment"+commentReplyId).after(_div);
							}else{
								$("#photop"+parentId).after(_div);
							}
							
							$(".photo_add_textarea").remove();
							$(".photo_button_second").remove();
						}else{
							_div += '<dd>';
								if(recordsComment.headImg=="" || recordsComment.headImg=="head/avatar_default.png" || recordsComment.headImg==undefined)
								{
									_div += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
								}else
								{
									_div += '<img src="<%=Cons.HEADIMGBASEPATH%>'+recordsComment.headImg +'">';
								}
								_div += '<div class="bbs_info">';
									_div += '<p><span><a href="javascript:;">'+recordsComment.commentUserName+'</a></span><span>:</span>'+recordsComment.content+'</p>';
									_div += '<p id="photop'+recordsComment.commentId+'"><span>'+recordsComment.createTime+'</span><i attr1='+recordsComment.commentId+' attr2='+recordsComment.commentId+' class="icon-comment" id="icon'+recordsComment.commentId+'"></i></p>';
								_div += '</div>';
							_div += '</dd>';
							$("#photod"+photoId).append(_div);
							
							//评论数量
							var photoCommentCount = parseInt($("#photoCommentCount"+photoId).text())+1;
							$("#photoCommentCount"+photoId).text(photoCommentCount);
						}
						//加载点击事件(仅仅只是对添加的icon绑定点击事件)
						$("dl #icon"+recordsComment.commentId).on("click",function(){
							var  photoId = $(this).parents("dl").attr("id").replace("photod", "");
							var commentReplyId = $(this).attr("attr1");
							var parentId = $(this).attr("attr2");
							var text='';
							if($("#photoText"+commentReplyId).length>0){
								 
							}else{
								text="<textarea id='photoText"+commentReplyId+"' class='photo_add_textarea' placeholder='我也来评论下。。。'></textarea><button class='photo_button_second' attr1 ='"+commentReplyId+"' attr2='"+parentId+"' attr3='"+photoId+"' onclick='addPhotoComment("+commentReplyId+","+parentId+","+photoId+","+null+")'>发表</button>";
							}
							$(".photo_add_textarea").remove();
							$(".photo_button_second").remove();
							$(this).parent().parent().append(text);
						})
					},
					
				});
				
			}

	//上传记录点赞
	function addPraise(recordsId){
		$.ajax({
			type: "post",
			url: "<%=basePath%>clazzPhoto/addPraise.do",
			data:{
				recordsId : recordsId
				},
			success: function(data){
				//点赞成功，已经点赞的人员取消点赞
				var recordsComment = eval("(" + data + ")");
				var existFlag = recordsComment.existFlag;
				if(existFlag == '0'){
					var _span= '<span id="praise'+recordsComment.commentId+'">'+recordsComment.commentUserName+'</span>';
					$("#praiseTotal"+recordsId).append(_span);
					//点赞次数增减
					$("#praiseCount"+recordsId).text("");
					var praiseCount = $("#praiseCount"+recordsId).text()+1;
					$("#praiseCount"+recordsId).text(praiseCount);
				}else{
					var commentId = recordsComment.commentId;
					$("#praiseTotal"+recordsId+ " span").remove("#praise"+commentId);
					
					//点赞次数增减
					$("#praiseCount"+recordsId).text("");
					var praiseCount = $("#praiseCount"+recordsId).text()-1;
					if(praiseCount < 0){
						$("#praiseCount"+recordsId).text(0);
					}else{
						$("#praiseCount"+recordsId).text(praiseCount);
					}
				}
				
			},
		});
	}
	
	//单个图片点赞
	function addPhotoPraise(photoId){
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzPhoto/addPraise.do",
					data:{
						photoId : photoId
						},
					success: function(data){
						//点赞成功，已经点赞的人员取消点赞
						var recordsComment = eval("(" + data + ")");
						var existFlag = recordsComment.existFlag;
						if(existFlag == '0'){
							var _span= '<span id="photoPraise'+recordsComment.commentId+'">'+recordsComment.commentUserName+'</span>';
							$("#photoPraiseTotal"+photoId).append(_span);
							//点赞次数增减
							$("#photoPraiseCount"+photoId).text("");
							var praiseCount = $("#photoPraiseCount"+photoId).text()+1;
							$("#photoPraiseCount"+photoId).text(praiseCount);
						}else{
							var commentId = recordsComment.commentId;
							$("#photoPraiseTotal"+photoId+ " span").remove("#photoPraise"+commentId);
							
							//点赞次数增减
							$("#photoPraiseCount"+photoId).text("");
							var praiseCount = $("#photoPraiseCount"+photoId).text()-1;
							if(praiseCount < 0){
								$("#photoPraiseCount"+photoId).text(0);
							}else{
								$("#photoPraiseCount"+photoId).text(praiseCount);
							}
						}
						
					},
				});
			}

	//删除上传记录
	function deleteUploadRecords(recordsId){
		if(confirm("确定删除这条记录？")){
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazzPhoto/deleteUploadRecords.do",
				data:{
					recordsId : recordsId
					},
				success: function(data){
					var flag = eval("(" + data + ")");
					if(flag){
						//删除成功的情况下需要，在页面上删除相关内容
						$("#li"+recordsId).remove();
					}
				},
			});
		}
	}
	
	//删除评价
	function deleteComment(commentId,parentId){
		if(confirm("确定删除这条评论？")){
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazzPhoto/deleteComment.do",
				data:{
					commentId : commentId,
					parentId : parentId
					},
				success: function(data){
					var flag = eval("(" + data + ")");
					if(flag){
						//删除成功的情况下需要，在页面上删除相关内容
						if(commentId == parentId){
							$("#dd"+commentId).remove();
						}else{
							$("#subComment"+commentId).remove();
						}
					}
				},
			});
		}
	}

	
	

	function loadSinglePhoto(index)
	{
		
        var oPicLi = $("#picBox").find("li");
        var oListLi = $("#listBox").find("li");
        var len1 = oPicLi.length;
        var len2 = oListLi.length;
        
        var oPicUl = $("#picBox").find("ul")[0];
        var oListUl = $("#listBox").find("ul")[0];
//         var w1 = $("#picBox").find("li")[0].offsetWidth;
//         var w2 = $("#listBox").find("li")[0].offsetWidth;

        var w1 = 600;
        var w2 = 80;
        

        oPicUl.style.width = w1 * len1 + "px";
        oListUl.style.width = w2 * len2 + "px";

        oPicUl.style.left = (- index * w1) + "px";
		oListUl.style.left = (- index * w2) + "px";

        var num = 5;
        var num2 = Math.ceil(num / 2);

        Change(oPicUl,index,num2,num,oListUl,len2,oListLi,w1,w2);
        
        $("#nextTop").on("click",function(){
            index ++;
            index = index == len2 ? 0 : index;
            Change(oPicUl,index,num2,num,oListUl,len2,oListLi,w1,w2);
        });
        $("#next").on("click",function(){
            index ++;
            index = index == len2 ? 0 : index;
            Change(oPicUl,index,num2,num,oListUl,len2,oListLi,w1,w2);
        });
        $("#prevTop").on("click",function(){
            index --;
            index = index == -1 ? len2 -1 : index;
            Change(oPicUl,index,num2,num,oListUl,len2,oListLi,w1,w2);
        });

        $("#prev").on("click",function(){
            index --;
            index = index == -1 ? len2 -1 : index;
            Change(oPicUl,index,num2,num,oListUl,len2,oListLi,w1,w2);
        });

        for (var i = 0; i < len2; i++) {
            oListLi[i].index = i;
            oListLi[i].onclick = function(){
                index = this.index;
                Change(oPicUl,index,num2,num,oListUl,len2,oListLi,w1,w2);
            }
        }
    }

    function getStyle(obj, attr) {
		
        if (obj.currentStyle) {
            return obj.currentStyle[attr];
        } else {
            return getComputedStyle(obj, false)[attr];
        }
    }
    function Animate(obj, json) {
        if (obj.timer) {
            clearInterval(obj.timer);
        }
        obj.timer = setInterval(function(){
            for (var attr in json) {
                var iCur = parseInt(getStyle(obj, attr));
                iCur = iCur ? iCur : 0;
                var iSpeed = (json[attr] - iCur) / 5;
                iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
                obj.style[attr] = iCur + iSpeed + 'px';
                if(iCur == json[attr]){
                    clearInterval(obj.timer);
                }
            }
        }, 30);
    }

    function Change(oPicUl,index,num2,num,oListUl,len2,oListLi,w1,w2) {
        Animate(oPicUl, {left: - index * w1});
        if(index < num2){
            Animate(oListUl, {left: 0});
        }else if(index + num2 <= len2){
            Animate(oListUl, {left: - (index - num2 + 1) * w2});
        }else{
            Animate(oListUl, {left: - (len2 - num) * w2});
        }

        for (var i = 0; i < len2; i++) {
            oListLi[i].className = "";
            if(i == index){
                oListLi[i].className = "on";
                loadSinglePhotoDetail($(".listBox .on").attr("id"));
            }
        }
    }
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>