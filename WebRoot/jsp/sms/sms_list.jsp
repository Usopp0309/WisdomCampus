<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>发送短信历史查看</title>
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
	                        <li><a href="">信息平台</a><i class="fa fa-circle"></i></li>
	                        <li><span>发送短信历史查看</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">发送短信历史查看</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode ne 'student' && roleList.roleCode ne 'parent' && roleList.roleCode ne 'other'}">
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
	                         		<span class="m_span">搜索内容：</span>
	                                <input type="text"  class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>发送短信历史查看</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_35">短信内容</th>
												<th class="m_width_10">发送人</th>
												<th class="m_width_15">发送时间</th>
												<th class="m_width_10">发送状态</th>
												<th class="m_width_10 hidden-sm hidden-md">发送类型</th>
												<th class="m_width_10 hidden-sm hidden-md hidden-lg">累计条数</th>
												<th class="m_width_10">查看详情</th>
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
		jQuery(document).ready(function(){  
			loadSubMenu("informationPlatform"); 
			//选取当前菜单位置
			setActive("informationPlatform","smsShow");  
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			//输入查询短信内容
			var queryContent = $("#queryContent").val();
			//加载初始化数据
			loadSmsList(userId, roleCode,queryContent,null);
			App.init();
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadSmsList(userId, roleCode,null,null,null);
			});
			//查找数据
			$("#search").click(function(){
				//输入查询条件
				var queryContent = $("#queryContent").val();
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				loadSmsList(userId, roleCode,queryContent,null);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;	
            	}
			});	

		});

		//加载信息列表
		function loadSmsList(userId, roleCode, queryContent,cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>sms/loadSmsList.do",
				data:{
						userId : userId,
						roleCode : roleCode,
						queryContent : queryContent,
						cPage : cPage
					},
				success: function(data){
					
					var page = eval("(" + data + ")");
					
					$("#currentPage").html(page.currentPage);
					
					$("#totalPage").html(page.totalPage);
					
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
						//短信内容
           				appendHtml += '<td style="overflow:hidden;">' + value.content + '</td>';
						//发送人
           				appendHtml += '<td >' + value.senderName + '</td>';
						//发送时间
           				var time = value.sentTime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
           				appendHtml += '<td>' + time + '</td>';
						//发送状态
           				var result = parseInt(value.result);
           				
           				switch(result)
           				{ 
           					case 0 : 
           						appendHtml += '<td>发送成功</td>';
           						break; 
           					case 6 : 
           						appendHtml += '<td>短信内容为空</td>';
           						break; 
           					case 7 : 
           						appendHtml += '<td>号码为空</td>';
           						break; 
           					case 99 : 
           						appendHtml += '<td>系统内部错误</td>';
           						break; 
           					default : 
           						appendHtml += '<td>待发送</td>';
           						break;
           				}
           				
           				//发送类型
           				var type = parseInt(value.type);
           				//0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知 4:校车 5:作业发布
           				switch(type)
           				{ 
           					case 0 : 
           						appendHtml += '<td class="hidden-sm hidden-md">教师短信服务</td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td class="hidden-sm hidden-md">学生短信服务</td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td class="hidden-sm hidden-md">成绩下发</td>';
           						break; 
           					case 3 : 
           						appendHtml += '<td class="hidden-sm hidden-md">会议通知</td>';
           						break; 
           					case 4 : 
           						appendHtml += '<td class="hidden-sm hidden-md">校车</td>';
           						break; 
           					case 5 : 
           						appendHtml += '<td class="hidden-sm hidden-md">作业发布</td>';
           						break; 
           				}
           				//累计成功短信总数
           				var num =  value.smsSum ;
           				if (typeof(num) == "undefined"){
           					num = 0;
           				}
           				appendHtml += '<td class="hidden-sm hidden-md hidden-lg">' + num + '</td>';
           				
           				//查看详情
           				appendHtml += '<td><a onclick="smsDetail(' + value.id +','+value.type + ')">详情</a></td>';
						
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
          			/* if (null != cPage)
              		{
          				$("#currentPage").html(cPage);
              		} */
          			
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

				//输入查询条件
				var queryContent = $("#queryContent").val();
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");

				loadSmsList(userId, roleCode,queryContent,cPageInt);
				$("#currentPage").html(cPageInt);
		}
		
		function smsDetail(id,type)
		{
		    standardPost('<%=basePath%>sms/toSmsDetailView.do',{id:id,type:type});
		}

		
	</script>
</html>