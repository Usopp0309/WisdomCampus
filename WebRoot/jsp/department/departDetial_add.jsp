<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>添加部门人员</title>
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
                            <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
                            <li><span>添加部门人员</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">添加部门人员</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">添加部门人员</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>depart/doAddTeacherList.do" class="form-horizontal" method="post" id="addTeacherForm">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择部门</label>
                                                <div class="col-md-4">
                                                    <select tabindex="1"  name="departmentList" id="departmentList" data-placeholder="Choose a Category" class="form-control"></select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">筛选人员</label>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control" id="search" name="code" onkeyup="filter(this.value)" onchange="filter(this.value)" onpropertychange="filter(this.value)" oninput="filter(this.value)">
                                                </div>
                                            </div>
                                            <div class="form-group" id="search_Result_box">
                                                <label class="control-label col-md-3" for="inputSuccess"></label>
                                                <div class="col-md-8">
                                                	<ul id="search_Result" style="display:block">
														
													</ul>
													<ul id="search_Result_hide" class="control-group" style="display: none">

													</ul>
													<select class="m-wrap medium " multiple="multiple" tabindex="1" id="toSelectObj1" style="float: left;display : none">
			
													</select>    
												</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">已选人员</label>
                                                <div class="col-md-8">
                                                    <ul class="teacherSms_list"></ul>
												</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button id="addTeacher" class="btn green" type="button">确定</button>
                                                    <button id="addTeacher" class="btn" type="button" onclick="history.go(-1)">返回</button>
													<input type="hidden" value="${departmentId}" name="departmentId" id="departmentId"/>
													<input type="hidden" value="${user.userId}" name="userId" id="userId"/>
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
        <!-- 公共js结束 -->
	<script type="text/javascript">

		$(function() {    
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","departManage"); 
			//全局数组存放已选中元素
			var selectValArr = new Array();
			
			var userId = $("#userId").val();
			var departmentId = $("#departmentId").val();

			//加载年级初始化数据
			loadDepartmentList(userId, null)
			

			//列表选择
			$("#search_Result").on("click","li",function(){
				
				var _this=$(this);
				var _id=_this.attr("id");
				var _teacherSms=$(".teacherSms_list");
				var _parent=$("#Department_list #"+_id+"");
				if(_this.hasClass("select")){
					_parent.removeAttr("class");
					_this.removeAttr("class");
					_teacherSms.find("#"+_id+"").remove();

					
					$("#selectedObj option[value='"+_id+"']").remove(); 
				}else{
					$(".teacherSms_list li[id="+_id+"]").remove();
					_parent.addClass("select");
					_this.addClass("select");
					_this.clone().appendTo(_teacherSms);

				}
			});
			
			//搜索框
			$("#search").on("focus",function(){
				$("#search_Result_box").show();
			})
			
			 //已选列表选择
			$(".teacherSms_list").on("click","li",function(){
				var _this=$(this);
				var _id=_this.attr("id");
				var _sResult=$("#search_Result #"+_id+"");
				_sResult.removeClass("select");
				_this.remove();

				$("#selectedObj option[value='"+_id+"']").remove();
			});
			
		
			//初始化选择部门，如果select改动则将发送对象改为某个部门的所有教师的信息
			$("#departmentList").change(function(){

				//部门ID
				var departmentId = $(this).val().replace("D", "");
				//departmentId为0表示选择所有部门，不为0表示选择某个部门
				if (departmentId != -1)
				{
					$.ajax({
						type: "POST",
					 	url: "<%=basePath%>baseData/getTeacherListByDepartmentId.do",
					 	processData:true,
					 	data:{
						 		departmentId : departmentId
						 	 },
					 	success: function(data){
					 		var teacherList = eval("(" + data + ")");
	
							var appendHtml = '';

							$.each(teacherList, function(n, value) {
								//新增，如果已选框有的话则不显示
								var val = "T" + value.id;
								//表明未选
								if (checkArray(selectValArr, val) == -1)
								{
									appendHtml += '<li id="T' + value.userId + '">(教师)' + value.realName + '</li>';
								}
		           			}); 
							  $("#search_Result").html(appendHtml)
		           			  $("#search_Result_hide").html(appendHtml);
					 	}
					});
				}
				else
				{
					$.ajax({
						type: "post",
						url: "<%=basePath%>sms/getTeacherList.do",
						data:{
								userId : userId,
								permissionCode : "departAddMember"
						},
						success: function(data){
							var departmentList = eval("(" + data + ")");
							
							var appendHtml_li='';
							var appendHtml='';
							var appendHtml_search='<ul>';
		           			$.each(departmentList, function(n, value) {
		           			    //select页面
								appendHtml_li += '<li id="D' + value.id + '">' + value.departmentName + '</li>';
								appendHtml += '<div class="accordion-body collapse" id="'+value.code+'">';
								appendHtml += '<ul class="accordion_list">';
									$.each(value.teacherList, function(k, value1) {
										appendHtml += '<li id="T'+value1.userId+'">'+value1.realName+'</li>';
										appendHtml_search +='<li id="T'+value1.userId+'">'+value1.realName+'</li>';
									});
								
								appendHtml += '</ul>';
								appendHtml += '</div>';
		           			}); 
		           			//初始化待选框
							$("#search_Result").html(appendHtml_li);
							$("#search_Result_hide").html(appendHtml_search);
						},
					});
					
				}
			});
			
			//提交表单 保存
			$("#addTeacher").click(function(){

			
				var _this=$(".teacherSms_list li");
				var _select_num=new Array();
			   	    _select_num=_this;
			    var add_num=_this.size();
			    
				var ids = null;
				
				if(add_num>0)
				{
				    for(var i=0;i<_select_num.length;i++)
					{
					    if(i==0)
						{
							ids =  _select_num[i].id;
						}else{
							ids += ","+_select_num[i].id;
						}
							   
					}
				 }else{
					 alert("请至少选择一个发送对象！");
					 return false;
				 }
				 
				 var departmentId = $("#departmentId").val();
				   
				 $.ajax({
						type: "POST",
						url: "<%=basePath%>depart/doAddTeacherList.do",
					 	processData:true,
					 	data:{
					 		departmentId : departmentId,
					 		ids : ids
						},
					 	success: function(data){
					 		standardPost('<%=basePath%>depart/depart_detialSelect.do',{id:departmentId});
					 	}
					});
				
			});
		
		});
		
		function filter(v){
           
            //全局数据用于存放toSelectObj中的text
			var arryText = new Array();
            //全局数据用于存放toSelectObj中的val
			var arryVal = new Array();
     		
     		$("#search_Result_hide").find("li").each(function(i, n) {
    			arryText[i] = $(this).text();
    			arryVal[i] = $(this).attr("id");
			});
     		var $SerTxt = v.trim();
    		
            if ($SerTxt != "" && $SerTxt != null) {
            	var appendHtml = '';
                for (var i = 0; i < arryText.length; i++) {
                    if (arryText[i].toLowerCase().indexOf($SerTxt) >= 0) {
                    	//添加到toSelectObject 中
                    	appendHtml +='<li id="'+arryVal[i]+'">'+arryText[i]+'</li>';
                    }
                }
                appendHtml += '</ul>';
                $("#search_Result").html(appendHtml);
            }else{
            	var appendHtml = '';
            	for (var i = 0; i < arryText.length; i++) {
            		appendHtml += '<li id="' + arryVal[i] + '">' + arryText[i] + '</li>';
                }
                $("#search_Result").html(appendHtml);
            }
		}
		
		//加载部门列表
		function loadDepartmentList(userId, roleCode)
		{

			$.ajax({
				type: "post",
				url: "<%=basePath%>sms/getTeacherList.do",
				data:{
						userId : userId,
						permissionCode : "departAddMember"
					},
				success: function(data){
					var departmentList = eval("(" + data + ")");
					
					var appendHtml = '<option value="D-1">--选择所有部门--</option>';
					var appendHtml_li='';
					var appendHtml_search ='<ul>';
					$.each(departmentList, function(n, value) {
           			    //select页面
						appendHtml += '<option value="D' + value.id + '">' + value.departmentName + '</option>';
           			}); 
           			$("#departmentList").html(appendHtml);
           			
           			$.each(departmentList, function(n, value) {
           			    //select页面
						appendHtml_li += '<li id="D' + value.id + '">' + value.departmentName + '</li>';

						appendHtml += '<div class="accordion-body collapse" id="'+value.code+'">';
						appendHtml += '<ul class="accordion_list">';
							$.each(value.teacherList, function(k, value1) {
								appendHtml += '<li id="T'+value1.userId+'">'+value1.realName+'</li>';
								appendHtml_search +='<li id="T'+value1.userId+'">'+value1.realName+'</li>';
							});
						
						appendHtml += '</ul>';
						appendHtml += '</div>';
						
           			}); 

           			//初始化待选框
           			var appendHtml = $("#departmentList").html();
					$("#search_Result").html(appendHtml_li);
					$("#search_Result_hide").html(appendHtml_search);
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

		
	</script>
</html>