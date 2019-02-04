<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
	<title>晨检详情</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body id="body" style="background-color:#eae9e9">

	<div class="app_head">
	
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>晨检详情
									
		
		
	</div>  
	
	<div class="moringCheck_detail">
		<div class="moringCheck_detail_head">
			<div class="moringCheck_detail_left">
				<img src="<%=Cons.KINDERGARTENINOUTIMAGEBASEPATH%>${schoolId }/headImg/${mc.cardCode}.jpg">
				<div class="info">
					<p>姓名：<span>${mc.name }</span></p>
					<p>班级：<span>${mc.clazzName }</span></p>
					<p>电话：<span>${mc.parentPhone }</span></p>
					<p>班主任：<span>${mc.leaderName }</span></p>
				</div>
			</div>
			<div class="moringCheck_detail_right">
				<div class="info">
					<p><span>${mc.teacherName }</span>：老师</p>
					<p><span>${mc.teacherPhone}</span>：电话</p>
				</div>
				<img src="<%=Cons.KINDERGARTENINOUTIMAGEBASEPATH%>${schoolId }/headImg/${mc.teacherCardCode}.jpg">
			</div>
		</div>
		<div class="moringCheck_detail_con">
			<div class="top">
				<div class="left">体温</div>
				<div class="con"><p>体温正常范围值</p><p>36.5℃-37.5℃</p></div>
				<div class="right">${mc.temperature }℃</div>
			</div>
			<div class="list">
				<div class="left"><p>精神</p><em class="jingshen"></em></div>
				<div class="right">${mc.spirit }</div>
			</div>
			<div class="list">
				<div class="left"><p>口腔</p><em class="kouqiang"></em></div>
				<div class="right">${mc.oralCavity }</div>
			</div>
			<div class="list">
				<div class="left"><p>形象</p><em class="xingxiang"></em></div>
				<div class="right">${mc.surface }</div>
			</div>
		</div>
	</div>
		</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->  
	</html>