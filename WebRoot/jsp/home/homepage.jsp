<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
	<title>智慧校园主页</title>
	<%@ include file="/public_module/public_css_new.jsp"%>
	<link rel="stylesheet" href="<%=basePath%>assets/global/plugins/jquery-calendar/css/jquery-calendar.css" />
	<link rel="stylesheet" href="<%=basePath%>assets/global/css/homepage_m.css"/>
</head>
<body>
	<div class="home_header">
		<%@include file="/public_module/header.jsp" %>
	</div>
	<div class="container home_main">
		<div clas="row home_head">
			<div class="col-md-9 col-sm-9 logo">
				<img src="<%=Cons.IMGBASEPATH%>${school.schoolBadge }"><span><em class="Response">欢迎登陆</em>${school.schoolName }<em class="Response">智慧校园</em></span>
			</div>
			<div class="col-md-3 col-sm-3 time">
				<iframe width="280" scrolling="no" height="25" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=34&icon=1&num=3"></iframe>
			</div> 
		</div>
		<div class="row home_row">
			<div class="col-md-8 col-sm-8 col-lg-8">
				<div class="news_show tabbable-line">
					<ul class="nav nav-tabs">
						<li class="col-md-3 col-sm-3 col-lg-3 active"><a href="#tab_3_1" data-toggle="tab">学校简介</a></li>
						<li class="col-md-3 col-sm-3 col-lg-3"><a href="#tab_3_2" data-toggle="tab">学校新闻</a></li>
						<li class="col-md-3 col-sm-3 col-lg-3 m_badge m_position_relative"><a href="#tab_3_3" data-toggle="tab">学校公告</a>
						<c:if test="${not empty announcement.content}">
						<span>1</span>
						</c:if>
						</li>
						<li class="col-md-3 col-sm-3 col-lg-3"><a href="#tab_3_4" data-toggle="tab">校长寄语</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_3_1">
							<div class="row school_aboutus">
								<div class="col-md-3 col-sm-3 col-lg-3">
									<c:choose>
										<c:when test="${school.introductionImg != null && not empty school.introductionImg }">
											<img src="<%=Cons.IMGBASEPATH%>${school.introductionImg}">
										</c:when>
										<c:otherwise>
											<img src="">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="col-md-9 col-sm-9 col-lg-9">
									<h3>学校简介</h3>
									<p>${school.introduction }</p>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab_3_2">
							<div class="row school_news" id="news_">
								 
							</div>
							<div class="pagination m_text_align_conter" style="margin-top:-5px;">
								<!-- <ul>
											<li>
												<a href="javascript:;" onclick="jumpPage('first')" title="首页">
													&laquo; 首页
												</a> 
											</li>
											<li>
												<a href="javascript:;" onclick="jumpPage('previous')" title="上一页">
													上一页
												</a>
											</li>
												
											<li>
												<a>
													<span id="currentPage"></span>/<span id="totalPage"></span>
												</a>
											</li>	
											<li>
												<a href="javascript:;" onclick="jumpPage('next')" title="下一页">
													下一页
												</a>
											</li>
											<li> 
												<a href="javascript:;" onclick="jumpPage('last')" title="末页">
													末页&raquo;
												</a>
											</li>
					
										</ul> -->
							</div>
						<%-- <c:if test="${school.newList != null && fn:length(school.newList) > 0 }">
									<c:forEach items="${school.newList }" var="news">
										 <c:if test="${news.imgPath != null && not empty news.imgPath}">
										<img src="<%=Cons.IMGBASEPATH%>${news.imgPath}">
										</c:if> 
										<h3>新闻介绍</h3>
										<p>${news.content } </p>
										
									</c:forEach>
								</c:if> --%>
						</div>
						<div class="tab-pane" id="tab_3_3">
						
						<h3>校园公告</h3>
						<p>${announcement.content} </p>
						</div>
						<div class="tab-pane" id="tab_3_4">
							<div class="col-md-3 col-sm-3 col-lg-3">
								<c:choose>
								<c:when test="${school.headmasterMottoPhoto != null && not empty school.headmasterMottoPhoto }">
									<img src="<%=Cons.IMGBASEPATH%>${school.headmasterMottoPhoto }">
								</c:when>
								<c:otherwise>
									<img src="">
								</c:otherwise>
							</c:choose>
							</div>
							<div class="col-md-9 col-sm-9 col-lg-9">
								<h3>校长：${school.president }</h3>
								<p>${school.headmasterMotto }</p>
							</div>
						</div>
					</div>

					</div>
			
			</div>
			<div class="col-md-4 col-sm-4 col-lg-4 tool_ul">
			<div class="row margin_buttom_15">
				<div class="platform">
					<a target="_blank" href="<%=resourceBasePath %>user/loginByUuidSchool.do?uuid=${sessionScope.user.uuserId}&schoolId=${sessionScope.user.schoolId}">
						<div class="col-md-3 col-sm-3 col-lg-3"><i class="icon iconfont">&#xe606;</i></div>
						<div class="col-md-9 col-sm-9 col-lg-9 platform_name">资源云平台</div>
					</a>
				</div>
			</div>
			<div class="row margin_buttom_15">
				<div class="platform">
					<a target="_blank" href="http://score.richx.cn/user/doLoginFromCampus.do?param=${sessionScope.user.uuserId}&schoolId=${sessionScope.user.schoolId}">
						<div class="col-md-3 col-sm-3 col-lg-3"><i class="iconfont">&#xe600;</i></div>
						<div class="col-md-9 col-sm-9 col-lg-9 platform_name">成绩云平台</div>
					</a>
				</div>
			</div>
			<div class="row margin_buttom_15">
				<div class="platform">
					<a href="javascript:void(0);">
						<div class="col-md-3 col-sm-3 col-lg-3"><i class="iconfont">&#xe607;</i></div>
						<div class="col-md-9 col-sm-9 col-lg-9 platform_name">E学习平台</div>
					</a>
				</div>
			</div>
			<div class="row margin_buttom_15">
		 	<div class="col-md-6 col-sm-6 col-lg-6 padding_0_7_0_0">
		 		<div class="m_module">
			 		<a href="<%=basePath%>user/enterMain.do?id=mySms" id="h1" target="_self">
			 			<div class="col-md-4 col-sm-4 col-lg-4"><i class="icon iconfont">&#xe604;</i></div>
						<div class="col-md-8 col-sm-8 col-lg-8 m_module_name">我的消息</div>
					</a>
				</div>
		 	</div>
		 	<div class="col-md-6 col-sm-6 col-lg-6 padding_0_0_0_7">
		 		<div class="m_module">
			 		<a href="<%=basePath%>user/enterMain.do?id=abnormal" id="h2">
				 		<div class="col-md-4 col-sm-4 col-lg-4"><i class="icon iconfont">&#xe608;</i></div>
				 		<div class="col-md-8 col-sm-8 col-lg-8 m_module_name">异常报警</div>
					</a>
				</div>
		 	</div>
		 	</div>
			<div class="row margin_buttom_15">
		 	<div class="col-md-6 col-sm-6 col-lg-6 padding_0_7_0_0">
		 		<div class="m_module">
			 		<a href="<%=basePath%>user/enterMain.do?id=auditLeave" id="h1" target="_self">
			 			<div class="col-md-4 col-sm-4 col-lg-4"><i class="icon iconfont">&#xe603;</i></div>
						<div class="col-md-8 col-sm-8 col-lg-8 m_module_name">请假审批</div>
					</a>
				</div>
		 	</div>
		 	<div class="col-md-6 col-sm-6 col-lg-6 padding_0_0_0_7">
		 		<div class="m_module">
			 		<a href="<%=basePath%>user/enterMain.do?id=teachingResources" id="h2">
				 		<div class="col-md-4 col-sm-4 col-lg-4"><i class="icon iconfont">&#xe605;</i></div>
				 		<div class="col-md-8 col-sm-8 col-lg-8 m_module_name">教学资源</div>
					</a>
				</div>
		 	</div>
		 	</div>
		 	<div class="row">
		 	<div class="col-md-6 col-sm-6 col-lg-6 padding_0_7_0_0">
		 		<div class="m_module">
			 		<a href="<%=basePath%>user/enterMain.do?id=meetingDetail" id="h3">
			 			<div class="col-md-4 col-sm-4 col-lg-4"><i class="icon iconfont">&#xe601;</i></div>
						<div class="col-md-8 col-sm-8 col-lg-8 m_module_name">会议通知</div>
					</a>
				</div>
		 	</div>
		 	<div class="col-md-6 col-sm-6 col-lg-6 padding_0_0_0_7">
		 		<div class="m_module">
		 		<a href="<%=basePath%>user/enterMain.do">
		 			<div class="col-md-4 col-sm-4 col-lg-4"><i class="icon iconfont">&#xe602;</i></div>
					<div class="col-md-8 col-sm-8 col-lg-8 m_module_name">进入系统</div>
				</a>
				</div>
		 	</div>
		 	</div>
		 </div>
		</div>
		<div class="row home_row m_padding_25_0_0_0">
			<div class="col-md-8 col-sm-8 col-lg-8">
			<div class="Course">
			<p class="header">课程表</p>
			<c:if test="${curriculumIsNull == 'no' }">
			<table class="table table-striped table-hover table-bordered " style="width:98%;margin:5px auto 0px;" cellspacing="1" cellpadding="0">
				<tr>
					<td class="bg" style="width:8%">阶段</td>
					<td class="bg" style="width:18%">时间</td>
					<td class="bg"  style="width:8%">一</td>
					<td class="bg" style="width:8%">二</td>
					<td class="bg" style="width:8%">三</td>
					<td class="bg" style="width:8%">四</td>
					<td class="bg" style="width:8%">五</td>
					<td class="bg" style="width:8%">六</td>
					<td class="bg" style="width:8%">日</td>
				</tr>

				<c:forEach items="${curriculumMorningTimeList}" var="mt" varStatus="cmt">
                    <c:choose>
                        <c:when test="${cmt.index==0}">
							<tr >
								<td class="bg" rowspan="${fn:length(curriculumMorningTimeList)}" align="center" style=" vertical-align:middle;" valign="middle">上午</td>
								<td class="bg">${mt.beginTime}-${mt.endTime}</td>
								<c:choose>
									 <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 0 }">
									     <c:forEach items="${mt.curriculumList}" var="ms">
											<td>${ms.subjectName}</td>
										  </c:forEach>
									 </c:when>
									 <c:otherwise>
									      <c:forEach items="${weekList}">
											 <td></td>
										  </c:forEach>
									 </c:otherwise>
								</c:choose>
							</tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                             	<td class="bg">${mt.beginTime}-${mt.endTime}</td>
							    <c:choose>
								  <c:when test="${mt.curriculumList!=null && fn:length(mt.curriculumList) > 0 }">
								     <c:forEach items="${mt.curriculumList}" var="ms2">
									<td>${ms2.subjectName}</td>
								  </c:forEach>
								  </c:when>
								  <c:otherwise>
								     <c:forEach items="${weekList}">
									 <td></td>
								  </c:forEach>
								  </c:otherwise>
							    </c:choose>
						    </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                       
                <c:forEach items="${curriculumAfternoonTimeList}" var="at" varStatus="cat">
                    <c:choose>
                        <c:when test="${cat.index==0}">
                            <tr>
								<td colspan="10">休息时间</td>
							</tr>
							<tr>
								<td class="bg" style=" vertical-align:middle;" rowspan="${fn:length(curriculumAfternoonTimeList) }" align="center" valign="middle">下午</td>
								<td class="bg">${at.beginTime}-${at.endTime}</td>
								<c:choose>
								   <c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 0 }">
								      <c:forEach items="${at.curriculumList}" var="as">
										<td>${as.subjectName}</td>
									  </c:forEach>
								   </c:when>
								   <c:otherwise>
								      <c:forEach items="${weekList}">
										 <td></td>
									  </c:forEach>
								   </c:otherwise>
								</c:choose>
							</tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
	                            <td class="bg">${at.beginTime}-${at.endTime}</td>
								<c:choose>
									<c:when test="${at.curriculumList!=null && fn:length(at.curriculumList) > 1 }">
									    <c:forEach items="${at.curriculumList}" var="as2">
											<td>${as2.subjectName}</td>
										</c:forEach>
									</c:when>
									<c:otherwise>
									    <c:forEach items="${weekList}">
										 	<td></td>
										</c:forEach>
									</c:otherwise>
								</c:choose>
                            </tr>
                        </c:otherwise>
                    </c:choose>
			    </c:forEach>
			    
			    <c:forEach items="${curriculumNightTimeList}" var="nt" varStatus="cnt">
					<c:choose>
                        <c:when test="${cnt.index==0}">
                            <tr>
								<td colspan="10">休息时间</td>
							</tr>
							<tr>
								<td class="bg" style=" vertical-align:middle;" rowspan="${fn:length(curriculumNightTimeList)}" align="center" valign="middle">晚上</td>
								<td class="bg">${nt.beginTime}-${nt.endTime}</td>
								<c:choose>
								   <c:when test="${nt.curriculumList!=null && fn:length(nt.curriculumList) > 1 }">
								      <c:forEach items="${nt.curriculumList}" var="ns">
										<td>${ns.subjectName}</td>
									  </c:forEach>
								   </c:when>
								   <c:otherwise>
								      <c:forEach items="${weekList}">
										 <td></td>
									  </c:forEach>
								   </c:otherwise>
								</c:choose>
							</tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                            	<td class="bg">${nt.beginTime}-${nt.endTime}</td>
                            	<c:choose>
								   <c:when test="${nt.curriculumList!=null && fn:length(nt.curriculumList) > 1 }">
								      <c:forEach items="${nt.curriculumList}" var="ns2">
										<td>${ns2.subjectName}</td>
									  </c:forEach>
								   </c:when>
								   <c:otherwise>
								      <c:forEach items="${weekList}">
										 <td></td>
									  </c:forEach>
								   </c:otherwise>
 							    </c:choose>
                            </tr>
                        </c:otherwise>
                    </c:choose>
				</c:forEach>
			</table>
			
			</c:if>
			<c:if test="${curriculumIsNull == 'yes' }">
				<table width="100%" cellspacing="1" cellpadding="0" class="teachtable">
					<tr><td class="bg">阶段</td><td class="bg">一</td><td class="bg">二</td><td class="bg">三</td><td class="bg">四</td><td class="bg">五</td><td class="bg">六</td><td class="bg">日</td></tr>
					<tr><td style=" vertical-align:middle;" align="center" rowspan="4" class="bg">上午</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
	                <tr> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
	                <tr> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
	                <tr> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
	                <tr><td colspan="10">休息时间</td></tr>
					<tr> <td style=" vertical-align:middle;" align="center" rowspan="3" class="bg">下午</td> <td></td> <td></td> <td></td> <td></td><td></td><td></td><td></td></tr>
	                <tr> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
	                <tr> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
	                <tr><td colspan="10">休息时间</td></tr>
					<tr><td style=" vertical-align:middle;" align="center" rowspan="3" class="bg">晚上</td><td></td><td></td><td></td><td></td><td></td> <td></td> <td></td> </tr>
	               	<tr> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
	               	<tr> <td></td> <td></td>  <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
				</table>
			</c:if>
			</div>
			</div>
			<div class="col-md-4 col-sm-4">
				<div class="row">
					<div class="calender">
						<div id="calendar">
						</div>
					</div>
				</div>
			</div>
		 
		</div>
		<div class="row m_margin_25_0_0_0 ContactUs">
			<div class="col-md-4 col-sm-4 col-lg-4">联系电话：<%=tel %></div>
			<div class="col-md-4 col-sm-4 col-lg-4">邮箱：<%=email %></div>
			<div class="col-md-4 col-sm-4 col-lg-4">RICH技术支持QQ:<%=support %></div>
		</div>
	</div>
	<div class="home_footer">
		<%@include file="/public_module/public_footer.jsp" %>
	</div>
	<a href="#static" data-toggle="modal" id="remind" style="display:none;" class=" btn yellow"></a>
	<div class="modal fade" id="static" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-md">
	       <div class="modal-content">
		       	<div class="modal-header">
					 <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                 <h4 class="modal-title">提示</h4>
				</div>
				<div class="modal-body">
					<c:if test="${timeIsNull == 1}">
						<p style="text-align: center;">您学校的作息时间尚未设置，是否前往设置作息时间</p>
					</c:if>
					<c:if test="${timeIsNull == 2}">
						<p style="text-align: center;">您设置的作息时间截至日期为<span style="color:#168ff2;padding:0px 10px;">${scheduleTime}</span>，是否重新添加作息时间</p>
					</c:if>
				</div>
				<div class="modal-footer" style="text-align: center;">
					<button class="btn" data-dismiss="modal" type="button">不了，稍后设置</button>
					<button class="btn" style="background-color:#3aa4f1;color:#fff" data-dismiss="modal" type="button" id="setScheduleTime">立即前往设置</button>
					<input type="hidden" id="timeRemind" value="${timeRemind}">
				</div>
	       </div>
	    </div>
	</div>
