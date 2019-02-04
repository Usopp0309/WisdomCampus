<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>我的会议</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束-->
	<style type="text/css">
	 .look{
	    font-size:14px;
	    color:#00a0ff;
	    margin-left:5px;
	 }
	 .form-group{margin-bottom: 0px;}
     .form_list{padding:2%;}
	</style> 
</head>

<body id="body">

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>会议记录
	</div>
	
	<c:if test="${listSize == 0}">
		<div class="null_con">
			<img src="<%=basePath%>assets/global/img/m_img/null.png">
		</div>
	</c:if>
	
	<c:if test="${listSize > 0}">
	
		<form action="<%=basePath%>meetingDetail/toMeetingDetailListByHuxinId.do" id="submitForm"  class="form-horizontal" method="post">
		<ul class="inout_list">
<!-- 			<div class="p_search"> -->
<!-- 				<input type="text" name="queryContent" pattern="会议名称、地点">  -->
<!-- 					<i id="top_search" class="m_icon-search"></i> -->
<!-- 			</div> -->
			
			<c:forEach items="${meetingList}" var="m" varStatus="index">
			        <li>
			        	<c:if test="${m.attenStatus == 0}">
				           <em class="Push">正</em>
				        </c:if>
				        <c:if test="${m.attenStatus == 1}">
				           <em class="late">迟</em>
				        </c:if>
				        <c:if test="${m.attenStatus == 3}">
				           <em class="Leave">缺</em>
				        </c:if>
				        <c:if test="${m.attenStatus != 0 && m.attenStatus != 1 && m.attenStatus != 3}">
				           <em class="Push">正</em>
				        </c:if>
				        <p class="top_p">
				        	<span class="span_left">${m.meetingName}</span>
				        	<span class="span_right">${m.meetingPlaceName}</span>
				          	<span id="span_${index.index}" class="glyphicon glyphicon-chevron-up" data-toggle="collapse" data-target="#demo_${index.index}" onclick="downUp(this);"></span>
				        </p>
				        <p>
					       	${m.meetingTime}
				        </p>
				       <!--每项列表隐藏的内容start -->
				       
				           <div id="demo_${index.index}" class="collapse out" style="background:white;">
				               <div class="container" style="padding-left:48px;">
					               
	                              <div class="form_list">
	                                 <span>名称：</span>
	                                 <span>${m.meetingName }</span>
	                              </div>
	                              
	                              <div class="form_list">
	                                <span>内容：</span>
	                                <span>${m.content }</span>
	                              </div>
	                              
	                              <div class="form_list">
	                              	<span>时间：</span>
	                                <span>${m.meetingTime }</span>
	                              </div>
	                              
	                               <div class="form_list">
	                                <span>地点：</span>
	                                <span>${m.meetingPlaceName }</span>
	                               </div>
	                             
	                              <div class="form_list">
	                                    <button type="button" class="btn btn-success" onclick="todetail(${m.meetingId});">会议详情</button>
					                    <c:if test="${m.status == 0}">
				        					<button type="button" class="btn btn-success" onclick="sign(${m.meetingId});">签到</button>
				        				</c:if>
					             </div>
                             
                            </div> 
				         </div>
				          <!--每项列表隐藏的内容end -->
				     </li>
			    </c:forEach>
			    
		<c:if test="${listSize >19}">
			<a href="#" id="op_all_save" class="op_all_save" onclick="loadMoreList()">查看更多</a>
		</c:if>
		</form>
	</c:if>
	
	<input type="hidden" id="cPage" name="cPage" value="${cPage}">
	<input type="hidden" id="apiKey" name="apiKey" value="${apiKey}">
	<input type="hidden" id="schoolId" name="schoolId" value="${schoolId}">
	<input type="hidden" id="queryContent" name="queryContent" value="${queryContent}">
	<input type="hidden" id="apiKeyTimeOut" value="${apiKeyTimeOut}">
	<input type="hidden" id="meetingId" value="">
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->  
	
	<script type="text/javascript">
