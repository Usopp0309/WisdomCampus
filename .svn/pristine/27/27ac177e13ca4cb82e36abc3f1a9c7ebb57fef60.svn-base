<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>蓝牙手环</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<!--公共css开始-->
<%@ include file="/public_module/public_css_new.jsp"%>
<script type="text/javascript" src="<%=basePath%>assets/global/plugins/echarts.js"></script>
<!--公共css结束-->
<style type="text/css">
.personInClass_condition {
	width:1200px;
	height:900px;
	border: 1px solid #28acb8;
}
</style>
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed"
	id="body">
	<input class="themes" type="hidden" value="<%=ThemePath%>">
	<input type="hidden" value="${schoolId}" id="schoolId">
	<input type="hidden" value="${sessionScope.user.userId}" id="userId">
	<!-- 公共顶部开始-->
	<%@ include file="/public_module/public_header.jsp"%>
	<!--公共顶部结束-->
	<div class="clearfix"></div>
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
							<li><a href="<%=basePath%>user/enterMain.do">首页</a><i
								class="fa fa-circle"></i></li>
							<li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i
								class="fa fa-circle"></i></li>
							<li><span>蓝牙手环</span></li>
						</ul>
					</div>
                   <h3 class="page-title">蓝牙手环</h3>
					<div class="portlet box green m_margin_15_auto_0">
					<div class="portlet light form-fit m_margin_0_0_15_0">
								<a
									class="btn btn-default"
									href="javascript:void(0);" onclick="history.go(-1);">返回</a>
							</div>
							<div class="portlet box green m_margin_15_auto_0">

								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-list"></i>个人和别人对比情况
									</div>
								</div>
							</div>
						<!-- 图标区域-->
						<div class="portlet-body flip-scroll">
								<table class="table table-hover table-bordered table-condensed"
									cellpadding="0" cellspacing="0">
							<thead><tr>
							<th align="center">${courseName}</th></tr>
							</thead><tbody><tr><td>
						<div class="portlet light form-fit m_margin_0_0_15_0 echars">
							<ul class="condition">
								<li><div class="class_condition">
								 <div style="height:300px;width:1200px;" id="clazz_steps"></div>
								 <div style="height:300px;width:1200px;" id="clazz_heartRate"></div>
								 <div style="height:300px;width:1200px;" id="clazz_calorie"></div>
								</div></li>
							</ul>
						</div></td>
						</tr></tbody>
						</table>
						</div>
						<!-- 底部开始 -->
						<%@ include file="/public_module/public_footer.jsp"%>
						<!-- 底部结束 -->
</body>
<!-- 公共js开始 -->
<%@ include file="/public_module/public_js.jsp"%>
<script src="<%=basePath%>assets/global/plugins/map.js"
	type="text/javascript"></script>
<!-- 公共js结束 -->
<script type="text/javascript">
        $(function(){
        	loadSubMenu("assetManagement");  
    		//选取当前菜单位置
    		setActive("assetManagement","braceletStatistics");      
    	 $('#startTime,#endTime').datetimepicker({
			 format:"Y-m-d H:i:00" 
		});
    	 initData();
    });
        function initData(){
        	var data1=eval(${listUser1});
        	var data2=eval(${listUser2});
        	var userName1="";
        	var userName2="";
        	
        	var steps1=[];
			var heartRate1=[];
			var calorie1=[];
			
        	var steps2=[];
			var heartRate2=[];
			var calorie2=[];
			
			var xAxis=[];
        	if(data1!='' && data1.length>0){
        		for(var i=0;i<data1.length;i++){
        			steps1.push(data1[i].steps);
        			heartRate1.push(data1[i].heartRate);
        			calorie1.push(data1[i].calorie);
        			userName1=data1[i].realName;
        			xAxis.push(data1[i].dataTime.substring(11,16));
        		}
        	}
        	if(data2!='' && data2.length>0){
        		for(var i=0;i<data2.length;i++){
        			steps2.push(data2[i].steps);
        			heartRate2.push(data2[i].heartRate);
        			calorie2.push(data2[i].calorie);
        			userName2=data2[i].realName;
        		}
        	}
        	//个人和班级情况
			var series=[{name:'步数('+userName1+')', type:'line', data:steps1},
			        {name:'步数('+userName2+')', type:'line', data:steps2}];
			myChart = echarts.init(document.getElementById('clazz_steps'));
			initEchart(['步数('+userName1+')','步数('+userName2+')'],series,'步数数据',myChart,xAxis);
			
			series=[{name:'心跳('+userName1+')', type:'line', data:heartRate1},
			        {name:'心跳('+userName2+')', type:'line', data:heartRate2}];
			myChart = echarts.init(document.getElementById('clazz_heartRate'));
			initEchart(['心跳('+userName1+')','心跳('+userName2+')'],series,'心跳数据',myChart,xAxis);
			
			series=[{name:'卡路里('+userName1+')', type:'line', data:calorie1},
			        {name:'卡路里('+userName2+')', type:'line', data:calorie2}];
			myChart = echarts.init(document.getElementById('clazz_calorie'));
			initEchart(['卡路里('+userName1+')','卡路里('+userName2+')'],series,'卡路里数据',myChart,xAxis);
        	
        }
        //个人数据
        function initEchart(datas,series,title,myChart,xAxis){
         	 // 指定图表的配置项和数据
     	    var option = {
     	    	    title : {
     	    	        text: title,
     	    	        subtext: ''
     	    	    },
     	    	    tooltip : {
     	    	        trigger: 'axis'
     	    	    },
     	    	    legend: {
     	    	        data:datas
     	    	    },
     	    	    toolbox: {
     	    	        show : true,
     	    	        feature : {
     	    	            dataView : {show: false, readOnly: false},
     	    	            magicType : {show: true, type: ['line', 'bar']},
     	    	            restore : {show: false},
     	    	            saveAsImage : {show: true}
     	    	        }
     	    	    },
     	    	    calculable : true,
     	    	    xAxis : [
     	    	        {
     	    	            type : 'category',
     	    	            data:xAxis,
     	    	            axisLabel: {
     	    	            	rotate:330,
     	    	            	}
     	    	        }
     	    	    ],
     	    	    yAxis : [
     	    	        {
     	    	            type : 'value'
     	    	        }
     	    	    ],
     	    	    series : series
     	    	};

     	    // 使用刚指定的配置项和数据显示图表。
     	    myChart.setOption(option);	
        }
    </script>
</html>