<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>创建电子课程表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
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
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">电子课程表</a><i class="fa fa-circle"></i></li>
	                        <li><span>创建电子课程表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">创建电子课程表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<form action="<%=basePath%>curriculum/toSaveCurriculumTime.do" class="form-horizontal" name="defform" method="post" id="saveCurriculumTime">
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
		                         <div class="row m_margin_10_auto">
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<span class="m_span">开始时间：</span>
		                                <input type="text" class="m_input form-control" name="startDay" id="startDay"/> 
		                         	</div>
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<span class="m_span">结束时间：</span>
		                         		<input type="text"class="m_input form-control" name="endDay"  id="endDay"/>
		                         	</div>
		                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                         		<a class="btn green" onclick="save();">保存</a>
		                         		<a class="btn yellow" id="back">返回</a>
		                         	</div>
		                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>创建电子课程表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover" >
								<tr>
									<td class="bg">阶段</td>
									<td class="bg">开始时间</td>
									<td class="bg">结束时间</td>
									<td class="bg">操作</td>
									<%-- <c:forEach items="${weekList}" var="week">
										<td class="bg">${week.weekName}</td>
									</c:forEach> --%>
								</tr>

								<tr id="morning1">
									<td class="curriculumtime bg" id="am" rowspan="1" align="center" valign="middle">上午</td>
									<td class="bg">
									    <input class="form-control add_title" placeholder="上课时间" name="startTimeAm" i="1" id="startTimeAm1"/>
									</td>
									<td class="bg">
									    <input placeholder="下课时间" name="endTimeAm" class="form-control add_title" i="1" id="endTimeAm1"/>
									</td>
									<td class="bg">
										<a class="btn mini green" onclick="appendAddAm()"><i class="fa fa-plus"></i></a>
									</td>

									<%-- <c:forEach items="${weekList}" var="s">
										 <td>
										</td>
									</c:forEach> --%>

								</tr>
								
								<tr>
									<td colspan="3">休息时间</td>
								</tr>

								<tr id="afternoon1">
									<td class="curriculumtime bg" id="pm" rowspan="1" align="center" valign="middle">下午</td>
									<td class="bg">
									    <input placeholder="上课时间" class="form-control add_title" name="startTimePm" j="1" id="startTimePm1"/>
									</td>
									<td class="bg">
									    <input placeholder="下课时间" name="endTimePm" class="form-control add_title" j="1" id="endTimePm1"/>
									</td>
									<td class="bg">
										<a class="btn mini green" onclick="appendAddPm()"><i class="fa fa-plus"></i></a>
									</td>

									<%-- <c:forEach items="${weekList}">
										 <td>
										</td>
									</c:forEach> --%>
								</tr>
								
								<tr>
									<td colspan="3">休息时间</td>
								</tr>

								<tr id="night1">
									<td class="curriculumtime bg" id="ni" rowspan="1" align="center" valign="middle">晚上</td>
									<td class="bg">
									    <input placeholder="上课时间"  name="startTimeN" class="form-control add_title" n="1" id="startTimeN1"/>
									</td>
									<td class="bg">
									    <input placeholder="下课时间" name="endTimeN" class="form-control add_title" n="1" id="endTimeN1"/>
									</td>
									<td class="bg">
										<a class="btn mini green" onclick="appendAddN()"><i class="fa fa-plus"></i></a>
									</td>

									<%-- <c:forEach items="${weekList}">
										 <td>
										</td>
									</c:forEach> --%>
								</tr>
							</table>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                        
	                    </form>
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
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script type="text/javascript">

		$(function() { 
			loadSubMenu("curriculum"); 
			//选取当前菜单位置
			setActive("curriculum","curriculumManager");     
			$('#startDay,#endDay').datetimepicker({
				format:'Y-m-d',
				timepicker:false
			});
			$('.add_title').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});
			//结束日期
			$("#endDay").blur(function(){
				var endDay = $("#endDay").val();
				var startDay = $("#startDay").val();
				//未输入结束时间
				if ("" == endDay)
				{
					layer.tips('结束时间不能为空', '#endDay');
				}
				else if(startDay > endDay)
				{
					layer.tips('开始日期不能晚于结束日期', '#startDay');
				}	
			});

			
			//点击确定保存
		    $("#back").on("click",function()
		    {
		    	window.history.back(-1);
			})
			

		});
		
		function save(){
			var flage =true;
			var startTimeAm = $("#startTimeAm1").val();
	    	$("input[id^='startTimeAm']").each(function(){
	    		var i=$(this).attr("i");
	    		var startTimeAm=$(this).val();
	    		$("input[id^='endTimeAm']").each(function(){
		    		var j=$(this).attr("i");
		    		var endTimeAm=$(this).val();
		    		if(!checkSplitDate(endTimeAm,2) || !checkSplitDate(startTimeAm,2)){
		    			layer.tips('请正确输入时间格式！', this);
		    			flage=false;
		    		}
		    		if(endTimeAm < startTimeAm && i == j){
		    			layer.tips('开始日期不能晚于结束日期', this);
		    			flage=false;
		    		}
		    		
		    	});
	    	});
	    	$("input[id^='startTimePm']").each(function(){
	    		var i=$(this).attr("j");
	    		var startTimeAm=$(this).val();
	    		$("input[id^='endTimePm']").each(function(){
		    		var j=$(this).attr("j");
		    		var endTimeAm=$(this).val();
		    		if(!checkSplitDate(endTimeAm,2) || !checkSplitDate(startTimeAm,2)){
		    			layer.tips('请正确输入时间格式！', this);
		    			flage=false;
		    		}
		    		if(endTimeAm < startTimeAm && i == j){
		    			layer.tips('开始日期不能晚于结束日期', this);
		    			flage=false;
		    		}
		    		
		    	});
	    	});
	    	$("input[id^='startTimeN']").each(function(){
	    		var i=$(this).attr("n");
	    		var startTimeAm=$(this).val();
	    		$("input[id^='endTimeN']").each(function(){
		    		var j=$(this).attr("n");
		    		var endTimeAm=$(this).val();
		    		if(!checkSplitDate(endTimeAm,2) || !checkSplitDate(startTimeAm,2)){
		    			layer.tips('请正确输入时间格式！', this);
		    			flage=false;
		    		}
		    		if(endTimeAm < startTimeAm && i == j){
		    			layer.tips('开始日期不能晚于结束日期', this);
		    			flage=false;
		    		}
		    		
		    	});
	    	});

	    	var startDay = $("#startDay").val();
	    	var endDay = $("#endDay").val();
		    	if(startDay=="" || endDay=="")
				{
		    		layer.tips('开始日期结束日期不能为空', '#startDay');
		    		flage=false;
				}
				if(startDay > endDay)
				{
					layer.tips('开始日期不能晚于结束日期', '#startDay');
					flage=false;
				}
			
		    	if(!checkTime(startDay,endDay))
				{
		    		flage=false;
				}
		    	if(!checkSplitDate(startDay,1) || !checkSplitDate(endDay,1)){
		    		flage=false;
		    	}
		    	if(flage)
				{
		    		$("#saveCurriculumTime").submit();
				}
		}
		
		
	    var i = 1;
		function appendAddAm(){
			i++;
			var appendHtml = '<tr id="morning'+i+'">';
			appendHtml += '<td class="bg">';
			appendHtml += '<input placeholder="上课时间" class="form-control add_title" name="startTimeAm" id="startTimeAm'+i+'" i="'+i+'" />';
			appendHtml += '</td>';
			appendHtml += '<td class="bg">';
			appendHtml += '<input placeholder="下课时间"class="form-control add_title" name="endTimeAm" id="endTimeAm'+i+'"/>';
			appendHtml += '</td>';
			appendHtml += '<td class="bg">';
			appendHtml += '<a class="btn mini red" onclick="removeAddAm($(this))"><i class="fa fa-minus"></i></a>';
			appendHtml += '</td>';
			/* appendHtml += '<c:forEach items="${weekList}"><td></td></c:forEach>'; */
			appendHtml += '</tr>';
			var id = $("#am").attr("rowspan");
			var d = parseInt(id)+1;
			$("#am").attr("rowspan",d);
			$("#morning1").after(appendHtml);
			$(".add_title").datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});
		}
		
		 var j = 1;
		function appendAddPm(){
			j++;
			var appendHtml = '<tr id="afternoon'+j+'">';
			appendHtml += '<td class="bg">';
			appendHtml += '<input placeholder="上课时间" class="form-control add_title" name="startTimePm" id="startTimePm'+j+'"/>';
			appendHtml += '</td>';
			appendHtml += '<td class="bg">';
			appendHtml += '<input placeholder="下课时间" class="form-control add_title" name="endTimePm" id="endTimePm'+j+'" />';
			appendHtml += '</td>';
			appendHtml += '<td class="bg">';
			appendHtml += '<a class="btn mini red" onclick="removeAddPm($(this));"><i class="fa fa-minus"></i></a>';
			appendHtml += '</td>';
		/* 	appendHtml += '<c:forEach items="${weekList}"><td></td></c:forEach>'; */
			appendHtml += '</tr>';

			var id = $("#pm").attr("rowspan");
			var d = parseInt(id)+1;
			$("#pm").attr("rowspan",d);
			$("#afternoon1").after(appendHtml);
			$('.add_title').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});
		}
		
		var n=1;
		function appendAddN(){
			n++;
			var appendHtml = '<tr id="night'+n+'">';
			appendHtml += '<td class="bg">';
			appendHtml += '<input placeholder="上课时间"  class="form-control add_title" name="startTimeN" id="startTimeN'+n+'"/>';
			appendHtml += '</td>';
			appendHtml += '<td class="bg">';
			appendHtml += '<input placeholder="下课时间" class="form-control add_title" name="endTimeN" id="endTimeN'+n+'"/>';
			appendHtml += '</td>';
			appendHtml += '<td class="bg">';
			appendHtml += '<a class="btn mini red" onclick="removeAddN($(this));"><i class="fa fa-minus"></i></a>';
			appendHtml += '</td>';
			/* appendHtml += '<c:forEach items="${weekList}"><td></td></c:forEach>'; */
			appendHtml += '</tr>';

			var id = $("#ni").attr("rowspan");
			var d = parseInt(id)+1;
			$("#ni").attr("rowspan",d);
			$("#night1").after(appendHtml);
			$('.add_title').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});
		}
		
		function removeAddAm(obj)
		{
			if(confirm("确定要删除此行吗？"))
		 	{
				var id = $("#am").attr("rowspan");
				var d = parseInt(id)-1;
				$("#am").attr("rowspan",d);
				obj.parent().parent().remove();
		 	}
		}
		
		function removeAddPm(obj)
		{
			if(confirm("确定要删除此行吗？"))
		 	{
				var id = $("#pm").attr("rowspan");
				var d = parseInt(id)-1;
				$("#pm").attr("rowspan",d);
				obj.parent().parent().remove();
		 	}
		}
		
		function removeAddN(obj)
		{
			if(confirm("确定要删除此行吗？"))
		 	{
				var id = $("#ni").attr("rowspan");
				var d = parseInt(id)-1;
				$("#ni").attr("rowspan",d);
		 		obj.parent().parent().remove();
		 	}
		}
		
		
		function checkTime(startDay,endDay)
		{
			var flag = false;
			$.ajax({
				type: "post",
				async:false, 
				data:{
					startDay : startDay,
					endDay : endDay
				},
				url: "<%=basePath%>curriculum/toCheckSemesterCurriculum.do",
				success: function(data)
				{
					var result = eval("(" + data + ")");
					//此日期存在
					if ("success" == result.resultCode)
					{
						layer.confirm('该时间段内已有课程表存在，请勿重新创建，如有问题请点编辑进行修改！', {
							  btn: ['是','否'] //按钮
							}, function(){
							 	window.location.href="<%=basePath%>curriculum/toAddCurriculum.do";
							}, function(){
							});
						flag = false;
					}
					else
					{
						flag = true;
					}
					
				},
			});
			return flag;
		}
		
		function checkSplitDate(date,type){
			var flag = true;
			var reg = /^[0-9]+$/;
			if(date !=null && date!=""){
				var strs = new Array();
				if(type == 1){
					strs = date.split("-");
				}else{
					strs = date.split(":");
				}
				for (i=0;i<strs.length ;i++ ) 
				{ 
					  if (!reg.test(strs[i])) {
						  flag = false;
					  }
					  
				} 
			}
			return flag;
		}
	</script>
</html>