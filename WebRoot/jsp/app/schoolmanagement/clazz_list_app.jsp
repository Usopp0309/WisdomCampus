<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>班级管理</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body">

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>班级管理
		<i class="icon-plus icon_right"></i>
		
	</div>
	<ul class="inout_list">
		<div class="p_search">
			<input type="text">
			<i class="m_icon-search"></i>
		</div>
		<li>
			<p class="depart_p">中二班</p>
			<p class="depart_p"><span>李凯</span><span>2015033</span><span>2015-11-16 16:30</span></p>
		</li>
		<li>
			<p class="depart_p">中二班</p>
			<p class="depart_p"><span>李凯</span><span>2015033</span><span>2015-11-16 16:30</span></p>
		</li>
		<li>
			<p class="depart_p">中二班</p>
			<p class="depart_p"><span>李凯</span><span>2015033</span><span>2015-11-16 16:30</span></p>
		</li>
		<li>
			<p class="depart_p">中二班</p>
			<p class="depart_p"><span>李凯</span><span>2015033</span><span>2015-11-16 16:30</span></p>
		</li>
		<li>
			<p class="depart_p">中二班</p>
			<p class="depart_p"><span>李凯</span><span>2015033</span><span>2015-11-16 16:30</span></p>
		</li>
		<li>
			<p class="depart_p">中二班</p>
			<p class="depart_p"><span>李凯</span><span>2015033</span><span>2015-11-16 16:30</span></p>
		</li>
	</ul>


	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	

	<script type="text/javascript">
		$(function(){
			$(".fa-ellipsis-v").on("click",function(){
				$(".submenu").show();
			})
			$(".submenu li").on("click",function(){
				$(".submenu").hide();
			})
		})
	</script>


</html>