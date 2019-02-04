<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - 人员列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<%@ include file="/public_module/header.jsp"%>
	<div class="manager_search_box">
		<div class="search_main">
			<button type="button" onclick="searchInfo()"  class="fa fa-search search_submit"></button>
			<input class="search_text" type="text" name="condition" id="condition" placeholder="请输入名称..."></input>
			<input type="hidden" name="status" value="${status}" id="status" />
		</div>
	</div>
	<div class="richxManager">
		<h3 class="margin_top_15">人员列表</h3>
		<ul class="mtabs margin_top_15" id="personTab">
		</ul>
		<h4 class="margin_top_15">人员列表</h4>
		<div class="con">
			<div class="tab-content">
				<div class="active" id="tab_1_1" style="position: relative;display: none">
					<p class="Response newsfile">
						<a class="btn_new btn blue" style="width: 90px;">新建</a>
					</p>
					<table class="table table-bordered table-hover">
						<thead>
							<tr class="news_from">
								<th colspan="5" class="m_padding_0">
									<form class="form-horizontal" id="subform1" action="<%=basePath%>persionner/addAgency.do" method="post">
									<table class="table table-hover table-light">
										<tr>
											<td class="m_width_10">代理商</td>
											<td class="m_width_25"><input type="text" class="form-control" id="name" name="name"></td>
											<td>邮箱</td>
											<td><input type="text" class="form-control" id="email" name="email"></td>
											<td class="m_width_10">联系电话</td>
											<td class="m_width_20"><input type="text" class="form-control" id="phone" name="phone"></td>
										</tr>
										<tr>
											<td>省份</td>
											<td>
												<select class="form-control" id="province" onchange="getChildrenArea('province','city')" name="province"></select>
											</td>
											<td>市</td>
											<td>
												<select class="form-control" id="city" onchange="getChildrenArea('city','country')" name="city"></select>
											</td>
											<td>区/县</td>
											<td>
												<select class="form-control" id="country" name="country"></select>
											</td>
										</tr>
										<tr>
											<td>法人</td>
											<td><input type="text" class="form-control" id="corporation" name="corporation"></td>
											<td>地址</td>
											<td><input type="text" class="form-control" id="address" name="address"></td>
											<td>联系人</td>
											<td><input type="text" class="form-control" id="realName1" name="realName"></td>
										</tr>
										<tr>
											<td class="m_width_10">代理类型</td>
											<td class="m_width_25 radio-list">
												<label class="radio radio-inline"><input checked="checked" type="radio" value="省级" name="agentType"> 省级</label>
												<label class="radio radio-inline"><input type="radio" value="市级" name="agentType"> 市级</label>
												<label class="radio radio-inline"><input type="radio" value="区/县级" name="agentType"> 区/县级</label>
											</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td class="text_align" colspan="6">
												 <button type="button" onclick="saveInfor(1)" class="btn green">确定</button>
					                    		 <button type="button" class="btn btn_new_cancel">取消</button>
											</td>
										</tr>
									</table>
									</form>
								</th>
							</tr>
							<tr>
								<th class="m_width_20">代理商名称</th>
								<th class="m_width_15">账号</th>
								<th class="m_width_20">省市区</th>
								<th class="m_width_20">地址</th>
								<th class="m_width_15">联系电话</th>
								<th class="m_width_10">操作</th>
							</tr>
						</thead>
						<tbody id="tbody_0">
						</tbody>
					</table>
				</div>
	
				<div id="tab_1_2" style="position: relative;display: none">
					<p class="Response newsfile">
						<a class="btn_new btn blue" style="width: 90px;">新建</a>
					</p>
					<table class="table table-bordered table-hover">
						<thead>
							<tr class="news_from">
								<th colspan="5" class="m_padding_0">
									<form class="horizontal-form" id="subform2"action="<%=basePath%>persionner/addSupport.do" method="post">
										<table class="table table-hover table-light">
											<tr>
												<td class="m_width_10">姓名</td>
												<td class="m_width_25"><input type="text" class="form-control" id="realName2" name="realName"/></td>
												<td class="m_width_10">邮箱</td>
												<td class="m_width_25 radio-list">
													<input type="text" class="form-control" id="supportEmail" name="supportEmail">
												</td>
												<td class="m_width_10">联系电话</td>
												<td class="m_width_20"><input type="text" class="form-control" id="supportPhone" name="supportPhone"/></td>
											</tr>
											<tr>
												<td>所属公司</td>
												<td>
													<select tabindex="1" class="form-control" id="agencySelect2" name="agency"></select>
												</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td class="text_align" colspan="6">
													 <button type="button"  onclick="saveInfor(2)" class="btn green">确定</button>
						                    		 <button type="button" class="btn btn_new_cancel">取消</button>
												</td>
											</tr>
										</table>
										</form>
									</th>
								</tr>
								<tr>
									<th class="m_width_20">姓名</th>
									<th class="m_width_15">账号</th>
									<th class="m_width_20">联系电话</th>
									<th class="m_width_15">邮箱</th>
									<th class="m_width_20">归属公司</th>
									<th class="m_width_10">操作</th>
								</tr>
							</thead>
							<tbody id="tbody_1">
								
							</tbody>
					</table>
				</div>
							
				<div id="tab_1_3" style="position: relative;display: none">
					<p class="Response newsfile">
						<a class="btn_new btn blue" style="width: 90px;">新建</a>
					</p>
					<table class="table table-bordered table-hover">
						<thead>
							<tr class="news_from">
								<th colspan="5" class="m_padding_0">
									<form class="form-horizontal" id="subform3"action="<%=basePath%>persionner/addAccountant.do" method="post">
										<table class="table table-hover table-light">
											<tr>
												<td class="m_width_10">姓名</td>
												<td class="m_width_25"><input type="text" class="form-control" id="realName3" name="realName"/></td>
												<td class="m_width_10">邮箱</td>
												<td class="m_width_25">
													<input type="text" class="form-control" id="accountantEmail" name="accountantEmail" />
												</td>
												<td class="m_width_10">联系电话</td>
												<td class="m_width_20"><input type="text" class="form-control" id="accountantPhone" name="accountantPhone"/></td>
											</tr>
											<tr>
												<td>所属公司</td>
												<td>
													<select tabindex="1" class="form-control" id="agencySelect3" name="agency">
													</select>
												</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td class="text_align" colspan="6">
													 <button type="button"  onclick="saveInfor(3)" class="btn green">确定</button>
						                    		 <button type="button" class="btn btn_new_cancel">取消</button>
												</td>
											</tr>
										</table>
										</form>
									</th>
								</tr>
								<tr>
									<th class="m_width_20">姓名</th>
									<th class="m_width_15">账号</th>
									<th class="m_width_20">联系电话</th>
									<th class="m_width_15">邮箱</th>
									<th class="m_width_15">归属公司</th>
									<th class="m_width_15">操作</th>
								</tr>
							</thead>
						<tbody id="tbody_2">
								
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<%@include file="/public_module/public_page.jsp" %>
	</div>
	<%@ include file="/public_module/public_footer.jsp" %>
	</body>
	<%@include file="/public_module/public_js.jsp" %>
	<script type="text/javascript">
		$(function(){
			$(".mtabs li").eq(0).css({"border-right":"none"});
			$(".mtabs li").eq(1).css({"border-right":"none"});
			var status = $("#status").val();
			if(status == "" || status == 0)
			{
				$("#tab_1_1").show();
				$("#tab_1_2").hide();
				$("#tab_1_3").hide();
				loadPersionner(0, null, null);
			}
			else if(status == 1)
			{
				$("#tab_1_1").hide();
				$("#tab_1_2").show();
				$("#tab_1_3").hide();
				loadPersionner(1, null, null);
			}
			else if(status == 2)
			{
				$("#tab_1_1").hide();
				$("#tab_1_2").hide();
				$("#tab_1_3").show();
				loadPersionner(2, null, null);
			}
				
			
			//显示详情
			$(".detal").on("click",function(){
				$(".persionner_info").removeAttr("style");
				$(this).parent().parent().next(".persionner_info").show();
			})
			//修改按钮
			$(".btn_update").on("click",function(){
				if($(this).text()=="修改"){
					var phone='<input type="text" class="form-control" value="'+$(this).parent().parent().parent().find(".editphone").text()+'">';
					var name='<input type="text" class="form-control" value="'+$(this).parent().parent().parent().find(".editname").text()+'">';
					var email='<input type="text" class="form-control" value="'+$(this).parent().parent().parent().find(".editemail").text()+'">';
					$(this).parent().parent().parent().find(".editphone").empty().append(phone);
					$(this).parent().parent().parent().find(".editname").empty().append(name);
					$(this).parent().parent().parent().find(".editemail").empty().append(email);
					$(this).text("提交");
				}else if($(this).text()=="提交"){
						$(this).text()=="修改"
				};
			})
			//取消
			$(".btn_cancel").on("click",function(){
				$(this).closest(".persionner_info").removeAttr("style");
			})
			//导航定位
			$(".menu_li a").removeClass("hover");
			$("#menu5").addClass("hover");
			//新建人员
			$(".btn_new").on("click",function(){
				$(".news_from").show();
			})
			//取消新建人员
			$(".btn_new_cancel").on("click",function(){
				$(".news_from").removeAttr("style");
			})
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
					$(this).css({"background-color":"#3aa4f1","display":"block"}).find("span").css({"color":"#fff"});
					$(this).find("i").addClass("icon-chevron-down");
				};
				
			});
			
			$(".accordion-toggle").on("click", function() {
				$("#accordion1").find("i").removeClass("icon-chevron-down");
				$("#accordion2").find("i").removeClass("icon-chevron-down");
				$("#accordion3").find("i").removeClass("icon-chevron-down");
				$(this).find("i").addClass("icon-chevron-down");
			});
			
			loadProvince();
			
		});
		
		function searchInfo()
		{
			var status = $("#status").val();
			var condition = $("#condition").val();
			loadPersionner(status, condition, null);
		}
		
		function loadPersionner(status, condition, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>persionner/getPersionner.do",
				data:{
						status : status,
						condition : condition,
						page : cPage
					},
				success: function(data){
					//页面tab
					var appendUlHtml = '';
					if(status == 0)
					{
						appendUlHtml += '<li class="active"><a href="javascript:change(0);">代理商列表</a></li>';
						appendUlHtml += '<li><a href="javascript:change(1);">技术支持列表</a></li>';
						appendUlHtml += '<li><a href="javascript:change(2);">财务人员列表</a></li>';
					}
					else if(status == 1)
					{
						appendUlHtml += '<li><a href="javascript:change(0);">代理商列表</a></li>';
						appendUlHtml += '<li class="active"><a href="javascript:change(1);">技术支持列表</a></li>';
						appendUlHtml += '<li><a href="javascript:change(2);">财务人员列表</a></li>';
					}
					else
					{
						appendUlHtml += '<li><a href="javascript:change(0);">代理商列表</a></li>';
						appendUlHtml += '<li><a href="javascript:change(1);">技术支持列表</a></li>';
						appendUlHtml += '<li class="active"><a href="javascript:change(2);">财务人员列表</a></li>';
					}
					$("#personTab").html(appendUlHtml);
					
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					$("#status").val(status);
					var appendHtml = '';
					
					$.each(page.list, function(n, value) { 
						
						if(status == 0)
						{
							appendHtml += '<tr>';
							appendHtml += '<td>'+value.name+'</td>';
							appendHtml += '<td>'+value.username+'</td>';
							var province = value.province;
							if(province == undefined)
							{
								province = "";
							}
							var city = value.city;
							if(city == undefined)
							{
								city = "";
							}
							var country = value.country;
							if(country == undefined)
							{
								country = "";
							}
							appendHtml += '<td>'+province+city+country+'</td>';
							appendHtml += '<td>'+value.address+'</td>';
							appendHtml += '<td>'+value.phone+'</td>';
							appendHtml += '<td><a class="detal">查看详情</a></td>';
							appendHtml += '</tr>';
							appendHtml += '<tr class="persionner_info">';
							appendHtml += '<td colspan="5" class="m_padding_0">';
							appendHtml += '<div style="border:1px solid #1490f4">';
							appendHtml += '<table class="table table-bordered">';
							appendHtml += '<tr>';
							appendHtml += '<td class="active">代理商</td>';
							appendHtml += '<td class="editname">'+value.name +'</td>';
							appendHtml += '<td class="active">代理类型</td>';
							appendHtml += '<td>'+value.agentType+'</td>';
							appendHtml += '<td class="active">省市区</td>';
							appendHtml += '<td>'+province+city+country+'</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							var realName = value.realName;
							if(realName == undefined)
							{
								realName = "";
							}
							appendHtml += '<td class="active">联系人</td> <td>'+realName+'</td>';
							appendHtml += '<td class="active">联系电话</td> <td class="editphone">'+value.phone+'</td>';
							appendHtml += '<td class="active">地址</td> <td class="editaddress">'+value.address+'</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							var corporation = value.corporation;
							if(corporation == undefined)
							{
								corporation = "";
							}
							appendHtml += '<td class="active">法人</td> <td>'+corporation+'</td>';
							var email = value.email;
							if(email == undefined)
							{
								email = "";
							}
							appendHtml += '<td class="active">邮箱</td> <td>'+email+'</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							appendHtml += '<td class="text_align" colspan="6">';
							appendHtml += '<input type="hidden" class="agencyId" value="'+value.id+'">';
							appendHtml += '<button type="button" class="btn blue btn-sm btn_update">修改</button>';
							appendHtml += '<button type="button" class="btn btn-sm btn_cancel">取消</button>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							appendHtml += '<td colspan="6">负责学校</td>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							appendHtml += '<td colspan="6">';
							appendHtml += '<dl class="personnel_info_con">';
							$.each(value.schoolList, function(n, school) { 
								appendHtml += '<dd>'+school.schoolName +'</dd>';
							});
							appendHtml += '</dl>';
							appendHtml += '</td>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
							appendHtml += '</table>';
							appendHtml += '</div>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
						}
						else if(status == 1)
						{
							appendHtml += '<tr>';
							appendHtml += '<td>'+value.realName+'</td>';
							appendHtml += '<td>'+value.username+'</td>';
							appendHtml += '<td>'+value.phone+'</td>';
							appendHtml += '<td>'+value.email+'</td>';
							appendHtml += '<td>'+value.name+'</td>';
							appendHtml += '<td><a class="detal">查看详情</a></td>';
							appendHtml += '</tr>';
							appendHtml += '<tr class="persionner_info">';
							appendHtml += '<td colspan="5"  class="m_padding_0">';
							appendHtml += '<div style="border:1px solid #1490f4">';
							appendHtml += '<table class="table table-bordered">';
							appendHtml += '<tr>';
							appendHtml += '<td class="active">名称</td> <td class="editname">'+value.realName +'</td>';
							appendHtml += '<td class="active">邮箱</td> <td class="editemail">'+value.email+'</td>';
							appendHtml += '<td class="active">手机</td> <td class="editphone">'+value.phone+'</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							appendHtml += '<td class="text_align" colspan="6">';
							appendHtml += '<input type="hidden" id="id" class="agencyId" value="'+value.userId+'">';
							appendHtml += '<button type="button" class="btn blue btn-sm btn_update">修改</button>';
							appendHtml += '<button type="button" class="btn btn-sm btn_cancel">取消</button>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							appendHtml += '<td colspan="6">负责学校</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							appendHtml += '<td colspan="6">';
							appendHtml += '<dl class="personnel_info_con">';
							$.each(value.schoolList, function(n, school) { 
								appendHtml += '<dd>'+school.schoolName +'</dd>';
							});
							appendHtml += '</dl>';
							appendHtml += '</td>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
							appendHtml += '</table>';
							appendHtml += '</div>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
						}
						else
						{
							appendHtml += '<tr>';
							appendHtml += '<td>'+value.realName +'</td>';
							appendHtml += '<td>'+value.username+'</td>';
							appendHtml += '<td>'+value.phone+'</td>';
							appendHtml += '<td>'+value.email+'</td>';
							appendHtml += '<td>'+value.name+'</td>';
							appendHtml += '<td><a class="detal">修改</a></td>';
							appendHtml += '</tr>';
							appendHtml += '<tr class="persionner_info">';
							appendHtml += '<td colspan="5"  class="m_padding_0">';
							appendHtml += '<div style="border:1px solid #1490f4">';
							appendHtml += '<table class="table table-bordered">';
							appendHtml += '<tr>';
							appendHtml += '<td class="m_width_10 active">姓名</td> <td class="m_width_25 editname">'+value.realName +'</td>';
							appendHtml += '<td class="m_width_10 active">邮箱</td> <td class="m_width_25 editemail">'+value.email+'</td>';
							appendHtml += '<td class="m_width_10 active">联系电话</td> <td class="m_width_20 editphone">'+value.phone+'</td>';
							appendHtml += '</tr>';
							appendHtml += '<tr>';
							appendHtml += '<td class="text_align" colspan="6">';
							appendHtml += '<input type="hidden" class="agencyId" id="id" value="'+value.userId+'">';
							appendHtml += '<button type="button" class="btn blue btn-sm btn_update">修改</button>';
							appendHtml += '<button type="button" class="btn btn-sm btn_cancel">取消</button>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
							appendHtml += '</table>';
							appendHtml += '</div>';
							appendHtml += '</td>';
							appendHtml += '</tr>';
						}
          			}); 
          			$("#tbody_"+status).html(appendHtml);
          			
          		    //显示详情
        			$(".detal").on("click",function(){
        				$(".persionner_info").removeAttr("style");
        				$(this).parent().parent().next(".persionner_info").show();
        			})
        			
        			//取消
					$(".btn_cancel").on("click",function(){
						var phone="";
						var name="";
						var email="";
						var address="";
						$(this).closest(".persionner_info").removeAttr("style");
						if($(this).parent().find(".btn_update").text()=="提交")
						{
							phone=$(this).parent().parent().parent().find(".editphone").find("input").val();
							name=$(this).parent().parent().parent().find(".editname").find("input").val();
							email=$(this).parent().parent().parent().find(".editemail").find("input").val();
							address=$(this).parent().parent().parent().find(".editaddress").find("input").val();
						}
						else if($(this).parent().find(".btn_update").text()=="修改")
						{
							phone=$(this).parent().parent().parent().find(".editphone").text();
							name=$(this).parent().parent().parent().find(".editname").text();
							email=$(this).parent().parent().parent().find(".editemail").text();
							address=$(this).parent().parent().parent().find(".editaddress").text();
						}
						$(this).parent().parent().parent().find(".editphone").empty().append(phone);
						$(this).parent().parent().parent().find(".editname").empty().append(name);
						$(this).parent().parent().parent().find(".editemail").empty().append(email);
						$(this).parent().parent().parent().find(".editaddress").empty().append(address);
						$(this).parent().find(".btn_update").text("修改");
					})
					
					//修改按钮
					$(".btn_update").on("click",function(){
						if($(this).text()=="修改"){
							var phone='<input type="text" class="form-control" value="'+$(this).parent().parent().parent().find(".editphone").text()+'">';
							var name='<input type="text" class="form-control" value="'+$(this).parent().parent().parent().find(".editname").text()+'">';
							var email='<input type="text" class="form-control" value="'+$(this).parent().parent().parent().find(".editemail").text()+'">';
							var address='<input type="text" class="form-control" value="'+$(this).parent().parent().parent().find(".editaddress").text()+'">';
							$(this).parent().parent().parent().find(".editphone").empty().append(phone);
							$(this).parent().parent().parent().find(".editname").empty().append(name);
							$(this).parent().parent().parent().find(".editemail").empty().append(email);
							$(this).parent().parent().parent().find(".editaddress").empty().append(address);
							$(this).text("提交");
						}else if($(this).text()=="提交"){
							if(status == 0)
							{
								var agencyId =$(this).parent().parent().parent().find(".agencyId").val();
								var phone=$(this).parent().parent().parent().find(".editphone").find("input").val();
								var name=$(this).parent().parent().parent().find(".editname").find("input").val();
								var address=$(this).parent().parent().parent().find(".editaddress").find("input").val();
								modifyAgency(status, condition,cPage,agencyId,phone,name,address);
							}	
							else if(status == 1)
							{
								var agencyId =$(this).parent().parent().parent().find(".agencyId").val();
								var name=$(this).parent().parent().parent().find(".editname").find("input").val();
								var email=$(this).parent().parent().parent().find(".editemail").find("input").val();
								var phone=$(this).parent().parent().parent().find(".editphone").find("input").val();
								modifySupport(status, condition,cPage,agencyId,phone,name,email);
							}	
							else
							{
								var agencyId =$(this).parent().parent().parent().find(".agencyId").val();
								var name=$(this).parent().parent().parent().find(".editname").find("input").val();
								var email=$(this).parent().parent().parent().find(".editemail").find("input").val();
								var phone=$(this).parent().parent().parent().find(".editphone").find("input").val();
								modifyAccountant(status, condition,cPage,agencyId,phone,name,email);
							}
						};
					})
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
			var condition = $("#condition").val();
			loadPersionner(status, condition, cPageInt)
		    $("#currentPage").html(cPageInt);
		}
		
		
		function modifyAgency(status, condition,cPage,agencyId,phone,name,address){
			$.ajax({
				type: "post",
				url: "<%=basePath%>persionner/modifyAgency.do",
				data:{
					agencyId :agencyId,
					phone : phone,
					name : name,
					address : address
				},
				success: function(data){
					var data = eval("(" + data + ")");
					if(data)
					{
						layer.msg("修改成功");
						loadPersionner(status, condition, cPage)
					}
				},
			});
		}
		function modifySupport(status, condition,cPage,agencyId,phone,name,email)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>persionner/modifySupport.do",
				data:{
					agencyId :agencyId,
					phone : phone,
					name : name,
					email : email
				},
				success: function(data){
					var data = eval("(" + data + ")");
					if(data)
					{
						layer.msg("修改成功");
						loadPersionner(status, condition, cPage)
					}
				},
			});
		}
		function modifyAccountant(status, condition,cPage,agencyId,phone,name,email)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>persionner/modifyAccountant.do",
				data:{
					agencyId :agencyId,
					phone : phone,
					name : name,
					email : email
				},
				success: function(data){
					var data = eval("(" + data + ")");
					if(data)
					{
						layer.msg("修改成功");
						loadPersionner(status, condition, cPage)
					}
				},
			});
		}
		
		function loadAgencySelect(num){
			$.ajax({
				type: "post",
				url: "<%=basePath%>persionner/getAgencyList.do",
				data:{
						
					},
				success: function(data){
					var list = $.parseJSON(data);
					var appendHtml = '<option value="0">----请选择----</option>';
					$.each(list, function(n, value) {  
						appendHtml += '<option value="' + value.id + '">' + value.name + '</option>';
          			}); 
          			$("#agencySelect"+num).html(appendHtml);
				},
			});
		}
		//加载省份
		function loadProvince(){
			$.ajax({
				type: "post",
				url: "<%=basePath%>apply/getPronvice.do",
				data:{
						
					},
				success: function(data){
					var list = $.parseJSON(data);
					var appendHtml = '<option value="0">----请选择----</option>';
					$.each(list, function(n, value) {  
						appendHtml += '<option value="' + value.areaId + '">' + value.areaName + '</option>';
          			}); 
          			$("#province").html(appendHtml);
				},
			});
			
		}
		//下拉框更改事件
		function getChildrenArea(parentId, childId){
			if (parentId == 'province'){//根据省获取地市
				$("#country").val("");
				$("#school").val("");
				$.ajax({
					type: "post",
					url: "<%=basePath%>apply/getChildrens.do",
					data:{
							areaId : $("#province").val()
						},
					success: function(data){
						var list = $.parseJSON(data);
						var appendHtml = '<option value="0">----请选择----</option>';
						$.each(list, function(n, value) {  
							appendHtml += '<option value="' + value.areaId + '">' + value.areaName + '</option>';
	          			}); 
	          			$("#city").html(appendHtml);
					},
				});
			}else if(parentId == 'city'){//根据地市获取区县
				$("#school").val("");
				$.ajax({
					type: "post",
					url: "<%=basePath%>apply/getChildrens.do",
							data : {
								areaId : $("#city").val()
							},
							success : function(data) {
								var list = $.parseJSON(data);
								var appendHtml = '<option value="0">----请选择----</option>';
								if (list.length == 0) {
									appendHtml += '<option value="'
											+ $("#city").val()
											+ '">城区 </option>';

								} else {
									$
											.each(
													list,
													function(n, value) {
														appendHtml += '<option value="' + value.areaId + '">'
																+ value.areaName
																+ '</option>';
													});

								}

								$("#country").html(appendHtml);
							},
						});
			}
		}
		//修改代理商信息
		function toModify(id, name, address, phone) {
			$("#agencyId1").val(id);
			$("#name1").val(name);
			$("#address1").val(address);
			$("#phone1").val(phone);
			$('#update').modal('show');
		}
		//修改技术支持或财务信息
		function toModifySupport(id, name, email, phone) {
			$("#agencyId1").val(id);
			$("#name1").val(name);
			$("#email1").val(email);
			$("#phone1").val(phone);
			$('#update').modal('show');
		}
		
		//切换tab
		function change(obj) {
			$(".news_from").hide();
			$("#tab_1_1").hide();
			$("#tab_1_2").hide();
			$("#tab_1_3").hide();
			$("#tab_1_"+(obj+1)).show();
			$("#status").val(obj);
			$("#condition").val("");
			loadPersionner(obj, null, null)
			
			if(obj == 0){
				loadProvince();
			}else if(obj == 1){
				loadAgencySelect(2);
			}else{
				loadAgencySelect(3);
			}
		}
		
		//新增人员
		function saveInfor(obj){
			if(obj == 1)
			{
				var realName = $("#realName1").val();
				if(realName == "")
				{
					layer.msg("联系人不能为空！");
					return;
				}
				
				var email = $("#email").val();
				if(email == "")
				{
					layer.msg("邮箱即为登录账号，不能为空！");
					return;
				}
				else if(checkEmail(email))
				{
					layer.msg("邮箱即为登录账号，系统中已存在请重新填写！");
					return;
				}
				else
				{
					$("#subform1").submit();
				}
				
				
			}
			else if(obj == 2)
			{
				var realName = $("#realName2").val();
				if(realName == "")
				{
					layer.msg("姓名不能为空！");
					return;
				} 
				var agencySelect = $("#agencySelect2").val();
				if(agencySelect == 0)
				{
					layer.msg("请选择所属公司！");
					return;
				} 
				var email = $("#supportEmail").val();
				if(email == "")
				{
					layer.msg("邮箱即为登录账号，不能为空！");
					return;
				}
				else if(checkEmail(email))
				{
					layer.msg("邮箱即为登录账号，系统中已存在请重新填写！");
					return;
				}
				else
				{
					$("#subform2").submit();
				}
			}
			else if(obj == 3)
			{
				var realName = $("#realName3").val();
				if(realName == "")
				{
					layer.msg("联系人不能为空！");
					return;
				}
				var agencySelect = $("#agencySelect3").val();
				if(agencySelect == 0)
				{
					layer.msg("请选择所属公司！");
					return;
				} 
				var email = $("#accountantEmail").val();
				if(email == "")
				{
					layer.msg("邮箱即为登录账号，不能为空！");
					return;
				}
				else if(checkEmail(email))
				{
					layer.msg("邮箱即为登录账号，系统中已存在请重新填写！");
					return;
				}
				else
				{
					$("#subform3").submit();
				}
			}
		}
		
		//加载省份
		function checkEmail(email){
			var flag = false;
			$.ajax({
				async:false, 
				type: "post",
				url: "<%=basePath%>baseData/checkUserName.do",
				data:{
						userName : email
					},
				success: function(data)
				{
					var data = eval("(" + data + ")");
					if(data)
					{
						flag = true;
					}else
					{
						flag = false;
					}
				}
			});
			
			return flag;
		}
		
	</script>
</html>