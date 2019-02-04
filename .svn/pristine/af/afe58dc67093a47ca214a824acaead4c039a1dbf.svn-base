<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>无障碍异常记录</title>
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
	                        <li><a href="">平安校园</a><i class="fa fa-circle"></i></li>
	                        <li><span>无障碍异常记录</span></li>
	                    </ul>
	                </div>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12 m_padding_15_0_0_0">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<li class="roleLi">
										<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
										</a>
									</li>
								</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择时间：</span>
	                         		<input type="text" placeholder="选择时间" class="m_input form-control" id="startTime"/>
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
	                                    <i class="fa fa-list"></i>无障碍异常记录</div>
	                            </div>
	                            <div class="portlet-body">
                                    <div id="tbody">
                                    </div>
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
</html>
	<script>

		jQuery(document).ready(function() {  
			loadSubMenu("safeSchool");
			//选取当前菜单位置
			setActive("safeSchool","accessInoutAbnormal");  
			$('#startTime').datetimepicker({format:'Ymd',timepicker:false}); 
			var date = $("#startTime").val();
			loadAccessInoutAbnormalList(date,1);

			$("#search").click(function(){
				var date = $("#startTime").val();
				loadAccessInoutAbnormalList(date,1);

			});
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
			});
			
		});

		function layout(dom){
			var httpPath = $(dom).attr("attr");
			//页面层
			layer.open({
			  type: 1,
			  skin: 'layui-layer-rim', //加上边框
			  area: ['500px', '500px'], //宽高
			  content: '<img src="'+httpPath+'">'
			});
		}
		
		//加载无障碍通道异常记录列表
		function loadAccessInoutAbnormalList(date,cPage)
		{
			App.blockUI(body); 
			$.ajax({
				type: "post",
				url: "<%=basePath%>accessInout/getAccessInoutAbnormal.do",
				data:{
					date : date,
					cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					//解锁UI
          			App.unblockUI(body);
					var appendHtml = '';
					$.each(page.list, function(n, value) { 
						if((n==0) || (n%4==0&&n>=4)){
							appendHtml += '<div class="row-fluid" >';
						}
						appendHtml += '<div class="col-md-3 col-sm-3">';
						appendHtml += '<div class="item">';
						appendHtml += '<a data-toggle="modal" attr="'+value.httpPath+'" href="javascript:void(0)" onclick="layout(this)">';
						appendHtml += '<div class="zoom">';
						appendHtml += '<img src="'+value.httpPath+'" alt="" />';
						appendHtml += '</div>';
						appendHtml += '</a>';
						appendHtml += '</div>';
						appendHtml += '</div>';
						if((n==3) || (((n+1)%4==0)&&((n+1)>4))){
							appendHtml += '</div>';
						}
          			}); 
          			$("#tbody").html(appendHtml);
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
			//开始时间
			var date = $("#startTime").val()
			loadAccessInoutAbnormalList(date,cPageInt);
		    $("#currentPage").html(cPageInt);
		}
	</script>
</html>