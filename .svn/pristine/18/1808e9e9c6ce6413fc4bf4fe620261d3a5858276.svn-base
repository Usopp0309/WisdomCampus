<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>请假申请</title>
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
                            <li><a href="">信息平台</a><i class="fa fa-circle"></i></li>
                            <li><span>请假申请</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">请假申请</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>leave/doAddLeave.do" class="form-horizontal" method="post" id="form1" name="form1">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">申请人</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" name="applyUserId"  tabindex="1" id="applyPersonSelect"></select>
	                                        		<span class="help-inline" style="display: none;" id="applyPersonHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">请假开始时间</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="startTime" id="startTime"  class="form-control" readonly="readonly"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">请假结束时间</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="endTime" id="endTime"  class="form-control"readonly="readonly"/>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="control-label col-md-3">请假类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" tabindex="1" name="type">
														<option value="0">事假</option>
														<option value="1">病假</option>
														<option value="2">产假</option>
														<option value="3">出差</option>
													</select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">审核人：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control select2me m_select" name="auditId"  tabindex="1" id="auditSelect"></select>
	                                        		<span class="help-inline" style="display: none;" id="auditHelp"></span>
                                                </div>
                                            </div>
                                            <h3 class="form-section">请假事由</h3>
                                             <div class="form-group">
                                                <label class="control-label col-md-3">请假事由：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <textarea class="form-control" rows="5" name="remark" id="remark"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                	<input type="hidden" value="${user.userId}" name="userId" id="userId"/>
													<input type="hidden" value="${roleCode}" name="roleCode" id="roleCode"/>
                                                    <button type="button" class="btn green" onclick="submit1();">申请</button>
                                                    <button type="button" class="btn" id="cancel">返回</button>
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
			loadSubMenu("leave"); 
			//选取当前菜单位置
			setActive("leave","applyLeave"); 
			$('#startTime,#endTime').datetimepicker({
				format:'Y-m-d H:i'
			});   
			var roleCode = $("#roleCode").val();
			var userId = $("#userId").val();
			getApplyPerson(roleCode,userId);
			
			var applyPersonId = $("#applyPersonSelect").val();
			getAuditPerson(roleCode,applyPersonId);

			//申请人改变 对应的审核人也将会改变（主要针对一个家长有多个小孩）
			$("#applyPersonSelect").change(function(){
				var personId = $("#applyPersonSelect").val();
				getAuditPerson(roleCode,personId);
			});

			//审核人
			$("#auditSelect").blur(function(){
				var auditSelect = $("#auditSelect").val();
				//未输入手机号码
				if ("" == auditSelect || 0 == auditSelect)
				{
					layer.tips('请选择审核人', '#auditSelect');
				}
			});

		});


		//加载申请人
		function getApplyPerson(roleCode,userId)
		{ 
			$.ajax({
				async: false,
				type: "post",
				url: "<%=basePath%>leave/getApplyPerson.do",
				data:{
					roleCode : roleCode,
					userId : userId
				},	
				success: function(data){
					var applyPerson = eval("(" + data + ")");
					var applyPersonSelectHtml ;

					$.each(applyPerson, function(n, value) {  
						//select页面
						applyPersonSelectHtml += '<option value="' + value.userId + '">' + value.realName +' </option>';
                         
	          		});
          			$("#applyPersonSelect").html(applyPersonSelectHtml);
          			
				},
			});
		} 

		//加载审核人
		function getAuditPerson(roleCode,applyPersonId)
		{ 
			$.ajax({
				type: "post",
				url: "<%=basePath%>leave/getAuditPerson.do",
				data:{
					roleCode : roleCode,
					applyPersonId : applyPersonId
				},	
				success: function(data){
					var auditPerson = eval("(" + data + ")");
					//年级select页面html
					var auditPersonSelectHtml = '<option value="0">--请选择--</option>';
					$.each(auditPerson, function(n, value) {  
						//select页面
						auditPersonSelectHtml += '<option value="' + value.userId + '">' + value.realName +' </option>';
	          		});
					
					var auditSelect= $("#auditSelect").val();
					if(auditSelect==null || auditSelect==''){
						auditSelect="--请选择--";
					}
	          		$("#select2-auditSelect-container").attr("title",auditSelect);
	          		$("#select2-auditSelect-container").text(auditSelect)
	          		
          			$("#auditSelect").html(auditPersonSelectHtml);
				},
			});
		} 

	    function check(){
	        var startTime = $("#startTime").val();
	        var endTime = $("#endTime").val();
	        var remark = $("#remark").val();
	        
	        if ("" == startTime){
	            layer.tips('请假开始日期不能为空', '#startTime');
	            return false;
	        }
	        if ("" == endTime){
	            layer.tips('请假结束日期不能为空', '#endTime');
	            return false;
	        }
	        var startMill = (new Date(startTime)).getTime();
	        var endMill = (new Date(endTime)).getTime();
	        if(endMill < startMill){
		        layer.tips('请假结束日期不能小于开始日期', '#endTime');
		        return false;
	        }
	        
	        var auditSelect = $("#auditSelect").val();
			//未输入手机号码
			if ("" == auditSelect || 0 == auditSelect)
			{
				layer.tips('请选择审核人', '#auditSelect');
				return false;
			}
			
	        if ("" == remark){
	            layer.tips('请假事由不能为空', '#remark');
	            return false;
	        }
	       
	        return true;
	    }
	    function submit1(){
               if(check()){
                $("#form1").submit();
              }
		    }
	</script>
</html>