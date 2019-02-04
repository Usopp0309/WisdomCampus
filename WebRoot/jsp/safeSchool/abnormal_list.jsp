<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>异常信息</title>
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
	                        <li><span>异常信息</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">异常信息 </h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs" id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<li class="roleLi">
										<a href="#tab_4" data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
										</a>
									</li>
							</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<button class="btn btn-default" type="button" id="export">导出</button>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                         <div class="row m_margin_10_auto">
								<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">人员姓名:</span>
	                         		<input class="m_input form-control" type="text" id="name">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">异常类型:</span>
	                         		<select class="form-control m_select" id="abnormalType">
										<option value="-1" selected="selected">全部</option>
										<option value="1">早退</option>
										<option value="0">迟到</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span" id="tchStuTypeLabel">师生类型:</span>
									<select class="form-control m_select" id="tchStuType">
										<option value="0" selected="selected">全部</option>
										<option value="teacher">教师</option>
										<option value="student">学生</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		 <button type="submit" class="btn design_btn"  id="search">确定</button>
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
	                                           	<th class="m_width_15">姓名</th>
												<th class="m_width_15">异常类型</th>
												<th class="m_width_45">内容</th>
												<th class="m_width_25">创建时间</th>
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
			setActive("safeSchool","abnormal"); 
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleId = $("#userTab li.active").find('a').attr("attr2");

			loadTchStuSelect(roleId);
			
			//加载初始化数据   
			loadAbnormalList(userId, roleId, null);
	        loadAllGradeList(userId, roleId);
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleId = $(this).attr("attr2");
				loadAbnormalList(userId, roleId, null);
				//初始化select
				$("#tchStuType").val('0');
			});
			
			//条件查询
			$("#search").click(function(){

				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				loadAbnormalList(userId, roleId, 1);
			});
			
			//导出数据
			$("#export").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				//姓名
				var name = $.trim($("#name").val());
				//师生类型
				var tchStuType = $.trim($("#tchStuType").val());
				//异常类型
				var abnormalType = $.trim($("#abnormalType").val());
				standardPost('<%=basePath%>abnormal/doExportExcel.do',{name:name,type:tchStuType,typeAbnorma:abnormalType,userId:userId,roleCode:roleId});
				});
			$("#name").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});
			
		});
		
		//根据学校ID加载该学校所有的班级数据
		function loadAllGradeList(userId, roleId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadClazzList.do",
				data:{
					userId : userId,
					permissionCode : "abnormal"
					},
				success: function(data){
					var gradeList = eval("(" + data + ")");
					var appendHtml = '<option value="0">--请选择--</option>';
					$.each(gradeList, function(n, value) {  
           				appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
          			}); 
          			$("#gradeSelect").html(appendHtml);
				},
			});
		}
		
		 //加载异常报警列表
		function loadAbnormalList(userId, roleId, cPage)
		{
			//姓名
			var name = $.trim($("#name").val());
			//师生类型
			var tchStuType = $.trim($("#tchStuType").val());
			//异常类型
			var abnormalType = $.trim($("#abnormalType").val());
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>abnormal/getAbnormalList.do",
				data:{
				        name :name,
				        tchStuType : tchStuType,
				        abnormalType : abnormalType,
						userId : userId,
						roleId : roleId,
						cPage : cPage
					},
				success: function(data){
					var page = $.parseJSON(data);
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						
						appendHtml += '<tr>';
							
						//持有者
           				appendHtml += '<td>' + value.realName + '</td>';
						//类型
						var type = parseInt(value.type);

			            switch(type)
			             { 
			             case 1:
           				     appendHtml += '<td><span class="unnormal">早退</span></td>';
           				     break;
           				 case 0:
           				     appendHtml += '<td><span class="unnormal">迟到</span></td>';
                             break;                        
                         default :  
                             appendHtml += '<td><span class="unnormal">未知异常</span></td>';   
                             break;
           				 } 
						//短信内容
						if (value.content == undefined)
						{
							appendHtml += '<td class="message_content"></td>';
						}
						else
						{
           					appendHtml += '<td class="message_content">' + value.content + '</td>';
						}
						//创建时间
						var time = value.createTime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
           				appendHtml += '<td>' + time + '</td>';
           				
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

			//师生类型
			var tchStuType = $("#tchStuType").val();
			
			//用户ID
			var userId = $("#userTab li.active").find('a').attr("attr1");
			//角色ID
			var roleId = $("#userTab li.active").find('a').attr("attr2");
			loadAbnormalList(userId, roleId, cPageInt);
			$("#currentPage").html(cPageInt);
		}

		//加载师生选择select
		function loadTchStuSelect(roleId)
		{
			//如果是系统管理员，超级管理员，校长，班主任则有发布权限
			if(roleId == "admin" || roleId == "president"){
				$("#tchStuType").show();
			}
			else if (roleId == "classLeader" || roleId == "departManager"){
				$("#tchStuTypeLabel").hide();
				$("#tchStuType").hide();
			}else{
				$("#tchStuTypeLabel").hide();
				$("#tchStuType").hide();
			}
		}
	</script>
</html>