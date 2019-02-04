<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>权限管理</title>
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
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">系统管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>权限管理</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">权限管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                                <input type="text" placeholder="姓名、工号、手机号" id="queryContent" class="m_input form-control">
														
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button class="btn green" type="button" id="search">查找 </button>
									
	                         	</div>
	                         	
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>权限管理</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>工号</th>
												<th>姓名</th>
												<th>手机号码</th>
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
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function() {   
		   loadSubMenu("systemManage"); 
			//选取当前菜单位置
		   setActive("systemManage","permissionManage");     
		   loadTeacherList(null,null);
		  //条件查询
		  $("#search").click(function(){
			//查询条件
			var queryContent = $("#queryContent").val();
			
			loadTeacherList(queryContent, null);
		  });
		  
		  $("#queryContent").keypress(function(event){
				if(event.which == "13")    
          	{
					$("#search").click();
					return false;	
          	}
		 });	

		});

		//加载教师页面
		function loadTeacherList(queryContent, cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>permission/getAllTeacherList.do",
				data:{
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
           				appendHtml += '<td >' + value.code + '</td>';
            			appendHtml += '<td >' + value.realName + '</td>';
            			appendHtml += '<td>' + value.phone + '</td>';
            			appendHtml += '<td ><c:if test="${sessionScope.user.type != 2}"><a href="javascript:;" onclick="modifyPermission(' + value.userId +')">修改</a></c:if></td>';
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			
          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		//点击修改教师页面
		function modifyPermission(userId)
		{
			standardPost('<%=basePath%>permission/toModifyPermission.do',{userId:userId});
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
			//查询条件
			var queryContent = $("#queryContent").val();
			loadTeacherList(queryContent, cPageInt);
		    $("#currentPage").html(cPageInt);
		}
		
	</script>
</html>