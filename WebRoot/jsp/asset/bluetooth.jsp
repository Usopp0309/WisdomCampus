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
<title>蓝牙手环</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<!--公共css开始-->
<%@ include file="/public_module/public_css_new.jsp"%>
<!--公共css结束-->
<style type="text/css">
.useing {
	color: #f92d68
}

.unusing {
	color: #666
}

.returned {
	color: #ff8212
}

.state input {
	margin: 15px;
}
</style>
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed"
	id="body">
	<input class="themes" type="hidden" value="<%=ThemePath%>">
	<input type="hidden" value="${user.schoolId}" id="schoolId">
	<input type="hidden" value="${user.userId}" id="userId">
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
							<li><a href="<%=basePath%>user/enterMain.do">首页</a><i
								class="fa fa-circle"></i></li>
							<li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i
								class="fa fa-circle"></i></li>
							<li><span>蓝牙手环</span></li>
						</ul>
					</div>
					<h3 class="page-title">蓝牙手环</h3>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<!-- 添加功能菜单开始 -->
							<div class="portlet light form-fit m_margin_0_0_15_0">
								<a
									class="btn btn-default"
									href="<%=basePath%>data/toRecord.do">历史记录</a>
									<a class="btn btn-default" href="<%=basePath%>bracelet/toRouter.do">hub配置</a>
									<a class="btn btn-default" href="<%=basePath%>bracelet/toBluetoothCourse.do">添加课程</a>
									<a class="btn btn-default" href="<%=basePath%>bracelet/toBluetoothCourseTime.do">课程时间设置</a>
							</div>
							<!-- 添加功能菜单结束 -->
							<div class="portlet box green m_margin_15_auto_0">

								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-list"></i>手环列表
									</div>
								</div>
							</div>

							<div class="portlet light form-fit m_margin_0_0_15_0"
								style="margin-top: 10px;">
								<a class="btn btn-default" data-toggle="modal" data-target="#update" onclick="addData();">添加手环</a>
								<a class="btn btn-default" href="javascript:void(0);" onclick="deleteAll();">删除手环</a>
								<a class="btn btn-default" href="<%=basePath%>bracelet/toBathBracelet.do">批量绑定人员</a>
								<a class="btn btn-default" href="javascript:void(0);" onclick="deleteAllRelation();">删除绑定</a>
							</div>

							<div class="portlet-body flip-scroll">
								<table class="table table-hover table-bordered table-condensed"
									cellpadding="0" cellspacing="0">
									<thead>
										<th width="3%"><input type="checkbox" name="bluebooth_radio" onclick="checkAll(this);" /></th>
										<th  width="10%">手环地址</th>
										<th width="10%">手环编号</th>
										<th width="5%">学生</th>
										<th width="10%">学号</th>
										<th width="10%">班级</th>
										<th width="10%">课程</th>
										<th width="10%">开始时间</th>
										<th width="10%">结束时间</th>
										<th width="5%">状态</th>
										<th width="15%">编辑</th>
									</thead>
									<tbody id="tbody">

									</tbody>
								</table>
							</div>
						</div>
						<!-- 分页开始 -->
					 <%@include file="/public_module/public_page.jsp" %>
						<!-- 分页结束 -->

						<!-- 修改状态弹窗 start-->
						<div class="modal fade" id="updateState" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-body">
										<div style="text-align: center;" class="state" id="statusList">
											<input type="radio" value="0" name="useState" id="s0" /><em class="useing">未使用</em> 
											<input type="radio" value="1" name="useState" id="s1" /><em class="unusing">停用</em> 
											<input type="radio"  value="2" name="useState" id="s2" /><em class="returned">使用中</em>
											<input type="radio" value="3"  name="useState" id="s3" /><em class="returned">未归还</em>
										</div>
									</div>
									<div class="modal-footer"
										style="border-top: none; margin-right: 70px;">
										<button type="button" class="btn btn-default" data-dismiss="modal" id="ups">取消</button>
										<input value="" type="hidden" id="updateId">
										<button type="button" class="btn btn-success" onclick="updateStatus();">保存</button>
									</div>
								</div>
							</div>
						</div>
						<!-- 操作手环 start-->
				<div class="modal fade" id="update" aria-labelledby="myModalLabel">
							<input type="hidden" id="id_" value="">
							<input id="upStatus"  type="hidden" value=""/>
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-body">
							<div style="text-align:left;">
							  <h4>修改蓝牙手环</h4>
							</div>
							<hr>
							<div style="text-align: center;">
							    <div class="modal-body">
							 <form action="#" method="post" id="addForm"
											class="form-horizontal">
											<div class="form-body">
												<div class="form-group">
													<label class="control-label col-md-3 col-lg-3"
														for="inputSuccess">蓝牙手环地址</label> <input id="mac"
														class="m_input form-control" type="text"
														style="width: 400px;">

												</div>
												<div class="form-group">
													<label class="control-label col-md-3 col-lg-3"
														for="inputSuccess">蓝牙手环编号</label> <input id="code"
														class="m_input form-control" type="text"
														style="width:400px;">
												</div>
												
											</div>
										</form>
							</div>
							 </div>
							<div class="modal-footer"
										style="border-top: none; margin-right: 70px;">
										<button type="button" class="btn btn-default"
											data-dismiss="modal" id="quxiao">取消</button>
										<button type="button"  class="btn btn-success" onclick="saveShouHuan(this);">保存</button>
							</div>
						</div>
					</div>
		        </div>
		        </div>
		        		<!-- 绑定学生-->
				<div class="modal fade" id="bindStudent" aria-labelledby="myModalLabel">
					<input type="hidden" id="id_" value="">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div style="text-align:left;">
							  <h4 style="margin-top:20px;margin-left: 15px;">绑定学生</h4>
							</div>
							<hr>
							<div style="text-align: left;">
							 <form action="#" method="post" id="addForm"
											class="form-horizontal">
											<div class="form-body">
											<div class="form-group">
													<label class="control-label col-md-3 col-lg-3"
														for="inputSuccess">蓝牙编号</label> <input readonly="readonly"
														class="m_input form-control" type="text"
														style="width: 400px;" id="bidCode">
                                                        <input value="" type="hidden" id="bid">
												</div>
												<div class="form-group">
													<label class="control-label col-md-3 col-lg-3"
														for="inputSuccess">选择课程时间</label> <select class="form-control" style="width: 400px;"  tabindex="1" name="courses" id="courses">
                                                    <option value="">--选择课程时间--</option>
                                                    <c:if test="${courseTime != null && fn:length(courseTime) > 0 }">
	                                                    <c:forEach var="t" items="${courseTime}">
	<%--                                                     //${t.courseName}(${t.startTime}-${t.time}) --%>
	                                                    <option value="${t.id }">${t.time}</option>
	                                                    </c:forEach>
                                                    </c:if>
                                                    
		                                            </select>  
												</div>
												<div class="form-group">
													<label class="control-label col-md-3 col-lg-3">选择班级</label>
													<select class="form-control" id="clazzList"
														style="width: 400px;" onchange="chooseClazz();">
													</select>
												</div>
												<div class="form-group state" id="bindStatus">
													<label class="control-label col-md-3 col-lg-3">状态</label> <input
														type="radio" name="useState" id="0_" value="0" checked="checked" /><em>未使用</em> <input
														type="radio" name="useState"  value="1" id="1_"  /><em>停用</em> <input
														type="radio" name="useState" value="2"  id="2_" /><em>使用中</em> <input
														type="radio" name="useState" value="3"  id="3_" /><em>未归还</em>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3 col-lg-3">使用对象</label>
													<div class="col-md-4 col-lg-2"
														style="width:400px; padding: 10px;max-height:400px;overflow-y:auto; " id="students">
														
													</div>
											</div>
										</form>
							 </div>
							<div class="modal-footer"
										style="border-top: none; margin-right: 70px;">
										<button type="button" class="btn btn-default"
											data-dismiss="modal" id="quxiao">取消</button>
										<button type="button"  class="btn btn-success" onclick="saveBindStudent(this);">保存</button>
							</div>
					</div>
		        </div>
		        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部开始 -->
	<%@ include file="/public_module/public_footer.jsp"%>
	<script src="<%=basePath%>assets/global/plugins/map.js" type="text/javascript" ></script>
	<!-- 底部结束 -->
