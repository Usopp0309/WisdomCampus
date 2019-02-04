<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>设备管理</title>
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
	                        <li><a href="<%=basePath %>place/toPlaceList.do">地点管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>设备管理</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">设备管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="#" class="form-horizontal">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                                <input type="text" placeholder="请输入设备名称"  class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search" onclick="loadDeviceList(1);">查找</button>
									<input type="hidden" id="type" value="${sessionScope.user.type}"/>
	                   				<input type="hidden" value="${placeId}" name="placeId" id="placeId"/>
	                         	</div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>设备管理</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>编号</th>
												<th>名称</th>
												<th>ip</th>
												<th>记录点类型</th>
												<th>进出类型</th>
												<th>更新时间</th>
												<c:if test="${sessionScope.user.type != 2}">
												<th>修改</th>
												</c:if>
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
			var placeId = $("#placeId").val();
			//加载初始化数据
			loadDeviceList(1);
			
			//条件查询
			$("#userTab li a").click(function(){

				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				
				//编号
				var queryContent = $("#queryContent").val();

				loadDeviceList(1);
			});

			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});				
		});

		//加载记录点页面
		function loadDeviceList(cPage)
		{
			//编号
			var placeId = $("#placeId").val();
			var queryContent = $("#queryContent").val();
			var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				
				url: "<%=basePath%>device/loadDeviceList.do",
				data:{
						queryContent : queryContent,
						placeId : placeId,
						cPage : cPage
				},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
           				appendHtml += '<td>' + value.code + '</td>';
            			appendHtml += '<td>' + value.name + '</td>';
            			appendHtml += '<td>' + value.ip + '</td>';
            			
            			var positionType = parseInt(value.positionType);

            			switch(positionType)
            			{ 
            				case 1 : 
            					appendHtml += '<td>校门</td>';
            					break; 
            				case 2 : 
            					appendHtml += '<td>宿舍</td>';
            					break; 
            				case 3 : 
            					appendHtml += '<td>会议</td>';
            					break; 
            				case 4 : 
            					appendHtml += '<td>校车</td>';
            					break; 
            				default : 
            					appendHtml += '<td>校门</td>';
            					break;
            			}

            			var inoutType = parseInt(value.inoutType);
            			switch(inoutType)
            			{ 
            				case 0 : 
            					appendHtml += '<td>不区分</td>';
            					break; 
            				case 1 : 
            					appendHtml += '<td>进</td>';
            					break; 
            				case 2 : 
            					appendHtml += '<td>出</td>';
            					break; 
            				default : 
            					appendHtml += '<td>不区分</td>';
            					break;
            			} 
            			var time = value.updatetime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
            			appendHtml += '<td>' + time + '</td>';
            			if ($("#type").val() != '2'){
            				appendHtml += '<td><a onclick="modifyDevice(' + value.id + ')">修改</a>';
            				appendHtml += '  <a onclick="deleteDevice(' + value.id + ','+value.placeId+',\''+ value.code +'\')">删除</a></td>';
            			}
           				appendHtml += '</tr>';
          			});
          			 
          			$("#tbody").html(appendHtml);

          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		//点击修改设备
		function modifyDevice(deviceId)
		{
			standardPost('<%=basePath%>device/toModifyDevice.do',{deviceId:deviceId});
		}
		
		//点击删除设备
		function deleteDevice(deviceId,placeId,code)
		{
			confirm_ = confirm('确定删除？');
        	if(confirm_){
        		$.ajax({
					type: "post",
					url: "<%=basePath%>device/deleteDevice.do",
					data:{
						deviceId : deviceId,
						deviceCode : code
					},
					success: function(data){
                      	//初始化加载部门列表
                      	layer.msg("删除成功",{icon:1,time:1000});
                      	loadDeviceList(1);
					}	
				});
				return false;
        	}
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
			loadDeviceList(cPageInt);
			$("#currentPage").html(cPageInt);
		}

	</script>
</html>