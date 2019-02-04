<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>编辑会议</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
        </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed">
    	<input class="themes" type="hidden" value="<%=basePath%>">
        <!-- 公共顶部开始-->
        <%@ include file="/public_module/public_header.jsp"%>    
        <!--公共顶部结束-->
        <div class="clearfix"> </div>
        <!-- 内容页开始 -->
        <div class="page-container">
            <!--主菜单开始-->
            <%@include file="/public_module/public_menu.jsp"%>
            <!--主菜单结束-->
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">会议管理</a><i class="fa fa-circle"></i></li>
                            <li><span>编辑会议</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">编辑会议</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                
                                   <div   class="form-horizontal"  >
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">会议名称</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input type="text" name="meetingName"  id="name" value="${meeting.name}" disabled="disabled" class="form-control"/>
                                                </div>
                                            </div>
                                              <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">会议类型</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select name="inoutType" class="form-control" id="meetingTypeSelect"> 
                                                    	<option value="">--请选择--</option>
                                                    	<option value="0">刷卡</option>
                                                    	<option value="1">wifi</option>
                                                    </select>
													<span class="help-block" style="display: none;color:red;" id="meetingTypeSelectHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">会议地点</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select name="place" class="form-control" id="meetingPlaceSelect" > </select>
													<span class="help-block" style="display: none;color:red;" id="meetingPlaceSelectHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">开始时间</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" value="${meeting.startTime}" name="startTime"  id="startTime"  class="m_input form-control"/>
													<span class="help-block" style="display: none;color:red;" id="startTimeHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">结束时间</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" value="${meeting.endTime}" name="endTime" id="endTime"  class="m_input form-control"/>
													<span class="help-block" style="display: none;color:red;" id="endTimeHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">内容</label>
                                                <div class="col-md-9 col-lg-4">
                                                     <textarea class="form-control" rows="5" name="content" id="content">${meeting.content}</textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">备注</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<textarea class="form-control" rows="5"  name="remark" id="remark">${meeting.remark}</textarea>    
												</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择部门</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select name="departmentList" id="departmentList" data-placeholder="Choose a Category"  class="form-control"></select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">筛选条件</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text"  name="code"  class="form-control" value="" id="search"  
								      			onkeyup="filter(this.value)" onchange="filter(this.value)" onpropertychange="filter(this.value)" oninput="filter(this.value)"/>
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                <label class="control-label col-md-3">发送对象</label>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj"></select>
													<select class="form-control" multiple="multiple" tabindex="1" id="toSelectObj1" style=" display:none"></select>
												</div>	
												<div class="col-md-1 col-lg-1">		
												<button type="button" class="btn default btn-block" id="add" style="display:block"><i class="fa fa-angle-right"></i></button>
													<button type="button" class="btn default btn-block" id="remove" style="display:block"><i class="fa fa-angle-left"></i></button>
  													<button type="button" class="btn green btn-block" id="addAll" style="display:block"><i class="fa fa-angle-double-right"></i></button>
  													<button type="button" class="btn green btn-block" id="removeAll" style="display:block"><i class="fa fa-angle-double-left"></i></button>
												</div>	
												<div class="col-md-4 col-lg-2">
												<select  class="form-control sms_select" multiple="multiple" id="selectedObj" name="selectedObj">
													<c:forEach items="${meets}" var="meet">
														<option value="T${meet.attendeeId}">${meet.attendee}</option>
													</c:forEach>
																	
												</select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                   	<button  class="btn green" onclick="editMeet();" >保存</button>
													<button type="button" class="btn" id="cancel">返回</button>
													<input type="hidden" value="${user.userId}"    id="userId"/>
													<input type="hidden" value="${meeting.person}" id="person"/>
													<input type="hidden" value="${meeting.place}"  id="place"/>
													<input type="hidden" value="${meeting.inoutType}"  id="inoutType"/>
													<input type="hidden" type="text" value="${meetingId}" name="meetingId" id="meetingId"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                </div>
                        </div>
                    </div>
                    </div>
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
	<script type="text/javascript">

		$(function()
		 {    
			loadSubMenu("meetingManager"); 
			//选取当前菜单位置
			setActive("meetingManager","meetPlan"); 
			loadMeetingPlaceList();
			
			$('#startTime,#endTime').datetimepicker( {
				format:'Y-m-d H:i:00',
				timepicker:true
			} );
			
			//全局数组存放已选中元素
			var selectValArr = new Array();
			//加载部门
			var userId = $("#use").val();
			loadDepartmentList(userId);
			
			
			$("#meetingPlaceSelect").blur(function(){
				var meetingPlaceSelect = $("#meetingPlaceSelect").val();
				//选择会议地点
				if (0 == meetingPlaceSelect)
				{
					layer.tips('请选择会议地点', '#meetingPlaceSelect');
				}
				
			});
			
			
			//初始化选择部门，如果select改动则将发送对象改为某个部门的所有教师的信息
			$("#departmentList").click(function(){
				//部门ID
				var departmentId = $(this).val().replace("D", "");
				//departmentId为0表示选择所有部门，不为0表示选择某个部门
				if (departmentId != -1)
				{
					$.ajax({
						type: "POST",
						url: "<%=basePath%>sms/loadTeacherListByDepartmentId.do",
					 	processData:true,
					 	data:{
						 		departmentId : departmentId
						 	 },
					 	success: function(data){
					 		var teacherList = eval("(" + data + ")");
	
							var appendHtml = '';

							$.each(teacherList, function(n, value) {
								//新增，如果已选框有的话则不显示
								var val = "T" + value.userId;
								//表明未选
								if (checkArray(selectValArr, val) == -1)
								{
									appendHtml += '<option value="T' + value.userId + '">(教师)' + value.realName + '</option>';

								}
		           			}); 
	
		           			$("#toSelectObj").html(appendHtml);
		           			$("#toSelectObj1").html(appendHtml);
		           			
					 	}
					});
				}
				else
				{

					var appendHtml = $("#departmentList").html();

					$("#toSelectObj").html(appendHtml);
					$("#toSelectObj option[value='D-1']").remove();
					$("#toSelectObj1").html(appendHtml);
					$("#toSelectObj1 option[value='D-1']").remove();	
				}
			});
			

			//将option从待发送对象移到发送对象的div中
			$("#toSelectObj").dblclick(function(){
            	var $options = $('#toSelectObj option:selected');//获取当前选中的项  
            	var $remove = $options.remove();//删除下拉列表中选中的项  
            	$remove.appendTo('#selectedObj');//追加给对方
            	
        		var i=0;
        		var length = $("#selectedObj option").length;
        		
        		while(i<length){
        			var j=i+1;
        			while(j<$("#selectedObj option").length){

        				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
            				$("#selectedObj option")[j].remove();
            				j++;   
        				}else{  
            				j++;   
        				}   
        			}  
        			i++;   
        		} 		
			});

			//将option从发送对象移到待发送对象的div中
			$("#selectedObj").dblclick(function(){
            	var $removeOptions = $('#selectedObj option:selected');  
            	$removeOptions.appendTo('#toSelectObj');//删除和追加可以用appendTo()直接
            	
        		var i=0;
        		var length = $("#toSelectObj option").length;
        		
        		while(i<length){
        			var j=i+1;
        			while(j<$("#toSelectObj option").length){

        				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
            				$("#toSelectObj option")[j].remove();    
            				j++;   
        				}else{  
            				j++;   
        				}   
        			}  
        			i++;   
        		}             	
			});
			
			
			
			$('#add').click(function(){

            	var $options = $('#toSelectObj option:selected');//获取当前选中的项  
            	var $remove = $options.remove();//删除下拉列表中选中的项  
            	$remove.appendTo('#selectedObj');//追加给对方
            	
        		var i=0;
        		var length = $("#selectedObj option").length;
        		
        		while(i<length){
        			var j=i+1;
        			while(j<$("#selectedObj option").length){

        				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
            				$("#selectedObj option")[j].remove();   
            				j++;   
        				}else{  
            				j++;   
        				}   
        			}  
        			i++;   
        		} 				
				

        	});  
          
        	$('#remove').click(function(){  

            	var $removeOptions = $('#selectedObj option:selected');  
            	$removeOptions.appendTo('#toSelectObj');//删除和追加可以用appendTo()直接
            	
        		var i=0;
        		var length = $("#toSelectObj option").length;
        		
        		while(i<length){
        			var j=i+1;
        			while(j<$("#toSelectObj option").length){

        				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
            				$("#toSelectObj option")[j].remove();    
            				j++;   
        				}else{  
            				j++;   
        				}   
        			}  
        			i++;   
        		} 
        	}); 
          
        	$('#addAll').click(function(){  
            	var $options = $('#toSelectObj option');  
            	$options.appendTo('#selectedObj');  
            	$("#selectedObj option").attr("selected",true);
        		var i=0;
        		var length = $("#selectedObj option").length;
        		
        		while(i<length){
        			var j=i+1;
        			while(j<$("#selectedObj option").length){
        				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
            				$("#selectedObj option")[j].remove(); 
            				j++;   
        				}else{  
            				j++;   
        				}   
        			}  
        			i++;   
        		}	
            	
        	});
			
			$('#removeAll').click(function(){  
            	var $options = $('#selectedObj option');  
            	$options.appendTo('#toSelectObj'); 
            	
        		var i=0;
        		var length = $("#toSelectObj option").length;
        		
        		while(i<length){
        			var j=i+1;
        			while(j<$("#toSelectObj option").length){

        				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
            				$("#toSelectObj option")[j].remove();    
            				j++;   
        				}else{  
            				j++;   
        				}   
        			}  
        			i++;   
        		}          	 
        	});
			
			//表单提交
