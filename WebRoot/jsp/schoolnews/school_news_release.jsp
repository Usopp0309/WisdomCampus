<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>校园新闻发布</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
		<link href="<%=basePath%>assets/global/css/news_m.css" rel="stylesheet" type="text/css"/>
	 	<!--公共css结束--> 
	 	 <link href="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
	 	 
	 	 <style type="text/css">
 	 		.select2-container{ 
		 		float: left; 
			 	width: 100% !important; 
 		 	} 
	 	</style>
        </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body_">
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
                            <li><a href="">校园新闻</a><i class="fa fa-circle"></i></li>
                            <li><span>校园新闻发布</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" >
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">添加新闻</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form action="<%=basePath%>schoolNewsRelease/addSchoolNewsRelease.do" class="form-horizontal" method="post" id="addForm">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">发布类型:</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <select class="form-control" id="newsType" name="newsType">
														<c:if test="${roleCode == 'admin' }">
															<option value="1">校园新闻</option>
															<option value="2">学校活动</option>
															<option value="3">学校招生信息</option>
															<option value="4">家长课堂</option>
															<option value="5">班级每日活动</option>
														</c:if>
														<c:if test="${roleCode == 'classLeader' }">
															<option value="5">班级每日活动</option>
														</c:if>
												    </select>
													<input type="hidden" id="roleCode" value = "${roleCode}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">标题</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text" name="newsTitle" id="newsTitle" class="form-control" />
													<span class="help-block" style="display: none;" id="nameHelp"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">作者</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input type="text"  name="newsAuthor" id="newsAuthor" class="form-control" />
													<span class="help-block" style="display: none;" id="nameHelp"></span>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="control-label col-md-3">正文</label>
                                                <div class="col-md-9 col-lg-6">
                                                    <script id="editor" type="text/plain"></script>
													<textarea  name="newsContent" id="newsContent" style="visibility:hidden;display:none"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">封面</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <p><a href="#static" data-toggle="modal"><button type="button" class="btn" >本地上传</button></a></p>
													<img  class="school_news_cover">
													<p><span style="color: grey;">大图片建议尺寸：900*500</span></p>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group" id="f_">
                                                <label class="control-label col-md-3">封面预览</label>
                                                <div class="col-md-7" id="imgFile_" style="height: 250px;width: 250px;">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">摘要</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <textarea rows="5" cols="40" class="form-control" name="newsDigest" id="newsDigest"></textarea>
													<span class="help-inline"> (剩余<b id="word">50</b> 个字)</span>
                                                </div>
                                            </div>
                                            <div class="form-group" id="phoneGroup" style="display: none;margin-left:215px;">
												<div class="controls">
													 <label class="control-label col-md-3">
													<!--  <i class="icon-ok" id="consult"></i> -->
													<input value="0" checked="false" type="checkbox" id="consult" onclick="chooseApply(1,this);" >
													 <b>添加我要咨询功能</b></label>
													 <div class="col-md-9 col-lg-4"  style="display:none;clear: both;margin-left:190px;" id="consult_">
															<label class="control-label"> 咨询号码： </label>
															<input type="text" name="name" id="phone" class="form-control" />
															<input type="hidden" id="phoneFunc" value=""/>
													</div>
												</div>
											</div>
											<div class="form-group" id="applyGroup" style="display: none;margin-left:215px;">
													<label class="control-label col-md-3">
													<!-- <i class="icon-ok" id="apply"></i> -->
													<input value="0" checked="false" type="checkbox" id="apply_" onclick="chooseApply(2,this);" >
													<b>添加我要报名功能</b></label>
													<div class="col-md-9 col-lg-4" style="display:none;clear: both;margin-left:190px;" id="apply_1">
														<a href="<%=basePath %>schoolNewsLook/applyInfoForward.do" target="_block">查看招生报名页(模板)</a>
														<input type="hidden" id="applyFunc" value=""/>
													</div>
											</div>
											<div class="form-group"  id="takePartInGroup" style="display: none;margin-left:215px;">
													<label class="control-label col-md-3">
													<!-- <i class="icon-ok" id="apply"></i> -->
													<input value="0" checked="false" type="checkbox" id="applyc" onclick="chooseApply(0,this);" >
													<b>添加我要参加功能</b></label>
													<div class="col-md-9 col-lg-4 show_input" style="display:none;clear: both;margin-left:190px;" id="apply1">
														<a href="<%=basePath %>schoolNewsLook/toTakePartInActivity.do" target="_block">查看我要参加页(模板)</a>
														<input type="hidden" id="applyFunc" value=""/>
													</div>
											</div>
											<div class="form-group"  id="takePartInGroup" style="display: none">
													<label class="control-label col-md-3"><i class="icon-ok" id="apply"></i><b>添加我要参加功能</b></label>
													<div class="col-md-9 col-lg-4 show_input" style="display:none">
														<a href="<%=basePath %>schoolNewsLook/toTakePartInActivity.do" target="_block">查看我要参加页(模板)</a>
														<input type="hidden" id="applyFunc" value=""/>
													</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3">发布范围:</label>
												<c:if test="${roleCode == 'admin' }">
													<div class="col-md-9 col-lg-4">
														<select  name="newsRanyeList" id="newsRanyeList" class="form-control select2me m_select"></select>
													</div>
												</c:if>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3"></label>
												<div class="col-md-9 col-lg-4" >
													<span style="color: grey;line-height:35px;">如果不选择则发给全校所有教职工和家长</span> 
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-3">发布对象:</label>
												<div class="col-md-4 col-lg-2">
													<select class="form-control sms_select " multiple="multiple"  id="toSelectObj">
													</select>
													<select class="form-control sms_select " multiple="multiple"  id="toSelectObj1" style="display:none">
													</select>
													</div>
													<div class="col-md-1 col-lg-1">
														<button type="button" class="btn default btn-block" id="add" style="display:block"><i class="fa fa-angle-right"></i></button>
														<button type="button" class="btn default btn-block" id="remove" style="display:block"><i class="fa fa-angle-left"></i></button>
	  													<button type="button" class="btn green btn-block" id="addAll" style="display:block"><i class="fa fa-angle-double-right"></i></button>
	  													<button type="button" class="btn green btn-block" id="removeAll" style="display:block"><i class="fa fa-angle-double-left"></i></button>
													</div>	
													<div class="col-md-4 col-lg-2">
													<select class="form-control sms_select " multiple="multiple" id="selectedObj" name="selectedObj"></select>
													</div>
												</div>
											</div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn green" onclick="beforeSaveInfo()">发布</button>
                                                    <button type="button" class="btn blue" onclick="lookDetail()">预览</button>
                                                    <button type="button" class="btn" id="cancel">返回</button>
                                                    <input type="hidden" id="userDetailId" value="">
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
        <script src="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
        <!-- 默认配置文件 -->
	    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.config.js" type="text/javascript" charset="utf-8" ></script>
	    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.all.js" type="text/javascript" charset="utf-8" > </script>
	    <!-- 语言文件 -->
	    <script src="<%=basePath%>assets/global/plugins/schoolnews/lang/zh-cn/zh-cn.js" type="text/javascript" charset="utf-8" ></script>
	    <!-- 如果需要页面渲染的话引入 -->
	    <script src="<%=basePath%>assets/global/plugins/schoolnews/ueditor.parse.min.js" type="text/javascript" charset="utf-8" ></script>
	    <script src="<%=basePath%>assets/global/plugins/album/scripts/ajaxfileupload.js" type="text/javascript" charset="utf-8" ></script>
	    <script src="<%=basePath%>assets/global/plugins/album/scripts/bootstrap-fileupload.js" type="text/javascript" charset="utf-8" ></script>
        <!-- 公共js结束 -->
        <div class="modal fade" id="static" tabindex="-1" role="dialog" aria-hidden="true">
        	<div class="modal-dialog modal-md">
	            <div class="modal-content">
	            	<div class="modal-header">
						<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>
						<h3>上传照片</h3>
					</div>
					<div class="modal-body">
						<form action="#" class="form-horizontal" >
							<div class="fileinput fileinput-new" data-provides="fileinput">
                                  <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                      <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt="" /> </div>
                                  <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
                                  <div>
                                      <span class="btn default btn-file">
                                          <span class="fileinput-new">选择图片</span>
                                          <span class="fileinput-exists">换一个</span>
                                          <input type="file" id="imgFile" name="file" onchange="changeImg(this);"> </span>
                                      <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                  </div>
                              </div>
							
						</form>
					</div>
					<div class="modal-footer">
					<button class="btn green"  type="button" onclick="saveImg()">提交</button>
					</div>
	            </div>
	        </div>
		</div>
    
	
    
	<script>
		$(function() { 
			$("#f_").hide();
			$("#newsType").val(1);
			$("#applyc").attr("checked",false);
			$("#consult").attr("checked",false);
			$("#apply_").attr("checked",false);
			loadSubMenu("campusNewsManager"); 
			//选取当前菜单位置
			setActive("campusNewsManager","schoolNewsRelease");    
			var ue = UE.getEditor('editor');
			loadNewsRanyeList();
			// 判断已经输入多少字 
			$("#newsDigest").keyup(check);
			 //摘要字数限制
			$("#newsDigest").blur(function(){
			   var editSms_v=trim($(this).val());
			   var len = editSms_v.length;
			   if(len > 51)
			   {
			    	$(this).val($(this).val().substring(0,51));
			   }
			   if(51 - len>0)
			   {
			       var num = 51 - len;
			   }else{
				   num=0;
			   }
			   $("#word").text(num);
			 }); 
			 //摘要字数限制
			$("#newsDigest").keydown(function(){
			   var editSms_v=trim($(this).val());
			   var len = editSms_v.length;
			   if(len > 51)
			   {
			    	$(this).val($(this).val().substring(0,51));
			   }
			   if(51 - len>0)
			   {
			       var num = 51 - len;
			   }else{
				   num=0;
			   }
			   $("#word").text(num);
			 }); 
			$('#newsType').click(function(){
				if($(this).val()==3)
				{
					$("#phoneGroup").show();
					$("#applyGroup").show();
					$("#takePartInGroup").hide();
				}else if($(this).val()==2)//学校活动
				{
					$("#takePartInGroup").show();
					$("#phoneGroup").hide();
					$("#applyGroup").hide();
				}else
				{
					$("#phoneGroup").hide();
					$("#applyGroup").hide();
					$("#takePartInGroup").hide();
				}
				
        	});  

			$(".icon-ok").on("click",function(){
				if($(this).hasClass("focus")){
					$(this).removeClass("focus");
					$(this).parent().siblings(".show_input").css({"display":"none"});
					if( $(this).parent().find("b").text()=="添加我要报名功能" || $(this).parent().find("b").text()=="添加我要参加功能")
					{
						$("#applyFunc").val("");	
					}else
					{
						$("#phoneFunc").val("");
					}
				}else{
					$(this).addClass("focus")
					$(this).parent().siblings(".show_input").removeAttr("style");
					if( $(this).parent().find("b").text()=="添加我要报名功能" || $(this).parent().find("b").text()=="添加我要参加功能")
					{
						$("#applyFunc").val("true");	
					}else
					{
						$("#phoneFunc").val("true");
					}
				}
			})
			
			//全局数组存放已选中元素
			var selectValArr = new Array();
			
			//初始化选择部门，如果select改动则将发送对象改变
			$("#newsRanyeList").click(function(){
				//如果以G开头这查找对应的班级
				var ranyeStart = $(this).val().indexOf("G");
				//ranyeStart为0表示年级Id
				if (ranyeStart == 0)
				{
					var gradeId = $(this).val().replace("G","");
					$.ajax({
						type: "POST",
						url: "<%=basePath%>schoolNewsRelease/loadClazzList.do",
					 	processData:true,
					 	data:{
						 		gradeId : gradeId
						 	 },
					 	success: function(data){
					 		var clazzIdList = eval("(" + data + ")");
	
							var appendHtml = '';

							$.each(clazzIdList, function(n, value) {
								//新增，如果已选框有的话则不显示
								var val = "C" + value.id;
								//表明未选
								if (checkArray(selectValArr, val) == -1)
								{
									appendHtml += '<option value="C' + value.id + '">' + value.clazzName + '</option>';

								}
		           			}); 
	
		           			$("#toSelectObj").html(appendHtml);
		           			$("#toSelectObj1").html(appendHtml);
					 	}
					});
				}
				else
				{
					var appendHtml = $("#newsRanyeList").html();
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
		});
		function chooseApply(type,obj){
			if(type==0){//学校活动
				if($(obj).is(':checked')){
					$("#apply1").show();	
				}else{
					$("#apply1").hide();	
				}
			}else if(type==1){
				if($(obj).is(':checked')){
					$("#consult_").show();	
				}else{
					$("#consult_").hide();
					$("#phone").val("");
				}
			}else if(type==2){
				if($(obj).is(':checked')){
					$("#apply_1").show();	
				}else{
					$("#apply_1").hide();	
				}	
			}
			
		}
		function lookDetail(){
			var date=new Date();
			 var currentdate =getNowFormatDate();
			var html='';
			var newsTitle=$("#newsTitle").val();
			var con = UE.getEditor('editor').getContent();
			html+='<div class="control-group news_detail" style="margin-top:0px;">';
			html+='<div class="control-group">';
			html+='<h2 style="font-family:Open Sans, sans-serif;font-weight:300px;">'+newsTitle+'</h2>';
			html+='</div>';
			html+='<div class="control-group news_detail_info" id="nameGroup">';
			html+='	<span style="">'+currentdate+'</span>';
		    html+='</div>';
			html+='<div class="control-group " id="nameGroup">';
			html+=con;
			html+='	</div>';
			html+='</div>';
			   layer.open({
				  type:1,
				  title: false,
				  shadeClose: true,
				  shade: 0.8,
				  area: ['70%', '90%'],
				  content: html
				}); 
		}
        function beforeSaveInfo(){
				var newsTitle=$("#newsTitle").val();
				if(newsTitle=="")
				{
					layer.tips('新闻标题不能为空！', '#newsTitle');
					return;
				}
				if($("#newsType").val()==3 && $("#phoneFunc").val()=="true" && $("#phone").val()=="")
				{
					layer.tips('咨询不能为空！', '#phone');
					return;
				}
				
				var con = UE.getEditor('editor').getContent();
				if(con=="")
				{
					layer.tips('新闻内容不能为空！', '#editor');
					return;
				}
				 var l_=layer.confirm('确定要发布！', {
					  btn: ['确定','取消'] //按钮
					}, function(){
						layer.close(l_);
						saveInfo(); 
					}, function(){
					  layer.close(l_);
					});
				
        }

		function saveInfo(){
			var d_ = layer.msg('正发布,请稍候。。。',{icon: 16,time:0,shade:0.3});
			var newsType=$("#newsType").val();
			var newsTitle=$("#newsTitle").val().replace(/\"/g, "&quot;");
			var newsAuthor = $("#newsAuthor").val();
			var newsDigest = $("#newsDigest").val().replace(/\"/g, "&quot;");
			if(newsDigest=="")
			{
				newsDigest = UE.getEditor('editor').getContentTxt().substring(0,54);
			}
			var phone = $("#phone").val();
			
			var selectedValues = [];    
			$("#selectedObj option").each(function(){
			    selectedValues.push($(this).val()); 
			});
			
			var applyFunc = $("#applyFunc").val();	
			var phoneFunc = $("#phoneFunc").val();
			
			$.ajaxFileUpload({
				url : '<%=basePath%>schoolNewsRelease/addSchoolNewsRelease.do',
				secureuri : false,
				fileElementId :[ 'imgFile'],
				data:{
					newsType : newsType,
					newsTitle : newsTitle,
					newsAuthor : newsAuthor,
					newsContent : UE.getEditor('editor').getContent().replace(/\"/g, "&quot;"),
					newsDigest : newsDigest,
					phone : phone,
					newsRanye : selectedValues,
					applyFunc : applyFunc,
					phoneFunc : phoneFunc
				},
				dataType : 'json',
				success : function(d, status) {
					layer.close(d_);
					var data = eval('(' + d + ')');
					if(data=="0")
					{
						layer.msg("发布成功！",{icon:1,time:1000});
						setTimeout(function(){
						window.location.href='<%=basePath%>schoolNewsRelease/toSchoolNewsRelease.do';
						},1000);
					}
				},
				error : function(data, status, e) {
					layer.close(d_);
					layer.msg(e);
				}

			}) 
		}

		function saveImg(){
			$(".school_news_cover").attr("src",$(".fileupload-preview > img").attr("src"));
			$(".school_news_cover").width('200px');
			$("#static").modal("hide");
		}
		function changeImg(file){
			$("#f_").show();
			if(file.value==""){
			$("#f_").hide();
			}
			var prevDiv = document.getElementById('imgFile_');
			if (file.files && file.files[0])
			{
			var reader = new FileReader();
			reader.onload = function(evt){
			prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
			}
			reader.readAsDataURL(file.files[0]);
			}
			else
			{
			prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
			}
			
		}
		//加载发布范围
		function loadNewsRanyeList()
		{
			var roleCode = $("#roleCode").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>schoolNewsRelease/loadGradeList.do",
				data:{
						roleCode : roleCode
					},
				success: function(data){
					if(roleCode == 'classLeader')
					{
						var list = eval("(" + data + ")");
						var appendHtml = '<option value="0">---请选择发布范围---</option>';
						
						$.each(list, function(n, value) {
	           				appendHtml += '<option value="C' + value.id + '">' + value.clazzName + '</option>';
	           			}); 
	           			$("#newsRanyeList").html(appendHtml);

	           			//初始化带选框
	           			var appendHtml = $("#newsRanyeList").html();
						$("#toSelectObj").html(appendHtml);
						$("#toSelectObj option[value='0']").remove();
						$("#toSelectObj1").html(appendHtml);
						$("#toSelectObj1 option[value='0']").remove();
					}
					else
					{
						var gradeList = eval("(" + data + ")");
						var appendHtml = '<option value="0">---请选择发布范围---</option>';
						appendHtml += '<option value="T0">全体教职工</option>';
						appendHtml += '<option value="P0">全体家长</option>';
						
						$.each(gradeList, function(n, value) {
	           				appendHtml += '<option value="G' + value.id + '">' + value.name + '</option>';
	           			}); 
						var newsRanye= $("#newsRanyeList").val();
						if(newsRanye==null || newsRanye==''){
							newsRanye="---请选择发布范围---";
						}
		          		$("#select2-newsRanyeList-container").attr("title",newsRanye);
		          		$("#select2-newsRanyeList-container").text(newsRanye)
	           			$("#newsRanyeList").html(appendHtml);

	           			//初始化带选框
	           			var appendHtml = $("#newsRanyeList").html();
						$("#toSelectObj").html(appendHtml);
						$("#toSelectObj option[value='0']").remove();
						$("#toSelectObj1").html(appendHtml);
						$("#toSelectObj1 option[value='0']").remove();
					}
					
				},
			});
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

		//用于检查文本域中已经输入字数
        function check() {
            var str = $("#newsDigest").val();
            var len = strlen(str);
            var info = len;
            info = info + "";
            if (info.indexOf('.') > 0){
                info = info.substring(0, info.indexOf('.'));
			}
        }

        function strlen(str) {
            var str = trim(str);
            var len = 0;
            for (var i = 0; i < str.length; i++) {
                len += str.charCodeAt(i) > 0 && str.charCodeAt(i) < 255 ? 0.5 : 1;
            }
            return len;
        }
        function trim(str) {
            return (str + '').replace(/(\s+)$/g, '').replace(/^\s+/g, '');
        }
	</script>
</html>