<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>学生考情</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
	
</head>

<body id="body">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>学生考勤
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
						<span class="span_right">${c.updateTime}</span>
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
	<input type="hidden" id="clazzId" value="${clazzId}">
	<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut}">
    <input type="hidden" id="createDate" value="${createDate}">
	<div class="select_role">
		<dl>
			<c:if test="${roleListSize >1}">
				<dd class="role_more iconfont" data-toggle="modal" href="#static">&#xe601;</dd>
			</c:if>
			<dd class="role_search iconfont" id="search">&#xe602;</dd>
		</dl>
		<span class="role_img iconfont">&#xe600;</span>
	</div>
	
	<div class="modal fade bs-modal-sm" id="static" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog modal-sm">
           <div class="modal-content">
               <div class="modal-body">
				    <ul class="more_role_choose" id="moreRole">
				    	<li id="0">请选择角色</li>
				    	<c:forEach items="${roleList}" var="r">
					       <c:if test="${r.roleCode == 'admin'}">
						  	 <li id="${r.roleCode}">校管</li>
					       </c:if>
					       <c:if test="${r.roleCode == 'president'}">
						  	 <li id="${r.roleCode}">校长</li>
					       </c:if>
					       <c:if test="${r.roleCode == 'departManager'}">
						  	 <li id="${r.roleCode}">部门管理员</li>
					       </c:if>
					       <c:if test="${r.roleCode == 'classLeader'}">
						  	 <li id="${r.roleCode}">班主任</li>
					       </c:if>
					       <c:if test="${r.roleCode == 'teacher'}">
						  	 <li id="${r.roleCode}">教师</li>
					       </c:if>
					       <c:if test="${r.roleCode == 'student'}">
						  	 <li id="${r.roleCode}">学生</li>
					       </c:if>
					        <c:if test="${r.roleCode == 'parent'}">
						  	 <li id="${r.roleCode}">家长</li>
					       </c:if>
					   </c:forEach>
					</ul>
			</div>
		</div>
	</div>
	</div>
	
			
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	</body>
	
	<script type="text/javascript">

	$(function() {    

		var timeOut = $("#apiKeyTimeOut").val();
		if(timeOut == '1')
		{
			alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
		}

		$(".more_role_choose li").on("click",function(){
			$("#roleCode").val($(this).attr("id"));
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var roleCode = $(this).attr("id");
			standardPost('<%=basePath%>check/toStudentCheckListByHuxinId.do',{apiKey:apiKey,schoolId:schoolId})
			})
	
		$("#search").on("click",function(){
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var roleCode = $("#roleCode").val();
			standardPost('<%=basePath%>check/toStudentSearchJspApp.do',{schoolId:schoolId,roleCode:roleCode})
			})
		
		$("#role").on("click",function(){
			$("#static").modal("show");
		})
		
	      
	});

	function seturl(){
		
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var roleCode = $("#roleCode").val();
		standardPost('<%=basePath%>check/toStudentSearchJspApp.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode})
		}
	//加载电子卡页面
	function loadMoreList()
	{
		var body = $("#body");
		
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var queryContent = $("#queryContent").val();
		var clazzId = $("#clazzId").val();
		var cPage = $("#cPage").val();
		var roleCode = $("#roleCode").val();
		var createDate = $("#createDate").val();
		$.ajax({
			type: "post",
			url: "<%=basePath%>check/loadStudentCheckListAPP.do",
			data:{
					apiKey : apiKey,
					schoolId : schoolId,
					queryContent : queryContent,
					clazzId : clazzId,
					roleCode : roleCode,
					createDate : createDate,
					cPage : cPage
			},
			success: function(data){

				var data = eval("(" + data + ")");

				$("#roleCode").val(data.roleCode);
   				$("#clazzId").val(data.clazzId);
   				$("#queryContent").val(data.queryContent);
   				$("#cPage").val(data.cPage);
   				$("#createDate").val(data.createDate);
   				var listSize = data.checklistSize;
   				if(listSize < 19)
   	   			{
   					$("#op_all_save").hide();
   	   	   		}
				var appendHtml = '';
				
				$.each(data.checklist, function(n, value) {  
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
					appendHtml += '<span class="span_right">'+value.updateTime+'</span>';
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