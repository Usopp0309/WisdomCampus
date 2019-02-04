<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
    <meta charset="utf-8" />
    <title>增加年级</title>
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
                            <li><span>增加年级</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">年级信息</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="/doAddGrade.do" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">选择学段</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="type" tabindex="1" id="type">
	                                       		<option value="0">幼儿园</option>
										   		<option value="1">小学</option>
										   		<option value="2">初中</option>
										   		<option value="3">高中</option>	
	                                        </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">选择年级</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="gradeName" tabindex="1" id="gradeName">
												   		<option value="1">小班</option>
												   		<option value="2">中班</option>
												   		<option value="3">大班</option>	
		                                       		</select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">入学年份</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="createYear" id="createYear" class="form-control" value=""/>
													<span class="help-inline" style="display: none;" id="createYearHelp"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
	                                                <button type="button" class="btn green" onclick="saveGrade();">保存</button>
	                                                <button type="button" class="btn" id="cancel">返回</button>
													<span id="mesg_" style="color: #B94A48;"></span>
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
	//注册键盘事件
	document.onkeydown = function(e) {
	 //捕捉回车事件
	 var ev = (typeof event!= 'undefined') ? window.event : e;
	 if(ev.keyCode == 13) {
	  return false;
	 }
	}
		jQuery(document).ready(function()
		 {    
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","gradeManage");   
			//入学年份
			$("#createYear").blur(function(){
				var createYear = $("#createYear").val();
				if ("" == createYear)
				{
					layer.tips('入学年份不能为空', '#createYear');
				}
				else if(checkCreateYear())
				{
					layer.tips('入学年份已经存在', '#createYear');
				}else if(checkGradeName()){
					layer.tips('已存在相同且可用的年级名称','#gradeName');	
				}
				
			});

			$("#type").change(function(){
				var type = $(this).val();
				var gradeName = $("#gradeName");
				gradeName.html("");
				if(type == 0){
					gradeName.append("<option value='1'>小班</option>");
					gradeName.append("<option value='2'>中班</option>");
					gradeName.append("<option value='3'>大班</option>");
				}else if(type == 1){
					gradeName.append("<option value='1'>一年级</option>");
					gradeName.append("<option value='2'>二年级</option>");
					gradeName.append("<option value='3'>三年级</option>");
					gradeName.append("<option value='4'>四年级</option>");
					gradeName.append("<option value='5'>五年级</option>");
					gradeName.append("<option value='6'>六年级</option>");
				}else if(type == 2){
					gradeName.append("<option value='1'>七年级</option>");
					gradeName.append("<option value='2'>八年级</option>");
					gradeName.append("<option value='3'>九年级</option>");
				}else if(type == 3){
					gradeName.append("<option value='1'>一年级</option>");
					gradeName.append("<option value='2'>二年级</option>");
					gradeName.append("<option value='3'>三年级</option>");
				}

			});

		});
		function saveGrade(){
			if (checkForm())
			{
				addGrade();
			}
		}
		//判断年级
		function checkGradeName(){
			var flag=false;
			var type = $("#type").val();
			var gradeName=$.trim($("#gradeName").find("option:selected").text());
			$.ajax({
				async:false, 
				type: "post",
				url: "<%=basePath%>grade/checkGradeName.do",
				dataType:"json",
				data:{
					gradeName : gradeName,
					type : type,
					state:0
				},
				success: function(data)
				{
					flag=data;
				}
			});
			return flag;
		}

		function checkForm()
		{
			var createYear = $("#createYear").val();
			if ("" == createYear)
			{
				layer.tips('入学年份不能为空', '#createYear');
				return false;
			}
			else if(checkCreateYear())
			{
				layer.tips('入学年份已经存在', '#createYear');
				return false;
			}else if(checkGradeName()){
				layer.tips('已存在相同且可用的年级名称', '#gradeName');
				return false;
			}
			return true;
		}
		function checkCreateYear(){
			var createYear = $("#createYear").val();
			var type = $("#type").val();
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				url: "<%=basePath%>grade/checkGradeCreateYearInAdd.do",
				data:{
					createYear : createYear,
					type : type
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
		function addGrade(){
			var type=$("#type").val();
			var gradeName=$("#gradeName").val();
			var createYear=$("#createYear").val();
			var indexlayer = layer.msg('正在添加数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			$.ajax({
				async:false, 
				type: "post",
				url: "<%=basePath%>grade/doAddGrade.do",
				dataType:"json",
				data:{
					createYear : createYear,
					type : type,
					gradeName:gradeName
				},
				success: function(result)
				{
					if(result){
						layer.msg("添加成功",{icon:1,time:1000});
						location.href="<%=basePath%>grade/toGradeList.do";	
					}else{
						layer.msg("添加失败",{icon:2,time:1000});
						layer.close(indexlayer);
					}
				},error:function(){
					layer.close(indexlayer);
				}
			});
		}
	</script>
</html>