<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%> 
<head>
	<title>蓝牙手环更多课程</title>
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
	 .app_table_head tr{background:rgb(53,198,212);}
	 #search{float: left;padding-left:10%;}
	 table {color:rgb(153,153,153);}
	.app_table .app_table_head tr{font-size:14px;}
	#tbody tr td nth-child(6){color:rgb(153,153,153);} 
	.table-striped>tbody>tr:nth-of-type(even) {background-color: rgb(238,238,238) !important;};
  
	</style>
</head>
<body>
              
     <!--     <div class="header">
		    <i class="m_icon-return icon_left" ></i>蓝牙手环
	      </div> -->
	          <table class="app_table table-striped margin">
	                     <thead class="app_table_head">
	                                  <tr>
	                                     <th style="width:3%;"><span onclick="search();" id="search">+</span><span>时间</span></th>
	                                     <th style="width:1%;">类型</th>
	                                     <th style="width:1%;">地址</th>
	                                     <th style="width:1%;">编号</th>
	                                     <th style="width:1%;">状态</th>
	                                     <th style="width:1%;">张三&nbsp;&nbsp;123</th>
	                                 </tr>
	                     </thead>
	                       <tbody  class="app_table_body" id="tbody">
	                           <tr>
						           	<td>2017-05-04 13:00:00</td>
									<td>体育</td>
									<td>454</td>
									<td>565</td>
									<td>使用</td>
									<td onclick="look();">查看</td> 
	                          </tr>
	                           <tr>
						           	<td>2017-05-04 13:00:00</td>
									<td>英语</td>
									<td>545</td>
									<td>545</td>
									<td>使用</td>
									<td onclick="look();">查看</td> 
	                          </tr>
	                           <tr>
						           	<td>2017-05-04 13:00:00</td>
									<td>高数</td>
									<td>454</td>
									<td>565</td>
									<td>使用</td>
									<td onclick="look();">查看</td> 
	                          </tr>
	                           <tr>
						           	<td>2017-05-04 13:00:00</td>
									<td>物理</td>
									<td>545</td>
									<td>545</td>
									<td>使用</td>
									<td onclick="look();">查看</td> 
	                          </tr>
	                           <tr>
						           	<td>2017-05-04 13:00:00</td>
									<td>化学</td>
									<td>454</td>
									<td>565</td>
									<td>使用</td>
									<td onclick="look();">查看</td> 
	                          </tr>
	                    </tbody>
	           </table>
	        
 		
</body>
           <!--公共js开始-->
          <%@ include file="/public_module/app_public_js.jsp"%>
	      <!--公共js结束--> 
	
   <script type="text/javascript">
       function look(){
    	   window.location.href="<%=basePath%>jsp/app/asset/bluetooth_echarts.jsp";
       }

       //进入到查询条件页面
       function search(){

    	   window.location.href="<%=basePath%>jsp/app/asset/bluetooth_search.jsp";
       }
  

   </script>

</html>