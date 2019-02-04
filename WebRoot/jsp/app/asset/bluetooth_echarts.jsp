<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%> 
<head>
	<title>蓝牙手环图表</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
	<style type="text/css">
	 /*  .header{ background-color:#168ff2;height:50px;line-height:50px;width:100%;font-size:20px;text-align:center;color:#fff;} */
	  .condition{background-color:rgb(54,197,213);height: 30px;line-height: 30px;width:100%;font-size: 14px;text-align:left;color:#fff;}
      .margin{margin-top: 0px !important;}
      .container ul{width:65%;margin: 0 auto;}
      .container ul li{border:1px solid #f1f1f1;height:190px;margin:2%;}
      .right_menu{float:right;margin-top:5%;}
      .right_menu ul li{width:40px;height:40px;line-height:40px;text-align:center;}
	</style>
</head>
<body>
		         <!--  <div class="header">
				    <i class="m_icon-return icon_left" ></i>蓝牙手环
			      </div> -->
		          <div class="condition">
				            <span style="margin-left:5%;">个人情况</span>
			      </div>
			      
			         <div class="right_menu">
	                      <ul class="menu_list">
							<li><span class="glyphicon glyphicon-plus" onclick="search();"></span></li>
							<li><span class="glyphicon glyphicon-book" onclick="moreCourse();"></span></li>
							<li><span class="glyphicon glyphicon-sort" onclick="compare();"></span></li>
						</ul>
                    </div>  
			      
			        <div class="container">
	                      <ul class="container_list">
							<li></li>
							<li></li>
							<li></li>
                         </ul>
                    </div>  
			      
	                     
                       
 		
</body>
  <!--公共js开始-->
  <%@ include file="/public_module/app_public_js.jsp"%>
  <!--公共js结束--> 
  <script type="text/javascript">
       function search(){

    	   window.location.href="<%=basePath%>jsp/app/asset/bluetooth_search.jsp";
       }
       function moreCourse(){

    	   window.location.href="<%=basePath%>jsp/app/asset/bluetooth_app.jsp";
       }
       function compare(){

    	   window.location.href="<%=basePath%>jsp/app/asset/bluetooth_app.jsp";
       }
   </script>
           
</html>