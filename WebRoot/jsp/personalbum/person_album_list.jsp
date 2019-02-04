<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>个人相册</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
	<link href="<%=basePath %>assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>assets/global/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" />
 	<!--公共css结束-->  
 	<style type="text/css">
 		.prev a,.next a{
 		    background:transparent !important;
 		    font-size:34px;
 		    color:#fff;
 		    margin-top:25px;
 		}
 	</style>      
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
	<a href="" id="download" style="display: none"><span id="span">download</span></a>
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
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">班级相册</a><i class="fa fa-circle"></i></li>
	                        <li><span>班级相册</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">班级相册</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0 tabbable tabbable-tabdrop">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs" id="userTab">
									<c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi" id="${roleList.roleCode}">
											<a href="#tab_4" data-toggle="tab" class="roleTab"  attr1="${sessionScope.user.userId}" 
												attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})</a>
										</li>
									</c:forEach>
										<input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}"/>	
										<input type="hidden" name="realName" id="realName" value="${sessionScope.user.realName}"/>
										<input type="hidden" name="schoolId" id="schoolId" value="${sessionScope.user.schoolId}"/>	
										<input type="hidden" name="prefix" id="prefix" value="person"/>
								</ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small" onclick="getid(1)">上传照片</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small" onclick="getid(2)">创建相册</button>
	                        	<button data-toggle="modal" href="#small" class="btn btn-default" type="button" onclick="getid(9);">导出</button>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box" style="display: none;">
	                       	<form action="#" class="form-horizontal">
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择年级：</span>
	                         		<select class="form-control m_select" id="gradeList">
                                        <option>选择年级</option>
                                    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15" >
	                         		<span class="m_span">选择班级：</span>
	                         		<select class="form-control m_select" id="clazzList">
                                        <option>选择班级</option>
                                    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		  <button type="submit" class="btn green">搜索</button>
	                         	</div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>班级相册</div>
	                            </div>
	                            <div class="portlet-body flip-scroll" style="padding:5px;">
	                                <div class="row" id="albumList">
	                                	</div>
	                                </div>
									<div class="photo_detail">
										<div class="photo_detail_header" style="height: 50px;">
                                        </div>
										<ul id="photoDetailList">
										</ul>
									</div>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                        <!-- 分页开始 -->
	                        <%@include file="/public_module/public_page.jsp" %>
	                        <!-- 分页结束 -->
	                    </div>
	                </div>
	                </div>
	                <!--页面内容结束 -->
	            </div>
	        </div>
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
<%--     <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-ui.js" type="text/javascript"></script> --%>
    <script src="<%=basePath %>assets/pages/scripts/form-fileupload.min.js" type="text/javascript"></script>
    
    
    <script src="<%=basePath%>assets/global/plugins/album/scripts/moxie.js" type="text/javascript" ></script>
    <script src="<%=basePath%>assets/global/plugins/album/scripts/plupload.dev.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/zh_CN.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/ui.js" type="text/javascript" ></script> 
    <script src="<%=basePath%>assets/global/plugins/album/scripts/qiniu.js" type="text/javascript" ></script>
    <script src="<%=basePath%>assets/global/plugins/album/scripts/highlight.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/main_person.js" type="text/javascript"></script>
	
    
    <div class="modal fade bs-modal-lg" id="small" tabindex="-1" role="dialog" aria-hidden="true">
    		<div class="page page1">
	          <div class="modal-dialog modal-lg">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">上传照片</h4>
	                  </div>
	                  <div class="modal-body form-horizontal m_img_upload">
	                  		<div class="form-group">
                                   <label class="control-label col-md-2">上传到</label>
                                   <div class="col-md-5">
