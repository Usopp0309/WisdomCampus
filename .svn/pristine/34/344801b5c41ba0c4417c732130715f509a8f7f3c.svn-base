<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>电子卡管理</title>
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
	                        <li><span>电子卡管理</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">电子卡管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
									<c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'president'|| roleList.roleCode eq 'departManager'}">
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
	                        	<button class="btn btn-default" type="button" id="addCard" >增加</button>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
		                         <div class="row m_margin_10_auto">
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<span class="m_span">内容搜索：</span>
		                         		<input type="text" placeholder="电子卡号、持有者..." class="m_input form-control" id="queryContent"/>
		                         	</div>
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<button type="button" class="btn design_btn" id="search">查找</button>
										<input type="hidden" id="type" value="${sessionScope.user.type}"/>
		                         	</div>
		                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>电子卡管理</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>电子卡号</th>
													<th>持有者</th>
													<th>更新时间</th>
													<th>状态</th>
													<c:if test="${sessionScope.user.type != 2}">
														<th>操作</th>
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
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function() {   
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","cardManage"); 
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleId = $("#userTab li.active").find('a').attr("attr2");
			
			//加载初始化数据
			loadCardList(null, userId, roleId, null);
			//点击tab页加载
			$("#userTab li a").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleId = $(this).attr("attr2");
				loadCardList(null, userId, roleId, null);
			});

			//点击增加年级页面
			$("#addCard").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>card/toAddCard.do',{userId:userId,roleId:roleId});
			});
			
			//条件查询
			$("#search").click(function(){

				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				
				//电子卡号
				var queryContent = $("#queryContent").val();
				
			
				loadCardList(queryContent, userId, roleId, null);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});	
		});

		//加载电子卡页面
		function loadCardList(queryContent, userId, roleId, cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>card/getCardList.do",
				data:{
						queryContent : queryContent,
						userId : userId,
						roleId : roleId,
						cPage : cPage
				},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						
						appendHtml += '<tr>';
           				appendHtml += '<td>' + value.cardCode + '</td>';
           				if (null == value.ower)
               			{
           					appendHtml += '<td><span style="color:red;">暂无持有者</span></td>';
                   		}
           				else
               			{
           					appendHtml += '<td>' + value.ower + '</td>';
                   		}
           				var time = value.updatetime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
            			appendHtml += '<td>' + time + '</td>';
            			if(value.status==0){
            				appendHtml += '<td>停用</td>';
            			}else if(value.status==1){
            				appendHtml += '<td>在用</td>';	
            			}else if(value.status==2){
            				appendHtml += '<td>失效</td>';	
            			}else{
            				appendHtml += '<td>其它</td>';	
            			}
            			
            			if ($("#type").val() != '2'){
            				appendHtml += '<td><a href="javascript:;" onclick="modifyCard(' + value.id + ')" class="btn btn-sm update_btn">修改</a>';
            				appendHtml += '  <a href="javascript:;" onclick="deleteCard(' + value.id + ')"   class="btn btn-sm delete_btn">删除</a></td>';
            			}
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);

          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}
		
		//点击修改电子卡页面
		function modifyCard(cardId)
		{
			var userId = $("#userTab li.active").find('a').attr("attr1");	
			var roleId = $("#userTab li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>card/toModifyCard.do',{userId:userId,roleId:roleId,cardId:cardId});
		}
		function deleteCard(cardId){
			var ll=layer.confirm('确定要删除该卡号？', {
				  btn: ['确定','取消'] //按钮
				}, function(){
					layer.close(ll);
					var indexlayer = layer.msg('正在删除数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
					$.ajax({
						type: "post",
						url: "<%=basePath%>card/deleteCard.do",
						data:{
							cardId : cardId
						},
						success: function(data){
							debugger;
							var data = $.parseJSON(data);
							if (data.resultCode == "0"){
								layer.msg("删除成功!",{icon:1,time:1000});
								location.href="<%=basePath%>card/toCardList.do" ;
							}else{
								layer.msg("删除失败!",{icon:1,time:1000});	
							}
						}
							
					}); 
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
			var roleId = $("#userTab li.active").find('a').attr("attr2");
			loadCardList(null, userId, roleId, cPageInt);
			$("#currentPage").html(cPageInt);
		}

		//加载增加按钮
		function loadAddBtn(roleId)
		{
			//如果是系统管理员，超级管理员，校长，班主任则有增加权限
			var roleIdInt = parseInt(roleId);

			switch(roleIdInt)
			{ 
				case 1 : 
					$("#addCard").show();
					break; 
				case 2 : 
					$("#addCard").show(); 
					break; 
				case 3 : 
					$("#addCard").show(); 
					break; 
				case 4 : 
					$("#addCard").hide();
					break; 
				default : 
					$("#addCard").hide();
					break;
			} 
		}
	
	</script>
</html>