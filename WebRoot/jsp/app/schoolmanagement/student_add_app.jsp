<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>添加学生</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>添加学生<i class="itext icon_right">保存</i>
	</div>
	<div class="app_search">
	<form action="" class="form-horizontal" method="post">
		<span>学号</span>
		<p><input type="text" ></p>
		<span>学生姓名</span>
		<p><input type="text" ></p>
		<span>家长1姓名</span>
		<p><input type="text" ></p>
		<span>家长1手机号码</span>
		<p><input type="text" ></p>
		<span>家长2姓名</span>
		<p><input type="text" ></p>
		<span>家长2手机号码</span>
		<p><input type="text" ></p>
		<span>类型</span>
		<p><input type="text" ></p>
		<span>班级</span>
		<p><input type="text" ></p>
		<span>电子卡</span>
		<p><input type="text" ></p>
	</form>
	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

</html>