<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>食谱展示</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
	<link href="<%=basePath%>assets/global/plugins/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css" />
 	<!--公共css结束--> 
 	<style type="text/css">
	.day{width:10%;text-align:center;}
	.day_recipes{width:22.5%;}
	table td .food{display:block;margin:0px 1%;text-align:center;height:90px;position: relative;width:31%;float:left}
	table td .food img{max-width:100%;margin:0px auto;height:65px;display:block;}
	table td .food .plus{width:40px!important;height:40px!important;margin:0px auto;}
	table td .food p{height:25px;width:100%;overflow: hidden;margin-top:-20px!important;text-align: center;}
	table td .food p span{max-width:70%;height:25px;line-height:25px;text-overflow: ellipsis;white-space: nowrap;display:inline-block;}
	table td .food p i{line-height:25px;text-align: center;margin:0 0 0 10px;font-size:14px;cursor: pointer;color:#ccc;display:inline-block;}
	table td .food .Actions{position: absolute;top:0px;right:0px;z-index: 7;width:50px;height:50px;display:none}
	table td .food .Actions .Actions_ul{margin:0px;border:1px solid #f2f2f2;background-color:#fff; overflow:hidden;}
	table td .food .Actions .Actions_ul dd{width:50px!important;height:25px; line-height:25px;border:none;margin:0px; text-align: center;}
	table td .food .Actions .Actions_ul dd a{ color:#999}
	table td .food .Actions .Actions_ul dd:hover{background-color:#f2f2f2}
	.food_detail{height:70px;}
	.food_detail span{height:70px;line-height:70px;display:inline-block;width:24.5%; text-align: center;float:left;}
	.food_detail .name{position: relative;}
	.food_detail .name em{position: absolute;top:0px;left:50%;}
	.food_detail span img{width:90%;margin:5px auto;height:60px;}
	.food_detail span i{width:50px;border:1px solid #ccc;height:30px;line-height:30px;display:block;margin:20px auto;color:#ccc;border-radius:20px; cursor: pointer;}
	.food_detail b{height:30px;line-height:30px;width:30px;display:block;margin:20px auto;border-radius:15px;color:#333;}
	.food_detail .num1{background-color:#fe0000; color:#fff;}
	.food_detail .num2{background-color:#ff790a; color:#fff;}
	.food_detail .num3{background-color:#f5b700; color:#fff;}
	.food_detail .no1{color:#fe0000;}
	.food_detail .no2{color:#ff790a;}
	.food_detail .no3{color:#f5b700;}
	.food_detail .good{float: right;margin-top: -70px;}
	.table td .food p i {
    line-height: 25px;
    text-align: center;
    margin: 0 0 0 10px;
    font-size: 14px;
    cursor: pointer;
    color: #ccc;
    display: inline-block;
}
 	</style>       
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
		<input class="themes" type="hidden" value="<%=ThemePath%>">
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
	            	<!-- 页面内容开始 -->
	            	<div class="col-md-12 col-sm-12 m_page_con">
	                <div class="page-bar m_margin_0_0_0_0">
	                    <ul class="page-breadcrumb">
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">营养食谱</a><i class="fa fa-circle"></i></li>
	                        <li><span>食谱展示</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">食谱展示</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<a class="btn btn-default" data-target="#static" data-toggle="modal" onclick="favoriteFood(2)">喜爱食物排名</a>
								<!-- <a class="btn btn-default" data-target="#static" data-toggle="modal" onclick="static_deleteRecipe(5);">删除本周食谱</a>
								<a class="btn btn-default" data-target="#static" data-toggle="modal" onclick="removeDay();">复制本周食谱</a> -->
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="#" class="form-horizontal">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择时间：</span>
	                         		<input type="text" class="m_input form-control" name="day" id="day"/>
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<button type="button" class="btn green" id="search">查找</button>
	                         	</div>
	                         </div>
	                         </form>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>食谱展示</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                              <div style="text-align: center;">
	                            	<div class="m_text_center">
										<img src="<%=basePath %>assets/global/img/day_food.png">
									</div>
									<h3 class="m_text_center m_color_999">
										<span id="date" style="color: #ccc;"></span>
										
									</h3>
									</div>
	                                <table class="table table-bordered table-hover">
	                                    <thead id="thead">
	                                    </thead>
	                                    <tbody id="tbody">
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                    </div>
	                </div>
	                </div>
	                <!--页面内容结束 -->
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
	    <input type="hidden" name="schoolId" id="schoolId" value="${sessionScope.user.schoolId}"/>	
		<input type="hidden" name="dishId" id="dishId" value=""/>
		<input type="hidden" name="newFoodPicName" id="newFoodPicName" value=""/>
		<input type="hidden" name="dishType" id="dishType" value=""/>
		<input type="hidden" name="pushDate" id="pushDate" value=""/>
		<!-- 当前页面上菜谱的开始时间 -->
		<input type="hidden" name="currentPageStartDay" id="currentPageStartDay" value=""/>
		<input type="hidden" name="currentPageEndDay" id="currentPageEndDay" value=""/>
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
<!-- 改变图片弹框开始 -->
<div class="modal fade" id="static" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-md page page1">
	           <div class="modal-content">
	               <div class="modal-header">
	                   <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                   <h4 class="modal-title">修改/添加菜品</h4>
	               </div>
	               <div class="modal-body">
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<form action="" method="POST" class="form-horizontal" id="uploadPhoto" enctype="multipart/form-data">  
								<div id="container" class="fileupload-buttonbar ">
									<div class="form-group">
										<label class="control-label col-md-3">菜品名称：</label>
										<div class="col-md-4">
											<input type="text" class="form-control" id="dishName"/>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3">图片地址：</label>
										<div class="col-md-4">
											<a class="btn btn-default btn-md pickfiles" id="pickfiles" href="#">
												<i class="glyphicon glyphicon-plus"></i>
												<span>选择图片</span> 
											</a>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3"></label>
										<div class="col-md-4">
											<div id="file-list"></div>
										</div>
									</div>
									
									<input id="domain" type="hidden" value="<%=Cons.QINIU_BUCKETNAME_SCHOOLRECIPE_URL%>">
									<input id="basePath" type="hidden" value="<%=basePath%>">
									<input id="uptoken_url" type="hidden" value="<%=basePath%>recipe/getUpTokenInJS.do">
								</div>
							</form>
						</div>
					</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="upload" class="btn green">确定</button>
						<button type="button" data-dismiss="modal" class="btn">取消</button>                            
					</div>
	           </div>
	       </div>
	       <div class="modal-dialog modal-md page page2">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">喜欢食物排名</h4>
	                </div>
	                <div class="modal-body">
						<ul class="order row-fluid nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab_1_1"><i class="fa fa-beer"></i>${zaocan}</a></li>
						<li><a data-toggle="tab" href="#tab_1_2"><i class="fa fa-ticket"></i>${zaodian}</a></li>
						<li><a data-toggle="tab" href="#tab_1_3"><i class="fa fa-lemon-o"></i>${wucan}</a></li>
						<li><a data-toggle="tab" href="#tab_1_4"><i class="fa fa-ellipsis-h"></i>${wancan}</a></li>
					</ul>
					<div class="tab-content">

						<div id="tab_1_1" class="tab-pane active">
						</div>

						<div id="tab_1_2" class="tab-pane">
						</div>
						
						<div id="tab_1_3" class="tab-pane">
						</div>
						
						<div id="tab_1_4" class="tab-pane">
						</div>

					</div>
					</div>
	                <div class="modal-footer">
	                    <button type="button" class="btn dark btn-outline" data-dismiss="modal">关闭</button>
	                </div>
	            </div>
	        </div>
	        <div class="modal-dialog modal-md page page3"  style="width:400px;">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">删除菜品</h4>
	                </div>
	                <div class="modal-body">
						<img src="<%=basePath%>assets/global/img/m_img/note.png" class="m_margin_left_15">确定删除该菜品?
					</div>
	                <div class="modal-footer">
	                    <button class="btn green" data-dismiss="modal" type="button" id="deleteDish">确定</button>
						<button class="btn" data-dismiss="modal" type="button">取消</button>
	                </div>
	            </div>
	        </div>
	       	<div class="modal-dialog modal-md page page4">
	            <div class="modal-content">
	                <div id="startCopy">
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                    <h4 class="modal-title">复制菜谱</h4>
		                </div>
		                <div class="modal-body">
						 <div class="form-group">
								<label class="control-label col-md-3">复制时间：</label>
								<div class="col-md-4" id="mubanDate"></div>
						 </div>
						 <div class="form-group" style="clear: left;">
						</div>
						 <div class="form-group" style="clear: left;">
							<label class="control-label col-md-3">开始时间：</label>
							<div class="col-md-4">
							    <input class="m_input form-control" name="startDay" id="startDay" type="text" size="16" style="height:30px;">
								<!-- <input type="text" size="16" name="startDay" id="startDay" style="width:50%;padding:0px;margin:0px;"/> -->
							</div>
						</div>
						<div class="form-group" style="clear: left;">
						</div>
						<div class="form-group" style="clear: left;">
							<label class="control-label col-md-3">结束时间：</label>
							<div class="col-md-4">
								<input class="m_input form-control"  name="startDay" id="endDay"  type="text" size="16" style="height:30px;">
								<!-- <span class="help-block message" style="display: none;font-size: 8pt;color: #A51515;" id="endDayHelp"></span> -->
							</div>
						</div>
						</div>
		                <div class="modal-footer">
		                    <button class="btn green" type="button" onclick="copyRecipe();" id="copyRecipe">开始复制</button>
							<button class="btn" data-dismiss="modal" type="button" id="closeCopyRecipe">取消复制</button>
		                </div>
	                </div>
	                <div id="okCopy">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
							<h4 class="modal-title">复制成功</h4>
						</div>
						<div class="modal-body" >
							<img src="<%=basePath%>assets/global/img/m_img/ok.png">
							复制完成! 
						</div>
						<div class="modal-footer">
								<button class="btn green " data-dismiss="modal" type="button" id="ok">好的</button>
								<button class="btn" data-dismiss="modal" type="button">关闭</button>
						</div>
					</div>
					<div id="ngCopy">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
							<h4 class="modal-title">复制失败</h4>
						</div>
						<div class="modal-body m_text_center">
							<div class="alert alert-danger">
                               <strong><i class="fa fa-warning"></i></strong>复制失败!
                            </div>
						</div>
						<div class="modal-footer">
							<button class="btn green " type="button" id="copyAgain" onclick="removeDay();">重新复制</button>
							<button class="btn" data-dismiss="modal" type="button">关闭</button>
						</div>
					</div>
	            </div>
	        </div>
	        <div class="modal-dialog modal-md page page5">
	            <div class="modal-content">
	                <div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						<h4 class="modal-title">删除食谱</h4>
					</div>
					<div class="modal-body" id="ngCopy">
						<div class="alert alert-danger m_text_align_conter">
                           <strong class="m_padding_0_0_0_15"><i class="fa fa-warning"></i></strong>确定删除本周食谱？
                        </div>
					</div>
					<div class="modal-footer m_text_center">
						<button class="btn green " type="button" id="deleteRecipe">确定</button>
						<button class="btn" data-dismiss="modal" type="button" id="cancelDeleteRecipe">取消</button>
					</div>
	            </div>
	        </div>
</div>
<!-- 改变图片弹框结束-->
	<script src="<%=basePath%>assets/global/plugins/album/scripts/moxie.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/plupload.dev_single.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/zh_CN.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/ui.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/qiniu.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/album/scripts/highlight.js" type="text/javascript" ></script>
	<script src="<%=basePath%>assets/global/plugins/recipe/scripts/main.js" type="text/javascript"></script>
	
	<!-- 七牛上传文件 引用结束 -->
	<script>
		$(function(){
			loadSubMenu("recipeManager"); 
			//选取当前菜单位置
			setActive("recipeManager","recipeExhibition"); 
			$('#day').datetimepicker({format:'Y-m-d',timepicker:false});
			$('#startDay').datetimepicker({format:'Y-m-d',timepicker:false});
			$('#endDay').datetimepicker({format:'Y-m-d',timepicker:false});
			//加载当前周的食谱
			loadweekDish();
			//查找数据
			$("#search").click(function(){
				loadweekDish();
			});
			$("#deleteDish").click(function(){
				//删除单个菜品
				var dishId = $("#dishId").val();
				var pushDate = $("#pushDate").val();
				deleteDishByDishId(dishId,pushDate);
			});

			$("#ok").click(function(){
				$("#day").val($("#endDay").val());
				loadweekDish();
			});

			//删除本周食谱
			$("#deleteRecipe").click(function(){
				//删除本周菜品
				var day = $("#day").val();
				deleteRecipe(day);
			});
			
	 })
			
	function loadweekDish()
	{
			var body = $("#body");
			App.blockUI(body);
			var day = $("#day").val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>recipe/loadWeekRecipe.do",
				data:{
						day : day
					},
				success: function(data){
					//解锁UI
          			App.unblockUI(body);
					var list = $.parseJSON(data);
					var appendHtml = '';
					var theadHtml = '';
					$("#date").text(list.currDay);
					$("#currentPageStartDay").val(list.currentPageStartDay);
					$("#currentPageEndDay").val(list.currentPageEndDay);
					var recipeMap = list.recipeMap;
					var mondayRecipe = recipeMap['星期一'];
					var tuesdayRecipe = recipeMap['星期二'];
					var wednesdayRecipe = recipeMap['星期三'];
					var thursdayRecipe = recipeMap['星期四'];
					var fridayRecipe = recipeMap['星期五'];
					var saturdayRecipe = recipeMap['星期六'];
					var sundayRecipe = recipeMap['星期日'];

					//获取当前服务器的时间
					var currentDate = list.currentDate;

					//创建数组，用于保存周一到周日的菜谱
					var recipeArr = new Array();
					recipeArr.push(mondayRecipe);
					recipeArr.push(tuesdayRecipe);
					recipeArr.push(wednesdayRecipe);
					recipeArr.push(thursdayRecipe);
					recipeArr.push(fridayRecipe);
					recipeArr.push(saturdayRecipe);
					recipeArr.push(sundayRecipe);
					
					theadHtml += '<tr><th class="m_width_10"></th><th class="m_width_20">${zaocan}</th><th class="m_width_20">${zaodian}</th><th class="m_width_25">${wucan}</th><th class="m_width_25">${wancan}</th></tr>';
					$("#thead").html(theadHtml);
					$.each(recipeArr,function(n,value) {
						appendHtml += '<tr class="er">';
						
						if(n == '0'){
							appendHtml += '<td class="day" style="vertical-align:middle;text-align:center;"><img src="<%=basePath%>assets/global/img/m_img/day01.png"></td>';
						}else if(n == '1'){
							appendHtml += '<td class="day" style="vertical-align:middle;text-align:center;"><img src="<%=basePath%>assets/global/img/m_img/day02.png"></td>';
						}else if(n == '2'){
							appendHtml += '<td class="day" style="vertical-align:middle;text-align:center;"><img src="<%=basePath%>assets/global/img/m_img/day03.png"></td>';
						}else if(n == '3'){
							appendHtml += '<td class="day" style="vertical-align:middle;text-align:center;"><img src="<%=basePath%>assets/global/img/m_img/day04.png"></td>';
						}else if(n == '4'){
							appendHtml += '<td class="day" style="vertical-align:middle;text-align:center;"><img src="<%=basePath%>assets/global/img/m_img/day05.png"></td>';
						}else if(n == '5'){
							appendHtml += '<td class="day" style="vertical-align:middle;text-align:center;"><img src="<%=basePath%>assets/global/img/m_img/day06.png"></td>';
						}else if(n == '6'){
							appendHtml += '<td class="day" style="vertical-align:middle;text-align:center;"><img src="<%=basePath%>assets/global/img/m_img/day07.png"></td>';
						}

						//获取当前时间
						var pushDate = value.pushDate;
			        	var pushTime=new Date(pushDate.replace("-", "/").replace("-", "/"));
			        	var currentTime=new Date(currentDate.replace("-", "/").replace("-", "/"));
			        	//该判断的作用是当前时间的食谱不能继续编辑
			        	if(pushTime >= currentTime){
			        		//能编辑的食谱start
							appendHtml += '<td class="day_recipes">';
							if(value.breakfastList.length > 0){
								$.each(value.breakfastList, function(n, breakfast) 
										{
											if(breakfast.picPath=="" && breakfast.dishName=="")
											{
												appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+breakfast.id+')"><img style="width:90px;height:65px;" id="img'+breakfast.id+'" class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a>';
												appendHtml += '<p><span style="display:none">'+breakfast.dishName+'</span><span class="foodName" >'+breakfast.dishName+'</span><i class="icon-thumbs-up" id="'+breakfast.id+'"></i></p>';
											}else
											{
												if(breakfast.picPath=="")
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+breakfast.id+',\''+breakfast.dishName+'\')"><img style="width:90px;height:65px;" id="img'+breakfast.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
												}else
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+breakfast.id+',\''+breakfast.dishName+'\')"><img  style="width:90px;height:65px;" id="img'+breakfast.id+'" src="' + breakfast.picPath+'"></a>';
												}
												appendHtml += '<div class="Actions">';
												appendHtml += '<dl class="Actions_ul">';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="getid(1,null,'+breakfast.id+',\''+breakfast.dishName+'\')">编辑</a></dd>';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="delid(3,100,'+breakfast.id+',\''+value.pushDate+'\')">删除</a></dd>';
												appendHtml += '</dl>';
												appendHtml += '</div>';
												appendHtml += '<p><span style="display:none">'+breakfast.dishName+'</span>';
												if(breakfast.dishName!="" && typeof(breakfast.dishName)!="undefined" && breakfast.dishName.length>5){
													appendHtml += '<span class="foodName" >'+breakfast.dishName.substring(0,5)+'...</span>';
												}else{
													appendHtml += '<span class="foodName" title="'+breakfast.dishName+'" >'+breakfast.dishName+'</span>';
												}
												appendHtml += '<i class="icon-thumbs-up" id="'+breakfast.id+'"></i></p>';
											}
											appendHtml += ' </div>';
											//在循环最后一次									
											if((value.breakfastList.length-1) == n){
												//符合这个条件说明可以继续添加
												 appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,280,1,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
												 appendHtml += ' </div>';
											}
								});
							}else{
								appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,null,1,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
								appendHtml += ' </div>';
							}
							appendHtml += '</td>';
							appendHtml += '<td class="day_recipes">';
							if(value.lunchList.length > 0){
								$.each(value.lunchList, function(n, lunch) 
										{
											if(lunch.picPath=="" && lunch.dishName=="")
											{
												appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+lunch.id+')"><img id="img'+lunch.id+'" class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a>';
												appendHtml += '<p><span style="display:none">'+lunch.dishName+'</span><span class="foodName" >'+lunch.dishName+'</span><i class="icon-thumbs-up" id="'+lunch.id+'"></i></p>';
											}else
											{
												if(lunch.picPath=="")
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+lunch.id+',\''+lunch.dishName+'\')"><img id="img'+lunch.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
												}else
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+lunch.id+',\''+lunch.dishName+'\')"><img style="width:90px;height:65px;" id="img'+lunch.id+'" src="' + lunch.picPath+'"></a>';
												}
												appendHtml += '<div class="Actions">';
												appendHtml += '<dl class="Actions_ul">';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="getid(1,null,'+lunch.id+',\''+lunch.dishName+'\')">编辑</a></dd>';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="delid(3,null,'+lunch.id+',\''+value.pushDate+'\')">删除</a></dd>';
												appendHtml += '</dl>';
												appendHtml += '</div>';
												appendHtml += '<p><span style="display:none">'+lunch.dishName+'</span>';
												if(lunch.dishName!="" && typeof(lunch.dishName)!="undefined" && lunch.dishName.length>5){
													appendHtml += '<span class="foodName" title="'+lunch.dishName+'">'+lunch.dishName.substring(0,5)+'...</span>';
												}else{
													appendHtml += '<span class="foodName" >'+lunch.dishName+'</span>';
												}
												appendHtml += '<i class="icon-thumbs-up" id="'+lunch.id+'"></i></p>';
											}
											appendHtml += ' </div>';
											//在循环最后一次									
											if((value.lunchList.length-1) == n){
												//符合这个条件说明可以继续添加
												appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,null,2,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
												appendHtml += ' </div>';
											}
									});
							}else{
								appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,null,2,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
								appendHtml += ' </div>';
							}
							appendHtml += '</td>';
							appendHtml += '<td class="day_recipes">';
							if(value.snackList.length > 0){
								$.each(value.snackList, function(n, snack) 
										{
											if(snack.picPath=="" && snack.dishName=="")
											{
												appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+snack.id+')"><img  style="width:90px;height:65px;" id="img'+snack.id+'" class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a>';
												appendHtml += '<p><span style="display:none">'+snack.dishName+'</span><span class="foodName" >'+snack.dishName+'</span><i class="icon-thumbs-up" id="'+snack.id+'"></i></p>';
											}else
											{
												if(snack.picPath=="")
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+snack.id+',\''+snack.dishName+'\')"><img id="img'+snack.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
												}else
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+snack.id+',\''+snack.dishName+'\')"><img style="width:90px;height:65px;" id="img'+snack.id+'" src="' + snack.picPath+'"></a>';
												}
												appendHtml += '<div class="Actions">';
												appendHtml += '<dl class="Actions_ul">';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="getid(1,null,'+snack.id+',\''+snack.dishName+'\')">编辑</a></dd>';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="delid(3,100,'+snack.id+',\''+value.pushDate+'\')">删除</a></dd>';
												appendHtml += '</dl>';
												appendHtml += '</div>';
												appendHtml += '<p><span style="display:none">'+snack.dishName+'</span>';
												if(snack.dishName!="" && typeof(snack.dishName)!="undefined" && snack.dishName.length>5){
													appendHtml += '<span class="foodName" title="'+snack.dishName+'">'+snack.dishName.substring(0,5)+'...</span>';
												}else{
													appendHtml += '<span class="foodName" >'+snack.dishName+'</span>';
												}
												appendHtml += '<i class="icon-thumbs-up" id="'+snack.id+'"></i></p>';
											}
											appendHtml += ' </div>';
											if((value.snackList.length-1) == n){
												appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,null,3,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
												appendHtml += ' </div>';
											}
								});
							}else{
								appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,null,3,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
								appendHtml += ' </div>';
							}
							appendHtml += '</td>';
							appendHtml += '<td class="day_recipes">';
							if(value.otherList.length > 0){
								$.each(value.otherList, function(n, other) 
										{
											if(other.picPath=="" && other.dishName=="")
											{
												appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+other.id+')"><img class="plus" id="img'+other.id+'" src="<%=basePath%>assets/global/img/m_img/plus.png"></a>';
												appendHtml += '<p><span style="display:none">'+other.dishName+'</span><span class="foodName" >'+other.dishName+'</span><i class="icon-thumbs-up" id="'+other.id+'"></i></p>';
											}else
											{
												if(other.picPath=="")
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+other.id+',\''+other.dishName+'\')"><img id="img'+other.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
												}else
												{
													appendHtml += '<div class="food"><a href="#static" data-toggle="modal" onclick="getid(1,null,'+other.id+',\''+other.dishName+'\')"><img style="width:90px;height:65px;" id="img'+other.id+'" src="'+ other.picPath+'"></a>';
												}
												appendHtml += '<div class="Actions">';
												appendHtml += '<dl class="Actions_ul">';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="getid(1,null,'+other.id+',\''+other.dishName+'\')">编辑</a></dd>';
												//appendHtml += '<dd><a href="#static" data-toggle="modal" onclick="delid(3,100,'+other.id+',\''+value.pushDate+'\')">删除</a></dd>';
												appendHtml += '</dl>';
												appendHtml += '</div>';
												appendHtml += '<p><span style="display:none">'+other.dishName+'</span>';
												if(other.dishName!="" && typeof(other.dishName)!="undefined" && other.dishName.length>5){
													appendHtml += '<span class="foodName" title="'+other.dishName+'" >'+other.dishName.substring(0,5)+'...</span>';
												}else{
													appendHtml += '<span class="foodName" >'+other.dishName+'</span>';
												}
												appendHtml += '<i class="icon-thumbs-up" id="'+other.id+'"></i></p>';
											}
											appendHtml += ' </div>';
											if((value.otherList.length-1) == n){
												appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,null,4,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
												appendHtml += ' </div>';
											}
								});
							}else{
								appendHtml += '<div class="food" ><%-- <a href="#static" data-toggle="modal" onclick="addid(1,null,4,\''+value.pushDate+'\')"><img class="plus" src="<%=basePath%>assets/global/img/m_img/plus.png"></a> --%>';
								appendHtml += ' </div>';
							}
							appendHtml += '</td>';
							appendHtml += '</tr>';
							//能编辑的食谱end
			            }else{
			            	//不能编辑的食谱start
			            	appendHtml += '<td class="day_recipes">';
							if(value.breakfastList.length > 0){
								$.each(value.breakfastList, function(n, breakfast) 
								{	
									if(breakfast.picPath=="")
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img id="img'+breakfast.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
									}else
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img style="width:90px;height:65px;" id="img'+breakfast.id+'" src="' + breakfast.picPath+'"></a>';
									}
									appendHtml += '<p><span class="foodName" >'+breakfast.dishName+'</span><i class="icon-thumbs-up" id="'+breakfast.id+'"></i></p>';
									appendHtml += ' </div>';
								});
							}
							appendHtml += '</td>';
							appendHtml += '<td class="day_recipes">';
							if(value.lunchList.length > 0){
								$.each(value.lunchList, function(n, lunch) 
								{
									if(lunch.picPath=="")
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img id="img'+lunch.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
									}else
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img style="width:90px;height:65px;" id="img'+lunch.id+'" src="' + lunch.picPath+'"></a>';
									}
									appendHtml += '<p><span class="foodName" >'+lunch.dishName+'</span><i class="icon-thumbs-up" id="'+lunch.id+'"></i></p>';
									appendHtml += ' </div>';
								});
							}
							appendHtml += '</td>';
							appendHtml += '<td class="day_recipes">';
							if(value.snackList.length > 0){
								$.each(value.snackList, function(n, snack) 
								{	
									if(snack.picPath=="")
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img id="img'+snack.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
									}else
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img style="width:90px;height:65px;" id="img'+snack.id+'" src="' + snack.picPath+'"></a>';
									}
									appendHtml += '<p><span class="foodName" >'+snack.dishName+'</span><i class="icon-thumbs-up" id="'+snack.id+'"></i></p>';
									appendHtml += ' </div>';
								});
							}
							
							appendHtml += '</td>';
							appendHtml += '<td class="day_recipes">';
							if(value.otherList.length > 0){
								$.each(value.otherList, function(n, other) 
								{
											
									if(other.picPath=="")
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img id="img'+other.id+'" src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></a>';
									}else
									{
										appendHtml += '<div class="food"><a href="javascript:;"><img id="img'+other.id+'" src="'+ other.picPath+'"></a>';
									}
									appendHtml += '<p><span class="foodName" >'+other.dishName+'</span><i class="icon-thumbs-up" id="'+other.id+'"></i></p>';
									appendHtml += ' </div>';
								});
							}
							
							appendHtml += '</td>';
							appendHtml += '</tr>';
							//不能编辑的食谱end
			        	}
				  	}); 
         			$("#tbody").html(appendHtml);
         			$("#tbody tr:eq('0')").css({"background-color":"#fcdfe3"});
        			$("#tbody tr:eq('1')").css({"background-color":"#f8d7a4"});
        			$("#tbody tr:eq('2')").css({"background-color":"#f5ee9e"});
        			$("#tbody tr:eq('3')").css({"background-color":"#cfefa4"});
        			$("#tbody tr:eq('4')").css({"background-color":"#9fedf7"});
        			$("#tbody tr:eq('5')").css({"background-color":"#a7d5f6"});
        			$("#tbody tr:eq('6')").css({"background-color":"#cbc4e5"});
        			$("#tbody tr:eq(0) td:eq(0)").css({"background-color":"#fff"});
        			$("#tbody tr:eq(1) td:eq(0)").css({"background-color":"#fff"});
        			$("#tbody tr:eq(2) td:eq(0)").css({"background-color":"#fff"});
        			$("#tbody tr:eq(3) td:eq(0)").css({"background-color":"#fff"});
        			$("#tbody tr:eq(4) td:eq(0)").css({"background-color":"#fff"});
        			$("#tbody tr:eq(5) td:eq(0)").css({"background-color":"#fff"});
        			$("#tbody tr:eq(6) td:eq(0)").css({"background-color":"#fff"});
        			$(".food i").on("click",function(){
        				var id = $(this).attr("id");
        				if($(this).attr("style")){
        					$(this).removeAttr("style");
        					delPraise(id);
        				}else{
        					$(this).css({"color":"#f5bc4b"})
        					addPraise(id);
        				}
        			});

        			//修改菜名
