<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>教师考勤</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body">

	<div class="app_head">
		<i class=" m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>教师考勤
	</div>
	<c:if test="${checklistSize == 0}">
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
	</c:if>
	
	<c:if test="${checklistSize > 0}">
		<ul class="inout_list">
			<c:forEach items="${checklist}" var="c">
			   	<li>
				    <c:if test="${c.status==1 || c.status==8 || c.status==15 || c.status==26}">
						<em class="Absenteeism">旷</em>
					</c:if>
					<c:if test="${c.status==2 || c.status==9 || c.status==16 || c.status==23}">
						<em class="late">迟</em>
					</c:if>
					<c:if test="${c.status==3 || c.status==10 || c.status==17 || c.status==24}">
						<em class="Leave">早</em>
					</c:if>
					<c:if test="${c.status==4 || c.status==5 || c.status==11 || c.status==12 || c.status==18 || c.status==19 || c.status==22 || c.status==25}">
						<em class="Push">正</em>
					</c:if>
					<c:if test="${c.status==6 || c.status==7 || c.status==13 || c.status==14 || c.status==20 || c.status==21 || c.status==27 || c.status==28}">
						<em class="abnormal">异</em>
					</c:if>
					 <p class="top_p">
						<span class="span_left">${c.name}</span>
						<span class="span_right">${c.createTime}</span>
					</p>
					<p>
					 	<i class="fa fa-credit-card"></i>
						<span class="span3">${c.code}</span>
						<span class="span3">${c.gradeName}</span>
						
					</p>
				</li>
			</c:forEach>
		</ul>
	    <c:if test="${checklistSize >19}">
		    <ul>
		       <li><a href="#" id="op_all_save" class="op_all_save" onclick="loadMoreList()">查看更多</a></li>
		    </ul>
	    </c:if>
    </c:if>
    
    <input type="hidden" id="roleCode" name="roleCode" value="${roleCode}">
	<input type="hidden" id="cPage" value="${cPage}">
	<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
	<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
	<input type="hidden" id="queryContent" value="${queryContent}">
	<input type="hidden" id="startTime" value="${startTime}">
	<input type="hidden" id="endTime" value="${endTime}">
	<input type="hidden" id="createDate" value="${createDate}">
	<input type="hidden" id="departmentId" value="${departmentId}">
	<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut}">
	
	<div class="select_role">
		<dl>
			<dd class="role_search iconfont" id="search">&#xe602;</dd>
		</dl>
		<span class="role_img iconfont">&#xe600;</span>
	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script>

	$(function() {    

		var timeOut = $("#apiKeyTimeOut").val();
		if(timeOut == '1')
		{
			alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
		}
		
		$("#search").on("click",function(){
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var roleCode = $("#roleCode").val();
			standardPost('<%=basePath%>check/toTeacherSearchJspApp.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode})
			})
	      
	});
	function seturl(){
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var roleCode = $("#roleCode").val();
		standardPost('<%=basePath%>check/toTeacherSearchJspApp.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode})
	}
	//加载电子卡页面
	function loadMoreList()
	{
		var body = $("#body");
		
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		var createDate = $("#createDate").val();
		var queryContent = $("#queryContent").val();
		var departmentId = $("#departmentId").val();
		var cPage = $("#cPage").val();
		var roleCode = $("#roleCode").val();

		$.ajax({
			type: "post",
			url: "<%=basePath%>check/loadTeacherCheckListAPP.do",
			data:{
					apiKey : apiKey,
					schoolId : schoolId,
					startTime : startTime,
					endTime : endTime,
					createDate : createDate,
					queryContent : queryContent,
					departmentId : departmentId,
					roleCode : roleCode,
					cPage : cPage
			},
			success: function(data){

				var data = eval("(" + data + ")");

				$("#roleCode").val(data.roleCode);
   				$("#departmentId").val(data.departmentId);
   				$("#queryContent").val(data.queryContent);
   				$("#startTime").val(data.startTime);
   				$("#endTime").val(data.endTime);
   				$("#createDate").val(data.createDate);
   				$("#cPage").val(data.cPage);
   				
				var appendHtml = '';
				
				$.each(data.checklist, function(n, value) {  

					var listSize = data.checklistSize;
	   				if(listSize < 19)
	   	   			{
	   					$("#op_all_save").hide();
	   	   	   		}
	   	   	   		
					appendHtml += '<li>';
					var status = value.status;
					if(status == 1  || status==8 || status==15 || status==26 )
					{
       					appendHtml += '<em class="Absenteeism">旷</em>';
               		}
       				else if(status==2 || status==9 || status==16 || status==23)
           			{
       					appendHtml += '<em class="late">迟</em>';
               		}else if(status==3 || status==10 || status==17 || status==24)
           			{
       					appendHtml += '<em class="Leave">早</em>';
               		}
               		else if(status==4 || status==5 || status==11 || status==12 || status==18 || status==19 || status==22 || status==25)
           			{
       					appendHtml += '<em class="Push">正</em>';
               		}else
                   	{
               			appendHtml += '<em class="abnormal">异</em> 	';
                   	}


					appendHtml += '<p class="top_p">';
					appendHtml += '<span class="span_left">'+value.name+'</span>';
					appendHtml += '<span class="span_right">'+value.createTime+'</span>';
					appendHtml += '</p>';
					appendHtml += '<p>';
					appendHtml += '<i class="fa fa-credit-card"></i>';
					appendHtml += '<span class="span3">'+value.code+'</span>';
					appendHtml += '<span class="span3">'+value.gradeName+'</span>';
					appendHtml += '</p>';
       				appendHtml += '</li>';

      			}); 
      			
      			$(".inout_list").append(appendHtml);
      			//解锁UI
			},
		});
	}
	</script>


</html>