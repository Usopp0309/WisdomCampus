<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>APP动态图</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->  
 	<link href="<%=basePath %>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
 	<style type="text/css">
	.graph_detail{border: 1px solid #dadcd9;height: 150px;margin-top:15px;}
	.graph_detail img {display: block;height: 120px;margin:0px auto;max-width:100%;width:auto;}
	.graph_detail p{display: block;height: 30px;width:100%;text-align: center;line-height:30px;margin:0px auto;}
	.graph_detail em{position: absolute;top:20px;left:20px;width: 20px; height: 20px;font-size: 15px;line-height:20px!important;background-color: #fff!important;border: 1px solid #ccc;color:#27a4b0;}
	.graph_detail em .fa-check{ackground-color: #4e90fe!important;border: 1px solid #4e90fe;color: #27a4b0;}
	p{text-align: left;margin:0px auto 15px;}
	.graph_detail .fa-times{position: absolute;top:20px;right:20px; cursor:pointer; display: block; width: 20px;height: 20px;font-size: 15px;line-height: 20px;color: #ccc;}
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
	                        <li><a href="">系统管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>APP动态图</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">APP动态图</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi" id="${roleList.roleCode}">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}">${sessionScope.user.realName}(${roleList.roleName})</a>
										</li>
									</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
<!-- 	                        <div class="portlet light form-fit m_margin_0_0_15_0"> -->
<!-- 	                        	<a href="#small" data-toggle="modal" class="btn btn-default">上传图片</a> -->
<!-- 	                        </div> -->
	                        <!-- 添加功能菜单结束 -->
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>APP动态图</div>
	                            </div>
	                            
	                            <div class="portlet-body" id="graphList">
	                            </div>
	                        </div>
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
    <script src="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
    <script src="<%=basePath%>assets/global/plugins/album/scripts/moxie.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/plupload.dev.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/zh_CN.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/ui.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/qiniu.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/highlight.js" type="text/javascript" ></script>
	<div class="modal fade" id="small" tabindex="-1" role="dialog" aria-hidden="true">
		 <div class="modal-dialog modal-lg">
            <div class="modal-content">
					<div class="modal-header">
						<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
						<h4>上传照片</h4>
					</div>
					<div class="modal_body">
						<form action="" class="form-horizontal" method="POST" id="uploadPhoto" enctype="multipart/form-data"> 
							<div class="form-group m_margin_15_0">
                                 <label class="control-label col-md-3">标题:</label>
                                 <div class="col-md-4">
                                     <input type="text" class="form-control" id="title" name="title">
                                 </div>
                             </div> 
							<div class="form-group">
                                 <label class="control-label col-md-3">链接:</label>
                                 <div class="col-md-4">
                                     <input type="text" class="form-control" id="url" name="url">
                                 </div>
                             </div> 
							<div class="form-group">
                                 <label class="control-label col-md-3">选择图片:</label>
                                 <div class="col-md-4">
                                     <div class="fileinput fileinput-new" data-provides="fileinput">
                                                    <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt="" /> </div>
                                                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
                                                    <div>
                                                        <span class="btn default btn-file">
                                                            <span class="fileinput-new">选择图片</span>
                                                            <span class="fileinput-exists">换一个</span>
                                                            <input type="file" name="..."> </span>
                                                        <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                                    </div>
                                                </div>
                                 </div>
                             </div> 
					  </form>
				  </div>
				  <div class="modal_footer">
				  	<button type="button" class="btn green">确定</button>
                    <button type="button" class="btn default">取消</button>
					<input id="domain" type="hidden" value="<%=Cons.QINIU_BUCKETNAME_RICH_AD_URL%>">
                    <input id="basePath" type="hidden" value="<%=basePath%>dynamicGraph/uploadDynamicGraph.do">
                    <input id="uptoken_url" type="hidden" value="<%=basePath%>dynamicGraph/getDynamicGraphUpTokenInJS.do">
                    <input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}"/>	
					<input type="hidden" name="realName" id="realName" value="${sessionScope.user.realName}"/>
					<input type="hidden" name="schoolId" id="schoolId" value="${sessionScope.user.schoolId}"/>
					<input type="hidden" name="prefix" id="prefix" value="graph"/>	
				  </div>
			   </div>
	   		</div>
	   </div>
	<script>

		jQuery(document).ready(function() { 
			loadSubMenu("systemManage"); 
			//选取当前菜单位置
			setActive("systemManage","dynamicGraph");   
			loadAllGraphList();
		});
		
		//加载所有的APP首页动态图
		function loadAllGraphList()
		{
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>dynamicGraph/loadAllGraphList.do",
				data:{
					},
				success: function(data){
					var graphList = $.parseJSON(data);
					var appendHtml = '';
					$.each(graphList, function(n, value){
						if((n==0) || (n%4==0&&n>=4)){
							appendHtml += '<div class="row">';
						}
						appendHtml += '<div class="col-md-3 col-sm-3" id="G'+value.graphId+'"><div class="graph_detail">';
						if(value.status==1)
						{
							appendHtml += '<em class="icon-ok fa fa-check" onclick="modifyStatus('+value.graphId+',2)"></em>';
						}else
						{
							appendHtml += '<em class="icon-ok" onclick="modifyStatus('+value.graphId+',1)"></em>';
						}
						appendHtml += '<img src="'+value.path +'">';
						if(value.title == undefined)
						{
							appendHtml += '<p></p>';
						}
						else
						{
							appendHtml += '<p>'+value.title +'</p>';
						}
						appendHtml += '<i class="fa fa-times" onclick="deleteGraph('+value.graphId+')"></i>';
						appendHtml += '</div></div>';
					    if((n==3) || (((n+1)%4==0)&&((n+1)>4))){
					    	appendHtml += '</div>';
						}
	       			}); 
	       			 
	       			$("#graphList").html(appendHtml);
	       			
					//解锁UI
		  			App.unblockUI(body);
				},
			});
			
		}

		//修改APP首页动态图的状态
		function modifyStatus(graphId,status)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>dynamicGraph/modifyStatus.do",
				data:{
					   graphId : graphId,
					   status : status
					},
				success: function(data){
					var data = $.parseJSON(data);
	       			if(data)
	       			{
	       				if($("#G"+graphId).find("em").hasClass("fa fa-check")){
	    					$("#G"+graphId).find("em").removeClass("fa fa-check");
	    				}else{
	    					$("#G"+graphId).find("em").addClass("fa fa-check");
	    				}
		       			layer.msg("修改成功！");
	       			}
				},
			});
		}

		//删除APP首页动态图
		function deleteGraph(graphId)
		{
			var l_=layer.confirm('是否确认删除？', {
				  btn: ['确定', '取消'] //可以无限个按钮
				}, function(){
					$.ajax({
						type: "post",
						url: "<%=basePath%>dynamicGraph/deleteGraph.do",
						data:{
							   graphId : graphId
							},
						success: function(data){
							var data = $.parseJSON(data);
			       			if(data)
			       			{
			       				layer.msg("删除成功！");
				       			$("#G"+graphId).remove();
				       			layer.close(l_);
			       			}
						},
					});
				  
				}, function(){
					 layer.close(l_);
				});
			
		}
	</script>
</html>