<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
	<title>异常记录详情</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body">
	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>异常信息详情
		
			<a href="">
				<i class=" icon-home icon_right"></i>
			</a>							
		
		
	</div>
	<div class="detail">
		<span>姓名</span>
		<p>王文瑞</p>
		<span>异常类型</span>
		<p>迟到</p>
		<span>内容</span>
		<p>您好,您的孩子陈惟凡于2015-12-30 15:30:00离开学校</p>
		<span>创建时间</span>
		<p>2015-12-30 15:30</p>
	</div>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->  


</html>