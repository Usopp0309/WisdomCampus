<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>地点管理</title>
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
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">地点管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>地点管理列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">地点管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'president'}">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
									</c:if>
								</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<c:if test="${sessionScope.user.type != 2}">
									 <r:right rightCode="positionManager">
										<button class="btn btn-default" type="button" id="addPlace">增加</button>
									</r:right>
								</c:if>
								<input type="hidden" id="type" value="${sessionScope.user.type}"/>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>地点管理</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>名称</th>
												<th>创建时间</th>
												<th>增加设备</th>
												<th>查看设备</th>
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
	    <!-- 弹窗开始  大小参数：modal-lg, modal-sm-->
	    <div class="modal fade bs-modal-sm" id="small" tabindex="-1" role="dialog" aria-hidden="true">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">天窗标题</h4>
	                </div>
	                <div class="modal-body">弹窗主题</div>
	                <div class="modal-footer">
	                    <button type="button" class="btn dark btn-outline" data-dismiss="modal">确定</button>
	                    <button type="button" class="btn green">取消</button>
	                </div>
	            </div>
	            <!-- /.modal-content -->
	        </div>
	        <!-- /.modal-dialog -->
	    </div>
	    <!-- 弹窗结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>

		jQuery(document).ready(function() {   
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","placeManage"); 
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			loadPlaceList(userId, roleCode, 1);
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadPlaceList(userId, roleCode, 1);
				
			});
			//点击增加地点页面
			$("#addPlace").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>place/toAddPlace.do',{userId:userId,roleCode:roleCode});
			});
		});

		//加载记录点页面
		function loadPlaceList(userId, roleCode, cPage)
		{
			//编号
			var queryContent = $("#queryContent").val();
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>place/getPlaceList.do",
				data:{
						userId : userId,
						roleCode : roleCode,
						cPage : cPage
				},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
            			appendHtml += '<td>' + value.name + '</td>';
            			var time = value.createTime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
            			appendHtml += '<td>' + time + '</td>';
            			if ($("#type").val() != '2'){
            				appendHtml += '<td><a href="javascript:;"  onclick="addCamera(' + value.id + ')">摄像头</a>    <a href="javascript:;"  onclick="addDevice(' + value.id +','+ value.type+')">读卡设备</a></td>';
            				appendHtml += '<td><a href="javascript:;"  onclick="viewCamera(' + value.id + ')">摄像头</a>    <a href="javascript:;"  onclick="viewDevice(' + value.id + ')">读卡设备</a></td>';
            				appendHtml += '<td><a href="javascript:;"  onclick="modifyPlace(' + value.id + ')" class="btn btn-sm update_btn">修改</a>';
            				appendHtml += '<a href="javascript:;" onclick="deletePlace(' + value.id+','+ value.type+')" class="btn btn-sm delete_btn">删除</a></td>';
            			}else{
            				appendHtml += '<td></td>';
            			}
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);

          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		
		//点击修改地点
		function modifyPlace(placeId)
		{
			standardPost('<%=basePath%>place/toModifyPlace.do',{placeId:placeId});
		}

		//点击删除地点
		function deletePlace(placeId,type)
		{
			//页面初始化时候的数据加载
			var ll=layer.confirm('确定删除地点及包含的所有设备？', {
				  btn: ['确定','取消'] //按钮
				}, function(){
					var indexlayer = layer.msg('正在删除数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
					$.ajax({
						type: "post",
						url: "<%=basePath%>place/deletePlace.do",
						data:{
							placeId : placeId,
							type : type
						},
						error:function(){
							layer.close(indexlayer);
						},
						success: function(data){
							layer.close(indexlayer);
							layer.close(ll);
							var data = eval("(" + data + ")");
							if(data)
							{
		                        layer.msg("删除成功",{icon:1,time:1000});
		                       	var userId = $("#userTab li.active").find('a').attr("attr1");
		           				var roleCode = $("#userTab li.active").find('a').attr("attr2");
		           				//搜索内容
		           				var queryContent = $("#queryContent").val();
		           				loadPlaceList(queryContent, userId, roleCode, 1);
							}else{
								 layer.msg("删除失败",{icon:2,time:1000});	
							}
						}	
					});
				});
		}

		//点击增加设备
		function addDevice(placeId,type)
		{
			var userId = $("#userTab li.active").find('a').attr("attr1");	
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>device/toAddDevice.do',{userId:userId,roleCode:roleCode,placeId:placeId,type:type});
			}

		//点击增加设备（教室添加摄像头）
		function addCamera(placeId)
		{
			standardPost('<%=basePath%>camera/toAddCamera.do',{placeId:placeId});
		}
		
		//点击查看设备
		function viewDevice(placeId)
		{
			var userId = $("#userTab li.active").find('a').attr("attr1");	
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>place/toViewDevice.do',{userId:userId,roleCode:roleCode,placeId:placeId});
		}

		//点击查看设备（教室查看摄像头）
		function viewCamera(placeId)
		{
			standardPost('<%=basePath%>camera/toCameraManager.do',{placeId:placeId});
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
			//用户ID
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			loadPlaceList(userId, roleCode, cPageInt);
			$("#currentPage").html(cPageInt);
		}

	</script>
</html>