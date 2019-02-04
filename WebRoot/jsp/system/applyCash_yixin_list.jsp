<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>提现管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束--> 
 	<style type="text/css">
		.zhi{padding:5px;background-color:#0eaff0;color:#fff;font-style: normal;border-radius:4px;}
		.wei{padding:5px;background-color:#3fb237;color:#fff;font-style: normal;border-radius:4px;}
		.tixian{padding:5px 10px;background-color:#4d90fe;color:#fff;cursor: pointer;}
		.tixian:hover{background-color:#0362fd;color:#fff;}
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
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><span>提现</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">亦信提现列表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<li class="roleLi">
											<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
										</li>
									</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">申请日期：</span>
                                    <input type="text" placeholder="申请日期" class="form-control m_input" name="startTime"  id="startTime" />
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">账户类型：</span>
									<select id="thirdType" class="form-control m_select">
										<option value="all">全部</option>
										<option value="1">支付宝</option>
										<option value="2">微信</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">提现状态：</span>
	                         		<select id="applyStatus" class="form-control m_select">
	                         			<option value="all">全部</option>
										<option value="0">未处理</option>
										<option value="1">已通过</option>
										<option value="4">已拒绝</option>
									</select>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">搜索内容：</span>
	                         		<input type="text" class="form-control m_input" placeholder="姓名,手机号"  id="queryContent"/>
	                         	</div>
	                        
		                         <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         	<button type="button" class="btn green" id="search">查找</button>
		                         	<button type="button" class="btn btn-default" id="export">导出</button>
		                         	<button type="button" class="btn btn-default" id="yixin">本校列表</button>
		                         </div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>提现申请记录列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead>
										<tr>
											<th class="m_width_10">提现申请人</th>
											<th class="m_width_10">手机号</th>
											<th class="m_width_20 hidden-sm hidden-md">申请人信息</th>
											<th class="m_width_10">提现金额</th>
											<th class="m_width_10 hidden-sm hidden-md">接收账户</th>
											<th class="m_width_10">申请日期</th>
											<th class="m_width_10">备注</th>
											<th class="m_width_10">操作</th>
										</tr>
										
									</thead>

									<tbody id="tbody">
										
									</tbody>
	                                </table>
	                            </div>
	                        </div>
	                        <div class="modal fade" id="quJueHtml" tabindex="-1" role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-lg" style="width: 400px;">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">消息</h4>
						                </div>
						                  <div class="modal-body m_padding_top_0">
						                <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
				                         <span class="m_display_inline m_float_left m_width_10">备注</span>
				                         <textarea class="m_width_90 m_float_left form-control" id="remark" name="remark" placeholder="请输入拒绝理由"></textarea>
			                            </div>
						                </div>
						                <div class="modal-footer">
						                <input value="" id="jujueId" type="hidden">
						                <input value="" id="userId_" type="hidden">
						                <button type="button" class="btn green" onclick="submitRefuseInfo(this);">确定</button>
						                <button type="button" class="btn" data-dismiss="modal">取消</button>
						                </div> 
						            </div>
						        </div>
						    </div>
						    
	                       <!-- 列表展现开始 -->
	                        <!-- 分页开始 -->
	                        <%@include file="/public_module/public_page.jsp" %>
	                        <!-- 分页结束 -->
	                    </div>
	                </div>
	                </div>
	                <!--页面内容结束 -->
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
			loadSubMenu("systemManage"); 
			//选取当前菜单位置
			setActive("systemManage","applyCash"); 
			getApplyCashList(null);
			$('#startTime').datetimepicker({
				 lang:"ch",
				 format:"Y-m-d" ,
				 timepicker:false
				});

			$("#search").click(function(){
				getApplyCashList(null);
			});
			$("#yixin").click(function(){
				
				standardPost('<%=basePath%>wallet/toApplyCashList.do',{});
			});

			//导出人员数据
			$("#export").click(function(){
				//获取申请日期
				var startTime = $("#startTime").val();
				//获取接收人账户提现类型
				var thirdType = $("#thirdType").val();
				//获取提现状态
				var applyStatus = $("#applyStatus").val();
				//获取查询内容
				var queryContent = $("#queryContent").val();
				standardPost('<%=basePath%>wallet/exportApplyCashUserList.do',{startTime:startTime,thirdType:thirdType,applyStatus:applyStatus,queryContent:queryContent,type:0});
			});
		})
		
		function getApplyCashList(cPage){
			var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
			//获取申请日期
			var startTime = $("#startTime").val();
			//获取接收人账户提现类型
			var thirdType = $("#thirdType").val();
			//获取提现状态
			var applyStatus = $("#applyStatus").val();
			//获取查询内容
			var queryContent = $("#queryContent").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>wallet/getApplyCashList.do",
				data:{
					startTime : startTime,
					thirdType : thirdType,
					applyStatus : applyStatus,
					queryContent : queryContent,
					cPage : cPage,
					type : 0
					},
					error:function(){
						layer.close(indexlayer);
					},
				success: function(data){
					var pages = eval("(" + data + ")");
					$("#currentPage").html(pages.currentPage);
					$("#totalPage").html(pages.totalPage);
					var appendHtml = '';
					$.each(pages.list, function(n, value) {
						appendHtml += '<tr>';
						appendHtml += '<td>'+value.userName+'</td>';
						if(typeof(value.user.bindPhone)!="undefined"){
							appendHtml += '<td>'+value.user.bindPhone+'</td>';
						}else{
							appendHtml += '<td></td>';
						}
						if(typeof(value.userInfo)!="undefined"){
							appendHtml += '<td class="hidden-sm hidden-md">'+value.userInfo+'</td>';
						}else{
							appendHtml += '<td class="hidden-sm hidden-md"></td>';
						}
						
						if(typeof(value.applyCash)!="undefined"){
							appendHtml += '<td>'+value.applyCash+'元</td>';
						}else{
							appendHtml += '<td></td>';
						}
						if(typeof(value.thirdType)!="undefined"){
							if(value.thirdType == 1){
								appendHtml += '<td class="hidden-sm hidden-md"><em class="zhi">支</em> '+value.thirdAccount+'</td>';
							}else{
								appendHtml += '<td class="hidden-sm hidden-md"><em class="wei">微</em> '+value.thirdAccount+'</td>';
							}
						}else{
							appendHtml += '<td class="hidden-sm hidden-md"></td>';
						}
						if(typeof(value.createTime)!="undefined"){
							appendHtml += '<td>'+value.createTime+'</td>';
						}else{
							appendHtml += '<td></td>';
						}
						if(typeof(value.dealDesc)!="undefined"){
							appendHtml += '<td>'+value.dealDesc+'</td>';
						}else{
							appendHtml += '<td></td>';
						}
						if(typeof(value.applyStatus)!="undefined"){
							if(value.applyStatus == 0){
								appendHtml += '<td><a class="btn green" onclick="tixian('+value.applyId+','+value.userId+')">提现</a>';
								appendHtml+='<a class="btn red" data-toggle="modal" href="#quJueHtml"  onclick="refuse('+value.applyId+','+value.userId+')">拒绝</a>';
								appendHtml+='</td>';
							}else if(value.applyStatus ==4){
								appendHtml += '<td style="color:red;">已拒绝</td>';
							}else{
								appendHtml += '<td>已处理</td>';	
							}
						}else{
							appendHtml += '<td></td>';
						}
						appendHtml += '</tr>';
					});
					$("tbody").html(appendHtml);
					layer.close(indexlayer);
				},
			});
		}
		//拒绝提现
        function refuse(applyId,userId){
        	$("#jujueId").val(applyId);
        	$("#userId_").val(userId);
        	$("#remark").val("");
        }
		//提交拒绝信息
		function submitRefuseInfo(obj){
			var applyId=$("#jujueId").val();
        	var userId=$("#userId_").val();
        	var remark=$.trim($("#remark").val());
        	if(remark==""){
        	layer.tips("请输入拒绝理由",$("#remark"));
        	return false;
        	}else if(remark.length>255){
        		layer.tips("拒绝理由最多255个汉字",$("#remark"));
            	return false;	
        	}
        	$(obj).next().click();
        	var l_=layer.confirm('确认拒绝？', {
				  btn: ['确定','取消'] //按钮
				},function(){
					var indexlayer = layer.msg('正在处理数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
					$.ajax({
						type: "post",
						url: "<%=basePath%>wallet/doConfirmApplyCash.do",
						data:{
							applyId : applyId,
							userId : userId,
							status:1,
							remark:remark
							},
						success: function(data){
							layer.close(indexlayer);
							var responseCode = eval("(" + data + ")");
							if(responseCode == 0){
								layer.msg("拒绝成功");
								var cPage = $("#currentPage").html();
								getApplyCashList(cPage);
							}else{
								layer.msg("服务器处理失败,请联系管理员");
							}
							
						}
					});
				},function(){
				  layer.close(l_);
				});
        	
		}
		function tixian(applyId,userId){
			var l_=layer.confirm('确认提现？', {
				  btn: ['确定','取消'] //按钮
				},function(){
					$.ajax({
						type: "post",
						url: "<%=basePath%>wallet/doConfirmApplyCash.do",
						data:{
							applyId : applyId,
							userId : userId,
							status:0,
							remark:""
							},
						success: function(data){
							var responseCode = eval("(" + data + ")");
							if(responseCode == 0){
								layer.msg("确认成功");
								//原页面刷新改成
								//location.reload();
								var cPage = $("#currentPage").html();
								getApplyCashList(cPage);
							}else{
								layer.msg("服务器处理失败,请联系管理员");
							}
						},
					});
				},function(){
				  layer.close(l_);
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
				
			getApplyCashList(cPageInt);		
			$("#currentPage").html(cPageInt);
		}
	</script>
</html>