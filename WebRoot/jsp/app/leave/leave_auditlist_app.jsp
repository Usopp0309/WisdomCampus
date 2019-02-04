<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>请假申请</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>
	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>请假申请
	</div>
	
	<c:if test="${leaveAuditListSize == 0}">
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
	</c:if>
	
	<c:if test="${leaveAuditListSize > 0}">

		<table class="app_table">
			<thead class="app_table_head">
				<tr>
					<th>请假人</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>类型</th>
					<th class="sub">
						<span>审核状态 <!-- <i class=" icon-caret-down"></i> --></span>
						<!-- <ul class="submenu">
							<i class=" icon-caret-up" style="color:#fff;position:absolute ;top:-9px;"></i>
							<li>已批准</li>
							<li>已拒绝</li>
							<li>待审核</li>
						</ul> -->
					</th>
				</tr>
			</thead>
			<tbody class="app_table_body" id="tbody">
			    
			    <c:forEach items="${leaveAuditList }" var="l" varStatus="ls">
			          <tr class="odd gradeX">
			          
			              <td>${l.userName}</td>
			              <td>${l.startTime}</td>
			              <td>${l.endTime}</td>
			              
			              <c:if test="${l.type==0}">
			                 <td><span class="Reason1">事</span></td>
			              </c:if>
			              <c:if test="${l.type==1}">
			                 <td><span class="Reason2">病</span></td>
			              </c:if>
			              <c:if test="${l.type==2}">
			                 <td><span class="Reason3">产</span></td>
			              </c:if>
			              <c:if test="${l.type==3}">
			                 <td><span class="Reason4">出</span></td>
			              </c:if>
			              <c:if test="${l.type != 0 && l.type != 1 && l.type != 2 && l.type != 3}">
			                 <td><span class="Reason5">其</span></td>
			              </c:if>
			              
			             
			              
			              <c:if test="${l.auditStatus==0}">
			                 <td><a class="edit" onclick="aduitLeave(${l.id})"><span class="state1">待审核</span></a></td>
			              </c:if>
			              <c:if test="${l.auditStatus==1}">
			                 <td><span class="state3">已批准</span></td>
			              </c:if>
			              <c:if test="${l.auditStatus==2}">
			                 <td><span class="state2">已拒绝</span></td>
			              </c:if>
	           		  </tr>
	           		  
			    </c:forEach>
			
			</tbody>
	
		</table>
		
		<c:if test="${leaveAuditListSize > 19}">
			<ul>
			    <li><a href="#" id="op_all_save" onclick="loadMoreLeaveList()">查看更多</a></li>
			</ul>
		</c:if>
		
		
	</c:if>
	
	<input type="hidden" id="userId" name="userId" value="${userId}">
	<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
	<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
	<input type="hidden" id=cPage name="cPage" value="${cPage}">
	<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut}">
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">
		$(function(){
			$(".sub").on("click",function(){
				$(".submenu").show();
			})

			var timeOut = $("#apiKeyTimeOut").val();
			
			if(timeOut == '1')
			{
				alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
			}
		})

		function loadMoreLeaveList()
		{
			var userId = $("#userId").val();
			var cPage = $("#cPage").val();
			loadLeaveAuditList(userId, null, cPage)
		}

		//加载请假审核列表
		function loadLeaveAuditList(userId, roleCode, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>leave/getLeaveAuditListApp.do",
				data:{
						userId : userId,
						roleCode : roleCode,
						cPage : cPage
					},
				success: function(data){
					var data = eval("(" + data + ")");
					
					$("#cPage").val(data.cPage);

					var listSize = data.listSize;
	   				if(listSize < 19)
	   	   			{
	   					$("#op_all_save").hide();
	   	   	   		}
					
					var appendHtml = '';
					$.each(data.leaveAuditList, function(n, value) {  
           				appendHtml += '<tr class="odd gradeX">';
						//请假人
           				appendHtml += '<td>' + value.userName + '</td>';
						//请假开始时间
           				appendHtml += '<td>' + value.startTime +'</td>';
           				//请假结束时间
           				appendHtml += '<td>' + value.endTime + '</td>';
						//事由
           				var type = parseInt(value.type);
           				switch(type)
           				{ 
           				case 0 : 
       						appendHtml += '<td><span class="Reason1">事</span></td>';
       						break; 
       					case 1 : 
       						appendHtml += '<td><span class="Reason2">病</span></td>';
       						break; 
       					case 2 : 
       						appendHtml += '<td><span class="Reason3">产</span></td>';
       						break; 
       					case 3 : 
       						appendHtml += '<td><span class="Reason4">出</span></td>';
       						break; 
       					default : 
       						appendHtml += '<td><span class="Reason5">其</span></td>';
       						break;
           				}
           				//审核状态
           				 var auditStatus = parseInt(value.auditStatus);
           				switch(auditStatus)
           				{ 
           				case 0 : 
       						appendHtml += '<td><a class="edit" onclick="aduitLeave(' + value.id + ')"><span class="state1">待审核</span></a></td>';
       						break; 
       					case 1 : 
       						appendHtml += '<td><span class="state3">已批准</span></td>';
       						break; 
       					case 2 : 
       						appendHtml += '<td><span class="state2">已拒绝</span></td>';
       						break; 
       					default : 
       						appendHtml += '<td><a class="edit" onclick="aduitLeave(' + value.id + ')"><span class="state1">待审核</span></a></td>';
       						break;
           				} 
           				/* if ($("#type").val() != '2'){
           					appendHtml += '<td>审核</a></td>';
           				} */
           				appendHtml += '</tr>';
          			}); 
//           			$("#tbody").html(appendHtml);
					$("#tbody").append(appendHtml);
				},
			});
		}

		//进入请假审核操作页面
		function aduitLeave(leaveId)
		{
			var userId = $("#userId").val();

			var apiKey = $("#apiKey").val();
			
			var schoolId = $("#schoolId").val();
			standardPost('<%=basePath%>leave/toAuditLeave_App.do',{userId:userId,apiKey:apiKey,schoolId:schoolId,leaveId:leaveId});
		}
	</script>
</html>