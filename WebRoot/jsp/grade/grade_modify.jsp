<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>年级修改页面</title>
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
                            <li><span>年级修改</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">年级修改</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="<%=basePath%>grade/doModifyGrade.do" class="form-horizontal" id="addForm" method="post">
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
                                                <label class="control-label col-md-3" for="inputError">年级名称</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="gradeName" id="gradeName" readonly="readonly" class="form-control" value="${name }"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">入学年份</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" size="16" name="createYear" id="createYear" class="form-control" value="${crteateYear }"/>
													<input type="hidden" id="originalCreateYear" value="${crteateYear}"/>
                                            	</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">状态</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <div class="input-icon right">
                                                        <select class="form-control" name="state" tabindex="1" id="state">
				                                       		<option value="0">可用</option>
													   		<option value="1">不可用</option>
				                                       </select>
	                                                </div>
                                            	</div>
                                        	</div>
                                        	<div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<button type="button" class="btn design_btn" id="save">保存</button>
													<button type="button" class="btn back_btn" id="cancel">返回</button>
													<input type="hidden" value="${gradeId}" name="gradeId" id="gradeId"/>
													<input type="hidden" value="${userId}" name="userId"/>
													<input type="hidden" value="${type}"  id="origType"/>
                                                
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
		jQuery(document).ready(function()
		 {    
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","gradeManage");  
			//加载年级名称
			loadType()

			//入学年份
			$("#createYear").blur(function(){
				var createYear = $("#createYear").val();
				if ("" == createYear)
				{
					layer.tips('入学年份不能为空', '#createYear');
				}else if(checkCreateYear())
				{
					layer.tips('入学年份已经存在', '#createYear');
				}
			});


			$("#save").click(function(){
				if (checkForm())
				{
					$("#addForm").submit();
				}
			});

		});

		//加载年级类型
		function loadType(){
			var origType = $("#origType").val();
			$("#type").val(origType);
		}

		function checkForm()
		{
			var createYearFlag = false;
			var createYear = $("#createYear").val();
			if ("" == createYear)
			{
				layer.tips('入学年份不能为空', '#createYear');
				createYearFlag = false;
			}else if(checkCreateYear())
			{
				layer.tips('入学年份已经存在', '#createYear');
				createYearFlag = false;
			}
			else
			{
				createYearFlag = true;
			}
			if (createYearFlag)
			{
				return true;
			}	
			else
			{
				return false;
			}
		}
		//判断年级
		function checkGradeName(){
			var flag=false;
			var type = $("#type").val();
			var gradeName=$.trim($("#gradeName").find("option:selected").text());
			var gradeId=$("#gradeId").val();
			var state=$("#state").val();
			$.ajax({
				async:false, 
				type: "post",
				url: "<%=basePath%>grade/checkGradeName.do",
				dataType:"json",
				data:{
					gradeName : gradeName,
					type : type,
					gradeId:gradeId,
					state:state
				},
				success: function(data)
				{
					flag=data;
				}
			});
			return flag;
		}
		function checkCreateYear(){
			var createYear = $("#createYear").val();
			var originalCreateYear = $("#originalCreateYear").val();
			var type = $("#type").val();
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				url: "<%=basePath%>grade/checkGradeCreateYearInModify.do",
				data:{
					createYear : createYear,
					originalCreateYear : originalCreateYear,
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
	</script>
</html>