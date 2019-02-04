<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>修改地点</title>
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
                            <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
                            <li><span>修改地点</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">修改地点</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>place/doModifyPlace.do" id="submitForm" class="form-horizontal" method="post" >
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">地点名：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="name"  id="name" value="${place.name}" class="form-control"/>
													<span class="help-inline" style="display: none;" id="nameSpan"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">地点对应的wifi名：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="wifi"  id="wifi" value="${place.wifi}" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">地点类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="type" name="type">
														<option value="0">--请选择--</option>
														<option value="1">校门</option>
														<option value="2">宿舍</option>
														<option value="3">会议</option>
														<option value="4">校车</option>
													</select>
													<input type="hidden" id="placeType" value="${place.type}">
													<span class="help-inline" style="display: none;color: red;" id="typeSpan"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<button type="button" id="submitButton" class="btn design_btn" id="submitButton">保存</button>
													<button type="button" class="btn back_btn" id="cancel">返回</button>
													<input type="hidden" id="functionId" value="${place.functionId}">
													<input type="hidden" id="funType" value="${place.functionType}">
													<input type="hidden" name="placeId" id="placeId" value="${place.id}">
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

	<script>

		$(function() {  
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","placeManage"); 
			var type = $("#placeType").val();
			$("#type").val(type);
            //名称验证
            $("#name").blur(function(){
                var name = $("#name").val();
                if("" == name)
                {
		            layer.tips("名称不能为空", '#name');
                }
            });
            
            $("#classFun").click(function(){
            	$("#clazzIdList").show();
        		$("#departmentIdList").hide();
        		loadAllClazzList();
			});

            $("#departFun").click(function(){
            	$("#clazzIdList").hide();
        		$("#departmentIdList").show();
        		loadDepartmentList();
			});
			//表单提交
			$("#submitButton").click(function()
			{
			    if(checkForm())
				{
				    $("#submitForm").submit();
				    $("#submitButton").attr("disabled","disabled");
				}
			
			});	
			
			
		});


		//加载班级信息
		function loadAllClazzList()
		{
			$.ajax({
				type: "post",
				 async: false,
				url: "<%=basePath%>place/loadClazzList.do",
				data:{
				},
				success: function(data)
				{
					var clazzList = $.parseJSON(data);
					//年级select页面html
					var clazzSelectHtml = '<option value="0">--请选择--</option>';
					
					$.each(clazzList, function(n, value)
					 {  
						clazzSelectHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
          			 });
					$("#clazzList").html(clazzSelectHtml);
				},
			});
		}

		//加载班级信息
		function loadDepartmentList()
		{
			$.ajax({
				type: "post",
				 async: false,
				url: "<%=basePath%>depart/getDepartmentList.do",
				data:{
					
				},
				success: function(data){
					var departmentList = eval("(" + data + ")");
				
					//年级select页面html
					var departmentSelectHtml = '<option value="0">--请选择--</option>';

					$.each(departmentList, function(n, value) {  
						//select页面
						departmentSelectHtml += '<option value="' + value.id + '">' + value.departmentName + '</option>';
                         
	          		});

          			$("#departmentList").html(departmentSelectHtml);
          			
				},
			});
		}
		
		
		//表单校验相关---begin
		
		function checkForm()
		{
			 //验证常量 
            var flagName = false;
            
            var flagType = false;
		
			//地点名称
			var name = $("#name").val();
			
			//类型
			var type = $("#type").val();
			
			//未输入名称
			if ("" == name)
			{
	             layer.tips('名称不能为空', '#name');
				 flagName = false;
			}
			else
			{
				flagName = true;
			}
			
			if(0 == type)
            {
		        layer.tips('请选择类型', '#type');
                flagType = false;
            }
            else
            {
               flagType = true;
            } 

            var flag = true;

			if(5 == type)
            {
				if ($("#classFun").attr("checked"))
				{
            		var clazzId = $("#clazzList").val();
            		if (clazzId == 0)
        			{
        	             layer.tips('班级不能为空', '#clazzList');
        				 flag = false;
        			}
        			else
        			{
        				flag = true;
        			}
				}

				
            	if ($("#departFun").attr("checked"))
   				{
            		var departmentId = $("#departmentList").val();
            		if (departmentId == 0)
        			{
        	             layer.tips('班级不能为空', '#departmentList');
        				 flag = false;
        			}
        			else
        			{
        				flag = true;
        			}
   				}
            }
			
			if (flagName && flagType && flag)
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