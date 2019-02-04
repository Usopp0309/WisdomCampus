<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>学校新闻列表</title>
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
	                        <li><a href="">校园新闻</a><i class="fa fa-circle"></i></li>
	                        <li><span>学校新闻列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">学校新闻列表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi">
											<a  attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})</a>
										</li>
									</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="<%=basePath%>check/loadTeacherCheckList.do" class="form-horizontal" method="post">
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择类型：</span>
		                                 <select class="form-control m_select" id="newsType" name="newsType">
											<option value="0">全部</option>
											<option value="1">校园新闻</option>
											<option value="2">学校活动</option>
											<option value="3">学校招生信息</option>
											<option value="4">家长课堂</option>
											<option value="5">班级每日活动</option>
									    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择时间：</span>
	                         		<input type="text" id="selectTime" class="m_input form-control"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		 <button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>学校新闻列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_35">新闻标题</th>
											    <th class="m_width_10">发布人</th>
											    <th class="m_width_5  hidden-sm hidden-md">状态</th>
											    <th class="m_width_10 hidden-sm hidden-md">类型</th>
											    <th class="m_width_20">时间</th>
											    <th class="m_width_10">操作</th>
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
	<script src="<%=basePath%>assets/global/plugins/layer/layer.js" type="text/javascript"></script>
	<script>
		jQuery(document).ready(function() {
			loadSubMenu("campusNewsManager"); 
			//选取当前菜单位置
			setActive("campusNewsManager","schoolNewsLook");  
			$('#selectTime').datetimepicker({format:'Y-m-d',timepicker:false});
	
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			
			//加载初始化数据   
			loadSchoolNews(null, null, null, null);
			
			App.init();
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadSchoolNews(null, null, null, null);
			});

		
			
			//查找数据
			$("#search").click(function(){
				var selectTime = $("#selectTime").val();
				var queryContent = $("#queryContent").val();
				var newsType = $("#newsType").val();
				loadSchoolNews(queryContent,selectTime,newsType,null);
				
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
            	}
			});
		});

		//加载新闻
		function loadSchoolNews(queryContent,createTime,newsType,cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolNewsLook/getSchoolNews.do",
				data:{
						newsContent : queryContent,
						createTime : createTime,
						newsType : newsType,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						
						appendHtml += '<tr>';
							
						//标题
       				    appendHtml += '<td><a href="javascript:void(0)" onclick="locationHref(\''+value.newsId+'\')">' + value.newsTitle + '</a></td>'; 
						//创建人
						appendHtml += '<td>' + value.createUserName + '</td>';
						
						//发布状态
						if(value.status=="1"){
           					appendHtml += '<td class=" hidden-sm hidden-md">已发布</td>';
						}else{
           					appendHtml += '<td class=" hidden-sm hidden-md">未发布</td>';
						}
						//发布类型
						if(value.newsType=="1"){
	           				appendHtml += '<td class=" hidden-sm hidden-md">校园新闻</td>';
						}else if(value.newsType=="2")
						{
           					appendHtml += '<td class=" hidden-sm hidden-md">学校活动</td>';
						}else if(value.newsType=="3")
						{
           					appendHtml += '<td class=" hidden-sm hidden-md">学校招生信息</td>';
						}else if(value.newsType=="4")
						{
           					appendHtml += '<td class=" hidden-sm hidden-md">家长课堂</td>';
           				}else if(value.newsType=="5")
               			{
           					appendHtml += '<td class=" hidden-sm hidden-md">班级每日活动</td>';
               			}else
               			{
							appendHtml += '<td class=" hidden-sm hidden-md">未指定类型</td>';
						}
						appendHtml += '<td>'+value.createTime+'</td>';

						appendHtml += '<td><a href="javascript:;" onclick="deleteSchoolNews(' + value.newsId + ')">删除</a></td>';

           				appendHtml += '</tr>';
          			}); 
          			
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		function locationHref(id){
			window.open("<%=basePath%>schoolNewsLook/forwardDetail.do?newsId="+id);
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
			var selectTime = $("#selectTime").val();
			var queryContent = $("#queryContent").val();
			var newsType = $("#newsType").val();
			loadSchoolNews(queryContent,selectTime,newsType,cPageInt);
			
			$("#currentPage").html(cPageInt);
		}

		
		function deleteSchoolNews(newsId)
		{
			var l_=layer.confirm('确定删除？一旦删除数据不可恢复！',
					 {btn: ['确定','取消'] //按钮
			}, function(){
					var d_ = layer.msg('正在删除数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
					 $.ajax({
				           type:"post",
				           url: "<%=basePath%>schoolNewsRelease/deleteSchoolNews.do",
						   data:{
							   newsId : newsId
						   },
				           error:function(){ 
					           layer.close(l_);
					           layer.close(d_);
					       },
				           success:function(data){
				        	   var date = eval("(" + data + ")");
								if(date)
								{
									$('#myModal').modal('hide');
									var createTime = $("#selectTime").val();
									var queryContent = $("#queryContent").val();
									var newsType = $("#newsType").val();
									loadSchoolNews(queryContent,createTime,newsType,null)
					        	    layer.close(l_);
					        	    layer.close(d_);
								}
				        	   
				           }
				    }); 
				}, function(){
				  layer.close(l_);
				});
			
		}
	</script>
</html>