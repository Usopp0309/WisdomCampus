<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<title>新闻详细页面</title>
	
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

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

	<link href="../media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" />
		<style type="text/css">
		.news_detail{}
		.news_detail h2{line-height:30px;text-align: center;font-size:16px;font-weight:bold;}
		.news_detail p{line-height:30px;text-align: center;font-size:13px;color:#999}
		#nameGroup{}
		#nameGroup p{line-height:30px;text-indent: 20px;font-size:13px;text-align: left;color:#333}
		.zixun{text-align: center;margin:0px auto 50px;}
		.zixun input{padding:5px 20px;background-color:#ccc;border:none;border-radius:15px!important;display:inline-block;color:#fff;}
		.zixun .baoming{background-color:#2BD56F}
		.zixun .tel{background-color:#1ABDE6}
		.bbs{position:fixed;left:0px;bottom:0px;width:100%;}
		.bbs p{margin:0px;padding:0px;text-align: left;}
		.bbs span{display:inline-block;padding:0px;margin:0px;height:30px;line-height:30px;}
		.bbs .text-input{width:79%;float:left;border:1px solid #ccc;background-color:#fff;}
		.bbs .text-submit{width:19%;float:left;border:none;background-color:#1ABDE6;color:#fff;border:1px solid #1ABDE6;text-align: center;}
		.bbs p input{float:right;display:inline-block;border:none;background-color:#ccc;}
		
		</style>
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">
  <input type="hidden" value="${schoolId }" id="schoolId" />
  
  <input type="hidden" value="${schoolNewsInfo.newsId }" id="newsId" />

	<div class="container-fluid">

		<div class="row-fluid">

			<div class="span12">
			
				<div class="portlet">
					<div class="portlet-body news_detail">
							
							<h2>${schoolNewsInfo.newsTitle }</h2>
							<p>
								作者：${schoolNewsInfo.newsAuthor}
								${schoolNewsInfo.createTime }
							</p>
							<div id="nameGroup">
								${schoolNewsInfo.newsContent }
							</div>
							<div class="zixun">
								<c:if test="${schoolNewsInfo.functionType==l}">
									<input id="zixunButton" class="tel" type="button" value="我要咨询" />
								</c:if>
								<c:if test="${schoolNewsInfo.functionType==2}">
									<input type="button"class="baoming" onclick="baoming()" value="我要报名" />
								</c:if>
								<c:if test="${schoolNewsInfo.functionType==3}">
									<input id="zixunButton" class="tel" type="button" value="我要咨询" />
									<input type="button" class="baoming" onclick="baoming()" value="我要报名" />
								</c:if>
								<input id="zixunButton" class="tel" type="button" value="我要咨询" />
								<input type="button" class="baoming" onclick="baoming()" value="我要报名" />
							</div>
							
							
							<div class="bbs" onclick="forwardComments('${schoolNewsInfo.newsId}')">
								<span class="text-input" ></span>
								<span class="text-submit">发表</span>
							</div>
						
					</div>
					
				</div>
				
			</div>
			
		</div>
		
	</div>
	<div class="modal hide fade" id="loginDialog" tabindex="-1" role="dialog">
	<div>账号：<input type="text" id="account" /></div>
	<div>密码：<input type="password" id="password" /></div>
	<input type="button" onclick="login()" value="登录"/>
	</div>
	<!-- 模态框（Modal） -->
	<!-- <div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
	   aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         
	         <div class="modal-body">
	         	<img alt="" id="imagePath" src="">
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default" 
	               data-dismiss="modal">关闭
	            </button>
	         </div>
	      </div>/.modal-content
	</div>/.modal
	</div> -->
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

// 			App.init();

// 			var ue = UE.getEditor('editor');
// 			loadClazzList();

			$('#school').click(function(){
				$("#clazzSelect").hide();
        	});  

			$('#clazz').click(function(){
				$("#clazzSelect").show();
        	});
        	if(IsPC()){
            	$("#zixunButton").hide();
            }
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
			/* if(!isLogin()){
				$("#loginDialog").modal("show");
			}else{ */
				window.open("<%=basePath %>schoolNewsLook/forwardCommentsPhone.do?newsId="+id+"&schoolId="+$("#schoolId").val());
			/* } */
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
			window.open("<%=basePath %>schoolNewsLook/applyInfoPhone.do?schoolId="+$("#schoolId").val()+"&newsId="+$("#newsId").val());
		}

		function shareWeixin(){
			$("#myModal").modal("show");
		}

	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>