<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>请假列表</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>请假列表
	</div>
	
	<c:if test="${leaveListSize == 0}">
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
	</c:if>
	
	<c:if test="${leaveListSize > 0}">
		<table class="app_table">
			<thead class="app_table_head">
				<tr>
					<th>请假人</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>类型</th>
					<th class="sub">
						<span>审核状态 </span>
					</th>
				</tr>
			</thead>
			<tbody class="app_table_body" id="tbody">
			      <c:forEach items="${leaveList}" var="l" varStatus="ls">
			          <c:choose>
			              	<c:when test="${ls.index%2==0}">
			              		<tr style="background-color: #f2f2f2">
			             	</c:when>
			              <c:otherwise>
			                	<tr>
			              </c:otherwise>
			          </c:choose>
			          
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
			                 <td><span class="state1">待审核</span></td>
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
		
		<c:if test="${leaveListSize >19}">
			<ul>
			    <li><a href="#" id="op_all_save" onclick="loadMoreLeaveList()">查看更多</a></li>
			</ul>
		</c:if>
		
	 </c:if>
	 
	 
	<input type="hidden" id="roleCode" name="roleCode" value="${roleCode}">
	<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
	<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
	<input type="hidden" id="cPage" name="cPage" value="${cPage}">
	<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut}">
	 
	<div class="select_role">
		<dl>
			<c:if test="${roleListSize >1}">
			<dd class="role_more iconfont" data-toggle="modal" href="#static">&#xe601;</dd>
			</c:if>
			<c:if test="${sessionScope.user.type != 2}">
				<dd class="role_add iconfont" id="addLeave">&#xe603;</dd>
			</c:if>
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

			//点击进入申请请假页面
			$("#addLeave").click(function(){
				var roleCode = $("#roleCode").val();
				var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				standardPost('<%=basePath%>leave/toLeaveAppAdd.do',{roleCode:roleCode,apiKey:apiKey,schoolId:schoolId});
			});

			$("#role").on("click",function(){
				$("#static").modal("show");
			})

			$(".more_role_choose li").on("click",function(){
				$("#roleCode").val($(this).attr("id"));
				var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				var roleCode = $(this).attr("id");
				standardPost('<%=basePath%>leave/toLeaveAppList.do',{roleCode:roleCode,apiKey:apiKey,schoolId:schoolId});
			})
			
		});


		function loadMoreLeaveList()
		{
			
			var cPage = $("#cPage").val();
			var roleCode = $("#roleCode").val();
			loadLeaveList(null, roleCode, cPage);
		}
		
		
		//加载请假列表
		function loadLeaveList(userId, roleCode, cPage)
		{
			$.ajax({
				type: "post",
				url: "<%=basePath%>leave/getLeaveListApp.do",
				data:{
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
					$.each(data.leaveList, function(n, value) {  
						
						if (n%2 == 0)
						{
							appendHtml += '<tr style="background-color: #f2f2f2">';
						}
						else
						{
							appendHtml += '<tr>';
						}	
						//请假人
           				appendHtml += '<td>' + value.userName + '</td>';
						//请假开始时间
           				appendHtml += '<td>' + value.startTime + '</td>';
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
           						appendHtml += '<td><span class="state1">待审核</span></td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td><span class="state3">已批准</span></td>';
           						break; 
           					case 2 : 
           						appendHtml += '<td><span class="state2">已拒绝</span></td>';
           						break; 
           					default : 
           						appendHtml += '<td><span class="state1">待审核</span></td>';
           						break;
           				} 
           				appendHtml += '</tr>';
          			}); 

				    $("#tbody").append(appendHtml);
          		//	$("#tbody").html(appendHtml);
				},
			});
		}

	</script>
</html>