<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>学生在线留言</title>
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
                            <li><a href="<%=basePath %>announcement/toAnnouncementList.do">信息中心</a><i class="fa fa-circle"></i></li>
                            <li><span>学生在线留言</span></li>
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
                                        <span class="caption-subject font-green sbold uppercase">学生在线留言</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>online-message/doAddSmsForStudent.do" class="form-horizontal" method="post" id="addSmsForm">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择班级：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" tabindex="1" name="clazzList" id="clazzList"> </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">输入筛选条件：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="code" class="form-control" value="" id="search" onkeyup="filter(this.value)" onchange="filter(this.value)" onpropertychange="filter(this.value)" oninput="filter(this.value)"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">发送对象：</label>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select " multiple="multiple" tabindex="1" id="toSelectObj">
													</select>
                                                </div>
                                                <div class="col-md-1 col-lg-1">
                                                    <button type="button" class="btn default btn-block" id="add" style="display:block"><i class="fa fa-angle-right"></i></button>
													<button type="button" class="btn default btn-block" id="remove" style="display:block"><i class="fa fa-angle-left"></i></button>
  													<button type="button" class="btn green btn-block" id="addAll" style="display:block"><i class="fa fa-angle-double-right"></i></button>
  													<button type="button" class="btn green btn-block" id="removeAll" style="display:block"><i class="fa fa-angle-double-left"></i></button>
                                                </div>
                                                <div class="col-md-4 col-lg-2">
                                                    <select class="form-control sms_select " multiple="multiple" id="selectedObj" name="selectedObj" >
													</select>
													<select class="form-control sms_select " multiple="multiple" tabindex="1" id="toSelectObj1" style="display:none">
													</select>
                                                </div>
                                            </div>
                                            
                                            <h3 class="form-section">发送内容</h3>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">内容:</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <textarea class="form-control" rows="10" name="content" id="content"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<c:if test="${sessionScope.user.type != 2}">
														<button type="button" class="btn green" id="addSms">发送</button>
														<button type="button" class="btn" onclick="history.go(-1);">返回</button>
													</c:if>
													<input type="hidden" value="" name="userId" id="userId" />
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
		$(function() { 
			loadSubMenu("informationPlatform");  
			//选取当前菜单位置
			setActive("informationPlatform","onlineStudentMessage");  
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

			//提交表单
			$("#addSms").click(function(){
			
				if($("#selectedObj option").val()==null)
				{
					alert("请至少选择一个发送对象！");
					return false;
				}
				if($("#content").val().trim()=='')
				{
					alert("留言内容不能为空！");
					return false;
				}

				var selectedValues = [];    
				$("#selectedObj option").each(function(){
				    selectedValues.push($(this).val()); 
				});
				$("#selectedObj").val(selectedValues);
				
				$("#addSms").val("正在发送...");
  				$("#addSms").attr("disabled", "disabled");
				$("#addSmsForm").submit();
				
			});
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
		
		//加载年级列表
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
		
	</script>
</html>
