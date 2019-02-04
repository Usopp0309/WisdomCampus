<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>成长档案-阶段</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->
 	<script type="text/javascript">
function addDate(month,months){ 
	var d=new Date(month); 
	d.setMonth(d.getMonth()+months); 
	var month=d.getMonth()+1; 
	var day = d.getDate(); 
	if(month<10){ 
		month = "0"+month; 
	} 
	if(day<10){ 
		day = "0"+day; 
	} 
	var val = d.getFullYear()+""+month+""+day;
	var getDate = new Date(Date.parse(val.substring(0,4)+"-"+val.substring(4,6)+"-"+val.substring(6,8)));
	return getDate; 
}
Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 
	if(/(y+)/.test(format)) { 
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 
	for(var k in o) { 
		if(new RegExp("("+ k +")").test(format)) { 
			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
		} 
	} 
	return format; 
}  
function strToDate(str) {
	 var setDate = str.substring(0,4)+"-"+str.substring(4,6)+"-";
	 if(str.length>6){
		 setDate += str.substring(6,8);
	 }else{
		 setDate +="00";
	 }
	 var date = new Date(Date.parse(setDate));
	 return date;
}
</script>        
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
		<input class="themes" type="hidden" value="<%=ThemePath%>">
		<%
			String list = (String)request.getAttribute("list");
		%>
		<input type="hidden" id="userId" value="${userId }" />
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
	                        <li><a href="">电子动力成长档案</a><i class="fa fa-circle"></i></li>
	                        <li><span>成长档案-阶段</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">成长档案-阶段</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode eq 'admin' || roleList.roleCode eq 'chairman'|| roleList.roleCode eq 'president' || roleList.roleCode eq 'teacher' || roleList.roleCode eq 'parent'}">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" >${sessionScope.user.realName}(${roleList.roleName})
												</a>
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
	                         		<span class="m_span">幼儿名称：</span>
	                         		<input class="m_input form-control" type="text" value="${realName }" disabled="disabled">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">年级：</span>
	                         		<input class="m_input form-control" type="text" value="${gradeName }" disabled="disabled">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">班主任：</span>
	                         		<input class="m_input form-control" type="text" value="${leaderName }" disabled="disabled">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">班级：</span>
	                         		<input class="m_input form-control" type="text" value="${clazzName }" disabled="disabled">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">家长名称：</span>
	                         		<input class="m_input form-control" type="text" value="${parentName }" disabled="disabled">
	                         	</div>
	                         </div>
	                         
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>成长档案-阶段</div>
	                            </div>
	                            <div class="portlet-body flip-scroll m_overflow_hidden">
	                            	<div class="portlet col-md-4 col-sm-4">
		                            	<div class="portlet-title">
		                                    <div class="caption">
		                                        <i class="fa fa-paste  font-red-sunglo"></i>
		                                        <span class="caption-subject font-red-sunglo bold uppercase">小班</span>
		                                    </div>
		                                </div>
	                            		<ul class="grow_templet">
											<li id="smallTopLi"  onclick="lookInfo(this)" style="cursor:pointer;"><img src="<%=basePath%>media/Template/smallDefault.png"><p>小班上</p></li>
											<li id="smallButLi"  onclick="lookInfo(this)" style="cursor:pointer;"><img src="<%=basePath%>media/Template/smallDefault.png"><p>小班下</p></li>
										</ul>
				
	                            	</div>
	                            	<div class="portlet col-md-4 col-sm-4">
	                            		<div class="portlet-title">
		                                    <div class="caption">
		                                        <i class="fa fa-paste  font-red-sunglo"></i>
		                                        <span class="caption-subject font-red-sunglo bold uppercase">中班</span>
		                                    </div>
		                                </div>
	                            			<ul class="grow_templet">
												<li id="middleTopLi"  onclick="lookInfo(this)" style="cursor:pointer;"><img src="<%=basePath%>media/Template/middleDefault.png"><p>中班上</p></li>
												<li id="middleButLi"  onclick="lookInfo(this)" style="cursor:pointer;"><img src="<%=basePath%>media/Template/middleDefault.png"><p>中班下</p></li>
											</ul>
											
	                            	</div>
	                            	<div class="portlet col-md-4 col-sm-4">
	                            		<div class="portlet-title">
		                                    <div class="caption">
		                                        <i class="fa fa-paste  font-red-sunglo"></i>
		                                        <span class="caption-subject font-red-sunglo bold uppercase">大班</span>
		                                    </div>
		                                </div>
	                            			<ul class="grow_templet">
												<li id="bigTopLi"  onclick="lookInfo(this)" style="cursor:pointer;"><img src="<%=basePath%>media/Template/bigDefault.png"><p>大班上</p></li>
												<li id="bigButLi"  onclick="lookInfo(this)" style="cursor:pointer;"><img src="<%=basePath%>media/Template/bigDefault.png"><p>大班下</p></li>
											</ul>
	                            	</div>
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
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
	<script>
		jQuery(document).ready(function() {  
			loadSubMenu("growthArchives"); 
			//选取当前菜单位置
			setActive("growthArchives","growth"); 
			//点击tab页加载
			$("#userTab li a").click(function(){
				$("#userTab li").removeAttr("class");
				$(this).parent().addClass("active");
				//用户ID
			});   
			var html="";
			var listData = <%=list %>;
			for(var i=0;i<listData.length;i++){
				var growth = listData[i];
				if(growth.gradeName.indexOf("小班")>-1){
					if(null!=growth.term && growth.term=="0"){
						$("#smallTopLi img").attr("src","<%=basePath%>media/Template/"+growth.path+"/01.png");
						$("#smallTopLi").attr("data-id",addDate(strToDate(growth.createYear),5).format('yyyy-MM-dd'));
						$("#smallTopLi").attr("name",growth.userId);
						$("#smallTopLi").attr("value",growth.id);
						$("#smallTopLi").css("background-color","");
					}
					if(null!=growth.term && growth.term=="1"){
						$("#smallButLi img").attr("src","<%=basePath%>media/Template/"+growth.path+"/01.png");
						$("#smallButLi").attr("data-id",addDate(strToDate(growth.createYear),9).format('yyyy-MM-dd'));
						$("#smallButLi").attr("name",growth.userId);
						$("#smallButLi").attr("value",growth.id);
						$("#smallButLi").css("background-color","");
					}
				}
				if(growth.gradeName.indexOf("中班")>-1){
					if(null!=growth.term && growth.term=="0"){
						$("#middleTopLi img").attr("src","<%=basePath%>media/Template/"+growth.path+"/01.png");
						$("#middleTopLi").attr("data-id",addDate(strToDate(growth.createYear),17).format('yyyy-MM-dd'));
						$("#middleTopLi").attr("name",growth.userId);
						$("#middleTopLi").attr("value",growth.id);
						$("#middleTopLi").css("background-color","");
					}
					if(null!=growth.term && growth.term=="1"){
						$("#middleButLi img").attr("src","<%=basePath%>media/Template/"+growth.path+"/01.png");
						$("#middleButLi").attr("data-id",addDate(strToDate(growth.createYear),21).format('yyyy-MM-dd'));
						$("#middleButLi").attr("name",growth.userId);
						$("#middleButLi").attr("value",growth.id);
						$("#middleButLi").css("background-color","");
					}
				}
				if(growth.gradeName.indexOf("大班")>-1){
					if(null!=growth.term && growth.term=="0"){
						$("#bigTopLi img").attr("src","<%=basePath%>media/Template/"+growth.path+"/01.png");
						$("#bigTopLi").attr("data-id",addDate(strToDate(growth.createYear),29).format('yyyy-MM-dd'));
						$("#bigTopLi").attr("name",growth.userId);
						$("#bigTopLi").attr("value",growth.id);
						$("#bigTopLi").css("background-color","");
					}
					if(null!=growth.term && growth.term=="1"){
						$("#bigButLi img").attr("src","<%=basePath%>media/Template/"+growth.path+"/01.png");
						$("#bigButLi").attr("data-id",addDate(strToDate(growth.createYear),33).format('yyyy-MM-dd'));
						$("#bigButLi").attr("name",growth.userId);
						$("#bigButLi").attr("value",growth.id);
						$("#bigButLi").css("background-color","");
					}
				}
			}
		});
		function lookInfo(objData){
			var endDate = $(objData).attr("data-id");
			var userId = $("#userId").val();
			var growthId =  $(objData).attr("value");
			var roleCode = $("ul li.active").find('a').attr("attr2");
			if(null != growthId && growthId != ""  && "undefined" != growthId){
				standardPost('<%=basePath %>growth/toAddArchive.do',{endDate:endDate,userId:userId,growthId:growthId,roleCode:roleCode});
			}
		}
	</script>
</html>