<!--                                     class="bs-select form-control" data-live-search="true" data-size="8" -->
                                       <select class="public_input_s"  id="albumSelectList" name="albumSelect">
                                        </select>
                                   </div>
                               </div>
               					<div class="form-group">
                                   	<div class="m_padding_0_15">
                                   		<form id="fileupload" action="" method="POST" enctype="multipart/form-data">
		                                <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
		                                <div class="row fileupload-buttonbar">
		                                    <div class="col-lg-7" id="container">
		                                        <!-- The fileinput-button span is used to style the file input field as button -->
		                                        <span class="btn green fileinput-button" id="pickfiles">
		                                            <i class="fa fa-plus"></i>
		                                            <span>选择图片</span>
		                                            <input type="file" name="files[]" multiple=""> </span>
		                                        <button type="submit" class="btn blue start">
		                                            <i class="fa fa-upload"></i>
		                                            <span>开始上传</span>
		                                        </button>
		                                        <button type="reset" class="btn warning cancel">
		                                            <i class="fa fa-ban-circle"></i>
		                                            <span>取消上传</span>
		                                        </button>
		                                        <button type="button" class="btn red delete">
		                                            <i class="fa fa-trash"></i>
		                                            <span>删除</span>
		                                        </button>
		                                        <input type="checkbox" class="toggle">
		                                        <!-- The global file processing state -->
		                                        <span class="fileupload-process"> </span>
		                                    </div>
		                                    <!-- The global progress information -->
		                                    <div class="col-lg-5 fileupload-progress fade">
		                                        <!-- The global progress bar -->
		                                        <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
		                                            <div class="progress-bar progress-bar-success" style="width:0%;"> </div>
		                                        </div>
		                                        <!-- The extended global progress information -->
		                                        <div class="progress-extended"> &nbsp; </div>
		                                    </div>
		                                </div>
		                                <div id="file-list"></div>
		                                <!-- The table listing the files available for upload/download -->
<!-- 		                                <table role="presentation" class="table table-striped clearfix"> -->
<!-- 		                                    <tbody class="files"> </tbody> -->
<!-- 		                                </table> -->
		                                <input id="domain" type="hidden" value="<%=Cons.QINIU_URL_CLASSALBUM%>">
			                            <input id="basePath" type="hidden" value="<%=basePath%>personAlbum/uploadPersonPhoto.do">
			                            <input id="uptoken_url" type="hidden" value="<%=basePath%>clazzAlbum/getUpTokenInJS.do">
		                            </form>
                                   	</div>
				                    <script id="template-upload" type="text/x-tmpl"> 
									</script>
                  						<script id="template-download" type="text/x-tmpl"></script>
                                 </div>
	                  </div>
	                  <div class="modal-body form-horizontal m_img_share">
                			<div class="alert alert-success m_margin_10_auto m_text_align_conter">
                               <ul class="fa-ul">
                                   <li><i class="fa fa-warning fa-lg fa-li"></i>您已成功上传<em id="photoNum"></em>张照片</li>
                               </ul>
                           </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" class="btn green m_btn_upload" id="upload">上传</button>
	                      <button type="button" data-dismiss="modal" class="btn green m_btn_share">查看相册</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
          <div class="page page2">
	          <div class="modal-dialog modal-md">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">创建相册</h4>
	                  </div>
	                  <div class="modal-body form-horizontal">
	                  		<div class="form-group">
                                <label class="col-md-3 control-label">相册名称</label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" placeholder="Enter text" name="albumName" id="albumName">
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  		<div class="form-group">
                                <label class="col-md-3 control-label" >相册描述</label>
                                <div class="col-md-8">
                                    <textarea class="form-control" rows="3" name="albumDescription" id="albumDescription"></textarea>
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" id="saveAlbum">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                      <input type="text" style="display: none;" id="saButron" value="0" />
	                  </div>
	              </div>
	          </div>
          </div>
