<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - 技术支持</title>
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
		<form action="<%=basePath %>school/toTechnicalSupport.do" id="searchForm" method="post">
			<div class="search_main">
				<button type="submit" class="fa fa-search search_submit"></button>
				<input class="search_text" type="text" name="condition" placeholder="请输入学校名称..." value="${condition }"></input>
				<input type="hidden" name="status" id="status" value="${status}">
				<input type="hidden" name="page" id="page" value="${page}">
				<input type="hidden" name="pages" id="pages" value="${totalPage}">
			</div>
		</form>
	</div>
	 <div class="richxManager">
			<h3 class="margin_top_15">技术支持</h3>
			<ul class="mtabs margin_top_15">
				<c:if test="${status eq '0' }">
					<li class="active"><a  href="javascript:changeSatus('0')">待绑定技术支持的学校</a></li>
					<li><a href="javascript:changeSatus('1')">已绑定技术支持的学校</a></li>
				</c:if>
				<c:if test="${status eq '1' }">
					<li><a href="javascript:changeSatus('0')">待绑定技术支持的学校</a></li>
					<li class="active"><a  href="javascript:changeSatus('1')">已绑定技术支持的学校</a></li>
				</c:if>
			</ul>
			<h4 class="margin_top_15">技术支持</h4>
			<div class="con">
				<div class="tab-content">
					<c:if test="${status eq '0' }">
						<div class="tab-pane active" id="tab_1_1">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th class="m_width_20">学校名称</th>
										<th class="m_width_40">学校地址</th>
										<th class="m_width_15">销售/代理商</th>
										<th class="m_width_15">技术支持</th>
										<th class="m_width_10">操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${schoolList }" var="shcool">
									<tr>
										<form action="<%=basePath%>school/doTechnicalSupport.do" class="form-horizontal" method="post">
												<td class="m_width_20">${shcool.schoolName }</td>
												<td class="m_width_30">${shcool.schoolAddress }</td>
												<td class="m_width_25">${shcool.agencyName }</td>
												<td class="m_width_15">
													<select class="form-control" data-placeholder="无" tabindex="1"  name="supportUserId" value="">
														<option value=""  selected="selected" >请选择</option>
														<c:forEach items="${shcool.supportUserList}" var="agency">
															<option value="${agency.userId }">${agency.realName }</option>
														</c:forEach>
													</select>
												</td>
												<td class="m_width_10">
													<a onclick="m_form(this)">确定</a> <input type="hidden" name="schoolId" value="${shcool.schoolId }" />
												</td>
										</form>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</c:if>
					<c:if test="${status eq '1' }">
						<div class="tab-pane active" id="tab_1_2">
						<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th class="m_width_20">学校名称</th>
										<th class="m_width_40">学校地址</th>
										<th class="m_width_15">销售/代理商</th>
										<th class="m_width_15">技术支持</th>
										<th class="m_width_10">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${schoolList }" var="shcool">
										<tr>
										<form action="<%=basePath%>school/doTechnicalSupport.do" method="post">
												<td class="m_width_20">${shcool.schoolName }</td>
												<td class="m_width_30">${shcool.schoolAddress }</td>
												<td class="m_width_25">${shcool.agencyName }</td>
												<td class="m_width_15">
													<select class="form-control" data-placeholder="无" tabindex="1" name="supportUserId" value="${shcool.supportUserId}">
														<option value="">无</option>
														<c:forEach items="${shcool.supportUserList}" var="agency">
																<c:if test="${shcool.supportUserId == agency.userId }"><option value="${agency.userId }"  selected>${agency.realName }</option></c:if>
																<c:if test="${shcool.supportUserId != agency.userId }"><option value="${agency.userId }" >${agency.realName }</option></c:if>
														</c:forEach>
												</select>
												</td> 
												<td class="m_width_10">
													<a onclick="m_form(this)">确定</a> 
													<input type="hidden" name="schoolId" value="${shcool.schoolId }" />
													<input type="hidden" name="orig_supportUserId" value="${shcool.supportUserId }" />
												</td>
										</form>
										</tr>
									</c:forEach>
							</tbody>
							</table>
						</div>
					</c:if>
					</div>
				</div>
				<%@include file="/public_module/public_page.jsp" %>
	
	</div>
	<%@ include file="/public_module/public_footer.jsp"%>
	</body>
	<%@ include file="/public_module/public_js.jsp"%>
	
	<script type="text/javascript">
		
		$(function() {
			$(".mtabs li").eq(0).css({"border-right":"none"})
			//导航定位
			$(".menu_li a").removeClass("hover");
			$("#menu6").addClass("hover");
			$("#currentPage").html($("#page").val());
			$("#totalPage").html($("#pages").val());
		})
		function changeSatus(obj){
			$("#page").val(1);
			$("#pages").val("");
			$("#status").val(obj);
			$("#searchForm").submit();
		}
		//发送表单
		function m_form(obj){
			$(obj).closest("tr").find("form").submit();
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
			$("#page").val(cPageInt);
			$("#pages").val(totalPage);
			$("#searchForm").submit();
		    $("#currentPage").html(cPageInt);
		}
	</script>
</html>