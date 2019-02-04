<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>部门管理</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body">

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>部门管理
		<i class="fa fa-ellipsis-v icon_right"></i>
		<ul class="submenu">
				<li>编辑部门</li>
				<li>添加人员</li>
				<li>创建亦信群</li>
			</ul>
	</div>
	<ul class="inout_list">
		<li>
			<p class="depart_p">王琦</p>
			<p class="depart_p"><span>班主任</span><span>编号：ycxx001</span><span>13954855685</span></p>
		</li>
		<li>
			<p class="depart_p">王琦</p>
			<p class="depart_p"><span>班主任</span><span>编号：ycxx001</span><span>13954855685</span></p>
		</li>
		<li>
			<p class="depart_p">王琦</p>
			<p class="depart_p"><span>班主任</span><span>编号：ycxx001</span><span>13954855685</span></p>
		</li>
		<li>
			<p class="depart_p">王琦</p>
			<p class="depart_p"><span>班主任</span><span>编号：ycxx001</span><span>13954855685</span></p>
		</li>
		<li>
			<p class="depart_p">王琦</p>
			<p class="depart_p"><span>班主任</span><span>编号：ycxx001</span><span>13954855685</span></p>
		</li>
		<li>
			<p class="depart_p">王琦</p>
			<p class="depart_p"><span>班主任</span><span>编号：ycxx001</span><span>13954855685</span></p>
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