<!--           33 -->
          <div class="page page3">
	          <div class="modal-dialog modal-md">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">编辑相册</h4>
	                  </div>
	                  <div class="modal-body form-horizontal">
	                  		<div class="form-group">
                                <label class="col-md-3 control-label">相册名称</label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" placeholder="Enter text" name="albumName" id="albumNameModify">
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  		<div class="form-group">
                                <label class="col-md-3 control-label">相册描述</label>
                                <div class="col-md-8">
                                    <textarea class="form-control" rows="3" name="albumDescription" id="albumDescriptionModify"></textarea>
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" id="modifyAlbum">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
          <div class="page page13">
	          <div class="modal-dialog modal-md">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">编辑照片</h4>
	                  </div>
	                  <div class="modal-body form-horizontal">
	                  		<div class="form-group">
                                <label class="col-md-3 control-label">照片名称</label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" placeholder="Enter text" name="albumName" id="albumNameModify">
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  		<div class="form-group">
                                <label class="col-md-3 control-label">照片描述</label>
                                <div class="col-md-8">
                                    <textarea class="form-control" rows="3" name="albumDescription" id="albumDescriptionModify"></textarea>
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" id="modifyPhoto">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
          <div class="page page4">
	          <div class="modal-dialog modal-md">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">删除相册</h4>
	                  </div>
	                  <div class="modal-body">
	                  		<div class="alert alert-danger m_margin_10_auto m_text_align_conter">
                                <ul class="fa-ul">
                                    <li><i class="fa fa-warning fa-lg fa-li"></i>确定删除本相册，并清空里面的所有照片?</li>
                                </ul>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" id="deleteAlbum">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
          <div class="page page5">
	          <div class="modal-dialog modal-sm">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">设定为封面</h4>
	                  </div>
	                  <div class="modal-body">
	                  		<div class="alert alert-success m_margin_10_auto m_text_align_conter">
                                <ul class="fa-ul">
                                    <li><i class="fa fa-warning fa-lg fa-li"></i>相册封面设定成功</li>
                                </ul>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" >确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
          <div class="page page14">
	          <div class="modal-dialog modal-md">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">删除照片</h4>
	                  </div>
	                  <div class="modal-body">
	                  		<div class="alert alert-danger m_margin_10_auto m_text_align_conter">
                                <ul class="fa-ul">
                                    <li><i class="fa fa-warning fa-lg fa-li"></i>确定删除照片?</li>
                                </ul>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" id="deletePhoto">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
          <div class="page page8">
	          <div class="modal-dialog modal-md">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">删除照片</h4>
	                  </div>
	                  <div class="modal-body">
	                  		<div class="alert alert-danger m_margin_10_auto m_text_align_conter">
                                <ul class="fa-ul">
                                    <li><i class="fa fa-warning fa-lg fa-li"></i>确定删除照片?</li>
                                </ul>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" id="deletePhoto">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
        
          <div class="page page6">
	          <div class="modal-dialog modal-lg">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">我的相册</h4>
	                  </div>
	                  <div class="modal-body m_overflow_hidden">
	                  		<div class="col-md-12 col-sm-12">
	                  			<div class="v_out v_out_p">
									<div class="prev"><a href="javascript:void(0)" class="fa fa-angle-left"></a></div>
								    <div class="v_show">
										<div class="v_cont" >
											<ul id="myPhotos">
<!-- 												<li index="0" style="background:#f00"> -->
<!-- 													<img src="http://pan.xici.com/group5/M03/9E/13/rBABqVg_5cqEZ3adAAAAANMbF4o214.jpg/640"> -->
<!-- 												</li> -->
<!-- 												<li index="1"   >[第2个] </li> -->
<!-- 												<li index="2" style="background:#f0f">[第3个]</li> -->
<!-- 												<li index="3" style="background:#999">[第4个]</li> -->
<!-- 												<li index="4" style="background:#666">[第5个]</li> -->
											</ul>
										</div>
									</div>
								    <div class="next"><a href="javascript:void(0)" class="fa fa-angle-right"></a></div>
								</div>
	                              <div class="listBox">
								<ul class="circle" id="myPhotos1">
<!-- 										<li class="circle-cur">1</li> -->
<!-- 										<li>2</li> -->
<!-- 										<li>3</li> -->
<!-- 										<li>4</li> -->
<!-- 										<li>5</li> -->
									</ul>
	                           </div>
	                  		</div>
	                  		
	                  </div>
	              </div>
	          </div>
          </div>
              <div class="page page9">
	          <div class="modal-dialog modal-md">
	              <div class="modal-content">
	                  <div class="modal-header">
	                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                      <h4 class="modal-title">导出</h4>
	                  </div>
	                  <div class="modal-body">
	                  		<div class="form-group">
                                   <label class="control-label col-md-2">选择相册</label>
                                   <div class="col-md-5">
