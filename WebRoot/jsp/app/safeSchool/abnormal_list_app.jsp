<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
	<title>异常信息</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body id="body">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>异常信息
	</div>
	
	<c:if test="${listSize == 0}">
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
	</c:if>
	
	<form action="<%=basePath%>abnormal/toAbnormalListByHuxinId.do"  id="addForm" class="form-horizontal" method="post">
		<c:if test="${listSize > 0}">	
			<ul class="inout_list">
				<c:forEach items="${abnormalList}" var="a">
			        <li>
			        	<c:if test="${a.type==1}">
							<em class="Leave">早</em>
						</c:if>
						<c:if test="${a.type==0}">
							<em class="late">迟</em>
						</c:if>
						<c:if test="${a.type!=1 && a.type!=0}">
							<em class="abnormal">未</em>
						</c:if>
						
			            <p class="top_p">
				           <span class="span_left">${a.realName}</span>
				           <span class="span_right">${a.createTime}</span>
			           </p>
			           <p class="info">${a.content}</p>
			        </li>
			    </c:forEach>
			</ul>
		  	<c:if test="${listSize >19}">
				<a id="op_all_save" class="op_all_save" onclick="loadMoreList()">查看更多</a>
			</c:if>
	    </c:if>	
	    <input type="hidden" id="cPage" value="${cPage}">
		<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
		<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
		<input type="hidden" id="type" value="${type}">
		<input type="hidden" id="roleCode" name="roleCode" value="${roleCode}">
		<input type="hidden" id="name" value="${name}">
		<input type="hidden" id="abnormalType" value="${abnormalType}">
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

    	$(".more_role_choose li").on("click",function(){
			$("#roleCode").val($(this).attr("id"));
			var s=document.getElementById("addForm");
			s.submit();
		})

	
		$("#search").on("click",function(){
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var roleCode = $("#roleCode").val();
			standardPost('<%=basePath%>jsp/app/safeSchool/abnormal_search_app.jsp',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
			})
		
		$("#role").on("click",function(){
			$("#static").modal("show");
		})
		
		var timeOut = $("#apiKeyTimeOut").val();
		if(timeOut == '1')
		{
			alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
		}
	      
	});
	function seturl(){
		
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var roleCode = $("#roleCode").val();
		standardPost('<%=basePath%>jsp/app/safeSchool/abnormal_search_app.jsp',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode});
	}
  	//查看更多
	function loadMoreList()
	{
		
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var type = $("#type").val();
		var name = $("#name").val();
		var abnormalType = $("#abnormalType").val();
		var cPage = $("#cPage").val();
		var roleCode = $("#roleCode").val();

		$.ajax({
			type: "post",
			url: "<%=basePath%>abnormal/toLoadMoreAbnormalListAPP.do",
			data:{
					apiKey : apiKey,
					schoolId : schoolId,
					type : type,
					name : name,
					abnormalType : abnormalType,
					roleCode : roleCode,
					cPage : cPage
			},
			success: function(data){

				var data = eval("(" + data + ")");
				
				$("#type").val(data.type);
   				$("#name").val(data.name);
   				$("#abnormalType").val(data.abnormalType);
   				$("#cPage").val(data.cPage);

   				var listSize = data.listSize;
   				if(listSize < 19)
   	   			{
   					$("#op_all_save").hide();
   	   	   		}
   				
				var appendHtml = '';
				
				$.each(data.abnormalList, function(n, value) {  

					appendHtml += '<li>';
					//类型
					var type = parseInt(value.type);

		            switch(type)
		             { 
		             case 1:
		            	 appendHtml += '<em class="Leave">早</em>';
       				     break;
       				 case 0:
       					appendHtml += '<em class="late">迟</em>';
                         break;                        
                     default :  
                    	 appendHtml += '<em class="abnormal">未</em>';
                         break;
       				 } 
					appendHtml += '<p class="top_p">';
   					appendHtml += '<span class="span_left">'+value.realName+'</span>';
   					appendHtml += '<span class="span_right">'+value.createTime+'</span>';
   					appendHtml += '</p>';
   					//短信内容
					if (value.content == undefined)
					{
						appendHtml += '<p class="info"></p>';
					}
					else
					{
						appendHtml += '<p class="info">' + value.content + '</p>';
					}
   					
       				appendHtml += '</li>';

      			}); 
      			
      			$(".inout_list").append(appendHtml);
			},
		});
	}


    </script>
</html>