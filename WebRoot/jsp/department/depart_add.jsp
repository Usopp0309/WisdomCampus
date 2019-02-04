<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
   <meta charset="utf-8" />
   <title>添加部门</title>
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
                            <li><span>添加部门</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">添加部门信息</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="" class="form-horizontal" method="post" id="addForm">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">部门编号</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="code"  id="code" class="form-control"/>
												    <input type="hidden" value="${schoolid}" name="schoolId" id="schoolId"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">部门名称</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="name"  id="name" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">参与考勤</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select id="isAttendance" class="form-control" name="isAttendance">
														<option value="0" selected="selected">是</option>
														<option value="1">否</option>
													</select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
	                                                <button type="button" class="btn design_btn" id="addDepart">提交</button>
													<button type="button" class="btn back_btn" id="cancel">返回</button>
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
	<script>

		$(function(){
			var codeFlag = false;
			var nameFlag = false;
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","departManage");      
			//部门
			//添加部门表单校验---begin
			//表单验证flag
			$("#code").blur(function(){
				var code = $.trim($("#code").val());
				//未输入部门编号
				if ("" == code)
				{
					layer.tips('部门编号不能为空', '#code');
				}
				else if (checkCode(code))
				{
					layer.tips('部门编号已存在', '#code');
				}else if(code.length>20){
					layer.tips('部门编号最多20个字符', '#code');
				}
				
				
			});
			//部门名称
			$("#name").blur(function(){
				var name = $.trim($("#name").val());
				//未输入姓名
				if ("" == name)
				{
					layer.tips('部门名称不能为空', '#name');
				}
				else if(checkName(name))
				{
					layer.tips('部门名称已存在', '#name');
				}else if(name.length>50){
					layer.tips('部门名称最多50个字符', '#name');
				}
			});
			//添加部门表单校验---end
			$("#addDepart").click(function(){
				//部门编号
				var code = $.trim($("#code").val());
				var name =  $.trim($("#name").val());
				//未输入部门编号
				if ("" == code)
				{
					layer.tips('部门编号不能为空', '#code');
					return false;
				}
				else if (checkCode(code))
				{
					layer.tips('部门编号已存在', '#code');
					return false;
				}else if(code.length>20){
					layer.tips('部门编号最多20个字符', '#code');
					return false;
				}
				if ("" == name)
				{
					layer.tips('部门名称不能为空', '#name');
					return false;
				}
				else if(checkName(name))
				{
					layer.tips('部门名称已存在', '#name');
					return false;
				}else if(name.length>50){
					layer.tips('部门名称最多50个字符', '#name');
					return false;
				}
					var isAttendance= $("#isAttendance").val();
					var indexlayer = layer.msg('正在添加数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
					$.ajax({
						type: "post",
						url:'<%=basePath%>depart/doAddDepartm.do',
						data:{
								code:code,
								name:name,
								isAttendance:isAttendance,
							},
							error:function(){
								layer.close(indexlayer);
							},
						success:function(result){
							layer.close(indexlayer);
							 if(result){
								 layer.msg("添加成功",{icon:1,time:1000});
								 setTimeout(function(){
									 window.location.href="<%=basePath%>depart/toDepartList.do";
								 },1000);
							}else{
								layer.msg('添加失败，请重新添加');
							}
							
						}
							
					})
			});
		});
		function checkCode(code)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					code : code,
				},
				url: "<%=basePath%>depart/checkDepartmCode.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此部门编号存在
					if ("success" == result.resultCode)
					{
						flag = false;
					}
					else
					{
						flag = true;
					}
					
				},
			});
			
			return flag;
		}
		
		function checkName(name)
		{
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				data:{
					name : name
				},
				url: "<%=basePath%>depart/checkDepartmName.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此部门编号存在
					if ("success" == result.resultCode)
					{
						flag = false;
					}
					else
					{
						flag = true;
					}
					
				},
			});
			
			return flag;
		}
		
        //表单校验相关---end
		// 普通跳转
		function jumpNormalPage(page)
		{
			 standardPost('<%=basePath%>leave/toSchoolList.do',{cpage:page});
			 
		}

		// 上一页 
		function jumpPreviousPage(page)
		{
			/*
			 * 已经是首页
			 */
			if (page == 1)
			{
			}
			else
			{
				page = page - 1;
				standardPost('<%=basePath%>leave/toSchoolList.do',{cpage:page});
			}
			 
		}

		// 下一页
		function jumpNextPage(page, totalPage)
		{
			/*
			 * 已经是尾页
			 */
			 if(page == totalPage || page > totalPage)
		     {}
			 else
			 {
				 page = page + 1;
				 standardPost('<%=basePath%>leave/toSchoolList.do',{cpage:page});
			 }
		}

		
	</script>
</html>