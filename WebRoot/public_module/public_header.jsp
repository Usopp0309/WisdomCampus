<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<div class="page-header navbar navbar-fixed-top">
            <div class="page-header-inner ">
                <div class="page-logo">
                    <a href="index.html">
                        <img src="<%=basePath %>assets/global/img/m_img/logo_main.png" class="logo-default" /></a>
                    <div class="menu-toggler sidebar-toggler"> </div>
                </div>
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
                <div class="top-menu">
                    <ul class="nav navbar-nav pull-right">
                        <li class="dropdown dropdown-extended dropdown-tasks" id="header_task_bar">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="fa fa-bell"></i>
                                <span class="badge badge-warning" id="unReadNum1">0</span>
                            </a>
                            <ul class="dropdown-menu extended tasks">
                                <li class="external"><h3>您共有<span class="bold" id="unReadNum2">0</span>条信息等待处理</h3></li>
                                <li>
                                    <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
                                        <li class="external" id="external">
                                        <a id="clickMe" href="<%=basePath %>online-message/toOnlineMessageCenter.do">查看所有留言 <i class="m-icon-swapright"></i></a>
								       </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="<%=basePath %>user/doLogin.do" class="m_header_home">
								返回主页
                            </a>
                        </li>
                       
                        <li class="dropdown dropdown-extended dropdown-tasks">
                                <c:choose>
                                	<c:when test="${sessionScope.schoolList.size() > 1}">
                                		<c:forEach items="${sessionScope.schoolList}" var="school">
													<c:if test="${school.schoolId eq sessionScope.user.schoolId}">
                            							<a href="javascript:;" class="dropdown-toggle" style="padding:14px 6px 12px 8px" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
															<i class="m_font_style_normal username username-hide-on-mobile school_name" style="font-size:14px">${school.schoolName}</i>
                            							</a> 
													</c:if>
										</c:forEach>
                                	</c:when>
                                	<c:otherwise>
                                	</c:otherwise>
                                </c:choose>
                                
                            <c:if test="${sessionScope.schoolList.size() > 1 && sessionScope.user.username ne 'sysadmin'}">
	                       		<ul class="dropdown-menu extended tasks">
	                                <c:forEach items="${sessionScope.schoolList}" var="school">
											<li class="roleLi">
												<a href="javascript:changeSchool(${school.schoolId })" class="roleTab" >${school.schoolName}</a>
											</li>
									</c:forEach>
	                            </ul>
                            </c:if>
                        </li>
                      
                        <li class="dropdown dropdown-user">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <c:if test="${fn:indexOf(resourceUser.headImg,'http')>-1}">
				                 <img alt="" class="img-circle" src="${sessionScope.user.headImg }" onerror="../assets/layouts/layout/img/avatar.png" />
				                 </c:if>
				                 <c:if test="${fn:indexOf(resourceUser.headImg,'http')==-1}">
				                 <img alt="" class="img-circle" src="<%=Cons.HEADIMGBASEPATH%>${sessionScope.user.headImg }" onerror="../assets/layouts/layout/img/avatar.png"/>
				                 </c:if>
                                <span class="username username-hide-on-mobile">${sessionScope.user.realName}</span>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                               <!--  <li><a href=""><i class="icon-user"></i>个人中心 </a></li>
                                <li><a href=""><i class="icon-calendar"></i>锁屏 </a></li> -->
                                <li><a href="javascript:void(0)" onclick="toLoginOut();"><i class="fa fa-key"></i>退出</a></li>
                            </ul>
                        </li>
                        <!-- 聊天按钮 -->
                        <!-- <li class="dropdown dropdown-quick-sidebar-toggler">
                            <a href="javascript:;" class="dropdown-toggle">
                                <i class="icon-logout"></i>
                            </a>
                        </li> -->
                          <!-- 聊天按钮 -->
                    </ul>
                </div>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END HEADER INNER -->
            <script src="<%=basePath%>assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        </div>
        <script>
    	refreshOnlineMessage();
		//切换学校
		function changeSchool(schoolId){
			 $.ajax({
					
					url: "<%=basePath%>user/toChangeSchool.do",
					data:{
						schoolId : schoolId
					},
		            success: function(data)
		            {
		                var data = $.parseJSON(data);
		                if( 0 == data.status)
		                {   
		                    window.location.href = "<%=basePath%>user/toHomePage.do";
		                }
		            }
			    });
			  
		}
      //登出
        function toLoginOut()
        {
            $.ajax({
        			
        		url: "<%=basePath%>user/toLoginOut.do",
                success: function(data)
                {
                    var reg = eval("(" + data + ")");
                    if( "true" == reg)
                    {   
                        window.location.href = "<%=basePath%>login.jsp";
                    }
                }
            });
        }
       //未读在线留言
		function refreshOnlineMessage() {
				$.ajax({
					type: "post",
					url: "<%=basePath%>online-message/unReadOnlineMessage.do",
					dataType:"json",
					success: function(page){
						var appendHtml = '';
						if (page != null){
							var unReadOnlineMessageCount=page.count;
							$("#unReadNum1").text(unReadOnlineMessageCount);
							$("#unReadNum2").text(unReadOnlineMessageCount);
							$.each(page.list, function(n, value) {
								if(value.content!='' && value.content.length>10){
									appendHtml +='<li><a href="javascript:void(0);">'+value.content.substring(0,10)+'...<span style="float:right;">'+value.timeInterval+'</span></a></li>';		
								}else{
									appendHtml +='<li><a href="javascript:void(0);">'+value.content+'<span style="float:right;">'+value.timeInterval+'</span></a></li>';	
								}
		          			}); 
						}
	          			$("#external").before(appendHtml);
					},
				});
		} 
        </script>