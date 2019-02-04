<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<title>新闻详细页面</title>
	<link href="<%=basePath%>assets/global/css/app_m.css" rel="stylesheet" type="text/css"/>
</head>

<body>
  <input type="hidden" value="${schoolId }" id="schoolId" />
  	<c:if test="${isExist}">
	<div class="news">
			<h2>${schoolNewsInfo.newsTitle }</h2>
			<h3>
				作者：${schoolNewsInfo.newsAuthor}
				${schoolNewsInfo.createTime }
			</h3>
			<div id="nameGroup">
				${schoolNewsInfo.newsContent }
				<c:if test="${schoolNewsInfo.functionType==1 || schoolNewsInfo.functionType==3}">
					<p>联系电话：${schoolNewsInfo.phone}</p>
				</c:if>
			</div>
			<div class="zixun">
				<c:if test="${schoolNewsInfo.newsType==3 && schoolNewsInfo.functionType==l}">
					<div class="abc"></div>
				</c:if>
				<c:if test="${schoolNewsInfo.newsType==3 && schoolNewsInfo.functionType==2}">
					<input type="button"class="baoming" onclick="baoming()" value="我要报名" />
				</c:if>
				<c:if test="${schoolNewsInfo.newsType==3 && schoolNewsInfo.functionType==3}">
					<div class="abc"></div>
				</c:if>
				<c:if test="${schoolNewsInfo.newsType==2 && schoolNewsInfo.functionType==2}">
					<input type="button"class="baoming" onclick="takepartin()" value="我要参加" />
				</c:if>
			</div>
			<div class="bbs" onclick="forwardComments('${schoolNewsInfo.newsId}')">
				<span class="text-input" ></span>
				<span class="text-submit">发表</span>
			</div>
			<input type="hidden" value="${schoolNewsInfo.newsId }" id="newsId" />
			<input type="hidden" value="${schoolNewsInfo.phone }" id="phone" />
			<input type="hidden" value="${schoolNewsInfo.functionType }" id="functionType" />
			<input type="hidden" value="${schoolNewsInfo.newsType }" id="newsType" />
		</c:if>
	</div>
	<c:if test="${!isExist}">
			<img style="max-width:100%;display:block;margin:30% auto 25px" src="<%=basePath%>assets/global/img/m_img/del.png">
		<p class="m_text_conter">
			很抱歉，此信息已被删除
		</p>
	</c:if>
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script>
		$(function() {  
			if(IsPC()==2){
				var _div='';
				var functionType = $("#functionType").val();
				var newsType = $("#newsType").val();
				var phone = $("#phone").val();
				if(newsType==3 && functionType==1)
				{
					_div+='<a id="zixunButton" onclick="window.richbook.onCall(\''+phone+'\')" class="tel">我要咨询 <i class="icon-hand-right"></i>'+phone+'</a>';
				}else if(newsType==3 && functionType==3)
				{
					_div+='<a id="zixunButton" onclick="window.richbook.onCall(\''+phone+'\')" class="tel">我要咨询 <i class="icon-hand-right"></i>'+phone+'</a>';
					_div+='<input type="button" class="baoming" onclick="baoming()" value="我要报名" />';
				}
				$(".abc").append(_div);
			}else if(IsPC()==3){
				var _div='';
				var functionType = $("#functionType").val();
				var newsType = $("#newsType").val();
				var phone = $("#phone").val();
				if(newsType==3 && functionType==1)
				{
					_div+='<a style="height: 35px;line-height:35px;width: 90%!important;margin: 15px auto 0;background-color:#1ABDE6;border: none;border-radius: 15px!important;display: inline-block; color: #fff;" href="dialNumber@'+phone+'">我要咨询<i class="icon-hand-right"></i>'+phone+'</a>';
				}else if(newsType==3 && functionType==3)
				{
					_div+='<a style="height: 35px;line-height:35px;width: 90%!important;margin: 15px auto 0;background-color:#1ABDE6;border: none;border-radius: 15px!important;display: inline-block; color: #fff;" href="dialNumber@'+phone+'">我要咨询<i class="icon-hand-right"></i>'+phone+'</a>';
					_div+='<input type="button" class="baoming" onclick="baoming()" value="我要报名" />';
				}
				$(".abc").append(_div);
			}
	
		});
		
		function forwardComments(id){
			/* if(!isLogin()){
				$("#loginDialog").modal("show");
			}else{ */
				window.open("<%=basePath %>schoolNewsLook/forwardCommentsPhone.do?newsId="+id+"&schoolId="+$("#schoolId").val());
			/* } */
		}
		
		function isLogin(){
			var isLog;
			$.ajax({
				type: "post",
				async:false,
				url: "<%=basePath%>user/isLogin.do",
				data:{
					schoolId:$("#schoolId").val()
				},
				success:function(data){
					var isL = eval("("+data+")");
					if(isL+""=="true"){
						isLog = true;
					}else{
						isLog = false;	
					}
				}
			});
			return isLog;
		}
		function baoming(){
			window.open("<%=basePath %>schoolNewsLook/applyInfoPhone.do?schoolId="+$("#schoolId").val()+"&newsId="+$("#newsId").val());
		}

		function takepartin()
		{
			window.open("<%=basePath %>schoolNewsLook/toTakePartInActivityPhone.do?schoolId="+$("#schoolId").val()+"&newsId="+$("#newsId").val());
		}
	</script>
</html>