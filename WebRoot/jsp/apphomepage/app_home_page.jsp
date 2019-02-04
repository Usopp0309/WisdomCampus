<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>手机模拟</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->      
 	<link href="<%=basePath%>assets/global/css/set_phone.css" rel="stylesheet" type="text/css" />
 	<link href="../assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
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
	                        <li><span>手机模拟</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">手机模拟</h3>
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
	                        <!-- 页面搜索开始 -->
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>手机模拟</div>
	                            </div>
	                            <div class="portlet-body">
	                                <div class="phonehome">
										<div class="m_row">
											<em></em>
										</div>
										<div class="phone_bg">
											<div class="m_row">
												<p class="header">${school.schoolName}</p>
											</div>
											<ul class="phone_page">
												<li>
													<div class="m_row">
														<div class="ad">
															<ul id="dynamic">
															</ul>
															<p><em class="select"></em><em></em><em></em></p>
														</div>
													</div>
													<div class="m_row" style="border-bottom:1px solid #ccc;">
														<ul class="menu" id="middleMenu">
														</ul>
													</div>
													<div class="m_row" style="margin:30px auto;border-top:1px solid #ccc;">
														<ul class="app_submenu" id="belowMenu">
														</ul>
													</div>
												</li>
												<li>
													<div class="m_row">
														<ul class="address" id="address">
														</ul>
													</div>
												</li>
											</ul>
											<p class="pages"><em class="select"></em><em></em></p>
										</div>
									</div>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
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
    <div class="modal fade bs-modal-sm" id="small" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="page1 dialog" style="height:580px;">
			<form action="<%=basePath%>appHomePage/addDynamicGraph.do" method="POST" id="uploadPhoto" enctype="multipart/form-data"> 
				<div class="modal-dialog modal-lg">
	            	<div class="modal-content"> 
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                    <h4 class="modal-title">上传广告图</h4>
						</div>
						<div class="modal-body form-horizontal">
							<div class="form-group">
                                 <label class="control-label col-md-3">标题:</label>
                                 <div class="col-md-4">
                                     <input type="text" class="form-control" id="title" name="title">
									 <input type="hidden" id="graphId" name="graphId">
                                 </div>
                             </div>
                             <div class="form-group">
                                 <label class="control-label col-md-3">链接:</label>
                                 <div class="col-md-4">
                                     <input type="text" class="form-control"  id="url" name="url">
									 <input type="hidden" class="width_100"  id="type" name="type">
                                 </div>
                             </div>
                             <div class="form-group">
                                 <label class="control-label col-md-3">上传图片:</label>
                                 <div class="col-md-4">
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                          <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                              <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt="" /> </div>
                                          <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
                                          <div>
                                              <span class="btn default btn-file">
                                                  <span class="fileinput-new">选择图片</span>
                                                  <span class="fileinput-exists">修改</span>
                                                  <input type="file" id="imgFile" name="file"> </span>
                                              <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                          </div>
                                      </div>
                                 </div>
                             </div>
						</div>
						<div class="modal-footer">						
							<button class="btn" data-dismiss="modal" type="button">取消</button>
							<button class="btn green" data-dismiss="modal" type="button" id="saveDynamicGraph">确定</button>
	                   </div>
                   </div>
             </div>
		</form>
	</div>
		<div class="page2 dialog" style="height:580px;">
			<div class="modal-dialog modal-lg">
	            <div class="modal-content"> 
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">配置模块</h4>
					</div>
					<div class="modal-body">
						<ul id="fixedMenu">
						</ul>
					</div>
					<input type="hidden" id="menuType1" name="menuType1">
					<div class="modal-footer">						
						<button class="btn green" data-dismiss="modal" type="button" id="saveFixedMenu">确定</button>
						<button class="btn" data-dismiss="modal" type="button">取消</button>
		            </div>
            	</div>
            </div>
		</div>
		<div class="page3 dialog" style="height:580px;">
			<div class="modal-dialog modal-lg">
	            <div class="modal-content"> 
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						<h2>配置模块</h2>
					</div>
					<div class="modal-body">
						<ul id="configMenu">
						</ul>
						<input type="hidden" id="menuType2" name="menuType2">
					</div>
					<div class="modal-footer">						
						<button class="btn green" data-dismiss="modal" type="button" id="saveConfigMenu">确定</button>
						<button class="btn" data-dismiss="modal" type="button">取消</button>
		            </div>
            	</div>
            </div>
		</div>
	</div>
	<script src="<%=basePath%>assets/global/plugins/m_ajaxfileupload.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	jQuery(document).ready(function() { 
		loadSubMenu("systemManage"); 
		//选取当前菜单位置
		setActive("systemManage","setAPPHomePage");
			loadMiddleMenuList();
			loadBelowMenuList();
			loadDynamicGraphList();
			loadAddressList();
			$(".ad p em").on("click",function(){
				var _num=parseInt($(this).index());
				$(".ad ul").animate({"left":-360*_num},"slow");
				$(this).addClass("select").siblings().removeClass("select");
			})
			$(".pages em").on("click",function(){
				var _num=parseInt($(this).index());
				$(".phone_page").animate({"left":-400*_num},"slow");
				$(this).addClass("select").siblings().removeClass("select");
			})
			$("#saveDynamicGraph").on("click",function(){
				var type = $("#type").val();
				var url = $("#url").val();
				var title  = $("#title").val();
				var graphId  = $("#graphId").val();
				saveDynamicGraph(type,url,title,graphId);
			})
			
			$("#saveFixedMenu").on("click",function(){
				var menuType = $("#menuType1").val();
				var menuStatus = 1;
				var menuId = $("#fixedMenu .select").attr("menuid");
				var menuName = $("#fixedMenu .select").attr("menuname");
				var menuUrl = $("#fixedMenu .select").attr("menuurl");
				var menuIcon = $("#fixedMenu .select").attr("menuicon");
				var permissionCode = $("#fixedMenu .select").attr("permissioncode");
				saveFixedMenu(menuType,menuStatus,menuId,menuName,menuUrl,menuIcon,permissionCode);
				
			})
			
			$("#saveConfigMenu").on("click",function(){
				var menuType = $("#menuType2").val();
				var menuStatus = 2;
				var menuId = $("#configMenu .select").attr("menuid");
				var menuName = $("#configMenu .select").attr("menuname");
				var menuUrl = $("#configMenu .select").attr("menuurl");
				var menuIcon = $("#configMenu .select").attr("menuicon");
				var permissionCode = $("#configMenu .select").attr("permissioncode");
				saveFixedMenu(menuType,menuStatus,menuId,menuName,menuUrl,menuIcon,permissionCode);
				
			})
			$(".m_row").on("click",".fa-close",function(){
					$(this).siblings("a").empty().append("<i class='add_img icon-plus'></i>")
					$(this).remove();
					var menuId = $(this).attr("menuid");
					var menuType = $(this).attr("menutype");
					var menuStatus = $(this).attr("menustatus");
					deleteMenu(menuId,menuType,menuStatus);
			})
			
		});

		function getid(id,type,path,title,url,graphId)
		{
			$(".dialog").removeAttr("style");
			$(".page"+id+"").show();
			if(id==1)
			{
				$(".school_news_cover").attr("src","");
				if(path=="undefined")
				{
					path = "";
				}
				if(title=="undefined")
				{
					title = "";
				}
				if(url=="undefined")
				{
					url = "";
				}
				if(graphId=="undefined")
				{
					graphId = "";
				}
				$("#type").val(type);
				$("#url").val(url);
				$("#title").val(title);
				$("#graphId").val(graphId);
				$(".school_news_cover").attr("src",path);
			}
			if(id==2)
			{
				getMiddleMenuList();
				$("#menuType1").val(type);
			}
			if(id==3)
			{
				getBelowMenuList();
				$("#menuType2").val(type);
			}
			
		}

		function loadMiddleMenuList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>appHomePage/loadMiddleMenuList.do",
				data:{
					},
				success: function(data){
					var middleMenuList = $.parseJSON(data);
					var appendHtml = '';
					var length = middleMenuList.length;
					$.each(middleMenuList, function(n, value) {
						appendHtml += '<li><em class="fa fa-close" menuid="'+value.menuId+'" menutype="'+value.menuType+'" menustatus="'+value.menuStatus+'"></em>';
						appendHtml += '<a href="#small" data-toggle="modal" onclick="getid(2,'+value.menuType+')">';
						appendHtml += '<i class="fa '+value.menuIcon+'"></i>';
						appendHtml += '<p>'+value.menuName+'</p>';
						appendHtml += '</div></a></li>';
	       			}); 
	       			
	       			if(length<4)
	       			{
		       			for(length;length<4;length++)
		       			{
		       				appendHtml += '<li><a href="#small" data-toggle="modal" onclick="getid(2,'+(length+1)+')"><i class=" icon-plus"></i><div class="model" style="display:none"><img src=""><p>晨检</p></div></a></li>';
		       			}
	       			} 
	       			
	       			$("#middleMenu").html(appendHtml);
				},
			});
			
		}
		
	 
		function loadBelowMenuList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>appHomePage/loadBelowMenuList.do",
				data:{
					},
				success: function(data){
					var belowMenuList = $.parseJSON(data);
					var appendHtml = '';
					var length = belowMenuList.length;
					$.each(belowMenuList, function(n, value) {
						appendHtml += '<li><em class="fa fa-close" menuid="'+value.menuId+'" menutype="'+value.menuType+'" menustatus="'+value.menuStatus+'"></em>';
						appendHtml += '<a href="#small" data-toggle="modal" onclick="getid(3,'+value.menuType+')">';
						appendHtml += '<i class="fa '+value.menuIcon+'"></i>';
						appendHtml += '<p>'+value.menuName+'</p>';
						appendHtml += '</div></a></li>';
	       			}); 
	       			
	       			if(length<8)
	       			{
		       			for(length;length<8;length++)
		       			{
		       				appendHtml += '<li><a href="#small" data-toggle="modal" onclick="getid(3,'+(length+1)+')"><i class=" icon-plus"></i></a></li>';
		       			}
	       			} 
	       			
	       			$("#belowMenu").html(appendHtml);
				},
			});
		}
		
		function loadDynamicGraphList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>appHomePage/loadDynamicGraphList.do",
				data:{
					},
				success: function(data){
					var graphList = $.parseJSON(data);
					var appendHtml = '';
					var length = graphList.length;

					$.each(graphList, function(n, value) {
						appendHtml += '<li>';
						appendHtml += '<a href="#small" data-toggle="modal" onclick="getid(1,'+value.type+',\''+value.path+'\',\''+value.title+'\',\''+value.url+'\','+value.graphId+')">';
						appendHtml += '<img src="'+value.path+'">';
						appendHtml += '</a></li>';
	       			}); 
	       			
	       			if(length<3)
	       			{
		       			for(length;length<3;length++)
		       			{
		       				appendHtml += '<li><a href="#small" data-toggle="modal" onclick="getid(1,'+(length+1)+')"><i class="icon-plus"></i><img src="" style="display:none;"></a></li>';
		       			}
	       			} 
	       			
	       			$("#dynamic").html(appendHtml);
				},
			});
		}
		
		function loadAddressList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>appHomePage/loadAddressList.do",
				data:{
					},
				success: function(data){
					var addressList = $.parseJSON(data);
					var appendHtml = '';
					appendHtml += '<dd><i>&nbsp</i><em class="fa fa-user"></em><span>新的朋友</span></dd>';
					appendHtml += '<dd><i>&nbsp</i><em class="fa fa-users"></em><span>群组</span></dd>';
					$.each(addressList, function(n, value) {
						appendHtml += '<dd>';
						if(value.status==1)
						{
							appendHtml += '<i class="icon-ok fa fa-check" id="'+value.menuId+'"></i>';
						}else
						{
							appendHtml += '<i class="icon-ok" id="'+value.menuId+'"></i>';
						}
						appendHtml += '<em class="fa fa-phone-square"></em>';
						appendHtml += '<span>'+value.menuName+'</span>';
						appendHtml += '</dd>';
	       			}); 
	       			
	       			$("#address").html(appendHtml);

	       			$(".icon-ok").on("click",function(){
	    				if($(this).hasClass("fa fa-check")){
	    					$(this).removeClass("fa fa-check");
	    					updateAddressList($(this).attr("id"),2);
	    				}else{
	    					$(this).addClass("fa fa-check");
	    					updateAddressList($(this).attr("id"),1);
	    				}
	    			})
				},
			});
		}


		function getMiddleMenuList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>appHomePage/getMiddleMenuList.do",
				data:{
					},
				success: function(data){
					var middleMenuList = $.parseJSON(data);
					var appendHtml = '';
					appendHtml += '<li>';
					$.each(middleMenuList, function(n, value) {
						appendHtml += '<span class="firstmenu" menuid="'+value.id+'" menuname="'+value.name+'" menuurl="'+value.url+'" menuicon="'+value.icon+'" permissioncode="'+value.permissionCode+'">';
						appendHtml += '<i class="fa '+value.icon+'"></i>';
						appendHtml += '<p>'+value.name+'</p>';
						appendHtml += '</span>';
	       			}); 
					appendHtml += '</li>';
	       			$("#fixedMenu").html(appendHtml);

	       			$("#fixedMenu span").on("click",function(){
	    				$("#fixedMenu span").removeClass("select");
	    	 			$(this).addClass("select");
	    				
	    			})
				},
			});
			
		}
		
		function getBelowMenuList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>appHomePage/getBelowMenuList.do",
				data:{
					},
				success: function(data){
					var belowMenuList = $.parseJSON(data);
					var appendHtml = '';
					$.each(belowMenuList, function(n, value) {
						appendHtml += '<li>';
						appendHtml += '<span class="firstmenu" menuid="'+value.id+'" menuname="'+value.name+'" menuurl="'+value.url+'" menuicon="'+value.icon+'" permissioncode="'+value.permissionCode+'">';
						appendHtml += '<i class="fa '+value.icon+'"></i>';
						appendHtml += '<p>'+value.name+'</p>';
						appendHtml += '</span>';
						$.each(value.subMenuList, function(m, sub) {
							appendHtml += '<span class="secondmenu" menuid="'+sub.id+'" menuname="'+sub.name+'" menuurl="'+sub.url+'" menuicon="'+sub.icon+'" permissioncode="'+sub.permissionCode+'">';
							appendHtml += '<i class="fa '+sub.icon+'"></i>';
							appendHtml += '<p>'+sub.name+'</p>';
							appendHtml += '</span>';
		       			}); 
						appendHtml += '</li>';
	       			}); 
	       			$("#configMenu").html(appendHtml);

	       			$("#configMenu span").on("click",function(){
	    				$("#configMenu span").removeClass("select");
	    	 			$(this).addClass("select");
	    			})
				},
			});
			
		}

		function saveDynamicGraph(type,url,title,graphId)
		{
			$.ajaxFileUpload({
				url : '<%=basePath%>appHomePage/addDynamicGraph.do',
				secureuri : false,
				fileElementId :[ 'imgFile'],
				data:{
					type : type,
					url : url,
					graphId : graphId,
					title : title
				},
				dataType : 'json',
				success : function(d, status) {
					var data = eval('(' + d + ')');
					if(data)
					{
						loadDynamicGraphList();
					}
				},

			}) 
		}
		
		function saveFixedMenu(menuType,menuStatus,menuId,menuName,menuUrl,menuIcon,permissionCode)
		{
			$.ajax({
				type: "post",
				url : '<%=basePath%>appHomePage/addMiddleMenu.do',
				data:{
					menuType : menuType,
					menuStatus : menuStatus,
					menuId : menuId,
					menuName : menuName,
					menuUrl : menuUrl,
					menuIcon : menuIcon,
					permissionCode : permissionCode
				},
				success: function(data){
					var data = eval('(' + data + ')');
					if(data)
					{
						loadMiddleMenuList();
						loadBelowMenuList();
					}
				},

			}) 
		}
		
		function updateAddressList(menuId,status)
		{
			
			$.ajax({
				type: "post",
				url : '<%=basePath%>appHomePage/updateAddressList.do',
				data:{
					menuId : menuId,
					status : status
				},
				success: function(data){
					var data = eval('(' + data + ')');
					if(data)
					{
						loadAddressList();
					}
				},

			}) 
		}
		
		function deleteMenu(menuId,menuType,menuStatus)
		{
			$.ajax({
				type: "post",
				url : '<%=basePath%>appHomePage/deleteMenu.do',
				data:{
					menuId : menuId,
					menuType : menuType,
					menuStatus : menuStatus
				},
				success: function(data){
					var data = eval('(' + data + ')');
					if(data)
					{
						loadMiddleMenuList();
						loadBelowMenuList();
					}
				},

			}) 
		}
		
	</script>
	</html>