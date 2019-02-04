<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>会议刷卡记录</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body">
	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>会议刷卡记录
	</div>
	
	<c:if test="${listSize == 0}">
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
	</c:if>
	
	<c:if test="${listSize > 0}">
	
		<ul class="inout_list">
		
		    <c:forEach items="${meetingInoutList}" var="m">
		        <li>
			        <c:if test="${m.status==0}">
			           <em class="Push">正</em>
			        </c:if>
			        <c:if test="${m.status==1}">
			           <em class="late">迟</em>
			        </c:if>
			        <c:if test="${m.status==3}">
			           <em class="Leave">缺</em>
			        </c:if>
			        <c:if test="${m.status!=1 && m.status!=0 && m.status!=3}">
			           <em class="Leave">其</em>
			        </c:if>
		            <p class="top_p">
		              <span class="span_left">${m.realName}</span>
		              <span class="span_right">${m.createTime}</span>
		           </p>
		           <p>
		              <i class="fa fa-map-marker"></i>
		              <span class="span3">${m.positionName}</span>
	               </p>
		        </li>
		    </c:forEach>
			
		</ul>
			
	  	<c:if test="${listSize >19}">
			<a href="#" id="op_all_save" class="op_all_save" onclick="loadMoreList()">查看更多</a>
		</c:if>
	</c:if>
	
	<input type="hidden" id="cPage" value="${cPage}">
	<input type="hidden" id="apiKey" value="${apiKey}">
	<input type="hidden" id="schoolId" value="${schoolId}">
	<input type="hidden" id="queryContent" value="${queryContent}">
	<input type="hidden" id="inoutType" value="${inoutType}">
	<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut}">
	<input type="hidden" id="status" value="${status}">
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
	<script type="text/javascript">

	$(function(){
		var timeOut = $("#apiKeyTimeOut").val();
		if(timeOut == '1')
		{
			alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
		}

		$("#search").on("click",function(){
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var status = $("#status").val();
			var queryContent = $("#queryContent").val();
			standardPost('<%=basePath%>meetingInout/toMeetingInoutSearchAPP.do',{apiKey:apiKey,schoolId:schoolId,status:status,queryContent:queryContent});
			})
	})

	function loadMoreList()
	{
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var queryContent = $("#queryContent").val();
		var cPage = $("#cPage").val();
		var inoutType = $("#inoutType").val();
		var apiKeyTimeOut =$("#apiKeyTimeOut").val();
		var status =$("#status").val();
		
		$.ajax({
			type: "post",
			url: "<%=basePath%>meetingInout/loadMoreMeetingInoutListAPP.do",
			data:{
					apiKey : apiKey,
					schoolId : schoolId,
					queryContent : queryContent,
					inoutType : inoutType,
					apiKeyTimeOut : apiKeyTimeOut,
					status : status,
					cPage : cPage
			},
			success: function(data){
				var data = eval("(" + data + ")");
   				$("#queryContent").val(data.queryContent);
   				$("#cPage").val(data.cPage);
   				$("#apiKeyTimeOut").val(data.apiKeyTimeOut);
   				$("#inoutType").val(data.inoutType);
   				
   				var listSize = data.listSize;
   				if(listSize < 19)
   	   			{
   					$("#op_all_save").hide();
   	   	   		}
				var appendHtml = '';
				
				$.each(data.meetingInoutList, function(n, value) { 
					appendHtml += '<li>';
					var status = value.status;
					if(status == 0)
					{
       					appendHtml += '<em class="Push">正</em>';
               		} else if(status == 1)
               		{
              			appendHtml += '<em class="late">迟</em>';
               		} else if(status == 3)
               		{
              			appendHtml += '<em class="Leave">迟</em>';
               		}
       				else
           			{
       					appendHtml += '<em class="Leave">其</em>';
               		}

					appendHtml += '<p class="top_p">';
					appendHtml += '<span class="span_left">'+value.realName+'</span>';
					appendHtml += '<span class="span_right">'+value.createTime+'</span>';
					appendHtml += '</p>';
					appendHtml += '<p>';
					appendHtml += '<i class="fa fa-credit-card"></i>';
					appendHtml += '<span class="span3">'+value.positionName+'</span>';
					appendHtml += '</p>';
       				appendHtml += '</li>';

      			}); 
      			
      			$(".inout_list").append(appendHtml);
			},
		});
	}
	
	</script>

</html>