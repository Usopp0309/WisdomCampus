<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>学生家长管理</title>
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
	                        <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>学生家长管理</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">学生家长管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
											<r:right rightCode="classManager">
													<li class="roleLi">
														<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
													</a>
													</li>
											</r:right>
										</c:if>
									</c:forEach>
									<input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}"/>		
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
		                        <c:if test="${sessionScope.user.type != 2}">
									<r:right rightCode="studentParentAdd">
								        <button class="btn btn-default" type="button" id="addStudent">增加学生</button>
								        <button class="btn btn-default" type="button" id="importStudent">导入学生</button>
								        <button class="btn btn-default" type="button"   data-toggle="modal" href="#importStudent_">导出人员</button>
										<button class="btn btn-default" type="button" id="batchUpdateImport">批量更新人员信息</button>
										<button class="btn btn-default" type="button" data-toggle="modal" href="#small">导出学生缴费信息</button>
									</r:right>
								</c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择类型：</span>
	                         		<select class="m_input form-control" id="type">
										<option value="student">--学生--</option>
										<option value="parent">--家长--</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择班级：</span>
	                         		<select class="m_input form-control" id="clazzList">
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" value="${queryContent}" placeholder="姓名、学号、手机号..." class="m_input form-control" id="queryContent"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn design_btn" id="search">查找</button>	
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>学生家长管理</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
											<tr id="thead">
											</tr>
										</thead>
										<tbody id="tbody">
										</tbody>
	                                </table>
	                            </div>
	                        </div>
	                        <r:right rightCode="studentParentModify"><input type="hidden" id="hasModifyPriv"></input></r:right>
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
	         <div class="modal fade" id="small" tabindex="-1" role="dialog" aria-hidden="true">
	        <div class="modal-dialog modal-md">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">导出</h4>
	                </div>
	                <div class="modal-body">
	                	<form action="#" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择类型：</label>
                                                <div class="col-md-8" style="margin-top:8px;" id="pay_">
                                                   <input type="radio" value="0" name="pay" checked="checked"/>&nbsp;已缴费&nbsp;&nbsp;&nbsp;<input type="radio" value="1" name="pay"/>&nbsp;未缴费
                                                </div>
                                            </div>
                                        </div>
                                    </form>
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn green" onclick="importStudent();">导出</button>
	                    <button type="button" class="btn" data-dismiss="modal" id="quxiao">取消</button>
	                </div>
	            </div>
	            <!-- /.modal-content -->
	        </div>
	        <!-- /.modal-dialog -->
	        </div>
	           <div class="modal fade" id="importStudent_" tabindex="-1" role="dialog" aria-hidden="true">
	        <div class="modal-dialog modal-md">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">导出</h4>
	                </div>
	                <div class="modal-body">
	                	<form action="#" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择类型：</label>
                                                <div class="col-md-8" style="margin-top:8px;" id="st_">
                                                   <input type="radio" value="0" name="pay" checked="checked"/>&nbsp;简单信息&nbsp;&nbsp;&nbsp;<input type="radio" value="1" name="pay"/>&nbsp;详细信息
                                                </div>
                                            </div>
                                        </div>
                                    </form>
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn green" onclick="exportStudent();">导出</button>
	                    <button type="button" class="btn" data-dismiss="modal" id="e_quxiao">取消</button>
	                </div>
	            </div>
	            <!-- /.modal-content -->
	        </div>
	        <!-- /.modal-dialog -->
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
	var objectData="";
		jQuery(document).ready(function() {
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","studentParentManage"); 
			//页面初始化时候的数据加载
			var userId = $("#userId").val();
			var roleId = $("#userTab li.active").find('a').attr("attr2");
			//加载班级信息
			loadclazzList(userId, 'studentParentManager');
			
			//加载增加按钮
			loadModifyBtn(roleId);
			//点击tab页加载
			$("#userTab  li a").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleId = $(this).attr("attr2");
				loadclazzList(userId, 'studentParentManager');
				loadStudentList(null, userId, roleId, null);
				//加载增加按钮
				loadModifyBtn(roleId);		
			});

			//点击增加学生页面
			$("#addStudent").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>student/toAddStudent.do',{userId:userId,roleId:roleId});
			});
			//点击增加学生页面
			$("#addStudentParent").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>student/toAddParent.do',{userId:userId,roleId:roleId});
			});
			
			//点击进入导入学生页面
			$("#importStudent").click(function(){
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>student/toImportStudent.do',{userId:userId,roleId:roleId});
			});
			
			//条件查询
			$("#search").click(function(){
				//班级ID
				var clazzId = $("#clazzList").val().replace("C", "");
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (clazzId != 0)
				{
					loadStudentList(clazzId, userId, roleId, null);
				}
				else
				{
					loadStudentList(null, userId, roleId, null);
				}
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;	
            	}
			});	
			
			//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#clazzList").change(function(){
				//查询条件
				var queryContent = $.trim($("#queryContent").val());		
				//班级ID
				var clazzId = $(this).val().replace("C", "");
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (clazzId != "")
				{
					loadStudentList(clazzId, userId, roleId, null);
				}
				
			});			
			
			$("#type").change(function(){
				var typeValue = $("#type").val();
				if(typeValue == 'student'){
					$("#queryContent").attr("placeholder", "姓名、学号...");
				}else{
					$("#queryContent").attr("placeholder", "姓名、手机号...");
				}
				
			});
			//点击进入批量更新人员页面
			$("#batchUpdateImport").click(function(){
				var userId = $("ul li.active").find('a').attr("attr1");	
				var roleId = $("ul li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>student/batchUpdateImport.do',{userId:userId,roleId:roleId});
			});
			
		});
		//导出人员
		function exportStudent(){
			var payType = $('#st_ input[name="pay"]:checked ').val();
		    $("#e_quxiao").click();
		    //简单信息
		    if(payType==0){
			//人员类型
			var userType = $("#type").val();
			//班级ID
			var clazzId = $("#clazzList").val();
			standardPost('<%=basePath%>student/doExportExcel.do',{userType:userType,clazzId:clazzId});
		    }else{//详细信息
		    //查询条件
			var queryContent = $.trim($("#queryContent").val());
			//班级ID
			var clazzId = $("#clazzList").val().replace("C", "");
			//var userId = $("#userTab li.active").find('a').attr("attr1");	
			//var roleId = $("#userTab li.active").find('a').attr("attr2");
			standardPost('<%=basePath%>student/exportStudentDetail.do',{queryContent:queryContent,clazzId:clazzId});
		    }
		}
		//导出学生信息
		function importStudent(){
			var payType = $('#pay_ input[name="pay"]:checked ').val();
			$("#quxiao").click();
			standardPost('<%=basePath%>student/payExportExcel.do',{payType:payType});
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
					var appendHtml ='';
					 if(clazzList.length==0){
					 appendHtml = '<option value="" selected="selected">---请选择---</option>';
					 }
					$.each(clazzList, function(n, value) {
						if (n == 0){
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
							appendHtml+= '<option value="">---全部---</option>';
						}else{
							appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
						}
           			}); 
           			$("#clazzList").html(appendHtml);
           			if("${clazzId}"!="" && "${clazzId}"!=0){
           				$("#clazzList").val("${clazzId}");	
           			}
           			$("#clazzList").change();
				},
			});
		}
		//排序
		function orderby(obj,tag){
			var list="";
			var order="";
			var key=tag+"_";
			if($(obj).hasClass("SortAscCss")){
				$(obj).removeClass("SortAscCss");
				order="SortDescCss";
				list=jsonSort(objectData.list,tag,true);
			}else if($(obj).hasClass("SortDescCss")){
				$(obj).removeClass("SortDescCss");
				order="SortAscCss";
				list=jsonSort(objectData.list,tag,false);
			}else{
				order="SortAscCss";
				list=jsonSort(objectData.list,tag,false);
			}
			objectData.list=list;
			showList(objectData,order,key);
		}
		function showList(data,order,key){
			var body = $("#body");
			App.blockUI(body);
			var userType = $("#type").val();
			var hasModifyPriv = false;
			if ($("#hasModifyPriv").length > 0){
				hasModifyPriv = true;
			}else{
				hasModifyPriv = false;
			}
			if(userType == 'student'){
				var appendHeadHtml = '';
				appendHeadHtml +='<th>姓名</th>';
				appendHeadHtml +='<th class="hidden-sm hidden-md">学号</th>';
				appendHeadHtml +='<th class="hidden-sm hidden-md">学生手机号</th>';
				appendHeadHtml +='<th>家长姓名</th>';
				appendHeadHtml +='<th >家长手机号</th>';
				appendHeadHtml +='<th class=" hidden-sm hidden-md">类型</th>';
				appendHeadHtml +='<th class=" hidden-sm hidden-md">卡号</th>';
				if("${count}">0){
					appendHeadHtml +='<th class="">服务费</th>';	
				}
				
				appendHeadHtml +='<th class=""  id="createTime_" onclick="orderby(this,\'createTime\');">更新时间</th>';
				if (hasModifyPriv){
					appendHeadHtml +='<th class="">编辑</th>';
				}
				$("#thead").html(appendHeadHtml);
			}else{
				var appendHeadHtml = '';
				appendHeadHtml +='<th class="">姓名</th>'
				appendHeadHtml +='<th class="">学生姓名</th>'
				appendHeadHtml +='<th class="">手机号码</th>';
				appendHeadHtml +='<th class=""  id="createTime_" onclick="orderby(this,\'createTime\');">创建时间</th>';
				appendHeadHtml +='<th class="">卡号</th>';
				/* if (hasModifyPriv){
					appendHeadHtml +='<th>编辑</th>';
				} */
				$("#thead").html(appendHeadHtml);
			}
			var page =data;
			$("#currentPage").html(page.currentPage);
			$("#totalPage").html(page.totalPage);
			var appendHtml = '';
			$.each(page.list, function(n, value) {  
				appendHtml += '<tr>';
				var time = value.updateTime;
				if (typeof(time)=="undefined" || time==""){
					time =value.createTime;
					if(typeof(time)=="undefined" || time==""){
						time="";
					}else{
						time = time.substr(0, time.length-2);
					}
				}else{
					time = time.substr(0, time.length-2);
				}
				if(userType == 'student'){
       				appendHtml += '<td style="vertical-align: middle;" rowspan="'+value.parentList.length+'">' + value.realName + '</td>';
        			appendHtml += '<td  class="hidden-sm hidden-md" style="vertical-align: middle;"  rowspan="'+value.parentList.length+'">' + value.code + '</td>';
    				 if(typeof(value.studentPhone)!="undefined"){
        				appendHtml += '<td class="hidden-sm hidden-md" style="vertical-align: middle;" rowspan="'+value.parentList.length+'" >' + value.studentPhone + '</td>';	
        			}else{
        				appendHtml += '<td class="hidden-sm hidden-md" style="vertical-align: middle;" rowspan="'+value.parentList.length+'"></td>';
        			} 
        			$.each(value.parentList, function(p, parentList) {  
            			if(p==0)
            			{
	            			appendHtml += '<td>' + parentList.parentname + '</td>';
	            			appendHtml += '<td>' + parentList.phone + '</td>';
	            			//学生类型
	           				var type = parseInt(value.schoolType);
	           				switch(type)
	           				{ 
	           					case 0 : 
	           						appendHtml += '<td  class="hidden-sm hidden-md" style="vertical-align: middle;"  rowspan="'+value.parentList.length+'">走读生</td>';
	           						break; 
	           					case 1 : 
	           						appendHtml += '<td  class="hidden-sm hidden-md" style="vertical-align: middle;"  rowspan="'+value.parentList.length+'">住宿生</td>';
	           						break; 
	           					case 2 : 
	           						appendHtml += '<td  class="hidden-sm hidden-md" style="vertical-align: middle;"  rowspan="'+value.parentList.length+'">停用</td>';
	           						break; 
	           					default : 
	           						appendHtml += '<td  class="hidden-sm hidden-md" style="vertical-align: middle;"  rowspan="'+value.parentList.length+'">其他</td>';
	           						break;
	           				} 
	           				appendHtml += '<td class="hidden-sm hidden-md" style="vertical-align: middle;"  rowspan="'+value.parentList.length+'">' + value.cardCode + '</td>';
	           				if("${count}">0){
	           				if(value.orderMessage>0){
	           					appendHtml += '<td  style="vertical-align: middle;color:green;"  rowspan="'+value.parentList.length+'">已购买</td>';	
	           				}else{
	           					appendHtml += '<td  style="vertical-align: middle;color:red;"  rowspan="'+value.parentList.length+'">未购买</td>';		
	           				}
	           				}
	            			appendHtml += '<td style="vertical-align: middle;"  rowspan="'+value.parentList.length+'">' + time + '</td>';
	            			if (hasModifyPriv){
	            				appendHtml += '<td  style="vertical-align: middle;"  rowspan="'+value.parentList.length+'"><a href="javascript:;" onclick="modifyStudent(' + value.userId + ', \''+ userType +'\')" class="btn btn-sm update_btn">修改</a>';
	            				appendHtml += ' <c:if test="${sessionScope.user.type != 2}">   <a href="javascript:;" onclick="delUser(' + value.userId + ')" class="btn btn-sm delete_btn">删除</a></c:if></td>';
	            			}
	           				appendHtml += '</tr>';
            			}else
            			{
            				
    						appendHtml += '<tr>';
            				appendHtml += '<td>' + parentList.parentname + '</td>';
	            			appendHtml += '<td>' + parentList.phone + '</td>';
            				appendHtml += '</tr>';
            			}
            			
        			}); 
        			
				}else{
					if(value.studentList!=null && value.studentList.length>0){
					appendHtml += '<td style="vertical-align: middle;" rowspan="'+value.studentList.length+'">' + value.realName + '</td>';
        			$.each(value.studentList, function(s, studentList) {  
        				if(s==0)
            			{
        					appendHtml += '<td>' + studentList.studentName + '</td>';

        					appendHtml += '<td style="vertical-align: middle;" rowspan="'+value.studentList.length+'">' + value.phone + '</td>';
	            			
	            			appendHtml += '<td style="vertical-align: middle;" rowspan="'+value.studentList.length+'">' +time + '</td>';
	            			appendHtml += '<td style="vertical-align: middle;" class=" hidden-sm hidden-md" rowspan="'+value.studentList.length+'">' + value.cardCode + '</td>';
	            			/* if (hasModifyPriv){
	            				//appendHtml += '<td class="Response" width="10%" style="vertical-align: middle;" rowspan="'+value.studentList.length+'"><a href="javascript:;" class="edit" onclick="modifyStudent(' + value.userId + ', \''+ userType +'\')">修改</a>';
	            				appendHtml += '<td class="Response" width="10%" style="vertical-align: middle;" rowspan="'+value.studentList.length+'">';
	            				appendHtml += ' <c:if test="${sessionScope.user.type != 2}">   <a href="javascript:;" class="edit" onclick="delUser(' + value.userId + ')">删除</a></c:if></td>';
	            			} */
	           				appendHtml += '</tr>';
        					
            			}else
        				{
            				
    						appendHtml += '<tr>';
            				appendHtml += '<td>' + studentList.studentName + '</td>';
            				appendHtml += '</tr>';
            			}
            			
    				}); 
				}
				}
    			
  			}); 
  			$("#tbody").html(appendHtml);
  			$("#"+key).addClass(order);
  			/* if(userType == 'student'){
  				//new TableSorter("sample_1",0,1,2,3,4,5,6);
  			}else{
  				//new TableSorter("sample_1",0,1,2,3);
  			} */
  			

  			//解锁UI
  			App.unblockUI(body);
  			
		}
		//加载学生页面
		function loadStudentList(clazzList, userId, roleId, cPage)
		{
			//查询条件
			var queryContent = $.trim($("#queryContent").val());
			var body = $("#body");
			App.blockUI(body);
			var userType = $("#type").val();
			var hasModifyPriv = false;
			if ($("#hasModifyPriv").length > 0){
				hasModifyPriv = true;
			}else{
				hasModifyPriv = false;
			}
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>student/getStudentList.do",
				dataType:"json",
				data:{
				    	clazzList : clazzList,
					    queryContent : queryContent,
						userId : userId,
						roleId : roleId,
						userType : userType,
						cPage : cPage
					},
				success: function(data){
					objectData=data;
					//alert(JSON.stringify(data));
					showList(data,'SortDescCss',"updateTime_");
				},
			});
		}

		//点击进入学生修改页面
		function modifyStudent(studentId, userType)
		{
			var queryContent=$.trim($("#queryContent").val());
			standardPost('<%=basePath%>student/toModifyStudentOrParent.do',{studentId:studentId,userType:userType,"queryContent":queryContent});
		}
		function delUser(userId){
			//询问框
			var ll=layer.confirm('确定要删除该用户？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
			 layer.close(ll);
			 var indexlayer = layer.msg('正在删除数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			 $.ajax({
					type: "post",
					url: "<%=basePath%>student/delUser.do",
					data:{
						userId : userId
					},
					success: function(data){
						layer.close(indexlayer);
						if (data == '0'){
							layer.msg("删除成功！",{icon:1,time:1000});
							var clazzId = $("#clazzList").val().replace("C", "");
							var userId = $("#userTab li.active").find('a').attr("attr1");	
							var roleId = $("#userTab li.active").find('a').attr("attr2");
							//clazzId为0表示选择所有班级，不为0表示选择某个班级
							if (clazzId != 0)
							{
								loadStudentList(clazzId, userId, roleId, null);
							}
							else
							{
								loadStudentList(null, userId, roleId, null);
							}	
						}else{
							layer.msg("删除失败！",{icon:2,time:1000});
						}
	          			/* $(".search_box").css({"display":"none"}); */
					}
				}); 
			 
			}, function(){
			  
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
		            iframe.contentWindow.document.body.scrollHeight + 100;
		            var dHeight = 
		            iframe.contentWindow.document.documentElement.scrollHeight;
		            var height = Math.max(bHeight, dHeight);
		            iframe.height = height;
		        }
		    }
		}
		//分页时重新设置 iframe 高度 ； 修改后：iframe.name = iframe.id
		var reSetIframeHeight = function()
		{
		    try 
		    {
		        var oIframe = parent.document.getElementById(window.name);
		        oIframe.height = 100;
		        iframeLoaded(oIframe);
		    }
		    catch (err)
		    {
		        try 
		        {
		        	parent.document.getElementById(window.name).height = 1000;
		        }
		        catch (err2) 
		        {
			    }
		    }
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

			//学号
			var queryContent = $.trim($("#queryContent").val());


				//班级ID
				var clazzId = $("#clazzList").val().replace("C", "");
				
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleId = $("#userTab li.active").find('a').attr("attr2");
				
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (clazzId != 0)
				{
					loadStudentList(clazzId, userId, roleId, cPageInt);
				}
				else
				{
					loadStudentList(null, userId, roleId, cPageInt);
				}
			$("#currentPage").html(cPageInt);
		}
		//加载修改按钮
		function loadModifyBtn(roleId)
		{
			//如果是系统管理员，超级管理员，校长，班主任则有发布权限
			var roleIdInt = parseInt(roleId);

			switch(roleIdInt)
			{ 
				case 1 : 
					$("#modifyStudent").show();
					break; 
				case 2 : 
					$("#modifyStudent").show(); 
					break; 
				case 3 : 
					$("#modifyStudent").show(); 
					break; 
				case 4 : 
					$("#modifyStudent").hide();
					break; 
				default : 
					$("#modifyStudent").hide();
					break;
			} 
		}
	</script>
</html>