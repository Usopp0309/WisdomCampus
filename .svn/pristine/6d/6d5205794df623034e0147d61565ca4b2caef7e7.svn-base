<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>会议刷卡记录</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <style type="text/css">
    .ad_time{position:fixed;bottom:1%;right:1%;width:30px;height:30px;line-height:30px;border-radius:50%;background:rgb(246,173,70);}
     .ad_time span{ font-weight:bold; color:#fff; padding:0 10px;}
      .ad_box{width:300px;height:200px;position: fixed;right:0; bottom:0;border: 1px solid rgb(53,196,212);border-radius:20px;border-top:20px solid rgb(53,196,212) !important;"}
      
   </style>
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
                            <li><a href="">会议管理</a><i class="fa fa-circle"></i></li>
                            <li><span>会议刷卡记录</span></li>
                        </ul>
                    </div>
                    <h3 class="page-title">会议刷卡记录</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                        	<div class="m_margin_0_0_15_0">
                        		<!-- 角色切换开始 -->
                        		<ul class="nav nav-tabs" id="userTab">
                                    <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
											<li class="roleLi">
												<a data-toggle="tab" class="roleTab" attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})</a>
											</li>
										</c:if>
									</c:forEach>
                                </ul>
                        		<!-- 角色切换结束 -->
                            </div>
                            <!-- 页面搜索开始 -->
                            <div class="portlet light form-fit bordered search_box">
                            	
	                            <div class="row m_margin_10_auto">

	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<span id="tchStuTypeLabel" class="m_span">出席状态:</span>
	                            		<select class="form-control m_select" id="status">
											<option selected="selected">--全部--</option>
											<option value="0">正常出勤</option>
											<option value="1">迟到</option>
										</select>
	                            	</div>
	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<span id="tchStuTypeLabel" class="m_span">签到类型:</span>
	                            		<select class="form-control m_select" id="inoutType">
											<option value="0">刷卡</option>
											<option value="1">wifi</option>
										</select>
										<input type="text" style="display: none;" id="hideType" value="${inoutType }" />
	                            	</div>

									<input type="text" style="display: none;" id="hideType" value="${inoutType }" />
									
	                            	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                            		<span class="m_span">会议名称:</span>
										<input type="text" placeholder="刷卡人、会议名称……" class="m_input form-control" id="queryContent" value="${queryContent }"/>
	                            	</div>
	                            
		                            <div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
		                            	<button type="button"  id="search" class="btn design_btn">确定</button>
<!-- 		                            	<button type="button"  id="phoneInout" class="btn green">手机签到</button> -->
		                            </div>
	                            </div>
                            </div>
                           	<div class="portlet box green m_margin_15_auto_0">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-list"></i>会议刷卡记录</div>
                                </div>
                                <div class="portlet-body flip-scroll">
                                    <table class="table table-bordered table-hover" id="meetingList">
                                        <thead class="flip-content">
                                            <tr>
                                               <th>会议名称</th><th>参会人</th><th>出席状态</th><th>地点(WIFI名称)</th><th>(签到WIFI)刷卡时间</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                           <!-- 列表展现开始 -->
                            <!-- 分页开始 -->
                            <%@include file="/public_module/public_page.jsp" %>
                            <!-- 分页结束 -->
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
        
         <!-- 右下角倒计时广告 -->
           <div class="ad_box" style="display: none">
                <!-- 要添加的广告内容 -->
               
                <div class="ad_box_content" style="position: relative; top:25%;">
                        <p>
                           <img src="<%=basePath%>/assets/global/img/sign_success.png"/>
                           <span style="color:rgb(77,77,77);font-size:24px;">签到成功</span>
                        </p>
                        <p style="color:rgb(77,77,77);margin-top:10px;" id="dialogContent"></p> 
                </div>

                <div class="ad_time">
                    <span id="t">3</span>
                </div>
             
            </div>  
        <!-- 底部开始 -->
        <%@ include file="/public_module/public_footer.jsp" %>
        <!-- 底部结束 -->
    </body>
        <!-- 公共js开始 -->
        <%@ include file="/public_module/public_js.jsp" %>
        <!-- 公共js结束 -->
	<script>
/*websocket开始*/
	var currentUserId = ${userId};
	var schoolId=${schoolId};
	var wsServer = 'ws://${serverName}:9350'; 
	var webSocket = null;
	  if (!window.WebSocket){
	    alert("你的浏览器不支持websocket，请升级到IE10以上浏览器，或者使用谷歌、火狐、360浏览器。");
	  }
	  webSocket = new WebSocket(wsServer);
	  webSocket.onerror = function(event) {
	    alert("websockt连接发生错误，请刷新页面重试!")
	  };
	// 连接成功建立的回调方法
	  webSocket.onopen = function(event) {
	    webSocket.send("_online_user_"+currentUserId+"&&"+schoolId);
	  };
	// 接收到消息的回调方法
	  webSocket.onmessage = function(event) {
	    var res=event.data;
	    if(res.indexOf("_msg_")>=0){
	    	var arra = res.split("_msg_");
	    	//提示签到成功，并且更新页面状态
	    	$("#dialogContent").html(arra[1]);
	    	$('.ad_box').show();
           // $('.ad_time').animate({width:110,height:30},'slow');`
            lxfEndtime();
 	    	loadMeetingInoutList(currentUserId,null, null);
	    }
	  };
	//切换在线状态的方法
	  function setonline() {
		webSocket.send("_online_user_"+currentUserId+"&&"+schoolId);
	  };
	//切换离线状态的方法
	  function sethide() {
		webSocket.send("_leave_user_"+currentUserId+"&&"+schoolId);
	  };
