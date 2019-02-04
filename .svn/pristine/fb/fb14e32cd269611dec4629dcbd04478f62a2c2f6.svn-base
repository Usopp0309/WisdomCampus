<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>部门修改</title>
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
                            <li><span>部门修改</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">部门修改</span>
                                    </div>
                                </div>
                                <div class="portlet-body form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">部门编号：</label>
                                                <div class="col-lg-4 col-md-9">
                                                 	<input type="text" size="16" name="code" id="code" class="form-control"/>
                                                 	<input type="hidden" value="" size="16" name="code" id="originalcode"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">名称：</label>
                                                <div class="col-lg-4 col-md-9">
                                                    <input type="text" size="16" name="departmentName" id="name" class="form-control"/>
													<input type="hidden" id="originalName"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" >创建时间</label>
                                                <div class="col-lg-4 col-md-9">
                                                     <input type="text" size="16" class="form-control" name="createTime" id="createTime" readonly="readonly"/>
                                            	</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">是否考勤</label>
                                                <div class="col-lg-4 col-md-9">
                                                    <div class="input-icon right">
                                                        <select id="isAttendance" class="form-control" name="isAttendance"  value ="">
																<option value="0" >是</option>
																<option value="1">否</option>
														</select>
                                                	</div>
                                            	</div>
                                        	</div>
                                            <h3 class="form-section">部门负责人</h3>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">部门主管：</label>
                                                <div class="col-lg-4 col-md-9">
                                                    <div class="input-icon right">
                                                        <select class="form-control select2me m_select" name="leaderId"  tabindex="1" id="departLeaderSelect">
                                       					</select>
                                                	</div>
                                                		<input type="hidden" name="departmentName" id="departmentName">
                                            	</div>
                                            </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn design_btn" id="save">确定</button>
                                                    <button type="button" class="btn back_btn" onclick="history.go(-1)">返回</button>
                                                    <input type="hidden" value="${departmentId}" name="departmentId" id="departmentId"/>
													<input type="hidden" value="${leaderId}" id="leaderId" name="oldLeaderId"/>
													<input type="hidden" value="${user.userId}" name="userId"/>
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
	<script>
		jQuery(document).ready(function()
		 {    
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","departManage");   
			var departmentId = $("#departmentId").val();
			loadDepartDetailForModify(departmentId);
			loadDepartmentLeaderList();
			//表单校验---begin
			//部门编号
			$("#code").blur(function(){
				var code = $.trim($("#code").val());
				var originalcode = $("#originalcode").val();
				//未输入部门编号
				if ("" == code)
				{
					layer.tips('部门编号不能为空', '#code');
				}
				else if (checkCode(code,originalcode))
				{
					layer.tips('部门编号已存在','#code')
				}
			});
			//部门名
			$("#name").blur(function(){
				var name = $.trim($("#name").val());
				var originalName = $("#originalName").val();
				//未输入部门编号
				if ("" == name)
				{
					layer.tips('部门名称不能为空','#name');
				}
				else if (checkName(name,originalName))
				{
					layer.tips('部门名已存在','#name')
				}
			});
			//表单校验---end
			$("#save").on("click",function(){
				var code = $.trim($("#code").val());
				var originalcode = $("#originalcode").val();
				//未输入年级代码
				if ("" == code)
				{
					layer.tips('部门编号不为空','#code');
					return false;
				}
				else if (checkCode(code,originalcode))
				{
					layer.tips('部门编号已存在','#code');
					return false;
				}else if(code.length>20){
					layer.tips('部门编号最多20个字符','#code');
					return false;
				}
				//部门名
				var name = $.trim($("#name").val());
				if(name==""){
					layer.tips('部门名称不为空','#name');
					return false;
				}else if(name.length>50){
					layer.tips('部门名称最多50个字','#name');
					return false;	
				}
				var originalName = $.trim($("#originalName").val());
				if (checkName(name,originalName))
				{
					layer.tips('部门名已存在','#name');
					return false;
				}
					var departmentName=$("#name").val();
					var leaderId=$("#departLeaderSelect").val();
					var isAttendance=$("#isAttendance").val();
					var departmentId=$("#departmentId").val();
					var indexlayer = layer.msg('正在修改数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
					$.ajax({
						type:"post",
						url:'<%=basePath%>depart/doModifyDepart.do',
						dataType:"json",
						data:{
							code:code,
							departmentName:departmentName,
							leaderId:leaderId,
							isAttendance:isAttendance,
							departmentId:departmentId,
							},
							error:function(){
								layer.close(indexlayer);
							},
						success:function(result){
							layer.close(indexlayer);
							if(result){
								layer.msg("修改成功",{icon:1,time:1000});
								setTimeout(function(){
									window.location.href="<%=basePath%>depart/toDepartList.do";	
								},1000);
							}else{
								layer.msg("修改失败",{icon:2,time:1000});
								}
							}
					})
			});
		});
		//加载部门详细信息
		function loadDepartDetailForModify(departmentId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>depart/getDepartDetailForModify.do",
				data : {
					departmentId : departmentId,
				},
				success: function(data){
					var depart = eval("(" + data + ")");
					$("#code").val(depart.code);
					$("#originalcode").val(depart.code);
					$("#name").val(depart.departmentName);
					$("#originalName").val(depart.departmentName);
					$("#isAttendance").val(depart.isAttendance);
					var time = depart.createTime;
					if (typeof(time)=="undefined"){
						time = "";
					}else{
						time = time.substr(0, time.length-2)
					}
					$("#createTime").val(time);
					
				},
			});
		}
		
		
		//加载部门主管信息
		function loadDepartmentLeaderList()
		{
			$.ajax({
				
				type: "post",
				
				url: "<%=basePath%>depart/getDepartManagerList.do",
				
				success: function(data){
					
					var departmentLeaderList = $.parseJSON(data);
          			var leaderId = $("#leaderId").val();

					//班主任select页面html
					var departmentLeaderSelectHtml = '<option value="0">--请选择--</option>';
					var departmentLeaderName ='';
					$.each(departmentLeaderList, function(n, value) {  
						if(leaderId == value.userId){
							departmentLeaderName = value.realName;
						}
						departmentLeaderSelectHtml += '<option value="' + value.userId + '">' + value.realName + '</option>';
						
	          		});
					if(departmentLeaderName ==null ||departmentLeaderName==''){
						departmentLeaderName="--请选择--";
					}
	          		$("#select2-departLeaderSelect-container").attr("title",departmentLeaderName);
	          		$("#select2-departLeaderSelect-container").text(departmentLeaderName);
          			$("#departLeaderSelect").html(departmentLeaderSelectHtml);
          			
          			
          			if (typeof(leaderId) == "undefined" || leaderId == "undefined"|| leaderId == "")
					{
						$("#departLeaderSelect").val("0");
					}
					else
					{
						$("#departLeaderSelect").val(leaderId);
					}
					
				},
			});
		}

		//检查部门编号是否存在
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
				url: "<%=basePath%>depart/checkModifyDepartmentByCode.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此编号存在
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

		//检查部门名是否存在
		function checkName(name, originalName)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					name : name,
					originalName : originalName
				},
				url: "<%=basePath%>depart/checkModifyDepartmentByName.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此年级存在
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
	</script>
</html>