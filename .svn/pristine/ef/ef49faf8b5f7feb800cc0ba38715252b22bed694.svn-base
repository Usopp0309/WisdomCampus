<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%> 
<head>
	<title>蓝牙手环搜索条件</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
	<style type="text/css">
	 /*  .header{
	      background-color: #168ff2;
          height: 50px;
          line-height: 50px;
          width: 100%;
          font-size: 20px;
          top: 0px;
          left: 0px;
          text-align: center;
          color: #fff;
       } */
	 .margin{
	 	margin-top: 0px !important;
	 }
	 .condition{background-color:rgb(54,197,213);height:40px;line-height:40px;width:100%;font-size:16px;text-align:center;color:#fff;}
	 .form_list{margin:5%;}
	 .form_sel{width:70%;height:30px;line-height:30px;background:none;border-radius:5px;padding:5px;border:1px solid #f2f2f2;}
   
   
  
  
 
	 
	</style>
</head>
<body>
        <!--   <div class="header">
		    <i class="m_icon-return icon_left" ></i>蓝牙手环
	      </div> -->
	         
			              <div class="condition">
						      <span>搜索</span> 
					      </div>
					      
	                   <div class="container">
					               
	                              <div class="form_list">
	                                 <span>课程类型：</span>
	                                 <select id="courseType" class="form_sel">
			                                  <option>体育</option>
			                                  <option>英语</option>
			                                  <option>高数</option>
			                                  <option>物理</option>
                                    </select>
	                              </div>
	                              
	                              <div class="form_list">
	                                <span>选择班级：</span>
	                                <select id="selClass" class="form_sel">
			                                  <option>12班</option>
			                                  <option>10班</option>
			                                  <option>11班</option>
			                                  <option>13班</option>
                                    </select>
	                              </div>
	                              
	                              <div class="form_list">
	                              	<span>搜索内容：</span>
	                                <input type="text" id="selContent" class="form_sel"/>
	                              </div>
	                              
	                               <div class="form_list">
	                                <span>开始时间：</span>
	                                <input type="text" id="startTime" class="form_sel">
	                               </div>
	                               
	                               <div class="form_list">
	                                <span>结束时间：</span>
	                                <input type="text" id="endTime"  class="form_sel">
	                               </div>
	                             
	                              <div class="form_list">
	                                   <button type="button" class="btn btn-success">搜索</button>
					             </div>
                             
                            </div> 
	       
	       
	            
		
</body>
  <!--公共js开始-->
  <%@ include file="/public_module/app_public_js.jsp"%>
  <!--公共js结束-->
  <script type="text/javascript">
  $(function () {  
	  var currYear = (new Date()).getFullYear();  
	  var opt={}; 
	  opt.date = {preset : 'date'};  
	  opt.datetime = {preset : 'datetime'};  
	  opt.time = {preset : 'time'};  
	  opt.default = {  
			  theme: 'android-ics light', //皮肤样式  
	          display: 'modal', //显示方式  
	          mode: 'scroller', //日期选择模式  
	          dateFormat: 'yyyy-mm-dd',  
	          dateOrder: 'yymmdd', //面板中日期排列格式  
		      timeFormat: 'hh:ii:ss',  
		      timeOrder: 'hhiiss',  
		      lang: 'zh',  
		      showNow: true,  
		      nowText: "今天",  
		      startYear: currYear - 10, //开始年份  
		      endYear: currYear + 10 //结束年份  
		    };   
	  var optDateTime = $.extend(opt['datetime'], opt['default']);  
	  $("#startTime").mobiscroll(optDateTime).datetime(optDateTime);  
	  $("#endTime").mobiscroll(optDateTime).datetime(optDateTime);  }
	  ); 
   
  </script>
    
</html>