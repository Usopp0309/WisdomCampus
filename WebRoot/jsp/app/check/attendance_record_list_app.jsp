<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>考情补录</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>考勤补录
			<a href="<%=basePath%>jsp/app/safeSchool/abnormal_search_app.jsp">
				<i class=" m_icon-search icon_right"></i>
			</a>							
		
		
	</div>
	<ul class="inout_list">
		<li><em class="late">迟</em><p><span class="name">王文</span></p><p><span>YXCC001</span><span>八年级组</span><span>2016-10-15 16:30</span></p></li>
		<li><em class="Leave">早</em><p><span class="name">王文</span></p><p><span>YXCC001</span><span>八年级组</span><span>2016-10-15 16:30</span></p></li>
		<li><em class="Push">正</em><p><span class="name">王文</span></p><p><span>YXCC001</span><span>八年级组</span><span>2016-10-15 16:30</span></p></li>
		<li><em class="late">迟</em><p><span class="name">王文</span></p><p><span>YXCC001</span><span>八年级组</span><span>2016-10-15 16:30</span></p></li>
		<li><em class="Leave">早</em><p><span class="name">王文</span></p><p><span>YXCC001</span><span>八年级组</span><span>2016-10-15 16:30</span></p></li>
		<li><em class="Push">正</em><p><span class="name">王文</span></p><p><span>YXCC001</span><span>八年级组</span><span>2016-10-15 16:30</span></p></li>
		
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