<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>补办卡申请</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
	 	<link href="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
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
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="">系统管理</a><i class="fa fa-circle"></i></li>
                            <li><span>补办卡申请</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">补办卡申请</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="<%=basePath %>cardApply/doAddCardApply.do" class="form-horizontal" method="post" id="submitForm" enctype="multipart/form-data">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">卡类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input name="cardType" type="text" class="form-control" id="cardType" value="" placeholder="请输入卡类型 如IC卡、RFID卡"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">数量：</label>
                                                <div class="col-md-9 col-lg-4">
                                                   <input name="sumNumber" type="text"  class="form-control" id="sumNumber" value="" placeholder="请输入申请数量"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">申请类型：</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="radio" name="type" value="办卡" style="margin-left:0px;"  checked="checked" onclick="changeType(0)"/>   办卡
													<input type="radio" name="type" value="补卡" style="margin-left:10px;"  onclick="changeType(1)"/>   补卡
													<input type="hidden" name="remark" id="remark" />
                                            	</div>
                                            </div>
                                            <div class="form-group" id="newCard">
                                                <label class="control-label col-md-3">补卡名单</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <div class="input-icon right">
                                                    	<div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file" id="wenjian">
                                                                <span class="fileinput-new">选择文件</span>
                                                                <span class="fileinput-exists">重选</span>
                                                                <input type="file" name="newCardPath"></span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                                        </div>
                                                       	<p><a href="<%= basePath %>/templet/办卡模板.rar"><label style="display:inline-block;margin-bottom:0px;line-height:30px;">办卡模板下载：</label><img style="width:24px; height:24px" title="下载模板" alt="" src="<%=basePath%>assets/global/img/m_img/cardTemplate.png"> 点击下载办卡模板</a></p>
                                                	</div>
	                                                </div>
	                                            </div>
                                            </div>
                                            <div id="repairCard" style="display:none">
	                                            <div class="form-group">
	                                                <label class="control-label col-md-3">选择班级</label>
	                                                <div class="col-md-9 col-lg-4">
	                                                    <select class="form-control" name="clazzList" id="clazzList">
														</select>
	                                                </div>
	                                            </div>
	                                            <div class="form-group">
	                                                <label class="control-label col-md-3">筛选条件</label>
	                                                <div class="col-md-9 col-lg-4">
	                                                    <input type="text" name="code" class="form-control" value="" id="search"  
								      			onkeyup="filter(this.value)" onchange="filter(this.value)" onpropertychange="filter(this.value)" oninput="filter(this.value)"/>
	                                                </div>
	                                            </div>
	                                            <div class="form-group">
	                                                <label class="control-label col-md-3">补卡名单</label>
	                                                <div class="col-md-4 col-lg-4">
													<select class="form-control sms_select" multiple="multiple" class="form-control sms_select" id="toSelectObj">
													</select>
													</div>
													<div class="col-md-1 col-lg-1">
														<button type="button" class="btn default btn-block" id="add" ><i class="fa fa-angle-right"></i></button>
   														<button type="button" class="btn default btn-block" id="remove" ><i class="fa fa-angle-left"></i></button>
   														<button type="button" class="btn green btn-block" id="addAll" ><i class="fa fa-angle-double-right"></i></button>
   														<button type="button" class="btn green btn-block" id="removeAll" ><i class="fa fa-angle-double-left"></i></button>
													</div>
													<div class="col-md-4 col-lg-4">
													<select class="form-control sms_select" multiple="multiple" id="selectedObj" name="selectedObj">
													</select>
													<select class="form-control sms_select" multiple="multiple" tabindex="1" id="toSelectObj1" style="float: left;display : none">
													</select>
	                                                </div>
	                                            </div>
                                            </div>
                                        </div>
	                                        <div class="form-actions">
	                                            <div class="row">
	                                                <div class="col-md-offset-3 col-md-9">
	                                                <input type="hidden" name="memberUserId" id="memberUserId"/>
														<c:if test="${sessionScope.user.type != 2}">
															<button class="btn green" id="submitButton" type="button" onclick="subForm()">确定</button>
														</c:if>
														<input type="hidden" value="${sessionScope.user.userId}" name="userId" id="userId" />
	                                                </div>
	                                            </div>
	                                        </div>
                                   		</div>
                                    </form>
                                </div>
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
        <script src="<%=basePath %>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
         <script src="<%=basePath%>assets/global/plugins/map.js" type="text/javascript" ></script>
	<script type="text/javascript">
	 var clazzUserMap=new Map();
	jQuery(document).ready(function() {   
		loadSubMenu("systemManage"); 
		//选取当前菜单位置
		setActive("systemManage","addCardApply"); 
		
		var userId = $("#userId").val();
		loadclazzList(userId, "studentMessageManager")
		
		//全局数组存放已选中元素
		var selectValArr = new Array();
		//初始化选择班级，如果select改动则将发送对象改为某个班级的所有学生的信息
		$("#clazzList").click(function(){
			//班级ID
			var clazzId = $(this).val().replace("C", "");
			//clazzId为0表示选择所有班级，不为0表示选择某个班级
			if (clazzId != 0)
			{
				var studentList =clazzUserMap.get(clazzId);//从数组中取
				var appendHtml = '';
				if(typeof(studentList)!="undefined" && studentList.length>0){
				$.each(studentList, function(n, value) {
					//新增，如果已选框有的话则不显示
					var val = "S" + value.userId;
					//表明未选
					if (checkArray(selectValArr, val) == -1)
					{
					appendHtml += '<option value="S' + value.userId + '">(学生)' + value.realName + '</option>';
					}
       			}); 
				}
       			$("#toSelectObj").html(appendHtml);
       			$("#toSelectObj1").html(appendHtml);
			}
			else
			{
				var appendHtml = $("#clazzList").html();

				$("#toSelectObj").html(appendHtml);
				$("#toSelectObj option[value='0']").remove();
				$("#toSelectObj1").html(appendHtml);
				$("#toSelectObj1 option[value='0']").remove();
			}
		});


		//将option从待发送对象移到发送对象的div中
		$("#toSelectObj").dblclick(function(){
        	var $options = $('#toSelectObj option:selected');//获取当前选中的项  
        	var $remove = $options.remove();//删除下拉列表中选中的项  
        	$remove.appendTo('#selectedObj');//追加给对方
        	
    		var i=0;
    		var length = $("#selectedObj option").length;
    		
    		while(i<length){
    			var j=i+1;
    			while(j<$("#selectedObj option").length){

    				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
        				$("#selectedObj option")[j].remove();
        				j++;   
    				}else{  
        				j++;   
    				}   
    			}  
    			i++;   
    		} 		
		});

		//将option从发送对象移到待发送对象的div中
		$("#selectedObj").dblclick(function(){
        	var $removeOptions = $('#selectedObj option:selected');  
        	$removeOptions.appendTo('#toSelectObj');//删除和追加可以用appendTo()直接
        	
    		var i=0;
    		var length = $("#toSelectObj option").length;
    		
    		while(i<length){
    			var j=i+1;
    			while(j<$("#toSelectObj option").length){

    				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
        				$("#toSelectObj option")[j].remove();    
        				j++;   
    				}else{  
        				j++;   
    				}   
    			}  
    			i++;   
    		}             	
		});


    	$('#add').click(function(){

        	var $options = $('#toSelectObj option:selected');//获取当前选中的项  
        	var $remove = $options.remove();//删除下拉列表中选中的项  
        	$remove.appendTo('#selectedObj');//追加给对方
        	
    		var i=0;
    		var length = $("#selectedObj option").length;
    		
    		while(i<length){
    			var j=i+1;
    			while(j<$("#selectedObj option").length){

    				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
        				$("#selectedObj option")[j].remove();   
        				j++;   
    				}else{  
        				j++;   
    				}   
    			}  
    			i++;   
    		} 				
			

    	});  
      
    	$('#remove').click(function(){  

        	var $removeOptions = $('#selectedObj option:selected');  
        	$removeOptions.appendTo('#toSelectObj');//删除和追加可以用appendTo()直接
        	
    		var i=0;
    		var length = $("#toSelectObj option").length;
    		
    		while(i<length){
    			var j=i+1;
    			while(j<$("#toSelectObj option").length){

    				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
        				$("#toSelectObj option")[j].remove();    
        				j++;   
    				}else{  
        				j++;   
    				}   
    			}  
    			i++;   
    		} 
    	}); 
      
    	$('#addAll').click(function(){  
        	var $options = $('#toSelectObj option');  
        	$options.appendTo('#selectedObj');  
        	$("#selectedObj option").attr("selected",true);
    		var i=0;
    		var length = $("#selectedObj option").length;
    		
    		while(i<length){
    			var j=i+1;
    			while(j<$("#selectedObj option").length){

    				if($("#selectedObj option")[i].value==$("#selectedObj option")[j].value){
        				$("#selectedObj option")[j].remove(); 
        				j++;   
    				}else{  
        				j++;   
    				}   
    			}  
    			i++;   
    		}	
        	
    	});  
      
    	$('#removeAll').click(function(){  
        	var $options = $('#selectedObj option');  
        	$options.appendTo('#toSelectObj'); 
        	
    		var i=0;
    		var length = $("#toSelectObj option").length;
    		
    		while(i<length){
    			var j=i+1;
    			while(j<$("#toSelectObj option").length){

    				if($("#toSelectObj option")[i].value==$("#toSelectObj option")[j].value){
        				$("#toSelectObj option")[j].remove();    
        				j++;   
    				}else{  
        				j++;   
    				}   
    			}  
    			i++;   
    		}          	 
    	});  
	
	})
	function changeType(obj){
		if (obj == 0){
			$("#newCard").show();
			$("#repairCard").hide();
		}else{
			
			$("#newCard").hide();
			$("#repairCard").show();
		}
	}
	
	function subForm(){
		var r = new RegExp("^\\d+(\\.\\d+)?$");
		var cardType=$.trim($("#cardType").val());
		var sumNumber=$.trim($("#sumNumber").val());
		if(cardType== ""){
			layer.tips("请输入卡类型！","#cardType")
			return false;
		}
		if(sumNumber==""){
			layer.tips("请输入申请卡数量！","#sumNumber")
			return false;	
		}else if(!r.test(sumNumber)){
			layer.tips("请输入正整数！","#sumNumber")
			return false;	
		}
		var remark = $('input[name="type"]:checked').val();
		$("#remark").val(remark);
		var memberUserIds="";
		if (remark == '补卡'){
			$("#selectedObj option").each(function(){
				memberUserIds = memberUserIds + $(this).attr("value") + ",";
			});
			if (memberUserIds.indexOf(",") != -1){
				memberUserIds = memberUserIds.substr(0, memberUserIds.length - 1);
				$("#memberUserId").val(memberUserIds);
			}else{
				layer.tips("请选择需要补卡的人员！","#selectedObj");
				return false;
			}
		}else{
			if ($("input[type='file']").val() == ""){
				layer.tips("请上传需要办卡的人员!","#wenjian");
				return false;
			}
			$("#remark").val("办卡");
		}
		submitForm.submit();
		
	}
	function filter(v){
        var $SerTxt = v.trim();
        //全局数据用于存放toSelectObj中的text
		var arryText = new Array();
        //全局数据用于存放toSelectObj中的val
		var arryVal = new Array();
 		$("#toSelectObj1").find("option").each(function(i, n) {
    		arryText[i] = $(this).text();
    		arryVal[i] = $(this).val();
		});
		
        if ($SerTxt != "" && $SerTxt != null) {
        	var appendHtml = '';
            for (var i = 0; i < arryText.length; i++) {
                if (arryText[i].toLowerCase().indexOf($SerTxt) >= 0) {
                	//添加到toSelectObject 中
                	appendHtml += '<option value="' + arryVal[i] + '">' + arryText[i] + '</option>';
                }
            }
            $("#toSelectObj").html(appendHtml);
        }else{
        	var appendHtml = '';
        	for (var i = 0; i < arryText.length; i++) {
        		appendHtml += '<option value="' + arryVal[i] + '">' + arryText[i] + '</option>';
            }
            $("#toSelectObj").html(appendHtml);
        }
	}

	//检查元素是否存在数组中
	//arr: 元素, e:数组
	function checkArray(arr, e)
	{
		for(var i = 0,j; j = arr[i]; i++)
		{
			if(j == e)
			{
				return i;
			}
		}
		return -1;	
	}
	
	//加载年级列表
	function loadclazzList(userId, permissionCode)
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>sms/getAllStudentList.do",
			data:{
					userId : userId,
					permissionCode : "studentMessageManager"
				},
				dataType:"json",
			success: function(data){
				var clazzList =data.clazzList;
				var appendHtml = '<option value="0">--选择所有班级--</option>';
				$.each(clazzList, function(n, value) {
					appendHtml += '<option value="C' + value.id + '">' + value.clazzName + '</option>';
       			});  
				$("#clazzList").html(appendHtml);
       			//初始化带选框
       			var appendHtml = $("#clazzList").html();
				$("#toSelectObj").html(appendHtml);
				$("#toSelectObj option[value='0']").remove();
				$("#toSelectObj1").html(appendHtml);
				$("#toSelectObj1 option[value='0']").remove();
				clazzUser(clazzList,data.studentList);
			},
		});
	}
	//将学生与班级的关系存入Map中，key:clazzId,value:对应学生数组
    function clazzUser(classId,studengList){
   	 for(var i=0;i<classId.length;i++){
   		 for(var k=0;k<studengList.length;k++){
       		 if(classId[i].id==studengList[k].clazzId){
       			 if(clazzUserMap.containsKey(classId[i].id)){
       				 var userarray=clazzUserMap.get(classId[i].id);
       				 userarray.push(studengList[k]);
       			 }else{
       				 var userarray=[];
       				 userarray.push(studengList[k]);
       				 clazzUserMap.put(classId[i].id,userarray);
       			 }
       			
       		 }
       	 }
   	 }
    }
	</script>
	</html>