<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>校车记录</title>
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
	                        <li><a href="">校车管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>校车记录</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">校车记录</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})</a>
										</li>
									</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<c:if test="${sessionScope.user.type != 2}">
									<button class="btn btn-default" type="button" id="export">导出</button>
							    </c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择类型：</span>
	                         		<select class="m_select form-control" id="type" name="type">
										<option value="1" selected="selected">学生</option>
										<option value="2">家长</option>
										<option value="3">司机</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择班级：</span>
	                         		<select class="m_select form-control" id="clazzList"></select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">搜索</button>
	                         	</div>
	                         </div>
	                         
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>校车记录列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                           <th>班级</th>
											    <th class="hidden-sm hidden-md">角色</th>
												<th>卡号</th>
												<th>拥有者</th>
												<th>状态</th>
												<th class="hidden-sm hidden-md">设备号</th>
												<th class="hidden-sm hidden-md hidden-lg">司机</th>
												<th>校车轨迹</th>
												<th>创建时间</th>
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
	<script>
		jQuery(document).ready(function() { 
			loadSubMenu("schoolBusManage"); 
			//选取当前菜单位置
			setActive("schoolBusManage","schoolBusDetail");   
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			//类型
			var type = $("#type").val();
			
			//加载初始化数据   
			loadSchoolBusOnList(null,null, type, userId, roleCode, null);
			
			//加载班级信息
			loadclazzList(userId, 'schoolBusOnManager');
			
			selectClass(roleCode);
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				//类型
				var type = $("#type").val();
				loadSchoolBusOnList(null, null, type, userId, roleCode, null);

				//初始化select
				$("#type").val('0');
				$("#clazzList").val('0');
			});
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
				
				//班级ID
				var clazzId = $("#clazzList").val();
				
				if (clazzId != 0)
				{
					loadSchoolBusOnList(clazzId, queryContent, type ,userId, roleCode, null);
				}
				else
				{
					loadSchoolBusOnList(null, queryContent, type, userId, roleCode, null);
				}
				
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
            	}
			});
			
			//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#clazzList").change(function(){
			
				//查询条件
				var queryContent = $("#queryContent").val();	
				
				//类型
				var type = $("#type").val();
					
				//班级ID
				var clazzId = $(this).val();
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (clazzId != 0)
				{
					loadSchoolBusOnList(clazzId, queryContent, type ,userId, roleCode, null);
				}
				else
				{
					loadSchoolBusOnList(null, queryContent, type, userId, roleCode, null);
				}
			});
			
			//导出数据
			$("#export").click(function(){
				//卡号
				//var code = $("#code").val();
				//拥有者
				//var name = $("#name").val();
				//地点
				var queryContent = $("#queryContent").val();
				//师生类型
				var type = $("#type").val();
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>schoolbus/doExportExcel.do',{queryContent:queryContent,type:type,userId:userId,roleCode:roleCode});
				});
		});

		//加载校车记录列表
		function loadSchoolBusOnList(clazzId,queryContent, type, userId, roleCode, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/loadSchoolBusOnList.do",
				data:{
						queryContent : queryContent,
						clazzId : clazzId, 
						type : type,
						userId : userId,
						roleCode : roleCode,
						permissionCode : "schoolBusOnManager",
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						
						appendHtml += '<tr>';
						
						
						if (value.clazzName == null)
						{
							appendHtml += '<td ></td>';
						}
						else
						{
							//班级
           				    appendHtml += '<td>' + value.clazzName + '</td>'; 
						}
						
           				if (value.roleName == null)
						{
							appendHtml += '<td class="hidden-sm hidden-md"></td>';
						}
						else
						{
							//角色
           				    appendHtml += '<td class="hidden-sm hidden-md">' + value.roleName + '</td>'; 
						}
						
						//卡号
           				appendHtml += '<td  name="cardId">' + value.code + '</td>';
						//拥有着
           				appendHtml += '<td  class="'+value.userId+'" name="userId">' + value.realName + '</td>';
				
						//进出状态
           				var status = parseInt(value.status);
           				switch(status)
           				{ 
           				    case 0 : 
	       						appendHtml += '<td  name="shuaka">刷卡</td>';
	       						break; 
           					case 1 : 
           						appendHtml += '<td  name="shuaka">上车</td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td name="shuaka">下车</td>';
           						break; 
           					default : 
           						appendHtml += '<td  name="shuaka">刷卡</td>';
           						break;
           				}
           				
						//地点
           				appendHtml += '<td class="hidden-sm hidden-md" name="projectId">' + value.position + '</td>';
           				
           				if (value.driverName == null)
						{
							appendHtml += '<td class="hidden-sm hidden-md hidden-lg"></td>';
						}
						else
						{
							//班级
           				    appendHtml += '<td class="hidden-sm hidden-md hidden-lg">' + value.driverName + '</td>'; 
						}
           				
           				//司机
           				//appendHtml += '<td class="hidden-sm hidden-md hidden-lg">' + value.driverName + '</td>';
           				appendHtml += '<td>';
           				if(value.isShow){
           					appendHtml += '<a href="javascript:void(0)" name="'+value.isZoudu+'" onclick="mapInfo(this)">查看轨迹</a>';
           				}
           				appendHtml += '</td>';
						//创建时间
           				appendHtml += '<td name="createTime">' + value.createTime + '</td>';
           				appendHtml += '</tr>';
          			}); 
          			
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
          			
				},
			});
		}
		function mapInfo(obj){
			var userId=$(obj).parent().parent().find("[name='userId']").attr("class");
			var cardId=$(obj).parent().parent().find("[name='cardId']").html();
			var positionId=$(obj).parent().parent().find("[name='projectId']").html();
			var createTime=$(obj).parent().parent().find("[name='createTime']").html();
			var shuaka=$(obj).parent().parent().find("[name='shuaka']").html();
			var isZoudu=$(obj).attr("name");
			var url="<%=basePath%>locationInfo/showLocationInfo.do?cardId="+cardId+"&isZoudu="+isZoudu+"&userId="+userId+"&positionId="+positionId+"&createTime="+createTime+"&shuaka="+shuaka+"&roleCode="+$("ul li.active").find('a').attr("attr2");
			//location.href=url;
			window.open(url);
 			//$("#mainPage",parent.document).attr("src",url);
 		}

		// 加载班级列表
		function loadclazzList(userId, permissionCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadClazzList.do",
				data:{
						userId : userId,
						permissionCode : permissionCode,
						
					},
				success: function(data){

					var clazzList = eval("(" + data + ")");
					
					var appendHtml = '<option value="0">--选择班级--</option>';

					$.each(clazzList, function(n, value) {
						var type = value.type;
						if(type==0){
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}else if(type == 1){
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}else if(type == 2){
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}else if(type == 3){
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}else{
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}
           				
           			});  
					 
           			$("#clazzList").html(appendHtml);
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
			var userId = $("#userTab li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			
			//查询条件
			var queryContent = $("#queryContent").val();	
				
			//类型
			var type = $("#type").val();
					
			//班级ID
			var clazzId = $("#clazzList").val().replace("C", "");
			
			//clazzId为0表示选择所有班级，不为0表示选择某个班级
			if (clazzId != 0)
			{
				loadSchoolBusOnList(clazzId, queryContent, type ,userId, roleCode, cPageInt);
			}
			else
			{
				loadSchoolBusOnList(null, queryContent, type, userId, roleCode, cPageInt);
			}
			
			$("#currentPage").html(cPageInt);
		}

		//加载师生选择select
		function selectClass(roleCode)
		{
			//如果是学生则不显示班级
			if(roleCode == "student")
			{
				$("#selectClass").hide();
			}else
			{
				$("#selectClass").show();
			}
		}
	</script>
</html>