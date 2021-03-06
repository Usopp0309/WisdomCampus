<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>添加教师</title>
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
                            <li><span>添加教师</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">添加教师</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>teacher/doAddTeacher.do" class="form-horizontal" method="post" id="addForm">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">工号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                	 <input type="text" name="code"  id="code"  class="form-control"/>
												      <span class="help-inline" style="display: none;" id="codeHelp"></span>
												      <span class="help-inline" style="display: block;">${message}</span>
                                                 </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">姓名：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="name"  id="name"  class="form-control"/>
													<span class="help-inline" style="display: none;" id="nameHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">绑定手机号码：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="11" maxlength="11" name="phone"  id="phone"  class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">角色：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="roleCode"  tabindex="1" id="roleSelect">
			                                        </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" >部门：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="departmentId" tabindex="1" id="departmentSelect" ">
		                                        		<option value="">--请选择--</option>
		                                        	</select>
                                                </div>
                                            </div>
                                            
                                            <h3 class="form-section">添加电子卡</h3>
                                            <div class="form-group" id="cardDiv">
                                                <label class="control-label col-md-3">电子卡号:</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<input type="text" name="cardCode" class="form-control" onBlur="bindBlurToCard($(this));"/>
                                            	</div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green" id="save">确定</button>
                                                    <button type="button" class="btn" onclick="history.go(-1);">返回</button>
                                                    <input type="hidden" value="${schoolId}" name="schoolId" id="schoolId"/>
									    			<input type="hidden" value="${user.userId}" name="userId" id="userId"/>
									    			<input type="hidden" value="true" name="isLocalSchool" id="isLocalSchool"/>
									    			<input type="hidden" value="true" name="isYinUser" id="isYinUser"/>
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
	<script src="<%=basePath%>assets/global/plugins/layer/layer.js"></script>
	<script>
		$(function(){ 
			loadSubMenu("schoolManager");  
			//选取当前菜单位置
			setActive("schoolManager","teacherManage");   
			loadDepartmentList();
			loadRoleList();
			//添加老师表单校验---begin
			//表单验证flag
			//工号
			$("#code").blur(function(){
				var code = $("#code").val();
				//未输入工号
				if ("" == code)
				{
					layer.tips('工号不能为空', '#code');
				}
				else if(checkCode(code))
				{
					layer.tips('工号已存在', '#code');
				}
			});
			//姓名
			$("#name").blur(function(){
				var name = $("#name").val();
				//未输入姓名
				if ("" == name)
				{
					layer.tips('姓名不能为空', '#name');
				}
				var phone = $.trim($("#phone").val());
				if(phone!="" && name!=""){
					var t=checkTeacherPhone(phone,name);
					if(t.flag){
						layer.tips(t.msg, '#phone');
						phoneFlag = false;
					}
				}
			});
			//手机号码
			$("#phone").blur(function(){
				var phone = $.trim($("#phone").val());
				var name = $.trim($("#name").val());
				//未输入手机号码
				if ("" == phone)
				{
					layer.tips('手机号码不能为空！', '#phone');
				}else if(!checkSubmitMobil($("#phone").val())){
					layer.tips('请输入正确的手机号码！！', '#phone');
				}else if(!checkSubmitMobil(phone)){
					layer.tips('手机号码格式不对！', '#phone');
					phoneFlag = false;
				}else if(phone!="" && name!=""){
					var t=checkTeacherPhone(phone,name);
					if(t.flag){
						layer.tips(t.msg, '#phone');
						phoneFlag = false;
					}
				}
			})
			//部门
			$("#departmentSelect").blur(function(){
				var departmentSelect = $("#departmentSelect").val();
				//未选择部门
				if ("" == departmentSelect)
				{
					layer.tips('请选择部门', '#departmentSelect');
				}
			});
			//角色
			$("#roleSelect").blur(function(){
				var roleSelect = $("#roleSelect").val();
				//未输入手机号码
				if (0 == roleSelect)
				{
					layer.tips('请选择角色', '#roleSelect');
				}
			});
			//添加教师表单校验---end
			$("#save").click(function(){
				if (checkForm())
				{
					var phone = $("#phone").val();
					 if(phone!=""){
			            	var t=checkTeacherPhone(phone,null);
							if(t.flag){//用户存在，且是教职工
								$("#isLocalSchool").val(t.isLocalSchool);
								$("#isYinUser").val(t.isYinUser);
								if(t.isLocalSchool && t.isteacher){//号码被本校教职工使用
									var ll=layer.confirm(t.msg+'是否进入修改页面？', {
										  btn: ['确定','取消'] //按钮
										}, function(){
											layer.close(ll);
											var userId = $("#userId").val();
											var roleCode = $("#roleSelect").val();
											var teacherId = t.userId;
											var departmentId = $("#departmentSelect").val();
											var fromAdd = 1;
											standardPost('<%=basePath%>teacher/toModifyTeacher.do',{userId:userId,roleCode:roleCode,teacherId:teacherId,departmentId:departmentId,fromAdd:1});
											
										}, function(){
										});	
								}else{//用户存在，不是被本校教职工占用
									var ll=layer.confirm(t.msg+'，是否继续？', {
										  btn: ['确定','取消'] //按钮
										}, function(){
											layer.close(ll);
											var indexlayer = layer.msg('正在保存教职工信息，请稍候。。。',{icon: 16,time:0,shade:0.3}); 
											$("#addForm").submit();
										}, function(){
											
										});
								}
								
							}else{//用户不存在
								var indexlayer = layer.msg('正在保存教职工信息，请稍候。。。',{icon: 16,time:0,shade:0.3}); 
								$("#addForm").submit();
							}
			            }else{
			            	layer.tips("请输入绑定手机号","#phone");
			            }
				}
			});
		});
		
		//教职工手机判断
		 function checkTeacherPhone(phone,name){
			var flag="";
			 $.ajax({
					type: "post",
					url: "<%=basePath%>teacher/checkTeacherPhone.do",
					dataType:"json",
					async: false, 
					data:{
						phone : phone,
						name:name
					},
					success: function(data){
						flag=data;
					}
				});
			   return flag;
		 }
		//表单校验相关---begin
		function checkForm()
		{
			//工号
			var code = $("#code").val();
			//未输入工号
			if ("" == code)
			{
				layer.tips('工号不能为空', '#code');
				return false;
			}
			else if (checkCode(code))
			{
				layer.tips('工号已存在', '#code');
				return false;
			}
			//姓名
			var name = $("#name").val();
			//未输入姓名
			if ("" == name)
			{
				layer.tips('姓名不能为空', '#name');
				return false;
			}
			//手机号码
			var phone = $("#phone").val();
			//未输入手机号码
			if ("" == phone)
			{
				layer.tips('手机号码不能为空', '#phone');
				phoneFlag = false;
				return phoneFlag;
			}else if(!checkSubmitMobil(phone)){
				layer.tips('手机号码格式不对！', '#phone');
				return false;
			}
			//部门
			var departmentSelect = $("#departmentSelect").val();
			//未输入部门
			if ("" == departmentSelect)
			{
				layer.tips('请选择部门', '#departmentSelect');
				return false;
			}
			//角色
			var roleSelect = $("#roleSelect").val();
			//未输入角色
			if (0 == roleSelect)
			{
				layer.tips('请选择角色', '#roleSelect');
				return false;
			}
			var iscontinue=true;
			//电子卡相关
			$("input[name='cardCode']").each(function(){
				var cardCode = $.trim($(this).val());
				if(iscontinue){
				if("" != cardCode && checkCardeCode(cardCode))
				{
					layer.tips('此卡号有拥有者', $(this));
					iscontinue=false;
					return cardFlag;
				}
				}
			});
			if(!iscontinue){
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
				url: "<%=basePath%>teacher/checkUserByCode.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此工号存在
					if (result)
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
		
		function checkCardeCode(cardCode)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					cardCode : cardCode,
				},
				dataType:"json",
				url: "<%=basePath%>card/checkCardCodeBycode.do",
				success: function(result)
				{
					//此卡号存在
					if (result)
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
		

		//加载部门信息
		function loadDepartmentList()
		{    
			$.ajax({
				type: "post",
				url: "<%=basePath%>depart/getDepartmentList.do",
				data:{
					
				},
				success: function(data){
					var departmentList = eval("(" + data + ")");
				
					//年级select页面html
					var departmentSelectHtml = '<option value="">--请选择--</option>';

					$.each(departmentList, function(n, value) {  
						//select页面
						departmentSelectHtml += '<option value="' + value.id + '">' + value.departmentName + '</option>';
                         
	          		});
          			$("#departmentSelect").html(departmentSelectHtml);
          			
				},
			});
		} 

		//加载角色信息
		function loadRoleList()
		{ 
			$.ajax({
				type: "post",
				url: "<%=basePath%>role/getRoleList.do",
				success: function(data){
					
					var roleList = eval("(" + data + ")");
					
					//年级select页面html
					var roleSelectHtml = '<option value="0">--请选择--</option>';

					$.each(roleList, function(n, value) {  
						//select页面
						if(value.roleCode!="parent" && value.roleCode!="student")
						{
							roleSelectHtml += '<option value="' + value.roleCode + '">' + value.roleName +' </option>';
						}
	          		});

          			$("#roleSelect").html(roleSelectHtml);
          			
				},
			});
		} 
		
		//添加新增卡号输入框
		function appendCardAdd()
		{
			var	appendHtml ='<div class="form-group" >';
				appendHtml +='<label class="control-label col-md-3">电子卡号:</label>';
				appendHtml +='<div class="col-md-4">';
				appendHtml +='<input type="text" name="cardCode" class="form-control" id="cardCode" class="form-control" onBlur="bindBlurToCard($(this));"/>';
				appendHtml +='</div>';
				appendHtml +='<div class="col-md-1"><i class="icon-trash m_margin_10_auto font-red-mint" onclick="removeCardAdd($(this));"></i></div>';
				appendHtml +='</div>';
				$("#cardDiv").before(appendHtml);
		}
		
		//删除新增卡号输入框		
		function removeCardAdd(obj)
		{
			if(confirm("确定要删除此电子卡吗？"))
		 	{
		 		obj.parent().parent().remove();
		 	}
		}
		
		
		function bindBlurToCard(obj)
		{
			var cardCode = obj.val();
			
			if(cardCode == null || cardCode == ""){
				
			}
			else if(checkCardeCode(cardCode))
			{
				layer.tips('此卡号有拥有者', $(obj));
			}
		}
	</script>
</html>