</body>
	<%@ include file="/public_module/public_js.jsp"%>
	<script type="text/javascript" src="<%=basePath%>assets/global/plugins/jquery-calendar/js/ui-general.js"></script>    
	<script type="text/javascript" src="<%=basePath%>assets/global/plugins/jquery-calendar/js/jquery-calendar.js"></script> 
	<script type="text/javascript" src="<%=basePath%>assets/global/plugins/jquery-calendar/js/jquery.bootpag.min.js"></script>
	<script type="text/javascript" lang="javascript">
	$(function(){
		var _height=$(window).height()-150;
		$(".home_main").css({"height":_height+"px"});
		if(IsPC()==2){
			$(".app_head").css({"display":"block"});
			$("#h1").attr("href","<%=basePath%>inout/toInoutListByHuxinId.do");
			$("#h2").attr("href","<%=basePath%>leave/toLeaveAppList.do");
			$("#h3").attr("href","<%=basePath%>check/toTeacherCheckListByHuxinId.do");
			$(".server").attr("href","http://www.richx.cn/");
		}else if(IsPC()==3){
			$(".app_head").css({"display":"none"});
			$("#h1").attr("href","<%=basePath%>inout/toInoutListByHuxinId.do");
			$("#h2").attr("href","<%=basePath%>leave/toLeaveAppList.do");
			$("#h3").attr("href","<%=basePath%>check/toTeacherCheckListByHuxinId.do");
			$(".server").attr("href","http://www.richx.cn/");
			}else{
			var timeRemind = $("#timeRemind").val();
			if(timeRemind == 1)
			{
				$("#remind").click();
			}
			
		}
		//新闻奇数去掉margin属性
		$(".school_news .col-md-6 col-sm-6:even").css({"margin-left":"0px"});
		getSchoolIndexNews(1);
	})
	
	var clearmsg = false;
	var ispoint = true;
	function getSchoolIndexNews(cPage){
		$.ajax({
			url:"<%=basePath%>schoolNewsLook/getSchoolIdnexNews.do",
			dataType:"json",
			data:{"newsType":1},//校园新闻
			type:"post",
			error:function(){},
			success:function(page){
				var news='';
			    var list=page;
			    for(var i=0;i<list.length && i<14;i++){
			    	if(i%2==0){
			    		news+='<div class="col-md-6 col-sm-6 m_margin_5_0_0_0" style="margin-left: 0px;">';	
			    	}else{
			    		news+='<div class="col-md-6 col-sm-6 m_margin_5_0_0_0">';	
			    	}
			    	news+='<a  target="_blank" href="<%=basePath%>schoolNewsLook/forwardDetail.do?newsId='+list[i].newsId+'">'+list[i].newsTitle+'</a><em>'+list[i].createTime.substring(0,10)+'</em>';
			    	news+='</div>';
			    }
			    $("#news_").html(news);
				//alert(JSON.stringify(data));
			}
			
		});
	}
	
	function show(obj){
		var data =	obj.value;
		var text = document.getElementById("text");
		if(clearmsg){
			text.value = "";
			clearmsg=false;
		}
		if(data == "+" || data == "-" || data == "*" || data == "/"){
			ispoint = true;
		}
		if(data == "0" && text.value == "0"){
			text.value = parseInt(text.value) + 0;	
		}else if(text.value == "0" && data != "+" && data != "-" && data != "*" && data != "/"){
			text.value = parseInt(text.value) + parseInt(data);
		}else{
			text.value += data;
		}
	}
	function iosBack(){
		window.location.href="ios.jsp";
	}
	function isios(){
		var u = navigator.userAgent;
		//var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
		var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
		return isiOS;
	}

		jQuery(document).ready(function() {       

		   UIGeneral.init();
		   
		   $('#calendar').eCalendar({
				textArrows: {previous: '<', next: '>'},
				eventTitle: 'Eventos',
				url: '',
				events:[
					{title: '标题', description: '哈哈', datetime: new Date(2016, 1, 11, 15)},
					]      
				});

			//点击进入作息时间设置页面
		    $("#setScheduleTime").on("click",function(){
	    		standardPost('<%=basePath%>schedule/toScheduleList.do',{id:scheduleManage});
			})

			if(isios()){
				$("#icon_left").attr("onclick","iosBack();");
			}else{
				$("#icon_left").attr("onclick","window.richbook.onFinish();");
			}
		
		});
		
		$(function(){
			$(".c-event-list").find(".c-event-item").eq(0).show();
			$(".c-grid .c-event").on("mousemove",function(){
				$(".c-event-list").find(".c-event-item").hide();
				$(".c-event-list").find(".c-event-over").show();
			})
			
			

			
		});
		//登出
		function toLoginOut(){
		    $.ajax({
					
				url: "<%=basePath%>user/toLoginOut.do",
	            success: function(data)
	            {
	                var reg = eval("(" + data + ")");
	                if( "true" == reg)
	                {   
	                    window.location.href = "<%=basePath%>login.jsp";
	                }
	            }
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
			
			getSchoolIndexNews(cPageInt);
			$("#currentPage").html(cPageInt);
		}
	</script>
	</html>