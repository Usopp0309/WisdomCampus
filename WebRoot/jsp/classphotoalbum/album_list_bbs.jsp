<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>相册评论</title>
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
 		.album_list{}
 		.album_list img{width:100%;}
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
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">班级相册</a><i class="fa fa-circle"></i></li>
	                        <li><span>相册评论</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">相册评论</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <li class="active">
	                                    <a>哈哈（老师）</a>
	                                </li>
	                                <li>
	                                    <a>哈哈（家长）</a>
	                                </li>
	                                <li>
	                                    <a>哈哈(学生)</a>
	                                </li>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small" onclick="getid(1)">上传照片</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small" onclick="getid(2)">创建相册</button>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="#" class="form-horizontal">
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择年级：</span>
	                         		<select class="form-control m_select">
                                        <option>选择年级</option>
                                    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择班级：</span>
	                         		<select class="form-control m_select">
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
	                            <div class="portlet-body flip-scroll">
	                                <div class="row">
	                                	<div class="col-md-3 col-sm-3 album_list">
	                                		<img src="http://pan.xici.com/group5/M03/9E/13/rBABqVg_5cqEZ3adAAAAANMbF4o214.jpg/640">
	                                		<div class="actions">
	                                			<i class="fa fa-angle-down"></i>
	                                			<ul>
	                                				<li data-toggle="modal" href="#small" onclick="getid(3)">编辑</li>
	                                				<li data-toggle="modal" href="#small" onclick="getid(4)">删除</li>
	                                			</ul>
	                                		</div>
                                    	</div>
	                                	<div class="col-md-3 col-sm-3 album_list">
	                                		<img src="http://pan.xici.com/group5/M03/9E/13/rBABqVg_5cqEZ3adAAAAANMbF4o214.jpg/640">
	                                	</div>
	                                	<div class="col-md-3 col-sm-3 album_list">
	                                		<img src="http://pan.xici.com/group5/M03/9E/13/rBABqVg_5cqEZ3adAAAAANMbF4o214.jpg/640">
	                                	</div>
	                                	<div class="col-md-3 col-sm-3 album_list">
	                                		<img src="http://pan.xici.com/group5/M03/9E/13/rBABqVg_5cqEZ3adAAAAANMbF4o214.jpg/640">
	                                	</div>
	                                	</div>
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
    <script src="<%=basePath %>assets/global/plugins/jquery-file-upload/js/jquery.fileupload-ui.js" type="text/javascript"></script>
    <script src="<%=basePath %>assets/pages/scripts/form-fileupload.min.js" type="text/javascript"></script>
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
                                       <select class="bs-select form-control" data-live-search="true" data-size="8">
                                            <option value="AF">一班</option>
                                            <option value="AL">一班</option>
                                            <option value="DZ">一班</option>
                                            <option value="AS">一班</option>
                                            <option value="AD">一班</option>
                                            <option value="AO">一班</option>
                                        </select>
                                   </div>
                               </div>
               					<div class="form-group">
                                   	<div class="m_padding_0_15">
                                   		<form id="fileupload" action="" method="POST" enctype="multipart/form-data">
		                                <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
		                                <div class="row fileupload-buttonbar">
		                                    <div class="col-lg-7">
		                                        <!-- The fileinput-button span is used to style the file input field as button -->
		                                        <span class="btn green fileinput-button">
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
		                                <!-- The table listing the files available for upload/download -->
		                                <table role="presentation" class="table table-striped clearfix">
		                                    <tbody class="files"> </tbody>
		                                </table>
		                            </form>
                                   	</div>
				                    <script id="template-upload" type="text/x-tmpl"> 
										{% for (var i=0, file; file=o.files[i]; i++) { %}
                        					<tr class="template-upload fade">
                            				<td>
                                				<span class="preview"></span>
                            				</td>
                            				<td>
                                				<p class="name">{%=file.name%}</p>
                                				<strong class="error text-danger label label-danger"></strong>
                            				</td>
                            				<td>
                                				<p class="size">Processing...</p>
                                				<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                    			<div class="progress-bar progress-bar-success" style="width:0%;"></div>
                                				</div>
                           					 </td>
                            				<td> {% if (!i && !o.options.autoUpload) { %}
                                				<button class="btn blue start" disabled>
                                    				<i class="fa fa-upload"></i>
                                    				<span>Start</span>
                                				</button> {% } %} {% if (!i) { %}
                                				<button class="btn red cancel">
                                    				<i class="fa fa-ban"></i>
                                    				<span>Cancel</span>
                                				</button> {% } %} </td>
                        					</tr> {% } %} </script>
                  						<script id="template-download" type="text/x-tmpl"> {% for (var i=0, file; file=o.files[i]; i++) { %}
                        					<tr class="template-download fade">
                            					<td>
                                					<span class="preview"> {% if (file.thumbnailUrl) { %}
                                    				<a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery>
                                        			<img src="{%=file.thumbnailUrl%}">
                                    				</a> {% } %} </span>
                            					</td>
                            					<td>
                                				<p class="name"> {% if (file.url) { %}
                                    			<a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl? 'data-gallery': ''%}>{%=file.name%}</a> {% } else { %}
                                    			<span>{%=file.name%}</span> {% } %} </p> {% if (file.error) { %}
                                			<div>
                                    			<span class="label label-danger">Error</span> {%=file.error%}</div> {% } %} </td>
                            					<td>
                                					<span class="size">{%=o.formatFileSize(file.size)%}</span>
                            					</td>
                            					<td> {% if (file.deleteUrl) { %}
                                					<button class="btn red delete btn-sm" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}" {% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}' {% } %}>
                                    				<i class="fa fa-trash-o"></i>
                                    				<span>Delete</span>
                                					</button>
                                					<input type="checkbox" name="delete" value="1" class="toggle"> {% } else { %}
                                					<button class="btn yellow cancel btn-sm">
                                    				<i class="fa fa-ban"></i>
                                    				<span>Cancel</span>
                               	 					</button> {% } %} </td>
                        						</tr> {% } %} </script>
                                 </div>
	                  </div>
	                  <div class="modal-body form-horizontal m_img_share">
	                	<h3 class="m_margin_0_auto">分享给(非必选)</h3>
	                	<h5 class="m_padding_15_0"><i></i>全选/取消全选<small>已选<b class="share_num">0</b>人</small></h5>
	                	<div class="row">
	                		<div class="col-md-2 col-sm-2"><p>哈哈</p></div>
	                		<div class="col-md-2 col-sm-2"><p>哈哈</p></div>
	                		<div class="col-md-2 col-sm-2"><p>哈哈</p></div>
	                		<div class="col-md-2 col-sm-2"><p>哈哈</p></div>
	                		<div class="col-md-2 col-sm-2"><p>哈哈</p></div>
	                		<div class="col-md-2 col-sm-2"><p>哈哈</p></div>
	                	</div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" class="btn green m_btn_upload">下一步</button>
	                      <button type="button" data-dismiss="modal" class="btn green m_btn_share">上传</button>
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
                                    <input type="text" class="form-control" placeholder="Enter text">
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  		<div class="form-group">
                                <label class="col-md-3 control-label">相册描述</label>
                                <div class="col-md-8">
                                    <textarea class="form-control" rows="3"></textarea>
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
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
                                    <input type="text" class="form-control" placeholder="Enter text">
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  		<div class="form-group">
                                <label class="col-md-3 control-label">相册描述</label>
                                <div class="col-md-8">
                                    <textarea class="form-control" rows="3"></textarea>
                                    <span class="help-block"> A block of help text. </span>
                                </div>
                            </div>
	                  </div>
	                  <div class="modal-footer">
	                      <button type="button" data-dismiss="modal" class="btn green">确定</button>
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
	                      <button type="button" data-dismiss="modal" class="btn green">确定</button>
	                      <button type="button" data-dismiss="modal" class="btn">取消</button>
	                  </div>
	              </div>
	          </div>
          </div>
      </div>
    <script type="text/javascript">
	  $(function(){
	      loadSubMenu("clazzPhotoAlbumManager"); 
		  //选取当前菜单位置
		  setActive("clazzPhotoAlbumManager","clazzPhotoAlbum"); 
		  $(".album_list").hover(function(){
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
			})
	   })
	   function getid(num){
		   $(".page").removeAttr("style");
		   $(".page"+num).show();
		}
    </script>
</html>