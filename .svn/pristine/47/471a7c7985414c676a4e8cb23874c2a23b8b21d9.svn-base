<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>视频信息详情</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
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
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="<%=basePath%>camera/toCameraManager.do">视频管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>视频信息详情</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">视频信息详情</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 页面搜索开始 -->
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>视频信息详情 </div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content" id="syllable">
<!-- 	                                        <tr> -->
<!-- 	                                            <th>使用对象</th> -->
<!-- 	                                            <th>创建时间</th> -->
<!-- 												<th>地点名称</th> -->
<!-- 												<th>摄像头编码</th> -->
<!-- 												<th>摄像头名称</th> -->
<!-- 												<th>类型</th> -->
<!-- 	                                        </tr> -->
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
	                    <input type="hidden" name="placeId" id="placeId" value="${placeId}">
						<input value="${camera.cameraId}" type="hidden" id="cameraId">
						<input value="${camera.cameraCode}" type="hidden" id="cameraCode">
						<input value="${camera.cameraName}" type="hidden" id="cameraName">
						<input value="${camera.type}" type="hidden" id="type">
						<input value="${camera.placeName}" type="hidden" id="placeName">
						<input value="${roleCode}" type="hidden" id="roleCode">
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
</html>

	
	<script type="text/javascript">

		$(function() {  
			loadSubMenu("liveCameraManager"); 
			//选取当前菜单位置
			setActive("liveCameraManager","cameraManager");  
			//条件查询
			$("#search").click(function(){
				//查询内容
				var queryContent = $("#queryContent").val();
				var roleCode = $("ul li.active").find('a').attr("attr2");
			});
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});	
			loadCameraList(1);
		});
		//加载摄像头页面
		function loadCameraList(cPage)
		{
			var body = $("#body");
			var cameraId = $("#cameraId").val();
			var cameraCode=$("#cameraCode").val();
			var cameraName=$("#cameraName").val();
			var type=$("#type").val();
			var placeName=$("#placeName").val();
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>camera/getDetailCamera.do",
				dataType:"json",
				data:{
					cameraId : cameraId,
					page : cPage,
					dataType:"json"
				},
				success: function(page){
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
// 					var data = JSON.stringify(page.list); 
// 					alert(data);
					var appendHtml = '';
					var trHtml = '';
					if(type != 2){
						trHtml += '<tr><th>使用对象</th><th>创建时间</th><th>地点名称</th><th>摄像头编码</th><th>摄像头名称</th><th>类型</th><th>操作</th></tr>';
					}else{
						trHtml += '<tr><th>使用对象</th><th>创建时间</th><th>地点名称</th><th>摄像头编码</th><th>摄像头名称</th><th>类型</th></tr>';
					}
					$.each(page.list, function(n, value) { 
						
						if (n%2 == 0)
						{
							appendHtml += '<tr style="background-color: #ededed">';
						}
						else
						{
							appendHtml += '<tr>';
						}	
            			appendHtml += '<td>' + value.name + '</td>';
            			
            			appendHtml += '<td>' + value.createTime + '</td>';

            			if(typeof(placeName) == "undefined"){
            				appendHtml += '<td></td>';
                		}else{
                			appendHtml += '<td>'+placeName+'</td>';
                    	}
                    	appendHtml += '<td>'+cameraCode+'</td>';
            			var startDay = value.startDay;
            			var endDay = value.endDay;
                    	
                    	if(startDay == undefined)
                       	{
                    		startDay = "";
                       	}
                    	if(endDay == undefined)
                       	{
                    		endDay = "";
                       	}
                    	appendHtml += '<td>' + cameraName + '</td>';
                    	if(type == 0){
            				appendHtml += '<td>公用</td>';
            				appendHtml += '<td><a href="javascript:;" onclick="deleteUserCamera(' + value.userIdOrClazzId + ',' + type + ')">删除</a></td>';
                		}else if(type == 1){
                			appendHtml += '<td>私用</td>';
                			appendHtml += '<td><a href="javascript:;" onclick="deleteUserCamera(' + value.userIdOrClazzId + ',' + type + ')">删除</a></td>';
                    	}else if(type == 2)
                        {
                    		appendHtml += '<td>全校</td>';
                        }else
                        {
                    		appendHtml += '<td>全校</td>';
                        }
           				appendHtml += '</tr>';
          			}); 
					$("#syllable").html(trHtml);
          			$("#tbody").html(appendHtml);
//           			解锁UI
          			App.unblockUI(body);
          			
				},
			});
		}
		//删除人员班级摄像头	
		function deleteUserCamera(id,type){
			var cameraId =$("#cameraId").val();
			var roleCode =$("#roleCode").val();
			layer.msg('数据删除无法回复？', {
				  time: 0 //不自动关闭
				  ,btn: ['确定', '取消']
				  ,yes: function(index){
				    layer.close(index);
				    $.ajax({
						type: "post",
						url: "<%=basePath%>camera/deleteCameraRelation.do",
						dataType:"json",
						data:{
							userOrclazzId : id,
							type : type,
							cameraId : cameraId
						},
						success: function(data){
							var flage = eval("(" + data + ")");
							if(flage){
								layer.msg('删除成功',{time:500}, function(){
										window.location.reload();
									});
							}else{
								layer.alert("删除失败",{icon:2});
							}
		          			
						},
					});
				  }
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

			var queryContent = $("#queryContent").val();
			loadCameraList(cPageInt);
			
			$("#currentPage").html(cPageInt);
		}

	</script>

	</html>