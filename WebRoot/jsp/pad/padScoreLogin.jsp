<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>RICHX智慧校园</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--公共css开始-->
<script src="<%=basePath%>assets/global/plugins/jquery.min.js"
	type="text/javascript"></script>
</head>
<body style="text-align: center;">
	<script type="text/javascript">
$(function(){
   var url="http://score.richx.cn/user/doLoginFromCampus.do?param=${uuid}&schoolId=${schoolId}";
   window.location.href = url;
	
});
</script>
</div>
</body>
</html>