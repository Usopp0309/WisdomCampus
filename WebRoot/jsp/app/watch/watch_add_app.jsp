<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>添加设备</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>添加设备 <i class="itext icon_right" onclick="submitForm()">保存</i>
	</div>
	<div class="app_search">
	
	<form action="<%=basePath %>locationInfo/doAddUserWatchLink.do" class="form-horizontal" method="post" id="userWatchForm">
		<span>设备ID</span>
		<p>
			<input type="text" id="watchId" name="watchId">
		</p>
		<span>学生姓名</span>
		<p>
			
			<input class="select_p" readonly="readonly" type="text" name="name">
			<input name="studentId" type="hidden" id="studentId">
		</p>
		<dl class="select_ul">
		<p>您可能想添加的学生</p>
			<c:forEach items="${list }" var="user">
				<dd id="${user.userId }"><p>${user.realName }</p></dd>
			</c:forEach>
		</dl>
	</form>
	</div>
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">
		$(function(){
			$(".select_p").on("click",function(){
				
				$(".select_ul").show();
				setTimeout("setinterval_time()",1000);
				
			});
			
			$(".select_ul dd").on("click",function(){
				$(".select_p").val($(this).find("p").text());
				$("#studentId").val($(this).attr("id"));
			});
			
		});
		function setinterval_time(){
			$(".select_p").removeAttr("readonly");
		}
		function submitForm(){
			$("#userWatchForm").submit();
		}
	</script>
</html>