//         			$(".foodName").attr("contenteditable", true);
//         			$(".foodName").blur(function(){
// 	        			var oldFoodName = $(this).prev().html();
//         			    var id = $(this).next().attr("id");
//         			    var newFoodName = $(this).html();
//         			    if(newFoodName == '' || oldFoodName == newFoodName){
//         			    	$(this).html(oldFoodName);
// 							return false;
// 		        		}
//         			    modifyFoodName(id,newFoodName,oldFoodName);
//         			});
	       			$(".food").hover(function(){
	    				$(this).find(".Actions").show();
	    				},function(){
	    					$(this).find(".Actions").hide();
    				})
				}
			});
	}

	//点赞
	function addPraise(id){
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/addPraise.do",
			data:{
				id : id
			},
			success: function(data){}
		});
	}
	// 取消点赞
	function delPraise(id){
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/delPraise.do",
			data:{
				id : id
			},
			success: function(data){}
		});
	}

	// 更改菜名
	function modifyFoodName(id,newFoodName,oldFoodName){
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/modifyFoodName.do",
			data:{
				id : id,
				newFoodName : newFoodName
			},
			success: function(data){
				var flag = $.parseJSON(data);
				if(flag){
					$("#"+id).prev().prev().html(newFoodName);
				}else{
					$("#"+id).prev().html(oldFoodName);
				}
			}
		});
	}

	//获取喜爱食物的排名
	function favoriteFood(num){
		$(".page").removeAttr("style");
		$(".page"+num).show();
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/loadFavoriteFood.do",
			success: function(data)
			{
				var list = $.parseJSON(data);
				var breakfastHtml = '';
				var lunchHtml = '';
				var snackHtml = '';
				var otherHtml = '';
				$.each(list.bList, function(b, breakfast) 
				{
					
					breakfastHtml += '<div class="food_detail">';
					if(b<3)
					{
						breakfastHtml += '<span class="num"><b class="num'+(b+1)+'">'+(b+1)+'</b></span>';
						if(typeof(breakfast.dishName)!="undefined" &&  breakfast.dishName!="" && breakfast.dishName.length>7){
							breakfastHtml += '<span class="name"><em class="no'+(b+1)+' fa fa-vimeo"></em>'+breakfast.dishName.substring(0,7)+'...</span>';	
						}else{
							breakfastHtml += '<span class="name"><em class="no'+(b+1)+' fa fa-vimeo"></em>'+breakfast.dishName+'</span>';	
						}
					}else
					{
						breakfastHtml += '<span class="num"><b class="num">'+(b+1)+'</b></span>';
						breakfastHtml += '<span class="name">'+breakfast.dishName+'</span>';
					}
					if(breakfast.picPath=="")
					{
						breakfastHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						breakfastHtml += '<span class="img"><img src="'+ breakfast.picPath+'"></span>';
					}
					breakfastHtml += '<span class="good"><i class="icon-thumbs-up">'+breakfast.praiseCount+'</i></span>';
					breakfastHtml += ' </div>';
				});
				$("#tab_1_1").html(breakfastHtml);
				$.each(list.lList, function(l, lunch) 
				{
					
					lunchHtml += '<div class="food_detail">';
					if(l<3)
					{
						lunchHtml += '<span class="num"><b class="num'+(l+1)+'">'+(l+1)+'</b></span>';
						lunchHtml += '<span class="name"><em class="no'+(l+1)+' fa fa-vimeo"></em>'+lunch.dishName+'</span>';
					}else
					{
						lunchHtml += '<span class="num"><b class="num">'+(l+1)+'</b></span>';
						
						if(typeof(lunch.dishName)!="undefined" &&  lunch.dishName!="" && lunch.dishName.length>7){
							lunchHtml += '<span class="name">'+lunch.dishName.substring(0,7)+'...</span>';
						}else{
							lunchHtml += '<span class="name">'+lunch.dishName+'</span>';	
						}
					}
					if(lunch.picPath=="")
					{
						lunchHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						lunchHtml += '<span class="img"><img src="'+ lunch.picPath+'"></span>';
					}
					lunchHtml += '<span class="good"><i class="icon-thumbs-up">'+lunch.praiseCount+'</i></span>';
					lunchHtml += ' </div>';
					
				});
				$("#tab_1_2").html(lunchHtml);
				$.each(list.sList, function(s, snack) 
				{
					
					snackHtml += '<div class="food_detail">';
					if(s<3)
					{
						snackHtml += '<span class="num"><b class="num'+(s+1)+'">'+(s+1)+'</b></span>';
						snackHtml += '<span class="name"><em class="no'+(s+1)+' fa fa-vimeo"></em>'+snack.dishName+'</span>';
					}else
					{
						snackHtml += '<span class="num"><b class="num">'+(s+1)+'</b></span>';
						if(typeof(snack.dishName)!="undefined" &&  snack.dishName!="" && snack.dishName.length>7){
							snackHtml += '<span class="name"><em class="no'+(s+1)+' fa fa-vimeo"></em>'+snack.dishName.substring(0,7)+'...</span>';
						}else{
							snackHtml += '<span class="name"><em class="no'+(s+1)+' fa fa-vimeo"></em>'+snack.dishName+'</span>';
						}
					}
					if(snack.picPath=="")
					{
						snackHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						snackHtml += '<span class="img"><img src="'+ snack.picPath+'"></span>';
					}
					snackHtml += '<span class="good"><i class="icon-thumbs-up">'+snack.praiseCount+'</i></span>';
					snackHtml += ' </div>';
				});
				$("#tab_1_3").html(snackHtml);
				$.each(list.oList, function(o, other) 
				{
					
					otherHtml += '<div class="food_detail">';
					if(o<3)
					{
						otherHtml += '<span class="num"><b class="num'+(o+1)+'">'+(o+1)+'</b></span>';
						otherHtml += '<span class="name"><em class="no'+(o+1)+' fa fa-vimeo"></em>'+other.dishName+'</span>';
					}else
					{
						otherHtml += '<span class="num"><b class="num">'+(o+1)+'</b></span>';
						if(typeof(other.dishName)!="undefined" &&  other.dishName!="" && other.dishName.length>7){
							otherHtml += '<span class="name" title="'+other.dishName+'"><em class=" fa fa-vimeo"></em>'+other.dishName.substring(0,7)+'...</span>';	
						}else{
							otherHtml += '<span class="name"><em class=" fa fa-vimeo"></em>'+other.dishName+'</span>';
						}
						
					}
					if(other.picPath=="")
					{
						
						otherHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						otherHtml += '<span class="img"><img src="'+ other.picPath+'"></span>';
					}
					otherHtml += '<span class="good"><i class="icon-thumbs-up">'+other.praiseCount+'</i></span>';
					otherHtml += ' </div>';
				}); 
				$("#tab_1_4").html(otherHtml);
			},
		});
	}

	//用于修改菜品的弹框
	function getid(num,height,id,dishName,desc){
		$("#dishId").val("");
		$("#dishName").val("");
		$("#file-list").find("div").remove();
		/*num：page,height：弹窗高,id*/
		$(".modal_page").removeAttr("style");
		$(".modal-body").css({"min-height":height});
		$("#dishId").val(id);
		if(num==1){
			$("#dishName").val(dishName);	
		}
		for(var i=1;i<=5;i++){
			if(num==i){
				$(".page"+i+"").show();
			}else{
				$(".page"+i+"").hide();
			}
		}
	}
	//用于添加菜品的弹框
	function addid(num,height,dishType,pushDate){
		$(".page").removeAttr("style");
		$(".page"+num+"").show();
		$("#dishId").val("");
		$("#dishType").val("");
		$("#pushDate").val("");
		$("#file-list").find("div").remove();
		$(".modal-body").css({"min-height":height});
		$("#dishType").val(dishType);
		$("#pushDate").val(pushDate);
		$("#dishName").val("");
	}

	//用于删除菜品的弹框
	function delid(num,height,id,pushDate){
		$("#dishId").val("");
		$("#pushDate").val("");
		$("#file-list").find("div").remove();
		/*num：page,height：弹窗高,id*/
		$(".modal_page").removeAttr("style");
		$(".modal-body").css({"min-height":height});
		$("#dishId").val(id);
		$("#pushDate").val(pushDate);
		for(var i=1;i<=5;i++){
			if(num==i){
				$(".page"+i+"").show();
			}else{
				$(".page"+i+"").hide();
			}
		}
	}

	
	function removeDay(){
		$(".modal_page").removeAttr("style");
		$("#startCopy").removeAttr("style");
		$("#okCopy").css("display","none");
		$("#ngCopy").css("display","none");

		$("#mubanDate").text($("#date").text());
		$("#startDay").val("");
		$("#endDay").val("");
		$("#startDay").css("border-color","");
		$("#endDay").css("border-color","");
		$("#startDayHelp").hide();
		$("#startDayHelp").html("");
		$("#endDayHelp").hide();
    	$("#endDayHelp").html("");
    	num=4;
    	for(var i=1;i<=5;i++){
			if(num==i){
				$(".page"+i+"").show();
			}else{
				$(".page"+i+"").hide();
			}
		}
	}

	function static_deleteRecipe(num){
		$(".page").removeAttr("style");
		$(".page"+num).show();
	}


	function copyRecipe(){
		//获取当前页面上食谱的开始时间和结束时间
		var currentPageStartDay = $("#currentPageStartDay").val();
		var currentPageEndDay = $("#currentPageEndDay").val();
		//获取选择复制的开始时间和结束时间
		var startDay = $("#startDay").val();
		var endDay = $("#endDay").val();
		var day = new Date();
		var str = "" + day.getFullYear() + "/"+(day.getMonth()+1) + "/"+ day.getDate();
		var now = new Date(str);
	    var start=new Date(startDay.replace("-", "/").replace("-", "/"));
    	var end=new Date(endDay.replace("-", "/").replace("-", "/"));
		if(startDay == ''){
			layer.tips("开始时间不能为空",$("#startDay"))
			return false;
    	}else if(start<now)
        {
			layer.tips("开始时间小于当前时间",$("#startDay"))
    		return false;
        }
    	if(endDay == ''){
			layer.tips("结束时间不能为空",$("#endDayHelp"));
			return false;
        }else if(end<now)
        {
			layer.tips("结束时间小于当前时间",$("#endDayHelp"));
    		return false;
        }
       	if(start > end){
			layer.tips("结束时间小于开始时间",$("#endDayHelp"));
			return false;
        }
        //复制过程中，不能点击关闭按钮
		$("#copyRecipe").html("复制中...");
		$("#copyRecipe").attr("disabled","disabled");
		$("#closeCopyRecipe").attr("disabled","disabled");
		//判断复制的开始时间是周几
		var start=new Date(startDay.replace("-", "/").replace("-", "/"));
		var end=new Date(endDay.replace("-", "/").replace("-", "/"));		 
		var week = showWeek(start);
		//算出开始时间和结束时间之间总共有几周
		if(week == '星期一'){
			//周一的话，直接用时间差除以7得出商然后加上余数
		}else if(week == '星期二'){
			//周二的话，需要往前推一天
			start.setTime(start.getTime()-24*3600*1000);
		}else if(week == '星期三'){
			//周三的话，需要往前推两天
			start.setTime(start.getTime()-2*24*3600*1000);
		}else if(week == '星期四'){
			//周四的话，需要往前推三天
			start.setTime(start.getTime()-3*24*3600*1000);
		}else if(week == '星期五'){
			//周五的话，需要往前推四天
			start.setTime(start.getTime()-4*24*3600*1000);
		}else if(week == '星期六'){
			//周六的话，需要往前推五天
			start.setTime(start.getTime()-5*24*3600*1000);
		}else if(week == '星期日'){
			//周日的话，需要往前推六天
			start.setTime(start.getTime()-6*24*3600*1000);
		}
		var millisecondDifference = end.getTime()-start.getTime(); //时间差的毫秒数
		//计算开始时间和结束时间总共包含多少天
		var daysDifference=Math.floor(millisecondDifference/(24*3600*1000))+1;
		//计算总共有几周
		var weekDifference = Math.ceil(daysDifference/7);
		
		//发送ajax请求,进行复制操作
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/copyRecipe.do",
			data:{
				currentPageStartDay : currentPageStartDay,
				currentPageEndDay : currentPageEndDay,
				startDay : startDay,
				weekDifference : weekDifference
			},
			success: function(data){
				var flag = $.parseJSON(data);
				$("#copyRecipe").html("开始复制");
				$("#copyRecipe").removeAttr("disabled");
				$("#closeCopyRecipe").removeAttr("disabled");
				if(flag){
					$("#startCopy").css("display","none");
					$("#okCopy").removeAttr("style"); //ie,ff均支持
					$("#ngCopy").css("display","none"); //ie,ff均支持
					//在提示栏显示复制成功，请查询查看
					$("#day").val(endDay);
					//loadweekDish();
				}else{
					//在提示栏显示复制失败,请稍后重试
					$("#startCopy").css("display","none");
					$("#okCopy").css("display","none"); //ie,ff均支持
					$("#ngCopy").removeAttr("style"); //ie,ff均支持
				}
			}
		});
	}

	//判断传递参数是周几
	function showWeek(time){ 
	    var show_day=new Array('星期日','星期一','星期二','星期三','星期四','星期五','星期六');  
	    var day=time.getDay();//返回值0-6 
	    return show_day[day];
	} 

	//删除单个菜品
	function deleteDishByDishId(dishId,pushDate)
	{	
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/deleteDishByDishId.do",
			data:{
				dishId : dishId
				},
			success: function(data){
				var flag = eval("(" + data + ")");
				if(flag)
				{
					$("#day").val(pushDate);
					loadweekDish();
				}
			},
		});
	}

	//删除本周食谱
	function deleteRecipe(day)
	{	
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/deleteRecipe.do",
			data:{
				day : day
				},
			success: function(data){
				var flag = eval("(" + data + ")");
				if(flag)
				{
					$("#cancelDeleteRecipe").click();
					$("#day").val(day);
					loadweekDish();
				}
			},
		});
	}
	</script>
</html>