// 			$("#editMeet").click(function()
// 					{
					
// 						alert($("#name").val());
						
					   
			
			
		});

		
		function editMeet(){
			
			var name = $("#name").val();
			
			
			var id = $("#meetingId").val();
			/**
			 * 会议地点
			 */
			var place = $("#meetingPlaceSelect").val();

			/**
			 * 开始时间
			 */
			var startTime = $("#startTime").val();

			/**
			 * 结束时间
			 */
			var endTime = $("#endTime").val();
			
			var type = $("#meetingTypeSelect").val()
			
			var content = $("#content").val();
			
			var remark = $("#remark").val();
		
			 if($("#selectedObj option").val()==null)
				{
					layer.tips('请至少选择一个发送对象！', '#selectedObj');
					return false;
				}
				
			    if(checkForm())
				{
			    	var selectedValues = [];    
					$("#selectedObj option").each(function(){
						selectedValues += $(this).val()+"," ; 
// 					    alert($(this).val());
					});
// 					$("#selectedObj").val(selectedValues);
					$.ajax({
						type: "post",
						url: "<%=basePath%>meeting/doEditMeeting.do",
						data:{
							meetingId  : id,
							name : name,
							place : place,
							startTime : startTime,
							endTime : endTime,
							inoutType : type,
							selectedObj : selectedValues,
							content : content,
							remark : remark
							
						},
						success: function(data){
							
							var f= eval("(" + data + ")");
							if(f == 0){
								standardPost('<%=basePath%>meeting/toMeetingList.do',{});
							}else{
								layer.msg("修改失败，请联系管理员！");
							
							}
						},
					});
				}	
			
		}
		
		  //加载会议地点
		function loadMeetingPlaceList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>meeting/getMeetingPlaceListByPositionType.do",
				success: function(data){
					var placeList = eval("(" + data + ")");

					//年级select页面html
					var placeSelectHtml = '<option value="0">--请选择--</option>';

					$.each(placeList, function(n, value) {  
						//select页面
						placeSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';

	          		});

          			$("#meetingPlaceSelect").html(placeSelectHtml);
          			$("#meetingPlaceSelect").val($("#place").val());
          			$("#meetingTypeSelect").val($("#inoutType").val());
          			
				},
			});
		} 
		//加载部门列表
		function loadDepartmentList(userId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>sms/getTeacherList.do",
				data:{
						userId : userId,
						permissionCode : "teacherMessageManager"
					},
				success: function(data){
					var departmentList = eval("(" + data + ")");
					
					var appendHtml = '<option value="D-1">--选择所有部门--</option>';
					
					$.each(departmentList, function(n, value) {
           				appendHtml += '<option value="D' + value.id + '">' + value.departmentName + '</option>';
           			}); 

           			$("#departmentList").html(appendHtml);

           			//初始化带选框
           			var appendHtml = $("#departmentList").html();
					$("#toSelectObj").html(appendHtml);
					$("#toSelectObj option[value='D-1']").remove();
					$("#toSelectObj1").html(appendHtml);
					$("#toSelectObj1 option[value='D-1']").remove();
				},
			});
		}
		
		//检查元素是否存在数组中
		//arr: 元素, e:数组
		function checkArray(arr, e)
		{
			for(var i = 0,j; j = arr[i]; i++)
			{
				if(j == e)
				{
					return i;
				}
			}
			return -1;	
		}
		
		
		
		function current()
		{ 
			var d=new Date();
			str=''; 
			str +=d.getFullYear()+'-'; //获取当前年份 
			str +=d.getMonth()+1+'-'; //获取当前月份（0——11） 
			str +=d.getDate()+' '; 
			str +=d.getHours()+':'; 
			str +=d.getMinutes()+':'; 
			str +=d.getSeconds(); 
			return str; 
		} 

		function checkForm()
		{
			var nameFlag = false;
			var startTimeFlag = false;
			var endTimeFlag = false;
			var selectedObjFlag = false;
			var placeFlag = false;
			//会议名称
			var name = $("#name").val();
			//未输入会议名称
			if ("" == name)
			{
				layer.tips('会议名称不能为空', '#name');
				nameFlag = false;
			}
			else
			{
				nameFlag = true;
			}

			//会议地点
			var place = $("#meetingPlaceSelect").val();
			//未选择会议地点
			if (0 == place)
			{
				layer.tips('请选择会议地点', '#meetingPlaceSelect');
				placeFlag = false;
			}
			else
			{
				placeFlag = true;
			}
			
            //开始时间
			var startTime = $("#startTime").val();
			var start=new Date(startTime.replace("-", "/").replace("-", "/")); 
			//当前时间 
		    var nowTime = current();
		    var now=new Date(nowTime.replace("-", "/").replace("-", "/")); 
			//未输入开始时间
			if ("" == startTime)
			{
				layer.tips('开始时间不能为空', '#startTime');
				startTimeFlag = false;
			}else if(start < now)
			{
				layer.tips('开始时间不能小于当前时间', '#startTime');
				startTimeFlag = false;
			}
			else
			{
				startTimeFlag = true;
			}

            //结束时间
			var endTime = $("#endTime").val();
			//未输入结束时间
			if ("" == endTime)
			{
				layer.tips('结束时间不能为空', '#endTime');
				endTimeFlag = false;
			}
			else if(startTime > endTime)
			{
				layer.tips('开始时间不能晚于结束时间', '#startTime');
				endTimeFlag = false;
			}	
			
			else
			{
				endTimeFlag = true;
			}
			

			
			if (nameFlag && placeFlag && startTimeFlag && endTimeFlag)
			{
				return true;
			}	
			else
			{
				return false;
			}
		}
	</script>
</html>