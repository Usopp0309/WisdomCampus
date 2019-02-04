<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - 学校授权</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<%@include file="/public_module/header.jsp" %>
	<div class="manager_search_box">
		<div class="search_main">
			<button type="button" id="search" class="fa fa-search search_submit"></button>
			<input class="search_text" type="text" name="condition" id="condition" placeholder="请输入学校名称..." value=""></input>
			<input type="hidden" name="status" id="status" value="">
		</div>
	</div>
	<div class="richxManager">
		<h3 class="margin_top_15">学校授权</h3>
		<ul class="mtabs margin_top_15" id="schoolTab">
			
		</ul>
		<h4 class="margin_top_15">学校授权列表</h4>
		<div class="con">
			<div class="tab-content">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th class="m_width_30">学校名称</th>
							<th class="m_width_30">学校地址</th>
							<th class="m_width_30">销售/代理商</th>
							<th class="m_width_10">操作</th>
						</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>
			</div>
		</div>
		<%@include file="/public_module/public_page.jsp" %>
	</div>
	<%@include file="/public_module/public_footer.jsp" %>
</body>
	<%@include file="/public_module/public_js.jsp" %>
	<script type="text/javascript">
		$(function() {
			$(".mtabs li").eq(0).css({"border-right":"none"})
			//导航定位
			$(".menu_li a").removeClass("hover");
			$("#menu4").addClass("hover");
			
			$(".authorization_con").on("click", function() {
				$(this).find("button").addClass("blue");
				$(this).siblings().find("button").removeClass("blue");
			})
			
			$("#search").on("click", function(){
				var status = $("#status").val();
				var condition = $("#condition").val();
				loadAuthorization(status, condition, null);
			})
			
			loadAuthorization(0, null, null);
		})
		function changeSatus(obj){
			$("#status").val(obj);
			$("#condition").val("");
			loadAuthorization(obj, null, null);
		}
		
		//加载请假列表
		function loadAuthorization(status, condition, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>school/loadAuthorization.do",
				data:{
						status : status,
						condition : condition,
						page : cPage
					},
				success: function(data){
					var data = eval("(" + data + ")");
					var agencyList = data.agencyList;
					var page = data.pages;
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					$("#status").val(status);
					var appendHtml = '';
					var appendUlHtml = '';
					if(status == 0)
					{
						appendUlHtml += '<li class="active"><a  href="javascript:changeSatus(0)">待授权学校</a></li>';
						appendUlHtml += '<li><a href="javascript:changeSatus(1)">已授权学校</a></li>';
					}
					else
					{
						appendUlHtml += '<li><a href="javascript:changeSatus(0)">待授权学校</a></li>';
						appendUlHtml += '<li class="active"><a  href="javascript:changeSatus(1)">已授权学校</a></li>';
					}
					$("#schoolTab").html(appendUlHtml);
					
					$.each(page.list, function(n, value) {  
						appendHtml += '<tr>';
           				appendHtml += '<td>'+value.schoolName+'</td>';
           				var schoolAddress = value.schoolAddress;
						if(schoolAddress == undefined)
						{
							schoolAddress = "";
						}
           				appendHtml += '<td>'+schoolAddress+'</td>';
           				appendHtml += '<td>';
           				appendHtml += '<select class="form-control" data-placeholder="无" tabindex="1">';
           				appendHtml += '<option value="0">---请选择---</option>';
           				$.each(agencyList, function(n, agency) {
           					if(status == 0)
        					{
	           					appendHtml += '<option value="'+agency.id+'">'+agency.name+'</option>';
        					}else
           					{
        						if(agency.id == value.id)
       							{
        							appendHtml += '<option selected="selected" value="'+agency.id+'">'+agency.name+'</option>';
       							}
        						else
       							{
        							appendHtml += '<option value="'+agency.id+'">'+agency.name+'</option>';
       							}
           					}
           				});
           				appendHtml += '</select>';
           				appendHtml += '</td>';
           				appendHtml += '<td>';
           				appendHtml += '<a class="save_agency" id="'+value.schoolId+'">确定</a>';
           				appendHtml += '</td>';
           				appendHtml += '</tr>';
          			}); 
					
          			$("#tbody").html(appendHtml);
          			
          		    //取消
					$(".save_agency").on("click",function(){
						var agencyId = $(this).parent().parent().find("select").val();
						var schoolId = $(this).attr("id");
						saveAgency(status,condition,cPage,agencyId,schoolId)
					})
					
				},
			});
		}
		
		function saveAgency(status,condition,cPage,agencyId,schoolId)
		{
			if(agencyId == 0)
			{
				layer.msg("请选择代理商或销售");
				return;
			}
			$.ajax({
				type: "post",
				url: "<%=basePath%>school/doAuthorization.do",
				data:{
						agencyId : agencyId,
						schoolId : schoolId
					},
				success: function(data){
					loadAuthorization(status, condition, cPage);
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
			loadAuthorization(status, condition, cPageInt);
		    $("#currentPage").html(cPageInt);
		}
	</script>

</html>