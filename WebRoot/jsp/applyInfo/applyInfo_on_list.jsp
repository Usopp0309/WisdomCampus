<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>招生信息列表</title>
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
	                        <li><a href="">信息发布管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>招生信息列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">招生信息列表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
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
	                       	<form action="<%=basePath%>check/loadTeacherCheckList.do" class="form-horizontal" method="post">
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择时间：</span>
	                         		<input type="text" id="selectTime" class="form-control m_input"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择状态：</span>
	                         		<select id="status" class="form-control m_select" >
										<option value="-1" >全部</option>
										<option value="0">查看</option>
										<option value="1">未查看</option>
								    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" placeholder="姓名，手机号..." class="form-control m_input" id="queryContent"/>
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
	                                    <i class="fa fa-list"></i>招生信息列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                        <th class="m_width_20">招生内容</th>
										    <th class="m_width_5">姓名</th>
										    <th class="m_width_5 hidden-sm hidden-md">性别</th>
										    <th class="m_width_5 hidden-sm hidden-md">推荐人</th>
										    <th class="m_width_10">联系电话</th>
										    <th class="m_width_10 hidden-sm hidden-md">出生年月</th>
										    <th class="m_width_15">申请时间</th>
										    <th class="m_width_5">操作</th>
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
			loadSubMenu("siguUpManager"); 
			//选取当前菜单位置
			setActive("siguUpManager","signUpInfoManager");     
			$('#selectTime').datetimepicker({format:'Y-m-d',timepicker:false});
			//选择第一个tab
			$("#userTab li:first").addClass("active");
	
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			
			//加载初始化数据   
			loadSignUpOnList(null,null, null, null);
			
			App.init();
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadSignUpOnList(null, null, null,null);
			});
			
			//查找数据
			$("#search").click(function(){
				var selectTime = $("#selectTime").val();
				var queryContent = $("#queryContent").val();
				var status = $("#status").val();
				loadSignUpOnList(queryContent,selectTime,status,null);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
            	}
			});
		});

		//加载校车记录列表
		function loadSignUpOnList(queryContent,createTime,status, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>applyInfo/getApplyInfoListInfo.do",
				data:{
						queryContent : queryContent,
						createTime : createTime,
						status : status,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
						var title = value.newsTitle;
						if(title.length>16){
							title = title.substring(0,16)+"...";
						}
						//招生信息
       				    appendHtml += '<td><a href="javascript:void(0)" title="'+value.newsTitle+'" onclick="locationHref(\''+value.newsId+'\')">' + title + '</a></td>'; 

						//姓名
						appendHtml += '<td>' + value.userName + '</td>';
						if(value.sex=="0"){
       						appendHtml += '<td class="hidden-sm hidden-md">男</td>';
						}else if(value.sex=="1"){
       						appendHtml += '<td class="hidden-sm hidden-md">女</td>';
						}
						//推荐人
						if(value.referrer=="" || value.referrer=="null" || value.referrer==undefined){
           					appendHtml += '<td class="hidden-sm hidden-md"></td>';
						}else{
							appendHtml += '<td class="hidden-sm hidden-md">'+value.referrer+'</td>';
						}

						//电话
						appendHtml += '<td>'+value.phone+'</td>';
						//出生年月
						appendHtml += '<td class="hidden-sm hidden-md">'+value.birth+'</td>';
						//家庭住址
						/* appendHtml += '<td class="message_content hidden-sm hidden-md">'+value.address+'</td>';
						//备注
						if(value.remark=="" || value.remark=="null" || value.remark==undefined){
           					appendHtml += '<td class="hidden-sm hidden-md"></td>';
						}else{
							appendHtml += '<td class="message_content hidden-sm hidden-md">'+value.remark+'</td>';
						} */
						
						appendHtml += '<td>'+value.createTime+'</td>';
						
						//状态
						if(value.status== 0)
						{
           					appendHtml += '<td><a id="status'+value.id+'" class="btn btn-sm green" onclick="lookOver('+value.id+')">查看</a></td>';
						}else if(value.status== 1){
							appendHtml += '<td>已查看</td>';
						}else{
							appendHtml += '<td></td>';
						}
						
           				appendHtml += '</tr>';
          			}); 
          			
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		function lookOver(id){
			$.ajax({
				type: "post",
				url: "<%=basePath%>applyInfo/lookOver.do",
				data:{
						id : id
					},
				success: function(data){
					var page = eval("(" + data + ")");
					if(page)
					{
						$("#status"+id).parent().text("已查看");
						$("#status"+id).remove();
					}
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
			var queryContent = $("#queryContent").val();	
			var selectTime = $("#selectTime").val();
			var status = $("#status").val();
					
			loadSignUpOnList(queryContent, selectTime,status, cPageInt);
			
			$("#currentPage").html(cPageInt);
		}
	</script>
</html>