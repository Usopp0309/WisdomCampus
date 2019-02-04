 <%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>校车报表</title>
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
	                        <li><a href="">校车管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>校车报表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">校车报表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'president' || roleList.roleCode eq 'classLeader'}">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
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
	                         		<span class="m_span">时间：</span>
	                                <input type="text" name="time"id="time"  class="m_input form-control"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择状态：</span>
	                         		<select class="form-control m_select" id="type" name="type">
                                        <option value="1" selected="selected">回家上车</option>
										<option value="2">上学下车</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption"><i class="fa fa-list"></i>校车报表</div>
	                            </div>
	                            <div class="portlet-body">
								<div class="col-md-12" id="qxtj" >
									<div id="totalChart" class="chart"></div>
								 </div>
									<div class="row" id="schoolBusAbnormalDetail" style="display:none;">	
										<p>(<span id="itemName" style="color:red;"></span>)人员详情</p>
										<div class="portlet light form-fit bordered search_box">
					                         <div class="row m_margin_10_auto">
					                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
					                         		<span class="m_span">选择类型：</span>
					                                <select class="form-control m_select" id="clazzList"></select>
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
					                         		<span class="m_span">搜索内容：</span>
					                         		<input type="text" placeholder="学号、姓名..."  id="queryContent" style="width: 140px;"/>
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
					                         		<button type="button" class="btn green" id="searchDetail">查找</button>
					                         		<input type="hidden" value="" name="itemName" id="itemName"/>
					                         	</div>
					                         </div>
				                         </div>
										 <table class="table table-bordered table-hover">
											<thead>
												<tr>
													<th>班级</th>
													<th>学号</th>
													<th>姓名</th>
													<th>状态</th>
													<th>设备号</th>
													<th>刷卡时间</th>
												</tr>
											</thead>
											<tbody id="tbody">
											<tr><td colspan="6"><img src="<%=basePath%>assets/global/img/null_img.jpg"></td></tr>
											</tbody>
										   </table>
									 </div>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
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
    <script src="<%=basePath%>assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="<%=basePath%>assets/global/plugins/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script>
    <script src="<%=basePath%>assets/pages/flot/jquery.flot.js"></script>
    <script src="<%=basePath%>assets/pages/flot/jquery.flot.canvas.min.js"></script>
	<script src="<%=basePath%>assets/pages/flot/jquery.flot.resize.js"></script>
	<script src="<%=basePath%>assets/pages/flot/jquery.flot.pie.js"></script>
	<script src="<%=basePath%>assets/pages/flot/jquery.flot.stack.js"></script>
<%-- 	<script src="<%=basePath%>assets/pages/flot/jquery.flot.crosshair.js"></script> --%>
<%-- 	<script src="<%=basePath%>assets/global/plugins/schoolnews/dialogs/charts/charts.js"></script>    --%>
    <!-- 公共js结束 -->
