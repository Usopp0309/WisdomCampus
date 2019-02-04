<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>会议安排</title>
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
                            <li><span>会议安排</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">会议安排</h3>
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
                            <!-- 添加功能菜单开始 -->
                            <div class="portlet light form-fit m_margin_0_0_15_0">
                            	<c:if test="${sessionScope.user.type != 2}">
                            		<button class="btn btn-default" type="button"  id="addMeeting">添加会议</button>
                            	</c:if>
                            </div>
                            <!-- 添加功能菜单结束 -->
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
	                            		<span class="m_span">查询会议：</span>
	                            		<input type="text" class="m_input form-control" name="content" id="content"/>
	                            	</div>
	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<button type="submit" class="btn design_btn" id="search">查找</button>
	                            	</div>
	                            </div>
                            </div>
                           	<div class="portlet box green m_margin_15_auto_0">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-list"></i>会议安排列表</div>
                                </div>
                                <div class="portlet-body flip-scroll">
                                    <table class="table table-bordered table-hover" id="sample_1">
                                        <thead class="flip-content">
                                            <tr>
                                                <th>会议名称</th><th>开始时间</th><th>结束时间</th><th>会议地点</th>
												<c:if test="${sessionScope.user.type != 2}">
												<th>编辑</th>
												</c:if>
												<th>详情</th>
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
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");

			//加载初始化数据
			loadMeetingList(null, null, null, null, null, userId, roleCode, null);
			//二级菜单显示
			loadSubMenu("meetingManager");
			//选取当前菜单位置
			setActive("meetingManager","meetPlan");
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadMeetingList(null, null, null, null, null, userId, roleCode, null);
			});
 
			//点击进入添加会议页面
			$("#addMeeting").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>meeting/toAddMeeting.do',{userId:userId,roleCode:roleCode});
				});
			
			//条件查询
			$("#search").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				
				var meetingConditionSelect =parseInt($("#meetingConditionSelect").val());
				//会议名称
				switch(meetingConditionSelect)
			   { 
				case 0 : 
					var name = $("#content").val();
					break; 
				case 1 : 
					var name = $("#content").val();
					break; 
				case 2 : 
					var placeName = $("#content").val();
					break; 
			
			    } 
				loadMeetingList(name, null, null, null, placeName, userId, roleCode, null);
			});
			
			$("#content").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});
			
		});

		//加载会议安排
		function loadMeetingList(name, theme, startTime, endTime, placeName, userId, roleCode, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>meeting/loadMeetingList.do",
				data:{
						name : name,
						theme : theme,
						startTime : startTime,
						endTime : endTime,
						placeName : placeName,
						userId : userId,
						roleCode : roleCode,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {
						
						if (n%2 == 0)
						{
							appendHtml += '<tr style="background-color: #ededed">';
						}
						else
						{
							appendHtml += '<tr>';
						}	
           				appendHtml += '<td width="25%">' + value.name + '</td>';
            			appendHtml += '<td width="20%">' + value.startTime + '</td>';
            			appendHtml += '<td width="20%">' + value.endTime + '</td>';
            			appendHtml += '<td width="15%">' + value.placeName + '</td>';
	            		appendHtml += '<td width="10%">';
            		    if(checkTime(value.endTime)){
            		    	appendHtml += '<a class="edit btn btn-sm edit_btn" onclick="editMeeting(' + value.id + ')">编辑</a>';
            		    	appendHtml += '<a class="edit btn btn-sm push_btn" onclick="sendMeetingMsg(' + value.id + ')">推送消息</a>';
            		    }
	            	    appendHtml += '<a class="edit btn btn-sm delete_btn" onclick="deleteMeetingById(' + value.id + ')">删除</a>';
	            		appendHtml += '</td>';
            		    appendHtml += '<td width="10%"><a class="edit btn btn-sm detail_btn" onclick="detailMeeting(' + value.id + ')">详情</a></td>';
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			//解锁UI
          			App.unblockUI(body);
          			
				},
			});
		}
		
		//点击修改会议页面
		function modifyMeeting(meetingId)
		{  
		    var userId = $("ul li.active").find('a').attr("attr1");	
			var roleCode = $("ul li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>meeting/toModifyMeeting.do',{userId:userId,roleCode:roleCode,meetingId:meetingId});
			
		};
		
		//删除会议
		function deleteMeetingById(meetingId)
		{  
			layer.msg('是否删除此会议？', {
				  time: 0 //不自动关闭
				  ,btn: ['是', '否']
				  ,yes: function(index){
				    layer.close(index);
				    $.ajax({
						type: "post",
						url: "<%=basePath%>meeting/deleteMeetingById.do",
						data:{
							id : meetingId
						},
						success: function(data){
							
							var f = eval("(" + data + ")");
							if(f == 0){
								layer.msg('删除成功', {icon: 1});
								window.location.href="<%=basePath%>meeting/toMeetingList.do";
							}else{
								layer.msg('删除失败，请联系管理员', {icon: 2});
							}	          			
						},
					});
				  }
				});
		
			
<%-- 			standardPost('<%=basePath%>meeting/toEditMeeting.do',{userId:userId,roleCode:roleCode,meetingId:meetingId}); --%>
		};
		//点击编辑会议页面
		function editMeeting(meetingId)
		{  
		    var userId = $("ul li.active").find('a').attr("attr1");	
			var roleCode = $("ul li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>meeting/toEditMeeting.do',{userId:userId,roleCode:roleCode,meetingId:meetingId});
		};
		
		//点击详情页面
		function detailMeeting(meetingId)
		{  
		    var userId = $("ul li.active").find('a').attr("attr1");	
			var roleCode = $("ul li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>meeting/toDetailMeeting.do',{userId:userId,roleCode:roleCode,meetingId:meetingId});
		};
		
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
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
			loadMeetingList(null, null, null, null, null, userId, roleCode, cPageInt);
			$("#currentPage").html(cPageInt);
		}
		
		
		function sendMeetingMsg(meetingId){
			if(meetingId != null && '' != meetingId){
				standardPost('<%=basePath%>meeting/sendMeetingMsg.do',{meetingId:meetingId});
			}
		}
		//两个时间比较
		function checkTime(time){
			var d=new Date();
			var str=''; 
			str +=d.getFullYear()+'-'; //获取当前年份 
			str +=d.getMonth()+1+'-'; //获取当前月份（0——11） 
			str +=d.getDate()+' '; 
			str +=d.getHours()+':'; 
			str +=d.getMinutes()+':'; 
			str +=d.getSeconds();
			//返回数值的单位是毫秒。
			var nowTime = (new Date(str)).getTime()/1000;
			var oldTime = (new Date(time)).getTime()/1000;
			if(nowTime < oldTime){
				return true;
			}else{
				return false;
			}
			
		}
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>