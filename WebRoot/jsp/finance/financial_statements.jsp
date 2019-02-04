<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 -财务报表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
 	<link href="<%=basePath%>assets/global/css/demoTable.css" rel="stylesheet" type="text/css" />
</head>

<body id="body">
<%@include file="/public_module/header.jsp" %>
	 <div class="Fill_Card">
	<div class="manager_search_box">
        <div class="search_main">
            <button type="button" class="search_submit" id="search">搜索</button>
            <input class="search_text" type="text" name="condition" id="queryContent" placeholder="请输入学校名、代理商..." value="">
            <input type="hidden" name="status" id="status" value="1">
        </div>
    </div>
    <div class="richxManager">
        <h3 class="margin_top_15">财务报表</h3>
        <div class="pageOn">
            <h4 class="margin_top_15">财务员财务报表</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="m_width_10">代理商名称</th>
                            <th class="m_width_10">学校名称</th>
                            <th class="m_width_10">学校总人数</th>
                            <th class="m_width_10">学生总人数</th>
                            <th class="m_width_10">教职工总人数</th>
                            <th class="m_width_10">智慧校园卡总数</th>
                            <th class="m_width_10">服务费总金额</th>
                            <th class="m_width_10">卡押金总金额</th>
                            <th class="m_width_10">操作</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">

                        </tbody>
                    </table>
                </div>
            </div>
            <!-- 分页开始 -->
              <%@include file="/public_module/public_page.jsp" %>
            <!-- 分页结束 -->
        </div>

    </div>
	</div>
	<%@include file="/public_module/public_footer.jsp" %>
	<%@include file="/public_module/public_js.jsp" %>

	<script type="text/javascript">
		jQuery(document).ready(function() {
			//初始化列表
			list(1);

			$("#search").click(function(){
				list(1);
			});
		});

		function detail(schoolId){
			standardPost('<%=basePath%>financialStatements/toFinancialStatementsDetail.do',{schoolId:schoolId});
		}

		function list(cPage){
			var body = $("#body");
			App.blockUI(body);
			var queryContent = $.trim($("#queryContent").val());
			$.ajax({
				type: "post",
				url: "<%=basePath%>financialStatements/getFinancialStatementsList.do",
				data:{
						queryContent : queryContent,
						cPage:cPage
					},
				success: function(data){
					var resultMap = eval("(" + data + ")");
					var appendHtml = '';
					if(resultMap.isPermission){
						var page = resultMap.pages;
						$("#currentPage").html(page.currentPage);
						$("#totalPage").html(page.totalPage);
						
						$.each(page.list, function(n, value) {  
							appendHtml += '<tr>';
							appendHtml += '<td class="m_width_10">'+value.agencyName+'</td>';
							appendHtml += '<td class="m_width_10">'+value.schoolName+'</td>';
							appendHtml += '<td class="m_width_10">'+value.userCount+'</td>';
							appendHtml += '<td class="m_width_10">'+value.studentCount+'</td>';
							appendHtml += '<td class="m_width_10">'+value.teacherCount+'</td>';
							appendHtml += '<td class="m_width_10">'+value.cardNumber+'</td>';
							appendHtml += '<td class="m_width_10">￥'+value.serviceTotalAmount+'</td>';
							appendHtml += '<td class="m_width_10">￥'+value.cardTotalDepositAmount+'</td>';
							appendHtml += '<td class="m_width_10"><a href="javascript:;" onclick="detail('+value.schoolId+');">详情</a></td>';
							
							appendHtml += '</tr>';
	          			}); 
	          			$("#tbody").html(appendHtml);
					}else{
						$("#currentPage").html(0);
						$("#totalPage").html(0);
						$("#tbody").html(appendHtml);
						layer.msg("您没有权限访问",{icon:4,time:2500});
					}
          			//解锁UI
          			App.unblockUI(body);
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
			list(cPageInt);
			$("#currentPage").html(cPageInt);
		}
	</script>
</body>
</html>