<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>维修列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<style type="text/css">
 	.modal-content{display: none;}
 	</style>
</head>
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
	<input class="themes" type="hidden" value="<%=ThemePath%>">
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
           		<!-- 页面内容开始 -->
            	<div class="col-md-12 col-sm-12 m_page_con">
                <div class="page-bar m_margin_0_0_0_0">
                    <ul class="page-breadcrumb">
                        <li><a href="<%=basePath%>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                    <li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i class="fa fa-circle"></i></li>
                        <li><span>维修列表</span></li>
                    </ul>
                </div>
                <h3 class="page-title">维修列表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<r:right rightCode="assetRepairListManager">
											<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
												<li class="roleLi">
													<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
												</li>
											</c:if>
										</r:right>
									</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">资产类型：</span>
	                         		<select class="form-control m_select" id="type">
                                    </select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">维修状态：</span>
	                         		<select class="form-control m_select" id="status">
	                         			<option value="">全部</option>
	                         			<option value="0">待处理</option>
	                         			<option value="1">已领取工单</option>
	                         			<option value="2">已同意维修</option>
	                         			<option value="3">已拒绝维修</option>
	                         			<option value="4">维修完成</option>
                                    </select>
	                         	</div>
		                         <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
			                         <button type="button" id="search" class="btn green">查找</button>
		                         </div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>维修列表</div>
	                            </div>
	                            <div class="portlet-body">
	                                <table class="table table-bordered table-hover" id="listTable">
	                                
	                                </table>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                        <!-- 分页开始 -->
	                        <%@include file="/public_module/public_page.jsp" %>
	                        <!-- 分页结束 -->
	                        <!-- 弹窗开始  大小参数：modal-lg, modal-sm-->
						    <div class="modal fade" id="small" tabindex="-1" role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-lg">
						            <div class="modal-content guanlirenyuan">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">报修详情</h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                	<div class="row m_margin_10_auto search_box">
						                		<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">报修人</span><input class="m_input form-control" disabled="disabled" id="repairman1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">报修人号码</span><input class="m_input form-control" disabled="disabled" id="repairmanphone1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">维修类型</span><input class="m_input form-control" disabled="disabled" id="typeName1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产名称</span><input class="m_input form-control" disabled="disabled" id="assetName1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">报修时间</span> <input class="m_input form-control" disabled="disabled" id="repairTime1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">状态</span><input class="m_input form-control" disabled="disabled" id="statusName1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">维修人员</span><input class="m_input form-control" disabled="disabled" id="serviceman1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">维修估价</span><input class="m_input form-control" disabled="disabled" id="repairPrice1" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">预估完成时间</span><input class="m_input form-control estimatedTime" disabled="disabled" id="estimatedTime1" type="text">
					                         	</div>
					                         </div>
					                         <hr class="m_hr">
					                         <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
					                         		<span class="m_display_inline m_float_left m_width_10">问题描述</span>
					                         		<textarea class="m_width_90 m_float_left form-control" disabled="disabled" id="remark1"></textarea>
					                         	</div>
					                         </div>
					                         <div class="row m_margin_10_auto search_box" id="auditRemarkGroup">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
					                         		<span class="m_display_inline m_float_left m_width_10">审核意见</span>
					                         		<textarea class="m_width_90 m_float_left form-control" id="auditRemark"></textarea>
					                         	</div>
					                         </div>
					                         <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
					                         		<span class="m_display_inline m_float_left m_width_10">图片</span>
					                         		<div class="m_width_90 m_float_left repair_img" id="repairImg1">
					                         		</div>
					                         	</div>
					                         </div>
						                </div>
						                <div class="modal-footer">
						                    <button type="button" class="btn green" id="reminder1" data-dismiss="modal" onclick="reminder()">催单</button>
						                    <button type="button" class="btn green" id="agreeRepair1" onclick="agreeRepair()" data-dismiss="modal">同意维修</button>
						                    <button type="button" class="btn red" id="refuseRepair1" onclick="refuseRepair()" data-dismiss="modal">拒绝维修</button>
						                    <button type="button" class="btn" data-dismiss="modal">返回</button>
						                </div>
						            </div>
						            <div class="modal-content weixiurenyuan">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">报修详情</h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                	<div class="row m_margin_10_auto search_box">
						                		<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">报修人</span><input class="m_input form-control" disabled="disabled" id="repairman2" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">报修人号码</span><input class="m_input form-control" disabled="disabled" id="repairmanphone2" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">维修类型</span><input class="m_input form-control" disabled="disabled" id="typeName2" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产名称</span><input class="m_input form-control" disabled="disabled" id="assetName2" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">报修时间</span> <input class="m_input form-control" disabled="disabled" id="repairTime2" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">状态</span><input class="m_input form-control" disabled="disabled" id="statusName2" type="text">
					                         	</div>
					                         </div>
					                         <hr class="m_hr">
					                         <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
						                         		<span class="m_display_inline m_float_left m_width_10">问题描述</span>
						                         		<textarea class="m_width_90 m_float_left form-control" disabled="disabled" id="remark2"></textarea>
					                         	</div>
					                         </div>
					                          <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">维修估价</span>
					                         		<input class="m_input form-control" id="repairPrice2" type="number">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">预估完成时间</span>
					                         		<input class="m_input form-control estimatedTime" id="estimatedTime2" type="text">
					                         	</div>
					                         </div>
					                         <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
						                         		<span class="m_display_inline m_float_left m_width_10">图片</span>
						                         		<div class="m_width_90 m_float_left repair_img" id="repairImg2">
						                         		</div>
					                         	</div>
					                         </div>
						                </div>
						                <div class="modal-footer">
						                	<button type="button" class="btn green" id="reminder2" data-dismiss="modal" onclick="reminder()">催单</button>
						                    <button type="button" class="btn green" data-dismiss="modal" id="startRepair" onclick="startRepair()">领取工单 </button>
						                    <button type="button" class="btn green" data-dismiss="modal" id="finishRepair" onclick="finishRepair()">维修完成 </button>
						                    <button type="button" class="btn" data-dismiss="modal">返回</button>
						                </div>
						            </div>
						            <div class="modal-content baoxiurenyuan">
						            
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">报修详情</h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                	<div class="row m_margin_10_auto search_box">
						                		<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产类型</span><input class="m_input form-control" disabled="disabled" id="typeName3" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产名称</span><input class="m_input form-control" disabled="disabled" id="assetName3" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">报修时间</span> <input class="m_input form-control" disabled="disabled" id="repairTime3" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">状态</span><input class="m_input form-control" disabled="disabled" id="statusName3" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">维修人员</span><input class="m_input form-control" disabled="disabled" id="serviceman3" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">维修估价</span><input class="m_input form-control" disabled="disabled" id="repairPrice3" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">预估完成时间</span><input class="m_input form-control estimatedTime" disabled="disabled" id="estimatedTime3" type="text">
					                         	</div>
					                         						                         	
					                         </div>
					                         <hr class="m_hr">
					                         <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
						                         		<span class="m_display_inline m_float_left m_width_10">问题描述 </span>
						                         		<textarea class="m_width_90 m_float_left form-control" disabled="disabled" id="remark3"></textarea>
					                         	</div>
					                         </div>
					                         <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
						                         		<span class="m_display_inline m_float_left m_width_10">图片</span>
						                         		<div class="m_width_90 m_float_left repair_img" id="repairImg3">
						                         		</div>
					                         	</div>
					                         </div>
						                </div>
						                <div class="modal-footer">
						                    <button type="button" class="btn green" data-dismiss="modal" id="reminder3" onclick="reminder()" >催单</button>
						                    <button type="button" class="btn" data-dismiss="modal">返回</button>
						                </div>
						            </div>
						        </div>
						    </div>
						    <!-- 弹窗结束 -->
	                    </div>
	                </div>
	                </div>
	                <!--页面内容结束 -->
	                <input type="hidden" id="repairId" value="">
	            </div>
	        </div>
	        <input type="hidden" id="userId" value="${sessionScope.user.userId}"/>	
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
	
	$(function(){
		$('.estimatedTime').datetimepicker({format:'Y-m-d',timepicker:false}); 
		//选取当前菜单位置
		setActive("assetManagement","assetRepairList"); 
		loadTyepList();
		loadAssetRepairList(null, null, null);
		//条件查询
		$("#search").click(function(){
			var status = $("#status").val();
			var type = $("#type").val();
			loadAssetRepairList(status, type, null);
		});
   	})
   	
	function getmodelname(name,num,status,id)
	{
		$(".modal-content").removeAttr("style");
		$("."+name).show();
		$("#repairId").val(id);
		$("#refuseRepair1").removeAttr("data-dismiss");
		$("#startRepair").removeAttr("data-dismiss");
		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/getAssetRepairDetailById.do",
			data:{
				id : id
			},
			success: function(data){
				var asset = eval("(" + data + ")");
				if(num == 1)
				{
					if(status == 0 || status == 2)
					{
						$("#reminder"+num).show();
						$("#agreeRepair"+num).hide();
						$("#refuseRepair"+num).hide();
					}
					else if(status == 1)
					{
						$("#reminder"+num).hide();
						$("#agreeRepair"+num).show();
						$("#refuseRepair"+num).show();
					}
					else 
					{
						$("#reminder"+num).hide();
						$("#agreeRepair"+num).hide();
						$("#refuseRepair"+num).hide();
					}	
				}
				else if(num == 2 )
				{
					if(status == 0 && asset.servicemanId != $("#userId").val())
					{
						$("#reminder2").show();
						$("#startRepair").hide();
						$("#finishRepair").hide();
					}
					else if(status == 0 && asset.servicemanId == $("#userId").val())
					{
						$("#reminder2").hide();
						$("#startRepair").show();
						$("#finishRepair").hide();
					}
					else if(status == 1 && asset.userId == $("#userId").val())
					{
						$("#reminder2").show();
						$("#startRepair").hide();
						$("#finishRepair").hide();
					}
					else if(status == 1 && asset.userId != $("#userId").val())
					{
						$("#reminder2").hide();
						$("#startRepair").hide();
						$("#finishRepair").hide();
					}
					else if(status == 2 && asset.servicemanId == $("#userId").val())
					{
						$("#reminder2").hide();
						$("#startRepair").hide();
						$("#finishRepair").show();
					}
					else if(status == 2 && asset.userId == $("#userId").val() && asset.servicemanId != $("#userId").val())
					{
						$("#reminder2").show();
						$("#startRepair").hide();
						$("#finishRepair").hide();
					}
					else 
					{
						$("#reminder2").hide();
						$("#startRepair").hide();
						$("#finishRepair").hide();
					}	
				}
				else if(num == 3)
				{
					if(status == 0 ||status == 1 || status == 2 )
					{
						$("#reminder3").show();
					}
					else
					{
						$("#reminder3").hide();
					}
				}
				
				$("#repairman"+num).val(asset.realName);
				$("#repairmanphone"+num).val(asset.phone);
				$("#typeName"+num).val(asset.typeName);
				$("#assetName"+num).val(asset.assetName);
				$("#repairTime"+num).val(asset.createTime);
				$("#statusName"+num).val(asset.statusName);
				$("#serviceman"+num).val(asset.serviceman);
				$("#remark"+num).val(asset.remark);
				$("#auditRemark").val(asset.auditRemark);
				$("#repairPrice"+num).val(asset.repairPrice);
				$("#estimatedTime"+num).val(asset.estimatedTime);
				var imgList = asset.imgList;
				var appendHtml = '';
				if(imgList.length==0)
				{
         			appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/asset_null.jpg">';
         			appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/asset_null.jpg">';
				}
				else if(imgList.length==1)
				{
					for(var i=0;i<imgList.length;i++)
					{
						appendHtml += '<img src="'+imgList[i].path+'">';
					}
					appendHtml += '<img src="<%=basePath%>assets/global/img/m_img/asset_null.jpg">';
				}
				else
				{
					for(var i=0;i<imgList.length;i++)
					{
						appendHtml += '<img src="'+imgList[i].path+'">';
					}
				}
				
				$("#repairImg"+num).html(appendHtml);
			},
		});
	}
	
	function loadAssetRepairList(status, type, cPage)
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/getAssetRepairList.do",
			data:{
				status : status,
				type : type,
				pageSize : 20,
				page : cPage
			},
			success: function(data){
				var data = eval("(" + data + ")");
				var page = data.pages;
				var personnelType = data.personnelType;
				$("#currentPage").html(page.currentPage);
				$("#totalPage").html(page.totalPage);
				var appendHtml = '';
				appendHtml += '<thead class="flip-content">';
				appendHtml += '<tr>';
				if(personnelType == "leader")
				{
					appendHtml += '<th>报修人</th>';
					appendHtml += '<th>报修人号码</th>';
					appendHtml += '<th>资产名称</th>';
					appendHtml += '<th class="hidden-md hidden-sm">维修类型</th>';
					appendHtml += '<th>问题描述</th>';
				}else if(personnelType == "serviceman")
				{
					appendHtml += '<th>报修人</th>';
					appendHtml += '<th>报修人号码</th>';
					appendHtml += '<th>资产名称</th>';
					appendHtml += '<th class="hidden-md hidden-sm">维修类型</th>';
					appendHtml += '<th>问题描述</th>';
				}
				else
				{
					appendHtml += '<th>资产名称</th>';
					appendHtml += '<th>维修类型</th>';
					appendHtml += '<th>问题描述</th>';
					
				}
				appendHtml += '<th class="hidden-md hidden-sm">维修人员</th>';
				appendHtml += '<th class="hidden-md hidden-sm">报修时间</th>';
				appendHtml += '<th class="hidden-md hidden-sm">完成时间</th>';
				appendHtml += '<th>状态</th>';
				appendHtml += '<th>操作</th>';
				appendHtml += '</tr>';
				appendHtml += '</thead>';
				appendHtml += '<tbody>';
				$.each(page.list, function(n, value) {  
					if(personnelType == "leader")
					{
						appendHtml += '<tr>';
						appendHtml += '<td>'+value.realName+'</td>';
						appendHtml += '<td>'+value.phone+'</td>';
						appendHtml += '<td>'+value.assetName+'</td>';
						if(value.type == 0)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">水电设施</td>';
	   					}
	       				else if(value.type == 1)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">房屋建筑物</td>';
	   					}
	       				else if(value.type == 2)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">办公设备</td>';
	   					}
	       				else if(value.type == 3)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">网络信息</td>';
	   					}
	       				else if(value.type == 4)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">仪器设备</td>';
	   					}
	       				else if(value.type == 5)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">运输设备</td>';
	   					}else if(value.type == 6)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">体育用品</td>';
	   					}else
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">其他</td>';
	   					}
						var remark = value.remark;
						if(remark == undefined)
						{
							remark = "";
						}
						appendHtml += '<td>'+remark+'</td>';
						appendHtml += '<td class="hidden-md hidden-sm">'+value.serviceman+'</td>';
						appendHtml += '<td class="hidden-md hidden-sm">'+value.createTime+'</td>';
						var finishTime = value.finishTime;
						if(finishTime == undefined)
						{
							finishTime = "";
						}
						appendHtml += '<td>'+finishTime+'</td>';
						if(value.status == 0)
	   					{
	       					appendHtml += '<td style="color: #2066e2;">待处理</td>';
	   					}
	       				else if(value.status == 1)
	   					{
	       					appendHtml += '<td style="color: #ef5f5f;">已领取工单</td>';
	   					}
	       				else if(value.status == 2)
	   					{
	       					appendHtml += '<td style="color: #11bbb5;">已同意维修</td>';
	   					}
	       				else if(value.status == 3)
	   					{
	       					appendHtml += '<td style="color: #23c16b;">已拒绝维修</td>';
	   					}
	       				else
	   					{
	       					appendHtml += '<td style="color: #0a97af;">维修完成</td>';
	   					}
						appendHtml += '<td><a class="btn btn-sm green" data-toggle="modal" href="#small" onclick="getmodelname(\'guanlirenyuan\',1,'+value.status+','+value.id+')">详情</a></td>';
						appendHtml += '</tr>';
						
					}else if(personnelType == "serviceman")
					{
						appendHtml += '<tr>';
						appendHtml += '<td>'+value.realName+'</td>';
						appendHtml += '<td>'+value.phone+'</td>';
						appendHtml += '<td>'+value.assetName+'</td>';
						if(value.type == 0)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">水电设施</td>';
	   					}
	       				else if(value.type == 1)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">房屋建筑物</td>';
	   					}
	       				else if(value.type == 2)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">办公设备</td>';
	   					}
	       				else if(value.type == 3)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">网络信息</td>';
	   					}
	       				else if(value.type == 4)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">仪器设备</td>';
	   					}
	       				else if(value.type == 5)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">运输设备</td>';
	   					}else if(value.type == 6)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">体育用品</td>';
	   					}else
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">其他</td>';
	   					}
						var remark = value.remark;
						if(remark == undefined)
						{
							remark = "";
						}
						appendHtml += '<td>'+remark+'</td>';
						appendHtml += '<td class="hidden-md hidden-sm">'+value.serviceman+'</td>';
						appendHtml += '<td class="hidden-md hidden-sm">'+value.createTime+'</td>';
						var finishTime = value.finishTime;
						if(finishTime == undefined)
						{
							finishTime = "";
						}
						appendHtml += '<td class="hidden-md hidden-sm">'+finishTime+'</td>';
						if(value.status == 0)
	   					{
	       					appendHtml += '<td style="color: #2066e2;">待处理</td>';
	   					}
	       				else if(value.status == 1)
	   					{
	       					appendHtml += '<td style="color: #ef5f5f;">已领取工单</td>';
	   					}
	       				else if(value.status == 2)
	   					{
	       					appendHtml += '<td style="color: #11bbb5;">已同意维修</td>';
	   					}
	       				else if(value.status == 3)
	   					{
	       					appendHtml += '<td style="color: #23c16b;">已拒绝维修</td>';
	   					}
	       				else
	   					{
	       					appendHtml += '<td style="color: #0a97af;">维修完成</td>';
	   					}
						appendHtml += '<td><a class="btn btn-sm green" data-toggle="modal" href="#small" onclick="getmodelname(\'weixiurenyuan\',2,'+value.status+','+value.id+')">详情</a></td>';
						appendHtml += '</tr>';
					}
					else
					{
	                    appendHtml += '<tr>';
						appendHtml += '<td>'+value.assetName+'</td>';
						if(value.type == 0)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">水电设施</td>';
	   					}
	       				else if(value.type == 1)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">房屋建筑物</td>';
	   					}
	       				else if(value.type == 2)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">办公设备</td>';
	   					}
	       				else if(value.type == 3)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">网络信息</td>';
	   					}
	       				else if(value.type == 4)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">仪器设备</td>';
	   					}
	       				else if(value.type == 5)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">运输设备</td>';
	   					}else if(value.type == 6)
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">体育用品</td>';
	   					}else
	   					{
	       					appendHtml += '<td class="hidden-md hidden-sm">其他</td>';
	   					}
						
						var remark = value.remark;
						if(remark == undefined)
						{
							remark = "";
						}
						appendHtml += '<td>'+remark+'</td>';
						appendHtml += '<td class="hidden-md hidden-sm">'+value.serviceman+'</td>';
						appendHtml += '<td class="hidden-md hidden-sm">'+value.createTime+'</td>';
						var finishTime = value.finishTime;
						if(finishTime == undefined)
						{
							finishTime = "";
						}
						appendHtml += '<td class="hidden-md hidden-sm">'+finishTime+'</td>';
						if(value.status == 0)
	   					{
	       					appendHtml += '<td style="color: #2066e2;">待处理</td>';
	   					}
	       				else if(value.status == 1)
	   					{
	       					appendHtml += '<td style="color: #ef5f5f;">已领取工单</td>';
	   					}
	       				else if(value.status == 2)
	   					{
	       					appendHtml += '<td style="color: #11bbb5;">已同意维修</td>';
	   					}
	       				else if(value.status == 3)
	   					{
	       					appendHtml += '<td style="color: #23c16b;">已拒绝维修</td>';
	   					}
	       				else
	   					{
	       					appendHtml += '<td style="color: #0a97af;">维修完成</td>';
	   					}
						appendHtml += '<td><a class="btn btn-sm green" data-toggle="modal" href="#small" onclick="getmodelname(\'baoxiurenyuan\',3,'+value.status+','+value.id+')">详情</a></td>';
						appendHtml += '</tr>';
					}
      			}); 
				appendHtml += '</tbody>';
      			$("#listTable").html(appendHtml);
			},
		});
	}
	
	function loadTyepList()
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/getAssetTypeList.do",
			data:{
			},
			success: function(data){
				var list = eval("(" + data + ")");
                var appendHtml = '';
               	appendHtml += '<option value="">全部</option>';
				$.each(list, function(n, value) {  
       				appendHtml += '<option value="'+value.id+'">'+value.name+'</option>';
      			}); 
      			$("#type").html(appendHtml);
			},
		});
    }
	
	function reminder()
	{
		$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/repairReminder.do",
			data:{
				repairId : $("#repairId").val()
			},
			success: function(data){
				var data = eval("(" + data + ")");
				if(data)
				{
					layer.msg("催单成功，请耐心等待维修人员维修");
				}	
			},
		});
	}
	
	//同意维修
	function agreeRepair()
	{
		var auditRemark = $("#auditRemark").val();
		$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/modifyAssetRepair.do",
			data:{
				repairId : $("#repairId").val(),
				status : 2,
				auditRemark : auditRemark
			},
			success: function(data){
				var data = eval("(" + data + ")");
				if(data)
				{
					layer.msg("审核完成");
					loadAssetRepairList(null, null, null);
				}	
			},
		});
	}
	
	//拒绝维修
	function refuseRepair()
	{
		var auditRemark = $("#auditRemark").val();
		if(auditRemark == "")
		{
			layer.tips('审核意见不能为空', '#auditRemark');
			return;
		}
		$("#refuseRepair1").attr("data-dismiss","modal");
		$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/modifyAssetRepair.do",
			data:{
				repairId : $("#repairId").val(),
				status : 3,
				auditRemark : auditRemark
			},
			success: function(data){
				var data = eval("(" + data + ")");
				if(data)
				{
					layer.msg("审核完成");
					loadAssetRepairList(null, null, null);
				}	
			},
		});
	}
	//领取工单
	function startRepair()
	{
		var repairPrice2 = $("#repairPrice2").val();
		
		if(repairPrice2 == "")
		{
			layer.tips('评估价格不能为空', '#repairPrice2');
			return;
		}else if(repairPrice2 < 0){
			layer.tips('评估价格不能小于0', '#repairPrice2');
			return;
		}
		var estimatedTime = $("#estimatedTime2").val();
		
		if(estimatedTime == "")
		{
			layer.tips('请选择预估完成时间', '#estimatedTime2');
			return;
		}
		$("#startRepair").attr("data-dismiss","modal");
		$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/modifyAssetRepair.do",
			data:{
				repairId : $("#repairId").val(),
				status : 1,
				repairPrice : repairPrice2,
				estimatedTime : estimatedTime
			},
			success: function(data){
				var data = eval("(" + data + ")");
				if(data)
				{
					layer.msg("领取工单成功,已提交至领导人审核，请耐心等待");
					loadAssetRepairList(null, null, null);
				}else{
					layer.msg("领取工单失败,预估完成时间不能早于报修时间");
				}
			},
		});
	}
	//维修完成
	function finishRepair()
	{
		$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/modifyAssetRepair.do",
			data:{
				repairId : $("#repairId").val(),
				status : 4
			},
			success: function(data){
				var data = eval("(" + data + ")");
				if(data)
				{
					loadAssetRepairList(null, null, null);
				}	
			},
		});
	}
	
	
	//分页相关
	function jumpPage(type)
	{
		var cPage = $("#currentPage").html();
		var totalPage = $("#totalPage").html();

		var cPageInt = parseInt(cPage);
		var totalPageInt = parseInt(totalPage);
					
		var newCPageInt = returnCPageInt(type,cPageInt,totalPageInt);
		if(newCPageInt < 0){
			return;
		}else{
			cPageInt = newCPageInt;
		}	
		var status = $("#status").val();
		var type = $("#type").val();
		loadAssetRepairList(status, type, cPageInt);
	    $("#currentPage").html(cPageInt);
	}
   </script>
</html>