<!--                                     class="bs-select form-control" data-live-search="true" data-size="8" -->
                                       <select class="form-control m_select"  id="exportAlbumSelectList" name="exportAlbumSelect">
                                        </select>
                                   </div>
                               </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green" onclick="getExportValue();">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
          
      </div>
    <script type="text/javascript">
	  $(function(){
	   //图片展示播放页面 点击加载下一个图片
		  $(".next a").click(function() {
				nextscroll();
			});

			function nextscroll() {
				var vcon = $(".v_cont ");
				var offset = ($(".v_cont li").width()) * -1;
				vcon.stop().animate({
					top: offset
				}, "slow", function() {
					var firstItem = $(".v_cont ul li").first();
					vcon.find("ul").append(firstItem);
					$(this).css("top", "0px");
					circle()
				})
			};
			function circle() {
				var currentItem = $(".v_cont ul li").first();
				var currentIndex = currentItem.attr("index");
				$(".circle li").removeClass("circle-cur");
				$(".circle li").eq(currentIndex).addClass("circle-cur")
			}
	          //图片展示播放页面 点击加载上一个图片
			$(".prev a").click(function() {
				var vcon = $(".v_cont ");
				var offset = ($(".v_cont li").width() * -1);
				var lastItem = $(".v_cont ul li").last();
				vcon.find("ul").prepend(lastItem);
				vcon.css("top", offset);
				vcon.animate({
					top: "0px"
				}, "slow", function() {
					circle()
				})
			});
			var animateEnd = 1;
	        
			$(".circle li").click(function() {
				if (animateEnd == 0) {
					return
				}
				$(this).addClass("circle-cur").siblings().removeClass("circle-cur");
	            
				var nextindex = $(this).index();
				var currentindex = $(".v_cont li").first().attr("index");
				var curr = $(".v_cont li").first().clone();
				if (nextindex > currentindex) {
					for (var i = 0; i < nextindex - currentindex; i++) {
						var firstItem = $(".v_cont li").first();
						$(".v_cont ul").append(firstItem)
					}
					$(".v_cont ul").prepend(curr);
					var offset = ($(".v_cont li").width()) * -1;
					if (animateEnd == 1) {
						animateEnd = 0;
						$(".v_cont").stop().animate({
							top: offset
						}, "slow", function() {
							$(".v_cont ul li").first().remove();
							$(".v_cont").css("top", "0px");
							animateEnd = 1
						})
					}
				} else {
					var curt = $(".v_cont li").last().clone();
					for (var i = 0; i < currentindex - nextindex; i++) {
						var lastItem = $(".v_cont li").last();
						$(".v_cont ul").prepend(lastItem)
					}
					$(".v_cont ul").append(curt);
					var offset = ($(".v_cont li").width()) * -1;
					$(".v_cont").css("top", offset);
					if (animateEnd == 1) {
						animateEnd = 0;
						$(".v_cont").stop().animate({
							top: "0px"
						}, "slow", function() {
							$(".v_cont ul li").last().remove();
							animateEnd = 1
						})
					}
				}
			})
	      loadSubMenu("clazzPhotoAlbumManager"); 
		  //选取当前菜单位置
		  setActive("clazzPhotoAlbumManager","selfPhotoAlbum"); 
		  $(document).ready(function() {

			  $(".album_list").hover(function(){
					$(this).find(".actions").show(100);
				  },function(){
					$(this).find(".actions").hide(100);
			   });
            });

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
			})
			   //点击tab页加载
			$("#roleTab li a").click(function(){
				$("#roleTab li").removeAttr("class");
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
			loadAllAlbumList(userId);
			
			//点击确定按钮修改相册
			$("#modifyAlbum").click(function(){
				var albumName = $("#albumNameModify").val();
				var albumDescription = $("#albumDescriptionModify").val();
				var albumId = $("#saButron").val();
				modifyAlbumByAlbumId(albumName,albumDescription,albumId);
			});
			//点击确定按钮添加相册
			$("#saveAlbum").click(function(){
				var albumName = $("#albumName").val();
				var albumDescription = $("#albumDescription").val();
// 				var userId = $("ul li.active").find('a').attr("attr1");
				var realName = $("#realName").val();
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
// 				if(roleCode=="parent")
// 				{
// 					userId = $("#studentList").val();
// 					realName = $("#studentList").text();
// 				}
// 				addPersonAlbum(albumName,albumDescription,userId,realName);
// 				$(".add_photo").eq("1").show();
// 				$(".add_photo").eq("0").hide();
			});
			
			//点击确定按钮删除照片
			$("#deletePhoto").click(function(){
				var photoId = $("#saButron").val();
				deletePhotoByPhotoId(photoId);
			});
			//点击确定按钮修改照片
			$("#modifyPhoto").click(function(){
				var photoName = $("#photoName").val();
				var photoDesc = $("#photoDesc").val();
				var photoId = $("#saButron").val();
				modifyPhotoByPhotoId(photoName,photoDesc,photoId);
			});
			
			//点击确定按钮删除相册
			$("#deleteAlbum").click(function(){
				var albumId = $("#saButron").val();
				$(".photo_detail").hide();
				$(".photo_list").show();
				deleteAlbumByAlbumId(albumId);
			});

			
			
	   })
	   function getid(num,id){
		   $(".page").removeAttr("style");
		   $(".page"+num).show();
		   $("#saButron").val(id);
		   if(num == 6){
			   loadPersonPhotoDetail(id);
		   }else if(num==3){
			   $("#saButron").val(id);
		   }else if(num==4){
			  
			   $("#saButron").val(id);
		   } else if(num==14){
			   $("#saButron").val(id.replace("P",""));
		   }
	   $(".listBox ul li").removeClass("circle-cur");
	   $(".listBox ul li:eq(0)").addClass("circle-cur");
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
		       			$("#gradeList").change();
					},
				});

				loadClazzByGradeId(userId,roleCode,gradeId);
		}
		  
		//加载所有的相册
		function loadAllAlbumList(userId)
		{
// 			var body = $("#body");
// 			App.blockUI(body);
			$.ajax({
				type: "post",
				async : false,
				url: "<%=basePath%>personAlbum/loadAllPersonAlbumList.do",
				data:{
					userId : userId
					},
				success: function(data){
					var albumList = $.parseJSON(data);
					var appendHtml = '';
					var ablumHtml = '';
					$.each(albumList, function(n, value) {
						appendHtml += '<div class="col-md-3 col-sm-3 album_list">';
						var albumPath = value.albumPath;
						var albumName = value.albumName;
						if(albumName=="" || albumName==undefined ||albumName==null){
							albumName='';
						}
						if(albumPath=="" || albumPath==undefined)
						{
							appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/null_img.jpg">';
						}else
						{
							appendHtml += '<img  onclick="loadPersonPhotoDetail('+value.albumId+')" src="'+value.albumPath +'">';
						}
						appendHtml += '<div class="photo_info">';
						appendHtml += '<p class="title">'+ value.albumName +'</p><p>'+value.createTime+'</p><span>'+value.photoNum+'</span>';
						appendHtml += '</div>'
						appendHtml += '<div class="actions">';
						appendHtml += '<i class="fa fa-angle-down"></i>';
						appendHtml += '<ul id="albumList"></ul>'
						appendHtml += '<ul>';
						appendHtml += '<li data-toggle="modal" href="#small" onclick="getid(3,'+value.albumId+')">编辑</li>';
						appendHtml += '<li data-toggle="modal" href="#small" onclick="getid(4,'+value.albumId+')">删除</li>';
//  						appendHtml += '<li data-toggle="modal" href="#small" onclick="getid(5,'+value.albumId+')">封面</li>';
						appendHtml += '<ul/>';
						appendHtml += '</div>';
						appendHtml += '</div>';
						ablumHtml += '<option  value="' + value.albumId + '">' + albumName + '</option>';
	       			}); 
	       			 
	       			$("#albumSelectList").html(ablumHtml);
	       			$("#exportAlbumSelectList").html(ablumHtml);
	       			$("#albumList").html(appendHtml);
// 	       			autoheight();
// 	       			$(".photo_list li img,.photo_list li .photo_info").on("click",function(){
// 	           			var albumId = $(this).parent().attr("id").replace("A", "");
// 	       				$(".photo_list").hide();
// 	       				$(".photo_detail").show();
// 	    				loadPersonPhotoDetail(albumId);
// 	       				$("#albumId").val(albumId);
	           			
// 	       			}),
	       			
// 	       			$("#albumList li").hover(function(){
// 	    				$(this).find(".Actions").show();
// 	    				$(this).find(".Actions_ul").hide();
// 	    				},function(){
// 	    					$(this).find(".Actions").hide();
// 					});

// 	       			$(".Actions i").click(function(){
// 	       			  if($(this).parent().find(".Actions_ul dd").hasClass("select"))
// 		       		  {
// 	       				$(this).parent().find(".Actions_ul").hide();
// 	       				$(this).parent().find(".Actions_ul dd").removeAttr("class");
// 	       			  }else
// 	       			  {
// 	    				$(this).parent().find(".Actions_ul").show();
// 	    				$(this).parent().find(".Actions_ul dd").addClass("select");
// 	       			  }
// 	    			})	
					//解锁UI
// 		  			App.unblockUI(body);
				},
			});
			
		}
		
		//修改相册
		function modifyAlbumByAlbumId(albumName,albumDescription,albumId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/modifyPersonAlbumByAlbumId.do",
				data:{
						albumName : albumName,
						albumDescription : albumDescription,
						albumId : albumId
					},
				success: function(data){
					var album = eval("(" + data + ")");
// 					$("#A"+album.albumId).find(".title").text(albumName);
// 					var userId = $("ul li.active").find('a').attr("attr1");
					var userId = $("#userTab li.active").find('a').attr("attr1");
// 					var roleCode = $("ul li.active").find('a').attr("attr2");
// 					if(roleCode=="parent")
// 					{
// 						$("#studentDiv").show();
// 						userId = $("#studentList").val();
// 					}
					loadAllAlbumList(userId);
// 					$("#albumId").val(0);
				},
			});
		}
		
		//点击照片进入浏览状态
		function getDetailPhoto(){
// 			$(".PAGE7").PARENT().PARENT().CSS({"WIDTH":"750PX","MARGIN-LEFT":"-496PX"});
// 			$(".PHOTOUL").REMOVE();
// 			$(".PHOTOLIKE").REMOVE();
// 			APP.BLOCKUI(BODY); 
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/loadPhotoDetailByAlbumId.do",
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
							
							$.each(map.photoList, function(n, photo) {
								
								appendHtml += '<li id="photo'+photo.photoId+'"><img src="'+photo.photoPath+'"/><span>['+photo.photoName+']</span></li>';
								if(n == 0){
									appendHtml1 += '<li class="arr2" id="'+photo.photoId+'"><img src="'+photo.photoPath+'"/></li>';
								}else{
									appendHtml1 += '<li class="arr2" id="'+photo.photoId+'"><img src="'+photo.photoPath+'"/></li>';
								}
									
							});
							
							$(".picBox .cf").html(appendHtml);
							$(".listBox .cf").html(appendHtml1);

							$("#listBox").find("#"+photoId+"").addClass("on");
							
							loadSinglePhoto($("#photo"+photoId).index());

						}else{
							$(".picBox .cf").html("");
							$(".listBox .cf").html("");
						}
					}else{
						$(".picBox .cf").html("");
						$(".listBox .cf").html("");
					}
				},
			});
			
			/*num：page,height：弹窗高,id*/
			$(".page"+num+"").show();
			$(".page"+num+"").siblings().hide();
			$(".modal-body").css({"min-height":height});
			letDivCenter("#static");
		}
		
		//根据相册Id加载所有的照片
		function loadPersonPhotoDetail(albumId)
		{
			$.ajax({
				type: "post",
				async : false,
				url: "<%=basePath%>personAlbum/loadPhotoDetailByAlbumId.do",
				data:{
						albumId : albumId
					},
				success: function(data){
					var map = $.parseJSON(data);
					var appendHtml1 = '';
					var appendHtml = '';
					var albumHtml1 ='';
					var albumHtml ='';
					var album = map.album;
					var albumPath = album.albumPath;
					if(albumPath=="" || albumPath==undefined)
					{
						albumHtml += '<img src="<%=basePath%>assets/global/img/m_img/null_img.jpg">';
					}else
					{
						albumHtml += '<img src="'+albumPath +'">';
					}
					albumHtml += '<div class="photo_detail_info"><p>';
					albumHtml += '<b style="color: rgb(23, 142, 242);margin: 0px  -1px;">《 '+album.albumName+' 》</b>';
					albumHtml += '<i class="icon-chevron-down">';
					albumHtml += '<em class="describe">';
					if(typeof(album.albumDesc)!="undefined"){
						albumHtml += '<b>相册描述</b>'+album.albumDesc;
					}else{
						albumHtml += '<b>相册描述</b>';
						}
					
					albumHtml += '</em></i></p>';
					albumHtml += '<p>'+album.createTime+'创建</p>';
					albumHtml += '</div>';
					/* albumHtml += '<a href="#" onclick="exportPhoto('+albumId+',\''+album.albumName+'\')">导出</a>'; */
					$.each(map.photoList, function(n, value) {
						appendHtml += '<li id="P'+value.photoId+'">';

						appendHtml += '<a href="#small" data-toggle="modal" onclick="getid(6,'+albumId+')">';

						appendHtml += '<img src="'+value.photoPath +'">';
						appendHtml += '<p>'+value.photoName+'</p></a>';
						appendHtml += '<div class="actions">';
						appendHtml += '<i class="fa fa-angle-down"></i>';
						/* appendHtml += '<ul>';
						appendHtml += '<li data-toggle="modal" href="#small" onclick="getid(13,'+value.photoId+')">编辑</li>';
						appendHtml += '<li data-toggle="modal" href="#small" onclick="getid(14,'+value.photoId+')">删除</li>';
						appendHtml += '<li data-toggle="modal" href="#" onclick="setCover('+albumId+',\''+value.photoPath+'\')">设置为封面</li>';
						appendHtml += '<ul/>'; */
						appendHtml += '<dl class="Actions_ul" style="display: none;">';
 						appendHtml += '<a href="#small" data-toggle="modal" onclick="getid(13,\'P'+value.photoId+'\',\''+value.photoName+'\',\''+value.photoDesc+'\')"><dd>编辑</dd></a>';
						appendHtml += '<a href="#small" data-toggle="modal" onclick="getid(14,\'P'+value.photoId+'\')"><dd>删除</dd></a>';
 						appendHtml += '<a href="#small" data-toggle="modal" onclick="setCover('+albumId+',\''+value.photoPath+'\')"><dd>设置为封面</dd></a>';
						appendHtml += '</dl>';
						
						appendHtml += '</div>';
						appendHtml += '</li>';
						<%--弹出框 --%>
						appendHtml1 += '<li index="'+n+'" >';    
						appendHtml1 += '<img src="'+value.photoPath +'">';
						appendHtml1 += '</li>';
						
						albumHtml1 += '<li class="circle-cur">';
	                    albumHtml1 += '<img src="'+value.photoPath +'"/>';
	                    albumHtml1+='</li>';
	       			}); 
	       			 
	       			$(".photo_detail_header").html(albumHtml);
	       			$("#photoDetailList").html(appendHtml);
	       			$("#myPhotos").html(appendHtml1);
	       			 $("#myPhotos1").html(albumHtml1);
// 	       			autoheight();
	       			/*$(".photo_detail li").hover(function(){
	    				$(this).find(".Actions").show();
	    				$(this).find(".Actions_ul").hide();
	    			},function(){
	    				$(this).find(".Actions_ul").hide();
	    			})
	               */

	    			//点击相册显示相册里的图片
	    			$("#albumList").hide();
	       			/* var flag=true;
	       			 $(".actions i").hover(function(){
	       				 if(flag==true){
		       				 $(this).next(".Actions_ul").show(1000);
		       				 $(this).parent().parent().siblings().find(".actions .Actions_ul").hide(1000);
		       			 }
	       				 else{
	       					
	                        $(this).next(".Actions_ul").hide(1000);
	                        
	                    } 
	       				 
	       			 }); */
	       		//按钮显示隐藏
	       			 $(".actions i").click(function(){
	       			 var flag=$(this).hasClass("fa-angle-up");
	       			  $(".Actions_ul").each(function(){
	       				 if($(this).prev().hasClass("fa-angle-down")){
	       					$(this).prev().addClass("fa-angle-up");
	       					$(this).prev().removeClass("fa-angle-down");
	       				    $(this).hide(); 
	       				 }
	       			 });
	       			 if(flag){
	       				 $(this).addClass("fa-angle-down");
	       				 $(this).removeClass("fa-angle-up");
	       			 }else{
	       				 $(this).addClass("fa-angle-up"); 
	       				 $(this).removeClass("fa-angle-down"); 
	       				 $(this).next().hide(); 
	       			 }
	       			 
	       			  $(".Actions_ul").each(function(){
                            	 if($(this).prev().hasClass("fa-angle-down")){
                            		 $(this).show(); 
                            	 }
                            });
	       			  });
	       			  
	       			
	       			 
	                 //图片右上角的图标切换
	                  /* $(".actions i").hover(function(event){
	                        $(this).next(".Actions_ul").show(1000);

                     },function(){
	                        $(this).next(".Actions_ul").hide(1000);

	                  });  */


					/*
	                  $(".Actions_ul i").click(function(){
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
	             */

	    			$(".photo_detail_info i").on("click",function(){
						$(".describe").show(500);
					})

					$(".describe").mouseleave(function(){
						$(this).hide(500);
					})

				},
			});

		}
