<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>蓝牙数据分析信息</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<!--公共css开始-->
<%@ include file="/public_module/public_css_new.jsp"%>
<!--公共css结束-->
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed"
	id="body">
	<input class="themes" type="hidden" value="<%=ThemePath%>">
	<input type="hidden" value="${schoolId}" id="schoolId">
	<input type="hidden" value="${sessionScope.user.userId}" id="userId">
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
				<div class="col-md-12 col-sm-12 m_page_con">
					<div class="page-bar m_margin_0_0_0_0">
						<ul class="page-breadcrumb">
							<li><a href="<%=basePath%>user/enterMain.do">首页</a><i
								class="fa fa-circle"></i></li>
							<li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i
								class="fa fa-circle"></i></li>
							<li><span>蓝牙手环数据分析信息</span></li>
						</ul>
					</div>
					<h3 class="page-title">蓝牙手环数据分析信息</h3>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="m_margin_0_0_15_0">
								<!-- 角色切换开始 -->
								<ul class="nav nav-tabs" id="userTab">
									<c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if
											test="${roleList.roleCode eq 'parent'|| roleList.roleCode eq 'president' || roleList.roleCode eq 'classLeader'}">
											<li
												class="roleLi">
												<a
												attr1="${sessionScope.user.userId}"
												attr2="${roleList.roleCode}" onclick="chooseRoleCode('${roleList.roleCode}');">${sessionScope.user.realName}(${roleList.roleName})
											</a></li>
										</c:if>
									</c:forEach>
								</ul>
								<!-- 角色切换结束 -->
							</div>
						</div>
						<div class="portlet box green m_margin_15_auto_0">
							<div class="portlet-body">
								<div class="portlet light form-fit bordered search_box">
									<form action="#" class="form-horizontal">
										<div class="row m_margin_10_auto">

											<div class="col-lg-3 m_margin_top-15" style="width: 15%;">
												<span class="m_span">课程类型：</span> <select
													class="form-control m_select" id="course"  onchange="init(1);">
													<option value="">--请选择--</option>
													<c:forEach var="bc" items="${bluetoothCourses }">
														<option value="${bc.id }">${bc.name }</option>
													</c:forEach>
												</select>
											</div>
											<!-- <div class="col-lg-3 m_margin_top-15" style="width: 15%;">
				                         		<span class="m_span">选择班级：</span>
				                                <select class="form-control m_select" id="clazzList">
				                                <option value="">--请选择班级--</option>
				                                </select>
				                         	</div> -->
                                            <div class="col-lg-3 m_margin_top-15" style="width: 15%;">
				                         		<span class="m_span">选择小孩：</span>
				                                <select class="form-control m_select" id="student" onchange="init(1);">
				                                <option value="">--请选选择小孩--</option>
				                                <c:forEach var="s" items="${stuidents}">
				                                <option value="${s.userId}">${s.realName}</option>
				                                </c:forEach>
				                                </select>
				                         	</div> 

											<div class="col-lg-3 m_margin_top-15" style="width: 20%;">
												<span class="m_span">搜索内容：</span> <input
													class="m_input form-control" type="text"
													placeholder="请输入姓名,学号..." id="content"/>
											</div>

											<div class="col-lg-3 m_margin_top-15" style="width: 20%;">
												<span class="m_span">开始时间：</span> <input
													class="m_input form-control" type="text" id="startDate" />
											</div>

											<div class="col-lg-3 m_margin_top-15" style="width: 20%;">
												<span class="m_span">结束时间：</span> <input
													class="m_input form-control" type="text" id="endDate" />
											</div>


											<div class="col-lg-3 m_margin_top-15" style="width: 10%;">
												<button type="button" class="btn green" onclick="init(1);">查找</button>
											</div>
										</div>
									</form>
								</div>
							</div>

							<div class="portlet box green m_margin_15_auto_0">

								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-list"></i>蓝牙手环数据列表
									</div>
								</div>
							</div>

							<div class="portlet-body flip-scroll">
								<table class="table table-hover table-bordered table-condensed"
									cellpadding="0" cellspacing="0">
									<thead>
										<th width="3%"></th>
										<th width="5%">姓名</th>
										<th width="5%">学号</th>
										<th width="10%">班级</th>
										<th width="10%">蓝牙地址</th>
										<th width="5%">蓝牙编号</th>
										<th width="10%">课程</th>
										<th width="20%">课程时间</th>
										<th width="20%">查看</th>
									</thead>
									<tbody id="tbody">

									</tbody>
								</table>
							</div>
						</div>
						<!-- 分页开始 -->
						<%@include file="/public_module/public_page.jsp"%>
						<!-- 分页结束 -->
					</div>
				</div>
			</div>
		</div>

		<!-- 底部开始 -->
		<%@ include file="/public_module/public_footer.jsp"%>
		<script src="<%=basePath%>assets/global/plugins/map.js"
			type="text/javascript"></script>
		<!-- 底部结束 -->
