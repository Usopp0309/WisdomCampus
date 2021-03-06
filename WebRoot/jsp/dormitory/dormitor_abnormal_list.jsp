<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>宿舍异常</title>
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
        <div class="clearfix"></div>
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
                            <li><span>宿舍异常</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">宿舍异常</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                        	<div class="m_margin_0_0_15_0">
                        		<!-- 角色切换开始 -->
                        		<ul class="nav nav-tabs" id="userTab">
                        			<c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'chairman' || roleList.roleCode eq 'classLeader' || roleList.roleCode eq 'departManager' || roleList.roleCode eq 'president' || roleList.roleCode eq 'teacher' || roleList.roleCode eq 'employee'}">
											<li class="roleLi">
												<a data-toggle="tab" aria-expanded="true" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})</a>
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
	                                    <span class="m_span">选择类型:</span>
										<select class="form-control m_select" id="type">
											<option value="1" selected="selected">出宿舍已刷卡</option>
											<option value="2">出宿舍未刷卡</option>
											<option value="3">进宿舍已刷卡</option>
											<option value="4">进宿舍未刷卡</option>
										</select>
	                            	</div>
	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<span class="m_span">开始时间:</span>
										<input type="text" placeholder="开始时间" name="startTime" id="startTime"  class="m_input form-control"/>
	                            	</div>
	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<span class="m_span">结束时间:</span>
										<input type="text" size="16" placeholder="结束时间" name="endTime" id="endTime"  class="m_input form-control"/>
	                            	</div>
	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<span class="m_span">选择班级:</span>
										<select class="m_select form-control" id="clazzList" >
										</select>
	                            	</div>
	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<span class="m_span">搜索内容:</span>
										<input type="text" placeholder="姓名……" class="m_input form-control" id="queryContent"/>
	                            	</div>
		                            <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                            	<button type="submit" class="btn green" id="search">确定</button>
		                            </div>
	                            </div>
                            </div>
                           	<div class="portlet box green m_margin_15_auto_0">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-list"></i>进出记录列表</div>
                                </div>
                                <div class="portlet-body flip-scroll">
                                    <table class="table table-bordered table-hover" id="sample_1">
                                        <thead class="flip-content">
                                            <tr>
                                                <th>班级</th><th>学号</th><th>姓名</th><th>卡号</th><th>状态</th>
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
 	<%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function() {    
			$('#startTime,#endTime').datetimepicker(/* {
				format:'Y-m-d',
				timepicker:false
			} */);
			loadSubMenu("dormitoryManage");
			//选取当前菜单位置
			setActive("dormitoryManage","dormitoryAbnormal");
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
			
			var type = $("#type").val();
	
			//加载初始化数据   
			loadDormitorAbnormalList(null,null,type,null,null, userId, roleCode, null);
			
	        //加载班级信息
			loadclazzList(userId, 'dormitoryAbnormalManager');
			
			
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				
				//加载班级信息
				loadclazzList(userId, 'dormitoryAbnormalManager');
				loadDormitorAbnormalList(null,null,null,null,null, userId, roleCode, null);

			});
			
			//条件查询
			$("#search").click(function(){

				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				//短信内容
				var queryContent = $("#queryContent").val();
				//刷卡类型
				var type = $("#type").val();
				//开始时间
				var startTime = $("#startTime").val();
				//结束时间
				var endTime = $("#endTime").val();
				
				//班级ID
			    var clazzId = $("#clazzList").val().replace("C", "");
			
			    //clazzId为0表示选择所有班级，不为0表示选择某个班级
			    if (clazzId != 0)
				{
					loadDormitorAbnormalList(clazzId,queryContent,type,startTime,endTime, userId, roleCode, null);
				}
				else
				{
					loadDormitorAbnormalList(null,queryContent,type,startTime,endTime, userId, roleCode, null);
				}
				
			});
			
			//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#clazzList").change(function(){
			
				var userId = $("ul li.active").find('a').attr("attr1");	
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				//短信内容
				var queryContent = $("#queryContent").val();
				//刷卡类型
				var type = $("#type").val();
				//开始时间
				var startTime = $("#startTime").val();
				//结束时间
				var endTime = $("#endTime").val();
				
				//班级ID
			    var clazzId = $("#clazzList").val().replace("C", "");
			
			    //clazzId为0表示选择所有班级，不为0表示选择某个班级
			    if (clazzId != 0)
				{
					loadDormitorAbnormalList(clazzId,queryContent,type,startTime,endTime, userId, roleCode, null);
				}
				else
				{
					loadDormitorAbnormalList(null,queryContent,type,startTime,endTime, userId, roleCode, null);
				}
			});
			
			//导出数据
			$("#export").click(function(){
				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				//短信内容
				var message = $("#message").val();
				//时间
				var time = $("#time").val();
				//姓名
				var name = $("#name").val();
				//类型
				var typeAbnorma = $("#typeAbnorma").val();
				
				standardPost('<%=basePath%>dormitory/doExportExcelAsDormitorAbnormal.do',{queryContent:queryContent,userId:userId,roleCode:roleCode});
				});
			
		});

		//加载宿舍异常报警列表
		function loadDormitorAbnormalList(clazzId,queryContent,type,startTime,endTime, userId, roleCode, cPage)
		{
		    var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>dormitory/loadDormitorAbnormalList.do",
				data:{
				        clazzId : clazzId,
				        queryContent : queryContent,
				        type : type,
				        startTime : startTime,
				        endTime : endTime,
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
						//持有者
           				appendHtml += '<td width="20%">' + value.clazzName + '</td>';
           				appendHtml += '<td width="20%">' + value.code + '</td>';
           				appendHtml += '<td width="20%">' + value.realName + '</td>';
           				appendHtml += '<td width="20%">' + value.cardCode + '</td>';
           				appendHtml += '<td width="20%">' + value.status + '</td>';
           				
           				appendHtml += '</tr>';
          			}); 
          			
          			$("#tbody").html(appendHtml);
          			/* new TableSorter("sample_1",0,1,2,3,4,5); */
          			//解锁UI
          			App.unblockUI(body);
          			
          			/* $(".search_box").css({"display":"none"}); */
				},
			});
		}
		
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
						
						var type = value.type;
						if(type==0){
							appendHtml += '<option value="C' + value.id + '">' + "幼儿园" +value.clazzName + '</option>';
						}else if(type == 1){
							appendHtml += '<option value="C' + value.id + '">' + "小学" +value.clazzName + '</option>';
						}else if(type == 2){
							appendHtml += '<option value="C' + value.id + '">' + "初中" +value.clazzName + '</option>';
						}else if(type == 3){
							appendHtml += '<option value="C' + value.id + '">' + "高中" +value.clazzName + '</option>';
						}else{
							appendHtml += '<option value="C' + value.id + '">' + "小学" +value.clazzName + '</option>';
						}
           			});  
					 
           			$("#clazzList").html(appendHtml);
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

			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
				
			//短信内容
			var queryContent = $("#queryContent").val();
			//刷卡类型
		    var type = $("#type").val();
			//开始时间
			var startTime = $("#startTime").val();
			//结束时间
			var endTime = $("#endTime").val();
				
			//班级ID
			var clazzId = $("#clazzList").val().replace("C", "");
			
		    //clazzId为0表示选择所有班级，不为0表示选择某个班级
			if (clazzId == 0)
			{
				loadDormitorAbnormalList(null,queryContent,type,startTime,endTime, userId, roleCode, cPageInt);
			}
			else
			{
				loadDormitorAbnormalList(clazzId,queryContent,type,startTime,endTime, userId, roleCode, cPageInt);
			}

			$("#currentPage").html(cPageInt);
		}

	</script>
</html>