// 		//根据相册Id加载所有的照片
// 		function loadPersonPhotoDetail(albumId)
// 		{
// 			$.ajax({
// 				type: "post",
// 				async : false,
<%-- 				url: "<%=basePath%>personAlbum/loadPhotoDetailByAlbumId.do", --%>
// 				data:{
// 						albumId : albumId
// 					},
// 				success: function(data){
// 					var map = $.parseJSON(data);
// 					var appendHtml = '';
// 					var albumHtml ='';
// 					var album = map.album;
// 					var albumPath = album.albumPath;
					
					
// 					if(albumPath=="" || albumPath==undefined)
// 					{
<%-- 						albumHtml += '<img src="<%=basePath%>assets/global/img/m_img/null_img.jpg">'; --%>
// 					}else
// 					{
// 						albumHtml += '<img src="'+albumPath +'">';
// 					}
// 					albumHtml += '<div class="photo_detail_info"><p>';
// 					albumHtml += '<b>《'+album.albumName+'》</b>相册描述';
// 					albumHtml += '<i class="icon-chevron-down">';
// 					albumHtml += '<em class="describe">';
// 					if(typeof(album.albumDesc)!="undefined"){
// 						albumHtml += '<b>相册描述：</b>'+album.albumDesc;
// 					}else{
// 						albumHtml += '<b>相册描述：</b>';
// 						}
					
