<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>校园一卡通</title>
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
	                        <li><a href="">校园一卡通</a><i class="fa fa-circle"></i></li>
	                        <li><span>校园一卡通</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">校园一卡通</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})</a>
										</li>
								</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                       <!--  <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">添加账号</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">删除账号</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">添加电子卡</button>
	                        	<button class="btn btn-default" type="button" data-toggle="modal" href="#small">删除电子卡</button>
	                        </div> -->
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">消费地点：</span>
	                                <select class="form-control m_select" id="yktPlace"></select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">师生类型：</span>
	                         		<select class=" form-control m_select" id="type">
									   <option value="1" selected="selected"> 教师 </option>
									   <option value="2"> 学生 </option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" class=" m_input form-control"  id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		 <button type="submit" class="btn green" id="search">确定</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>校园一卡通</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="hidden-sm hidden-md">班级/部门</th>
												<th>卡号</th>
												<th>持卡人</th>
												<th>消费金额</th>
												<th>余额</th>
												<th>原余额</th>
												<th class="hidden-sm hidden-md">消费地点</th>
												<th>类型</th>
												<th>消费时间</th>
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
	    <div class="modal fade bs-modal-sm" id="small" tabindex="-1" role="dialog" aria-hidden="true">
	        <div class="modal-dialog modal-sm">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">天窗标题</h4>
	                </div>
	                <div class="modal-body">弹窗主题</div>
	                <div class="modal-footer">
	                    <button type="button" class="btn dark btn-outline" data-dismiss="modal">确定</button>
	                    <button type="button" class="btn green">取消</button>
	                </div>
	            </div>
	            <!-- /.modal-content -->
	        </div>
	        <!-- /.modal-dialog -->
	    </div>
	    <!-- 弹窗结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function() {  
			loadSubMenu("xyYktManager"); 
			//选取当前菜单位置
			setActive("xyYktManager","yktTotalManager");   
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");

			if(roleCode=="admin" || roleCode=="president" )
			{
			
			}else if(roleCode=="student" || roleCode=="parent" )
			{
				$("#type option:eq(0)").remove();
				$("#type option:eq(1)").attr('selected','selected');
			
			}else
			{
				$("#type option:eq(1)").remove();
			} 

			//查询内容
			var type = $("#type").val();

			//加载初始化数据   
			loadTotalList(null, null, type, userId, roleCode, null);
			
            //加载消费地点
			loadYktPlaceList()
			App.init();
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				 var html='<option value="1" selected="selected"> 教师 </option>';
			     html+='<option value="2"> 学生 </option>';
			     $("#type").html(html);
				if(roleCode=="admin" || roleCode=="president" )
				{
				}else if(roleCode=="student" || roleCode=="parent" )
				{
					$("#type option:eq(0)").remove();
					$("#type option:eq(0)").attr('selected','selected');
				
				}else
				{
					$("#type option:eq(1)").remove();
				}

				//查询内容
				var type = $("#type").val();
				
				loadTotalList(null, null, type, userId, roleCode, null);

			});

			//查找数据
			$("#search").click(function(){
				
				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("#userTab li.active").find('a').attr("attr2");

				//查询内容
				var queryContent = $("#queryContent").val();

				//消费地点
				var yktPlace = $("#yktPlace").val();
				
				//师生类型
				var type = $("#type").val();
				
				loadTotalList(queryContent, yktPlace, type, userId, roleCode, null);
				
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;	
            	}
			});
			
		});

		//加载总览列表
		function loadTotalList(queryContent, yktPlace, type, userId, roleCode, cPage)
		{
		
		    var body = $("#body");
			App.blockUI(body);
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>ykt/getYktTotalList.do",
				data:{
						queryContent : queryContent, 
						yktPlace : yktPlace,
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
							

						//部门或者班级
           				appendHtml += '<td class="hidden-sm hidden-md">' + value.itemName + '</td>';
           				
						//卡号
           				appendHtml += '<td>' + value.cardCode + '</td>';
           				
						//持卡人
           				appendHtml += '<td>' + value.userName + '</td>';
           				
           				//消费金额
           				appendHtml += '<td>' + value.consMoney + '</td>';
           				
           				//余额
           				appendHtml += '<td>' + value.balance + '</td>';

           				//原余额
           				appendHtml += '<td>' + value.oldMoney + '</td>';
           				
           			    //消费地点
           				appendHtml += '<td class="hidden-sm hidden-md">' + value.consPlace + '</td>';
           				
           				//操作
           				appendHtml += '<td>' + value.consStatus + '</td>';
           				
           				//时间
           				var time = value.consTime;
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


		//加载一卡通地点
		function loadYktPlaceList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>ykt/getYktPlaceList.do",
				success: function(data){
					
					var placeList = eval("(" + data + ")");

					//年级select页面html
					var placeSelectHtml = '<option value="">--请选择--</option>';

					$.each(placeList, function(n, value) {  
						//select页面
						placeSelectHtml += '<option value="' + value.consPlace + '">' + value.consPlace + '</option>';

	          		});

          			$("#yktPlace").html(placeSelectHtml);
          			
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
			
			//查询内容
			var queryContent = $("#queryContent").val();

			//消费地点
			var yktPlace = $("#yktPlace").val();
			
			//师生类型
			var type = $("#type").val();
			
			loadTotalList(queryContent, yktPlace, type, userId, roleCode, cPageInt);
			
			$("#currentPage").html(cPageInt);
		}
	</script>
</html>