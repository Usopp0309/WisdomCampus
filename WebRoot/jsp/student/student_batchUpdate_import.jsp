<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>批量更新人员</title>
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
            <div class="page-content-wrapper">
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
                            <li><span>批量更新人员</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">批量更新人员</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">人员导入</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                   <form action="<%=basePath%>userBatchUpdateImport/batchUpdate.do" class="form-horizontal" id="form1" name="form1" method="post" enctype="multipart/form-data">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">导入文件</label>
                                                <div class="col-md-4">
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
		                                                <div class="input-group input-large">
		                                                    <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
		                                                        <i class="fa fa-file fileinput-exists"></i>&nbsp;
		                                                        <span class="fileinput-filename"> </span>
		                                                    </div>
		                                                    <span class="input-group-addon btn default btn-file">
		                                                        <span class="fileinput-new">选择文件</span>
		                                                        <span class="fileinput-exists">换一个</span>
		                                                        <input type="file" name="inputFile" accept="application/vnd.ms-excel"> </span>
		                                                    <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput">移除</a>
		                                                </div>
													</div>
                                                </div>
                                            </div>
                                            <span>${errorMsg}</span>
											<input type="hidden" value="${userId}" name="userId" id="userId"/>
											<span class="help-block" style="" id="codeHelp">${errormsg}</span>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green" onclick="batchUpdateImport();">导入</button>
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
 		<script src="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
		<script  type="text/javascript" src="<%=basePath%>assets/global/plugins/layer/layer.js"></script>
	<script>
	   var indexlayer =null;
		$(function() {    
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","studentParentManage");  
			 var code=$("#codeHelp").val();
             if(code!=""){
              layer.close(indexlayer);	 
             }
		});
		function batchUpdateImport(){
			 indexlayer = layer.msg('正在导入信息,请稍候。。。',{icon: 16,time:0,shade:0.3,offset:['200px', '40%']});
			 $("#form1").submit();
  	</script>
</html>