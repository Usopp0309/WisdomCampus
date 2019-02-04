<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>发送短信详情</title>
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
                            <li><span>发送短信详情</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">发送短信详情</span>
                                    </div>
                                </div>
                                <div class="portlet-body form-horizontal">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">发件人</label>
                                                <div class="col-md-9 col-lg-4">
                                                     <input type="text" class="form-control" id="senderName" readonly="readonly"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">短信内容</label>
                                                <div class="col-md-9 col-lg-7">
                                                    <textarea class="form-control" id="message" readonly="readonly"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">收件人</label>
                                                <div class="col-md-9 col-lg-9">
                                                     <div id="announcementContent" readonly="readonly"></div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">发件日期</label>
                                                <div class="col-md-9 col-lg-4">
                                                     <input type="text" class="form-control" id="date" readonly="readonly"/>
                                                </div>
                                            </div>
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
	<script type="text/javascript">

		$(function() {    
			loadSubMenu("informationPlatform"); 
			//选取当前菜单位置
			setActive("informationPlatform","smsShow");  
			var messageId = $("#messageId").val();
			//加载短信信息
			loadSmsDetailInfo(messageId);
		
		});

		//加载短信详细基本信息
		function loadSmsDetailInfo(messageId)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>sms/loadSmsDetail.do",
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
		        	{
			        	if(value.status==0)
			        	{
			        		messagename+='<span>['+value.receiverName+'|'+value.phone+'<b class="font-green-sharp">(成功)</b>,]</span>';
			        	}  
			        	else if(value.status==2)
			        	{
			        		messagename+='<span>['+value.receiverName+'|'+value.phone+'<b class="font-red-mint">(失败：未交服务费)</b>,]</span>';
			        	}
			        	else
			        	{
			        		messagename+='<span>['+value.receiverName+'|'+value.phone+'<b class="font-red-mint">(失败)</b>,]</span>';
			        	} 
		        	});
		        	$("#announcementContent").html(messagename);
		        	$("#senderName").val(name);
		        	$("#message").html(messagedetail);
		        	$("#date").val(messagedate);
		        }
			});
		}

	</script>
	</html>