/*websocket结束*/
 		
 		//右下角弹框倒计时
         function lxfEndtime(){
             $t=$('#t').html();
             if($t!=0){
                 $('#t').html($t-1);
                 $i=setTimeout("lxfEndtime()",1000);
             }else{
                 $('.ad_box').hide();
                // $('.ad_time').css({'width':'554px','height':'351px'});
                 clearTimeout($i);
             }
         }
	
		jQuery(document).ready(function() {  

			$('#startTime,#endTime').datetimepicker({
				format:"Y-m-d H:i" 
			});
			//页面初始化时候的数据加载
			var userId = $("ul li.active").find('a').attr("attr1");
			var roleCode = $("ul li.active").find('a').attr("attr2");
			//二级菜单显示
			loadSubMenu("meetingManager");
			//选取当前菜单位置
			setActive("meetingManager","meetingInout");
			$("#inoutType").val($("#hideType").val());
			//加载初始化数据   
			loadMeetingInoutList(userId, roleCode, null);
			//选择第一个tab
			//点击tab页加载
			$(".roleTab").click(function(){
				//用户ID
				var userId = $(this).attr("attr1");
				var roleCode = $(this).attr("attr2");
				loadMeetingInoutList(userId, roleCode, null);
				
				//初始化select
				$("#status").val('3');
				
			});
			
			//查找数据
			$("#search").click(function(){

				//用户ID
				var userId = $("#userTab li.active").find('a').attr("attr1");	
				var roleCode = $("#userTab li.active").find('a').attr("attr2");
				var inoutType = $("#inoutType").val();
				loadMeetingInoutList(userId, roleCode, null);
			});
			
			$("#queryContent").keypress(function(event){
				if(event.which == "13")    
            	{
					$("#search").click();
					return false;
            	}
			});
			
			//导出数据
			$("#export").click(function(){
				//开始时间
				var startTime = $("#startTime").val();
				//结束时间
				var endTime = $("#endTime").val();
				//查询内容
				var queryContent = encodeURI(encodeURI($("#queryContent").val())) ;
				
				//师生类型
				var type = $("#tchStuType").val();
				//进出类型
				var inoutType = $("#inoutType").val();
				
				//用户ID
				var userId = $("ul li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("ul li.active").find('a').attr("attr2");
				standardPost('<%=basePath%>inout/doExportExcel.do',{userId:userId,roleCode:roleCode,type:type,inoutType:inoutType,queryContent:queryContent,startTime:startTime,endTime:endTime});
				});
			
		});

		

        //加载进出记录列表
		function loadMeetingInoutList(userId, roleCode, cPage)
		{
			//开始时间
			var startTime = $("#startTime").val();
			//结束时间
			var endTime = $("#endTime").val();
			var queryContent = $("#queryContent").val();
			var status = $("#status").val();
			var inoutType = $("#inoutType").val();
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>meetingInout/loadMeetingInoutList.do",
				data:{
						startTime : startTime,
						endTime : endTime,
						queryContent : queryContent, 
						status : status,
						userId : userId,
						roleCode : roleCode,
						cPage : cPage,
						inoutType  : inoutType
					},
				success: function(data){
					var page = eval("(" + data + ")");
					$("#currentPage").html(page.currentPage);
					$("#totalPage").html(page.totalPage);
					var appendHtml = '';
					$.each(page.list, function(n, value) {  
						
						appendHtml += '<tr>';
           				//会议名称
           				appendHtml += '<td width="20%">' + value.meetingName + '</td>';
						//卡号
//            			appendHtml += '<td width="15%" class="hidden-sm hidden-md">' + value.code + '</td>';
						//拥有着
           				appendHtml += '<td width="15%">' + value.realName + '</td>';
						//出勤状态
           				var status = parseInt(value.status);
           				switch(status)
           				{ 
           					case 0 : 
           						appendHtml += '<td width="15%"><span class="normal">正常</span></td>';
           						break; 
           					case 1 : 
           						appendHtml += '<td width="15%"><span class="unnormal">迟到</span></td>';
           						break; 
           					default : 
           						appendHtml += '<td width="15%"><span class="unnormal">其他</span></td>';
           						break;
           				}
           				
						//地点
           				appendHtml += '<td width="15%">' + value.positionName + '</td>';
						//创建时间
           				var time = value.createTime;
						if (typeof(time)=="undefined"){
							time = "";
						}else{
							time = time.substr(0, time.length-2)
						}
           				appendHtml += '<td width="20%">' + time + '</td>';
           				appendHtml += '</tr>';
          			}); 
          			
          			$("#tbody").html(appendHtml);
          			$("#inoutType").val(inoutType);
          			//解锁UI
          			App.unblockUI(body);
				},
			});
		}

		//分页相关
		function jumpPage(type)
		{
			var cPage = $("#currentPage").html();
			var totalPage = $("#totalPage").html();

			var cPageInt = parseInt(cPage);
			var totalPageInt = parseInt(totalPage);
						
			var newCPageInt = returnCPageInt(type,cPageInt,totalPageInt);
			if(newCPageInt < 0){
				return;
			}else{
				cPageInt = newCPageInt;
			}
				//用户ID
				var userId = $("ul li.active").find('a').attr("attr1");
				//角色ID
				var roleCode = $("ul li.active").find('a').attr("attr2");
				
				loadMeetingInoutList(userId, roleCode, cPageInt)
			
			$("#currentPage").html(cPageInt);
		}		
	</script>
</html>