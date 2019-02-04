<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>我的会议</title>
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
	                        <li><a href="">会议管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>会议记录</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">会议记录</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs" id="userTab">
									<c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
											<li class="roleLi">
												<a data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
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
	                         		<span class="m_span">选择类型：</span>
                                    <select class="form-control m_select" name="place"  tabindex="1" id="meetingConditionSelect">
                                         <option value="0">请选择查询条件</option>
                                         <option value="1">会议名称</option>
                                         <option value="2">会议地点</option>
                                    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" name="content" class="m_input form-control" id="content"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		 <button type="submit" class="btn design_btn" id="search">搜索</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>会议记录</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover" id="sample_1">
	                                    <thead class="flip-content">
	                                        <tr>
	                                          	<th class="m_width_15">会议名称</th>
	                                          	<th class="m_width_40">会议内容</th>
	                                          	<th class="m_width_20">会议时间</th>
	                                          	<th class="m_width_15">会议地点</th>
	                                          	<th class="m_width_10">状态</th>
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
			//加载初始化数据
			loadMeetingDetailList(null, null, null);
			//点击tab页加载
			$(".roleTab").click(function(){
				loadMeetingDetailList(null, null, null);
			});
			//二级菜单显示
			loadSubMenu("meetingManager");
			//选取当前菜单位置
			setActive("meetingManager","meetingDetail");
			//条件查询
			$("#search").click(function(){

				var meetingConditionSelect =parseInt($("#meetingConditionSelect").val());
				//会议名称
				switch(meetingConditionSelect)
			   { 
				case 1 : 
					var name = $("#content").val();
					break; 
				case 2 : 
					var placeName = $("#content").val();
					break; 
			
			    } 
			
				loadMeetingDetailList(name, placeName, null);
			});
			
			$("#content").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});
			
			
		});

		//加载会议
		function loadMeetingDetailList(name ,meetingPlaceName, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>meetingDetail/loadMeetingDetailList.do",
				data:{
						name : name,
						meetingPlaceName : meetingPlaceName,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						
						appendHtml += '<tr>';
						
           				appendHtml += '<td>' + value.meetingName + '</td>';
           				
           				if(null == value.content || "" == value.content)
           				{
           					appendHtml += '<td></td>';
                   		}
           				else
           				{
           					appendHtml += '<td>' + value.content +'</td>';
               			}
            			appendHtml += '<td>' + value.meetingTime + '</td>';
            			appendHtml += '<td>' + value.meetingPlaceName + '</td>';
            			debugger;
            			var attensta = parseInt(value.attenStatus);
           				switch(attensta)
           				{ 
           					case 0 : 
           						appendHtml += '<td><span class="normal">正常</span></td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td><span class="unnormal">迟到</span></td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td><span class="unnormal">早退</span></td>';
           						break;
           					case 3 : 
           						appendHtml += '<td><span class="unnormal">缺勤</span></td>';
           						break;	 
           					default : 
           						appendHtml += '<td><span class="unnormal">缺勤</span></td>';
           						break;
           				} 
           				appendHtml += '</tr>';
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


			var meetingConditionSelect =parseInt($("#meetingConditionSelect").val());
			//会议名称
			switch(meetingConditionSelect)
		   { 
			case 1 : 
				var name = $("#content").val();
				break; 
			case 2 : 
				var placeName = $("#content").val();
				break; 
		
		    } 
			loadMeetingDetailList(name, placeName, cPageInt);	

			$("#currentPage").html(cPageInt);
		}
	</script>
</html>