<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
<meta charset="utf-8" />
<title>班级修改</title>
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
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
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
                            <li><span>班级修改</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                      		<!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_15_0">
	                        	<r:right rightCode="createClazzGroup">
									<button class="btn btn-default " type="button" id="createClazzGroup">一键创建亦信班级群</button>
									<button class="btn btn-default " type="button" id="delClazzGroup">删除亦信班级群</button>
								</r:right>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">班级修改</span>
                                    </div>
                                </div>
                                
                                <div class="portlet-body">
                                    <form action="<%=basePath%>clazz/doModifyClazz.do" id="addForm" method="post" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">班级编号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                  <input type="text" name="code" id="code" class="form-control" value="${code}"/>
											      <input type="hidden" name="originalcode" id="originalcode" value="${code}"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">学段类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <c:if test="${requestScope.type eq '0' }">
														<input type="text" size="16" name="type" id="type" class="form-control" value="幼儿园" readonly="readonly"/>
													</c:if> 
													<c:if test="${requestScope.type eq '1' }">
														<input type="text" size="16" name="type" id="type" class="form-control" value="小学" readonly="readonly"/>
													</c:if> 
													<c:if test="${requestScope.type eq '2' }">
														<input type="text" size="16" name="type" id="type" class="form-control" value="初中" readonly="readonly"/>
													</c:if> 
													<c:if test="${requestScope.type eq '3' }">
														<input type="text" size="16" name="type" id="type" class="form-control" value="高中" readonly="readonly"/>
													</c:if> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">年级名称：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="createYear" id="createYear" class="form-control" value="${gradeName }" readonly="readonly"/>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="control-label col-md-3">班级名称：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <div class="input-icon right">
                                                        <input type="text" size="16" name="clazzName" id="clazzName" class="form-control" value="${clazzName }" />
                                                	</div>
                                            	</div>
                                        	</div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">班主任：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <div class="input-icon right">
                                                        <select class="form-control select2me m_select" name="clazzLeaderSelect"  tabindex="1" id="clazzLeaderSelect">
				                                        </select>
                                                	</div>
                                            	</div>
                                        	</div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn design_btn"  id="save">确定</button>
                                                    <button type="button" class="btn back_btn" onclick="history.go(-1);">返回</button>
                                                    <input type="hidden" value="${clazzId}" name="clazzId" id="clazzId"/>
													<input type="hidden" value="${userId}" name="userId"/>
													<input type="hidden" value="${leaderId}" name="oldLeaderId" id="leaderId"/>
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
		$(function(){ 
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","clazzManage");  
			//加载班主任信息
			loadClazzLeaderList();
			
			//添加班级表单校验---begin
			//表单验证flag
			//班级编号
			$("#code").blur(function(){
				var code = $.trim($("#code").val());
				var originalcode = $("#originalcode").val();
				//未输入班级编号
				if ("" == code)
				{
					layer.tips("班级编号不能为空","#code");
					return false;
				}
				else if (checkCode(code, originalcode))
				{
					layer.tips("班级编号已存在","#code");
					return false;
				}
			});
			$("#clazzName").blur(function(){
				var clazzName=$.trim($("#clazzName").val());
				if(clazzName!=""){
					var flag=checkClazzName(clazzName,"${gradeId}");
					if(flag=="1"){
						layer.tips('该班级名称在同年级已经存在', '#clazzName');
				}
			}
			});
			//班主任
			$("#clazzLeaderSelect").blur(function(){
				var clazzLeaderSelect = $("#clazzLeaderSelect").val();
			});
			//添加班级表单校验---end
			$("#save").click(function(){
				if (checkForm())
				{
					$("#addForm").submit();
				}
			});

			//一键创建亦信班级群
			$("#createClazzGroup").click(function(){
				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				var clazzId = $("#clazzId").val();
				if(confirm('确认创建班级群？')){
					//创建群时，判断班级里面有没有人， 没有人不让建群 
					createClazzGroup(clazzId);
				}
			});
			$("#delClazzGroup").click(function(){
				var userId = $("ul li.active").find('a').attr("attr1");
				var roleCode = $("ul li.active").find('a').attr("attr2");
				var clazzId = $("#clazzId").val();
				if(confirm('确认删除班级群？')){
					//创建群时，判断班级里面有没有人， 没有人不让建群 
					delClazzGroup(clazzId);
				}
			});
			

		});

		//创建班级群
		function createClazzGroup(clazzId){
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazz/createClazzGroup.do",
				data:{clazzId : clazzId},
				success : function(data){
					var result = eval("(" + data + ")");
					layer.msg(result);
					//解锁UI
          			App.unblockUI(body);
					
				}
			});
		}

		//删除班级群
		function delClazzGroup(clazzId){
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>clazz/delClazzGroup.do",
				data:{clazzId : clazzId},
				success : function(data){
					var flag = eval("(" + data + ")");
					if(flag){
						layer.msg("班级群组删除成功");
					}else{
						layer.msg("班级群组删除失败，请稍后重试");
					}
					//解锁UI
          			App.unblockUI(body);
					
				}
			});
		}
		
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
					var leaderId = $("#leaderId").val();
					var lName='';
					$.each(clazzLeaderList, function(n, value) {  
						if(leaderId == value.userId){
							lName=value.realName;
						}
						clazzLeaderSelectHtml += '<option value="' + value.userId + '">' + value.realName + '</option>';
	          		});
					if(lName==''){
						lName="--请选择--";
						$("#clazzLeaderSelect").html(clazzLeaderSelectHtml);
					}else{
						$("#clazzLeaderSelect").html(clazzLeaderSelectHtml);
					}
					var leaderId= $("#leaderId").val();
	          		$("#select2-clazzLeaderSelect-container").attr("title",lName);
	          		$("#select2-clazzLeaderSelect-container").text(lName);
          			
					$("#clazzLeaderSelect").val(leaderId);
					var clazzLeader = $("#clazzLeaderSelect").val();
					if (null == clazzLeader || "" == clazzLeader)
					{
						$("#clazzLeaderSelect").val(0);
					}
				},
			});
		}
				
		//表单校验相关---begin
		function checkForm()
		{
			//班级编号
			var code = $.trim($("#code").val());
			var originalcode = $.trim($("#originalcode").val());
			//未输入编号
			if ("" == code)
			{
				layer.tips('班级编号不能为空', '#code');
				return false;
			}
			else if (checkCode(code,originalcode))
			{
				layer.tips('班级编号已存在', '#code');
				return false;
			}else if(code.length>20){
				layer.tips('班级编号最多20个字符', '#code');
				return false;	
			}
			var clazzName=$.trim($("#clazzName").val());
			if(clazzName==""){
				layer.tips('请输入班级名称', '#clazzName');
				return false;
			}else if(clazzName!=""){
				var flag=checkClazzName(clazzName,"${gradeId}");
				if(flag=="1"){
					layer.tips('该班级名称在同年级已经存在', '#clazzName');
					return false;
				}
			}else if(clazzName.length>64){
				layer.tips('班级名称最多64个字', '#clazzName');
				return false;
			}
			//班主任
			var clazzLeaderSelect=$("#clazzLeaderSelect").val();
			return true;
		}
		
		function checkCode(code, originalcode)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				url: "<%=basePath%>clazz/checkClazzModifyByCode.do",
				data:{
					code : code,
					originalcode : originalcode
				},
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
					
				}
			});
			
			return flag;
			
		}
		//判断班级名称是否重复
		function checkClazzName(clazzName ,gradeId)
		{
			var classId=$("#clazzId").val();
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				dataType:"json",
				data:{
					clazzName : clazzName,
					gradeId : gradeId,
					classId:classId
				},
				url: "<%=basePath%>clazz/checkUpdateClazzByClazzName.do",
				success: function(data)
				{
				flag = data;
				},
			});
			
			return flag;
		}
	</script>
</html>