<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>维修人员列表</title>
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
	                        <li><a href="<%=basePath%>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>维修人员列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">维修人员信息</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<r:right rightCode="assetServicemanManager">
											<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
												<li class="roleLi">
													<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
												</li>
											</c:if>
										</r:right>
									</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<a class="btn btn-default" href="<%=basePath%>asset/toAddAssetServiceman.do">添加维修人员</a>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	                         	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">资产类型：</span>
	                         		<select class="form-control m_select" id="type" onchange="checkServicemanList();">
                                     </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">查询内容：</span>
	                         		<input class="m_input form-control" placeholder="输入员工编号，员工姓名……" id="code"  type="text">
	                         	</div>
		                         <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
			                         <button type="button" id="search" class="btn green">查找</button>
		                         </div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>维修人员列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_20">维修人员</th>
	                                            <th class="m_width_20 hidden-md">员工编号</th>
	                                            <th class="m_width_20">维修人员手机号</th>
	                                            <th class="m_width_20">维修类型 </th>
	                                            <th class="m_width_20"> 相关领导</th>
	                                            <r:right rightCode="assetServicemanDeleteManager">
	                                            	<th class="m_width_20">操作</th>
	                                           	</r:right>
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
    <!-- 公共js结束 -->
   
   <script type="text/javascript">
   	$(function(){
   	    //选取当前菜单位置
   		setActive("assetManagement","assetServicemanList"); 
   		loadTyepList();
   		loadServicemanList(null,null, null)
   		
		//条件查询
		$("#search").click(function(){
			var code = $("#code").val();
			var type = $("#type").val();
			loadServicemanList(code, type, null);
		});
   	})
   	function checkServicemanList(){
   		var code = $("#code").val();
		var type = $("#type").val();
		loadServicemanList(code, type, null);
   	}
   	function loadServicemanList(code,type, cPage)
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/getServicemanList.do",
			data:{
				code : code,
				type : type,
				choose : 2,
				pageSize : 20,
				page : cPage
			},
			success: function(data){
				var page = eval("(" + data + ")");
				$("#currentPage").html(page.currentPage);
				$("#totalPage").html(page.totalPage);
				var appendHtml = '';
				$.each(page.list, function(n, value) {  
					appendHtml += '<tr>';
						appendHtml += '<td>'+value.serviceman+'</td>';
	       				var code = value.code;
	       				if(code == undefined)
	   					{
	       					code = "";
	   					}
	       				appendHtml += '<td>'+code+'</td>';
	       				var phone = value.phone;
	       				if(phone == undefined)
	   					{
	       					phone = "";
	   					}
	       				appendHtml += '<td>'+phone+'</td>';
	       				
	       				if(value.type == 0)
	   					{
	       					appendHtml += '<td class="hidden-md">水电设施</td>';
	   					}
	       				else if(value.type == 1)
	   					{
	       					appendHtml += '<td class="hidden-md">房屋建筑物</td>';
	   					}
	       				else if(value.type == 2)
	   					{
	       					appendHtml += '<td class="hidden-md">办公设备</td>';
	   					}
	       				else if(value.type == 3)
	   					{
	       					appendHtml += '<td class="hidden-md">网络信息</td>';
	   					}
	       				else if(value.type == 4)
	   					{
	       					appendHtml += '<td class="hidden-md">仪器设备</td>';
	   					}
	       				else if(value.type == 5)
	   					{
	       					appendHtml += '<td class="hidden-md">运输设备</td>';
	   					}else if(value.type == 6)
	   					{
	       					appendHtml += '<td class="hidden-md">体育用品</td>';
	   					}else
	   					{
	       					appendHtml += '<td class="hidden-md">其他</td>';
	   					}
	       				var leaderOne = value.leaderOne;
	       				if(leaderOne == undefined)
	   					{
	       					leaderOne = "";
	   					}
	       				var leaderTwo = value.leaderTwo;
	       				if(leaderTwo == undefined)
	   					{
	       					leaderTwo = "";
	   					}
	       				appendHtml += '<td>'+leaderOne+' '+leaderTwo+'</td>';
	       				appendHtml += ' <r:right rightCode="assetServicemanDeleteManager">';
       					appendHtml += '<td class="hidden-md"><a class="btn btn-sm red del" onclick="deletePerson('+value.id+')">删除</a></td>';
       					appendHtml += ' </r:right>';
	       				appendHtml += '</tr>';
       				
      			}); 
      			$("#tbody").html(appendHtml);
			},
		});
	}
   	
   	function loadTyepList()
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/getAssetTypeList.do",
			data:{
			},
			success: function(data){
				var list = eval("(" + data + ")");
                var appendHtml = '';
                appendHtml += '<option value="">全部</option>';
				$.each(list, function(n, value) {  
       				appendHtml += '<option value="'+value.id+'">'+value.name+'</option>';
      			}); 
      			$("#type").html(appendHtml);
			},
		});
    }
 	function deletePerson(id){
 		layer.msg('数据一旦删除无法恢复，请确认？', {
 			  time: 0 //不自动关闭
 			  ,btn: ['确定', '取消']
 			  ,yes: function(index){
 			    layer.close(index);
 			   $.ajax({
 					type: "post",
 					url: "<%=basePath%>securityDanger/deleteAssetServicemanById.do",
 					data:{
 						servicemanId : id
 					},
 					success: function(data){
 						if(data==0){
 							layer.msg("删除成功");
 							location.replace("<%=basePath%>asset/toAssetServicemanList.do"); 
 						}else{
 							layer.msg("删除失败");
 						}
 						
 					}
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
		var code = $("#code").val();
		var type = $("#type").val();
		loadServicemanList(code, type, cPageInt);
	    $("#currentPage").html(cPageInt);
	}
   </script>
</html>