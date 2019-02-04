<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>修改电子卡</title>
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
                            <li><span>修改电子卡</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">修改电子卡</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>card/doModifyCard.do" class="form-horizontal" id="formAction">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">电子卡：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" readonly="readonly" name="code"  id="code" value="${card.cardCode}" class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">状态：</label>
                                                <div class="col-md-9 col-lg-4">
	                                                <select name="status" id="status" class="form-control" value="${card.status}">
											      		<option value="1" <c:if test="${card.status==1}">selected="selected"</c:if> >启用</option>
											      		<option value="0" <c:if test="${card.status==0}">selected="selected"</c:if> >禁用</option>
											      		<option value="2" <c:if test="${card.status==2}">selected="selected"</c:if> >失效</option>
											      	</select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn design_btn" onclick="checkForm()">确定</button>
                                                    <button type="button" class="btn back_btn" onclick="history.go(-1);">返回</button>
                                                    <input type="hidden" value="${cardId}" name="cardId" id="cardId"/>
													<input type="hidden" value="${user.userId}" name="userId"/>
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

		$(function() {  
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","cardManage");   
		});
		
		function checkForm(){
			$("#formAction").submit();
		}
	</script>
</html>