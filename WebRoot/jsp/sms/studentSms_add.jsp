<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>学生短信服务</title>
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
            <div class="page-content-wrapper">
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">信息平台</a><i class="fa fa-circle"></i></li>
                            <li><span>学生短信服务</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                        	<div class="m_margin_0_0_15_0">
                        		<ul class="nav nav-tabs">
                                    <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<c:if test="${roleList.roleCode eq 'classLeader' || roleList.roleCode eq 'chairman' || roleList.roleCode eq 'president'}">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
									</c:if>
								</c:forEach>
                                </ul>
                            </div>
                            
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">学生短信服务</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>sms/doAddSmsForStudent.do" class="form-horizontal" id="addSmsForm">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择班级：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" tabindex="1" name="clazzList" id="clazzList">
														</select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">筛选条件：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text"  name="code" class="form-control" value="" id="search" onkeyup="filter(this.value)" onchange="filter(this.value)" onpropertychange="filter(this.value)" oninput="filter(this.value)"/>

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">发送对象：</label>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj"></select>
                                                </div>
                                                <div class="col-md-1 col-lg-1">
                                                	<button type="button" class="btn default btn-block" id="add" style="display:block"><i class="fa fa-angle-right"></i></button>
													<button type="button" class="btn default btn-block" id="remove" style="display:block"><i class="fa fa-angle-left"></i></button>
  													<button type="button" class="btn green btn-block" id="addAll" style="display:block"><i class="fa fa-angle-double-right"></i></button>
  													<button type="button" class="btn green btn-block" id="removeAll" style="display:block"><i class="fa fa-angle-double-left"></i></button>
  												</div>
												<div class="col-md-4 col-lg-2">
													<select class="form-control sms_select" multiple="multiple" id="selectedObj" name="selectedObj" ></select>
													<select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj1" style="display : none"></select>
                                            	</div>
                                            </div>
                                            <h3 class="form-section">发送内容</h3>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">内容：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <textarea class="form-control" rows="10" name="content" id="content"></textarea>
														<span class="help-inline">(剩余<b id="word">${smsWordLimit }</b>个字, 共 <b id="page">0</b>条短信, 限<b>${smsWordLimit }</b>字)</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<c:if test="${sessionScope.user.type != 2}">
													<c:if test="${schoolTrySms == 'have'}">
															<button type="button" class="btn green" id="addSms"><span id="send">立即发送</span></button>
															<button type="button" class="btn" id="addSmsBypresendTime"><span id="presend">定时发送</span></button>
															<input type="text" size="16" class="form-control input-inline input-medium m_display_inline" placeholder="设置发送时间" value="" name="startTime"  id="startTime"/>
															<span class="add-on"><i class="icon-calendar"></i></span>
													</c:if>
													<c:if test="${schoolTrySms == 'nothave'}">
													</c:if>
												</c:if>
												<input type="hidden" value="" name="userId" id="userId" />
												<!-- 用户识别短信发送类型 -->
												<input type="hidden" value="1" name="mode" id="mode"/>
												<input type="hidden" value="${schoolTrySms}" name="schoolTrySms" id="schoolTrySms"/>
												<input type="hidden" value="${smsWordLimit}" name="smsWordLimit" id="smsWordLimit"/>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
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
         <script src="<%=basePath%>assets/global/plugins/map.js" type="text/javascript" ></script>
        <!-- 公共js结束 -->
	<script>
	    var clazzUserMap=new Map();
		var smsWordLimit = $("#smsWordLimit").val();
		jQuery(document).ready(function() { 
			loadSubMenu("informationPlatform"); 
			//选取当前菜单位置
			setActive("informationPlatform","studentSms");  
			$('#startTime').datetimepicker({
				 format:"Y-m-d H:i:s" 
			});   
			// 判断已经输入多少字 
			$("#content").keyup(check);
			
			//全局数组存放已选中元素
			var selectValArr = new Array();
			//页面初始化时候的数据加载
			var userId = $("#userTab li.active").find('a').attr("attr1");
			var roleCode = $("#userTab li.active").find('a').attr("attr2");
			$("#userId").val(userId);
			$("#roleCode").val(roleCode);
			//加载初始化数据
			loadclazzList(userId, "studentMessageManager");
			//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
			$("#clazzList").change(function(){
				//班级ID
				var clazzId = $(this).val().replace("C", "");
				
				//clazzId为0表示选择所有班级，不为0表示选择某个班级
				if (clazzId != 0)
				{
					 		var studentList =clazzUserMap.get(clazzId);//从数组中取
							var appendHtml = '';
							if(typeof(studentList)!="undefined" && studentList.length>0){
							$.each(studentList, function(n, value) {
								//新增，如果已选框有的话则不显示
								var val = "S" + value.userId;
								//表明未选
								if (checkArray(selectValArr, val) == -1)
								{
								appendHtml += '<option value="S' + value.userId + '">(学生)' + value.realName + '</option>';
								}
		           			}); 
							}
		           			$("#toSelectObj").html(appendHtml);
		           			$("#toSelectObj1").html(appendHtml);
				}
				else
				{
					var appendHtml = $("#clazzList").html();

					$("#toSelectObj").html(appendHtml);
					$("#toSelectObj option[value='0']").remove();
					$("#toSelectObj1").html(appendHtml);
					$("#toSelectObj1 option[value='0']").remove();
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

			//提交表单 立即发送短信
			$("#addSms").click(function(){
				if($("#selectedObj option").val()==null)
				{
					layer.msg("请至少选择一个发送对象！");
					return false;
				}
				//获取textarea中的值
				var str = $("#content").val();
				if(str.trim()=='')
				{
					layer.msg("短信内容不能为空！");
					return false;
				}
				
            	var len = strlen(str);
				if(len > smsWordLimit){
					layer.msg("对不起，你已经超过短信规定长度！");
					return false;
				}
				var selectedValues = [];    
				$("#selectedObj option").each(function(){
				    selectedValues.push($(this).val()); 
				});
				$("#selectedObj").val(selectedValues);
				var indexlayer = layer.msg('正在发送,请稍候。。。',{icon: 16,time:0,shade:0.3});
				$("#addSmsForm").submit();
				
			});
			//定时提交表单 定时发送短信
			$("#addSmsBypresendTime").click(function(){
			
				if($("#selectedObj option").val()==null)
				{
					layer.msg("请至少选择一个发送对象！");
					return false;
				}
				//获取textarea中的值
				var str = $("#content").val();
				if(str.trim()=='')
				{
					layer.msg("短信内容不能为空！");
					return false;
				}
				
            	var len = strlen(str);
				if(len > smsWordLimit){
					layer.msg("对不起，你已经超过短信规定长度！");
					return false;
				}

				var presendTime=$("#startTime").val();
				if(confirm('您设置的定时发送时间为:'+ presendTime)) {
					var selectedValues = [];    
					$("#selectedObj option").each(function(){
					    selectedValues.push($(this).val()); 
					});
					$("#selectedObj").val(selectedValues);
					var indexlayer = layer.msg('正在发送,请稍候。。。',{icon: 16,time:0,shade:0.3});
					//$("#presend").html("正在发送...");
					//$("#addSms").attr("disabled", "disabled");
	  				//$("#addSmsBypresendTime").attr("disabled", "disabled");
					$("#addSmsForm").submit();
				} else {
					layer.msg('取消')
					return false;
				}
				
			});			
			
		});
		 //邮件字数限制
		$("#content").keydown(function(){
		   var editSms_v=trim($(this).val());
		   var len = editSms_v.length;
		   if(len > smsWordLimit)
		   {
		    	$(this).val($(this).val().substring(0,smsWordLimit));
		   }
		   if(smsWordLimit - len>0)
		   {
		       var num = smsWordLimit - len;
		   }else{
			   num=0;
		   }
		   var page=Math.ceil(len/65);
		   $("#word").text(num);
		   $("#page").text(page);
		 }); 
    	
		function filter(v){
            var $SerTxt = v.trim();
            //全局数据用于存放toSelectObj中的text
			var arryText = new Array();
            //全局数据用于存放toSelectObj中的val
			var arryVal = new Array();
     		$("#toSelectObj1").find("option").each(function(i, n) {
        		arryText[i] = $(this).text();
        		arryVal[i] = $(this).val();
    		});
    		
            if ($SerTxt != "" && $SerTxt != null) {
            	var appendHtml = '';
                for (var i = 0; i < arryText.length; i++) {
                    if (arryText[i].toLowerCase().indexOf($SerTxt) >= 0) {
                    	//添加到toSelectObject 中
                    	appendHtml += '<option value="' + arryVal[i] + '">' + arryText[i] + '</option>';
                    }
                }
                $("#toSelectObj").html(appendHtml);
            }else{
            	var appendHtml = '';
            	for (var i = 0; i < arryText.length; i++) {
            		appendHtml += '<option value="' + arryVal[i] + '">' + arryText[i] + '</option>';
                }
                $("#toSelectObj").html(appendHtml);
            }
		}
		
		// 加载班级列表
		function loadclazzList(userId, permissionCode)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>sms/getAllStudentList.do",
				dataType:"json",
				data:{
						userId : userId,
						permissionCode : "studentMessageManager"
					},
				success: function(data){
					var clazzList =data.clazzList;
					var appendHtml = '<option value="0">--选择所有班级--</option>';
					$.each(clazzList, function(n, value) {
           				appendHtml += '<option value="C' + value.id + '">' + value.clazzName + '</option>';
           			}); 
           			$("#clazzList").html(appendHtml);
           			//初始化带选框
           			var appendHtml = $("#clazzList").html();
					$("#toSelectObj").html(appendHtml);
					$("#toSelectObj option[value='0']").remove();
					$("#toSelectObj1").html(appendHtml);
					$("#toSelectObj1 option[value='0']").remove();
					clazzUser(clazzList,data.studentList);
				},
			});
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
		//用于检查文本域中已经输入字数
        function check() {
            var str = $("#content").val();
            var len = strlen(str);
            var info = len;
            info = info + "";
            if (info.indexOf('.') > 0){
                info = info.substring(0, info.indexOf('.'));
			}
			$("#info").html(info);
			//65个字作为一条短信
			if(len <= 65){
				if(len == 0){
					$("#info1").html("");
				}else{
					$("#info1").html("1");
				}	
			}else if(len > 65 && len <= smsWordLimit){
				if(len%65 == 0){
					$("#info1").html(len/65);
				}else{
					$("#info1").html(parseInt(len/65)+1);
				}
			}else if(len > smsWordLimit){
				layer.msg("对不起，你已经超过短信规定长度！");
				return false;
			}
        }

        function strlen(str) {
            var str = trim(str);
            var len = 0;
            for (var i = 0; i < str.length; i++) {
                len += str.charCodeAt(i) > 0 && str.charCodeAt(i) < 255 ? 0.5 : 1;
            }
            return len;
        }
        function trim(str) {
            return (str + '').replace(/(\s+)$/g, '').replace(/^\s+/g, '');
        }	
        	
	</script>
</html>