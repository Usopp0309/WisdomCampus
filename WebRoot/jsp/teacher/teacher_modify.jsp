<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>教师修改</title>
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
                            <li><span>教师修改</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">教师修改</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>teacher/doModifyTeacher.do" class="form-horizontal" method="post" id="addForm">
                                        <div class="form-body">
                                        <div class="form-group">
                                                <label class="control-label col-md-3">亦信号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" readonly="readonly"  value="${teacher.userName }"  class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">工号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="code"  id="code" value="${teacher.code }"  class="form-control"/>
												      <input type="hidden"  value="${teacher.code }" id="originalcode"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">名称：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="realName" value="${teacher.realName }"  id="realName" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">绑定手机号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                     <input type="text" name="bindPhone" value="${teacher.bindPhone}" maxlength="11" id="bindPhone" class="form-control"/>
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                <label class="control-label col-md-3">手机号：</label>
                                                <div class="col-md-9 col-lg-4">
                                                     <input type="text" name="phone" value="${teacher.phone}" maxlength="11" id="phone" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">密码：</label>
                                                <div class="col-md-9 col-lg-4">
                                                     <input type="text" name="passWord" value=""  id="passWord" class="form-control" placeholder="若输入密码则会修改原密码"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">角色：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="roleName"  tabindex="1" id="roleSelect">
				                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">部门：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="departmentName" disabled="disabled"  tabindex="1" id="departmentSelect">
			                                         </select>
                                                </div>
                                            </div>
                                            
                                            <h3 class="form-section">电子卡</h3>
                                            <div id="cardDiv">
                                                
                                            </div>
                                            
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<c:if test="${sessionScope.user.type != 2}">
														<button type="button" class="btn design_btn" id="save">保存</button>
														<button type="button" class="btn back_btn" id="cancel">返回</button>
													</c:if>
													<input type="hidden" value="${schoolId}" name="schoolId" id="schoolId"/>
													<input type="hidden" value="${teacherId}" name="teacherId" id="teacherId"/>
													<input type="hidden" value="${roleCode}" name="roleCode" id="roleCode"/>
													<input type="hidden" value="${departmentId}" name="departmentId" id="departmentId"/>
													<input type="hidden"  name="userId" value="${userId}" id="userId"/>
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
		jQuery(document).ready(function() {
			loadSubMenu("schoolManager");  
			//选取当前菜单位置
			setActive("schoolManager","teacherManage");     
			 loadRoleList();
			//加载部门列表
			loadDepartmentList();
			//电子卡
			loadTeacherCardListForModify(); 
			//添加老师表单校验---begin
			//表单验证flag
			//工号
			$("#code").blur(function(){
				var code = $("#code").val();
				var originalcode = $("#originalcode").val();
				//未输入工号
				if ("" == code)
				{
					layer.tips('工号不能为空', '#code');
				}
				else if (checkCode(code,originalcode))
				{
					layer.tips('工号已存在', '#code');
				}
			});
			//姓名
			$("#realName").blur(function(){
				var name = $("#realName").val();
				//未输入姓名
				if ("" == name)
				{
					layer.tips('姓名不能为空', '#realName');
				}
			});
			$("#phone").blur(function(){
				var phone = $("#phone").val();
				//未输入手机号码
				if ("" == phone)
				{
					layer.tips('手机号码不能为空', '#phone');
				}else if(!checkSubmitMobil(phone)){
					layer.tips('手机号码格式不对！', '#phone');
				}
			});
			//手机号码
			$("#bindPhone").blur(function(){
				var bindPhone = $("#bindPhone").val();
				var teacherId=$("#teacherId").val();
				//未输入手机号码
				if ("" == bindPhone)
				{
					layer.tips('手机号码不能为空', '#bindPhone');
				}else if(!checkSubmitMobil(bindPhone)){
					layer.tips('手机号码格式不对！', '#bindPhone');
				}else if(bindPhone!="" && bindPhone!=""){
					var t=checkTeacherPhone(bindPhone,name);
					if(t.flag && teacherId!=t.userId){
						layer.tips(t.msg, '#bindPhone');
					}
				}
			});
			//部门
			$("#departmentSelect").blur(function(){
				var departmentSelect = $("#departmentSelect").val();
				if ("" == departmentSelect)
				{
					layer.tips('请选择部门！', '#departmentSelect');
				}
			});
			//角色
			$("#roleSelect").blur(function(){
				var roleSelect = $("#roleSelect").val();
				//未输入手机号码
				if (0 == roleSelect)
				{
					layer.tips('请选择角色！', '#roleSelect');
				}
			});
			//添加学生表单校验---end
			$("#save").click(function(){
				if (checkForm())
				{
					var teacherId=$("#teacherId").val();
					var realName = $("#realName").val();
					var bindPhone = $.trim($("#bindPhone").val());
					var d=checkTeacherPhone(bindPhone,realName);
					if(d.flag){
						//被占用，但是亦信号未修改,说明号码还未使用过
						if(d.userId != teacherId && d.isDefalutUserName == 0){
							var isupdate=false;
							//亦信
						    if(d.isYinUser){
						    	isupdate=true;
						    }else if(!d.isLocalSchool){//非本校
						    	isupdate=true;
						    }
						    if(isupdate){
							layer.confirm(d.msg+"，是否继续？", {
							  btn: ['保存','取消'] //按钮
							}, function(){
								var indexlayer = layer.msg('正在保存教职工信息,请稍候。。。',{icon: 16,time:0,shade:0.3}); 
								$("#addForm").submit();
							}, function(){
								
							});
						    }else{
						    	layer.alert(d.msg+"，不允许修改");	
						    }
						
						}else if(d.userId==teacherId){
							$("#addForm").submit();	
						}else{
							layer.alert(d.msg+"，不允许修改");
						}
					}else{
						var indexlayer = layer.msg('正在保存教职工信息,请稍候。。。',{icon: 16,time:0,shade:0.3}); 
						$("#addForm").submit();
					}
				}
			});
		});
		//加载部门信息
		function loadDepartmentList()
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>depart/getDepartmentList.do",
				success: function(data){
					var departmentList = eval("(" + data + ")");
					//年级select页面html
					var departmentSelectHtml = '<option value="">--请选择--</option>';
					$.each(departmentList, function(n, value) {  
						//select页面
						departmentSelectHtml += '<option value="' + value.id + '">' + value.departmentName + '</option>';
	          		});
          			$("#departmentSelect").html(departmentSelectHtml);
          			
          			var departmentId = $("#departmentId").val();
          			
          			if (typeof(departmentId) == "undefined" || departmentId == "undefined")
					{
						$("#departmentSelect").val("0");
					}
					else
					{
						$("#departmentSelect").val(departmentId);
					}
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
          			var roleCode = $("#roleCode").val();
          			if (roleCode == null)
					{
						$("#roleSelect").val("0");
					}
					else
					{
						$("#roleSelect").val(roleCode);
					}
				},
			});
		} 
		
		
		//表单校验相关---begin
		
		function checkForm()
		{
			//工号
			var code = $.trim($("#code").val());
			var originalcode = $("#originalcode").val();
			//未输入工号
			if ("" == code)
			{
				layer.tips("工号不能为空","#code");
				return false;
			}
			else if (checkCode(code,originalcode))
			{
				layer.tips("工号已存在","#code");
				return false;
			}
			//姓名
			var name = $("#name").val();
			//未输入姓名
			if ("" == name)
			{
				layer.tips("姓名不能为空","#name");
				return false;
			}

			//绑定手机号码
			var phone = $.trim($("#phone").val());
			//未输入手机号码
			if ("" == phone)
			{
				layer.tips("手机号码不能为空","#phone");
				return false;
			}else if(!checkSubmitMobil(phone)){
				layer.tips("手机号码格式不对！","#phone");
				return false;
			}
			
			//绑定手机号码
			var bindPhone = $.trim($("#bindPhone").val());
			var teacherId=$("#teacherId").val();
			//未输入手机号码
			if ("" == bindPhone)
			{
				layer.tips("手机号码不能为空","#bindPhone");
				return false;
			}else if(!checkSubmitMobil(bindPhone)){
				layer.tips("手机号码格式不对！","#bindPhone");
				return false;
			}else if(bindPhone!="" && bindPhone!=""){
				var t=checkTeacherPhone(bindPhone,name);
				if(t.flag && teacherId!=t.userId){
					layer.tips(t.msg, '#bindPhone');
					return false;
				}
			}
           //部门
			var departmentSelect = $("#departmentSelect").val();
			if ("" == departmentSelect)
			{
				layer.tips("请选择部门","#departmentSelect");
				return false;
			}
			//角色
			var roleSelect = $("#roleSelect").val();
			//未输入角色
			if (0 == roleSelect)
			{
				layer.tips("请选择角色","#roleSelect");
				return false;
			}
			var iscontinue=true;
			//电子卡相关
			$("#cardDiv").find("input[name='cardCode']").each(function(){
				var cardCode = $(this).val();
				var cardCode = $.trim($(this).val());
				var originalCardCode = $(this).next("input").val();
				if(cardCode!=""){
				if(checkCardCode(cardCode,originalCardCode))
				{
					layer.tips("卡已有人使用",$(this));
					iscontinue=false;
					return false;
				}
			    }
			});
			if(!iscontinue){
				return false;
			}
			return true;
		}
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
		//检查工号
		function checkCode(code,originalcode)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					code : code,
					originalcode : originalcode
				},
				url: "<%=basePath%>teacher/checkModifyTeacherByCode.do",
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

       	//检查卡号
		function checkCardCode(code,originalCardCode)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					code : code,
					originalCardCode : originalCardCode
				},
				url: "<%=basePath%>teacher/checkModifyTeacherCardCodeByCardCode.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此卡号存在
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

		//添加新增卡号输入框
		function appendCardAdd(){
			var appendHtml  ='<div class="form-group">';
				appendHtml +='<label class="control-label col-md-3">电子卡号</label>';
				appendHtml +='<div class="col-md-8 col-lg-4">';
				appendHtml +='<input type="text" name="cardCode" id="cardCode" class="form-control" onBlur="bindBlurToCard($(this));"/>';
				appendHtml +='<input type="hidden"  value="" name="originalCardCode"/>';
				appendHtml +='</div>';
				appendHtml +='<div class="col-md-1"><i class="icon-trash font-green-sharp m_margin_10_auto" onclick="removeCardAdd($(this));"></i></div>';
				appendHtml +='</div>';
				$("#cardDiv").append(appendHtml);
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
			var originalCardCode = obj.next("input").val();
			if(cardCode!="" && checkCardCode(cardCode,originalCardCode))
			{
			    obj.parent().parent().addClass("error");
				obj.next().next().next().show();
				obj.next().next().next().html("此卡号有拥有者");
			}
			else
			{
				obj.parent().parent().removeClass("error");
				obj.next().next().next().hide();
			}
		}
				
		
		
		//表单校验相关---end
		
		
		//加载电子卡列表,用于修改
		function loadTeacherCardListForModify()
		{
			var teacherId = $("#teacherId").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>teacher/getTeacherCardListForModify.do",
				data:
				{
					teacherId : teacherId
				},
				success: function(data)
				{
					var cardList = eval("(" + data + ")");

					var appendHtml = '';

					//如果没有电子卡					
					if (cardList.length == 0)
					{
						appendHtml +='<div class="form-group">';
						appendHtml +='<label class="control-label col-md-3">电子卡号</label>';
						appendHtml +='<div class="col-md-4">';
						appendHtml +='<input type="text" name="cardCode" id="cardCode" class="form-control" onBlur="bindBlurToCard($(this));"/>';
						appendHtml +='<input type="hidden"  value="" name="originalCardCode"/>';
						appendHtml +='</div>';
						appendHtml +='<div class="col-md-1"><i class="icon-trash font-red-mint m_margin_10_auto" onclick="appendCardAdd()"></i></div>';
						appendHtml +='</div>';
					}
					
					//遍历电子卡
					$.each(cardList, function(n, value){
						if (n == cardList.length - 1)
						{   
							appendHtml +='<div class="form-group">';
							appendHtml +='<label class="control-label col-md-3">电子卡号</label>';
							appendHtml +='<div class="col-md-8 col-lg-4">';
							appendHtml +='<input type="text" name="cardCode" id="cardCode" class="form-control" onBlur="bindBlurToCard($(this));" value="' + value.cardCode + '"/>';
							appendHtml +='<input type="hidden"  value="' + value.cardCode + '" name="originalCardCode"/>';
							appendHtml +='</div>';
							appendHtml +='<div class="col-md-1"><i class="icon-plus font-red-mint m_margin_10_auto" onclick="appendCardAdd()"></i></div>';
							appendHtml +='</div>';
						}						
						else
						{ 
							appendHtml +='<div class="form-group">';
							appendHtml +='<label class="control-label col-md-3">电子卡号</label>';
							appendHtml +='<div class="col-md-8 col-lg-4">';
							appendHtml +='<input type="text" name="cardCode" id="cardCode" class="form-control" onBlur="bindBlurToCard($(this));" value="' + value.cardCode + '"/>';
							appendHtml +='<input type="hidden"  value="' + value.cardCode + '" name="originalCardCode"/>';
							appendHtml +='</div>';
							appendHtml +='<div class="col-md-1"><i class="icon-trash font-green-sharp m_margin_10_auto" onclick="removeCardAdd($(this))"></i></div>';
							appendHtml +='</div>';
						}
          			});

          			$("#cardDiv").html(appendHtml);

				},
			});
		}
</script>
</html>