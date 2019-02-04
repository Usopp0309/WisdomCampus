<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RICHX智慧校园</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--公共css开始-->
<script src="<%=basePath%>assets/global/plugins/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">
<!--E学习pad模拟登陆-->
$(function(){
    $.ajax({
		type: "post",
		url: "<%=basePath%>user/doCheckUsernamePassword.do",
		data:{
				userId:"${userId}"
		},
		success:function(data){
			var result = eval("(" + data + ")");
		    var flag = result["reg"];
		    if(flag)
	        {
	            alert("用户不存在");
	        }
	        else
	        {
		      window.location.href = "<%=basePath%>user/doLogin.do";
	        }
		}
	}); 
	
	
});
</script>
</body>
</html>