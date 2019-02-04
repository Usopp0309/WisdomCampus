<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>菜品列表</title>
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
	                <%@include file="/public_module/public_config.jsp" %>
	                    <ul class="page-breadcrumb">
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">平安校园</a><i class="fa fa-circle"></i></li>
	                        <li><span>菜品列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">菜品列表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
								</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<c:if test="${sessionScope.user.type != 2}">
												   
						    		<r:right rightCode="addDish">
										<button class="btn btn-default" type="button" id="addDish">增加</button>
									</r:right>
				      		 	</c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                                <input type="text" placeholder="菜名" class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
									<input type="hidden" id="type" value="${sessionScope.user.type}"/>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>菜品列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                           	<th>菜品图片</th>
												<th>菜品名称</th>
												<th>菜品类型</th>
												<th>点赞次数</th>
												<th>创建时间</th>
												<th>修改</th>
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
	                        <r:right rightCode="modifyRecipe"><input type="hidden" id="hasModifyPriv"></input></r:right>
							<r:right rightCode="deleteRecipe"><input type="hidden" id="hasDelPriv"></input></r:right>
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

		$(function() {    
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");

			//输入查询短信内容
			var queryContent = $("#queryContent").val();

			//加载初始化数据
			loadDishList(queryContent,null);
			
			//查找数据
			$("#search").click(function(){
				
				//输入查询条件
				var queryContent = $("#queryContent").val();

				loadDishList(queryContent,null);
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
		function loadDishList(queryContent,cPage)
		{
		
			var body = $("#body");
			App.blockUI(body);
			
			var hasModifyPriv = false;
			if ($("#hasModifyPriv").length > 0){
				hasModifyPriv = true;
			}else{
				hasModifyPriv = false;
			}

			var hasDelPriv = false;
			if ($("#hasDelPriv").length > 0){
				hasDelPriv = true;
			}else{
				hasDelPriv = false;
			}
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>recipe/loadDishList.do",
				data:{
						queryContent : queryContent,
						cPage : cPage
					},
				success: function(data){
					//解锁UI
          			App.unblockUI(body);
					var page = $.parseJSON(data);
					var appendHtml = '';
					if (page != null){
						$("#currentPage").html(page.currentPage);
						$("#totalPage").html(page.totalPage);
						$.each(page.list, function(n, value) {
							appendHtml += '<tr>';
							//菜品图片
	           				appendHtml += '<td width="35%" style="max-width:400px;word-break:break-all;text-align:left"><img src="http://121.199.27.191:18086/wisdomcampus/'+value.picPath+'/'+value.picName+'" /></td>';
							//菜品名称
							appendHtml += '<td width="10%">' + value.dishName + '</td>';
							if(value.dishType == '1'){
								//菜品类型 1、早餐 2、午餐 3、下午茶4、晚餐,5、其他
								appendHtml += '<td width="10%">早餐</td>';
							}else if(value.dishType == '2'){
								appendHtml += '<td width="10%">午餐</td>';
							}else if(value.dishType == '3'){
								appendHtml += '<td width="10%">下午茶</td>';
							}else if(value.dishType == '4'){
								appendHtml += '<td width="10%">晚餐</td>';
							}else if(value.dishType == '5'){
								appendHtml += '<td width="10%">其他</td>';
							}
							//点赞次数
	           				appendHtml += '<td width="10%">' + value.praiseCount + '</td>';
							//创建时间
	           				appendHtml += '<td width="10%">' + value.createTime + '</td>';
	           				appendHtml += '<td width="25%">';
	           				if (hasModifyPriv){
	            				appendHtml += '<a href="javascript:;" class="edit" onclick="modifyDish(' + value.id +')">修改</a>';
	            			}
	           				if (hasDelPriv){	
	            				appendHtml += ' <c:if test="${sessionScope.user.type != 2}">   <a href="javascript:;" class="edit" onclick="delDish(' + value.id + ')">删除</a></c:if>';
				   			}
	           				appendHtml += '</td>';
	           				appendHtml += '</tr>';



	          			}); 
					}
          			$("#tbody").html(appendHtml);
          			
          			
          			/* $(".search_box").css({"display":"none"}); */
          			if (null != cPage)
              		{
          				$("#currentPage").html(cPage);
              		}
          			
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
				var userId = $("ul li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("ul li.active").find('a').attr("attr2");

				loadDishList(queryContent,cPageInt);
				$("#currentPage").html(cPageInt);
		}

		
	</script>
</html>