// 					albumHtml += '</em></i></p>';
// 					albumHtml += '<p>'+album.createTime+'创建</p>';
// 					albumHtml += '</div>';
// 					albumHtml += '<a href="#" onclick="exportPhoto('+albumId+',\''+album.albumName+'\')">导出</a>';
// 					$.each(map.photoList, function(n, value) {
// 						appendHtml += '<li index="'+n+'" >';    
// 						appendHtml += '<img src="'+value.photoPath +'" style="height: 100%;">';
// 						appendHtml += '</li>';
						
// 						albumHtml += '<li class="circle-cur">'+n+'</li>';
// 	       			}); 
// 	       			 $("#myPhotos").html(appendHtml);
// 	       			 $("#myPhotos1").html(albumHtml);
	       			
// 				},
// 			});
// 		}
		//添加相册
		function addPersonAlbum(albumName,albumDescription,userId,userName)
		{
			$.ajax({
				type: "post",
				async : false,
				url: "<%=basePath%>personAlbum/addPersonAlbum.do",
				data:{
						albumName : albumName,
						albumDescription : albumDescription,
						userId : userId,
						userName : userName
					},
				success: function(data){
					var album = eval("(" + data + ")");
					if(album.albumId>0)
					{
						layer.msg("添加成功！");
						 location.reload(); 
					}else{
						layer.msg("添加失败！");
					}
					
				},
			});
		}
		//删除照片
		function deletePhotoByPhotoId(photoId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/deletePersonPhotoByPhotoId.do",
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
		
// 		删除相册
		function deleteAlbumByAlbumId(albumId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/deletePersonAlbumByAlbumId.do",
				data:{
						albumId : albumId
					},
				success: function(data){
					var flag = eval("(" + data + ")");
					if(flag)
					{
						layer.msg("添加成功！");
						 location.reload();
// 						$("#A"+albumId).remove();
// 						$("#albumId").val(0);
						//autoheight();
					}
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
				url: "<%=basePath%>personAlbum/exportPhotoByAlbumId.do",
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
		
		//修改照片
		function modifyPhotoByPhotoId(photoName,photoDesc,photoId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/modifyPersonPhotoByPhotoId.do",
				data:{
						photoName : photoName,
						photoDesc : photoDesc,
						photoId : photoId
					},
				success: function(data){
					var albumId = $("#albumId").val();
					loadPersonPhotoDetail(albumId);
					$("#photoId").val(0);
				},
			});
		}

		
		//导出照片
		function exportPhoto(albumId,albumName)
		{
			debugger;
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/exportPhotoByAlbumId.do",
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
		
		//删除项目下压缩的包
		function deleteZipFile(fileName)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/deleteZipFile.do",
				data:{
						fileName : fileName
					},
				success: function(data){
				},
			});
		}
		function getExportValue(){
				var albumId = $("#exportAlbumSelectList").val();
				var albumName = $("#exportAlbumSelectList option:selected").text();
				if(albumId !=null && albumId != ""){
					exportPhoto(albumId,albumName);
				}
		}
		//设置相册封面
		function setCover(albumId,photoPath)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>personAlbum/setPersonAlbumCover.do",
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
    </script>
</html>