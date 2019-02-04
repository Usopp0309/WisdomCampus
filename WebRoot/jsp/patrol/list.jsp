<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>校务巡查巡更</title>
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
	                        <li><span>校务巡查巡更</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">校务巡查巡更</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<r:right rightCode="patrol">
											<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
												<li class="roleLi">
													<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
												</li>
											</c:if>
										</r:right>
									</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<r:right rightCode="patrolModify">
	                        		<a class="btn btn-default" href="<%=basePath%>patrol/toPatrolPlaceList.do">地点列表</a>
	                        		<a class="btn btn-default" href="<%=basePath%>patrol/toPatrolAdd.do">校务巡查设置</a>
	                        		<a class="btn btn-default" onclick="clearPatrol();">清空设置</a>
	                        	</r:right>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择时间：</span>
	                         		<input class="m_input form-control" id="createDate"  type="text">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">员工姓名：</span>
	                         		<input class="m_input form-control" placeholder="教职工姓名,部门" id="queryContent"  type="text">
	                         	</div>
		                         <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
			                         <button type="button" id="search" class="btn design_btn">查找</button>
		                         </div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>巡查巡更列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_10 hidden-sm hidden-md">员工编号</th>
	                                            <th class="m_width_10">巡查人员</th>
	                                            <th class="m_width_15">巡查人员手机号</th>
	                                            <th class="m_width_10  hidden-sm hidden-md">所属部门</th>
	                                            <th class="m_width_20  hidden-sm hidden-md">理论巡查时间</th>
	                                            <th class="m_width_20">实际巡查时间 </th>
	                                            <th class="m_width_10">巡查地点</th>
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
   <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=MnblP7QGUnaYv50psbrm3Dgt""></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils_min.js"></script>

   <script type="text/javascript">
   	$(function(){
   	    //选取当前菜单位置
   		setActive("safeSchool","patrol"); 
   		$('#createDate,.time').datetimepicker({
			 format:"Y-m-d",
			 timepicker:false
		});
		var myDate=new Date();
		var m=myDate.getMonth()+1;
		var d=myDate.getDate();
		m=m<10?"0"+m:m;
		d=d<10?"0"+d:d;
		$("#createDate").val(myDate.getFullYear()+"-"+m+"-"+d);  

		getPatrolList(null);


		$("#search").click(function(){
			getPatrolList(null);
		});
   	});


   	//获取校务巡查巡更列表
   	function getPatrolList(cPage){
		var createDate = $("#createDate").val();
		var queryContent = $("#queryContent").val();
		$.ajax({
			type: "post",
			url: "<%=basePath%>patrol/getPatrolList.do",
			data:{
				cPage : cPage,
				createDate : createDate,
				queryContent : queryContent
				},
			success: function(data){
				var page = eval("(" + data + ")");
				$("#currentPage").html(page.currentPage);
				$("#totalPage").html(page.totalPage);
				var appendHtml = '';
				$.each(page.list, function(n, value) {
					appendHtml += '<tr>';
					appendHtml += '<td class="m_width_10  hidden-sm hidden-md">'+value.code+'</td>';
					appendHtml += '<td class="m_width_10">'+value.realName+'</td>';
					appendHtml += '<td class="m_width_15">'+value.phone+'</td>';
					appendHtml += '<td class="m_width_10  hidden-sm hidden-md">'+value.departmentName+'</td>';
					var timeList = value.timeList;
					if(timeList.length ==0 || timeList == null || typeof(timeList) == "undefined"){
						appendHtml += '<td class="m_width_20  hidden-sm hidden-md"></td>';
					}else{
						appendHtml += '<td class="m_width_20  hidden-sm hidden-md">'
						for(var k=0;k<timeList.length;k++){
							var patrolTime = timeList[k];
							appendHtml += '<p>'+patrolTime.startTime.split(" ")[1]+' - '+patrolTime.endTime.split(" ")[1]+'</p>';
						}
						appendHtml += '</td>'
					}
					
					var inoutList = value.inoutList;
					if(inoutList.length ==0 || inoutList == null || typeof(inoutList) == "undefined"){
						appendHtml += '<td class="m_width_20"></td>';
					}else{
						appendHtml += '<td class="m_width_20">'
						var tmpList = new Array();
						for(var k=0;k<inoutList.length;k++){
							var patrolInout = inoutList[k];
							if(!hasPermissionCodeInArray(patrolInout.inoutTime,tmpList)){
								tmpList.push(patrolInout.inoutTime);
								appendHtml += '<p>'+patrolInout.inoutTime+'</p>';
							}
						}
						appendHtml += '</td>'
					}
					if(typeof(value.placeName) == "undefined" || value.placeName == null){
						appendHtml += '<td class="m_width_10">暂未设置</td>';
					}else{
						appendHtml += '<td class="m_width_10">'+value.placeName+'</td>';
					}
					appendHtml += '<td class="m_width_10">';
					appendHtml += '<r:right rightCode="patrolModify"><a class="btn btn-sm update_btn" onclick="toEdit('+value.id+')">修改</a>';
					appendHtml += '<a class="btn btn-sm map_btn" onclick="toViewMap('+value.placeId+','+value.userId+')">地图显示</a>';
					appendHtml += '</r:right>';
					appendHtml += '</td>';
					appendHtml += '</tr>';

				});
				$("#tbody").html(appendHtml);
			},
		});
   	}

   	function toEdit(id){
   		window.location.href = "<%=basePath %>patrol/toPatrolEdit.do?id="+id;
   	}

   	function toViewMap(placeId,userId){
   		var createDate = $("#createDate").val();
   		window.open("<%=basePath %>jsp/patrol/map.jsp?userId="+userId+"&placeId="+placeId+"&createDate="+createDate,"_blank");
   	}
   	
   	function clearPatrol(){
   		layer.confirm('是否清空今天往后的巡更设置？', {
			  btn: ['是','否'] //按钮
			}, function(){
				$.ajax({
					type: "post",
					url: "<%=basePath%>patrol/clearPatrol.do",
					success: function(data){
                      	var flag=eval("("+data+')');
                      	if(flag){
                      		layer.msg('清空巡更设置成功',{icon:1,time:1000});
	                     }
                      	getPatrolList(null);
					}	
				});
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
		
		getPatrolList(cPageInt);
		$("#currentPage").html(cPageInt);
	}

	function hasPermissionCodeInArray(id,array)
	{
		var flag = false;
		for(var e in array){
			if(array[e] == id){
				flag = true;
				return flag;
			}
		}
		return flag;
	}
   </script>
</html>