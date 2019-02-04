<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>作息时间表设定</title>
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
	                        <li><a href="">作息时间</a><i class="fa fa-circle"></i></li>
	                        <li><span>作息时间表设定</span></li>
	                    </ul>
	                </div>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<form action="<%=basePath%>schedule/doSaveSchedule.do" id="addForm" class="form-horizontal" method="post">
	                    	<img src="<%=basePath%>assets/global/img/m_img/ScheduleTime1.png" style="display:block;margin:15px auto;">
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                         <div class="row m_margin_10_auto">
								<input type="hidden" id="type" value="${sessionScope.user.type}"/>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">开始时间：</span>
                                    <input placeholder="开始日期" class="m_input form-control" type="text" readonly="readonly" name="startDay" id="startDay">
                                    <span class="help-inline" style="display: none;color: red;" id="startDayHelp">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">结束时间：</span>
	                         		<input placeholder="结束日期" class="m_input form-control" type="text" readonly="readonly" name="endDay" id="endDay">
	                         		<span class="help-inline" style="display: none;" id="endDayHelp"></span> 
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">作息类型：</span>
	                         		<select class="m_select form-control" name="type" id="typeSel" onchange="getnum()">
										<option value="1">全天</option>
										<option value="0">分段</option>
									</select>
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption"><i class="fa fa-list"></i>作息时间表设定 </div>
	                            </div>
	                            <div class="portlet-body">
	                            	<div class="quantian">
									<div class="control-group settime">
										<div class="time_con" style="display:block">
											<table class="table table-bordered table-hover">
												<thead class="flip-content">
													<th class="m_width_25">时间单元</th>
													<th class="m_width_25">开始时间</th>
													<th class="m_width_25">结束时间</th>
													<th class="m_width_25">操作</th>
												</thead>
												<tbody>
													<td>时间单元<b class="num">1</b></td>
													<td><input type="text" readonly="readonly" name="beginTime" class="time form-control"></td>
													<td><input type="text" readonly="readonly" name="endTime" class="time form-control"></td>
													<td><a href="javascript:;" class="add btn btn-icon-only green" id="allday"><i class="fa fa-plus"></i></a>
													</td>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="fenduan" style="display:none">
									<div class="control-group settime">
										<p><i class="checkbox" id="morningCheck"></i>上午</p>
										<div class="time_con">
											<table class="table table-bordered table-hover">
												<thead>
													<th class="m_width_25">时间单元</th>
													<th class="m_width_25">开始时间</th>
													<th class="m_width_25">结束时间</th>
													<th class="m_width_25">操作</th>
												</thead>
												<tbody>
													<td>时间单元<b class="num">1</b></td>
													<td><input type="text" readonly="readonly" name="morningBegin" class="time form-control"></td>
													<td><input type="text" readonly="readonly" name="morningEnd" class="time form-control"></td>
													<td>
													<a href="javascript:;" class="add btn btn-icon-only green" id="morning"><i class="fa fa-plus"></i></a>
													</td>
												</tbody>
											</table>
										</div>
									</div>
									<div class="control-group settime">
										<p><i class="checkbox" id="afternoonCheck"></i>下午</p>
										<div class="time_con">
											<table class="table table-bordered table-hover">
												<thead>
													<th class="m_width_25">时间单元</th>
													<th class="m_width_25">开始时间</th>
													<th class="m_width_25">结束时间</th>
													<th class="m_width_25">操作</th>
												</thead>
												<tbody>
													<td>时间单元<b class="num">1</b></td>
													<td><input type="text" readonly="readonly" name="afternoonBegin" class="time form-control"></td>
													<td><input type="text" readonly="readonly" name="afternoonEnd" class="time form-control"></td>
													<td>
													<a href="javascript:;" class="add btn btn-icon-only green" id="afternoon"><i class="fa fa-plus"></i></a>
													</td>
												</tbody>
											</table>
										</div>
									</div>
									<div class="control-group settime">
										<p><i class="checkbox" id="nightCheck"></i>晚上</p>
										<div class="time_con">
											<table class="table table-bordered table-hover">
												<thead>
													<th class="m_width_25">时间单元</th>
													<th class="m_width_25">开始时间</th>
													<th class="m_width_25">结束时间</th>
													<th class="m_width_25">操作</th>
												</thead>
												<tbody>
													<td>时间单元<b class="num">1</b></td>
													<td><input type="text" readonly="readonly" name="nightBegin" class="time form-control"></td>
													<td><input type="text" readonly="readonly" name="nightEnd" class="time form-control"></td>
													<td>
													<a href="javascript:;" class="add btn btn-icon-only green" id="night"><i class="fa fa-plus"></i></a>
													</td>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<input type="hidden" name="amCheck" id="amCheck">
								<input type="hidden" name="pmCheck" id="pmCheck">
								<input type="hidden" name="ngCheck" id="ngCheck">
								<button type="button" class="btn green" id="save">下一步<i class="icon-angle-right"></i></button>
								<button type="button" class="btn" id="cancel">取消</button>
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
		var num=1;
		$(function() {
			$("#typeSel").val(1);
			loadSubMenu("schoolManager"); 
			//选取当前菜单位置
			setActive("schoolManager","scheduleManage");  
			$('#startDay,#endDay').datetimepicker({
				 format:"Y-m-d" ,
			     timepicker:false
				});
			$('.time').datetimepicker({
				datepicker:false,
				format:'H:i',
				step:5
			});   
			//开始日期
			$("#startDay").blur(function(){
				var startDay = $("#startDay").val();
				var nowtime = new Date();  
	            var year = nowtime.getFullYear();  
	            var month = padleft0(nowtime.getMonth() + 1);  
	            var day = padleft0(nowtime.getDate());  
				var nowDay = year + "-" + month + "-" + day;
				if ("" == startDay)
				{
					layer.tips('开始日期不能为空', '#startDay');
				}
				else if (!checkTimeLegal(nowDay,startDay))
				{
					layer.tips('开始日期不能小于当前日期', '#startDay');
				}
			}); 
			//结束日期
			$("#endDay").blur(function(){
				var startDay = $("#startDay").val();
				var endDay = $("#endDay").val();
				//未输入结束时间
				if ("" == endDay)
				{
					layer.tips('结束时间不能为空', '#endDay');
					endDayFlag = false;
				}
				else if(!checkTimeLegal(startDay, endDay))
				{
					layer.tips('结束日期不能小于开始日期', '#endDay');
				    endDayFlag = false;
				}	
				else
	            {
					endDayFlag = true;    
	             } 
			}); 
			
			$(".checkbox").on("click",function(){
				var id = $(this).attr("id");
				if($(this).hasClass("fa-check")){
					$(this).removeClass("fa fa-check");
					$(this).parent().parent().find(".time_con").removeAttr("style");
					if(id=="morningCheck")
					{
						$("#amCheck").val("");
					}else if(id=="afternoonCheck")
					{
						$("#pmCheck").val("");
					}
					else if(id=="nightCheck")
					{
						$("#ngCheck").val("");
					}
				}else{
					$(this).addClass("fa fa-check");
					$(this).parent().parent().find(".time_con").show();
					if(id=="morningCheck")
					{
						$("#amCheck").val("amCheck");
					}else if(id=="afternoonCheck")
					{
						$("#pmCheck").val("pmCheck");
					}
					else if(id=="nightCheck")
					{
						$("#ngCheck").val("ngCheck");
					}
				}
			})
			$(".add").on("click",function(){
				var type = $(this).attr("id");
				var startTime = "";
				var endTime = "";
				if(type == "allday")
				{
					startTime = "beginTime";
					endTime = "endTime";
				}
				else if(type == "morning")
				{
					startTime = "morningBegin";
					endTime = "morningEnd";
				}
				else if(type == "afternoon")
				{
					startTime = "afternoonBegin";
					endTime = "afternoonEnd";
				}
				else if(type == "night")
				{
					startTime = "nightBegin";
					endTime = "nightEnd";
				}
				var num=2;
				var httpappend='<tr><td>时间单元<b class="num"></b></td>'
								+'<td><input type="text" name="'+startTime+'" readonly="readonly" class="time form-control"></td>'
								+'<td><input type="text" name="'+endTime+'" readonly="readonly" class="time form-control"></td>'
								+'<td><a href="javascript:;" class="del btn btn-icon-only grey-cascade"><i class="fa fa-minus"></i></a></td></tr>';
				$(this).parent().parent().parent().append(httpappend);
				$('.time').datetimepicker({
					datepicker:false,
					format:'H:i',
					step:5
				});
				addNum();
			})
			$(document).on("click",".del",function(){
				$(this).parent().parent().remove();
				addNum();
			})
			
			$("#save").on("click",function(){
				if (checkForm())
				{
					var d_ = layer.msg('正在保存,请稍候。。。',{icon: 16,time:0,shade:0.3});
					$("#addForm").submit();
				}
			})
		})
		//初始化时间单元后面的数字
		function addNum(){
			$("#allday").parent().parent().parent().find(".num").each(function(i,v){
				$(this).text(i+1);
			});	
			$("#morning").parent().parent().parent().find(".num").each(function(i,v){
				$(this).text(i+1);
			});	
			$("#afternoon").parent().parent().parent().find(".num").each(function(i,v){
				$(this).text(i+1);
			});	
			$("#night").parent().parent().parent().find(".num").each(function(i,v){
				$(this).text(i+1);
			});	
		}
		//补齐两位数  
        function padleft0(obj) {  
            return obj.toString().replace(/^[0-9]{1}$/, "0" + obj);  
        } 
		
		function getnum(){
			var type = $("#typeSel").val();
			if (type == 0)
			{
				$(".quantian").hide();
				$(".fenduan").show();
			}else{
				$(".quantian").show();
				$(".fenduan").hide();
			}
		}
		
		function checkForm()
		{
            //开始时间
			var startDay = $("#startDay").val();
			var nowtime = new Date();  
            var year = nowtime.getFullYear();  
            var month = padleft0(nowtime.getMonth() + 1);  
            var day = padleft0(nowtime.getDate());  
			var nowDay = year + "-" + month + "-" + day;
			if ("" == startDay)
			{
				layer.tips('开始日期不能为空', '#startDay');
				return false;
			}
			else if (!checkTimeLegal(nowDay,startDay))
			{
				layer.tips('开始日期不能小于当前日期', '#startDay');
				return false;
			}
            //结束时间
			var endDay = $("#endDay").val();
			//未输入结束时间
			if ("" == endDay)
			{
				layer.tips('结束时间不能为空', '#endDay');
				return false;
			}
			else if(!checkTimeLegal(startDay, endDay))
			{
				layer.tips('开始时间不能大于结束时间', '#endDay');
			    return false;
			}	
			 if(startDay!=""&&endDay!="")
	           	{
	            	var m=checkSchedule();
	    			if(m.flag=="1"){
	    				layer.tips(m.msg, '#startDay');
	    				return false;
	    			}
	           	}
            var typeSel=$("#typeSel").val();
            if(typeSel==1)
            {
            	   var istime=true;
            	   $("input[name='beginTime']").each(function(){
            		var b=$.trim($(this).val());
            		var e=$.trim($(this).parent().next().find("input[name='endTime']").val());
            		if(b==""){
            			layer.tips("该时间不能为空",$(this));
            			istime=false;
                		return false;
            		}else if(e==""){
            			layer.tips("该时间不能为空",$(this).parent().next().find("input[name='endTime']"));
            			istime=false;
                		return false;	
            		}else if(b!="" && e!=""){
            			b=b.replace(":","");
                    	e=e.replace(":","");
                    	if(parseInt(b)>=parseInt(e)){
                    		layer.tips("开始时间不能晚于结束时间",$(this));
                    		istime=false;
                    		return false;
                    	}	
            		}
                   });
             if(!istime){
           		return false;
           	 }	
            }else if(typeSel==0)
            {
            	var count=0;
            	var length= $(".fenduan").find(".fa-check").length;
            	if(length>0)
           		{
            		 var istime=true;
            		if($(".fenduan #morningCheck").hasClass("fa-check"))
           			{
            			$("input[name='morningBegin']").each(function(){  
            				var b=$.trim($(this).val());
                    		var e=$.trim($(this).parent().next().find("input[name='morningEnd']").val());
                    		if(b==""){
                    			layer.tips("该时间不能为空",$(this));
                    			istime=false;
                        		return false;	
                    		}else if(e==""){
                    			layer.tips("该时间不能为空",$(this).parent().next().find("input[name='morningEnd']"));
                    			istime=false;
                        		return false;	
                    		}else if(b!="" && e!=""){
                    			b=b.replace(":","");
                            	e=e.replace(":","");
                            	if(parseInt(b)>=parseInt(e)){
                            		layer.tips("开始时间不能晚于结束时间",$(this));
                            		istime=false;
                            		return false;
                            	}else{
                            		count++;
                            	}	
                    		}
                        }); 
           			}
            		if($("#afternoonCheck").hasClass("fa-check"))
           			{
            			$("input[name='afternoonBegin']").each(function(){  
            				var b=$.trim($(this).val());
                    		var e=$.trim($(this).parent().next().find("input[name='afternoonEnd']").val());
                    		if(b==""){
                    			layer.tips("该时间不能为空",$(this));
                    			istime=false;
                        		return false;	
                    		}else if(e==""){
                    			layer.tips("该时间不能为空",$(this).parent().next().find("input[name='afternoonEnd']"));
                    			istime=false;
                        		return false;	
                    		}else if(b!="" && e!=""){
                    			b=b.replace(":","");
                            	e=e.replace(":","");
                            	if(parseInt(b)>=parseInt(e)){
                            		layer.tips("开始时间不能晚于结束时间",$(this));
                            		istime=false;
                            		return false;
                            	}else{
                            		count++;
                            	}	
                    		}
                        }); 
           			}
            		if($("#nightCheck").hasClass("fa-check"))
           			{
            			$("input[name='nightBegin']").each(function(){  
            				var b=$.trim($(this).val());
                    		var e=$.trim($(this).parent().next().find("input[name='nightEnd']").val());
                    		if(b==""){
                    			layer.tips("该时间不能为空",$(this));
                    			istime=false;
                        		return false;	
                    		}else if(e==""){
                    			layer.tips("该时间不能为空",$(this).parent().next().find("input[name='nightEnd']"));
                    			istime=false;
                        		return false;	
                    		}else if(b!="" && e!=""){
                    			b=b.replace(":","");
                            	e=e.replace(":","");
                            	if(parseInt(b)>=parseInt(e)){
                            		layer.tips("开始时间不能晚于结束时间",$(this));
                            		istime=false;
                            		return false;
                            	}else{
                            		count++;
                            	}	
                    		}
                        }); 
           			}
            		if(!istime){
            			return false;
            		}else if(count==0){
            			layer.msg("字少选择一个时间段");
            			return false;
            		}
           		}	
            }
	         return true; 
		}
		
		function checkSchedule(){
			var m="";
			var s=$("#startDay").val();
			var e=$("#endDay").val();
			$.ajax({
	            url:"<%=basePath%>schedule/checkScheule.do",
	            type:"post",
	            async: false,
	            dataType:"json",
	            data:{"beginTime":s,"endTime":e},
	            error:function(){},
	            success:function(data){
	               m=data;
             	}
			});
			return m;
		}
		
		function checkTimeLegal(startTime, endTime)
		{

			var flg = false;
			var startDate = new Date(startTime);
			var endDate = new Date(endTime);

			if (startDate > endDate)
			{
				flg = false;
			}
			else
			{
                flg = true
			}	
			return flg;
		}
		
		//验证相关的时间比较
		function checkTime(startTime, endTime) {
			var flg = false;
			if (startTime > endTime || startTime > endTime) {
				flg = false;
			} else {
				flg = true;
			}
			return flg;
		}
		
	</script>
</html>