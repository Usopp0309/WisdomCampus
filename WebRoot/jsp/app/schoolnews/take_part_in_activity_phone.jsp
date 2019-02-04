<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
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
			<span>学校:</span>
			<span style="text-align: left;width: 60%;" id="schoolName">${school.schoolName }</span>
		</div>
		<div class="mrow" style="margin:20px auto 0px;">
			<span>活动名称:</span>
			<span style="text-align: left;width: 60%;" id="schoolName">${newsTitle }</span>
		</div>
		<div class="mrow">
			<span>学生姓名:</span>
			<input type="text" value="" id="name"/>
		</div>
		<div class="mrow">
			<span>学生性别:</span>
			<select id="sex">
				<option selected="selected" value="0">男</option>
				<option value="1">女</option>
			</select>
		</div>
		<div class="mrow">
			<span>入学年份:</span>
			<select id="schoolYear">
			</select>
		</div>
		<div class="mrow">
			<span>儿童人数:</span>
			<input type="text" value="" id="childNum"/>
		</div>
		<div class="mrow">
			<span>家长人数:</span>
			<input type="text" value="" id="adultNum"/>
		</div>
		<div class="mrow">
			<span>联系人:</span>
			<input type="text" value="" id="linkMan"/>
		</div>
		<div class="mrow">
			<span>联系电话:</span>
			<input type="text" value="" id="linkPhone"/>
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
	$(function(){
		year_num();
	})
	function year_num(){
		var num=parseInt(new Date().getFullYear())-10;
		var _div="";
		for(i=num;i<=parseInt(new Date().getFullYear());i++){
			_div+="<option value="+i+"入学>"+i+"入学</option>";
		}
		$("#schoolYear").append(_div)
	}
		function submitForm(){
			var name = $("#name").val();
			var sex = $("#sex").val();
			var schoolYear = $("#schoolYear").val();
			var linkMan = $("#linkMan").val();
			var linkPhone = $("#linkPhone").val();
			var childNum = $("#childNum").val();
			var adultNum = $("#adultNum").val();
			if(null==name||""==$.trim(name)){
				alert("请输入姓名");
				return false;
			}
			if(null==linkMan||""==$.trim(linkMan)){
				alert("请填写联系人姓名");
				return false;
			}
			if(null==linkPhone||""==$.trim(linkPhone)){
				alert("请填写联系电话");
				return false;
			}
			if(!validate(linkPhone)){
				alert("联系电话只能填写数字");
				return false;
			}
			if(null==childNum||""==$.trim(childNum)){
				alert("请填写儿童人数");
				return false;
			}
			if(null==adultNum||""==$.trim(adultNum)){
				alert("请填写大人人数");
				return false;
			}
			var schoolId = $("#schoolId").val();
			var newsId = $("#newsId").val();
			$.ajax({
				url:"<%=basePath %>applyInfo/addTakePartInActivity.do",
				data:{
					schoolId : schoolId,
					name:name,
					sex:sex,
					schoolYear:schoolYear,
					linkMan:linkMan,
					linkPhone:linkPhone,
					adultNum:adultNum,
					childNum:childNum,
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