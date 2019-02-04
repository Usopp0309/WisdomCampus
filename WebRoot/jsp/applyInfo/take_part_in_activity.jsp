<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<title>我要参加</title>
 <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束--> 
<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css"/>
</head>
<body>
 <%@ include file="/public_module/public_header.jsp"%>  
 <div style="height: 100px;"></div>
<div>
	<div >
	<div class="news_relsase col-md-9 col-sm-9">
	<input type="hidden" value="${newsId }" id="newsId" />
	<h2><span class="m_clear col-md-3 col-sm-3 m_text_center" style="margin:0px auto;display:block;float:none">参加申请</span></h2>
	<p><span class="m_clear col-md-3 col-sm-3 m_text_center" style="margin:0px auto;display:block;border-bottom:5px solid #1b90ef;float:none;font-size:12px;">PARTICIPATE APPLICATION</span></p>
	
	<div class="m_row">
		<div class="col-md-6 col-sm-6"><label>活动名称：</label><span id="schoolId">${newsTitle}</span></div>
	</div>
	<div class="m_row">
		<div class="col-md-6 col-sm-6">
			<label>报名学校：</label>
			<span id="schoolId">${school.schoolName }</span>
		</div>
		<div class="col-md-6 col-sm-6">
			<label class="control-label col-md-3" style="margin-top:8px;">学生姓名：</label>
			<div class="m_controls">
				<input class="col-md-12 col-sm-12 form-control" type="text" value="" id="name"/>
			</div>
		</div>
	</div>
	<div class="m_row">
		<div class="col-md-6 col-sm-6">
			<label class="control-label col-md-3" style="margin-top:8px;">学生性别：</label>
			<div class="m_controls">
			<select class="col-md-12 col-sm-12 form-control" id="sex">
				<option selected="selected" value="0">男</option>
				<option value="1">女</option>
			</select>
			</div>
		</div>
		<div class="col-md-6 col-sm-6">
			<label class="control-label col-md-3" style="margin-top:8px;">入学年份：</label>
			<div class="m_controls">
				<select class="col-md-12 col-sm-12 form-control" id="schoolYear">
					
				</select>
			</div>
		</div>
	</div>
	<div class="m_row">
		<div class="col-md-6 col-sm-6">
			<label  class="control-label col-md-3" style="margin-top:8px;">联系人：</label>
			<div class="m_controls">
				<input class="col-md-12 col-sm-12 form-control" type="text" value="" id="linkMan"/>
			</div>
		</div>
		<div class="col-md-6 col-sm-6">
			<label  class="control-label col-md-3" style="margin-top:8px;">联系电话:</label>
			<div class="m_controls">
				<input class="col-md-12 col-sm-12 form-control" type="text" value="" id="linkPhone"/>
			</div>
		</div>
	</div>
	
	<div class="m_row">
		<div class="col-md-6 col-sm-6">
			<label  class="control-label col-md-3" style="margin-top:8px;">儿童人数：</label>
			<div class="m_controls">
				<input class="col-md-12 col-sm-12 form-control" type="text" value="" name="childNum" id="childNum"/>
			</div>
		</div>
		<div class="col-md-6 col-sm-6">
			<label  class="control-label col-md-3" style="margin-top:8px;">家长人数：</label>
			<div class="m_controls">
				<input class="col-md-12 col-sm-12 form-control" type="text" value="" id="adultNum" name="adultNum"/>
			</div>
		</div>
	</div>
	<p class="m_text_center" style="color:grey">注：尽量填写正确信息，方便及时与您联系</p>
	<div class="m_text_center"><input class="btn green" type="button" onclick="submitForm()" value="提交申请" /></div>
	</div>
</div>
	
</div>
 <%@include file="/public_module/public_footer.jsp" %>
 </body>
 <%@include file="/public_module/public_js.jsp"%>
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
		layer.tips("请输入姓名",$("#name"));
		return false;
	}
	if(null==linkMan||""==$.trim(linkMan)){
		layer.tips("请填写联系人姓名",$("#linkMan"));
		return false;
	}
	if(null==linkPhone||""==$.trim(linkPhone)){
		layer.tips("请填写联系电话",$("#linkPhone"));
		return false;
	}
	if(!validate(linkPhone)){
		layer.tips("联系电话只能填写数字",$("#linkPhone"));
		return false;
	}
	if(null==childNum||""==$.trim(childNum)){
		layer.tips("请填写儿童人数",$("#childNum"));
		return false;
	}
	if(null==adultNum||""==$.trim(adultNum)){
		layer.tips("请填写大人人数",$("#adultNum"));
		return false;
	}
	$.ajax({
		url:"<%=basePath %>applyInfo/addTakePartInActivity.do",
		data:{
			schoolId:'${school.schoolId}',
			name:name,
			sex:sex,
			schoolYear:schoolYear,
			linkMan:linkMan,
			linkPhone:linkPhone,
			adultNum:adultNum,
			childNum:childNum,
			newsId:$("#newsId").val()
		},
		async:false,
		type:"post",
		success:function(data){
			var isSuccess=eval("("+data+")");
			if(isSuccess+""=="success"){
				layer.msg("添加成功",{icon:1,time:1000});
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