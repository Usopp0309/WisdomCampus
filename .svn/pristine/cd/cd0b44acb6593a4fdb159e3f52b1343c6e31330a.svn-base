<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>新增学校新闻</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
	 	<link href="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
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
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="<%=basePath %>schoolNews/toAddSchoolNews.do">系统管理</a><i class="fa fa-circle"></i></li>
                            <li><a href="<%=basePath %>schoolNews/toAddSchoolNews.do">学校新闻管理</a><i class="fa fa-circle"></i></li>
                            <li><span>新增学校新闻</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">新增学校新闻</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="<%=basePath %>schoolNews/doAddSchoolNews.do" class="form-horizontal" method="post" id="submitForm" enctype="multipart/form-data">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">新闻标题</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input name="title" type="text" class="form-control" id="title" value="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">新闻内容</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<textarea name="content" id="content" rows="5" class="form-control" ></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">新闻图片</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new">选择图片</span>
                                                                <span class="fileinput-exists">换一张</span>
                                                                <input type="file" id="file" name="imgPath"></span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                                        </div>
                                                	</div>
												</div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<c:if test="${sessionScope.user.type != 2}">
														<button class="btn green" id="submitButton" type="button">保存</button>
													</c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- END FORM-->
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
        <script src="<%=basePath %>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(function(){
		loadSubMenu("schoolManager"); 
		//选取当前菜单位置
		setActive("schoolManager","schoolNewsManage"); 
		
		
		$("#submitButton").click(function(){
			 if(checkForm())
			 {
				 $("#submitForm").submit();
			 }
		});
	})
	
	function checkForm()
	{
		var titleFlag = true;
		var contentFlag = true;
		var title = $("#title").val();
		var content = $("#content").val();
		if(title == "")
		{
			layer.msg("新闻标题不能为空");
			titleFlag = false;
		}else
		{
			titleFlag = true;
		}
		
		if(content == "")
		{
			layer.msg("新闻内容不能为空");
			contentFlag = false;
		}else
		{
			contentFlag = true;
		}
		
		if(titleFlag && contentFlag)
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