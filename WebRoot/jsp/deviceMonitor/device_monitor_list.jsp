<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>设备监控</title>
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
	                        <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>设备监控</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">设备监控</h3>
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
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">工作状态：</span>
	                         		<select class="m_input form-control" id="type">
										<option value="0" selected="selected">请选择</option>
										<option value="1">工作</option>
										<option value="2">关闭</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" id="queryContent" placeholder="请输入设备号" class="m_input form-control"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn design_btn" id="search">查找</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>设备监控</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <div class="row" id="tbody"></div>
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
	<script>
		jQuery(document).ready(function() {    
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","deviceMonitor"); 
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
	
			//加载初始化数据   
			loadSchoolBusDevice(null,null, userId, roleCode, null);
			
			
			//setTimeout("self.location.reload();",1000);
			
				setInterval("refreshOnlineMessage()", 300000);
			//查找数据
			$("#search").click(function(){
				//卡号
				var queryContent = $("#queryContent").val();
				
				//类型
				var type = $("#type").val();
				
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				
				loadSchoolBusDevice(queryContent,type, userId, roleCode, null);
				
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});
			
		});
		
		//未读在线留言
		function refreshOnlineMessage() {
			//用户ID
			var userId = $("#userTab li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			
			//查询条件
			var queryContent = $("#queryContent").val();	
				
			//类型
			var type = $("#type").val();
			
			loadSchoolBusDevice(queryContent,type, userId, roleCode, null);
			
		} 
		
       

		//加载校车设备状态列表
		function loadSchoolBusDevice(queryContent,type, userId, roleCode, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>deviceMonitor/loadDeviceMonitorList.do",
				data:{
						queryContent : queryContent,
						type : type,
						userId : userId,
						roleCode : roleCode
					},
				success: function(data){
					var page = eval("(" + data + ")");
					
					var appendHtml = '';
					$.each(page, function(n, value) { 

						//设备开启状态
           				var status = parseInt(value.status); 
           				if(status == 1)
               			{	
           					appendHtml += '<div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 margin-bottom-10">';
           					appendHtml += '<div class="dashboard-stat green">';
           					appendHtml += '<div class="visual">';
           					appendHtml += '<i class="fa fa-bus fa-icon-medium"></i>';
           					appendHtml += '</div>';
           					appendHtml += '<div class="details">';
           					appendHtml += '<div class="number"> 工作</div>';
           					appendHtml += '<div class="desc"> 设备号：<span class="title">' + value.code + '</div>';
           					appendHtml += '</div>';
           					appendHtml += '<a class="more">';
           					if(value.time==undefined)
       						{
    							appendHtml += '续航时间：<span class="time"></span>';
       						}else
	   						{
	        					appendHtml += '续航时间：<span class="time">' + value.time + '</span>';
	   						}
           					if(value.createTime==undefined)
       						{
    							appendHtml += '开启时间：';
       						}else
	   						{
       							appendHtml += '开启时间：' + value.createTime + '';
	   						}
           					appendHtml += '</a>';
           					appendHtml += '</div>';
           					appendHtml += '</div>';
           					
                   		}else if(status == 2)
                       	{
                   			appendHtml += '<div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 margin-bottom-10">';
           					appendHtml += '<div class="dashboard-stat red">';
           					appendHtml += '<div class="visual">';
           					appendHtml += '<i class="fa fa-bus fa-icon-medium"></i>';
           					appendHtml += '</div>';
           					appendHtml += '<div class="details">';
           					appendHtml += '<div class="number">关闭</div>';
           					appendHtml += '<div class="desc"> 设备号：<span class="title">' + value.code + '</div>';
           					appendHtml += '</div>';
           					appendHtml += '<a class="more"><span>';
           					if(value.time==undefined)
       						{
    							appendHtml += '续航时间：';
       						}else
	   						{
	        					appendHtml += '续航时间：' + value.time + '</span>';
	   						}
           					appendHtml += '<span>';
           					if(value.createTime==undefined)
       						{
    							appendHtml += '开启时间：';
       						}else
	   						{
       							appendHtml += '开启时间：' + value.createTime + '</span>';
	   						}
           					appendHtml += '</a>';
           					appendHtml += '</div>';
           					appendHtml += '</div>';
                       	}
                       	
          			}); 
					
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
				},
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
					
			//用户ID
			var userId = $("ul li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("ul li.active").find('a').attr("attr2");
			
			//查询条件
			var queryContent = $("#queryContent").val();	
				
			//类型
			var type = $("#type").val();
					
			
			loadSchoolBusDevice(queryContent,type, userId, roleCode, cPageInt);
			
			$("#currentPage").html(cPageInt);
		}

		//加载师生选择select
		function loadTchStuSelect(roleCode)
		{
			//如果是系统管理员，超级管理员，校长，班主任则有选择权限
			var roleCodeInt = parseInt(roleCode);

			switch(roleCodeInt)
			{ 
				case 1 : 
					$("#tchStuType").show();
					break; 
				case 2 : 
					$("#tchStuType").show(); 
					break; 
				case 3 : 
					$("#tchStuType").show(); 
					break; 
				case 4 : 
					$("#tchStuType").show();
					$("#clazzList").hide();
					break; 
				case 5 : 
					$("#tchStuType").hide();
					break; 
				case 6 : 
					$("#tchStuType").hide();
					break; 
				case 7 : 
					$("#tchStuType").hide();
					break; 
				default : 
					$("#tchStuType").hide();
					break;
			} 
		}
	</script>
	</html>