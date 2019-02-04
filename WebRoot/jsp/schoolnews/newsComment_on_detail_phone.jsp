<%@page import="com.guotop.palmschool.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>评论信息</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<meta content="" name="description" />

	<meta content="" name="author" />

	<!-- BEGIN GLOBAL MANDATORY STYLES -->

	<link href="../media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/pricing-tables.css" rel="stylesheet" type="text/css"/>

	<link href="../media/css/select2_metro.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		p{padding:0px;height:35px;line-height:35px;width:90%;margin:0px auto;}
		textarea{width:90%;margin:0px auto;display:block;resize:none;padding:0px;}
		input{width:90%!important;margin:15px auto 0;padding:5px 0px; display:block;resize:none;background-color:#1A94E6;color:#fff;border:none;}
		p span{width:30%;float:left;display:inline-block;line-height:35px;float:left;}
	</style>
</head>

<body class="page-header-fixed">
	<div class="container-fluid">
		<p><span>我要评论</span><span><em>0</em>条评论</span></p>
		<textarea  id="commentContent" rows="5"></textarea>
		<input type="button" onclick="sendCommentNoParent()" value="发表评论"/>
		<p>
			<span id="allComments" onclick="setCommentsType('')">全部评论</span>
			<span id="myComments" onclick="setCommentsType('1')">我的评论</span>
		</p>
		<table id="commentsTable">
		</table>

		
		
	</div>
	<div class="modal hide fade" id="replyModal" tabindex="-1" role="dialog" style="width: 40%;z-index:1002;left:30%;top:20%;position: absolute;margin-left:0px;">
	</div>
	<script src="../media/js/jquery-2.1.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="../media/js/bootstrap.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="../media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<script src="../media/js/select2.min.js" type="text/javascript" ></script>

	<script src="../media/js/jquery.dataTables.min.js" type="text/javascript" ></script>

	<script src="../media/js/DT_bootstrap.js" type="text/javascript" ></script>

	<script src="../media/js_m/public_js.js" type="text/javascript" ></script>
	
	<script src="../media/js/app.js" type="text/javascript" ></script>
	
    
	<!-- 默认配置文件 -->
    <script src="../media/schoolnews/ueditor.config.js" type="text/javascript" charset="utf-8" ></script>
    <script src="../media/schoolnews/ueditor.all.js" type="text/javascript" charset="utf-8" > </script>
    <!-- 语言文件 -->
    <script src="../media/schoolnews/lang/zh-cn/zh-cn.js" type="text/javascript" charset="utf-8" ></script>
    
    <!-- 如果需要页面渲染的话引入 -->
    <script src="../media/schoolnews/ueditor.parse.min.js" type="text/javascript" charset="utf-8" ></script>
    
    
	<script>


		jQuery(document).ready(function() {    
			loadComments("commentsTable","0","${schoolNewsInfo.newsId}","","1");
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
				loadComments("commentsTable","0","${schoolNewsInfo.newsId}","","1");
			}
		}
		var orderType="1";
		function setOrderType(type){
			orderType=type;
			loadComments("commentsTable","0","${schoolNewsInfo.newsId}",myComments,orderType)
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
				url:"<%=basePath %>schoolNewsLook/getCommentsByAsync.do",
				data:{
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
							if(elementId!="commentsTable"){
								appendHTML += "<tr style='margin-left:50px;'>";
							}else{
								appendHTML += "<tr>";
							}
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
							appendHTML+="		<span onclick='reply("+value.commentId+",this)'>回复</span>";
							if(value.replayCount!="0"){
								appendHTML+="		<span  data-toggle='modal' onclick='lookComment("+value.commentId+")'>查看回复("+value.replayCount+")</span>";
							}
							appendHTML+="	</div>";
							appendHTML+="	</td>";
							appendHTML+="</tr>";
						}
						$("#"+elementId).html(appendHTML);
					}
				}
			});
		}
		function sendCommentNoParent(){
			sendComment($("#commentContent").html(),"0");
		}
		var isOpen;
		function reply(id,obj){
			$("div[name='replayParent']").each(function(){
				$(this).remove();
			});
			if(isOpen != obj){
				$(obj).parent().append("<div name='replayParent'><textarea style='width: 400px;' id='commentContent' rows='5'></textarea><span style='float:right;'><input type='button' onclick='sendCommentByParent("+id+",this)' value='发表评论'/></span></div>");
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
						zanCount = parseInt(zanCount.substring(zanCount.indexOf("(")+1,zanCount.indexOf(")")))+1;
						$(obj).html("赞("+zanCount+")");
					}
				});
			}
		}
		function sendCommentByParent(id,obj){
			var newsId = "${schoolNewsInfo.newsId}";
			var commentContent = $(obj).parent().prev().html();
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
						var list = eval("("+data+")");
						var appendHTML = "<table style='margin-left:20px;'><tr>";
						appendHTML+="	<td valign='top' rowspan='3'>";
<%-- 						appendHTML+="		<img src='<%=basePath+((User)session.getAttribute("user")).getHeadImg() %>'>"; --%>
						appendHTML+="	</td>";
						appendHTML+="	<td>";
<%-- 						appendHTML+="		<span><%=((User)session.getAttribute("user")).getRealName() %></span>"; --%>
						appendHTML+="		<span>"+nowDate.Format("yyyy-MM-dd hh:mm:ss")+"</span>";
						appendHTML+="	</td>";
						appendHTML+="</tr>";
						appendHTML+="<tr>";
						appendHTML+="	<td>";
						appendHTML+="		<span>"+commentContent+"</span>";
						appendHTML+="	</td>";
						appendHTML+="</tr>";
						appendHTML+="<tr>";
						appendHTML+="	<td>";
						appendHTML+="		<span><a href='javascript:void(0)' onclick='clickZan("+list[0].commentId+",this)'>赞(0)</a></span>";
						appendHTML+="	</td>";
						appendHTML+="</tr></table>";
						$(obj).parent().parent().html(appendHTML);
					}
				}
			});
		}
		function sendComment(commentContent,parendId){
			var newsId = "${schoolNewsInfo.newsId}";
			var commentContent = commentContent;
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
					newsId : "${schoolNewsInfo.newsId}",
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
					newsId : "${schoolNewsInfo.newsId}",
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
	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>