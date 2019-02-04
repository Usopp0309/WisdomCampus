<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>进出宿舍</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body id="body">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>进出宿舍
	</div>
	
	<c:if test="${listSize == 0}">
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
	</c:if>
	
	<form action="<%=basePath%>dormitory/toDormitoryInoutListByHuxinId.do"  id="addForm" class="form-horizontal" method="post">
		<c:if test="${listSize > 0}">
			<ul class="inout_list">
			    <c:forEach items="${dormitoryList}" var="d">
			        <li>
				        <c:if test="${d.status==1}">
				           <em class="error_enter">进</em>
				        </c:if>
				        <c:if test="${d.status==2}">
				           <em class="error_aut">出</em>
				        </c:if>
			             <p class="top_p">
			              <span class="span_left">${d.realName}</span>
			              <span class="span_right">${d.createTime}</span>
			           </p>
			           <p>
			              <i class="fa fa-credit-card"></i>
			              <span class="span3">${d.code}</span>
			              <span class="span3">${d.positionName}</span>
		               </p>
		               <p>
		               	  <span class="span2">${d.itemName}</span>
		               </p>
			        </li>
			    </c:forEach>
			</ul>
		  	<c:if test="${listSize >19}">
				<a href="#" id="op_all_save" class="op_all_save" onclick="loadMoreList()">查看更多</a>
			</c:if>
		</c:if>
		
		<input type="hidden" id="cPage" value="${cPage}">
		<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
		<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
		<input type="hidden" id="inoutType" value="${inoutType}">
		<input type="hidden" id="type" value="${type}">
		<input type="hidden" id="queryContent" value="${queryContent}">
		<input type="hidden" id="startDate" value="${startDate}">
		<input type="hidden" id="startTime" value="${startTime}">
		<input type="hidden" id="endDate" value="${endDate}">
		<input type="hidden" id="endTime" value="${endTime}">
		<input type="hidden" id="roleCode" name="roleCode" value="${roleCode}">
		<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut}">
	</form>
	
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
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	
    <script type="text/javascript">

    $(function() {    
		var timeOut = $("#apiKeyTimeOut").val();
		if(timeOut == '1')
		{
			alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
		}

		$(".more_role_choose li").on("click",function(){
			$("#roleCode").val($(this).attr("id"));
			var s=document.getElementById("addForm");
			s.submit();
		})
	
		$("#search").on("click",function(){
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var roleCode = $("#roleCode").val();
			standardPost('<%=basePath%>jsp/app/dormitory/dormitory_inout_list_search_app.jsp',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
			})
		
		$("#role").on("click",function(){
			$("#static").modal("show");
		})
	      
	});
	function seturl(){
		
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var roleCode = $("#roleCode").val();
		standardPost('<%=basePath%>jsp/app/dormitory/dormitory_inout_list_search_app.jsp',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
	}
  	//查看更多
	function loadMoreList()
	{
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var type = $("#type").val();
		var inoutType = $("#inoutType").val();
		var queryContent = $("#queryContent").val();
		var startDate = $("#startDate").val();
		var startTime = $("#startTime").val();
		var endDate = $("#endDate").val();
		var endTime = $("#endTime").val();
		var cPage = $("#cPage").val();
		var roleCode = $("#roleCode").val();

		$.ajax({
			type: "post",
			url: "<%=basePath%>dormitory/toLoadDormitoryInoutListByHuxinId.do",
			data:{
					apiKey : apiKey,
					schoolId : schoolId,
					type : type,
					inoutType : inoutType,
					queryContent : queryContent,
					startDate : startDate,
					startTime : startTime,
					endDate : endDate,
					endTime : endTime,
					roleCode : roleCode,
					cPage : cPage
			},
			success: function(data){

				var data = eval("(" + data + ")");
				
				$("#type").val(data.type);
   				$("#inoutType").val(data.inoutType);
   				$("#queryContent").val(data.queryContent);
   				$("#startDate").val(data.startDate);
   				$("#startTime").val(data.startTime);
   				$("#endDate").val(data.endDate);
   				$("#endTime").val(data.endTime);
   				$("#cPage").val(data.cPage);

   				var listSize = data.listSize;
   				if(listSize < 19)
   	   			{
   					$("#op_all_save").hide();
   	   	   		}
   				
				var appendHtml = '';
				
				$.each(data.dormitoryList, function(n, value) {  

					appendHtml += '<li>';
					var status = value.status;
					if(status == 1)
					{
       					appendHtml += '<em class="error_enter">进</em>';
               		}
       				else
           			{
       					appendHtml += '<em class="error_aut">出</em>';
               		}

					appendHtml += '<p class="top_p">';
					appendHtml += '<span class="span_left">'+value.realName+'</span>';
					appendHtml += '<span class="span_right">'+value.createTime+'</span>';
					appendHtml += '</p>';
					appendHtml += '<p>';
					appendHtml += '<i class="fa fa-credit-card"></i>';
					appendHtml += '<span class="span3">'+value.code+'</span>';
					appendHtml += '<span class="span3">'+value.positionName+'</span>';
					appendHtml += '</p>';
					appendHtml += '<p>';
					appendHtml += '<span class="span2">'+value.itemName+'</span>';
					appendHtml += '</p>';
       				appendHtml += '</li>';

      			}); 
      			
      			$(".inout_list").append(appendHtml);
			},
		});
	}
    </script>
</html>