<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>添加班级</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
	 	<style type="text/css">
 	 		.select2-container{ 
		 		float: left; 
			 	width: 100% !important; 
 		 	} 
	 	</style> 
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
                            <li><span>添加班级</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">添加班级</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="<%=basePath%>clazz/doAddClazz.do" class="form-horizontal" method="post" id="addForm">
                                           <div class="form-group">
                                               <label class="control-label col-md-3">班级编号：</label>
                                               <div class="col-md-9 col-lg-4">
                                                   <input type="text"  name="code" id="code" class="form-control" value="${code}"/>
                                               </div>
                                           </div>
                                          <div class="form-group">
                                              <label class="control-label col-md-3">年级：</label>
                                              <div class="col-md-9 col-lg-4">
                                                  <div class="input-icon right">
                                                      <select class="form-control" name="gradeId"  tabindex="1"  id="gradeSelect">
		                                        </select>
                                               </div>
                                           </div>
                                      	</div>
                                          <div class="form-group">
                                              <label class="control-label col-md-3" for="clazzName">班级名称：</label>
                                              <div class="col-md-9 col-lg-4">
                                                  <input type="text" size="16" name="clazzName"  id="clazzName"  class="form-control"/>
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <label class="control-label col-md-3" for="clazzLeaderSelect">班主任：</label>
                                              <div class="col-md-9 col-lg-4">
                                                  <select class="form-control select2me m_select" name="clazzLeaderSelect"  tabindex="1" id="clazzLeaderSelect" >
                                       		</select>
                                              </div>
                                              <input type="hidden" name="clazzLeaderName" id="clazzLeaderName">
                                          </div>
                                            
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
	                                                <button type="button" class="btn green" id="save">保存</button>
													<button type="button" class="btn" id="cancel">返回</button>
													<input type="hidden" value="${user.id}" name="userId"/>
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
		jQuery(document).ready(function() {
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","clazzManage");      
			//加载班主任信息
			loadClazzLeaderList();
			//加载年级信息
			loadGradeList();
			//班级编号
			$("#code").blur(function(){
				var code = $("#code").val();
				//未输入班级编号
				if ("" == code)
				{
					layer.tips('班级编号不能为空', '#code');
				}
				else if (checkCode(code))
				{
					layer.tips('班级编号已存在', '#code');
				}else if(code.length>20){
					layer.tips('班级编号最多20个字符', '#code');
					return false;
				}
			});
			
			//班级名称
			$("#clazzName").blur(function(){
				var clazzName = $("#clazzName").val();
				var code = $("#code").val();
				//未输入班级名称
				if ("" == clazzName)
				{
					layer.tips('班级名称不能为空', '#clazzName');
				}else if (checkCode(code))
				{
					layer.tips('班级编号已存在', '#code');
					return false;
				}else if(clazzName.length>64){
					layer.tips('班级名称最多64个汉字', '#clazzName');
					return false;
				}
			});
			
			//年级
			$("#gradeSelect").blur(function(){
				var gradeSelect = $("#gradeSelect").val();
				//未输入手机号码
				if ("--请选择--" == gradeSelect)
				{
					layer.tips('请选择年级', '#gradeSelect');
				}
			});
			
			//添加班级表单校验---end
			
			$("#save").click(function(){
				if (checkForm())
				{
					$("#addForm").submit();
				}
			});
			
		});
		//加载班主任信息
		function loadClazzLeaderList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazz/getAllClazzLeader.do",
				success: function(data){
					var clazzLeaderList = eval("(" + data + ")");
					//班主任select页面html
					var clazzLeaderSelectHtml = '<option value="0">--请选择--</option>';
					$.each(clazzLeaderList, function(n, value) {  
						clazzLeaderSelectHtml += '<option value="' + value.userId + '">' + value.realName + '</option>';
	          		});
					var clazzVal= $("#clazzLeaderSelect").val();
					if(clazzVal==null || clazzVal==''){
						clazzVal="--请选择--";
					}
	          		$("#select2-clazzLeaderSelect-container").attr("title",clazzVal);
	          		$("#select2-clazzLeaderSelect-container").text(clazzVal);
          			$("#clazzLeaderSelect").html(clazzLeaderSelectHtml);
          			
          			var leaderId = $("#leaderId").val();

					$("#clazzLeaderSelect").val(leaderId);
					var clazzLeader = $("#clazzLeaderSelect").val();
					if (null == clazzLeader || "" == clazzLeader)
					{
						$("#clazzLeaderSelect").val(0);
					}
					
				},
			});
		}

		//加载年级信息
		function loadGradeList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>baseData/getGradeList.do",
				success: function(data){
					var gradeList = eval("(" + data + ")");

					//年级select页面html
					var gradeSelectHtml = '<option value="0">--请选择--</option>';

					$.each(gradeList, function(n, value) {  
						//select页面
						var type = value.type;
						if(type == 0){
							gradeSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';
						}else if(type == 1){
							gradeSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';
						}else if(type == 2){
							gradeSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';
						}else if(type == 3){
							gradeSelectHtml += '<option value="' + value.id + '">' + value.name + '</option>';
						}
	          		});
          			$("#gradeSelect").html(gradeSelectHtml);
          			
				},
			});
		} 
		
		//表单校验相关---begin
		
		function checkForm()
		{
			//班级编号
			var code = $.trim($("#code").val());

			
			//未输入编号
			if ("" == code)
			{
				layer.tips('班级编号不能为空', '#code');
				return false;
			}
			else if (checkCode(code))
			{
				layer.tips('班级编号已存在', '#code');
				return false;
			}else if(code.length>20){
				layer.tips('班级编号最多20个字符', '#code');
				return false;
			}
			//年级
			var gradeSelect = $("#gradeSelect").val();
			//未输入手机号码
			if (0 == gradeSelect || gradeSelect==null )
			{
				layer.tips('请选择年级', '#gradeSelect');
				return false;
			}
			//班级名称
			var clazzName = $.trim($("#clazzName").val());
			//年级id
			var gradeId = $.trim($("#gradeSelect").val());
			//未输入班级名称
			if ("" == clazzName)
			{
				layer.tips('班级名称不能为空', '#clazzName');
				return false;
			}else if(checkClazzName(clazzName ,gradeId)){
				layer.tips('班级名称已存在', '#clazzName');
				return false;
			}else if(clazzName.length>64){
				layer.tips('班级名称最多64个汉字', '#clazzName');
				return false;
			}
			
			
			return true;
		}
		
		function checkCode(code)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					code : code,
				},
				url: "<%=basePath%>clazz/checkClazzByCode.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此学号存在
					if ("success" == result.resultCode)
					{
						flag = true;
					}
					else
					{
						flag = false;
					}
					
				},
			});
			
			return flag;
		}

		function checkClazzName(clazzName ,gradeId)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					clazzName : clazzName,
					gradeId : gradeId
				},
				url: "<%=basePath%>clazz/checkClazzByClazzName.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此学号存在
					if ("success" == result.resultCode)
					{
						flag = true;
					}
					else
					{
						flag = false;
					}
					
				},
			});
			
			return flag;
		}
		
		//表单校验相关---end
		
	</script>
</html>