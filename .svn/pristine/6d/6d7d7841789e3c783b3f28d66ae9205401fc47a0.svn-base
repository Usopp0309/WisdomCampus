<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>修改作息时间表</title>
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
                            <li><span>修改作息时间表</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">修改作息时间表</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">修改作息时间表</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>schedule/doEditSchedule.do" class="form-horizontal" id="addForm" method="post">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">作息时间：</label>
                                                <div class="col-md-4">
                                                   <input class="form-control" type="text" id="liveingDate" name="liveingDate" readonly="readonly"value="${liveingDate }" />
                                                </div>
                                            </div>
                                            
                                         <c:forEach items="${list }" var="schedule">
                                         	<div class="form-group">
                                                <label class="control-label col-md-3">选择类型：</label>
                                                <div class="col-md-4">
                                                   <select class="form-control" tabindex="1" name="status" id="status" value="${schedule.status }">
														<option value="0" <c:if test="${schedule.status==0 }">selected="selected"</c:if> >上课</option>
														<option value="1" <c:if test="${schedule.status==1 }">selected="selected"</c:if> >休息</option>
													</select>
												</div>
                                            </div>

									
									<c:if test="${schedule.type eq 0 }">
									        <div class="form-group">
                                                <label class="control-label col-md-3">上午：</label>
                                                <div class="col-md-4">
                                                   <input type="checkbox" class="form-control" checked="checked" value="morning" id="morning" name="timeCheckBox"/> 
												</div>
                                            </div>
									        <div class="form-group" id="morningBeginGroup">
                                                <label class="control-label col-md-3">起始时间：</label>
                                                <div class="col-md-4">
                                                    <input class="form-control" type="text" name="amstarttime" id="morningBeginVal" value="${schedule.amStartTime}"/> 
													<span class="help-block" id="morningBeginHelp"></span>
												</div>
											</div>
									        <div class="form-group" id="morningEndGroup">
                                                <label class="control-label col-md-3">起始时间：</label>
                                                <div class="col-md-4">
                                                    <input class="form-control" type="text" name="amendtime" id="morningEndVal" value="${schedule.amEndTime}" /> 
												 	<span class="help-block" id="morningEndHelp"></span>
												</div>
											</div>
									        <div class="form-group">
                                                <label class="control-label col-md-3">下午：</label>
                                                <div class="col-md-4">
                                                    <input type="checkbox" class="form-control"  checked="checked" value="afternoon" id="afternoon" name="timeCheckBox"/>
												</div>
											</div>
									        <div class="form-group" id="afternoonBeginGroup">
                                                <label class="control-label col-md-3">起始时间：</label>
                                                <div class="col-md-4">
                                                   <input class="form-control" type="text" name="pmstarttime" id="afternoonBeginVal" value="${schedule.pmStartTime}"/>
												   <span class="help-block" id="afternoonBeginHelp"></span>
												</div>
											</div>
									        <div class="form-group" id="afternoonEndGroup">
                                                <label class="control-label col-md-3">结束时间：</label>
                                                <div class="col-md-4">
                                                   <input class="form-control" type="text" name="pmendtime" id="afternoonEndVal" value="${schedule.pmEndTime}" />
												   <span class="help-block" id="afternoonEndHelp"></span>
												</div>
											</div>
									        <div class="form-group">
                                                <label class="control-label col-md-3">晚上：</label>
                                                <div class="col-md-4">
                                                   <input type="checkbox" value="night" checked="checked"  class="form-control" id="night" name="timeCheckBox"/> 
												</div>
											</div>
									        <div class="form-group" id="nightBeginGroup">
                                                <label class="control-label col-md-3">起始时间：</label>
                                                <div class="col-md-4">
                                                   <input class="form-control" type="text" name="nightstarttime" id="nightBeginVal" value="${schedule.nightStartTime}" />
													<span class="help-block" id="nightBeginHelp"></span>
												</div>
											</div>
									        <div class="form-group" id="nightEndGroup">
                                                <label class="control-label col-md-3">结束时间：</label>
                                                <div class="col-md-4">
                                                   <input class="form-control" type="text" name="nightendtime" id="nightEndVal" value="${schedule.nightEndTime}" /> 
												   <span class="help-block" id="nightEndHelp"></span>
												</div>
											</div>
									</c:if>
									<c:if test="${schedule.type eq 1 }">
										<div class="form-group" id="nightEndGroup">
                                                <label class="control-label col-md-3">起始时间：</label>
                                                <div class="col-md-4">
                                                   <input class="form-control" type="text" name="beginTime" id="beginTime" value="${schedule.beginTime}" data-default-value="${schedule.beginTime}"/>
												   <span class="help-block" id="beginHelp"></span>
												</div>
										</div>
										<div class="form-group" id="endGroup">
                                                <label class="control-label col-md-3">结束时间：</label>
                                                <div class="col-md-4">
                                                   <input class="form-control" type="text" name="endTime" id="endTime" value="${schedule.endTime}" defaultTime="false"/>
													<span class="help-inline" id="endHelp"></span>
												</div>
										</div>
										
									</c:if>
									<input type="hidden" name="scheduleId" id="scheduleId" value="${schedule.id }" />
									<input type="hidden" value="${liveingDate}" name="liveingDate" id="liveingDateHidden" />
								</c:forEach>
                                      
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green" id="save">确定</button>
                                                    <button type="button" class="btn default">取消</button>
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
		jQuery(document).ready(function() {
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","scheduleManage"); 
			$('#morningBeginVal,#morningEndVal,#afternoonBeginVal,#afternoonEndVal,#nightBeginVal,#nightEndVal,#beginTime,#endTime').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			}); 
			//表单提交
			$("#save").click(function() {
				if (checkForm()) {
					$("#addForm").submit();
				}
			});
			 $("#morning").change(function() {
			      if(!$(this).is(':checked')){
			    	  $("#morningBeginVal").val("");
			    	  $("#morningEndVal").val("");
			    	  $("#morningBeginGroup").hide();
			    	  $("#morningEndGroup").hide();
			      }else{
			    	  $("#morningBeginGroup").show();
			    	  $("#morningEndGroup").show();
			      }
			    });
			 
			 $("#afternoon").change(function() {
			      if(!$(this).is(':checked')){
			    	  $("#afternoonBeginVal").val("");
			    	  $("#afternoonEndVal").val("");
			    	  $("#afternoonBeginGroup").hide();
			    	  $("#afternoonEndGroup").hide();
			      }else{
			    	  $("#afternoonBeginGroup").show();
			    	  $("#afternoonEndGroup").show();
			      }
			    });
			 $("#night").change(function() {
			      if(!$(this).is(':checked')){
			    	  $("#nightBeginVal").val("");
			    	  $("#nightEndVal").val(""); 
			    	  $("#nightBeginGroup").hide();
			    	  $("#nightEndGroup").hide();
			      }else{
			    	  $("#nightBeginGroup").show();
			    	  $("#nightEndGroup").show(); 
			      }
			    });
		});
		//表单验证
		function checkForm() {
			//验证常量
			var morningBeginFlag = true;
			var afternoonBeginFlag = true;
			var morningEndFlag = true;
			var afternoonEndFlag = true;
			var nightBeginFlag = true;
			var nightEndFlag = true;
            var beginTime=$("#beginTime").val();
            var endTime=$("#endTime").val();
            if(beginTime!="" && endTime!=""){
            		if (!checkTime(beginTime, endTime)) {
						layer.tips('开始时间不能大于结束时间', '#endTime');
						return false;
					}
            }
			//上午时间
			if ($("#morning").is(':checked')) {
				var morningBegin = $("#morningBeginVal").val();
				//未输入结束时间

				if ("" == morningBegin) {
					layer.tips('请选择上午起始时间', '#morningBeginVal');
					return false;

				} else {
					morningBeginFlag = true;
				}
				var morningEnd = $("#morningEndVal").val();
				//未输入结束时间

				if ("" == morningEnd) {
					layer.tips('请选择上午结束时间', '#morningEndVal');
					return false;
				} else if ("" != morningBegin) {
					if (!checkTime(morningBegin, morningEnd)) {
						layer.tips('上午开始时间不能大于结束时间', '#morningEndVal');
						return false;
					} else {
						morningEndFlag = true;
					}

				}

			}
			//下午时间
			if ($("#afternoon").is(':checked')) {
				var afternoonBegin = $("#afternoonBeginVal").val();
				//未输入结束时间
				if ("" == afternoonBegin) {
					layer.tips('请选择下午起始时间', '#afternoonBeginVal');
					return false;
				} else {
				
					afternoonBeginFlag = true;
				}
				var afternoonEnd = $("#afternoonEndVal").val();
				//未输入结束时间
				if ("" == afternoonEnd) {
					layer.tips('请选择下午结束时间', '#afternoonEndVal');
					return false;
				} else {
					afternoonEndFlag = true;
				}
				if (!checkTime(afternoonBegin, afternoonEnd)) {
					layer.tips('下午开始时间不能大于结束时间', '#afternoonEndVal');
					return false;
				} else {
					afternoonEndFlag = true;
				}
				if(!checkTime(morningEnd, afternoonBegin)){
					layer.tips('下午开始时间不能小于上午结束时间', '#afternoonEndVal');
					return false;
				}else{
					afternoonBeginFlag=true;
				}
			}

			//晚上时间
			if ($("#night").is(':checked')) {
				var nightBegin = $("#nightBeginVal").val();
				//未输入结束时间
				if ("" == nightBegin) {
					layer.tips('请选择晚上起始时间', '#nightBeginVal');
					return false;
				} else {
					nightBeginFlag = true;
				}
				var nightEnd = $("#nightEndVal").val();
				//未输入结束时间
				if ("" == nightEnd) {
					layer.tips('请选择晚上结束时间', '#nightEndVal');
					return false;
				} else {
					nightEndFlag = true;
				}
				if (!checkTime(nightBegin, nightEnd)) {
					layer.tips('晚上开始时间不能大于结束时间', '#nightEndVal');
					return false;
				} else {
					nightEndFlag = true;
				}
				if(!checkTime(afternoonEnd, nightBegin)){
					layer.tips('晚上开始时间不能小于下午结束时间', '#nightBeginVal');
					return false;
				}else{
					afternoonBeginFlag=true;
				}
			}
			var m=checkSchedule();
			if(m.flag=="1"){
				layer.tips(m.msg, '#startTime');
				return;
			}
			//reSetIframeHeight();
			if (morningBeginFlag && afternoonBeginFlag && morningEndFlag
					&& afternoonEndFlag && nightBeginFlag && nightEndFlag) {
				return true;
			} else {
				return false;
			}

		}
		//验证相关的时间比较
		function checkTime(startTime, endTime) {
			var flg = false;
			if (startTime > endTime || startTime > endTime) {
				flg = false;
			} else {
				flg = true;
			}
			return flg;
		}
		//检查作息时间
		function checkSchedule(){
			var m="";
			var s=$("#startTime").val();
			var e=$("#endTime").val();
			var scheduleId=$("#scheduleId").val();
			$.ajax({
	            url:"<%=basePath%>schedule/checkScheule.do",
	            type:"post",
	            async: false,
	            dataType:"json",
	            data:{"beginTime":s,"endTime":e,"scheduleId":scheduleId},
	            error:function(){},
	            success:function(data){
	               m=data;
	             }
				});
			return m;
			}
	</script>
</body>
</html>