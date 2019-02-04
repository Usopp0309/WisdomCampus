<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>我要报名</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>
	<div class="news">
		<div class="addapplyinfo">
		<div class="mrow" style="margin:20px auto 0px;">
			<span>报名学校:</span>
			<span style="text-align: left;width: 60%;" id="schoolName">${school.schoolName }</span>
		</div>
		<div class="mrow">
			<span>学生姓名:</span>
			<input type="text" value="" id="studentName"/>
		</div>
		<div class="mrow">
			<span>学生性别:</span>
			<select id="sex">
				<option selected="selected" value="0">男</option>
				<option value="1">女</option>
			</select>
		</div>
		<div class="mrow">
			<span>出生年月:</span>
			<input type="text" value="" id="birth"/>
		</div>
		<div class="mrow">
			<span>联系电话:</span>
			<input type="text" value="" id="phone"/>
		</div>
		<div class="mrow">
			<span>家庭住址:</span>
			<input type="text" value="" id="address"/>
		</div>
		<div class="mrow">
			<span>推荐人:</span>
			<input type="text" value="" id="referrer"/>
		</div>
		<div class="mrow">
			<span>备注:</span>
			<textarea name="remark" id="remark" rows="" cols="" style="height:70px;width:60%;margin:0px;border-color:#999999;"></textarea>
		</div>
		
		<p>注：尽量填写正确信息，方便及时与您联系</p>
		<input class="isubmit" type="button" onclick="submitForm()" value="提交申请" />
		</div>
	</div>
	
	
	<input type="hidden" id="schoolId" value="${school.schoolId}" />
	<input type="hidden" value="${newsId }" id="newsId" />
	
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<!-- 默认配置文件 -->
    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.config.js" type="text/javascript" charset="utf-8" ></script>
    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.all.js" type="text/javascript" charset="utf-8" > </script>
    <!-- 语言文件 -->
    <script src="<%=basePath%>assets/global/plugins/schoolnews/lang/zh-cn/zh-cn.js" type="text/javascript" charset="utf-8" ></script>
    <!-- 如果需要页面渲染的话引入 -->
    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.parse.min.js" type="text/javascript" charset="utf-8" ></script>
    
	<script type="text/javascript">
		function submitForm(){
			var studentName = $("#studentName").val();
			var phone = $("#phone").val();
			var address = $("#address").val();
			var referrer = $("#referrer").val();
			var remark = $("#remark").val();
			if(null==studentName||""==$.trim(studentName)){
				alert("请输入姓名");
				return false;
			}
			if(null==phone||""==$.trim(phone)){
				alert("请填写联系电话");
				return false;
			}
			if(!validate(phone)){
				alert("联系电话只能填写数字");
				return false;
			}
			if(null==address||""==$.trim(address)){
				alert("请填写家庭住址");
				return false;
			}
			
			var schoolId = $("#schoolId").val();
			var newsId = $("#newsId").val();
			$.ajax({
				url:"<%=basePath %>applyInfo/addApplyInfo.do",
				data:{
					schoolId : schoolId,
					userName : $("#studentName").val(),
					phone : $("#phone").val(),
					address:address,
					referrer:referrer,
					remark:remark,
					birth : $("#birth").val(),
					sex : $("#sex").val(),
					newsId : newsId
				},
				async:false,
				type:"post",
				success:function(data){
					var isSuccess=eval("("+data+")");
					if(isSuccess+""=="success"){
						alert("添加成功");
						window.close();
					}
				}
			});
		}
		function validate(text){  
		    var reg = new RegExp("^[0-9]*$");  
		    var obj = text; 
		    var isTrue = false; 
			if(reg.test(obj)){  
				isTrue = true;
			}  
			if(/^[0-9]*$/.test(obj)){  
				isTrue = true;
			}  
			return isTrue;
		}
</script>
</html>