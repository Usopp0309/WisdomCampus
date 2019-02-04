<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>地点添加</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>地点添加<i class="itext icon_right">保存</i>
	</div>
	<div class="app_search">
	<form action="" class="form-horizontal" method="post">
		<span>地点</span>
		
		<p><a href=""><input type="text"></a></p>
		
		<span>地点类型</span>
		<p><input type="text" ></p>
	</form>
	</div>
	
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

</html>