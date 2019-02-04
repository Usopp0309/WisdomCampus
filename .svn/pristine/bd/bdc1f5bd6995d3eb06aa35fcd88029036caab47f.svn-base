<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>考勤补录</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body id="body">

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>考勤统计
		<i class="icon-plus icon_right"></i>
		
	</div>
	
	<ul class="inout_list">
		<div class="p_search">
			<input readonly="readonly" name="startTime" id="startday" type="text">
		</div>
		<div class="check_img"></div>
		<div class="check_count">
			<span><i class="Push">正</i></span><span>正常上班 60%</span><span class="num">62人</span>
		</div>
		<li>
			<p class="depart_p">徐茂 <i></i></p>
			<p class="depart_p"><span>SYY-CSS-001</span><span>一年级</span><span>2015-06-15 15:30</span></p>
		</li>
		<li>
			<p class="depart_p">徐茂 <i></i></p>
			<p class="depart_p"><span>SYY-CSS-001</span><span>一年级</span><span>2015-06-15 15:30</span></p>
		</li>
		<li>
			<p class="depart_p">徐茂 <i></i></p>
			<p class="depart_p"><span>SYY-CSS-001</span><span>一年级</span><span>2015-06-15 15:30</span></p>
		</li>
		<li>
			<p class="depart_p">徐茂 <i></i></p>
			<p class="depart_p"><span>SYY-CSS-001</span><span>一年级</span><span>2015-06-15 15:30</span></p>
		</li>
		<li>
			<p class="depart_p">徐茂 <i></i></p>
			<p class="depart_p"><span>SYY-CSS-001</span><span>一年级</span><span>2015-06-15 15:30</span></p>
		</li>
		<li>
			<p class="depart_p">徐茂 <i></i></p>
			<p class="depart_p"><span>SYY-CSS-001</span><span>一年级</span><span>2015-06-15 15:30</span></p>
		</li>
	</ul>

		
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 

	<script type="text/javascript">
	$(function() {    

		if(isios()){
			$("#icon_left").attr("onclick","iosBack();");
		}else{
			$("#icon_left").attr("onclick","window.richbook.onFinish();");
		}
	});
	
	function iosBack(){
		window.location.href="ios.jsp";
	}
	
	function isios(){
		var u = navigator.userAgent;
		//var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
		var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
		return isiOS;
	}
	</script>


</html>