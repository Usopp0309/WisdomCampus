<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
    <meta charset="utf-8" />
    <title>进出记录</title>
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
	                        <li><a href="<%=basePath%>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="<%=basePath%>inout/toInoutList.do">平安校园</a><i class="fa fa-circle"></i></li>
	                        <li><span>进出记录</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">进出记录</h3>
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
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                          	 <c:if test="${sessionScope.user.type != 2}">
							    	<button type="button" class="btn btn-default" id="export">导出</button>
								</c:if>	
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span id="tchStuTypeLabel" class="m_span">选择类型:</span>
                                    <select  id="allType" class="form-control m_select" style="display:none;">
										<option value="1" >教师</option>
										<option value="2">学生</option>
										<option value="3">家长</option>
								    </select>
								    <select id="type" class="form-control m_select" style="display:none;">
										<option value="2">学生</option>
										<option value="3">家长</option>
								    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span id="tchStuTypeLabel" class="m_span">选择状态:</span>
	                         		<select id="inoutType" class="form-control m_select">
	                         		    <option value="0">全部</option>
										<option value="1">进</option>
										<option value="2">出</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容:</span>
	                         		<input type="text" class="m_input form-control" placeholder="刷卡人、部门（班级）……"  id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">开始时间:</span>
	                         		<input class="m_input form-control" type="text" name="startTime"  id="startTime" >
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">结束时间:</span>
	                         		<input class="m_input form-control" type="text"name="endTime"  id="endTime" >
	                         	</div>
	                         <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         <button type="button" class="btn design_btn" id="search">搜索</button>
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
	                                            <th class="m_width_10">部门/班级</th>
	                                            <th class="m_width_10">卡号</th>
												<th class="m_width_20">刷卡人</th>
												<th class="m_width_10">进出状态</th>
												<c:if test="${schoolCategory eq '0' }">
													<th id="photo" class="m_width_10">刷卡照片</th>
												</c:if>
												<th class="m_width_20">地点</th>
												<th class="m_width_15">刷卡时间</th>
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
</html>
	<script>
		jQuery(document).ready(function() { 
			loadSubMenu("safeSchool"); 
			//选取当前菜单位置
			setActive("safeSchool","inout"); 
			$('#startTime,#endTime').datetimepicker({
				 lang:"ch",
				 format:"Y-m-d H:i:s" 
				});
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			loadSelect(roleCode);
			//类型
			var type = null;
			if(roleCode=="student" || roleCode=="parent")
			{
				type = $("#type").val();
			}else{
				type = $("#allType").val();
			}
			
			$("#startTime").val(getBeginNowFormatDate(true));
			$("#endTime").val(getNowFormatDate());

			//加载初始化数据   
			loadInoutList(null,null, type, userId, roleCode, null);
			
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				
				var roleCode = $(this).attr("attr2");
				loadSelect(roleCode);

				//类型
				var type = null;
				if(roleCode=="student" || roleCode=="parent")
				{
					type = $("#type").val();
				}else{
					type = $("#allType").val();
				}

				loadInoutList(null, null,type, userId, roleCode, null);
				
				
			});

			//查找数据
			$("#search").click(function(){
				//开始时间
				var startTime = $("#startTime").val();
				//结束时间
				var endTime = $("#endTime").val();
				//查询内容
				var queryContent =$.trim($("#queryContent").val());
				//进出类型
				var inoutType = $("#inoutType").val();
				
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				//类型
				var type = null;
				if(roleCode=="student" || roleCode=="parent")
				{
					type = $("#type").val();
				}else{
					type = $("#allType").val();
				}

				loadInoutList(queryContent,inoutType, type, userId, roleCode, null);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});
			
			//导出数据
			$("#export").click(function(){
				//开始时间
				var startTime = $("#startTime").val();
				//结束时间
				var endTime = $("#endTime").val();
				//查询内容
				var queryContent = encodeURI(encodeURI($("#queryContent").val())) ;
				//进出类型
				var inoutType = $("#inoutType").val();
				
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				//类型
				var type = "";
				if(roleCode=="student" || roleCode=="parent")
				{
					type = $("#type").val();
				}else{
					type = $("#allType").val();
				}
				var url="<%=basePath%>inout/doExportExcel.do?userId="+userId+"&roleCode="+roleCode+"&type="+type+"&inoutType="+inoutType+"&queryContent="+queryContent+"&startTime="+startTime+"&endTime="+endTime+"";
					url=encodeURI(encodeURI(url)); 
				location.href=url;
				<%-- standardPost('<%=basePath%>inout/doExportExcel.do',{userId:userId,roleCode:roleCode,type:type,inoutType:inoutType,queryContent:queryContent,startTime:startTime,endTime:endTime}); --%>
				});
			  // $("#search").click();
			
		});

        
		//加载进出记录列表
		function loadInoutList(queryContent, inoutType,type, userId, roleCode, cPage)
		{
			var startTime=$("#startTime").val();
			var endTime=$("#endTime").val();
			var body = $("#body");
			 App.blockUI(body); 
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>inout/getInoutList.do",
				data:{
						startTime : startTime,
						endTime : endTime,
						queryContent : queryContent, 
						inoutType : inoutType,
						type : type,
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
						if(null == value.itemName || "" == value.itemName)
           				{
           					appendHtml += '<td></td>';
                   		}
           				else
           				{
           				    //部门
           				    appendHtml += '<td>' + value.itemName + '</td>';
               			}
           				
						//卡号
           				appendHtml += '<td>' + value.code + '</td>';
						//拥有着
           				appendHtml += '<td>' + value.userName + '</td>';
				
						//进出状态
           				var status = parseInt(value.status);
           				switch(status)
           				{ 
           					case 1 : 
           						appendHtml += '<td>进</td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td>出</td>';
           						break; 
           					default : 
           						appendHtml += '<td>进</td>';
           						break;
           				}
					if ($("#photo").text() != "" ){
           				appendHtml += '<td class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-picture" style="color:#4d90fe"></i></a>';

        				appendHtml += '<ul class="dropdown-menu extended inbox"><img src="http://121.199.27.191:18086/wcftp/'+value.imgPath+'">';

           				appendHtml += '</ul></td>';
					}
						//地点
           				appendHtml += '<td>' + value.positionName + '</td>';
						//创建时间
           				appendHtml += '<td>' + value.createTime + '<span class="Response"></span></td>';
           				appendHtml += '</tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			if ($("#photo").text() != "" ){
          			}else{
          			}
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
				//开始时间
				var startTime = $("#startTime").val();
				//结束时间
				var endTime = $("#endTime").val();
				//查询内容
				var queryContent = $("#queryContent").val();
				
				//进出状态
				var inoutType = $("#inoutType").val();
				
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");

				//类型
				var type = null;
				if(roleCode=="student" || roleCode=="parent")
				{
					type = $("#type").val();
				}else{
					type = $("#allType").val();
				}

				loadInoutList(queryContent, inoutType,type, userId, roleCode, cPageInt)
			
			   $("#currentPage").html(cPageInt);
		}

		//加载教师学生选择框
		function loadSelect(roleCode)
		{
			if(roleCode=="student" || roleCode=="parent")
			{
				$("#allType").hide();
				$("#type").show();
			}else
			{
				$("#allType").show();
				$("#type").hide();
			}
		}

	</script>
</html>