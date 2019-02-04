<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>考勤补录</title>
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
	                        <li><a href="<%=basePath %>check/toAttendanceRecord.do">考勤补录</a><i class="fa fa-circle"></i></li>
	                        <li><span>教职工考勤补录列表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">教职工考勤补录</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                               	<li class="active"><a target="_self">教师补录</a></li>
									<li><a href="<%=basePath %>check/toStudentAttendanceRecord.do">学生补录</a></li>
									<input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}"/>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择部门：</span>
	                         		<select class="m_select form-control" id="departmentSelect" name="gradeId"></select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">开始时间：</span>
	                         		<input type="text" name="createDate" id="createDate"  class="m_input form-control"/>
			                    </div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>考勤补录</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th>科室</th>
												<th class="hidden-sm hidden-md">工号</th>
												<th>姓名</th>
												<th>状态</th>
												<th>备注</th>
												<th>更新时间</th>
												<th>编辑</th>
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
			loadSubMenu("attendance");  
			//选取当前菜单位置
			setActive("attendance","attendanceFill"); 
			$('#createDate').datetimepicker({
				 format:"Y-m-d",
				 timepicker:false
			});
			var myDate=new Date();
			var m=myDate.getMonth()+1;
			var d=myDate.getDate();
			m=m<10?"0"+m:m;
			d=d<10?"0"+d:d;
			$("#createDate").val(myDate.getFullYear()+"-"+m+"-"+d);  
			
			//页面初始化时候的数据加载
			var userId = $("#userId").val();

			//初始化部门select
			loadDepartmentList(userId);
			
			//加载初始化数据
			loadTeacherCheckList(null, null, userId, null);			
			$("#search").click(function(){
				var userId = $("#userId").val();
				var departmentId = $("#departmentSelect").val();
				var queryContent = $("#queryContent").val();
				loadTeacherCheckList(departmentId, queryContent, userId, 1);
			});
			$("#queryContent").keypress(function(){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});

			
			//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#departmentSelect").change(function(){
				//查询条件
				var queryContent = $("#queryContent").val();		
				//班级ID
				var departmentId = $(this).val().replace("", "");
				var userId = $("#userId").val();
				
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (departmentId != 0)
				{
					loadTeacherCheckList(departmentId, queryContent, userId, 1);
				}
				else
				{
					loadTeacherCheckList(departmentId, queryContent, userId, 1);
				}	
			});
		});
		//加载部门列表
		function loadDepartmentList(userId)
		{

			$.ajax({
				type: "post",
				url: "<%=basePath%>depart/getDepartList.do",
				data:{
						userId : userId,
						permissionCode : "attendanceRecordManager"
					},
				success: function(data){
					var departmentList = eval("(" + data + ")");
					var appendHtml = '<option value="">--选择所有部门--</option>';
					$.each(departmentList, function(n, value) {
           				appendHtml += '<option value="' + value.id + '">' + value.departmentName + '</option>';
           			}); 

           			$("#departmentSelect").html(appendHtml);

           			//初始化带选框
           			var appendHtml = $("#departmentSelect").html();
				},
			});

		}
		
		//加载教师考勤页面
		//参数说明: gradeId:年级ID
		//		 code:工号
		//       name:姓名
		//       phone:手机号码
		//       cardCode:电子卡号
		function loadTeacherCheckList(departmentId, queryContent, userId, cPage)
		{
			var body = $("#body");
			App.blockUI(body);
			var createDate = $("#createDate").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>check/loadTeacherCheckList.do",
				data:{
						from : '2',
						departmentId : departmentId,
						queryContent : queryContent,
						userId : userId,
						createDate : createDate,
						cPage : cPage
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					var j = 0;
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
           				appendHtml += '<td>' + value.gradeName + '</td>';
            			appendHtml += '<td class="hidden-sm hidden-md">' + value.code + '</td>';
            			appendHtml += '<td> '+ value.name+'</td>';
            			
            			var status = parseInt(value.status);
         			    appendHtml += '<td> <select class="form-control" id="status' + j + '" name="'+status+'">';
					   	if (status <= 14){
	            			appendHtml += '<option value="5">上午正常上班</option>';
	            			appendHtml += '<option value="2">上午迟到</option>';
	            			appendHtml += '<option value="3">上午早退</option>';
	            			appendHtml += '<option value="4">上午正常下班</option>';
	            			appendHtml += '<option value="1">上午旷工</option>';
	            			appendHtml += '<option value="11">下午正常上班</option>';
	            			appendHtml += '<option value="9">下午迟到</option>';
	            			appendHtml += '<option value="10">下午早退</option>';
	            			appendHtml += '<option value="12">下午正常下班</option>';
	            			appendHtml += '<option value="8">下午旷工</option>';
	            			appendHtml += '<option value="6">上午非正常进校</option>';
	            			appendHtml += '<option value="7">上午非正常出校</option>';
	            			appendHtml += '<option value="13">下午非正常进校</option>';
	            			appendHtml += '<option value="14">下午非正常出校</option>';
					   	}else{
					   		appendHtml += '<option value="22">正常上班</option>';
	            			appendHtml += '<option value="23">迟到</option>';
	            			appendHtml += '<option value="24">早退</option>';
	            			appendHtml += '<option value="25">正常下班</option>';
	            			appendHtml += '<option value="26">旷工</option>';
	            			appendHtml += '<option value="27">非正常进校</option>';
	            			appendHtml += '<option value="28">非正常出校</option>';
					   	}
            			//$("select[name="+value.code+"] option[value='val']").attr("selected","selected");			
            			appendHtml += '</select></td>';
          			    
          			    
						
           				if (value.remark == null)
						{
							appendHtml += '<td></td>';
						}
						else
						{
							appendHtml += '<td>' + value.remark + '</td>'; 
						}
            			appendHtml += '<td>' + value.createTime + '</td>';
            			appendHtml += '<td><c:if test="${sessionScope.user.type != 2}"><a href="javascript:;" class=" btn btn-sm green"  onclick="updateStatus(' + j + ',' + value.uId + ','+ value.status + ',\''+ value.createTime +'\')">保存</a></c:if></td>';
           				appendHtml += '</tr>';
           				j++;
          			}); 
          			
          			
          			$("#tbody").html(appendHtml);
          			$("#tbody select").each(function(){
          				var id = $(this).attr("id");
          				$("#" + id + " > option[value='" + $(this).attr("name") + "']" ).attr("selected",true);
          			});
          			
			        //解锁UI
          	        App.unblockUI(body);
				},
			});
			
		}
		
		//修改状态
		function updateStatus(j,uId,status,createDate)
		{
			var userId = $("userId").val();	
			var queryContent = $("#queryContent").val();		
			var departmentId = $("#departmentSelect").val();
			var newStatus = $("#status" + j).val();
			if(status == newStatus){
				return;
			}
			//询问框
			var ll=layer.confirm('确定修改状态？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				layer.close(ll);
				var indexlayer = layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
				$.ajax({
					type: "post",
					url: "<%=basePath%>check/toUpdateStatus.do",
					data:{
						userId : userId,
						uId : uId,
						status : status,
						createDate : createDate,
						newStatus : newStatus
					},
					dataType:"json",
					error:function(){
						layer.close(indexlayer);
					},
					success: function(data){
						
						//成功
						layer.close(indexlayer);
						if(data=="1"){
							var cPage = $("#currentPage").html();
							layer.msg("保存成功！",{icon:1,time:1000});
							loadTeacherCheckList(departmentId, queryContent, userId, cPage);	
						}else{
							layer.msg("保存失败！",{icon:2,time:1000});
						}
					}
				});
			}, function(){
			  
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
			var userId = $("#userId").val();
			//部门
			var departmentId = $("#departmentSelect").val();
			var queryContent = $("#queryContent").val();
			loadTeacherCheckList(departmentId, queryContent, userId, cPageInt);
			$("#currentPage").html(cPageInt);
		}
	</script>
</html>