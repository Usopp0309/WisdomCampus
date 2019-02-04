<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
        <meta charset="utf-8" />
        <title>学生家长信息修改</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束-->
        </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed">
    	<input class="themes" type="hidden" value="<%=basePath%>">
        <!-- 公共顶部开始-->
        <%@ include file="/public_module/public_header.jsp"%>    
        <!--公共顶部结束-->
        <div class="clearfix"> </div>
        <!-- 内容页开始 -->
        <div class="page-container">
            <!--主菜单开始-->
            <%@include file="/public_module/public_menu.jsp"%>
            <!--主菜单结束-->
            <div class="page-content-wrapper">
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">学校管理</a><i class="fa fa-circle"></i></li>
                            <li><span>学生家长信息修改</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">学生家长信息修改</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption"><i class="fa fa-list"></i>学生资料修改</div>
	                            </div>
	                            <div class="portlet-body m_overflow_hidden form-horizontal">
	                                <div class="col-md-6 col-sm-6 col-lg-8">
	                                	<div class="row">
	                                		<div class="col-md-12 col-sm-12 col-lg-6">
	                                			<div class="form-group">
	                                                <label class="control-label col-md-4 col-lg-3">亦信号</label>
	                                                <div class="col-md-8 col-lg-9">
	                                                    <input type="text" readonly="readonly"  class="form-control" value="${student.username}"/>
	                                                </div>
	                                            </div>
	                                		</div>
	                                		<div class="col-md-12 col-sm-12 col-lg-6">
	                                			<div class="form-group">
	                                                <label class="control-label col-md-4 col-lg-3">学号<span style="color: red;">*</span></label>
	                                                <div class="col-md-8 col-lg-9">
	                                                   <input type="text" name="code" id="code" class="form-control" value="${student.code}"/>
											           
	                                                </div>
	                                            </div>
	                                		</div>
	                                	</div>
	                                	<div class="row">
	                                		<div class="col-md-12 col-sm-12 col-lg-6">
	                                			<div class="form-group">
	                                                <label class="control-label col-md-4 col-lg-3">班级</label>
	                                                <div class="col-md-8 col-lg-9">
	                                               <select class="form-control" tabindex="1" name="clazzname" tabindex="1" id="clazzSelect">
												    
											       </select>
	                                                </div>
	                                            </div>
	                                		</div>
	                                		<div class="col-md-12 col-sm-12 col-lg-6">
	                                			<div class="form-group">
	                                                <label class="control-label col-md-4 col-lg-3">姓名</label>
	                                                <div class="col-md-8 col-lg-9">
	                                                   <input type="text" size="16" name="name"  id="name" class="form-control" value="${student.realName}"/>
	                                                </div>
	                                            </div>
	                                		</div>
	                                	</div>
	                                	<div class="row">
	                                		<div class="col-md-12 col-sm-12 col-lg-6">
	                                			<div class="form-group">
	                                                <label class="control-label col-md-4 col-lg-3">类型</label>
	                                                <div class="col-md-8 col-lg-9">
	                                              <select class="form-control" tabindex="1" name="type" id="typeSelcet" value="${student.type }">
												    <option value="" <c:if test="${empty student.type }">selected="selected"</c:if> >其它</option>
							                        <option value="0" <c:if test="${student.type==0}">selected="selected"</c:if>>走读生</option>
							                        <option value="1" <c:if test="${student.type==1}">selected="selected"</c:if>>住宿生</option>
							                        <option value="2"  <c:if test="${student.type==2}">selected="selected"</c:if>>停用</option>
											     </select>
	                                                </div>
	                                            </div>
	                                		</div>
	                                		
	                                	</div>
	                                	<div class="row">
	                                		<div class="col-md-6 col-sm-6">
	                                			 <div class="col-md-offset-3 col-md-9">
	                                			 	<input type="hidden" value="${student.code}" id="originalcode"/>
												 	<input type="hidden" value="${student.clazzId}" id="orignialclazzId"/>
												 	<input type="hidden" value="${student.type}" id="orignialstudentType"/>
												 	<input type="hidden" value="${student.realName}" id="orignialstudentName"/>
												 	<input type="hidden" value="${student.userId}" id="studentId"/>
                                                </div>
	                                		</div>
	                                	</div>
	                                </div>
	                                <div class="col-md-6 col-sm-6 col-lg-4">
	                                <div class="row">
	                                		<div class="col-md-12 col-sm-12" id="studengtCard">
	                                			<div class="form-group cardDiv" id="studentCardDiv">
	                                               
	                                            </div>
	                                		</div>
	                                	</div>
	                                </div>
	                            </div>
                                               
	                        </div>
                            <div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption"><i class="fa fa-list"></i>家长资料修改</div>
	                            </div>
	                            <div class="portlet-body m_overflow_hidden form-horizontal">
	                                <div class="row parents">
	                                		<div class="col-md-12 col-sm-12 col-lg-6" id="deleteParent1">
	                                			<div class="portlet">
					                                <div class="portlet-title">
					                                    <div class="caption">
					                                        <span class="caption-subject font-dark">家长一</span>
					                                        
					                                        	<c:if test="${parent1.isReciveSms eq '0' }">
					                                        		<div class="Check on" title="勾选之后家长可以接收短信">
					                                        			<input onclick="confirmSendSms('chk1')" type="checkbox" checked="checked" name="chk1">
					                                        		</div>
					                                        	</c:if>
					                                        	<c:if test="${parent1.isReciveSms eq '1' }">
					                                        		<div class="Check" title="勾选之后家长可以接收短信">
					                                        			<input onclick="confirmSendSms('chk1')" type="checkbox" name="chk1">
					                                        		</div>
					                                        	</c:if>
					                                        
					                                    </div>
					                                </div>
					                                <div class="portlet-body">
                                						<div class="col-md-6 col-sm-6 col-lg-6">
                                						   <div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3 col-lg-4">亦信号</label>
				                                                <div class="col-md-9 col-lg-8">
				                                                   <input type="text" readonly="readonly" class="form-control" value="${parent1.userName}"/>
				                                                </div>
				                                            </div>
                                							<div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3 col-lg-4">绑定手机</label>
				                                                <div class="col-md-9 col-lg-8">
				                                                   <input size="16" name="phone1" id="phone1" class="form-control" value="${parent1.bindPhone}" type="text">
				                                                </div>
				                                            </div>
				                                            <div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3 col-lg-4">姓名</label>
				                                                <div class="col-md-9 col-lg-8">
				                                                    <input size="16" name="parentname1" id="parentname1" class="form-control" value="${parent1.realName}" type="text">
				                                                </div>
				                                            </div>
				                                            <div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3 col-lg-4">密码</label>
				                                                <div class="col-md-9 col-lg-8">
				                                                      <input size="16" name="passWord1" id="passWord1" class="form-control" value="" type="text" placeholder="若输入密码则会修改原密码">
				                                                </div>
				                                            </div>
				                                            <div class="form-group m_overflow_hidden" style="padding-left: 100px;">
																<button type="button" class="btn btn-sm red"  onclick="deleteParent(1)"><i class="icon-ok"></i>删除</button>
															 	
				                                            </div>
				                                            
				                                            
                                						</div>
                                						<div class="col-md-6 col-sm-6 col-lg-6" id="parentCardDiv1">
                                							
                                						</div>
                                						<!-- 隐藏 -->
                                						<div class="row">
						                                		<div class="col-md-6 col-sm-6">
						                                			 <div class="col-md-offset-3 col-md-9">
						                                			 	<input type="hidden" value="${parent1.userId}" name="parentId1" id="parentId1" >
						                                			 	<input type="hidden" value="${parent1.bindPhone}" id="originalparent1BindPhone"/>
																	 	<input type="hidden" value="${parent1.phone}" id="orignialparent1RecivePhone"/>
																	 	<input type="hidden" value="${parent1.realName}" id="orignialparent1name"/>
					                                                </div>
						                                		</div>
	                                					</div>
					                                </div>
					                            </div>
	                                		</div>
	                                		<div class="col-md-12 col-sm-12 col-lg-6" id="deleteParent2">
	                                			<div class="portlet">
					                                <div class="portlet-title">
					                                    <div class="caption">
					                                        <span class="caption-subject font-dark">家长二</span>
					                                        	<c:if test="${parent2.isReciveSms eq '0' }">
					                                        		<div class="Check on" title="勾选之后家长可以接收短信">
					                                        			<input onclick="confirmSendSms('chk2')" type="checkbox" checked="checked" name="chk2">
					                                        		</div>
					                                        	</c:if>
					                                        	<c:if test="${parent2.isReciveSms eq '1' }">
					                                        		<div class="Check" title="勾选之后家长可以接收短信">
					                                        			<input onclick="confirmSendSms('chk2')" type="checkbox" name="chk2">
					                                        		</div>
					                                        	</c:if>
					                                    </div>
					                                </div>
					                                <div class="portlet-body">
                                						<div class="col-md-6 col-sm-6">
                                						<div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3">亦信号</label>
				                                                <div class="col-md-9">
				                                                   <input type="text" readonly="readonly" class="form-control" value="${parent2.userName}"/>
				                                                </div>
				                                            </div>
                                							<div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3">绑定手机</label>
				                                                <div class="col-md-9">
				                                                    <input size="16" name="phone2" id="phone2" class="form-control" value="${parent2.bindPhone}" type="text">
				                                                </div>
				                                            </div>
				                                            <div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3">姓名</label>
				                                                <div class="col-md-9">
				                                                   <input size="16" name="parentname2" id="parentname2" class="form-control" value="${parent2.realName}" type="text">
				                                                </div>
				                                            </div>
				                                            <div class="form-group m_overflow_hidden">
				                                                <label class="control-label col-md-3">密码</label>
				                                                <div class="col-md-9">
				                                                   <input size="16" name="passWord2" id="passWord2" class="form-control" value="" type="text" placeholder="若输入密码则会修改原密码">
				                                                </div>
				                                            </div>
				                                            <div class="form-group m_overflow_hidden" style="padding-left: 100px;">
															<button type="button" class="btn btn-sm red" onclick="deleteParent(2)"><i class="icon-ok"></i>删除</button>
				                                            </div>
                                						</div>
                                						<div class="col-md-6 col-sm-6 col-lg-6" id="parentCardDiv2">
                                							
                                						</div>
                                						<!-- 隐藏 -->
                                						<div class="row">
						                                		<div class="col-md-6 col-sm-6">
						                                			 <div class="col-md-offset-3 col-md-9">
						                                			 	<input type="hidden" value="${parent2.userId}" name="parentId2" id="parentId2" >
						                                			 	<input type="hidden" value="${parent2.bindPhone}" id="originalparent2BindPhone"/>
																	 	<input type="hidden" value="${parent2.phone}" id="orignialparent2RecivePhone"/>
																	 	<input type="hidden" value="${parent2.realName}" id="orignialparent2name"/>
					                                                </div>
						                                		</div>
	                                					</div>
					                                </div>
					                            </div>
	                                		</div>
	                                	</div>
	                            </div>
	                        </div>
	                        <div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption"><i class="fa fa-list"></i>家长接收短信号码修改</div>
	                            </div>
	                            <div class="portlet-body m_overflow_hidden form-horizontal">
	                                <div class="row">
	                                		<div class="col-md-6 col-sm-6 col-lg-4  parent1PhoneDiv">
		                                		<div class="form-group m_overflow_hidden">
	                                                <label class="control-label col-md-3">家长1手机号</label>
	                                                <div class="col-md-7">
	                                                    <input size="16" name="parent1Phone" id="parent1Phone" class="form-control" value="${parent1.phone}" type="text">
	                                                </div>
	                                                <div class="col-md-2">
	                                                    <a href="javascript:;" class="btn btn-icon-only green" onclick="appendPhoneAdd(this)">
                                                         <i class="fa fa-plus"></i>
                                                         </a>
	                                                </div>
	                                            </div>
	                                		</div>
	                                		<div class="col-md-6 col-sm-6 col-lg-4 parent2PhoneDiv">
		                                		<div class="form-group m_overflow_hidden ">
	                                                <label class="control-label col-md-3">家长2手机号</label>
	                                                <div class="col-md-7">
	                                                     <input size="16" name="parent2Phone" id="parent2Phone" class="form-control" value="${parent2.phone}" type="text">
	                                                </div>
	                                                <div class="col-md-2">
	                                                    <a href="javascript:;" class="btn btn-icon-only green" onclick="appendPhoneAdd(this)">
                                                         <i class="fa fa-plus"></i>
                                                         </a>
	                                                </div>
	                                            </div>
	                                		</div>
	                                	</div>
	                            </div>
	                        </div>
	                        <div class="clearfix m_text_align_conter m_margin_15_0">
						        <button type="button" class="btn design_btn" id="save" onclick="updateParent()"><i class="icon-ok"></i>保存</button>
	                            <button type="button" class="btn back_btn" onclick="return_page();">返回</button>
	                            <input value="${queryContent }" type="hidden" id="queryContent">
	                        </div>
                         </div>
                   	</div>
                    </div>
                    </div>
                </div>
            </div>
            <!-- 亦信聊天开始 -->
        	<%@ include file="/public_module/public_QQ.jsp" %>
            <!-- 亦信聊天结束 -->
        </div>
        <!-- 内容页结束 -->
        <!-- 底部开始 -->
        <%@ include file="/public_module/public_footer.jsp" %>
        <!-- 底部结束 -->
    </body>
        <!-- 公共js开始 -->
        <%@ include file="/public_module/public_js.jsp" %>
        <!-- 公共js结束 -->
	<script src="<%=basePath%>assets/global/plugins/layer/layer.js"></script>
	<script>
	var originalstudentCardCodeArray=[];
	var originalparent1CardCodeArray=[];
	var originalparent2CardCodeArray=[];
	var originalparent1ForwrdPhoneArray=[];
	var originalparent2ForwrdPhoneArray=[];
	var aLi = document.querySelectorAll('.Check');  
	for (var i=0;i<aLi.length;i++ )
	{
	    aLi[i].ifCheck = false;                       
	    aLi[i].nowClass = aLi[i].className;           
	    aLi[i].onclick = function(){
	         if(this.ifCheck){                        
	            this.className = this.nowClass        
	    }else{
	            this.className += ' on'                
	            }                                     
	        this.ifCheck = !this.ifCheck;              
	    };
	};
	$(function() 
	{  
		loadSubMenu("schoolManager"); 
		//选取当前菜单位置
		setActive("schoolManager","studentParentManage");  
		$("body,html",parent.document).animate({ scrollTop: 0 },0);
		loadAllClazzList();
		loadStudentCardListForModify();
		loadParentCardListForModify(1,"parentCardDiv1");
		loadParentCardListForModify(2,"parentCardDiv2");
		loadParentForwardPhoneForModify(1,"parent1PhoneDiv");
		loadParentForwardPhoneForModify(2,"parent2PhoneDiv");
		$("#code").blur(function(){
			var code=$.trim($("#code").val());
			var originalcode=$.trim($("#originalcode").val());
			if(code==""){
				layer.tips("请输入学号","#code");
			}else if(checkCode(code,originalcode)){
				layer.tips("该学号已有人在用","#code");
			}
		});
		$("#name").blur(function(){
			var name=$.trim($("#name").val());
			if(name==""){
				layer.tips("学生姓名不为空","#name");
			}
		});
		$("#phone1").blur(function(){
			var phone1=$.trim($("#phone1").val());
			if(phone1!="" && !checkSubmitMobil(phone1)){
				layer.tips("该手机号格式不对","#phone1");
			}
		});
		$("#phone2").blur(function(){
			var phone2=$.trim($("#phone2").val());
			if(phone2!="" && !checkSubmitMobil(phone2)){
				layer.tips("该手机号格式不对","#phone2");
			}
		});
		$("#parent1Phone").blur(function(){
			var parent1Phone=$.trim($("#parent1Phone").val());
			if(parent1Phone!="" && !checkSubmitMobil(parent1Phone)){
				layer.tips("该手机号格式不对","#parent1Phone");
			}
		});
		$("#parent2Phone").blur(function(){
			var parent2Phone=$.trim($("#parent2Phone").val());
			if(parent2Phone!="" && !checkSubmitMobil(parent2Phone)){
				layer.tips("该手机号格式不对","#parent2Phone");
			}
		});
		$("#clazzSelect").blur(function(){
			var clazzSelect=$.trim($("#clazzSelect").val());
			if(clazzSelect==0){
				layer.tips("请选择班级","#clazzSelect");
			}
		});
		
	});

	function updateParent(){
		//判断学生有没有修改
		if(checkTotalFormStudent() && checkTotalFormParent1() && checkTotalFormParent2()){
			updateStudent();
			updateAddParent1();
			updateAddParent2();
			return_page();
		}
	}

	function checkTotalFormStudent(){
		var isCheckPass = true;
		$("#studentCardDiv").find("input[name='cardCode']").each(function(){
			if($.trim($(this).val())!=""){
				var cardCode=$.trim($(this).val());
				var old=$.trim($(this).next().val());
				if(cardCode!="" && checkCardCode(cardCode,old)){
					layer.tips("该卡号已被使用",$(this));
					isCheckPass=false;
					return isCheckPass;
				}
			}
		});
		if(!checkFormStudent()){
			isCheckPass = false;
		}
		return isCheckPass;
	}

	function checkFormStudent()
	{
		//学号
		var code = $("#code").val();
		var originalcode = $("#originalcode").val();
		var clazzSelect = $("#clazzSelect").val();
		var name = $("#name").val();
		//未输入学号
		if ("" == code)
		{
			layer.tips("学号不能为空","#code");
			return false;
		}
		else if (checkCode(code, originalcode) && originalcode != code)
		{
			layer.tips("学号已存在","#code");
			return false;
		}
		//未输入姓名
		if ("" == name)
		{
			layer.tips("姓名不能为空","#name");
			return false;
		}
		if(clazzSelect==0){
			layer.tips("请选择班级","#clazzSelect");
			return false;
		}
	   return true;
	}
	
	function checkTotalFormParent1(){
		var isCheckPass = true;
		$("#parentCardDiv1").find("input[name='cardCode']").each(function(){
			if($.trim($(this).val())!=""){
				var cardCode=$.trim($(this).val());
				var old=$.trim($(this).next().val());
				if(cardCode !="" && checkCardCode(cardCode,old)){
					layer.tips("家长1卡号已被使用",$(this));
					isCheckPass=false;
					return isCheckPass;
				}
			}
		});
		if(!checkFormParent1()){
			isCheckPass = false;
		}
		return isCheckPass;
	}

    function checkFormParent1(){ 
        var isParent1Add = false;     
    	var parentId1 = $("#parentId1").val();
    	var phone1=$.trim($("#phone1").val());
    	var parent1Phone=$.trim($("#parent1Phone").val());
    	var parentname1=$.trim($("#parentname1").val());
    	if(parentId1 == ""){
    		isParent1Add = true;
			//说明是新原先没有家长2
			if(phone1 != ""){
				if(phone1==""){
	        		layer.tips("请输入该手机号!","#phone1");
	        		return false
	        	}else if(parentname1==""){
	        		layer.tips("请输入姓名!","#parentname1");
	        		return false
	        	}else if(phone1!="" && !checkSubmitMobil(phone1)){
	        		layer.tips("该手机号格式不对!","#phone1");
	        		return false;
	        	}else if(parent1Phone!="" &&  !checkSubmitMobil(parent1Phone)){
	        		layer.tips("该手机号格式不对!","#parent1Phone");
	        		return false;
	        	}else if(parentname1.length>50){
	        		layer.tips("姓名最多50个字!","#parentname1");
	        		return false;	
	        	}
			}
    	}else{
    		isParent1Add = false;
        	if(phone1==""){
        		layer.tips("请输入该手机号!","#phone1");
        		return false
        	}else if(parentname1==""){
        		layer.tips("请输入姓名!","#parentname1");
        		return false
        	}else if(phone1!="" && !checkSubmitMobil(phone1)){
        		layer.tips("该手机号格式不对!","#phone1");
        		return false;
        	}else if(parent1Phone!="" &&  !checkSubmitMobil(parent1Phone)){
        		layer.tips("该手机号格式不对!","#parent1Phone");
        		return false;
        	}else if(parentname1.length>50){
        		layer.tips("姓名最多50个字!","#parentname1");
        		return false;	
        	}
        }

    	if(phone1 != ""){
    	    var originalparent1BindPhone=$.trim($("#originalparent1BindPhone").val());
        	var t=checkTeacherPhone(phone1,originalparent1BindPhone);
    		 if(t.flag){
    			 var userId_=t.userId;
    			 if(isParent1Add){
    				 //新增用户
    				 if(confirm(t.msg+'，继续会将该小孩与占用该手机号的用户绑定在一起，是否继续？')){
    					 return true;
    				 }else{
    					 return false;
    				 }
    			 }else{
    				//修改用户
    				 if(parentId1 != userId_){
    					 layer.alert(t.msg+'，不允许修改');
    					 return false;
    				 }else if(parentId1 == userId_){
    					 return true;
    				 }
    			 }
    		}else{
    			return true;
    		}
        	return true;
        }
    	return true;
    }
	
	function checkTotalFormParent2(){
		var isCheckPass = true;
		$("#parentCardDiv2").find("input[name='cardCode']").each(function(){
			if($.trim($(this).val())!=""){
				var cardCode=$.trim($(this).val());
				var old=$.trim($(this).next().val());
				if(cardCode !="" && checkCardCode(cardCode,old)){
					layer.tips("家长2的卡号已被使用",$(this));
					isCheckPass=false;
					return isCheckPass;
				}
			}
		});
		if(!checkFormParent2()){
			isCheckPass = false;
		}
		return isCheckPass;
	}

    function checkFormParent2(){
    	var isParent2Add = false;   
        var parentId2 = $("#parentId2").val();
        var phone2=$.trim($("#phone2").val());
    	var parent2Phone=$.trim($("#parent2Phone").val());
    	var parentname2=$.trim($("#parentname2").val());
        if(parentId2 == ""){
        	isParent2Add = true;
			//说明是新原先没有家长2
			if(phone2 != ""){
				//说明原先有家长2
	        	if(phone2==""){
	        		layer.tips("请输入该手机号!","#phone2");
	        		return false
	        	}else if(parentname2==""){
	        		layer.tips("请输入姓名!","#parentname2");
	        		return false
	        	}else if(phone2!="" && !checkSubmitMobil(phone2)){
	        		layer.tips("该手机号格式不对!","#phone2");
	        		return false;
	        	}else if(parentname2.length>50){
	        		layer.tips("姓名最多50个字!","#parentname2");
	        		return false;	
	        	}else if(parent2Phone!="" &&  !checkSubmitMobil(parent2Phone)){
	        		layer.tips("该手机号格式不对!","#parent2Phone");
	        		return false;
	        	}
			}
        }else{
        	isParent2Add = false;
			//说明原先有家长2
        	if(phone2==""){
        		layer.tips("请输入该手机号!","#phone2");
        		return false
        	}else if(parentname2==""){
        		layer.tips("请输入姓名!","#parentname2");
        		return false
        	}else if(phone2!="" && !checkSubmitMobil(phone2)){
        		layer.tips("该手机号格式不对!","#phone2");
        		return false;
        	}else if(parentname2.length>50){
        		layer.tips("姓名最多50个字!","#parentname2");
        		return false;	
        	}else if(parent2Phone!="" &&  !checkSubmitMobil(parent2Phone)){
        		layer.tips("该手机号格式不对!","#parent2Phone");
        		return false;
        	}
        }
		
        if(phone2 != ""){
    	    var originalparent2BindPhone=$.trim($("#originalparent2BindPhone").val());
        	var t=checkTeacherPhone(phone2,originalparent2BindPhone);
    		 if(t.flag){
    			 var userId_=t.userId;
    			 if(isParent2Add){

    				 if(confirm(t.msg+'，继续会将该小孩与占用该手机号的用户绑定在一起，是否继续？')){
    					 return true;
    				 }else{
    					 return false;
    				 }
    			 }else{
    				//修改用户
    				 if(parentId2 != userId_){
    					 layer.alert(t.msg+'，不允许修改');
    					 return false;
    				 }else if(parentId2 == userId_){
    					 return true;
    				 }
    			 }
    		}else{
    			return true;
    		}
        }
        return true;
    }

    //检查学号/工号是否存在
	function checkCode(code,originalcode)
	{
		var flag = false;
		$.ajax({
			async:false, 
			type: "post",
			data:{
				code : code,
				originalcode : originalcode
			},
			url: "<%=basePath%>student/checkModifyStudentByCode.do",
			success: function(data)
			{
				var result = eval("(" + data + ")");
				//此学号存在
				if (result)
				{
					flag = true;
				}
				else
				{
					flag = false;
				}
			},
		});
		return flag;
	}

	 //手机校验
	 function checkTeacherPhone(phone,name){
		var flag="";
		 $.ajax({
				type: "post",
				url: "<%=basePath%>teacher/checkTeacherPhone.do",
				dataType:"json",
				async: false, 
				data:{
					phone : phone,
					name:name
				},
				success: function(data){
					flag=data;
				}
			});
		   return flag;
	}
		
  	//检查卡号是否存在
	function checkCardCode(code,originalCardCode)
	{
		var flag = false;
		$.ajax({
			async:false, 
			type: "post",
			data:{
				code : code,
				originalCardCode : originalCardCode
			},
			url: "<%=basePath%>teacher/checkModifyTeacherCardCodeByCardCode.do",
			success: function(data)
			{
				var result = eval("(" + data + ")");
				//此卡号号存在
				if ("success" == result.resultCode)
				{
					flag = true;
				}
				else
				{
					flag = false;
				}
			},
		});
		
		return flag;
	}
	 //更新学生信息
	function updateStudent(){
		var isUpdateStudentFlag = false;

		var studentId=$("#studentId").val();
		var code=$.trim($("#code").val());
		var name=$.trim($("#name").val());
		var type=$.trim($("#typeSelcet").val());
		var clazzId=$.trim($("#clazzSelect").val());
		
		var studentOriginalcode = $.trim($("#originalcode").val()); 
		//学生学号
		if(studentOriginalcode != code){
			isUpdateStudentFlag = true;
		}
		var orignialstudentName = $.trim($("#orignialstudentName").val());
		//学生姓名
		if(orignialstudentName != name){
			isUpdateStudentFlag = true;
		}

		//学生班级
		var orignialclazzId = $("#orignialclazzId").val();
		if(clazzId != orignialclazzId){
			isUpdateStudentFlag = true;
		}
		
		//学生类型
		var orignialstudentType = $("#orignialstudentType").val();
		if(orignialstudentType != type){
			isUpdateStudentFlag = true;
		}
		//学生卡号
		var cardCodeArry=[];
		var iscontine=true;
		$("#studentCardDiv").find("input[name='cardCode']").each(function(){
			if($.trim($(this).val())!=""){
				var cardCode=$.trim($(this).val());
				cardCodeArry.push(cardCode);
			}
		});

		var isModifyCardCodeFlag = isModifyCardCode(originalstudentCardCodeArray,cardCodeArry);
		if(isModifyCardCodeFlag){
			isUpdateStudentFlag = true;
		}
		if(isUpdateStudentFlag){
			var indexlayer = layer.msg('正在保存学生信息,请稍候。。。',{icon: 16,time:0,shade:0.3}); 
		   $.ajax({
				url:"<%=basePath%>student/updateStudent.do",
				type:"post",
				dataType:"json",
				async:false,
				data:{"studentId":studentId,"type":type,"code":code,"name":name,"clazzId":clazzId,"cardCode":cardCodeArry.join(",")},
				error:function(){layer.close(indexlayer);},
				success:function(data){
					layer.close(indexlayer);
					if(data==true){
						layer.msg("保存学生信息成功",{time:2000,icon:1});
					}else{
						layer.msg("保存学生信息失败",{time:2000,icon:2});
					}
				}
			});
		}
	}
	
	 //更新家长1信息
	function updateAddParent1(){
		var isUpdateParent1Flag = false;
		var studentId=$("#studentId").val();
	    var phone=$.trim($("#phone1").val());
	    var oldPhone=$.trim($("#originalparent1BindPhone").val());
	    var name=$.trim($("#parentname1").val());
		var password=$.trim($("#passWord1").val());
		var parentId=$.trim($("#parentId1").val());
		var parent1Phone=$.trim($("#parent1Phone").val());

		//家长1id是否存在
		if(parentId == ""){
			isUpdateParent1Flag = true;
		}

		//家长1绑定手机号码
		if(phone != oldPhone){
			isUpdateParent1Flag = true;
		}

		//家长接收短信手机号
		var orignialparent1RecivePhone = $("#orignialparent1RecivePhone").val();
		if(parent1Phone != orignialparent1RecivePhone){
			isUpdateParent1Flag = true;
		}
			
		//家长1姓名
		var orignialparent1name = $("#orignialparent1name").val();
		if(name != orignialparent1name){
			isUpdateParent1Flag = true;
		}

		//家长1登录密码
		if(password != ""){
			isUpdateParent1Flag = true;
		}
		
		var parentCardCodeArray=[];
		//电子卡
		$("#parentCardDiv1").find("input[name='cardCode']").each(function(){
			if($.trim($(this).val())!=""){
				var cardCode=$.trim($(this).val());
				parentCardCodeArray.push(cardCode);
			}
		});

		var parentForwardPhoneArray=[];
		//电子卡
		$("#parent1PhoneDiv").find("input[name='parentForwardPhone']").each(function(){
			if($.trim($(this).val())!=""){
				var forwardPhone=$.trim($(this).val());
				parentForwardPhoneArray.push(forwardPhone);
			}
		});
		
		var isModifyCardCodeFlag = isModifyCardCode(originalparent1CardCodeArray,parentCardCodeArray);
		if(isModifyCardCodeFlag){
			isUpdateParent1Flag = true;
		}

		var parentForwardPhoneArray=[];
		//分发号码
		$(".parent1PhoneDiv").find("input[name='parentForwardPhone']").each(function(){
			if($.trim($(this).val())!=""){
				var forwardPhone=$.trim($(this).val());
				parentForwardPhoneArray.push(forwardPhone);
			}
		});

		var isModifyForwardPhoneFlag = isModifyForwardPhone(originalparent1ForwrdPhoneArray,parentForwardPhoneArray);
		if(isModifyForwardPhoneFlag){
			isUpdateParent1Flag = true;
		}

		if(isUpdateParent1Flag){
				var url="";
				var data=null;
				if(parentId!=""){//修改
					url="<%=basePath%>student/doModifyParent.do";
					data={"parentPhone":parent1Phone,"studentId":studentId,"parentId":parentId,"parentname":name,"phone":phone,"oldPhone":oldPhone,"passWord":password,"cardCode":parentCardCodeArray.join(","),"parentForwardPhone":parentForwardPhoneArray.join(",")}; 
				}else{//添加
					url="<%=basePath%>student/addParent.do";
					data={"parentPhone":parent1Phone,"studentId":studentId,"parentname":name,"phone":phone,"passWord":password,"oldPhone":oldPhone,"cardCode":parentCardCodeArray.join(","),"parentForwardPhone":parentForwardPhoneArray.join(",")};
				}
				if(phone != "" && name != ""){
					submitAjax(url,data);
				}
		 }
	} 
	 //更新家长2信息
	function updateAddParent2(){
		
		var isUpdateParent2Flag = false;
	    var studentId=$("#studentId").val();
	    var phone=$.trim($("#phone2").val());
	    var oldPhone=$.trim($("#originalparent2BindPhone").val());
	    var name=$.trim($("#parentname2").val());
		var password=$.trim($("#passWord2").val());
		var parentId=$.trim($("#parentId2").val());
		var parent2Phone=$.trim($("#parent2Phone").val());
		//家长1id是否存在
		if(parentId == ""){
			isUpdateParent2Flag = true;
		}

		//家长1绑定手机号码
		if(phone != oldPhone){
			isUpdateParent2Flag = true;
		}

		//家长接收短信手机号
		var orignialparent2RecivePhone = $("#orignialparent2RecivePhone").val();
		if(parent2Phone != orignialparent2RecivePhone){
			isUpdateParent2Flag = true;
		}
			
		//家长1姓名
		var orignialparent2name = $("#orignialparent2name").val();
		if(name != orignialparent2name){
			isUpdateParent2Flag = true;
		}

		//家长1登录密码
		if(password != ""){
			isUpdateParent2Flag = true;
		}
		
		var parentCardCodeArray=[];
		//电子卡
		$("#parentCardDiv2").find("input[name='cardCode']").each(function(){
			if($.trim($(this).val())!=""){
				var cardCode=$.trim($(this).val());
				parentCardCodeArray.push(cardCode);
			}
		});
		var isModifyCardCodeFlag = isModifyCardCode(originalparent2CardCodeArray,parentCardCodeArray);
		if(isModifyCardCodeFlag){
			isUpdateParent2Flag = true;
		}
		
		var parentForwardPhoneArray=[];
		//分发手机号码
		$(".parent2PhoneDiv").find("input[name='parentForwardPhone']").each(function(){
			if($.trim($(this).val())!=""){
				var forwardPhone=$.trim($(this).val());
				parentForwardPhoneArray.push(forwardPhone);
			}
		});

		var isModifyForwardPhoneFlag = isModifyForwardPhone(originalparent2ForwrdPhoneArray,parentForwardPhoneArray);
		if(isModifyForwardPhoneFlag){
			isUpdateParent2Flag = true;
		}
		if(isUpdateParent2Flag){
			var url="";
			var data=null;
			if(parentId != ""){//修改
				url="<%=basePath%>student/doModifyParent.do";
				data={"parentPhone":parent2Phone,"studentId":studentId,"parentId":parentId,"parentname":name,"phone":phone,"oldPhone":oldPhone,"passWord":password,"cardCode":parentCardCodeArray.join(","),"parentForwardPhone":parentForwardPhoneArray.join(",")}; 
			}else{//添加
				url="<%=basePath%>student/addParent.do";
				data={"parentPhone":parent2Phone,"studentId":studentId,"parentname":name,"phone":phone,"passWord":password,"oldPhone":oldPhone,"cardCode":parentCardCodeArray.join(","),"parentForwardPhone":parentForwardPhoneArray.join(",")};
			}
			if(phone != "" && name != ""){
				submitAjax(url,data);
			}
		}
	}
	 function submitAjax(url,data){
		 var indexlayer = layer.msg('正在保存家长信息,请稍候。。。',{icon: 16,time:0,shade:0.3});
		  $.ajax({
			url:url,
			type:"post",
			dataType:"json",
			data:data,
			async:false,
			error:function(){layer.close(indexlayer);},
			success:function(data){
				if(data=="1"){
					layer.msg("修改成功",{time:2000,icon:1});
				}else{
					layer.msg("修改失败",{time:2000,icon:2});
					layer.close(indexlayer);
				}
			}
		}); 
	 }

	 //删除家长
	function deleteParent(tag){
		 var userId="";
		 var parenId1=$.trim($("#parentId1").val());
		 var parenId2=$.trim($("#parentId2").val());
		 var studentUserId=$.trim($("#studentId").val());
		 if(tag==1){
			 userId=parenId1;
		 }else{
			 userId=parenId2;
		 }
		 if(userId==""){
			 layer.msg("数据没保存或没有数据",{time:2000});
			 return;
		 }else if(tag==1 && parenId2==""){
			 layer.msg("最少保留一个家长",{time:2000});
			 return;
		 }else if(tag==2 && parenId1==""){
			 layer.msg("最少保留一个家长",{time:2000});
			 return;
		 }
		 var ll=layer.confirm('确定要删除？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				var indexlayer = layer.msg('正在删除家长'+tag+'信息,请稍候。。。',{icon: 16,time:0,shade:0.3}); 
				$.ajax({
					type: "post",
					url: "<%=basePath%>student/delUser.do",
					dataType:"json",
					data:{
						userId : userId,
						studentUserId:studentUserId
					},
					success: function(data){
						if (data== "0"){
							layer.msg("删除家长"+tag+"信息成功",{time:2000,icon:1});
							return_page();	
						}else{
							layer.msg("删除家长"+tag+"信息失败",{time:2000,icon:2});
						}
						layer.close(indexlayer);
					}
				}); 
			}, function(){
			}); 
	}
	
	//加载电子卡列表,用于修改
	function loadStudentCardListForModify()
	{
		var studentId = $("#studentId").val();
		$.ajax({
			type: "post",
			url: "<%=basePath%>student/loadStudentCardListForModify.do",
			data:{
				"studentId":studentId
			},
			dataType:"json",
			success: function(cardList)
			{
				var appendHtml = '';
				//如果没有电子卡					
				if (cardList.length == 0)
				{
					appendHtml +='<div class="form-group" id="xxxx">';
					appendHtml +='<label class="control-label col-md-4 col-lg-4" for="inputSuccess">电子卡号：</label>';
					appendHtml +='<div class="col-md-6 col-lg-6">';
					appendHtml +='<input type="text" size="16" name="cardCode" id="cardCode" class="form-control"/>';
					appendHtml +='<input type="hidden"  value="" name="originalstudentCardCode"/>';
					appendHtml +='</div>';
					appendHtml +='<div class="col-md-1 col-lg-1">';
					appendHtml +='<a class="btn mini green" onclick="appendCardAdd()"><i class="fa fa-plus"></i></a>';
					appendHtml +='</div>';
					appendHtml +='</div>';
				}else{
					for(var i=0;i<cardList.length;i++){
						var value=cardList[i];
						if(i==0){
							appendHtml+='<div class="form-group" id="xxxx">';	
						}else{
							appendHtml+='<div class="form-group">';
						}
						appendHtml +='<label class="control-label col-md-3" for="inputSuccess">电子卡号：</label>';
						appendHtml +='<div class="col-md-7">';
						appendHtml +='<input type="text" size="16" name="cardCode"  value="' + value.cardCode + '" class="form-control"/>';
						appendHtml +='<input type="hidden"  value="' + value.cardCode + '" name="originalstudentCardCode" />';
						appendHtml +='</div>';
						if(i==0){
							appendHtml +='<div class="col-md-1">';
							appendHtml +='<a class="btn mini green" onclick="appendCardAdd()"><i class="fa fa-plus"></i></a>';
							appendHtml +='</div>';
						}else{
							appendHtml +='<div class="col-md-1">';
							appendHtml +='<a class="btn mini red" onclick="removeCardAdd($(this));"><i class="fa fa-minus"></i></a>';
							appendHtml +='</div>';	
						}
						appendHtml +='</div>';
						originalstudentCardCodeArray.push(value.cardCode);
					}
				}
				$("#studentCardDiv").html(appendHtml);
			}
		});
	}
	
	//加载家长电子卡列表,用于修改
	function loadParentCardListForModify(tag,id)
	{
		var parentId ="";
		if(tag==1){
			parentId=$("#parentId1").val();
		}else{
			parentId=$("#parentId2").val();	
		}
		$.ajax({
			type: "post",
			url: "<%=basePath%>student/loadStudentCardListForModify.do",
			data:{
				studentId : parentId
			},
			success: function(data)
			{
				var cardList = $.parseJSON(data);
				var appendHtml = '';
				//如果没有电子卡					
				if (cardList==null || cardList.length == 0)
				{
					if(tag==1){
					appendHtml +='<div class="form-group" id="parent1">';
					}else{
					appendHtml +='<div class="form-group" id="parent2">';
					}
					appendHtml +='<label class="control-label col-md-4 col-lg-4">电子卡号</label>';
					appendHtml +='<div class="col-md-6 col-lg-6">';
					appendHtml +='<input type="text" name="cardCode" id="cardCode" class="form-control"/>';
					appendHtml +='<input type="hidden"  value="" name="originalparentCardCode"/>';
					appendHtml +='</div>';
					appendHtml +='<div class="col-md-1 col-lg-1">';
					if(tag==1){
						appendHtml +='<a class="btn mini green" onclick="parentAppendCardAdd(1)"><i class="fa fa-plus"></i></a>';
					}else{
						appendHtml +='<a class="btn mini green" onclick="parentAppendCardAdd(2)"><i class="fa fa-plus"></i></a>';
					}
					appendHtml +='</div>';
					appendHtml +='</div>';
				}
				//遍历电子卡
				$.each(cardList, function(n, value){
					if (n==0)//第一个
					{
						if(tag==1){
						appendHtml +='<div class="form-group" id="parent1">';
							}else{
						appendHtml +='<div class="form-group" id="parent2">';
						}
						appendHtml +='<label class="control-label col-md-4 col-lg-4" for="inputSuccess">电子卡号</label>';
						appendHtml +='<div class="col-md-6 col-lg-6">';
						appendHtml += '<input type="text" name="cardCode" id="cardCode" class="form-control" value="' + value.cardCode + '"/>';
						appendHtml += '<input type="hidden"  value="' + value.cardCode + '" name="originalparentCardCode"/>';
						appendHtml +='</div>';
						appendHtml +='<div class="col-md-1 col-lg-1">';
						if(tag==1){
							appendHtml +='<a class="btn mini green" onclick="parentAppendCardAdd(1)"><i class="fa fa-plus"></i></a>';
						}else{
							appendHtml +='<a class="btn mini green" onclick="parentAppendCardAdd(2)"><i class="fa fa-plus"></i></a>';
						}
						appendHtml +='</div>';
						appendHtml +='</div>';
					}						
					else
					{ 
						appendHtml +='<div class="form-group">';
						appendHtml +='<label class="control-label col-md-4 col-lg-4" for="inputSuccess"></label>';
						appendHtml +='<div class="col-md-6 col-lg-6">';
						appendHtml +='<input type="text" name="cardCode" id="cardCode" class="form-control" value="' + value.cardCode + '"/>';
						appendHtml += '<input type="hidden"  value="' + value.cardCode + '" name="originalparentCardCode"/>';
						appendHtml +='</div>';
						appendHtml +='<div class="col-md-1 col-lg-1"><a class="btn mini red" onclick="removeCardAdd($(this));"><i class="fa fa-minus"></i></a></div>';
						appendHtml +='</div>';
					}
					if(tag==1){
						originalparent1CardCodeArray.push(value.cardCode);
					}else{
						originalparent2CardCodeArray.push(value.cardCode);
					}
					
      			});
      			$("#"+id).html(appendHtml);
			},
		});
	}

	//加载家长电子卡列表,用于修改
	function loadParentForwardPhoneForModify(tag,id)
	{
		var parentId ="";
		if(tag==1){
			parentId=$("#parentId1").val();
		}else{
			parentId=$("#parentId2").val();	
		}
		$.ajax({
			type: "post",
			url: "<%=basePath%>student/loadParentForwardPhoneForModify.do",
			data:{
				parentId : parentId
			},
			success: function(data)
			{
				var phoneList = $.parseJSON(data);
				var appendHtml = '';
				//如果没有电子卡					
				if (phoneList==null || phoneList.length == 0)
				{

				}else{
					//遍历电子卡
					$.each(phoneList, function(n, value){
						if(value != ""){
							appendHtml ='<div class="form-group">';
							appendHtml +='<label class="control-label col-md-3 col-lg-3"></label>';
							appendHtml +='<div class="col-md-7 col-lg-7">';
							appendHtml +='<input type="text" name="parentForwardPhone" value="'+value+'" class="form-control"/>';
							appendHtml +='</div>';
							appendHtml +='<div class="col-md-2 col-lg-2">';
							appendHtml +='<a class="btn mini red" onclick="parentRemovePhone($(this));"><i class="fa fa-minus"></i></a>';
							appendHtml +='</div>';
							appendHtml +='</div>';
							
							if(tag==1){
								originalparent1ForwrdPhoneArray.push(value);
							}else{
								originalparent2ForwrdPhoneArray.push(value);
							}
						}
	      			});
				}
      			$("."+id).append(appendHtml);
			},
		});
	}
	

	//加载班级信息
	function loadAllClazzList()
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>baseData/loadClazzList.do",
			data:{
				permissionCode : "studentParentModify"
			},
			success: function(data){
				var clazzList = $.parseJSON(data);

				//年级select页面html
				var clazzSelectHtml = '<option value="0">--请选择--</option>';
				
				$.each(clazzList, function(n, value){  
					clazzSelectHtml += '<option value="' + value.id + '">' +value.clazzName + '</option>';
      			});
				 $("#clazzSelect").html(clazzSelectHtml);
     			var clazzId = $("#orignialclazzId").val();
     			if (typeof(clazzId) == "undefined" || clazzId == "undefined")
			    {
				    $("#clazzSelect").val("0");
			    }
			    else
			    {
				   $("#clazzSelect").val(clazzId);
			    }
			}
		});
	}

	
	//判断卡号是否有修改 true:有修改  false:没有修改
	function isModifyCardCode(orignialcardCodeArray,cardCodeArray){
		var flag = false;
		var orignialLength = orignialcardCodeArray.length;
		var nowLength = cardCodeArray.length;
		if(nowLength != orignialLength){
				flag = true;
		}else{
			if(nowLength == orignialLength && nowLength == 0){
				flag = false;
			}else if(nowLength == orignialLength && nowLength != 0){
				for(var o in orignialcardCodeArray){
					var originalcardCode = orignialcardCodeArray[o];
					for(var n in cardCodeArray){
						var cardCode = cardCodeArray[n];
						if(originalcardCode != cardCode){
							flag = true;
							return flag;
						}
					}
				}
			}
		}
		return flag;
	}

	//判断卡号是否有修改 true:有修改  false:没有修改
	function isModifyForwardPhone(orignialForwardPhoneArray,forwardPhoneArray){
		var flag = false;
		var orignialLength = orignialForwardPhoneArray.length;
		var nowLength = forwardPhoneArray.length;
		if(nowLength != orignialLength){
				flag = true;
		}else{
			if(nowLength == orignialLength && nowLength == 0){
				flag = false;
			}else if(nowLength == orignialLength && nowLength != 0){
				for(var o in orignialForwardPhoneArray){
					var originalForwardPhone = orignialForwardPhoneArray[o];
					for(var n in forwardPhoneArray){
						var forwardPhone = forwardPhoneArray[n];
						if(originalForwardPhone != forwardPhone){
							flag = true;
							return flag;
						}
					}
				}
			}
		}
		return flag;
	}
	
	//学生添加新增卡号输入框
	function appendCardAdd(obj)
	{
		var	appendHtml ='<div class="form-group">';
			appendHtml +='<label class="control-label col-md-4 col-lg-4" for="inputSuccess"></label>';
			appendHtml +='<div class="col-md-6 col-lg-6">';
			appendHtml +='<input type="text" name="cardCode" id="cardCode" class="form-control"/>';
			appendHtml +='<input type="hidden"  value="" name="originalCardCode"/>';
			appendHtml +='</div>';
			appendHtml +='<div class="col-md-1 col-lg-1">';
			appendHtml +='<a class="btn mini red" onclick="removeCardAdd($(this));"><i class="fa fa-minus"></i></a>';
			appendHtml +='</div>';
			appendHtml +='</div>';
		$("#xxxx").parent().append(appendHtml);
	}
	//家长添加新增卡号输入框
   function parentAppendCardAdd(tag){
    	var	appendHtml ='<div class="form-group">';
			appendHtml +='<label class="control-label col-md-4 col-lg-4" for="inputSuccess"></label>';
			appendHtml +='<div class="col-md-6 col-lg-6">';
			appendHtml +='<input type="text" size="16" name="cardCode" id="cardCode" class="form-control"/>&nbsp;';
			appendHtml +='<input type="hidden"  value="" name="originalCardCode"/>';
			appendHtml +='</div>';
			appendHtml +='<div class="col-md-1 col-lg-1">';
			appendHtml +='<a class="btn mini red" onclick="removeCardAdd($(this));"><i class="fa fa-minus"></i></a>';
			appendHtml +='</div>';
			appendHtml +='</div>';
		
		$("#parent"+tag).parent().append(appendHtml);
    }
	//关联手机号码
	function appendPhoneAdd(obj)
	{	
		var	appendHtml ='<div class="form-group">';
			appendHtml +='<label class="control-label col-md-3 col-lg-3">转发手机号</label>';
			appendHtml +='<div class="col-md-7 col-lg-7">';
			appendHtml +='<input type="text" name="parentForwardPhone"  class="form-control"/>';
			appendHtml +='</div>';
			appendHtml +='<div class="col-md-2 col-lg-2">';
			appendHtml +='<a class="btn mini red" onclick="parentRemovePhone($(this));"><i class="fa fa-minus"></i></a>';
			appendHtml +='</div>';
			appendHtml +='</div>';
			$(obj).parent().parent().parent().append(appendHtml);
	} 
	//删除新增卡号输入框		
	function removeCardAdd(obj)
	{
	 obj.parent().parent().remove();
	}

	//删除接受短信的手机号码
	function parentRemovePhone(obj)
	{
		obj.parent().parent().remove();
	}
	//返回上一级页面
	function return_page(){
		var clazzId=$("#clazzSelect").val();
		var queryContent=$("#queryContent").val();
		standardPost('<%=basePath%>student/toStudentList.do',{clazzId:clazzId,"queryContent":queryContent});
	}

	//确认是否是该家长接收短信
	function confirmSendSms(type){
		var content = '';
		var studentId = $("#studentId").val();
		var parentId = '';
		if(type == 'chk1'){
			//家长1
			var chk1Flag = $("input[name='chk1']").parent().hasClass('on');
			if(!chk1Flag){
				content='确定将家长一设为接收短信?';
			}else{
				content='确定将家长一取消接收短信?';
			}
			parentId = $("#parentId1").val();
		}else if(type == 'chk2'){
			//家长2
			var chk2Flag = $("input[name='chk2']").parent().hasClass('on');
			if(!chk2Flag){
				content='确定将家长二设为接收短信?';
			}else{
				content='确定将家长二取消接收短信?';
			}
			parentId = $("#parentId2").val();
		}
		
		var l_=layer.confirm(content, {
		  btn: ['确定','取消'] //按钮
		}, function(){
			 $.ajax({
		           type:"post",
		           url: "<%=basePath%>student/confirmSendSms.do",
				   data:{
					   studentId:studentId,
					   parentId:parentId
					},
		           error:function(){ 
			           layer.close(l_);
			       },
		           success:function(data){
		        	   var reslult = eval("(" + data + ")");
						if(reslult)
						{
			        	  	//清空成功  
							layer.msg('设置成功',{icon:1,time:1000});
							//删除样式
							if(type == 'chk1'){
								 if(chk1Flag){
								  $("input[name='chk1']").removeAttr("checked");
								  $("input[name='chk1']").parent().removeClass("on");
								 }
							}else if(type == 'chk2'){
								if(chk2Flag){
									  $("input[name='chk2']").removeAttr("checked");
									  $("input[name='chk2']").parent().removeClass("on");
								}
							}
						}else{
							layer.msg('设置失败，请稍后重试',{icon:2,time:1000});
							location.reload();
						}
						layer.close(l_);
		           }
		    }); 
		}, function(){
		  //删除样式
		  if(type == 'chk1'){
			  if(!chk1Flag){
				  $("input[name='chk1']").removeAttr("checked");
				  $("input[name='chk1']").parent().removeClass("on");
			  }
		  }else if(type == 'chk2'){
				if(!chk2Flag){
					  $("input[name='chk2']").removeAttr("checked");
					  $("input[name='chk2']").parent().removeClass("on");
				}
		  }
		  layer.close(l_);
		});
	}
</script>
</html>