<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>学生家长管理</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
	
<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>学生家长管理
	</div>
	<div class="app_search">
	
	<form action="" class="form-horizontal" method="post">
	<span>角色选择</span>
	<ul>
		<li id="1" class="select">全部</li><li id="2">学生</li><li id="3">家长</li><li id="4">司机</li>
		<input type="hidden" class="val" name="val" value="5">
	</ul>
	<span>选择年级</span>
	<ul>
		<li id="1" class="select">全部</li><li id="2">一年级</li><li id="3">二年级</li><li id="4">三年级</li><li id="5">四年级</li>
		<input type="hidden" class="val" name="val" value="7">
	</ul>
	<span>选择班级</span>
	<ul>
		<li id="1" class="select">全部</li><li id="2">一班</li><li id="3">二班</li><li id="4">三班</li><li id="5">四班</li>
		<input type="hidden" class="val" name="val" value="7">
	</ul>
	<span>姓名/学号</span>
	<p><input type="text" ></p>
	<p>
		<button type="submit">查找</button>
		<button type="buttom">重置</button>
		<button type="buttom">导出</button>
	</p>
	
	</form>
	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

</html>