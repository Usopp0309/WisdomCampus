<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>教学资源</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	 <link href="<%=basePath %>assets/pages/scripts/bootstrap-fileupload.css" rel="stylesheet" type="text/css" />
 	 <link href="<%=basePath %>assets/pages/scripts/style-metro.css" rel="stylesheet" type="text/css" />
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
	                        <li><a href="<%=basePath %>teachingResources/toTeachingResources.do">教学资源</a><i class="fa fa-circle"></i></li>
	                        <li><span>教学资源列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">教学资源</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
                      				<r:right rightCode="teachingResourcesUpload"> 
                      						<button class="btn btn-default" type="button" data-toggle="modal" href="#static" onclick="resourceDilag();" id="xxxx">资源上传</button>
									</r:right>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="#" class="form-horizontal">
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">开始时间：</span>
                                    <input type="text" id="startTime" name="startTime" class="m_input form-control">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">结束时间：</span>
	                         		<input type="text" id="endTime" name="endTime" class="m_input form-control">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择类型：</span>
	                         		    	<select id="seleteFileType" class="m_select form-control">
												<option value="">--请选择--</option>
												<option value="1">视频</option>
												<option value="2">办公类型</option>
												<option value="3">压缩包</option>
												<option value="4">图片</option>
												<option value="5">音频</option>
												<option value="6">其他</option>
											</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input class="m_input form-control" type="text" id="queryContent">
	                         	</div>
	                         
		                         <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
			                         <button type="button" class="btn green" id="search" onclick="getPages(1);">搜索</button>
		                         </div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>教学资源</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="hidden-sm hidden-md">格式</th>
	                                            <th>文件名</th>
												<th class="hidden-sm hidden-md">类型</th>
												<th>上传者</th>
												<th class="hidden-sm hidden-md">大小(M)</th>
												<th>上传时间</th>
												<th>操作</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="tbody">
	                                    </tbody>
	                                </table>
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
    <script src="<%=basePath%>assets/global/plugins/album/scripts/bootstrap-fileupload.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/pages/scripts/form-fileupload.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/ajaxfileupload.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/global/plugins/album/js/fileinput_locale_zh.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/moxie.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/plupload.dev.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/zh_CN.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/ui.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/resource/js/qiniu.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/resource/js/main.js" type="text/javascript"></script>
    <!-- 公共js结束 -->
     <script src="<%=basePath %>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
    <div class="modal fade" id="static" tabindex="-1" role="dialog" aria-hidden="true">
    	<div class="modal-dialog modal-dm">
	        <div class="modal-content" id="container">
	        	<form action="#" method="POST" enctype="multipart/form-data">  
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    				<h4 class="modal-title">资源上传<span style="color: red;font-size: 14px;">(最大上传500M)</span></h4>
									</div>
									<div class="modal-body" style="text-align: center;" id="uploadHtml">
										<div data-provides="fileupload" class="fileupload fileupload-new " id="fileupload-exists">
												<div class="input-append">
													<div class="uneditable-input" style="height: 34px;">
														<i class="icon-file fileupload-exists"></i> 
														<span class="fileupload-preview"></span>
													</div>
													<span class="btn btn-file">
													<span class="fileupload-new" id="uploadFile">选择文件</span>
													<span class="fileupload-exists" >换一个</span>
													<input type="file" class="default">
													</span>
													<a data-dismiss="fileupload" class="btn fileupload-exists" href="#">移除</a>
												</div>
											</div>
											<div><input class="form-control" type="text" placeholder="请输入文件名" style="width:208px;margin-left: 136px;" id="file_name"></div>
											<div><select id="seleteUploadFileType" class="form-control" style="width:208px;margin-left: 136px;margin-top: 10px;" >
																	<option value="">--请选择文件类型--</option>
																	<option value="1">视频</option>
																	<option value="2">办公类型</option>
																	<option value="3">压缩包</option>
																	<option value="4">图片</option>
																	<option value="5">音频</option>
																	<option value="6">其他</option>
																	</select></div>
									</div>
									<div class="modal-footer">
										<button class="btn" data-dismiss="modal" type="button" id="quxiao">取消</button>
										<button class="btn green upload_btn" type="button" id="upload">上传</button>
									</div>
                                     <!-- 是新建空间的域名 -->
									 <input id="domain" type="hidden" value="<%=Cons.QINIU_BUCKETNAME_TEACHING_RES_URL%>">
									 <!--用于获取uptoken  -->
                                     <input id="uptoken_url" type="hidden" value="<%=basePath%>teachingResources/getUpTokenInJS.do">
                                     <!-- 提交到后台的地址 -->
                                      <input id="basePath_" type="hidden" value="<%=basePath%>teachingResources/addTeachingResources.do">
                                      <input value="${sessionScope.user.userId}" id="userId_" type="hidden">
                                      <input type="hidden" name="schoolId" id="schoolId" value="${sessionScope.user.schoolId}"/>	
                                      </form>
	        </div>
	   	</div>
								
	</div>
	<script>
	$(function(){
		loadSubMenu("teachingResourcesManager"); 
		//选取当前菜单位置
		setActive("teachingResourcesManager","teachingResources");
		$('#startTime,#endTime').datetimepicker({
			format:'Y-m-d',
			timepicker:false
		});
		
	})
	var indexlayer="";
	var qiniukey_="";
		jQuery(document).ready(function() {
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			getPages(1);
			
		});
		
		//enter事件
		document.onkeydown=function(event){
            var e = event || window.event || arguments.callee.caller.arguments[0];
             if(e && e.keyCode==13){ // enter 键
            	 getPages(1);
            }
        }; 
		//清楚原有的选择的文件
		function resourceDilag(){
			$("#upload").find("div").remove();
			$(".fileupload-preview").text("");
    		$("#fileupload-exists").removeClass("fileupload-exists");
    		$("#fileupload-exists").addClass("fileupload-new");
    		$("#file_name").val("");
    		$("#seleteUploadFileType").val("");
		}
		function loading_(){
			indexlayer = layer.msg('正在上传数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
		}
		//分页获得资源
		function getPages(cpage){
        var startTime=$("#startTime").val();
        var endTime=$("#endTime").val();
        var queryContent=$("#queryContent").val();
        var seleteFileType=$("#seleteFileType").val();
        $("#seleteUploadFileType").val("");
        if(startTime!="" && endTime!="" ){
               if(parseInt(startTime.replace("-"))>parseInt(endTime.replace("-"))){
            	   $("#endTime").val("");
                   alert("开始时间不能大于结束时间");
                 }
            }
        $.ajax({
           url:"<%=basePath%>teachingResources/getPageTeachingResources.do",
           type:"post",
           dataType:"json",
           data:{"startTime":startTime,"endTime":endTime,"fileName":queryContent,"page":cpage,"fileType":seleteFileType},
           error:function(){},
           success:function(results){
                var  result=results.list;
                var appendHtml='';
            	$("#currentPage").html(results.currentPage);
				$("#totalPage").html(results.totalPage);
               for(var i=0;i<result.length;i++){
            	   appendHtml+=' <tr>';
            	  
               	   //文件类型(1:视频，2：办公类型,3:压缩包，4：图片，5：音频，6：其他)
               	   if(result[i].fileType==1){
               		   	appendHtml+=' <td class="hidden-sm hidden-md">mp4</td><td>'+result[i].fileName+'</td>';
                   	}else if(result[i].fileType==2){
                       	var tolocaleLowerCase=result[i].fileUrl.toLowerCase();
                   		if(tolocaleLowerCase.indexOf("xls")>-1 && tolocaleLowerCase.indexOf("xlsx")>-1){
               			  	appendHtml+=' <td class="hidden-sm hidden-md">excel></td><td>'+result[i].fileName+'</td>';
                         }else if(tolocaleLowerCase.indexOf("doc")>-1 && tolocaleLowerCase.indexOf("docx")>-1){
                       	 	appendHtml+=' <td class="hidden-sm hidden-md">word></td><td>'+result[i].fileName+'</td>';
                         }else if(tolocaleLowerCase.indexOf("txt")>-1){
                       	  	appendHtml+=' <td class="hidden-sm hidden-md">txt></td><td>'+result[i].fileName+'</td>';
                         }else{
                       	  	appendHtml+=' <td class="hidden-sm hidden-md">其他></td><td>'+result[i].fileName+'</td>';
                         }
                    }else if(result[i].fileType==3){
                	   appendHtml+=' <td class="hidden-sm hidden-md">zip></td><td>'+result[i].fileName+'</td>';
                    }else if(result[i].fileType==4){
                	   appendHtml+=' <td class="hidden-sm hidden-md">img</td><td>'+result[i].fileName+'</td>';
                    }else if(result[i].fileType==5){
                	   appendHtml+=' <td class="hidden-sm hidden-md">mp4</td><td>'+result[i].fileName+'</td>';
                    }else if(result[i].fileType==6){
                	   appendHtml+=' <td class="hidden-sm hidden-md">其他</td><td>'+result[i].fileName+'</td>';
                    }
                   
               	   //文件类型(1:视频，2：办公类型,3:压缩包，4：图片，5：音频，6：其他)
            	   if(result[i].fileType==1){
            		   appendHtml+=' <td class="hidden-sm hidden-md">视频</td>';
                	}else if(result[i].fileType==2){
                	   appendHtml+=' <td class="hidden-sm hidden-md">办公类型</td>';
                    }else if(result[i].fileType==3){
                	   appendHtml+=' <td class="hidden-sm hidden-md">压缩包</td>';
                    }else if(result[i].fileType==4){
                	   appendHtml+=' <td class="hidden-sm hidden-md">图片</td>';
                    }else if(result[i].fileType==5){
                	   appendHtml+=' <td class="hidden-sm hidden-md">音频</td>';
                    }else if(result[i].fileType==6){
                	   appendHtml+=' <td class="hidden-sm hidden-md">其他</td>';
                    }
                    
            	   appendHtml+=' <td>'+result[i].userName+'</td>';
            	   appendHtml+=' <td class="hidden-sm hidden-md">'+result[i].fileSize+'</td>';
            	   appendHtml+=' <td>'+result[i].createTime+'</td>';
            	   appendHtml+=' <td>';
            	   if(result[i].fileType==1 || result[i].fileType==5){
            	   appendHtml+='<a href="javascript:void(0);" onclick="player(\''+result[i].fileUrl+'\')">播放</a>';
                	}
            	   appendHtml+='<a href="javascript:void(0);" onclick="downFile(\''+result[i].fileUrl+'\')">下载</a>';
            	   appendHtml+='<a href="javascript:void(0);" onclick="deleteData('+result[i].id+',\''+result[i].fileUrl+'\')">删除</a></td></tr>';
              }
               $("#tbody").html(appendHtml);
           }
        });
	}
function player(url){
	//页面层
	layer.open({
	  title:"教学资源",
	  type: 2,
	  skin: 'layui-layer-rim', //加上边框
	  area: ['600px', '400px'], //宽高
	  content: '<%=basePath%>teachingResources/toPlayVedio.do?url='+url
	});
}
	//下载文件
	function downFile(fileUrl){
		var last=fileUrl.lastIndexOf("/");
		var fileName=fileUrl.substring(last);
		var domainKey=fileUrl.substring(0,last);
		var url=fileUrl+"?download"+fileName;
        location.href=url;
	}
	 //删除资源
	function deleteData(key,qiniuKey){
	var l_=layer.confirm('确定删除？一旦删除数据不可恢复！', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			var d_ = layer.msg('正在删除数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			 $.ajax({
				   url:"<%=basePath%>teachingResources/deleteTeachingResource.do",
		           type:"post",
		           dataType:"json",
		           data:{"key":key,"qiniuKey":qiniuKey},
		           error:function(){ 
			           layer.close(l_);
			           layer.close(d_);
			           },
		           success:function(result){
		        	   $('#myModal').modal('hide');
			           var cPageInt=$("#currentPage").text();
		        	   getPages(cPageInt);
		        	   layer.close(l_);
		        	   layer.close(d_);
		           }
		    }); 
		}, function(){
		  layer.close(l_);
		});
	
	}
		//分页相关
		function jumpPage(type)
		{
			var cPage = $("#currentPage").html();
			var totalPage = $("#totalPage").html();

			var cPageInt = parseInt(cPage);
			var totalPageInt = parseInt(totalPage);
						
			var newCPageInt = returnCPageInt(type,cPageInt,totalPageInt);
			if(newCPageInt < 0){
				return;
			}else{
				cPageInt = newCPageInt;
			}
			getPages(cPageInt);
		   	$("#currentPage").html(cPageInt);
		} 
	</script>
</html>