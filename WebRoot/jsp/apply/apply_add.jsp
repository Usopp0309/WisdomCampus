<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->       
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" /> 
 	<link href="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
</head>

<body class="page-header-fixed">
	<header class="header">
		<div class="top">
			<img src="<%=basePath%>assets/global/img/m_img/logo.png" style="display:block;float:left;height:35px;margin:2px 0 0 0"><span style="color:#fff;line-height:40px;font-size:16px;display:block;float:left;margin:0px 0 0 15px;">RichX 智慧校园</span>
			<ul class="apply_addmenu_li">
				<li class="zhao_about1" style="float:left;width:20%"><a href="http://www.richx.cn/index.html" target="_blank"><span class="Response">关于</span>RICH</a></li>
				<li class="zhao_about2" style="float:left;width:20%"><a href="http://wpa.qq.com/msgrd?v=3&uin=6949265&site=qq&menu=yes" target="_blank">在线咨询</a></li>
			</ul>
		</div>
	</header>
	
	<section id="page_1" class="main">
		<img src="<%=basePath%>assets/global/img/m_img/State_1.jpg">
		<form action="<%=basePath%>apply/submitApplyInfo.do" id="submitForm1"
			class="form-horizontal" method="post" enctype="multipart/form-data">
			<div class="apply_container">
				<h4 class="alt_info">
					<i class="icon-info-sign"></i><span style="color:#f00">请学校官方申请，并补充附件资料，以便系统快速审核（以个人身份申请则无法通过审核）</span>
				</h4>
				<h4 class="alt_info">
					<i class="icon-info-sign"></i>请真实填写注册信息<em class="Response">，以便我们与您联系</em>
				</h4>
				<div class="apply_row">
					<div class="apply_title">学校区域</div>
					<div class="apply_Control">
						<select class="form-control apply_select" name="province"
							id="province" onchange="getChildrenArea('province','city')"></select>
						<select class="form-control apply_select" name="city" id="city"
							onchange="getChildrenArea('city','country')"></select> 
						<select	class="form-control apply_select" name="country" id="country"
							onchange="getChildrenArea('country','school')"></select>
					</div>
				</div>
				<div class="apply_row apply_row_padding_0">
					<div class="apply_title">学校名称</div>
					<div class="apply_Control v_error_text" style="position: relative;">
						<input type="text" class="form-control" AUTOCOMPLETE="OFF"
							style="background: none; margin: 0px; text-indent: 5px;"
							name="schoolName" id="school_name" onkeyup="filter(this.value)"
							onchange="filter(this.value)"
							onpropertychange="filter(this.value)"
							oninput="filter(this.value)" name="schoolName">
						<div class="schoolname_e">
							<span class="error_info"><i id="name_error"
								class="error_info_icon icon-remove-circle"></i>请输入学校名称</span>
						</div>
						<input id="schoolId" type="text" value="" style="display: none;">
						<select id="toSelectObj" size=5 class="form-control"></select>
						<select id="school_select" style="display: none"></select>
					</div>
					<!-- <div class="span3 clear_margin schoolname_e"><span class="error_info"><i id="name_error" class="error_info_icon icon-remove-circle"></i>请输入学校名称</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">学校性质</div>
					<div class="apply_Control">
						<label class="radio inline"><input class="property_input"
							type="radio" name="schoolType" value="0" checked><span class="property_span">公立</span></label>
						<lable class="radio inline">
						<input class="property_input" type="radio" name="schoolType"
							value="1" ><span class="property_span">私立</span></lable>
						<lable class="radio inline">
						<input class="property_input" type="radio" name="schoolType"
							value="2" ><span class="property_span">其他</span></lable>
					</div>
				</div>
				<div class="apply_row">
					<div class="apply_title">学校类别</div>
					<div class="apply_Control">
						<label class="radio inline">
						<input class="property_input" type="radio" name="schoolCategory" value="0" ><span class="property_span">幼儿园</span></label>
						<lable class="radio inline">
						<input class="property_input" type="radio" name="schoolCategory" value="1" checked><span class="property_span">义务教育(1-9年级)</span></lable>
						<lable class="radio inline">
						<input class="property_input" type="radio" name="schoolCategory" value="2" ><span class="property_span">高中</span></lable>
					</div>
				</div>
				<div class="apply_row" style="display:block;">
					<div class="apply_title">成立时间</div>
					<div class="apply_Control v_error_text">
						<input name="createTime" id="time" type="text" class="form-control" AUTOCOMPLETE="OFF" style="cursor: pointer;"> <span class="v_out">请输入成立时间</span>
					</div>
					<!-- <div class="span3 name_error_e"><span class="error_info"><i id="name_error" class="error_info_icon icon-remove-circle"></i>请输入名称</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">学生人数</div>
					<div class="apply_Control v_error_text">
						<input name="schoolNum" id="num" type="text" class="form-control">
						<span class="v_out">请输入学校的学生人数</span>
					</div>
					<!-- <div class="span3 name_error_e"><span class="error_info"><i id="name_error" class="error_info_icon icon-remove-circle"></i>请输入名称</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">校长姓名</div>
					<div class="apply_Control v_error_text">
						<input name="schoolMaster" id="school_schoolMaster" type="text" class="form-control no_bg">
						<div class="name_error_e">
							<span class="error_info"><i id="name_error"
								class="error_info_icon icon-remove-circle"></i>请输入名称</span>
						</div>
						<span class="v_out">请输入校长的真实姓名</span>
					</div>
					<!-- <div class="span3 name_error_e"><span class="error_info"><i id="name_error" class="error_info_icon icon-remove-circle"></i>请输入名称</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">校长手机号码</div>
					<div class="apply_Control v_error_text">
						<input name="schoolMasterPhone" id="schoolMasterPhone" type="text" class="form-control no_bg">
						<div class="phone_error_e xs_dispaly_block">
							<span class="error_info"><i id="phone_error"
								class="error_info_icon icon-remove-circle"></i>请正确输入校长手机号码</span>
						</div>
						<span class="v_out">请输入校长的手机号</span>
					</div>
					<!-- <div class="span3 phone_error_e"><span class="error_info"><i id="phone_error" class="error_info_icon icon-remove-circle"></i>请正确输入手机号码</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">姓名</div>
					<div class="apply_Control v_error_text">
						<input name="name" id="name" type="text" class="form-control no_bg">
						<div class="name_error_e">
							<span class="error_info"><i id="name_error"
								class="error_info_icon icon-remove-circle"></i>请输入名称</span>
						</div>
						<span class="v_out">请输入您的真实姓名</span>
					</div>
					<!-- <div class="span3 name_error_e"><span class="error_info"><i id="name_error" class="error_info_icon icon-remove-circle"></i>请输入名称</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">职称</div>
					<div class="apply_Control v_error_text">
						<input name="duties" id="title" type="text" class="form-control">
						<span class="v_out">请输入您在学校的职称或与学校的工作关系</span>
					</div>
					<!-- <div class="span3 name_error_e"><span class="error_info"><i id="name_error" class="error_info_icon icon-remove-circle"></i>请输入名称</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">手机号码</div>
					<div class="apply_Control v_error_text">
						<input name="phone" id="phone" type="text" class="form-control no_bg">
						<div class="phone_error_e">
							<span class="error_info"><i id="phone_error"
								class="error_info_icon icon-remove-circle"></i>请正确输入手机号码</span>
						</div>
						<span class="v_out">请输入您常用的手机号</span>
					</div>
					<!-- <div class="span3 phone_error_e"><span class="error_info"><i id="phone_error" class="error_info_icon icon-remove-circle"></i>请正确输入手机号码</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">附件资料(图片)</div>
					<div class="apply_Control v_error_text">
						<div class="fileinput fileinput-new" data-provides="fileinput">
                             <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                 <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt="" /> </div>
                             <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
                             <div>
                                 <span class="btn default btn-file">
                                     <span class="fileinput-new">选择图片</span>
                                     <span class="fileinput-exists">换一个</span>
                                     <input type="file" id="multiFile" name="multiFile"></span>
                                 <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput">删除</a>
                             </div>
                         </div>
						<span class="v_out"><a href="<%=basePath%>templet/apply_data.docx" class="margin_right_15">学校资料模板下载</a>请下载模板后填写内容，并盖章上传</span>
					</div>
					<!-- <div class="span3 phone_error_e"><span class="error_info"><i id="phone_error" class="error_info_icon icon-remove-circle"></i>请正确输入手机号码</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">邮箱</div>
					<div class="apply_Control v_error_text">
						<input id="email" name="email" type="text" class="form-control no_bg" style="width:30%;">
						<div class="email_error_e xs_dispaly_block">
							<span class="error_info"><i id="phone_error"
								class="error_info_icon icon-remove-circle"></i>请正确输入邮箱</span>
						</div>
						<button class="btn btn-large btn-warning margin_left_15 code"
							type="button" onclick="sendIdentifyingCode()" id="identifyingCodebtn">获取验证码</button>
						<span class="v_out">我们将把审核结果发送到您的邮箱<em class="Response">，务必填写无误</em></span>
					</div>
					<!-- <div class="span3 email_error_e"><span class="error_info"><i id="phone_error" class="error_info_icon icon-remove-circle"></i>请正确输入邮箱</span></div> -->
				</div>
				<div class="apply_row">
					<div class="apply_title">邮箱验证码</div>
					<div class="apply_Control v_error_text">
						<input id="email_code" name="email_code" type="text"
							class="form-control no_bg">
						<div class="email_code_e">
							<span class="error_info"><i id="phone_error"
								class="error_info_icon icon-remove-circle"></i>请正确输入邮箱验证码</span>
						</div>
					</div>
					<!-- <div class="span3 email_code_e"><span class="error_info"><i id="phone_error" class="error_info_icon icon-remove-circle"></i>请正确输入邮箱验证码</span></div> -->
				</div>
				
				
				<div class="apply_row">
					<div class="agreement" style="margin-left:35%;text-align:left;">
						<input class="agreement_checkbox" type="checkbox" id="check"
							checked onclick="changeSubmitButton()">
							<em>我同意并遵守</em>
					</div>
					<div class="agreement" style="margin-left:35%;text-align:left;">
						<a href="<%=basePath%>jsp/system/RichX.html" target="_blank">《RICH智慧校园平台服务协议》</a>
					</div>
					<div class="agreement" style="margin-left:35%;text-align:left;">
						<a href="<%=basePath%>jsp/system/AgreementInfo.html" target="_blank">《用户须知》</a>
					</div>
					<div class="agreement" style="margin-left:35%;text-align:left;">
						<a href="<%=basePath%>jsp/system/RichxPerson.html" target="_blank">《RichX智慧校园个人信息保护政策》</a>
					</div>
				</div>
				<div class="apply_row" style="padding:0px;">
					<div class="span12 clear_margin">
						<input type="submit" id="submitButton" value="提交"
							class="btn btn-primary"
							style="width: 300px; margin: 0px auto; display: block" />
						<!-- 	<span type="submit" class="a_link a_hover">提交申请</span> -->
					</div>
				</div>
			</div>
		</form>
	</section>

	<section id="page_2" class="main" style="display: none">
		<img src="<%=basePath%>assets/global/img/m_img/State_2.jpg">

		<div class="send_box">
			<div class="text_con">
				<div class="Success_icon">
					<img src="<%=basePath%>WebRoot/assets/global/img/m_img/Success_icon.png">
				</div>
				<div class="sussecc_text">
					<h3>感谢注册！我们将尽快对您的信息进行审核，</h3>
					<p>
						我们将以邮件方式将审核结果发至您注册邮箱：<a href="" id="goemail"></a>
					</p>
					<p>请耐心等待</p>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/public_module/public_footer.jsp" %>
 	<!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
     <script src="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
     <script src="<%=basePath%>assets/global/plugins/jquery.validate.min.js" type="text/javascript"></script>
    </body>
	<script>
		var identifyingCode = "";
		$(function() { 
			$("#submitButton").attr("disabled",false); 
			loadProvince();
			
			$('#time').datetimepicker({
				 timepicker:false,
				 lang:"ch",
				 format:"Y-m-d" 
				});
			
			//点击document隐藏下来框
			$(document).click(function(){
				 $("#toSelectObj").hide();
			})
			if("${status}"==-1){
				layer.msg("${msg}",{time:3000});
			}
		});
		
		function changeSubmitButton(obj){
			if($("#check").attr("checked") == "checked"){
				$("#submitButton").removeAttr("disabled");
				$("#check").attr("checked","checked")
			}else{
				$("#submitButton").attr("disabled","disabled");
				$("#check").removeAttr("checked");
			}
		}
		//加载省份
		function loadProvince(){
			$.ajax({
				type: "post",
				url: "<%=basePath%>apply/getPronvice.do",
				data:{
					},
				success: function(data){
					var list = $.parseJSON(data);
					var appendHtml = '<option value="0">----请选择----</option>';
					$.each(list, function(n, value) {  
						appendHtml += '<option value="' + value.areaId + '">' + value.areaName + '</option>';
          			}); 
          			$("#province").html(appendHtml);
				},
			});
			
		}
		
		//下拉框更改事件
		function getChildrenArea(parentId, childId){
			if (parentId == 'province'){//根据省获取地市
				$("#country").val("");
				$("#school").val("");
				$.ajax({
					type: "post",
					url: "<%=basePath%>apply/getChildrens.do",
					data:{
							areaId : $("#province").val()
						},
					success: function(data){
						var list = $.parseJSON(data);
						var appendHtml = '<option value="0">----请选择----</option>';
						$.each(list, function(n, value) {  
							appendHtml += '<option value="' + value.areaId + '">' + value.areaName + '</option>';
	          			}); 
	          			$("#city").html(appendHtml);
					},
				});
			}else if(parentId == 'city'){//根据地市获取区县
				$("#school").val("");
				$.ajax({
					type: "post",
					url: "<%=basePath%>apply/getChildrens.do",
					data:{
							areaId : $("#city").val()
						},
					success: function(data){
						var list = $.parseJSON(data);
						var appendHtml = '<option value="0">----请选择----</option>';
						if(list.length == 0){
							appendHtml += '<option value="' + $("#city").val() + '">城区 </option>';
							
						}else{
							$.each(list, function(n, value) {  
		           				appendHtml += '<option value="' + value.areaId + '">' + value.areaName + '</option>';
		          			}); 
							
						}
						
	          			$("#country").html(appendHtml);
					},
				});
			}else{//根据区县获取学校
				$.ajax({
					type: "post",
					url: "<%=basePath%>apply/getSchoolsByAreaId.do",
							data : {
								areaId : $("#country").val()
							},
							success : function(data) {
								var list = $.parseJSON(data);
								//var data = new Array();

								var appendHtml = '<option value="0">----请选择----</option>';

								$.each(
												list,
												function(n, value) {
													//data[n] =value.schoolId+'-'+value.schoolName;
													appendHtml += '<option value="' + value.schoolId + '">'
															+ value.schoolName
															+ '</option>';
												});

								/* $('#school_name').AutoComplete({
								    'data': data,
								    'itemHeight': 20,
								    'width': 280
								}).AutoComplete('show'); */

								appendHtml += '<option value="-1">其它</option>';
								$("#school_select").html(appendHtml);
							},
						});
			}
		}
		function filter(v) {
			var $SerTxt = v.trim();
			//全局数据用于存放toSelectObj中的text
			var arryText = new Array();
			//全局数据用于存放toSelectObj中的val
			var arryVal = new Array();
			$("#school_select").find("option").each(function(i, n) {
				arryText[i] = $(this).text();
				arryVal[i] = $(this).val();
			});

			if ($SerTxt != "" && $SerTxt != null) {
				$("#toSelectObj").css({
					"display" : "block"
				});
				var appendHtml = '';
				for (var i = 0; i < arryText.length; i++) {
					if (arryText[i].toLowerCase().indexOf($SerTxt) >= 0) {
						//添加到toSelectObject 中
						appendHtml += '<option value="' + arryVal[i] + '">'
								+ arryText[i] + '</option>';
					}
				}
				$("#toSelectObj").html(appendHtml);
				$("#toSelectObj option").on("click", function() {
					$("#school_name").val($(this).text());
					$("#schoolId").val($(this).val());
					$("#toSelectObj").hide();
				})
			} else {
				$("#toSelectObj").hide();
				var appendHtml = '';
				for (var i = 0; i < arryText.length; i++) {
					appendHtml += '<option value="' + arryVal[i] + '">'
							+ arryText[i] + '</option>';
				}
				$("#toSelectObj").html(appendHtml);

			}
		}
		//根据学校选择内容显示学校新增模块
		function showAddSchool() {
			var school = $("#school").val();
			$("#schoolName").val("");
			if (school == -1) {
				$("#addSchoolDiv").show();
			} else {
				$("#addSchoolDiv").hide();
			}
		}

		//表单校验相关---begin

		function checkForm() {
			var country = $("#country").val();
			
		}

		$(function() {
			$('#submitForm').validate({
				submitHandler : function (form) {
				 	var identifyingCodeInput = $("#email_code").val();
					if (identifyingCodeInput == ""){
						layer.msg("请输入验证码",{time:3000});
						return false;
					}
					
					if (identifyingCode != identifyingCodeInput){
						layer.msg("验证码错误，请重新输入",{time:3000});
						return false;
					} 
					var multiFile=$("#multiFile").val();
					if(multiFile=="" || multiFile==null){
						layer.msg("请上传附件",{time:2000});
						return;
					}else if(multiFile!=""){
						var d=multiFile.substring(multiFile.lastIndexOf(".")+1).toLowerCase();
						if(d!="png" && d!="jpg" && d!="jpeg"){
							layer.msg("支持图片格式:png,jpg,jpeg",{time:3000});
							return;
						}
					}
					$("#submitButton").attr("disabled",true); 
					var indexlayer = layer.msg('正在提交申请信息,请稍候。。。',{icon: 16,time:0,shade:0.3}); 
					form.submit();
				}
				
			});
			$('#school_name').rules('add', {
				required : true,
				messages : {
					required : '学校名称不能为空！',
				},
			});
			$('#school_schoolMaster').rules('add', {
				required : true,
				messages : {
					required : '校长名称不能为空！',
				},
			});
			$('#schoolMasterPhone').rules('add', {
				required : true,
				schoolMasterPhone : true,
				messages : {
					required : '校长手机不能为空！',
				},
			});
			$('#name').rules('add', {
				required : true,
				minlength : 2,
				messages : {
					required : '名称不能为空！',
					minlength : jQuery.format('名称不能小于{0}位！'),
				},
			});
			$('#phone').rules('add', {
				required : true,
				phone : true,
				messages : {
					required : '手机号不能为空！',
				},
			});
			$('#email').rules('add', {
				required : true,
				email : true,
				messages : {
					required : '邮箱不能为空！',
				},
			});
			$('#email_code').rules('add', {
				required : true,
				messages : {
					required : '验证码不能为空！',
				},
			});
			

			$.validator.addMethod(
					'schoolMasterPhone',
					function(value, element) {
						var tel = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
						return this.optional(element)
								|| (tel.test(value));
					}, '请输入正确的手机号！');
			
			$.validator.addMethod(
							'phone',
							function(value, element) {
								var tel = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
								return this.optional(element)
										|| (tel.test(value));
							}, '请输入正确的手机号！');

			$.validator.addMethod(
							'email',
							function(value, element) {
								var tel = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
								return this.optional(element)
										|| (tel.test(value));
							}, '请输入正确的邮箱！');

		})
		function getCode(){
			var arr = [ 0, 1, 2, 3, 4, 5, 6, "a", "b", "c", "d", "e", "f", "g" ];
			(function() {
				var randNum = null;
				var old = [];
				var str = "";
				function done() {
					randNum = Math.floor(Math.random() * 14);
					if (only(randNum, old)) {
						str = str + arr[randNum];
						old.push(randNum);
					} else {
						done();
					}
				}
				for (var index = 0; index < 4; index++) {
					done();
				}
				identifyingCode = str;
			})(arr)
		}

		//表单校验相关---end
		function sendIdentifyingCode() {
			getCode();
			var email = $("#email").val();
			if (email == ""){
				alert("请输入邮件地址");
				return false;
			}
			var name = $("#name").val();
			if (name == ""){
				alert("请输入联系人姓名");
				return false;
			}
			$("#identifyingCodebtn").attr("disabled","disabled");
			$.ajax({
				type: "post",
				url: "<%=basePath%>mail/sendValidCode.do",
						data : {
							code : identifyingCode,
							email : email,
							name : name
						},
						success : function(data) {
							var datas = $.parseJSON(data);
							if (datas.status == -1){
								alert("发送失败，请重新获取验证码");
							}
						},
						complete: function(){
							$("#identifyingCodebtn").removeAttr("disabled");
						}
					});
		}
		function only(ele, arr) {
			if (arr.length == 0) {
				return true;
			}
			for (var j = 0; j < arr.length; j++) {
				if (ele == arr[j]) {
					return false;
				} else {
					return true;
				}
			}
		}

		
	</script>
</html>