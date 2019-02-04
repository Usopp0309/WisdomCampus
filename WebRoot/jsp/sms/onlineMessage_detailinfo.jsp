<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>留言详情</title>
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
                            <li><a href="">信息平台</a><i class="fa fa-circle"></i></li>
                            <li><span>留言详情</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">留言详情</span>
                                    </div>
                                </div>
                                <div class="portlet-body form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">发送人</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" class="form-control" id="name" readonly="readonly" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" >短信内容</label>
                                                <div class="col-md-9 col-lg-8">
                                                   <textarea rows="" id="message" cols=""class="form-control"  readonly="readonly"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">收件人</label>
                                                <div class="col-md-9 col-lg-8">
                                                    <textarea rows="" id="announcementContent" class="form-control" cols=""  readonly="readonly"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">发送日期</label>
                                                <div class="col-md-9 col-lg-4">
                                                        <input type="text" class="form-control" class="form-control" id="date"  readonly="readonly"/>
                                                        <input type="hidden" value="${id}" id="messageId">
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

</html>

	<script type="text/javascript">
		$(function() {    
			loadSubMenu("informationPlatform"); 
			//选取当前菜单位置
			setActive("informationPlatform","onlineMessageShow");  
			var messageId = $("#messageId").val();
			//加载在线留言详细信息
			loadOnlineMessageInfo(messageId);
			
		});

		//加载在线留言详细信息
		function loadOnlineMessageInfo(messageId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>online-message/loadSmsListDetail.do",
				data:
				{
					messageId : messageId
				},
		        success:function(data){
		        	var message = eval("(" + data + ")");
		        	var messagename='' ;
		        	var messagedate=message[0].sentTime;
		        	var name=message[0].senderName;
		        	var messagedetail=message[0].content;
		        	
		        	$.each(message, function(n, value) 
		        	{   if(0 == value.status)
		        	    {
		        	        messagename+='['+value.receiverName+'(已读)]，';
		        	    }
		        	    else if(1 == value.status)
		        	    {
		        	        messagename+='['+value.receiverName+'(未读)]，';
		        	    }
		        	});
		        	$("#announcementContent").html(messagename);
		        	$("#name").val(name);
		        	$("#message").html(messagedetail);
		        	$("#date").val(messagedate);
		        }
			});
		}


	</script>
</html>