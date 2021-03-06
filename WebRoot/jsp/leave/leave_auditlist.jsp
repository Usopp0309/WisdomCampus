<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>请假审核</title>
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
	                        <li><span>请假审核</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">请假审核</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'president' || roleList.roleCode eq 'classLeader' }">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
									</c:if>
								</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        
	                        
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>请假审核</div>
	                                    <input type="hidden" id="type" value="${sessionScope.user.type}"/>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_10">请假人</th>
												<th class="m_width_20">请假开始时间</th>
											    <th class="m_width_20">请假结束时间</th>
			                                    <th class="m_width_10">类型</th>
												<th class="m_width_10">审核状态</th>
												<c:if test="${sessionScope.user.type != 2}">
													<th class="m_width_10">审核操作</th>
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
	    <!-- 弹窗开始  大小参数：modal-lg, modal-sm-->
	    <div class="modal fade" id="small" tabindex="-1" role="dialog" aria-hidden="true">
	        <div class="page page1">
		        <div class="modal-dialog modal-md">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                    <h4 class="modal-title">请假详情</h4>
		                </div>
		                <div class="modal-body">
		                  	<div class="form-body form-horizontal">
	                           <div class="form-group">
	                               <label class="control-label col-md-3">请假缘由</label>
	                               <div class="col-md-8">
	                                   <textarea class="form-control" id="remark" readonly="readonly"></textarea>
	                               </div>
	                           </div>
	                           <div class="form-group">
	                               <label class="control-label col-md-3">审核状态</label>
	                               <div class="col-md-8">
	                                   <input type="text" class="form-control" id="auditStatus" readonly="readonly"/>
	                               </div>
	                           </div>
		                       <div class="form-group">
		                               <label class="control-label col-md-3">审核意见</label>
		                               <div class="col-md-8">
		                                   <textarea class="form-control" id="auditRemark" readonly="readonly"></textarea>
		                           </div>
		                       </div>
							</div>
			                <div class="modal-footer">
			                    <button type="button" class="btn green" data-dismiss="modal">确定</button>
			                </div>
		            	</div>
		        	</div>
		    	</div>
	    	</div>
	    </div>
	    <!-- 弹窗结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function() {  
			loadSubMenu("leave");  
			//选取当前菜单位置
			setActive("leave","auditLeave");   
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			//加载初始化数据
			loadLeaveAuditList(userId, roleCode, null);

			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadLeaveAuditList(userId, roleCode, null);
			});

		});

		//加载请假审核列表
		function loadLeaveAuditList(userId, roleCode, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>leave/getLeaveAuditList.do",
				data:{
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
           				appendHtml += '<tr>';
						//请假人
           				appendHtml += '<td>' + value.userName + '</td>';
						//请假开始时间
           				appendHtml += '<td>' + value.startTime +'</td>';
           				//请假结束时间
           				appendHtml += '<td>' + value.endTime + '</td>';
						//事由
           				var type = parseInt(value.type);
           				switch(type)
           				{ 
           					case 0 : 
           						appendHtml += '<td>事假</td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td>病假</td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td>产假</td>';
           						break; 
           					case 3 : 
           						appendHtml += '<td>出差</td>';
           						break; 
           					default : 
           						appendHtml += '<td>其他</td>';
           						break;
           				}
           				//审核状态
           				var auditStatus = parseInt(value.auditStatus);
           				switch(auditStatus)
           				{ 
           					case 0 : 
           						appendHtml += '<td>未审核</td>';
           						if ($("#type").val() != '2'){
                   					appendHtml += '<td><a class="btn btn-sm green" onclick="aduitLeave(' + value.id + ')">审核</a></td>';
                   				}
           						break; 
           					case 1 : 
           						appendHtml += '<td class="font-green-sharp">已批准</td>';
           						appendHtml += '<td><span class="btn btn-sm default" data-toggle="modal" href="#small" onclick="getId(1,'+value.id+')">详情</span></td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td class="font-red-mint">未批准</td>';
           						appendHtml += '<td><span class="btn btn-sm default" data-toggle="modal" href="#small" onclick="getId(1,'+value.id+')">详情</span></td>';
           						break; 
           					default : 
           						appendHtml += '<td>未审核</td>';
	           					if ($("#type").val() != '2'){
	               						appendHtml += '<td><a class="btn btn-sm green" onclick="aduitLeave(' + value.id + ')">审核</a></td>';
	               					}
           						break;
           				}
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
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

			//用户ID
			var userId = $("#userTab li.active").find('a').attr("attr1");
			//角色ID
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			loadLeaveAuditList(userId, roleCode, cPageInt);
			$("#currentPage").html(cPageInt);
		}

		//进入请假审核操作页面
		function aduitLeave(leaveId)
		{
			var userId = $("#userTab li.active").find('a').attr("attr1");	
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			standardPost('<%=basePath%>leave/toAuditLeave.do',{userId:userId,roleCode:roleCode,leaveId:leaveId});
		}
	   function getId(num,leaveId){
		   $(".page").removeAttr("style");
		   $(".page"+num).show();

			$.ajax({
				type: "post",
				url: "<%=basePath%>leave/getLeaveDetail.do",
				data:{
					leaveId : leaveId
					},
				success: function(data){
					var data = eval("(" + data + ")");
					var auditStatus = data.auditStatus;
					var auditStatus = parseInt(data.auditStatus);
       				switch(auditStatus)
       				{ 
       					case 0 : 
           					$("#auditStatus").val("待审核");
       						break; 
       					case 1 : 
       						$("#auditStatus").val("已批准");
       						break; 
       					case 2 : 
       						$("#auditStatus").val("未批准");
       						break; 
       					default : 
       						$("#auditStatus").val("待审核");
       						break;
       				}
					$("#remark").val(data.remark);
					$("#auditRemark").val(data.auditRemark);
				},
			});
		}
	</script>
	</html>