</body>
<!-- 公共js开始 -->
<%@ include file="/public_module/public_js.jsp"%>
<!-- 公共js结束 -->
<script type="text/javascript">
    var clazzUserMap=new Map();
    $(function(){
    	loadSubMenu("assetManagement");  
		//选取当前菜单位置
		setActive("assetManagement","bluetoothList");      	
    	init(1);
    	initClazz();
    });
    function checkAll(obj){
    	if($(obj).is(":checked")){
    		$("#tbody tr td input[type='checkbox']").each(function(){
    			if(!$(this).is(":checked")){
    				$(this).prop("checked", "checked");
    			}
    		});
    	}else{
    		$("#tbody tr td input[type='checkbox']").each(function(){
    			if($(this).is(":checked")){
    				$(this).prop("checked",false);
    			}
    		});	
    	}
    }
    //修改状态
    function updateStatus(){
    	var useState= $('#statusList input:radio[name="useState"]:checked').val();
    	var id=$("#updateId").val();
    	 var indexlayer = layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
    	 $.ajax({
  			type: "post",
  			url: "<%=basePath%>bracelet/updateStatus.do",
  			dataType:"json",
  			data:{
  				"status":useState,"id":id
  				},
  			success: function(data){
  				layer.close(indexlayer);
  				if(data==200){
  					layer.msg("保存成功",{icon:1,time:1000}); 
  					$("#ups").click();
					init(1);
  				}else{
  					layer.msg("保存失败",{icon:2,time:1000}); 
  				}
  			}
  		});
    }
    function updateStatusById(id,status){
    	$("#updateId").val(id);
    	$("#s"+status).prop("checked", "checked");
    }
    
  	//删除选中的手环
    function deleteAllRelation(){
    	var ids=[];
    	$("#tbody tr td input[type='checkbox']").each(function(){
			if($(this).is(":checked")){
				ids.push($(this).attr("idValue"));	
			}
		});	
    	if(ids.length==0){
    		layer.msg("请选择要删除的绑定数据！",{icon:0,time:2000});
    		return;
    	}
    	var ll=layer.confirm('是否删除绑定？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    			 var indexlayer = layer.msg('正在删除数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
    			$.ajax({
    				type: "post",
    				url: "<%=basePath%>bracelet/deleteStudentBathIds.do",
    				dataType:"json",
    				data:{
    					ids:ids.join(",")
    					},
    				success: function(data){
    					layer.close(ll);
    					layer.close(indexlayer);
    				 if(data==200){
    					layer.msg("删除成功",{icon:1,time:1000}); 
    					var cPage = $("#currentPage").html();
    					init(cPage);
    				 }else{
    					layer.msg("删除失败",{icon:2,time:1000});  
    				 }
    				}
    			});
    		}, function(){
    			layer.close(ll);
				layer.close(indexlayer);
    		});
		  	 
    }
    
    //删除选中的手环
    function deleteAll(){
    	var ids=[];
    	$("#tbody tr td input[type='checkbox']").each(function(){
			if($(this).is(":checked")){
				ids.push($(this).attr("idValue"));	
			}
		});	
    	if(ids.length==0){
    		layer.msg("请选择要删除的数据！",{icon:0,time:2000});
    		return;
    	}
    	var ll=layer.confirm('确定要删除选中的数据？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    			 var indexlayer = layer.msg('正在删除数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
    			$.ajax({
    				type: "post",
    				url: "<%=basePath%>bracelet/deleteBluetoothBraceletByIds.do",
    				dataType:"json",
    				data:{
    					ids:ids.join(",")
    					},
    				success: function(data){
    					layer.close(ll);
    					layer.close(indexlayer);
    				 if(data==200){
    					layer.msg("删除成功",{icon:1,time:1000}); 
    					var cPage = $("#currentPage").html();
    					init(cPage);
    				 }else{
    					layer.msg("删除失败",{icon:2,time:1000});  
    				 }
    				}
    			});
    		}, function(){
    			layer.close(ll);
				layer.close(indexlayer);
    		}); 
    }
    //绑定人员
    function bindStudent(bid,code,bluetoothCourseTimeId,userId,clazzId,status){
    	$("#bidCode").val(code);
    	$("#bid").val(bid);
    	$("#courses").val(bluetoothCourseTimeId);
    	$("#clazzList").val(clazzId);
    	$("#"+status+"_").prop("checked", "checked");
    	chooseClazz();
    	$("#"+userId).addClass("btn-success");
    	$("#"+userId).removeClass("btn-default");
    }
    //保存绑定的人员
    function saveBindStudent(obj){
    	var bid=$("#bid").val();//蓝牙手环主键
    	var coursesTime=$("#courses").val();//时间课程主键
    	var useState= $('#bindStatus input:radio[name="useState"]:checked').val();
    	var stuName="";
    	var stuUserId="";
    	var userCode="";
    	var clazzId=$("#clazzList").val();
    	var clazzName=$("#clazzList ").find("option:selected").text();
    	$("#students").find("a").each(function(){
    		if($(this).hasClass("btn-success")){
    			stuUserId=$(this).attr("id");
    			userCode=$(this).attr("code");
    			stuName=$(this).text();
    			return;
    		}
    	});
    	if(coursesTime=="" || coursesTime == null){
    		layer.tips("请选择课程",$("#courses"));
    		return;
    	}else if(stuName==""){
    		layer.tips("请选择学生",$("#students"));
    		return;	
    	}
    	var indexlayer = layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
    	 $.ajax({
  			type: "post",
  			url: "<%=basePath%>bracelet/savaStudent.do",
  			dataType:"json",
  			async: false,
  			data:{
  				bid:bid,
  				coursesTime:coursesTime,
  				studentName:stuName,
  				stuUserId:stuUserId,
  				clazzId:clazzId,
  				clazzName:clazzName,
  				useState:useState,
  				userCode:userCode
  				},
  			success: function(data){
  				layer.close(indexlayer);
  				if(data==200){
  					layer.msg("绑定成功",{icon:1,time:1000});
  					$(obj).prev().click();
  					init(1);
  				}else{
  					layer.msg("绑定失败",{icon:2,time:2000});	
  				}
  			}
  		});
    }
    //检查提交的参数
    function checkSave(mac,code,bbId){
    	var flag=false;
    	 $.ajax({
 			type: "post",
 			url: "<%=basePath%>bracelet/checkBraceletSave.do",
 			dataType:"json",
 			async: false,
 			data:{
 				mac:mac,
 				code:code,
 				bbId:bbId
 				},
 			success: function(data){
 				if(data.ResponseCode==1){
 					layer.tips(data.ResponseObject,$("#mac"));
 				}else if(data.ResponseCode==2){
 					layer.tips(data.ResponseObject,$("#code"));
 				}else if(data.ResponseCode==0){
 					flag=true;
 				}
 			}
 		});
    	return flag;
    }
    
    //添加手环
    function saveShouHuan(obj){
    	var status=$("#upStatus").val();
    	var id_=$("#id_").val();
    	var mac=$.trim($("#mac").val());
    	var code=$.trim($("#code").val());
    	if(mac==''){
        	layer.tips("请输入手环的mac地址",$("#mac"));
        	return;
        }else if(code==''){
       		layer.tips("请输入手环的编号",$("#code"));
           	return;
        }
    	if(!checkSave(mac,code,id_,status)){
	    	   return;	
	    }
    	var indexlayer = layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
   	 	$.ajax({
			type: "post",
			url: "<%=basePath%>bracelet/saveBracelet.do",
			dataType:"json",
			data:{
				mac:mac,
				code:code,
				id:id_,
				status:status
			},
			success: function(data){
					layer.close(indexlayer);
					if(data==200){
						layer.msg("保存成功",{icon:1,time:1000});
						init(1);
						$(obj).prev().click();
					}else{
						layer.msg("保存失败",{icon:2,time:2000});	
					}
			}
		}); 
    }
    //获得班级
    function initClazz(){
    	var userId=$("#userId").val();
    	$.ajax({
			type: "post",
			url: "<%=basePath%>sms/getAllStudentList.do",
			dataType:"json",
			data:{
					userId :userId,
					permissionCode : "studentMessageManager"
				},
			success: function(data){
				var clazzList =data.clazzList;
				var appendHtml = '<option value="">--请选择班级--</option>';
				$.each(clazzList, function(n, value) {
					appendHtml += '<option value="' + value.id + '" userCode="'+value.code+'">' + value.clazzName + '</option>';
       			});  
       			$("#clazzList").html(appendHtml);
       			clazzUser(clazzList,data.studentList);
			}
		});
    }
    //选择班级
    function chooseClazz(){
    	var clazz=$("#clazzList").val();
    	var userList=clazzUserMap.get(clazz);
    	if(userList){
    		var html='';
    		for(var i=0;i<userList.length;i++){
    			//
    			html+='<a onclick="chUser(this);" class="btn btn-default" style="margin-top:5px;" href="javascript:void(0);" id="'+userList[i].userId+'" code="'+userList[i].code+'">'+userList[i].realName+'</a>&nbsp;';
    		}
    		$("#students").html(html);
    	}
    }
    //点击学生加载样式
    function chUser(this_){
    	$("#students").find("a").each(function(){
    		if($(this).hasClass("btn-success")){
    			$(this).removeClass("btn-success");
    			$(this).addClass("btn-default");
    		}
    	});
    	$(this_).addClass("btn-success");
    }
  	//将学生与班级的关系存入Map中，key:clazzId,value:对应学生数组
    function clazzUser(classId,studengList){
		for(var i=0;i<classId.length;i++){
		 	for(var k=0;k<studengList.length;k++){
		  		 if(classId[i].id==studengList[k].clazzId){
		  			 if(clazzUserMap.containsKey(classId[i].id)){
		  				 var userarray=clazzUserMap.get(classId[i].id);
		  				 userarray.push(studengList[k]);
		  			 }else{
		  				 var userarray=[];
		  				 userarray.push(studengList[k]);
		  				 clazzUserMap.put(classId[i].id,userarray);
		  			 }
		  		 }
		  	 }
		}
    }
    
    function upddate(id,mac,code,status){
      $("#id_").val(id);
      $("#mac").val(mac);
  	  $("#code").val(code);
  	  $("#upStatus").val(status);
  
    }
    
    function addData(){
    	$("#id_").val("");	
    	$("#mac").val("");
    	$("#code").val("");
    }
    
    //初始化数据
    function init(page){
    	var indexlayer = layer.msg('正在获取数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
    	$.ajax({
    		url:"<%=basePath%>bracelet/getPageBracelet.do",
    		type:"POST",
    		dataType:"json",
    		data:{"page":page,pageSize:50},
    		success:function(data){
    		    var html='';
    		    $("#currentPage").html(data.currentPage);
 				$("#totalPage").html(data.totalPage);
    		    var list=data.list;
    			for(var i=0;i<list.length;i++){
    			 html+='<tr>';
    			 html+='<td><input type="checkbox" name="bluebooth_checkbox" idValue="'+list[i].id+'" /></td>';
    			 if(list[i].mac){
    				 html+='<td>'+list[i].mac+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].code){
    				 html+='<td>'+list[i].code+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].studentName){
    				 html+='<td>'+list[i].studentName+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].userCode){
    				 html+='<td>'+list[i].userCode+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].clazzName){
    				 html+='<td>'+list[i].clazzName+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].courseName){
    				 html+='<td>'+list[i].courseName+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].startTime){
    				 html+='<td>'+list[i].startTime+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].endTime){
    				 html+='<td>'+list[i].endTime+'</td>';	 
    			 }else{
    				 html+='<td></td>';
    			 }
    			 if(list[i].status==0){
    				 html+=' <td><span class="useing">未使用</span></td>';	 
    			 }else if(list[i].status==1){
    				 html+=' <td><span class="useing">停用</span></td>';	 
    			 }else if(list[i].status==2){
    				 html+=' <td><span class="useing">使用中</span></td>';	 
    			 }else if(list[i].status==3){
    				 html+=' <td><span class="useing">未归还</span></td>';	 
    			 }else{
    				 html+=' <td></td>';	 
    			 }
    			 html+=' <td>';
    			 html+='  <a class="btn btn-success btn-sm" data-toggle="modal" data-target="#update" onclick=upddate('+list[i].id+',\''+list[i].mac+'\',\''+list[i].code+'\','+list[i].status+');"">修改手环</a>';
    			 html+='<a class="btn btn-success btn-sm" data-toggle="modal" data-target="#updateState" onclick="updateStatusById('+list[i].id+','+list[i].status+');">修改状态</a>';
    			 html+='<a class="btn btn-success btn-sm" data-toggle="modal" data-target="#bindStudent" onclick="bindStudent('+list[i].id+',\''+list[i].code+'\','+list[i].bluetoothCourseTimeId+','+list[i].userId+','+list[i].clazzId+','+list[i].status+');">绑定人员</a>';
    			 html+='</td>';
    			 html+=' </tr>';
    		 }	
    		$("#tbody").html(html);
    		layer.close(indexlayer);
    		},
    		error:function(){
    			layer.close(indexlayer);	
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