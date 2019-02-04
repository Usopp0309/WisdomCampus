<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>班级相册</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
	<link href="<%=basePath %>assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>assets/global/plugins/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>assets/global/plugins/album/styles/albunm.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>assets/global/plugins/album/styles/photo_Slideshow.css" rel="stylesheet" type="text/css" />
 	<!--公共css结束-->  
 	<style type="text/css">
        .page-content-white .page-content .page-bar{
            border-bottom:none !important;
		    margin: -7px 0 20px !important;
		    list-style: none;
		    background-color: #f5f5f5;
        }
       
</style>      
</head>
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
	        <div class="page-content-wrapper">
	            <div class="page-content m_overflow_hidden m_page_content">
	            	<!-- 页面内容开始 -->
	            	<div class="col-md-12 col-sm-12 m_page_con">
	                <div class="page-bar m_margin_0_0_0_0">
	                    <ul class="page-breadcrumb">
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="icon-angle-right"></i></li>
	                        <li><a href="">班级相册</a><i class="icon-angle-right"></i></li>
	                        <li><span>班级相册</span></li>
	                    </ul>
	                </div>
	     <!--             <h3 class="page-title">班级相册</h3>  -->
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div>
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs addmenuUl"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
											</li>
								    </c:forEach>	
	                            </ul>
	                            <input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}"/>	
						        <input type="hidden" name="schoolId" id="schoolId" value="${sessionScope.user.schoolId}"/>	
						        <input type="hidden" name="prefix" id="prefix" value="class"/>		
	                    		<!-- 角色切换结束 -->
	                           </div>
	                       
	                        
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
	                     <button type="button" class="btn blue f_right m_margin_top-15" id="search" style="float:left;padding:4px 14px;"><i class="icon-search"></i>查找</button>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            
	                            
	                            <div class="portlet-body flip-scroll photo">
	                                <div class="row">
	                                <ul class="nav nav-tabs">
										<li class="active" onclick="toAlbum(this);" style="cursor: pointer;">相册</li>
										<li onclick="toPhoto(this)" style="cursor: pointer;">照片</li>
									</ul>
									<!-- 添加功能菜单开始 -->
		                        <div class="portlet light form-fit m_margin_0_0_15_0 add-menu">
	<!-- 	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#qrcodeHtml" onclick="getid(1)">上传照片</button> -->
	<!-- 	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#createHtml" onclick="getid(2)">创建相册</button> -->
		                        	<a href="#static" data-toggle="modal" class=" btn blue" onclick="getid(1,450)" id="uploadPhotos">上传照片</a>
									<a href="#static" data-toggle="modal" class=" btn"  onclick="getid(2,150)" id="newPhoto">创建相册</a>
		                        </div>
	                        <!-- 添加功能菜单结束 -->
									<div  class="photo_list">
										<ul id="albumList">
										</ul>
									</div>
									<div class="photo_detail">
										<div class="photo_detail_header">
										</div>
										<ul id="photoDetailList">
										</ul>
									</div>
	                                </div>
	                                </div>
	                                
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                        <!-- 分页开始 -->
	                       <%--  <%@include file="/public_module/public_page.jsp" %> --%>
	                        <!-- 分页结束 -->
	                    </div>
	                </div>
	                </div>
	                <!--页面内容结束 -->
	            </div>
	        </div>
	        <input type="hidden" name="albumId" id="albumId" value="0">
			<input type="hidden" name="photoId" id="photoId" value="0">
			<input type="hidden" name="uploadCom" id="uploadCom" value="${uploadCom}">
			<input type="hidden" name="num" id="num" value="${num}">
			<input type="hidden" name="gradeId" id="gradeId" value="${gradeId}">
			<input type="hidden" name="clazzId" id="clazzId" value="${clazzId}">
			<input type="hidden" name="roleCode" id="roleCode" value="${roleCode}">
			<!-- 	单张图片分享使用 -->
			<input type="hidden" id="photoPath" value="">
			<input type="hidden" id="singleShare" value="">
			<input type="hidden" id="student" value="">
	        <!-- 亦信聊天开始 -->
	    	<%@ include file="/public_module/public_QQ.jsp" %>
	        <!-- 亦信聊天结束 -->
	    </div>
	    <!-- 内容页结束 -->
	    <!-- 底部开始 -->
	    <%@ include file="/public_module/public_footer.jsp" %>
	    <!-- 底部结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
    <script src="<%=basePath %>assets/global/plugins/bootstrap-select/js/bootstrap-select.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/pages/scripts/components-bootstrap-select.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/tmpl.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/load-image.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/vendor/canvas-to-blob.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/blueimp-gallery/jquery.blueimp-gallery.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-process.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-image.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-audio.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-video.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-validate.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-ui.js" type="text/javascript"></script>
    
    <script src="<%=basePath %>assets/global/plugins/album/js/layer/layer.js" type="text/javascript"></script>
    
    <script src="<%=basePath %>assets/pages/scripts/form-fileupload.min.js" type="text/javascript"></script>
    
	<script src="<%=basePath%>assets/global/plugins/album/scripts/moxie.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/plupload.dev.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/zh_CN.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/ui.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/qiniu.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/highlight.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/main.js" type="text/javascript"></script>
    <div class="modal fade bs-modal-lg" id="static" tabindex="-1" role="dialog" aria-hidden="true">
	     <div class="modal-dialog modal-lg">
	     
	        <!--1111111start  -->
    		<div class="modal_page page1" style="display:none;">
			<div class="upload_photo" id="phone_up">
				<div class="modal-header null_margin_padding">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
					<h3 style="font-size:18px;">上传照片</h3>
				</div>
				<form action="" method="POST" id="uploadPhoto" enctype="multipart/form-data" style="padding:0 20px;">  
					<div class="row-fluid fileupload-buttonbar">
	                    <div class="span12" id="clazzDiv" style="margin:15px 0 0 0">
								<span>上传到:</span>
								<select class="public_input_s" id="albumSelectList" name="albumSelect"></select>
						</div>
	                    <div class="col-md-12" style="margin-top: 50px;">
	                        <div id="container" style="position: relative;">
	                            <a class="btn green fileinput-button " id="pickfiles" style="position: relative; z-index: 1;left: 45px;" href="#">
	                                <i class="glyphicon glyphicon-plus"></i>
	                                <span>选择文件</span> 
	                            </a>
	                             <a class="btn yellow fileinput-button " id="upload" style="position: relative; z-index: 1;left: 60px;" href="javascript:uploadFiles();">
	                                <i class="glyphicon glyphicon-plus"></i>
	                             <span>上传</span>
	                              </a>
		                        <div class="moxie-shim moxie-shim-html5" id="html5_1ahb5b2no6n71dhs1fb11dda1nm3_container" style="left: 0px; top: 0px; width: 171px; height: 46px; overflow: hidden; position: absolute; z-index: 0;">
		                       		 <input id="html5_1ahb5b2no6n71dhs1fb11dda1nm3" style="left: 0px; top: 0px; width: 100%; height: 100%; font-size: 999px; position: absolute; opacity: 0;" type="file" accept="" multiple="">
		                        </div>
	                        </div>
	                    </div>
	                    <div id="file-list"></div>
						<input id="domain" type="hidden" value="<%=Cons.QINIU_URL_CLASSALBUM%>">
	                    <input id="basePath" type="hidden" value="<%=basePath%>clazzAlbum/uploadPhoto.do">
	                    <input id="uptoken_url" type="hidden" value="<%=basePath%>clazzAlbum/getUpTokenInJS.do">
                   </div>
			  </form>
		   </div>
		   
		   <div class="upload_photo" id="phone_share" style="padding:0 20px;">
				<i style=" position: absolute; top:10px;right:10px;display:block;color:#ccc;font-size:16px;cursor: pointer;" onclick="shareCancel()" class="icon-remove"></i>
				<h2>分享给<span style="margin-left: 10px;font-size: 10px;font-weight: 500;">(非必选,如不分享点击取消)</span></h2>
				<div class="modal_select_person">
					<div class="row-fluid">
						<span ><i class="icon-ok modal_all_person"></i>全选 <b>已选<em class="modal_num">0</em></b>人</span>
					</div>
					<ul id="selectStudentUp">
					</ul>
					<div class="footer">
						<button class="btn" onclick="shareCancel()" type="button">取消</button>
						<button class="btn blue" onclick="shareConfirm()" id="sharePhotoUpload">确定</button>
					</div>
				</div>
		   </div>	
	</div>
	        <!--1111111end  -->
	        
	        <!--2222222start  -->
	        <div class="modal_page page2" style="margin-top: 450px;display:none;">
		    <div class="add_photo">    
			<form class="form-horizontal" action="" id="addAlbum" style="background: ghostwhite; width: 500px; margin-left: 50%;">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
					<h3>创建相册</h3>
				</div>
				<div class="modal-body">
					<div class="control-group">
						<label class="control-label">相册名称</label>
						<div class="controls">
							<input type="text" name="albumName" id="albumName">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">相册描述</label>
						<div class="controls">
							<textarea rows="" cols="" style="height:75px;rzsize:none;" name="albumDescription" id="albumDescription"></textarea>
						</div>
					</div>
				</div>
				
				<div class="modal-footer no-padding-margin">
				    <button class="btn" data-dismiss="modal" type="button">取消</button>
					<button class="btn green" type="button" id="saveAlbum" >确定</button>
			   </div>
			</form>
		</div>
		
		<div class="add_photo text_c" style="display:none;background: ghostwhite;margin-left: 400px;width: 500px;">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
				<h3>创建相册</h3>
			</div>
			
			<div class="add_photo_info" style="width: 400px;">
				<img src="<%=basePath%>assets/global/img/m_img/note.png" style="margin: 9px 10px 0 30px;width: 40px;height: 40px;float: left;">
				<p style="margin: 0 0 0 90px;height:25px;float:none;" >相册创建成功，</p>
				<p style="margin:0 0 0 90px;height:25px;float:none;width: 400px;">是否马上上传照片到这个相册</p>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" type="button">否</button>
				<button class="btn b_true2 green" type="button" id="uploadPhotoToAlbum">是</button>
			</div>
		</div>
	</div>
	        <!--2222222end-->
	        
	        <!-- 333333start -->
	        <div class="modal_page page3" style="background: white;">
			  <div class="add_photo">
				<form class="form-horizontal" action="" id="addAlbum">
					<div class="modal-header">
						<button aria-hidden="true" data-dismiss="modal" class="close"
							type="button"></button>
						<h3>修改相册</h3>
					</div>
					<div class="modal-body form-horizontal">
						<div class="form-group">
							<label class="col-md-3 control-label">相册名称</label>
							<div class="col-md-8">
								<input type="text" class="form-control" placeholder="Enter text"
									name="albumName" id="albumNameModify"> <span
									class="help-block"> A block of help text. </span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">相册描述</label>
							<div class="col-md-8">
								<textarea class="form-control" rows="3" name="albumDescription"
									id="albumDescriptionModify"></textarea>
								<span class="help-block"> A block of help text. </span>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn" data-dismiss="modal" type="button">取消</button>
						<button class="btn green " data-dismiss="modal" type="button"
							id="modifyAlbum">确定</button>
					</div>
				</form>
			</div>
		</div>
	        <!-- 333333end -->
	        
	        <!-- 444444start -->
	        <div class="modal_page page4" style="display:none;">
		      <form class="form-horizontal" action="">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
				<h3>修改照片</h3>
			</div>
			<div class="modal-body">
				<div class="control-group">
					<label class="control-label">照片名称</label>
					<div class="controls">
						<input type="text" name="photoName" id="photoName">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">照片描述</label>
					<div class="controls">
						<textarea rows="" cols="" style="height:75px;rzsize:none;" name="photoDesc" id="photoDesc"></textarea>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" type="button">取消</button>
				<button class="btn green " data-dismiss="modal" type="button" id="modifyPhoto">确定</button>
			</div>
		</form>
	</div>
	        <!-- 444444end -->
	        
	        <!-- 555555start -->
	        <div class="modal_page page5"  style="display:none;">
		<div class="modal-header">
			<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
			<h3>删除照片</h3>
		</div>
		<div class="modal-body">
			<img src="<%=basePath%>assets/global/img/m_img/note.png" style="width: 30px;width: 35px;display:block;margin:0px auto;">
			<p style="text-align:center;">确定删除本相册，并清空里面的所有照片?</p>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" type="button">否</button>
			<button class="btn green " data-dismiss="modal" type="button" id="deletePhoto" >是</button>
		</div>
	</div>
		    <!-- 555555end -->
		    
		    <!-- 666666start -->
	        <div class="modal_page page6"  style="display:none;">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
				<h3>删除相册</h3>
			</div>
			<div class="modal-body">
				<img src="<%=basePath%>assets/global/img/m_img/note.png" style="width: 30px;width: 35px;display:block;margin:0px auto;">
				<p style="text-align:center;">确定删除本相册，并清空里面的所有照片?</p>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" type="button">否</button>
				<button class="btn green " data-dismiss="modal" type="button" id="deleteAlbum">是</button>
			</div>
		</div>
       	    <!-- 666666end -->
       	   
       	    <!-- 77777start -->
       	    <div class="modal-dialog modal-md page page7" style="width:1000px;display:none;">
		       <div class="modal-content">
			   <div class="modal-header">
			    <span class="albumName"></span>
				<i style="position: absolute; top: 10px; right: 10px; display: block; color: #ccc; font-size: 16px; cursor: pointer;"
					data-dismiss="modal" class="icon-remove"></i>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="photo_show">
							<span id="prev" class="btn prev" style="display: none"></span> <span
								id="next" class="btn next" style="display: none"></span> <span
								id="prevTop" class="btn prev fa fa-angle-left"></span> <span
								id="nextTop" class="btn next fa fa-angle-right"></span>

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
			<div class="modal-footer">
				<!-- <button type="button" id="upload" class="btn green">确定</button> -->
				<button type="button" data-dismiss="modal" class="btn">关闭</button>                            
			</div>
		</div>
	</div>
	         <!-- 77777end -->
	        
	         <!-- 88888start -->
	        <div class="modal-dialog modal-md page page8" style="display:none;">
	           <div class="modal-content">
			   <div class="modal-header">
				<i style="position: absolute; top:10px;right:10px;display:block;color:#ccc;font-size:16px;cursor: pointer;" data-dismiss="modal" class="icon-remove"></i>
			    <h3>分享给</h3>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="modal_select_person">
							<div class="row-fluid">
								<span ><i class="icon-ok modal_all_person"></i>全选 <b>已选<em class="modal_num">0</em></b>人</span>
							</div>
							<ul id="selectStudent">
							</ul>
				        </div> 
					</div>
			   </div>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" type="button">取消</button>
				<button class="btn blue" data-dismiss="modal" type="button" id="sharePhoto">分享</button>
			</div>
	 </div>
	</div>
              <!-- 88888end -->
        </div>
    </div>
    <script type="text/javascript">
	  $(function(){
	      loadSubMenu("clazzPhotoAlbumManager"); 
		  //选取当前菜单位置
		  setActive("clazzPhotoAlbumManager","clazzPhotoAlbum");
		 /*  $(".album_list").hover(function(){
				$(this).find(".actions").show(100);
			  },function(){
				$(this).find(".actions").hide(100);
		   }) 
		   $(".m_btn_upload").on("click",function(){
				$(this).hide();
				$(".m_img_upload").hide();
				$(".m_btn_share,.m_img_share").show();
			  })
			$(".m_img_share p").on("click",function(){
				if($(this).hasClass("select")){
					$(this).removeClass("select");
					$(".share_num").text($(".select").length)
				}else{
					$(this).addClass("select");
					$(".share_num").text($(".select").length)
				}
			}); */
			$(".photo_button_first").on("click",function(){
				var _textarea = $(this).prev();
				var photoId = $("#listBox .cf").find(".on").attr("id");						
				var commentReplyId = 0;
				var parentId = 0;
				var textareaText = _textarea.val();
				addPhotoComment(commentReplyId,parentId,photoId,textareaText);
				_textarea.val("");
			});
		    //点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadGrade(userId,roleCode);
			});
			//用户ID
			var userId = $("#userTab li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			loadGrade(userId,roleCode);
		   //年级改变对应的班级也会改变
		    $("#gradeList").change(function(){
		    	//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				var gradeId = $("#gradeList").val();
				loadClazzByGradeId(userId,roleCode,gradeId);
			  });
		    //班级改变对应的相册也改变
		    $("#clazzList").change(function(){
		    	//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
		    	var clazzId = $("#clazzList").val();
				loadAllAlbumList(clazzId,userId,roleCode);
			  });
		    var clazzId = $("#clazzList").val();
		    loadAllAlbumList(clazzId,userId,roleCode);
		    $(".modal_all_person").on("click",function(){
				if($(this).hasClass("focus")){
						$(".modal_select_person li").find("em").removeClass("focus");
						$(".modal_select_person li").removeAttr("style");
						$(".modal_all_person").removeClass("focus");
						$(".modal_num").text($(".modal_select_person #selectStudent").find(".focus").size());
					}else{
						$(".modal_all_person").addClass("focus");
						$(".modal_select_person li").find("em").addClass("focus");
						$(".modal_select_person li").css({"border":"1px solid #4e90fe"});
						$(".modal_num").text($(".modal_select_person #selectStudent").find(".focus").size());
				}
			});
		  //点击分享
			$("#sharePhoto").click(function(){
				var isSingle = $("#singleShare").val();
				var photoPath;
				if(isSingle=="true")
				{
					photoPath = $("#photoPath").val();
				}
				else
				{
					$("#photoDetailList li").find(".focus").each(function(m){
						if(m==0)
						{
							photoPath = $(this).attr("attr");
						}else
						{
							photoPath += ","+$(this).attr("attr");
						}
					})
				}

				if(photoPath==undefined || photoPath=="" || photoPath==null)
				{
					layer.msg("至少选择一张照片",{time:3000,icon:5});
					return;
				}
				
				var student = [];
				
				$("#selectStudent li").find(".focus").each(function(n){
					student.push($(this).parent().attr("id").replace("S","")+":"+$(this).parent().find("span").text());
				})
				
				if(student.length==0)
				{
					layer.msg("至少选择一位同学",{time:3000,icon:5});
					return;
				}
				student = student.join(",");
				
				sharePhoto(photoPath,student);
			});
			//点击确定按钮添加相册
			$("#saveAlbum").click(function(){
				var albumName = $("#albumName").val();
				var albumDescription = $("#albumDescription").val();
				var clazzId = $("#clazzList").val();
				var clazzName = $("#clazzList").text();
				if(albumName==''||albumName==null){
					layer.alert('请输入相册名称', {
					    skin: 'layui-layer-lan'
					    ,closeBtn: 0
					  });
				}else{
					addAlbum(albumName,albumDescription,clazzId,clazzName);
				}
			});
			//点击确定按钮删除相册
			$("#deleteAlbum").click(function(){
				var albumId = $("#albumId").val();
				$(".photo_detail").hide();
				$(".photo_list").show();
				deleteAlbumByAlbumId(albumId);
			});
			
			//点击确定按钮添加相册
			$("#uploadPhotoToAlbum").click(function(){
				
				$(".add_photo").eq("0").show();
				$(".add_photo").eq("1").hide();
				var clazzId = $("#clazzList").val();
				loadAlbumList(clazzId);
				loadStudentByClazzId("selectStudentUp");
				$("#static .page2").removeAttr("style")
				;
				$(".modal_page").attr("style","display:none;");
				 $(".modal_num").text(0);
				 
				$("#static").addClass("in");
				$("#static .page1").css({"width":"850px","display":"block"});
				$("#static .page1").parent().css({"min-height":"400px","width":"800px","overflow-y":"auto","overflow-x":"hidden","background":"#fff","padding-top":"0","position":"absolute","left":"50%","top":"150px"});		
				
				$("#phone_up").show();
				$("#phone_share").hide();
				$("#student").val("");
				$(".modal_select_person li").find("em").removeClass("focus");
				$(".modal_select_person li").removeAttr("style");
				$(".modal_all_person").removeClass("focus");
				$(".modal_num").text($(".modal_select_person").find(".focus").size());		
			
			});
			
			//点击确定按钮修改相册
			$("#modifyAlbum").click(function(){
				var albumName = $("#albumNameModify").val();
				var albumDescription = $("#albumDescriptionModify").val();
				var albumId = $("#albumId").val();
				modifyAlbumByAlbumId(albumName,albumDescription,albumId);
			});
			//点击确定按钮删除照片
			$("#deletePhoto").click(function(){
				var photoId = $("#photoId").val();
				//alert(photoId);
				deletePhotoByPhotoId(photoId);
			});
	   });
	  
	//添加相册
		function addAlbum(albumName,albumDescription,clazzId,clazzName)
		{
			$.ajax({
				type: "post",
				async : false,
				url: "<%=basePath%>clazzAlbum/addAlbum.do",
				data:{
						albumName : albumName,
						albumDescription : albumDescription,
						clazzId : clazzId,
						clazzName : clazzName
					},
				success: function(data){
					var album = eval("(" + data + ")");
					if(album.albumId>0)
					{
						var appendHtml = '';
						appendHtml += '<li id="A'+album.albumId+'">';
						appendHtml += '<img src="<%=basePath%>media/image_m/null_img.jpg">';
						appendHtml += '<div class="Actions">';
						appendHtml += '<i class="icon-chevron-down"></i>';
						appendHtml += '<dl class="Actions_ul">';
						appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(3,150,\'A'+album.albumId+'\',\''+album.albumName+'\',\''+album.albumDesc+'\')"><dd>编辑</dd></a>';
						appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(6,100,\'A'+album.albumId+'\')"><dd>删除</dd></a>';
						appendHtml += '</dl>';
						appendHtml += '</div>';
						appendHtml += '<div class="photo_info">';
						appendHtml += '<p class="title">'+ album.albumName +'</p><p>' +album.createTime+ '</p><span>0</span>';
						appendHtml += '</div></li>';
						
		       			$("#albumList").prepend(appendHtml);
		       			
		       			$(".photo_list li img,.photo_list li .photo_info").on("click",function(){
		       				var albumId = $(this).attr("id").replace("A", "");
		    				$(".photo_list").hide();
		    				$(".photo_detail").show();
		    				$(".upload_photo_com").hide();
		       				$("#albumPhotoOne").hide();
		       				$("#albumPhotoTwo").show();
		    				var userId = $("ul li.active").find('a').attr("attr1");
		    				var roleCode = $("ul li.active").find('a').attr("attr2");
		    				loadPhotoDetail(albumId,userId,roleCode);
		    				$("#albumId").val(albumId);
		    			});	
		    			
		       			//autoheight();
		       			$("#albumId").val(album.albumId);
		       			
		       			$("#albumList li").hover(function(){
		    				$(this).find(".Actions").show();
		    				$(this).find(".Actions_ul").hide();
		    				},function(){
		    					$(this).find(".Actions").hide();
						});	

		       			$(".Actions i").click(function(){
		       			  if($(this).parent().find(".Actions_ul dd").hasClass("select"))
			       		  {
		       				$(this).parent().find(".Actions_ul").hide();
		       				$(this).parent().find(".Actions_ul dd").removeAttr("class");
		       			  }else
		       			  {
		    				$(this).parent().find(".Actions_ul").show();
		    				$(this).parent().find(".Actions_ul dd").addClass("select");
		       			  }
		    			})

		    			$(".add_photo").eq("1").show();
						$(".add_photo").eq("0").hide();

					}else
					{
						alert("相册创建失败！");
					}
					
				},
			});
		}
		//修改相册
		function modifyAlbumByAlbumId(albumName,albumDescription,albumId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazzAlbum/modifyAlbumByAlbumId.do",
				data:{
						albumName : albumName,
						albumDescription : albumDescription,
						albumId : albumId
					},
				success: function(data){
					var album = eval("(" + data + ")");
					$("#A"+album.albumId).find(".title").text(albumName);
					var clazzId = $("#clazzList").val();
					var userId = $("ul li.active").find('a').attr("attr1");
					var roleCode = $("ul li.active").find('a').attr("attr2");
					loadAllAlbumList(clazzId,userId,roleCode);
					$("#albumId").val(0);
				},
			});
		}
	  function toAlbum(obj){
		$(obj).parent().find("li").each(function(){
			  $(this).removeClass("active");
		});
	    $(obj).addClass("active");
	    var clazzId = $("#clazzList").val();
		//用户ID
		var userId = $("#userTab li.active").find('a').attr("attr1");
		//角色ID
		var roleCode = $("#userTab li.active").find('a').attr("attr2");
		$(".photo_list").attr("style","display:block;");
	    loadAllAlbumList(clazzId,userId,roleCode);
	  }
	  function toPhoto(obj){
		  $(obj).parent().find("li").each(function(){
			  $(this).removeClass("active");
		  });
		  $(obj).addClass("active");  
	  }
	  //弹框
	  function getid(num,id,path){
		 
// 		  modal-dialog modal-md page page7
		  $(".modal_page,.m_modal_body,#static,.modal-body").removeAttr("style");
		  $(".modal_page,.modal-md").attr("style","display:none;");
		  $(".modal_num").text(0);
// 		   $(".page").removeAttr("style");
// 		   $(".page "+num).show();
		   if(num==1)
			{	
			   $(".page"+num).show();
				var clazzId = $("#clazzList").val();
// 				style="background: white;height: 500px;margin-left: 50px; margin-top: 200px;"
// 				$(".m_modal_body").css({"overflow-y":"auto","overflow-x":"hidden","width":"800px","height":"400px"});
				$(".page"+num).css({"background":"white","overflow-y":"auto","overflow-x":"hidden","width":"800px","height":"400px","margin-left":"60%"});
				loadAlbumList(clazzId);
				loadStudentByClazzId("selectStudentUp");
				$("#phone_up").show();
				$("#phone_share").hide();
				$("#student").val("");
				$(".modal_select_person li").find("em").removeClass("focus");
				$(".modal_select_person li").removeAttr("style");
				$(".modal_all_person").removeClass("focus");
				$(".modal_num").text($(".modal_select_person").find(".focus").size());
				$("#file-list").children().remove(); 
				
				letDivCenter("#static");//
			}else if(num==2)
			{	$(".page "+num).show();
				$(".add_photo").eq("0").show();
				$(".add_photo").eq("1").hide();
				$(".page"+num).show();
				$(".m_modal_body").css({"min-height":id,"width":"400px","height":"250px"});
				letDivCenter("#static");
			}else if(num==3){
				//alert(id);
				$("#albumId").val(id);
				$(".page"+num).show();
// 				$(".m_modal_body").css({"min-height":height,"width":"400px","height":"250px"});
				$(".page"+num).css({"background":"white"});
			}else if(num==4){
				$("#photoId").val(id);
				$(".page"+num).css({"background":"white"});
				$(".page"+num).show();
				$(".m_modal_body").css({"min-height":height,"width":"400px","height":"250px"});
			}else if(num==5){
				$("#photoId").val(id);
				$(".page"+num).show();
				$(".page"+num).css({"background":"white"});
				$(".m_modal_body").css({"min-height":height,"width":"400px","height":"220px"});
			}else if(num==6){
				$("#albumId").val(id);
				$(".page"+num).show();
// 				style="width: 500px; background: white; margin-left: 400px;margin-top: 350px; "
				$(".page"+num).css({"background":"white","overflow-y":"auto","overflow-x":"hidden","width":"800px","height":"250px"});
// 				$(".m_modal_body").css({"min-height":height,"width":"500px","height":"220px","margin-left":"400px"});
			}else if(num==8){
				$(".page"+num).show();
				$(".m_modal_body").css({"min-height":id,"width":"800px","height":"250px"});
				loadStudentByClazzId("selectStudent");
// 				letDivCenter("#static");
				if(path != undefined)
				{
					$("#photoPath").val(path);
					$("#singleShare").val("true");
				}
				
		   }
		}
	  
		 	//删除相册
			function deleteAlbumByAlbumId(albumId)
			{
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/deleteAlbumByAlbumId.do",
					data:{
							albumId : albumId
						},
					success: function(data){
						var flag = eval("(" + data + ")");
						if(flag)
						{
							
							$("#A"+albumId).remove();
							$("#albumId").val(0);
							//autoheight();
						}
					},
				});
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
						}else{
							$("#gradeList").val(gradeId);
						}
		       			$("#gradeList").change();
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
								appendHtml += '<option selected="selected" leaderid="'+value.leaderId+'" value="' + value.id + '">' + value.clazzName + '</option>';
							}else{
								appendHtml += '<option leaderid="'+value.leaderId+'" value="' + value.id + '">' + value.clazzName + '</option>';
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
					}
				});
		}
		//加载所有的相册
		function loadAllAlbumList(clazzId,userId,roleCode)
		{
			$(".photo_list").show();
			$(".photo_detail").hide();
			$("#albumList").show();
			var body = $("#body");
			App.blockUI(body);
			var leaderId = $("#clazzList").find(" option:selected").attr("leaderid");
			var flag = false;
			if(roleCode == "classLeader")
			{
				flag = true;
			}		
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazzAlbum/loadAllAlbumList.do",
				data:{
						clazzId : clazzId
					},
				success: function(data){
					var albumList = $.parseJSON(data);
					var appendHtml = '';
					$.each(albumList, function(n, value) {
						appendHtml += '<li id="A'+value.albumId+'">';
						var albumPath = value.albumPath;
						if(albumPath=="" || albumPath==undefined)
						{
							appendHtml += '<img src="<%=basePath%>assets/global/img/null_img.jpg">';
						}else
						{
							appendHtml += '<img src="'+value.albumPath +'">';
						}
						if(value.createUserId==userId || roleCode=="admin" || roleCode=="chairman" || roleCode=="president" || flag )
						{
							appendHtml += '<div class="Actions">';
							appendHtml += '<i class="icon-chevron-down"></i>';
							appendHtml += '<dl class="Actions_ul">';
							appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(3,\''+value.albumId+'\',\''+value.albumName+'\',\''+value.albumDesc+'\')"><dd>编辑</dd></a>';
// 							appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(6,100,\'A'+value.albumId+'\')"><dd>删除</dd></a>';
							appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(6,\''+value.albumId+'\')"><dd>删除</dd></a>';
							appendHtml += '</dl>';
							appendHtml += '</div>';
						}
						
						appendHtml += '<div class="photo_info">';
						appendHtml += '<p class="title">'+ value.albumName +'</p><p>'+value.createTime+'</p><span>'+value.photoNum+'</span>';
						appendHtml += '</div>';
						appendHtml += '</li>';
	       			}); 
	       			 
	       			$("#albumList").html(appendHtml);
	       			$(".photo_list li img,.photo_list li .photo_info").on("click",function(){
	           			var albumId = $(this).parent().attr("id").replace("A", "");
	       				$(".photo_list").hide();
	       				$(".upload_photo_com").hide();
	       				$(".photo_detail").show();
	       				$("#albumPhotoOne").hide();
	       				$("#albumPhotoTwo").show();
// 	       				var userId = $("ul li.active").find('a').attr("attr1");
	    				var roleCode = $("ul li.active").find('a').attr("attr2");
	    				var userId = $("#userId").val();
	       				loadPhotoDetail(albumId,userId,roleCode);
	       				$("#albumId").val(albumId);
	           			
	       			}),
	       			$("#albumList li").hover(function(){
	    				$(this).find(".Actions").show();
	    				$(this).find(".Actions_ul").hide();
	    				},function(){
	    					$(this).find(".Actions").hide();
					});
	       			$(".Actions i").click(function(){
	       			  if($(this).parent().find(".Actions_ul dd").hasClass("select"))
		       		  {
	       				$(this).parent().find(".Actions_ul").hide();
	       				$(this).parent().find(".Actions_ul dd").removeAttr("class");
	       			  }else
	       			  {
	    				$(this).parent().find(".Actions_ul").show();
	    				$(this).parent().find(".Actions_ul dd").addClass("select");
	       			  }
	    			})	
					//解锁UI
		  			App.unblockUI(body);
				}
			});
			
		}
		//加载所有的相册上传照片时选择使用
		function loadAlbumList(clazzId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazzAlbum/loadAllAlbumList.do",
				data:{
						clazzId : clazzId
					},
				success: function(data){
					var albumList = $.parseJSON(data);
					var appendHtml = '';
					$.each(albumList, function(n, value) {
						if (n == 0){
							appendHtml += '<option selected="selected" value="' + value.albumId + '">' + value.albumName + '</option>';
						}else{
							appendHtml += '<option value="' + value.albumId + '">' + value.albumName + '</option>';
						}
	       			}); 
	       			
	       			$("#albumSelectList").html(appendHtml);
	       			
	       			var albumId = $("#albumId").val();

	      			if (albumId != 0)
					{
						$("#albumSelectList").val(albumId);
					}
				}
			});
			
		}
		//根据相册Id加载所有的照片
		function loadPhotoDetail(albumId,userId,roleCode)
		{
			var leaderId = $("#clazzList").find(" option:selected").attr("leaderid");
			var flag = false
			if(roleCode == "classLeader")
			{
				flag = true;
			}
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazzAlbum/loadPhotoDetailByAlbumId.do",
				data:{
						albumId : albumId
					},
				success: function(data){
					var map = $.parseJSON(data);
					var appendHtml = '';
					var albumHtml ='';
					var album = map.album;
					var albumPath = album.albumPath;
					if(albumPath=="" || albumPath==undefined)
					{
						albumHtml += '<img src="<%=basePath%>media/image_m/null_img.jpg">';
					}else
					{
						albumHtml += '<img src="'+albumPath +'">';
					}
					albumHtml += '<div class="photo_detail_info"><p>';
					albumHtml += '<b>《'+album.albumName+'》</b>相册描述';
					albumHtml += '<i class="icon-chevron-down">';
					albumHtml += '<em class="describe">';
					if(typeof(album.albumDesc)!="undefined"){
					albumHtml += '<b>相册描述：</b>'+album.albumDesc;
					}else{
					albumHtml += '<b>相册描述：</b>';
					}
					albumHtml += '</em></i></p>';
					albumHtml += '<p><b>'+album.createUserName+'</b>于'+album.createTime+'创建</p>';
					albumHtml += '</div>';
					albumHtml += '<a href="#" onclick="exportPhoto('+albumId+',\''+album.albumName+'\')">导出</a>';
					albumHtml += '<a id="uploadPhotos" onclick="getid(1,450)" data-toggle="modal" href="#static">上传照片</a>';
					albumHtml += '<a href="#static" class="select_person" data-toggle="modal" onclick="getid(8,450)">选择分享人</a>';
					albumHtml += '<a id="btn_share">分享</a>';
					albumHtml += '<span class="select_num_photo"><i class="icon-ok"></i>全选 <b>已选择<em>0</em>张</b></span>';
					$.each(map.photoList, function(n, value) {
						appendHtml += '<li id="P'+value.photoId+'">';
						appendHtml += '<div class="click-cover">';
						appendHtml += '<em class="icon-ok" attr="'+value.photoPath+'"></em></div>';
						appendHtml += '<a href="#static" data-toggle="modal" onclick="getDetailPhoto(7,500,'+albumId+','+value.photoId+')">';
						
						appendHtml += '<img src="'+value.photoPath +'">';
						appendHtml += '<p>'+value.photoName+'</p></a>';
						
							appendHtml += '<div class="Actions">';
							appendHtml += '<i class="icon-chevron-down"></i>';
							appendHtml += '<dl class="Actions_ul">';
							if(value.createUserId==userId || roleCode=="admin" || roleCode=="chairman" || roleCode=="president" || flag)
							{
								appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(4,150,\'P'+value.photoId+'\',\''+value.photoName+'\',\''+value.photoDesc+'\')"><dd>编辑</dd></a>';
								appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(5,\''+value.photoId+'\')"><dd>删除</dd></a>';
							}
							appendHtml += '<a href="#static" data-toggle="modal" onclick="getid(8,450,\''+value.photoPath+'\')"><dd>分享</dd></a>';
							appendHtml += '<a href="#" data-toggle="modal" onclick="setCover('+albumId+',\''+value.photoPath+'\')"><dd>设置为封面</dd></a>';
							appendHtml += '</dl>';
							appendHtml += '</div>';
						
						appendHtml += '</li>';
	       			}); 
	       			 
	       			$(".photo_detail_header").html(albumHtml);
	       			$("#photoDetailList").html(appendHtml);
	       			$(".photo_detail li").hover(function(){
	    				$(this).find(".Actions").show();
	    				$(this).find(".Actions_ul").hide();
	    			},function(){
	    				$(this).find(".Actions").hide();
	    			})
					
					$(".Actions i").click(function(){
	       			  if($(this).parent().find(".Actions_ul dd").hasClass("select"))
		       		  {
	       				$(this).parent().find(".Actions_ul").hide();
	       				$(this).parent().find(".Actions_ul dd").removeAttr("class");
	       			  }else
	       			  {
	    				$(this).parent().find(".Actions_ul").show();
	    				$(this).parent().find(".Actions_ul dd").addClass("select");
	       			  }
	    			})

	    			$(".photo_detail_info i").on("click",function(){
						$(".describe").show(500);
					})

					$(".describe").mouseleave(function(){
						$(this).hide(500);
					})
					
					$("#btn_share").on("click",function(){
						var v_var=$(this).text();
						if(v_var=="分享"){
							$("#photoDetailList li").find("em").css({"display":"block"});
							$(".photo_detail_header .select_person,.photo_detail_header .select_num_photo,.click-cover").css({"display":"block"});
							$(this).text("取消分享");
						}else if(v_var=="取消分享"){
							$(this).text("分享");
							$("#photoDetailList li").find("em").removeAttr("style");
							$("#photoDetailList li").find("em").removeClass("focus");
							$("#photoDetailList li").removeAttr("style");
							$(".photo_detail_header .select_person,.photo_detail_header .select_num_photo,.click-cover").removeAttr("style");
						}
						
					})
					
					$(".click-cover").on("click",function(){
						if($(this).find("em").hasClass("focus")){
							$(this).find("em").removeClass("focus");
							$(this).find("em").parent().parent().removeAttr("style");
							$(".select_num_photo em").text($("#photoDetailList").find(".focus").size());
						}else{
							$(this).find("em").addClass("focus");
							$(this).find("em").parent().parent().css({"border":"1px solid #4e90fe"});
							$(".select_num_photo em").text($("#photoDetailList").find(".focus").size());
						}
					})
	       			$(".select_num_photo .icon-ok").on("click",function(){
	           			if($(this).hasClass("focus")){
	               			$(this).removeClass("focus");
							$("#photoDetailList li em").removeClass("focus");
							$("#photoDetailList li em").parent().parent().removeAttr("style"); 
							$(".select_num_photo em").text($("#photoDetailList").find(".focus").size());
	           			}else{
	               			$(this).addClass("focus");
							$("#photoDetailList li em").addClass("focus");
							$("#photoDetailList li em").parent().parent().css({"border":"1px solid #4e90fe"});
							$(".select_num_photo em").text($("#photoDetailList").find(".focus").size());
	               			}
	           			})
				},
			});
			
		}
		/* function close(){
			for(var i=1;i<=8;i++){
				$(".page"+i+"").css({"display":"none"});
			}
		} */
		//点击照片加载对应的评论
		function getDetailPhoto(num,height,albumId,photoId){
			$(".modal_page,.m_modal_body,#static,modal-body").removeAttr("style");
			$(".page"+num).css({"left":'40%'});
			$(".page"+num).css({"width":'1000px'});
			$(".page"+num).css({"padding":'0'});
			$(".photoUl").remove();
			$(".photoLike").remove();
			App.blockUI(body); 
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazzAlbum/getPhotoDetailByAlbumId.do",
				data:{
						albumId : albumId
					},
				success: function(data){
					//解锁UI
	      			App.unblockUI(body);
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
								$(".photo_detail_header1").find('img').attr('src','<%=basePath%>assets/global/img/m_img/head_photo.png');
							}else
							{
								$(".photo_detail_header1").find('img').attr('src','<%=Cons.HEADIMGBASEPATH%>'+map.album.headImg);
							}
							$(".albumName").text(map.album.albumName);
							$(".createUserName").text(map.album.createUserName);
							$(".createTime").text(map.album.createTime);
							
							$.each(map.photoList, function(n, photo) {
								var commentList = photo.commentList;
								var commentMap = photo.commentMap;
								var commentSubMap = photo.commentSubMap;
								var praiseList = photo.praiseList;
								
								appendHtml += '<li id="photo'+photo.photoId+'"><img src="'+photo.photoPath+'"/><span>['+photo.photoName+']</span></li>';
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
										appendHtml_comment += '<dd>';
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
									appendHtml_ul += '<li style="cursor: pointer;" class="m_zan icon-thumbs-up" onclick= "addPhotoPraise('+photo.photoId+')" ><a href="javascript:;">赞</a>(<span id="photoPraiseCount'+photo.photoId+'">0</span>)</li>';
								}
								if(commentList != null){
									
									appendHtml_ul += '<li onclick="textareaFocus()" style="cursor: pointer;" class="m_bbs icon-comment"><a href="javascript:;">评论</a>(<span id="photoCommentCount'+photo.photoId+'">'+commentList.length+'</span>)</li>';
								}else{
									appendHtml_ul += '<li onclick="textareaFocus()" style="cursor: pointer;" class="m_bbs icon-comment"><a href="javascript:;">评论</a>(<span id="photoCommentCount'+photo.photoId+'">0</span>)</li>';
								}
									appendHtml_ul += '<a href="'+photo.photoPath+'?attname='+photo.photoName+'.jpg"><li style="cursor: pointer;" class="icon-download-alt">下载</li><a>';
								appendHtml_ul += '</ul>';
									
							});
							$(".picBox .cf").html(appendHtml);
							$(".listBox .cf").html(appendHtml1);
							$(".show_bbs").html(appendHtml_comment);
							$("#photoTextarea").before(appendHtml_ul);
							$(".show_bbs").before(appendHtml_praise);
							$("#listBox").find("#"+photoId+"").addClass("on");

							/* loadSinglePhotoDetail(photoId); */
							
							loadSinglePhoto($("#photo"+photoId).index());
							//加载点击事件
							$("dl .icon-comment").on("click",function(){
								
								var  photoId = $(this).parents("dl").attr("id").replace("photod", "");
								var commentReplyId = $(this).attr("attr1");
								var parentId = $(this).attr("attr2");
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
				}
			});
			
			/*num：page,height：弹窗高,id*/
			$(".page"+num+"").show();
			$(".page"+num+"").siblings().hide();
			$(".modal-body").css({"min-height":height});
			letDivCenter("#static");
		}

		function loadSinglePhoto(index)
		{

	        var oPicLi = $("#picBox").find("li");
	        var oListLi = $("#listBox").find("li");
	        var len1 = oPicLi.length;
	        var len2 = oListLi.length;

	        var oPicUl = $("#picBox").find("ul")[0];
	        var oListUl = $("#listBox").find("ul")[0];

	        var w1 = 600;
	        var w2 = 80;
	        

	        oPicUl.style.width = w1 * len1 + "px";
	        oListUl.style.width = w2 * len2 + "px";

	        oPicUl.style.left = (- index * w1) + "px";
			oListUl.style.left = (- index * w2) + "px";

	        var num = 5;
	        var num2 = Math.ceil(num / 2);

	        Change(oPicUl,index,num2,oListUl,len2,oListLi,w1,w2,num);
	        
	        $("#nextTop").on("click",function(){
	            index ++;
	            index = index == len2 ? 0 : index;
	            Change(oPicUl,index,num2,oListUl,len2,oListLi,w1,w2,num);
	        });
	        $("#next").on("click",function(){
	            index ++;
	            index = index == len2 ? 0 : index;
	            Change(oPicUl,index,num2,oListUl,len2,oListLi,w1,w2,num);
	        });
	        $("#prevTop").on("click",function(){
	            index --;
	            index = index == -1 ? len2 -1 : index;
	            Change(oPicUl,index,num2,oListUl,len2,oListLi,w1,w2,num);
	        });

	        $("#prev").on("click",function(){
	            index --;
	            index = index == -1 ? len2 -1 : index;
	            Change(oPicUl,index,num2,oListUl,len2,oListLi,w1,w2,num);
	        });
	        
	        for (var i = 0; i < len2; i++) {
	            oListLi[i].index = i;
	            oListLi[i].onclick = function(){
	                index = this.index;
	                Change(oPicUl,index,num2,oListUl,len2,oListLi,w1,w2,num);
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
		 function Change(oPicUl,index,num2,oListUl,len2,oListLi,w1,w2,num) {
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

		    function shareCancel()
		    {
		    	$("#phone_up").show();
				$("#phone_share").hide();
		    }

		    function shareConfirm()
		    {
		    	var student = [];
				$("#selectStudentUp li").find(".focus").each(function(n){
					student.push($(this).parent().attr("id").replace("S","")+":"+$(this).parent().find("span").text());
				})
				var s = JSON.stringify(student)
				$("#student").val(student);
				$("#phone_up").show();
				$("#phone_share").hide();
		    }

			//点击评论  评论输入框获取焦点
			function textareaFocus(){
				$("#photoTextarea").focus();
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
			
			//导出照片
			function exportPhoto(albumId,albumName)
			{
				var body = $("#body");
				App.blockUI(body);
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/exportPhotoByAlbumId.do",
					data:{
							albumId : albumId,
							albumName : albumName
						},
					success: function(data){
						var fileName = eval("(" + data + ")");
						var downPath = "<%=basePath%>"+fileName;
						$("#download").attr("href",downPath);
						//模拟点击a标签
						$("#span").click();
						//解锁UI
		      			App.unblockUI(body);
		      			//解锁之后删除zip包
		      			deleteZipFile(albumName+".zip");
		      			
					},
				});
			}

			//上传照片后点击确定按钮修改照片信息
			function savePhoto(photoUpName,photoUpDesc,albumIdUp,recordsId)
			{
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/savePhotoByRecordsId.do",
					data:{
							photoUpName : photoUpName,
							photoUpDesc : photoUpDesc,
							albumIdUp : albumIdUp,
							recordsId : recordsId
						},
					success: function(data){
						$(".photo_list").hide();
						$(".photo_detail").show();
		   				$("#albumPhotoOne").hide();
		   				$("#albumPhotoTwo").show();
						$(".upload_photo_com").hide();
						var userId = $("ul li.active").find('a').attr("attr1");
						var roleCode = $("ul li.active").find('a').attr("attr2");
						loadPhotoDetail(albumIdUp,userId,roleCode);
						$("#albumId").val(albumIdUp);
					},
				});
				//autoheight();
			}
				
			//修改照片
			function modifyPhotoByPhotoId(photoName,photoDesc,photoId)
			{
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/modifyPhotoByPhotoId.do",
					data:{
							photoName : photoName,
							photoDesc : photoDesc,
							photoId : photoId
						},
					success: function(data){
						var albumId = $("#albumId").val();
						//用户ID
						var userId = $("#userTab li.active").find('a').attr("attr1");
						//角色ID
						var roleCode = $("#userTab li.active").find('a').attr("attr2");
						loadPhotoDetail(albumId,userId,roleCode);
						$("#photoId").val(0);
					},
				});
			}

			//删除照片
			function deletePhotoByPhotoId(photoId)
			{
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/deletePhotoByPhotoId.do",
					data:{
							photoId : photoId
						},
					success: function(data){
						var flag = eval("(" + data + ")");
						if(flag)
						{
							$("#P"+photoId).remove();
							$("#photoId").val(0);
						}
					},
				});
			}

			//设置相册封面
			function setCover(albumId,photoPath)
			{
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/setAlbumCover.do",
					data:{
							albumId : albumId,
							albumPath : photoPath
						},
					success: function(data){
						var result= eval("(" + data + ")");
						if(result)
						{
							alert("相册封面设置成功！");
							$("#"+albumId).find('img').attr('src',photoPath);
							$(".photo_detail_header").find('img').attr('src',photoPath);
						}
					},
				});
			}
			//进入照片页面
			function toPhoto()
			{
				var gradeId = $("#gradeList").val();
				var clazzId = $("#clazzList").val();
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>clazzPhoto/toPhoto.do',{gradeId:gradeId,clazzId:clazzId,roleCode:roleCode});
			}

			//删除项目下压缩的包
			function deleteZipFile(fileName)
			{
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/deleteZipFile.do",
					data:{
							fileName : fileName
						},
					success: function(data){
					},
				});
			}

			
			//分享照片到个人相册
			function sharePhoto(photoPath,student)
			{
				$.ajax({
					type: "post",
					url: "<%=basePath%>clazzAlbum/sharePhoto.do",
					data:{
							photoPath : photoPath,
							student : student
						},
					success: function(data){
						var flag = eval("(" + data + ")");
						if(flag)
						{
							layer.msg("照片分享成功！",{time:1000,icon:1});
		                    $(".modal_num").text(0);					
							var albumId = $("#albumId").val();
							var userId = $("ul li.active").find('a').attr("attr1");
							var roleCode = $("ul li.active").find('a').attr("attr2");
							loadPhotoDetail(albumId,userId,roleCode);
						}
					},
				});
				
			}
			//根据userId roleCode gradeId加载学生
			function loadStudentByClazzId(selectStudentId)
			{
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				var clazzId = $("#clazzList").val();
				$.ajax({
					type: "post",
					async : false,
					url: "<%=basePath%>baseData/loadStudentByClazzId.do",
					data:{
							userId : userId,
							roleCode : roleCode,
							clazzId : clazzId
						},
					success: function(data){
						var studentList = eval("(" + data + ")");
						var appendHtml = '';
						$.each(studentList, function(n, value) {
							appendHtml += '<li id="S'+value.userId+'">';
							appendHtml += '<em class="icon-ok"></em>';
							appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
							appendHtml += '<span>'+value.realName+'</span>';
							appendHtml += '</li>';
		       			});  
		       			$("#"+selectStudentId).html(appendHtml);
		       			//选择分享人员
		    			$(".modal_select_person li").on("click",function(){
		    				if($(this).find("em").hasClass("focus")){
		    					$(this).find("em").removeClass("focus");
		    					$(this).removeAttr("style");
		    					$(".modal_num").text($(".modal_select_person").find(".focus").size());
		    				}else{
		    					$(this).find("em").addClass("focus");
		    					$(this).css({"border":"1px solid #4e90fe"});
		    					$(".modal_num").text($(".modal_select_person").find(".focus").size());
		    				}
		    			});
					},
				});
			}

    </script>
</html>