</body>
<!-- 公共js开始 -->
<%@ include file="/public_module/public_js.jsp"%>
<!-- 公共js结束 -->
<script type="text/javascript">
      $(function(){
    	  loadSubMenu("assetManagement");  
    		//选取当前菜单位置
    		setActive("assetManagement","braceletStatistics");  
    	 // loadclazzList();
	     $('#startDate,#endDate').datetimepicker({
			 format:"Y-m-d H:i:00" 
		});
	     init(1);
	     $("#userTab li a").each(function(){
	    	 var attr2=$(this).attr("attr2");
	    	 var flag=true;
	    	 if(attr2=="${crtCode}" && $(this).parent().hasClass("active")){
	    		 $(this).parent().addClass("active");
	    		 flag=false;
	    	 }
	    	 if(flag){
	    		 $(this).parent().removeClass("active"); 
	    	 }
	     });
    });
      function chooseRoleCode(roleCode){
    	  standardPost('<%=basePath%>statistics/toStatistics.do',{crtCode:roleCode});  
      }
      //初始化数据
      function init(page){
    	  var course=$("#course").val();
    	  var studentId=$("#student").val();
    	  var content=$("#content").val();
    	  var startDate=$("#startDate").val();
    	  var endDate=$("#endDate").val();
    	  if(studentId==""){//查询所有的小孩
    		  var studentIds=[];
    		 $("#student option").each(function(){
    			 if($(this).val()!=''){
    				 studentIds.push($(this).val());  
    			 }
    		 }); 
    		 studentId=studentIds.join(",");
    		 // studentId='21312,42579';  
    	  }
    	  $.ajax({
				type: "post",
				url: "<%=basePath%>statistics/getPageStatisticsBluetoothData.do",
				dataType:"json",
				data:{
					studentId : userId,
					roleCode:"parent",
					page:page,
					course:course,
					studentId:studentId,
					content:content,
					startTime:startDate,
					endTime:endDate
					},
				success: function(data){
				    var html='';
	    		    $("#currentPage").html(data.currentPage);
	 				$("#totalPage").html(data.totalPage);
	    		    var list=data.list;
	    		    if(list!=null && list.length>0){
	    			for(var i=0;i<list.length;i++){
	    				html+='<tr> <td><input  type="checkbox" name="statistics" value="'+list[i].bluetoothCourseTimeId+'" userId="'+list[i].userId+'" /></td>';
	    				html+=' <td>'+list[i].realName+'</td>';
	    				html+=' <td>'+list[i].userCode+'</td>';
	    				html+=' <td>'+list[i].clazzName+'</td>';
	    				html+=' <td>'+list[i].braceletMac+'</td>';
	    				html+=' <td>'+list[i].braceletCode+'</td>';
	    				html+=' <td>'+list[i].courseName+'</td>';
	    				html+=' <td>'+list[i].startTime+'-'+list[i].time+'</td>';
	    				html+=' <td> <a class="btn btn-success btn-sm" onclick="lookDtail('+list[i].userId+','+list[i].bluetoothCourseTimeId+',\''+list[i].courseName+'\',\''+list[i].startTime+'-'+list[i].time+'\',\''+list[i].realName+'\','+list[i].clazzId+');">详情</a><a class="btn btn-success btn-sm" onclick="compare(\''+list[i].courseName+'\',\''+list[i].startTime+'-'+list[i].time+'\');">对比</a></td><tr>';
	    			}
	    		    }
	    		    $("#tbody").html(html);
				}
			}); 
      }
      //对你
      function compare(courseName,time){
    	  var title=courseName+"("+time+")"
    	  var count=0; 
    	  var userId1="";
    	  var bluetoothCourseTimeId1="";
    	  var userId2="";
    	  var bluetoothCourseTimeId2="";
    		$("#tbody tr td input[type='checkbox']").each(function(){
    			if($(this).is(":checked")){
    				count++;
    				if(count==1){
    					userId1=$(this).attr("userId");	
    					bluetoothCourseTimeId1=$(this).val();	
    				}else if(count==2){
    					userId2=$(this).attr("userId");	
    					bluetoothCourseTimeId2=$(this).val();	
    				}
    			}
    		});
    		 if(userId1==userId2){
    			layer.msg("请选择两个不同的人进行对比！",{icon:0,time:3000});
    			return;
    		 }else if(bluetoothCourseTimeId1!=bluetoothCourseTimeId2){
    			 layer.msg("请选择两个同一时间段的课程进行对比！",{icon:0,time:3000});
     			return; 
    		 }
 			standardPost('<%=basePath%>statistics/toBluetoothParentCompare.do',{studentId1:userId1,studentId2:userId2,bluetoothCourseTimeId:bluetoothCourseTimeId1,courseName:title});
      }
      //家长查看详情
      function lookDtail(userId,bluetoothCourseTimeId,courseName,time,name,clazzId){
    	  var title=name+"/"+courseName+"("+time+")";
			standardPost('<%=basePath%>statistics/toBluetoothParentDetail.do',{studentId:userId,bluetoothCourseTimeId:bluetoothCourseTimeId,title:title,clazzId:clazzId});
      }
  	    // 加载班级列表
		function loadclazzList()
		{
			var userId=$("#userId").val();
			var permissionCode="parent";
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/loadClazzList.do",
				data:{
						userId : userId,
						permissionCode : permissionCode
					},
				success: function(data){
					var clazzList = eval("(" + data + ")");
					var appendHtml ='';
					 appendHtml = '<option value="" selected="selected">---请选择---</option>';
					$.each(clazzList, function(n, value) {
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
         			}); 
         			$("#clazzList").html(appendHtml);
				}
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
		init(cPageInt);
		$("#currentPage").html(cPageInt);
	}
    </script>
</html>