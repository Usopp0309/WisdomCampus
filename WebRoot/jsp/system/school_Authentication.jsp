<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - 学校认证</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<%@include file="/public_module/header.jsp" %>
		<%-- <img src="<%=basePath%>media/image/web_logo1.png"> --%>
	<div class="manager_search_box">
		<c:if test="${type eq '0'}">
			<form action="<%=basePath%>schoolApply/toSchoolApplyList.do" method="post" id="searchForm">
		</c:if>
		<c:if test="${type eq '1'}">
			<form action="<%=basePath%>schoolApply/toSchoolApplyPassList.do" method="post" id="searchForm">
		</c:if>
		<c:if test="${type eq '2'}">
			<form action="<%=basePath%>schoolApply/toSchoolApplyNotPassList.do" method="post" id="searchForm">
		</c:if>
			<div class="search_main">
				<button type="submit" class="fa fa-search search_submit"></button>
				<input class="search_text" type="text" name="condition" placeholder="请输入学校名称..." value="${condition}"></input> 
				<input type="hidden" name="status" id="status" value="${status}"/> 
				<input type="hidden" name="lastId" id="lastId" value="${lastId}"/>
				<input type="hidden" id="rowNum" name="rowNum" value="${rowNum}"/>
			</div>
			</form>
	</div>
	<div class="richxManager">
			<h3 class="margin_top_15">学校认证</h3>
			<ul class="mtabs margin_top_15">
			<c:if test="${type eq '0'}">
				<li class="active"><a href="javascrip:void(0)" data-toggle="tab" onclick="show(1)">待审批<em class="Response">的学校</em></a></li>
			</c:if>
			<c:if test="${type ne '0'}">
				<li><a href="javascrip:void(0)" data-toggle="tab" onclick="show(1)">待审批<em class="Response">的学校</em></a></li>
			</c:if>
			<c:if test="${type eq '1'}">
				<li class="active"><a href="javascrip:void(0)" data-toggle="tab" onclick="show(2)">已审批<em class="Response">的学校</em></a></li>
			</c:if>
			<c:if test="${type ne '1'}">
				<li><a href="javascrip:void(0)" data-toggle="tab" onclick="show(2)">已审批<em class="Response">的学校</em></a></li>
			</c:if>
			<c:if test="${type eq '2'}">
				<li class="active"><a href="javascrip:void(0)" data-toggle="tab" onclick="show(3)">未通过<em class="Response">的学校</em></a></li>
			</c:if>
			<c:if test="${type ne '2'}">
				<li><a href="javascrip:void(0)" data-toggle="tab" onclick="show(3)">未通过<em class="Response">的学校</em></a></li>
			</c:if>
			</ul>
			<h4 class="margin_top_15">人员列表</h4>
				<div class="con">
				<div class="tab-content">
					<c:if test="${type eq '0'}">
						<div class="tab-pane active" id="tab_1_1">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th class="m_width_20">申请学校</th>
										<th class="m_width_25">学校地址</th>
										<th class="m_width_10">校长</th>
										<th class="m_width_20">校长电话</th>
										<th class="m_width_15">申请时间</th>
										<th class="m_width_10">操作</th>
									</tr>
								</thead>
								<body>
								<c:forEach items="${applyList}" var="apply">
									<tr>
										<td>${apply.schoolName}</td>
										<td>${apply.schoolAddress}</td>
										<td>${apply.proposer}</td>
										<td>${apply.phone}</td>
										<td>${apply.applyTime}</td>
										<td><a class="detal">查看详情</a></td>
									</tr>
									<tr class="persionner_info">
										<td colspan="6" class="m_padding_0">
											<div style="border:1px solid #1490f4">
												<table class="table table-bordered">
													<tr>
														<td class="active">学校名称</td>
														<td>${apply.schoolName}</td>
														<td class="active">校长</td>
														<td>${apply.schoolMaster}</td>
														<td class="active">学校地址</td>
														<td>${apply.schoolAddress}</td>
													</tr>
													<tr>
														<td class="active">申请人职务</td>
														<td>${apply.duties}</td>
														<td class="active">学校性质</td>
														<td>${apply.schoolType}</td>
														<td class="active">申请时间</td>
														<td>${apply.applyTime}</td>
													</tr>
													<tr>
														<td class="active">成立时间</td>
														<td>${apply.createDate}</td>
														<td class="active">校长电话</td>
														<td>${apply.schoolMasterPhone}</td>
														<td class="active">学生人数</td>
														<td>${apply.totalNum}</td>
													</tr>
													<tr>
														<td class="active">校长邮箱</td>
														<td>${apply.email}</td>
														<td class="active">查看附件</td>
														<td><a href="javascript:void(0);" onclick="lookAttachment('${apply.attachment}');">查看附件</a></td>
														<td class="active"></td>
														<td></td>
													</tr>
													<tr>
														<td class="text_align" colspan="6">
														<button class="btn blue btn-sm"  onclick="showPassModal(${apply.id}, '${apply.schoolName}', '${apply.email}')">通过</button>
														<button class="btn btn-sm"  onclick="showNotPassModal(${apply.id}, '${apply.schoolName}', '${apply.email}')">拒绝</button>
														</td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</c:forEach>
								</body>
							</table>
                            </div>
							<div id="refuse" class="modal fade" tabindex="-1" data-width="400">
								<div class="modal-dialog">
									<div  class="modal-content">
										<h3>拒绝<a href="javascript:" class="clear" id="notPassSchoolName"></a></h3>
										<h3>智慧校园学校认证！</h3>
										<div class="info">
											<span><em class="Response">拒绝</em>原因</span>
											<ul>
												<li onclick="addReason(this)">已申请</li>
												<li onclick="addReason(this)"><em class="Response">核实</em>无此学校</li>
												<li onclick="addReason(this)"><em class="Response">提供</em>信息不全</li>
												<li onclick="addReason(this)"><em class="Response">提供</em>信息有误</li>
												<li onclick="addReason(this)"><em class="Response">校方</em>未达成共识</li>
												<li onclick="addReason(this)">手机<em class="Response">号码</em>有误</li>
												<li onclick="addReason(this)">重复提交<em class="Response">申请</em></li>
											</ul>
										</div>
										<div class="info">
											<span>备注</span>
											<textarea rows="" cols="" id="reason"></textarea>
											<input type="hidden" id="notPassApplyId">
											<input type="hidden" id="notPassEmail">
										</div>
										<div class="info">
											<a href="javascript:" class="sub clear" onclick="refuse()" id="refuseBtn">确认拒绝</a>
										</div>
									</div>
								</div>
							</div>
							<div id="school_pass" class="modal fade" tabindex="-1"
								data-width="400">
								<div class="modal-dialog">
									<div class="modal-content pass_info">
										<h3>通过<a href="javascript:" class="clear" id="passSchoolName"></a></h3>
										<h3>智慧校园学校认证！</h3>
										<p>
											系统将默认用户名，密码发送至<em class="Response">申请人注册邮箱</em>：<a href="javascript:" class="clear" id="passEmail"></a>
												<input type="hidden" id="passApplyId">
										</p>
										<p>
											<a href="javascript:" class="sub clear" onclick="accept()" id="acceptBtn">确认通过</a>
										</p>
									</div>
								</div>
						</div>
					</div>
				</div>
				</c:if>
				<c:if test="${type eq '1'}">
					<div class="tab-pane active" id="tab_1_2">
					
					<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th class="m_width_20">申请学校</th>
										<th class="m_width_25">学校地址</th>
										<th class="m_width_10">校长</th>
										<th class="m_width_20">校长电话</th>
										<th class="m_width_15">申请时间</th>
										<th class="m_width_10">操作</th>
									</tr>
								</thead>
								<body>
								<c:forEach items="${applyPassList}" var="applyPass">
									<tr>
										<td>${applyPass.schoolName}</td>
										<td>${applyPass.schoolAddress}</td>
										<td>${applyPass.proposer}</td>
										<td>${applyPass.phone}</td>
										<td>${applyPass.applyTime}</td>
										<td><a class="detal">查看详情</a></td>
									</tr>
									<tr class="persionner_info">
										<td colspan="6" class="m_padding_0">
											<div style="border:1px solid #1490f4">
												<table class="table table-bordered">
													<tr>
														<td class="active">学校名称</td>
														<td>${applyPass.schoolName}</td>
														<td class="active">校长</td>
														<td>${applyPass.schoolMaster}</td>
														<td class="active">学校地址</td>
														<td>${applyPass.schoolAddress}</td>
													</tr>
													<tr>
														<td class="active">申请人职务</td>
														<td>${applyPass.duties}</td>
														<td class="active">学校性质</td>
														<td>${applyPass.schoolType}</td>
														<td class="active">申请时间</td>
														<td>${applyPass.applyTime}</td>
													</tr>
													<tr>
														<td class="active">成立时间</td>
														<td>${applyPass.createDate}</td>
														<td class="active">校长电话</td>
														<td>${applyPass.schoolMasterPhone}</td>
														<td class="active">学生人数</td>
														<td>${applyPass.totalNum}</td>
													</tr>
													<tr>
														<td class="active">校长邮箱</td>
														<td>${applyPass.email}</td>
														<td class="active">查看附件</td>
														<td><a href="javascript:void(0);" onclick="lookAttachment('${applyPass.attachment}');">查看附件附件</a></td>
														<td class="active"></td>
														<td></td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</c:forEach>
								</body>
							</table>
					</div>
				</c:if>
				<c:if test="${type eq '2'}">
					<div class="tab-pane active" id="tab_1_3">
					<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th class="m_width_20">申请学校</th>
										<th class="m_width_25">学校地址</th>
										<th class="m_width_10">校长</th>
										<th class="m_width_20">校长电话</th>
										<th class="m_width_15">申请时间</th>
										<th class="m_width_10">操作</th>
									</tr>
								</thead>
								<body>
								<c:forEach items="${applyNotPassList}" var="applyNotPass">
									<tr>
										<td>${applyNotPass.schoolName}</td>
										<td>${applyNotPass.schoolAddress}</td>
										<td>${applyNotPass.proposer}</td>
										<td>${applyNotPass.phone}</td>
										<td>${applyNotPass.applyTime}</td>
										<td><a class="detal">查看详情</a></td>
									</tr>
									<tr class="persionner_info">
										<td colspan="6" class="m_padding_0">
											<div style="border:1px solid #1490f4">
												<table class="table table-bordered">
												 <input type="hidden" name="notPassLastId" value="${notPassLastId}" id="notPassLastId"/>
													<tr>
														<td class="active">学校名称</td>
														<td>${applyNotPass.schoolName}</td>
														<td class="active">校长</td>
														<td>${applyNotPass.proposer}</td>
														<td class="active">学校地址</td>
														<td>${applyNotPass.schoolAddress}</td>
													</tr>
													<tr>
														<td class="active">申请人职务</td>
														<td>${applyNotPass.duties}</td>
														<td class="active">学校性质</td>
														<td>${applyNotPass.schoolType}</td>
														<td class="active">申请时间</td>
														<td>${applyNotPass.applyTime}</td>
													</tr>
													<tr>
														<td class="active">成立时间</td>
														<td>${applyNotPass.createDate}</td>
														<td class="active">校长电话</td>
														<td>${applyNotPass.phone}</td>
														<td class="active">学生人数</td>
														<td>${applyNotPass.totalNum}</td>
													</tr>
													<tr>
														<td class="active">校长邮箱</td>
														<td>${applyNotPass.email}</td>
														<td class="active"></td>
														<td></td>
														<td class="active"></td>
														<td></td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</c:forEach>
								</body>
							</table>
					</div>
				</c:if>
		</div>
		
		
		
		
	</div>
	<%@include file="/public_module/public_footer.jsp" %>
	</body>
	<%@include file="/public_module/public_js.jsp" %>
	<script type="text/javascript">
		$(function() {
			$(".menu_li a").removeClass("hover");
			$("#menu2").addClass("hover");
			$(".mtabs li").eq(0).css({"border-right":"none"});
			$(".mtabs li").eq(1).css({"border-right":"none"});
		});
		//查看附件
		function lookAttachment(url){
			url="<%=Cons.IMGBASEPATH%>"+url;
			//页面层
			layer.open({
			  title:"附件信息",
			  type:1,
			  skin: 'layui-layer-rim', //加上边框
			  area: ['500px', '500px'], //宽高
			  content: '<div style="text-align: center;vertical-align: middle;"><img style="vertical-align:middle;margin-top:30px;" height="400" width="400" src="'+url+'"/></div>'
			});
		}
		function show(obj){
			
			if (obj == 1){
				$("#searchForm").attr("action","<%=basePath%>schoolApply/toSchoolApplyList.do");
			}else if(obj == 2){
				$("#searchForm").attr("action","<%=basePath%>schoolApply/toSchoolApplyPassList.do");
			}else{
				$("#searchForm").attr("action","<%=basePath%>schoolApply/toSchoolApplyNotPassList.do");
			}
			$("#searchForm").submit();
		}
		function showPassModal(id,schoolName,email){
			$("#passSchoolName").text(schoolName);
			$("#passEmail").text(email);
			$("#passApplyId").val(id);
			$("#school_pass").modal("show");
		}
		function showNotPassModal(id,schoolName,email){
			$("#notPassSchoolName").text(schoolName);
			$("#notPassEmail").text(email);
			$("#notPassApplyId").val(id);
			$("#refuse").modal("show");
		}
		//审核通过
		function accept(){
			var applyId = $("#passApplyId").val();
			var email = $("#passEmail").text();
			$("#acceptBtn").removeAttr('onclick');
			$("#acceptBtn").html("后台处理中...");
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolApply/doAudit.do",
				data:{
						id : applyId,
						status : '0',
						email : email
					 },
				success: function(data) 
				{
				    var data = $.parseJSON(data);
				    if (data.status != 0){
				    	alert("提交通过数据出错，请联系管理员");
				    }
				    window.location.reload();
				}
			});
			
		}
		//审核不通过
		function refuse(){
			var applyId = $("#notPassApplyId").val();
			var email = $("#notPassEmail").text();
			var reason = $("#reason").val();
			$("#refuseBtn").attr("disabled", "disabled");
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolApply/doAudit.do",
				data:{
						id : applyId,
						status : '1',
						email : email,
						reason : reason
					 },
				success: function(data) 
				{
				    var data = $.parseJSON(data);
				    if (data.status != 0){
				    	layer.msg("提交拒绝数据出错，请联系管理员");
				    }else{
				    	window.location.reload();
				    }
				},
				complete: function(){
					$("#refuseBtn").removeAttr("disabled");
				}
			});
		}
		//快速添加原因
		function addReason(obj){
			var reason = $("#reason").val() + $(obj).text();
			$("#reason").val(reason);
		}
		//加载更多
		function loadMore(obj){
			var rowNum = $("#rowNum").val();
			if (obj == 0){//加载通过的内容
				$.ajax({
					type: "post",
					url: "<%=basePath%>schoolApply/moreSchoolApplyPassList.do",
					data:{
							passLastId : $("#passLastId").val(),
							condition : $("#condition").val()
						 },
					success: function(data) 
					{
					    var data = $.parseJSON(data);
					    if (data.status != 0){
					    	alert("加载出错");
					    }else{
					    	var appendHtml = "";
					    	$.each(data.list,function(i,item){
					    		rowNum = rowNum + i;

					    		appendHtml += '<div class="panel panel-default">';
					    		appendHtml += '<div class="panel-heading">';
					    		appendHtml += '<h4 class="panel-title">';
					    		appendHtml += '<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_'+ item.id + '">';
						    	appendHtml += '		<p class="Fill_Card_accordion_title">';
						    	appendHtml += '			<span>' + item.schoolName + '</span> <span>' + item.schoolAddress + '</span>';
						    	appendHtml += '			<span>' + item.proposer + '</span> <span>' + item.phone + '</span>';
						    	appendHtml += '	<span class="school_w"><i class="icon-chevron-right"></i>&nbsp</span>';
						    	appendHtml += '		</p>';
					    		appendHtml += '</a>';
					    		appendHtml += '</h4>';
					    		appendHtml += '</div>';
					    		appendHtml += '<div id="collapse_'+ item.id + '" class="panel-collapse collapse">';
					    		appendHtml += '<div class="panel-body">';
						    	appendHtml += '	<p class="School_apply_info School_apply_info_100">';
						    	appendHtml += '		<span><em class="Response">学校</em>名称：' + item.schoolName + '</span>';
						    	appendHtml += '		<span>校长:<em>' + item.proposer + '</em></span> <span><em';
						    	appendHtml += '			class="Response">学校</em>地址：' + item.schoolAddress + '</span> <span><em';
						    	appendHtml += '			class="Response">申请人</em>职务：' + item.duties + '</span> <span><em';
						    	appendHtml += '			class="Response">学校</em>性质：' + item.schoolType + '</span> <span><em';
						    	appendHtml += '			class="Response">申请</em>时间：' + item.applyTime + '</span> <span><em';
						    	appendHtml += '			class="Response">学校</em>成立<em class="Response">时间</em>：' + item.createDate + '</span>';
						    	appendHtml += '		<span><em class="Response">校长</em>电话：' + item.phone + '</span>';
						    	appendHtml += '		<span><em class="Response">学生</em>人数：' + item.totalNum + '</span>';
						    	appendHtml += '		<span><em class="Response">校长</em>邮箱：' + item.email + '</span>';
						    	appendHtml += '	</p>';
					    		appendHtml += '</div>';
					    		appendHtml += '</div>';
					    		appendHtml += '</div>';
					    	});
					    	
					    	$("#passMore").before(appendHtml);
					    	$("#passLastId").val(data.passLastId);
					    	if(data.list.length<10)
				    		{
					    		$("#passMoreThan").hide();
				    		}
					    	
					    	//点击状态改变
							$(".accordion-toggle").on("click", function() {
								if($(this).parent().parent().find(".accordion-body").hasClass("in")){
									$(this).removeAttr("style");
									$(this).find("span").removeAttr("style");
									$(this).find("i").removeClass("icon-chevron-down");
								}else{
									$(".accordion").find(".accordion-toggle").removeAttr("style");
									$(".accordion").find(".accordion-toggle").find("span").removeAttr("style");
									$(".accordion").find("i").removeClass("icon-chevron-down");
									$(this).css({"background-color":"#3aa4f1"}).find("span").css({"color":"#fff"});
									$(this).find("i").addClass("icon-chevron-down");
								};
								
							})
							
					    	
					    }
					},
					complete: function(){
					}
				});
			}else{//加载不通过的内容
				$.ajax({
					type: "post",
					url: "<%=basePath%>schoolApply/moreSchoolApplyNotPassList.do",
					data:{
						notPassLastId : $("#notPassLastId").val(),
						condition : $("#condition").val()
						 },
					success: function(data) 
					{
					    var data = $.parseJSON(data);
					    if (data.status != 0){
					    	alert("加载出错");
					    }else{
					    	var appendHtml = "";
					    	$.each(data.list,function(i,item){
					    		rowNum = rowNum + i;
					    		appendHtml += '<div class="panel panel-default">';
					    		appendHtml += '<div class="panel-heading">';
					    		appendHtml += '<h4 class="panel-title">';
					    		appendHtml += '<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_'+item.id+'">';
					    		appendHtml += '		<p class="Fill_Card_accordion_title">';
						    	appendHtml += '			<span>' + item.schoolName + '</span> <span>' + item.schoolAddress + '</span>';
						    	appendHtml += '			<span>' + item.proposer + '</span> <span>' + item.phone + '</span>';
						    	appendHtml += '	<span class="school_w"><i class="icon-chevron-right"></i>&nbsp</span>';
						    	appendHtml += '		</p>';
					    		appendHtml += '</a>';
					    		appendHtml += '</h4>';
					    		appendHtml += '</div>';
					    		appendHtml += '<div id="collapse_'+item.id+'" class="panel-collapse collapse">';
					    		appendHtml += '<div class="panel-body">';
					    		appendHtml += '	<p class="School_apply_info School_apply_info_100">';
						    	appendHtml += '		<span><em class="Response">学校</em>名称：' + item.schoolName + '</span>';
						    	appendHtml += '		<span>校长:<em>' + item.proposer + '</em></span> <span><em';
						    	appendHtml += '			class="Response">学校</em>地址：' + item.schoolAddress + '</span> <span><em';
						    	appendHtml += '			class="Response">申请人</em>职务：' + item.duties + '</span> <span><em';
						    	appendHtml += '			class="Response">学校</em>性质：' + item.schoolType + '</span> <span><em';
						    	appendHtml += '			class="Response">申请</em>时间：' + item.applyTime + '</span> <span><em';
						    	appendHtml += '			class="Response">学校</em>成立<em class="Response">时间</em>：' + item.createDate + '</span>';
						    	appendHtml += '		<span><em class="Response">校长</em>电话：' + item.phone + '</span>';
						    	appendHtml += '		<span><em class="Response">学生</em>人数：' + item.totalNum + '</span>';
						    	appendHtml += '		<span><em class="Response">校长</em>邮箱：' + item.email + '</span>';
						    	appendHtml += '	</p>';        
					    		appendHtml += '</div>';
					    		appendHtml += '</div>';
					    		appendHtml += '</div>';
					    	});
					    	
					    	$("#notPassMore").before(appendHtml);
					    	$("#notPassLastId").val(data.notPassLastId);
					    	if(data.list.length<10)
				    		{
					    		$("#notPassMoreThan").hide();
				    		}
					    	
					    	//点击状态改变
							$(".accordion-toggle").on("click", function() {
								if($(this).parent().parent().find(".accordion-body").hasClass("in")){
									$(this).removeAttr("style");
									$(this).find("span").removeAttr("style");
									$(this).find("i").removeClass("icon-chevron-down");
								}else{
									$(".accordion").find(".accordion-toggle").removeAttr("style");
									$(".accordion").find(".accordion-toggle").find("span").removeAttr("style");
									$(".accordion").find("i").removeClass("icon-chevron-down");
									$(this).css({"background-color":"#3aa4f1"}).find("span").css({"color":"#fff"});
									$(this).find("i").addClass("icon-chevron-down");
								};
								
							})
					    }
					},
					complete: function(){
						
					}
				});
			}
			$("#rowNum").val(rowNum);
		}
	</script>
</html>