</html>
	<script type="text/javascript">
		$(function(){ 
			loadSubMenu("schoolBusManage"); 
			//选取当前菜单位置
			setActive("schoolBusManage","schoolBusReport");    
			$('#time').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			});
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");

			var type = $("#type").val();
			
			loadTotalData(null, type, userId, roleCode);
			
			loadclazzList(userId, 'schoolBusReportManager')
			
			//查找全校统计
			$("#search").click(function(){
				
				$("#schoolBusAbnormalDetail").hide();
				
				var time = $("#time").val();
				var type = $("#type").val();
				
			   loadTotalData(time, type, userId, roleCode);
			   
			  
			});

        	
			//查找数据
			$("#searchDetail").click(function(){
				//卡号
				var queryContent = $("#queryContent").val();
				
				var time = $("#time").val();

				var type = $("#type").val();
				
				//角色ID
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				//卡号
				var queryContent = $("#queryContent").val();
				
				//班级ID
				var clazzId = $("#clazzList").val().replace("C", "");
				
				var itemName = $("#itemName").val();
				
				if (clazzId != 0)
				{
					loadDetailDate(itemName,time,clazzId, queryContent, type, roleCode);
				}
				else
				{
					loadDetailDate(itemName,time,null, queryContent, type, roleCode);
				}
				
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#searchDetail").click();
					return false;	
            	}
			});
			
		});
		
		// 加载班级列表
		function loadclazzList(userId, permissionCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadClazzList.do",
				data:{
						userId : userId,
						permissionCode : permissionCode
					},
				success: function(data){

					var clazzList = eval("(" + data + ")");
					
					var appendHtml = '<option value="0">--选择班级--</option>';

					$.each(clazzList, function(n, value) {
           				appendHtml += '<option value="C' + value.id + '">' + value.clazzName + '</option>';
           			});  
					 
           			$("#clazzList").html(appendHtml);
				},
			});
		}

		function test(data){
		
		    var itemName = null;
		    
			if(data==0)
			{
			  itemName = "未刷卡";
			  $("#schoolBusAbnormalDetail").show();
			}
			if(data==1)
			{
			  itemName = "已刷卡";
			  $("#schoolBusAbnormalDetail").show();
			}
			if(data==2)
			{
			  $("#schoolBusAbnormalDetail").hide();
			}
			
			
			$("#itemName").val(itemName);
			$("#itemName").html(itemName);
			
			//角色ID
			var roleCode = $("ul li.active").find('a').attr("attr2");
			//时间
			var time = $("#time").val();

			//状态
			var type = $("#type").val();
			
			loadDetailDate(itemName,time,null, null, type, roleCode);
			
		}

		//加载总数据
		function loadTotalData(time, type, userId, roleCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/loadTotalData.do",
				data:{
					time : time,
					userId : userId,
					roleCode : roleCode,
					type : type	
				},
				success: function(data){
				
					var total = eval("(" + data + ")");
					
					var studentSum = total.studentSum;
					var studentAbnormal = total.studentAbnormal;
					var studentNormal = studentSum - studentAbnormal;

					//未查询到统计数据
					if (typeof(studentSum) == "undefined"&& typeof(studentAbnormal) == "undefined")
					{
						$("#totalChart").hide();
					}
					else
					{
						$("#totalChart").show();
					}
					
					

					//初始化当天时间
					if (null == time)
					{
						$("#time").val(total.time);
					}
					
					var data = [];
					//未正常刷卡学生数量
		            data[0] = {
		           		label: "未刷卡: " + studentAbnormal + "人",
		                data: studentAbnormal
		            };
		            //正常刷卡学生数量
					data[1] = {
		           		label: "已刷卡: " + studentNormal + "人",
		                data: studentNormal
		            };
					//总人数
					data[2] = {
		           		label: "总人数: " + studentSum + "人",
		           		data: 0
		            };
		              // DEFAULT
					   $.plot($("#totalChart"), data, {
		            	  series: {
			                pie: {
			                    show: true,
			                    radius: 1,
		                        label: {
		                            show: true,
		                            radius: 1,
		                            formatter: function (label, series) {
		                                return '<div style="font-size:8pt;text-align:center;padding:2px;color:black;">' + label + '<br/>' + Math.round(series.percent) + '%</div>';
		                            },
		                            background: {
		                                opacity: 0.8
		                            }
		                        }
			                   }
			               },
			              grid: {
			                hoverable: true,
			                clickable: true
			              }
		               });
		            
					  $("#totalChart").bind("plotclick", pieClick);
				},
			});
		}
		
		//加载分组数据
		function loadDetailDate(itemName,time,clazzId, queryContent, type, roleCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/loadDetailData.do",
				data:{
					itemName : itemName,
					time : time,
					clazzId : clazzId,
					queryContent : queryContent,
					type : type,
					roleCode : roleCode,
				},
				success: function(data){
					var detailList = eval("(" + data + ")");
					var appendHtml = '';
					$.each(detailList, function(n, value) {
						appendHtml += '<tr>';
						appendHtml += '<td width="15%">' + value.clazzName + '</td>';
           				appendHtml += '<td width="15%">' + value.code + '</td>';
            			appendHtml += '<td width="15%">' + value.realName + '</td>';
            			appendHtml += '<td width="15%">' + value.status + '</td>';
            			appendHtml += '<td width="15%">' + value.position + '</td>';
            			appendHtml += '<td width="25%">' + value.createTime + '</td>';
           				appendHtml += '</tr>';
          			}); 
          			
					$("#tbody").html(appendHtml);
					
					/* $(".search_box").css({"display":"none"}); */
				},
			});
		}
		
		function pieClick(event, pos, obj) 
		{
            if (!obj)
            {
            	return;
            }
            
            
			$("#schoolBusAbnormalDetail").show();
			var itemName = obj.series.label;
			$("#itemName").val(itemName);
			$("#itemName").html(itemName);

			var time = $("#time").val();
			var type = $("#type").val();
			var roleCode = $("ul li.active").find('a').attr("attr2");
			var userId = $("ul li.active").find('a').attr("attr1");
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolbus/loadDetailData.do",
				data:{
					itemName : itemName,
					time : time,
					userId : userId,
					roleCode : roleCode,
					type : type
				},
				success: function(data){
					var detailList = eval("(" + data + ")");
					var appendHtml = '';
					$.each(detailList, function(n, value) {
						appendHtml += '<tr>';
						appendHtml += '<td>' + value.clazzName + '</td>';
           				appendHtml += '<td>' + value.code + '</td>';
            			appendHtml += '<td>' + value.realName + '</td>';
            			appendHtml += '<td>' + value.status + '</td>';
            			appendHtml += '<td>' + value.position + '</td>';
            			appendHtml += '<td>' + value.createTime + '</td>';
           				appendHtml += '</tr>';
          			}); 
          			
					$("#tbody").html(appendHtml);
					/* $(".search_box").css({"display":"none"}); */
				},
			});
        }
        

		//iframe加载相关
		var iframeLoaded = function (iframe) 
		{
		    if (iframe.src.length > 0) 
			{
		        if (!iframe.readyState || iframe.readyState == "complete") 
			    {
		            var bHeight = 
		            iframe.contentWindow.document.body.scrollHeight;
		            var dHeight = 
		            iframe.contentWindow.document.documentElement.scrollHeight;
		            var height = Math.max(bHeight, dHeight);
		            iframe.height = height + 100;
		        }
		    }
		}
	</script>
	</html> 