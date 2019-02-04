<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>新闻详情</title>
	<%@ include file="/public_module/public_css_new.jsp"%>
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link href="<%=basePath%>assets/global/css/news_m.css" rel="stylesheet" type="text/css"/>
</head>
<body>
  <input type="hidden" value="${schoolId }" id="schoolId" />
  <input type="hidden" value="${schoolNewsInfo.newsId }" id="newsId" />
	<div class="header">
		<div class="top">
			<div class="logo"><img src="<%=basePath%>assets/global/img/m_img/logo_main.png"></div>
		</div>
	</div>
	<div class="control-group news_detail">
		<div class="control-group">
			<h2>${schoolNewsInfo.newsTitle }</h2>
		</div>

		<div class="control-group news_detail_info" id="nameGroup">
			<span style="">${schoolNewsInfo.createTime }</span>
		</div>

		<div class="control-group " id="nameGroup">
			${schoolNewsInfo.newsContent }

			<c:if
				test="${schoolNewsInfo.newsType==3 && (schoolNewsInfo.functionType==1 || schoolNewsInfo.functionType==3)}">
				<p>联系电话：${schoolNewsInfo.phone}</p>
			</c:if>
		</div>

		<div class="control-group operation">
			<c:if
				test="${schoolNewsInfo.newsType==3 && (schoolNewsInfo.functionType==2 || schoolNewsInfo.functionType==3)}">
				<input class="enroll" type="button" onclick="baoming()" value="我要报名" />
			</c:if>
			<c:if
				test="${schoolNewsInfo.newsType==2 && schoolNewsInfo.functionType==2}">
				<input class="enroll" type="button" onclick="takepartin()"
					value="我要参加" />
			</c:if>
		</div>

		<p class="control-group news_detail_share">
			<span>分享到:</span> <span> <script type="text/javascript">
									(function(){
									var p = {
									url:'<%=basePath%>schoolNewsLook/forwardDetail.do?newsId="+${schoolNewsInfo.newsId }+"&schoolId="+${schoolId }', 
									desc:'', /*分享理由(风格应模拟用户对话),支持多分享语随机展现（使用|分隔）*/
									title:'', /*分享标题(可选)*/
									summary:'', /*分享摘要(可选)*/
									pics:'', /*分享图片(可选)*/
									flash: '', /*视频地址(可选)*/
									site:'', /*分享来源(可选) 如：QQ分享*/
									style:'202',
									width:24,
									height:24
									};
									var s = [];
									for(var i in p){
									s.push(i + '=' + encodeURIComponent(p[i]||''));
									}
									document.write(['<a class="qcShareQQDiv" href="http://connect.qq.com/widget/shareqq/index.html?',s.join('&'),'" target="_blank">分享到QQ</a>'].join(''));
									})();
									</script> <script src="http://connect.qq.com/widget/loader/loader.js"
					widget="shareqq" charset="utf-8"></script>
			</span> <span> <script type="text/javascript">
									(function(){
									var p = {
									url:'<%=basePath%>schoolNewsLook/forwardDetail.do?newsId="+${schoolNewsInfo.newsId }+"&schoolId="+${schoolId }', 
									showcount:'0',/*是否显示分享总数,显示：'1'，不显示：'0' */
									desc:'',/*默认分享理由(可选)*/
									summary:'',/*分享摘要(可选)*/
									title:'',/*分享标题(可选)*/
									site:'',/*分享来源 如：腾讯网(可选)*/
									pics:'', /*分享图片的路径(可选)*/
									style:'202',
									width:31,
									height:31
									};
									var s = [];
									for(var i in p){
									s.push(i + '=' + encodeURIComponent(p[i]||''));
									}
									document.write(['<a version="1.0" class="qzOpenerDiv" href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?',s.join('&'),'" target="_blank">分享</a>'].join(''));
									})();
									</script> <script
					src="http://qzonestyle.gtimg.cn/qzone/app/qzlike/qzopensl.js#jsdate=20111201"
					charset="utf-8"></script>
			</span> <span><img onclick="shareWeixin()"
				src="<%=basePath %>assets/global/img/m_img/weixin.png"></span> <span><img
				onclick="shareWeixin()"
				src="<%=basePath %>assets/global/img/m_img/yixin.png"></span>
		</p>
		<div class="news_detail_bbs">
			<p>我要评论</p>
			<textarea id="commentContent" rows="5"></textarea>
			<div class="m_btn">
				<span id="pingIsSuccess" class="success">评论成功</span><span
					style="float: right;"><input type="button"
					onclick="sendComment()" value="发表评论" /></span>
			</div>
			<div class="more">
				<a onclick="forwardComments('${schoolNewsInfo.newsId }')"
					href="javascript:void(0)">点击查看更多评论</a>
			</div>
		</div>
	</div>
	</div>
	<div class="modal hide fade" id="loginDialog" tabindex="-1" role="dialog">
	<div class="login">
		<h2>用户登录<button type="button" data-dismiss="modal" class="m_close">X</button></h2>
		<input class="logon_input" type="text" id="account" />
		<input class="logon_input" type="password" id="password" />
		<input class="logon_btn" type="button" onclick="login()" value="登录"/>
	</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="erweima">
		<h2>分享<button type="button" data-dismiss="modal" class="m_close">X</button></h2>
		
	   <img alt="" id="imagePath" src="" style="display:block;margin:0px auto;">
	   </div>
	</div>
	<%@ include file="/public_module/public_footer.jsp" %>
    <%@ include file="/public_module/public_js.jsp"%>
	<!-- 默认配置文件 -->
    <script src="<%=basePath %>assets/global/plugins/schoolnews/ueditor.config.js" type="text/javascript" charset="utf-8" ></script>
    <script src="<%=basePath %>assets/global/plugins/schoolnews/ueditor.all.js" type="text/javascript" charset="utf-8" > </script>
    <!-- 语言文件 -->
    <script src="<%=basePath %>assets/global/plugins/schoolnews/lang/zh-cn/zh-cn.js" type="text/javascript" charset="utf-8" ></script>
    <!-- 如果需要页面渲染的话引入 -->
    <script src="<%=basePath %>assets/global/plugins/schoolnews/ueditor.parse.min.js" type="text/javascript" charset="utf-8" ></script>
	<script type="text/javascript">
		$(function() {
			$('#school').click(function(){
				$("#clazzSelect").hide();
        	});  
			$('#clazz').click(function(){
				$("#clazzSelect").show();
        	});
        	$("#imagePath").attr("src","http://qr.topscan.com/api.php?text="+"<%=basePath %>schoolNewsLook/forwardDetailPhone.do?schoolId="+$("#schoolId").val()+"%26newsId="+$("#newsId").val());
		});
		function login(){
			var account = $("#account").val();
			var password = $("#password").val();
			if(null==account||""==$.trim(account)){
				alert("请输入账号");
				return false;
			}
			if(null==password||""==$.trim(password)){
				alert("请输入密码");
				return false;
			}
			$.ajax({
				type: "post",
				async:false,
				url: "<%=basePath%>user/doCheckUsernamePassword.do",
				data:{
						username : account,
						password : password
				},
				success:function(data){
					var result = eval("(" + data + ")");
				    var flag = result["reg"];
				    if(flag)
			        {
			            alert("用户名或密码不对");
			        }
			        else
			        {
			            alert("登陆成功");
			            $("#loginDialog").modal("hide");
			        }
				}
			}); 
		}
		function sendComment(){
			if(!isLogin()){
				$("#loginDialog").modal("show");
			}else{
				var newsId = ${schoolNewsInfo.newsId};
				var commentContent = $("#commentContent").val();
				var commentType = "1";
				if($.trim(commentContent)==""){
				}else{
					$.ajax({
						url:"<%=basePath %>schoolNewsLook/addComment.do",
						data:{
							newsId : newsId,
							commentContent : commentContent,
							commentType : commentType,
							parentId : "0"
						},
						type:"post",
						success:function(data){
							if(data){
								$("#commentsCount").html(parseInt($("#commentsCount").html())+1);
								$("#pingIsSuccess").show();
								setTimeout(function(){
									$("#pingIsSuccess").hide(1000);
								},1000);
								$("#commentContent").html("");
							}
						}
					});
				}
			}
		}
		function forwardComments(id){
			var schoolId = $("#schoolId").val();
			window.open("<%=basePath %>schoolNewsLook/forwardComments.do?newsId="+id+"&schoolId="+schoolId);
		}
		function IsPC() {
		    var userAgentInfo = navigator.userAgent;
		    var Agents = ["Android", "iPhone",
		                "SymbianOS", "Windows Phone",
		                "iPad", "iPod"];
		    var flag = true;
		    for (var v = 0; v < Agents.length; v++) {
		        if (userAgentInfo.indexOf(Agents[v]) > 0) {
		            flag = false;
		            break;
		        }
		    }
		    return flag;
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
			window.open("<%=basePath %>schoolNewsLook/applyInfoForward.do?schoolId="+$("#schoolId").val()+"&newsId="+$("#newsId").val());
		}

		function takepartin()
		{
			window.open("<%=basePath %>schoolNewsLook/toTakePartInActivity.do?schoolId="+$("#schoolId").val()+"&newsId="+$("#newsId").val());
		}

		function shareWeixin(){
			$("#myModal").modal("show");
		}

	</script>
</html>