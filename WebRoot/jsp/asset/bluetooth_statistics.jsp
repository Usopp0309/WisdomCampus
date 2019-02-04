<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>蓝牙手环-历史记录</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <script type="text/javascript" src="<%=basePath%>assets/global/plugins/echarts.js"></script>
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
		<input class="themes" type="hidden" value="<%=ThemePath%>">
		<input type="hidden" value="${schoolId}" id="schoolId">
	<input type="hidden" value="${sessionScope.user.userId}" id="userId">
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
	            	<div class="col-md-12 col-sm-12 m_page_con" id="content">
	                <div class="page-bar m_margin_0_0_0_0">
	                    <ul class="page-breadcrumb">
	                        <li><a href="<%=basePath%>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>数据统计</span></li>
	                    </ul>
	                </div>
	                <div class="portlet box green m_margin_15_auto_0">
	                    <div class="portlet-title">
		                           <div class="caption">
		                             <i class="fa fa-list"></i>数据统计
		                           </div>
		                      </div>
	                       <div class="portlet-body">
	                          <div class="portlet light form-fit bordered search_box">
	                         	<form action="#" class="form-horizontal">
				                         <div class="row m_margin_10_auto">
				
				                         	<div class="col-lg-3 m_margin_top-15" style="width: 20%;">
				                         		<span class="m_span">日期：</span>
				                         		 <input class="m_input form-control" type="text" id="startTime"/>
				                         	</div>
				                         	<div class="col-lg-3 m_margin_top-15" style="width: 20%;">
				                         		<span class="m_span">选择班级：</span>
				                                <select class="form-control m_select" id="clazzList" onchange="chooseClazz();"></select>
				                         	</div>
				                         	
				                         	<div class="col-lg-3 m_margin_top-15" style="width: 20%;">
				                         		<span class="m_span">选择学生：</span>
				                                <select class="form-control m_select" id="studentLists" onchange="initStatistics();">
				                                <option value="">--请选择学生--</option>
				                                </select>
				                         	</div>
				                         	
				                         	<div class="col-lg-3 m_margin_top-15">
				                         		<button type="button" class="btn green" onclick="initStatistics();">查找</button>
				                         	</div>
				                         </div>
	                              </form>
	                        </div>   
	                      </div>
	                       <div style="width: 1000px;height: 500px;overflow-x: auto;" id="main" >
	                       
	                       </div>
	                              </div>
	                          </div>
	                    </div>
	               </div>
	    <!-- 底部开始 -->
	    <%@ include file="/public_module/public_footer.jsp" %>
	     <script src="<%=basePath%>assets/global/plugins/map.js" type="text/javascript" ></script>
	    <!-- 底部结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <script src="<%=basePath%>assets/global/plugins/map.js" type="text/javascript" ></script>
    <!-- 公共js结束 -->
    <script type="text/javascript">
    var clazzUserMap=new Map();
    $(function(){
    	loadSubMenu("assetManagement");  
		//选取当前菜单位置
		setActive("assetManagement","bluetoothList"); 
		$('#startTime').datetimepicker({
			format:'Y-m-d',
			timepicker:false
		});
		var myDate=new Date();
		var m=myDate.getMonth()+1;
		var d=myDate.getDate();
		m=m<10?"0"+m:m;
		d=d<10?"0"+d:d;
		$("#startTime").val(myDate.getFullYear()+"-"+m+"-"+d);
		initClazz();
// 		initStatistics();
		
    });
    //图表数据
    function initStatistics(){
    	var studentLists=$("#studentLists").val();
    	var clazzList=$("#clazzList").val();
    	var startTime=$("#startTime").val();
    	$("#main").html("");
    	if(startTime==""){
    		layer.tips("请选择日期",$("#clazzList"));
    		return;
    	}else if(clazzList==""){
    		layer.tips("请选择班级",$("#clazzList"));
    		return;	
    	}else if(studentLists==""){
    		layer.tips("请选择学生",$("#studentLists"));
    		return;
    	}
       	$.ajax({
    			type: "post",
    			url: "<%=basePath%>data/getStatistics.do",
    			dataType:"json",
    			data:{
    				    userId :studentLists,
    				    clazzId : clazzList,
    					startTime:startTime
    				},
    			success: function(data){
    				//dataTime
    				//xAxis,series_steps,series_heartRate,series_calorie
    				var xAxis=[];
    				var series_steps=[];
    				var series_heartRate=[];
    				var series_calorie=[];
    				if(data!=null && data.length>0){
    					for(var i=0;i<data.length;i++){
    						xAxis.push(data[i].dataTime.substring(11));	
    						series_steps.push(data[i].steps);	
    						series_heartRate.push(data[i].heartRate);	
    						series_calorie.push(data[i].calorie);	
        				}	
    					initImg(xAxis,series_steps,series_heartRate,series_calorie);
    				}
    				
    				
    			}
    		});
    	
    }
    //获得班级
    function initClazz(){
   	var userId=$("#userId").val();
   	$.ajax({
			type: "post",
			url: "<%=basePath%>sms/getAllStudentList.do",
			dataType:"json",
			data:{
					userId :userId,
					permissionCode : "studentMessageManager"
				},
			success: function(data){
				var clazzList =data.clazzList;
				var appendHtml = '<option value="">--请选择班级--</option>';
				$.each(clazzList, function(n, value) {
					appendHtml += '<option value="' + value.id + '">' + value.clazzName + '</option>';
      			});  
      			$("#clazzList").html(appendHtml);
      			clazzUser(clazzList,data.studentList);
			}
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
    function chooseClazz(){
    	$("#main").html("");
    	var clazz=$("#clazzList").val();
    	var userList=clazzUserMap.get(clazz);
    	if(userList){
    		var html='';
    		html+='<option value="">--请选择学生--</option>';
    		for(var i=0;i<userList.length;i++){
    			html+='<option value="'+userList[i].userId+'">'+userList[i].realName+'</option>';
    		}
    		$("#studentLists").html(html);
    	}
    }
    function initImg(xAxis,series_steps,series_heartRate,series_calorie){
    	  $("#main").css({"width":$("#content").width()});
    	 var myChart = echarts.init(document.getElementById('main'));
    	 // 指定图表的配置项和数据
	    var option = {
	    	    title : {
	    	        text: '蓝牙手环数据统计',
	    	        subtext: ''
	    	    },
	    	    tooltip : {
	    	        trigger: 'axis'
	    	    },
	    	    legend: {
	    	        data:['步数','心率','卡路里']
	    	    },
	    	    toolbox: {
	    	        show : true,
	    	        feature : {
	    	            dataView : {show: true, readOnly: false},
	    	            magicType : {show: true, type: ['line', 'bar']},
	    	            restore : {show: true},
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
	    	    series : [
	    	        {
	    	            name:'步数',
	    	            type:'line',
	    	            data:series_steps
	    	        },
	    	        {
	    	            name:'心率',
	    	            type:'line',
	    	            data:series_heartRate
	    	        },
	    	        {
	    	            name:'卡路里',
	    	            type:'line',
	    	            data:series_calorie
	    	        }
	    	    ]
	    	};

	    // 使用刚指定的配置项和数据显示图表。
	    myChart.setOption(option);
    }
	   
    </script>
</html>