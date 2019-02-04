<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>评价信息</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>
	<div class="news">
	<h2 class="text-left">我要评论</h2>
	<textarea  id="commentContent" rows="5"></textarea>
	<input type="button" onclick="sendCommentNoParent()" value="发表评论"/>
								
	<h2 class="text-left">评论列表</h2>
	
	<ul id="commentsTable">
	</ul>
	
		<input type="hidden" id="newsId" value="${schoolNewsInfo.newsId}"/>
		<input type="hidden" id="schoolId" value="${schoolId}"/>
	</div>
	
	<div class="modal hide fade" id="loginDialog" tabindex="-1" role="dialog">
	<div class="login">
		<h2>用户登录<button type="button" data-dismiss="modal" class="m_close">X</button></h2>
		<input class="logon_input" type="text" id="account" />
		<input class="logon_input" type="password" id="password" />
		<input class="logon_btn" type="button" onclick="login()" value="登录"/>
	</div>
	</div>
	
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
    
	<!-- 默认配置文件 -->
    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.config.js" type="text/javascript" charset="utf-8" ></script>
    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.all.js" type="text/javascript" charset="utf-8" > </script>
    <!-- 语言文件 -->
    <script src="<%=basePath%>assets/global/plugins/schoolnews/lang/zh-cn/zh-cn.js" type="text/javascript" charset="utf-8" ></script>
    
    <!-- 如果需要页面渲染的话引入 -->
    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.parse.min.js" type="text/javascript" charset="utf-8" ></script>
	<script type="text/javascript">

		$(function() {    
			loadComments("commentsTable","0",$("#newsId").val(),"","1");
			$(".fa-thumbs-up").on("click",function(){
				$(this).text(parseInt($(this).text())+1);
			})
			$(".reply").on("click",function(){
				$("#commentsTable").find(".reply_con").remove();
				//
				$(this).closest(".info").append("<div class='reply_con'><input class='reply_text' type='text'><input class='reply_submit' type='submit' value='发表'></div>")
			})
		});
		var myComments = "";
		//我的评论
		function setCommentsType(type){
			myComments=type;
			if(type=="1"){
				$("#orderButton").hide();
				loadMyComments();
			}else{
				$("#orderButton").show();
				loadComments("commentsTable","0",$("#newsId").val(),"","1");
			}
		}
		var orderType="1";
		function setOrderType(type){
			orderType=type;
			loadComments("commentsTable","0",$("#newsId").val(),myComments,orderType)
		}
		function loadMyComments(){
			$.ajax({
				url:"<%=basePath %>schoolNewsLook/getMyCommentByUserId.do",
				type:"post",
				success:function(data){
					var list = eval("("+data+")");
					var appendHTML = "";
					for(var i = 0;i<list.length;i++){
						var value = list[i];
						appendHTML += "<tr><td style='color:gray'>"+value.createTime+"&nbsp;&nbsp;";
						if(value.parentId != "0"){
							appendHTML += "回复了<span style='color:#328BD2'>"+value.commentUserName+"</span>的评论&nbsp;<span style='color:#1A649D'>"+value.newsTitle+"</span>";
						}else{
							appendHTML += "发表评论";
						}
						appendHTML += "</td></tr><tr><td>"+value.content;
						appendHTML += "</td></tr><tr><td><span style='color:gray;'>"+value.newsTitle;
						appendHTML += "</span></td></tr><tr><td style='color:gray;'>赞("+value.zanCount+")&nbsp;&nbsp;<a href='javascript:void(0)' onclick='deleteComments("+value.commentId+")'>删除</a>";
						appendHTML += "</td></tr>";
					}
					$("#commentsTable").html(appendHTML);
				}
			});
		}
		function loadComments(elementId,parentId,newsId,myComments,orderType){
			$.ajax({
				url:"<%=basePath %>schoolNewsLook/getCommentsByAsyncPhone.do",
				data:{
					schoolId : $("#schoolId").val(),
					parentId : parentId,
					newsId : newsId,
					myComments : myComments,
					orderType : orderType
				},
				type:"post",
				success:function(data){
					var list = eval("("+data+")");
					if(null!=list){
						var appendHTML = "";
						for(var i=0;i<list.length;i++){
							var value = list[i];
							appendHTML += "<li>";
							appendHTML +="	<div class='header'>";
							if(value.userHeadPath=="" || value.userHeadPath=="head/avatar_default.png" || value.userHeadPath==undefined)
							{
								appendHTML +='<img src="<%=basePath%>assets/global/img/m_img/head_photo.png">';
							}else
							{
								appendHTML += '<img src="<%=Cons.HEADIMGBASEPATH%>'+ value.userHeadPath +'">';
							}
							appendHTML +="</div>";
							appendHTML +="<div class='info'>";
							appendHTML +="<p><span class='name'>"+value.commentUserName+"</span>";
							appendHTML +="<span class='time'>"+value.createTime+"</span></p>";
							appendHTML +="<p>"+value.content+"</p>";
							appendHTML +="<i class='fa fa-thumbs-up' style='margin-right:10px;' onclick='clickZan("+value.commentId+",this)'>"+value.zanCount+"</i><i class='fa fa-share reply' onclick='reply("+value.commentId+",this)'>回复</i>";
							appendHTML +="<ul style='clear:both' id='comment_sub'>";
							for(var j=0;j< value.reviewersList.length;j++){
								var va = value.reviewersList[j];
								appendHTML +="<li>";
								appendHTML +="<div class='header'>";
								if(va.userHeadPath=="" || va.userHeadPath=="head/avatar_default.png" || va.userHeadPath==undefined)
								{
									appendHTML +="<img src='<%=basePath%>assets/global/img/m_img/head_photo.png'>";
								}else
								{
									appendHTML += '<img src="<%=Cons.HEADIMGBASEPATH%>'+ va.userHeadPath +'">';
								}
								appendHTML +="</div>";
								appendHTML +="<div class='info'>";
								appendHTML +="<p><span class='name'>"+va.commentUserName+"</span>";
								appendHTML +="<span class='time'>"+va.createTime+"</span></p>";
								appendHTML +="<p>"+va.content+"</p>";
								appendHTML += "</div></li>";
							}
							appendHTML += "</ul></div></li>";
						}
						$("#"+elementId).html(appendHTML);
					}
				}
			});
		}
		function sendCommentNoParent(){
			if(!isLogin()){
				$("#loginDialog").modal("show");
			}else{
				sendComment($("#commentContent").val(),"0");
			}
		}
		var isOpen;
		function reply(id,obj){
			if(isOpen != obj){
				$(".replayParent").remove();
				$(obj).parent().append("<div class='replayParent' name='replayParent'><textarea  id='commentContentReply' style='width:90%;margin:0px' rows='5'></textarea><span style='display:inline-block;'><input type='button' class='reply_btn' onclick='sendCommentByParent("+id+",this)' value='发表评论'/></span></div>");
				isOpen = obj;
			}else{
				isOpen = null;
			}
		}
		var isDian = false;
		var isId="";
		function clickZan(id,obj){
			if(isDian&&null!=isId&&isId.indexOf(","+id)>-1){
			}else{
				isDian=true;
				isId+=","+id;
				$(obj).css("cursor","default");
				$.ajax({
					url:"<%=basePath %>schoolNewsLook/addZan.do",
					data:{
						commentId : id
					},
					type:"post",
					success:function(data){
						var zanCount = $(obj).html();
						zanCount = parseInt(zanCount)+1;
						$(obj).html(zanCount);
					}
				});
			}
		}
		function sendCommentByParent(id,obj){
			if(!isLogin()){
				$("#loginDialog").modal("show");
			}else{
				var newsId = $("#newsId").val();
				var commentContent = $("#commentContentReply").val();
				var commentType = "1";
				var nowDate = new Date();
				$.ajax({
					url:"<%=basePath %>schoolNewsLook/addComment.do",
					data:{
						newsId : newsId,
						commentContent : commentContent,
						commentType : commentType,
						parentId : id
					},
					type:"post",
					success:function(data){
						if(data){
							var reviewers = eval("("+data+")");
							var appendHTML = "";
							appendHTML +="<li>";
							appendHTML +="<div class='header'>";
							if(reviewers.userHeadPath=="" || reviewers.userHeadPath=="head/avatar_default.png" || reviewers.userHeadPath==undefined)
							{
								appendHTML+="<img src='<%=basePath%>assets/global/img/m_img/head_photo.png'>";
							}else
							{
								appendHTML += '<img src="<%=Cons.HEADIMGBASEPATH%>'+ reviewers.userHeadPath +'">';
							}
							appendHTML +="</div>";
							appendHTML +="<div class='info'>";
							appendHTML +="<p><span class='name'>"+reviewers.commentUserName+"</span>";
							appendHTML +="<span class='time'>"+reviewers.createTime+"</span></p>";
							appendHTML +="<p>"+reviewers.content+"</p>";
							appendHTML += "</div></li>";
							$(obj).parent().parent().html(appendHTML);
						}
					}
				});
			}
		}
		function sendComment(commentContent,parendId){
			var newsId = $("#newsId").val();
			var commentType = "1";
			$.ajax({
				url:"<%=basePath %>schoolNewsLook/addComment.do",
				data:{
					newsId : newsId,
					commentContent : commentContent,
					commentType : commentType,
					parentId : parendId
				},
				type:"post",
				success:function(data){
					if(data){
						$("#pingIsSuccess").show();
						setTimeout(function(){
							$("#pingIsSuccess").hide(1000);
						},1000);
						$("#commentContent").val("");
						loadComments("commentsTable","0",newsId,"","1");
					}
				}
			});
		}
		
		Date.prototype.Format = function (fmt) { //author: meizz 
		    var o = {
		        "M+": this.getMonth() + 1, //月份 
		        "d+": this.getDate(), //日 
		        "h+": this.getHours(), //小时 
		        "m+": this.getMinutes(), //分 
		        "s+": this.getSeconds(), //秒 
		        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
		        "S": this.getMilliseconds() //毫秒 
		    };
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		    for (var k in o)
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		    return fmt;
		}
		$("#replyModal").bind("show",function(){
			$("#replyModal").html("");
			var parentCommentId = $(this).attr("name");
			$.ajax({
				url:"<%=basePath %>schoolNewsLook/getCommentsByAsync.do",
				data:{
					parentId : parentCommentId,
					newsId : $("#newsId").val(),
					myComments : "",
					orderType : "2",
					detailComment:"1"
				},
				type:"post",
				async:false,
				success:function(data){
					var list = eval("("+data+")");
					if(null!=list){
						var appendHTML = "<table id='commentTable'>";
						for(var i=0;i<list.length;i++){
							var value = list[i];
							appendHTML += "<tr>";
							appendHTML +="	<td valign='top' rowspan='3'>";
							appendHTML +="		<img src='<%=basePath %>"+value.userHeadPath+"'>";
							appendHTML +="	</td>";
							appendHTML +="	<td>";
							appendHTML +="		<span>"+value.commentUserName+"</span>";
							appendHTML +="		<span>"+value.createTime+"</span>";
							appendHTML +="	</td>";
							appendHTML +="</tr>";
							appendHTML +="<tr>";
							appendHTML +="	<td>";
							appendHTML +="		<span>"+value.content+"</span>";
							appendHTML +="	</td>";
							appendHTML +="</tr>";
							appendHTML +="<tr>";
							appendHTML +="	<td>";
							appendHTML +="	<div>";
							appendHTML +="		<span><a href='javascript:void(0)' onclick='clickZan("+value.commentId+",this)'>赞("+value.zanCount+")</a></span>";
							appendHTML +="		<span onclick='reply("+value.commentId+",this)'>回复</span>";
							appendHTML +="	</div>";
							appendHTML +="	</td>";
							appendHTML +="</tr>";
						}
						appendHTML+="</table>";
						$("#replyModal").html(appendHTML);
					}
				}
			});
			$.ajax({
				url:"<%=basePath %>schoolNewsLook/getCommentsByAsync.do",
				data:{
					parentId : parentCommentId,
					newsId : $("#newsId").val(),
					myComments : "",
					orderType : "2"
				},
				type:"post",
				async:false,
				success:function(data){
					var list = eval("("+data+")");
					if(null!=list){
						var appendHTML = "<div  style='margin-left:50px;'><table>";
						for(var i=0;i<list.length;i++){
							var value = list[i];
							appendHTML += "<tr>";
							appendHTML+="	<td valign='top' rowspan='3'>";
							appendHTML+="		<img src='<%=basePath %>"+value.userHeadPath+"'>";
							appendHTML+="	</td>";
							appendHTML+="	<td>";
							appendHTML+="		<span>"+value.commentUserName+"</span>";
							appendHTML+="		<span>"+value.createTime+"</span>";
							appendHTML+="	</td>";
							appendHTML+="</tr>";
							appendHTML+="<tr>";
							appendHTML+="	<td>";
							appendHTML+="		<span>"+value.content+"</span>";
							appendHTML+="	</td>";
							appendHTML+="</tr>";
							appendHTML+="<tr>";
							appendHTML+="	<td>";
							appendHTML+="	<div>";
							appendHTML+="		<span><a href='javascript:void(0)' onclick='clickZan("+value.commentId+",this)'>赞("+value.zanCount+")</a></span>";
							appendHTML+="	</div>";
							appendHTML+="	</td>";
							appendHTML+="</tr>";
						}
						appendHTML+="</table></div>";
						$("#replyModal").append(appendHTML);
					}
				}
			});
		});
		function lookComment(id){
			$("#replyModal").attr("name",id);
			$("#replyModal").modal("show");
		}
		function deleteComments(id){
			if(confirm("确认删除吗？")){
				$.ajax({
					url:"<%=basePath %>schoolNewsLook/deleteComments.do",
					data:{
						commentId : id
					},
					type:"post",
					async:false,
					success:function(data){
						var isSuccess=eval("("+data+")");
						if(isSuccess=="success"){
							alert("删除成功！");
							loadMyComments();
						}
					}
				});
			}
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
	</script>
</html>