/*websocket开始*/
	var currentUserId = ${userId};
	var schoolId=${schoolId};
	var wsServer = 'ws://${serverName}:9350'; 
	var webSocket = null;
	  if (!window.WebSocket){
	    alert("你的浏览器不支持websocket，请升级到IE10以上浏览器，或者使用谷歌、火狐、360浏览器。");
	  }
	  webSocket = new WebSocket(wsServer);
	  webSocket.onerror = function(event) {
	    alert("websockt连接发生错误，请刷新页面重试!")
	  };
	// 连接成功建立的回调方法
	  webSocket.onopen = function(event) {
	    webSocket.send("_online_user_"+currentUserId+"&&"+schoolId);
	  };
	// 接收到消息的回调方法
	  webSocket.onmessage = function(event) {
	    var res=event.data;
	    //TODO 提示签到成功，并且更新页面状态
	    if(res.indexOf("_msg_")>=0){
	    	var arra = res.split("_msg_");
	    	//更新状态
	    	layer.msg("签到成功");
	    	location.reload();
	    }
	  };
     //切换在线状态的方法
	  function setonline() {
		webSocket.send("_online_user_"+currentUserId+"&&"+schoolId);
	  };
	//切换离线状态的方法
	  function sethide() {
		webSocket.send("_leave_user_"+currentUserId+"&&"+schoolId);
	  };

	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
	window.onbeforeunload = function(){
	    websocket.close();
	};
	function downUp(obj){
		 var cutid=$(obj).attr("id").split("_")[1];
		  $("div[id^='demo_']").each(function(){
			  var id=$(this).attr("id").split("_")[1];
			  if(cutid!=id){
			  if($("#span_"+id).hasClass("glyphicon-chevron-down")){
	        	    $("#span_"+id).removeClass("glyphicon-chevron-down");
	        	    $(this).removeClass("in");
	        	    $("#span_"+id).addClass("glyphicon-chevron-up");
	               }
			  }
			  });
		  
           if($(obj).hasClass("glyphicon-chevron-down")){
        	    $(obj).removeClass("glyphicon-chevron-down");
        	    $(obj).addClass("glyphicon-chevron-up");
               }else{
            	$(obj).addClass("glyphicon-chevron-down");
           	    $(obj).removeClass("glyphicon-chevron-up");
               }
	}
/*websocket结束*/

		$(function(){
			$("#top_search").on("click",function(){
				$("#cPage").val(1);
				$("#submitForm").submit();
			})

			var timeOut = $("#apiKeyTimeOut").val();
			if(timeOut == '1')
			{
				alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
			}
		})
		
		//签到功能
		function sign(meetingId){
			$("#meetingId").val(meetingId);
			if(IsPC() == 2){//Android
				window.richbook.sign();
			}else if (IsPC() == 3){//IOS
				window.location.href="index.jsp?sign=filter";
			}
		} 
		//设置手机端本地信息
		/*wifi名称&&定位信息&&手机名称
		  例子:Admin的Mac mini&&0.0,0.0&&明亮iPhone6s
		  Admin的Mac mini&&31.976434,118.771511&&明亮iPhone6s')
		  NoWiFi&&31.976457,118.771541&&明亮iPhone6s
		*/
		function setLocationInfo(info){
			var meetingId = $("#meetingId").val();
			webSocket.send("_sendLocation_"+info+"&&"+meetingId+"&&"+currentUserId+"&&"+schoolId);
		}

		//关闭websocket
		function closeWebsocket(){
			websocket.close();
		}
		
		//加载更会议信息
		function loadMoreList()
		{
			var apiKey = $("#apiKey").val();
			var schoolId = $("#schoolId").val();
			var queryContent = $("#queryContent").val();
			var cPage = $("#cPage").val();
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>meetingDetail/loadMoreMeetingDetailAPP.do",
				data:{
						apiKey : apiKey,
						schoolId : schoolId,
						queryContent : queryContent,
						cPage : cPage
				},
				success: function(data){
					var data = eval("(" + data + ")");
					
	   				$("#queryContent").val(data.queryContent);
	   				$("#cPage").val(data.cPage);
	
	   				var listSize = data.listSize;
	   				if(listSize < 19)
	   	   			{
	   					$("#op_all_save").hide();
	   	   	   		}
					var appendHtml = '';
					
					$.each(data.meetingList, function(n, value) { 
	
						appendHtml += '<li>';
						var status = value.attenStatus;
				        if(status == 0)
				        {
			        		appendHtml += '<em class="Push">正</em>';
			        	}else if(status == 1)
				        {
		        			appendHtml += '<em class="late">迟</em>';
				        }else if(status == 3)
				        {
			        		appendHtml += '<em class="Leave">缺</em>';
				        }else
				        {
			        		appendHtml += '<em class="Push">正</em>';
				        }
				        appendHtml += '<p class="top_p">';
				        appendHtml += '<span class="span_left">'+value.meetingName+'</span>';
				        appendHtml += '<span class="span_right">'+value.meetingPlaceName+'</span>';
				        if(value.status == 0){
				        	appendHtml += '<button type="button" id="sign'+value.meetingId+'"class="btn btn-success btn-sm" onclick="sign('+value.meetingId+');">签到</button>';
					    }
				        appendHtml += '</p>';
				        appendHtml += '<p>'+value.meetingTime+'</p>';
	       				appendHtml += '</li>';
	      			}); 
	      			
	      			$(".inout_list").append(appendHtml);
				},
			});
		}
		
		function todetail(meetingId){
			standardPost('<%=basePath%>meetingDetail/toMeetingDetailApp.do',{meetingId:meetingId,currentPage:null});
		}
	</script>
</html>