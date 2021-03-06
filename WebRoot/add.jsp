<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>测试</title>
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
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content m_overflow_hidden m_page_content">
                	
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">系统管理</a><i class="fa fa-circle"></i></li>
                            <li><span>地点管理</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">添加地点</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                        	<div class="m_margin_0_0_15_0">
                        		<ul class="nav nav-tabs">
                                    <li class="active">
                                        <a data-toggle="tab" aria-expanded="true">哈哈（老师）</a>
                                    </li>
                                    <li class="">
                                        <a data-toggle="tab" aria-expanded="false">哈哈（家长）</a>
                                    </li>
                                    <li class="">
                                        <a data-toggle="tab" aria-expanded="false">哈哈(学生)</a>
                                    </li>
                                </ul>
                            </div>
                            
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">填写类别一</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="#" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">属性1</label>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control" id="inputWarning" />
                                                    <span class="help-block">错误提示</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">属性2</label>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control" id="inputError" />
                                                    <span class="help-block">错误提示</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">属性3</label>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control" id="inputSuccess" /> </div>
                                            </div>
                                            <h3 class="form-section">填写类别二</h3>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">属性4</label>
                                                <div class="col-md-4">
                                                    <div class="input-icon right">
                                                        <i class="fa fa-exclamation tooltips" data-original-title="please write a valid email"></i>
                                                        <input type="text" class="form-control" /> </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">属性4</label>
                                                <div class="col-md-4">
                                                    <div class="input-icon right">
                                                        <i class="fa fa-warning tooltips" data-original-title="please write a valid email"></i>
                                                        <input type="text" class="form-control" /> </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">属性5</label>
                                                <div class="col-md-4">
                                                    <div class="input-icon right">
                                                        <i class="fa fa-check tooltips" data-original-title="success input!"></i>
                                                        <input type="text" class="form-control" /> </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="submit" class="btn green">确定</button>
                                                    <button type="button" class="btn default">取消</button>
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

</html>