<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>评价模板设定</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <link href="../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束--> 
 	 <style>
        .control-label{
            float: left;
		    width: 160px;
		    padding-top: 5px;
		    text-align: right;
        }
        .templet_list{
            min-height: 200px;
		    border: 1px solid #e6e7eb;
		    padding: 0px;
		    margin: 0px;
		    overflow: hidden;
        }
        .templet_list li{
            width: 18%;
		    min-height: 150px;
		    margin: 15px 1% 0;
		    text-align: center;
		    float: left;
		    color: #666;
        }
        .templet_list li p {
             margin: 0px;
        }
	</style>

 	       
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
	                        <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">教学评价</a><i class="fa fa-circle"></i></li>
	                        <li><span>评价模板设定</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">电子课程表设定</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
		                        <c:if test="${sessionScope.user.type != 2}">
		                        	<a href="#static" class="btn btn-default" data-toggle="modal">添加模板</a>		
<!-- 									<button class="btn btn-default" type="button" onclick="opendivshow()"></button> -->
									<button class="btn btn-default" type="button" onclick="forbiddenModel()">禁用模板</button>
								</c:if>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                       	<form action="<%=basePath%>evaluation/doAddEvaluationTemplate.do" class="form-horizontal" method="post" id="addEvaluationTemplate">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">选择学期：</span>
	                         		<input type="hidden" name="eids" id="eids">
									<select name="semester" class="m_select form-control">
										<option value="1" selected="selected">上学期</option>
										<option value="2">下学期</option>
									</select>
	                         	</div>
	                         </div>
	                         <div class="modal fade bs-modal-lg" id="static" tabindex="-1" role="dialog" aria-hidden="true">
<!-- 	                         	<div class="modal-body_1"> -->
										<table border="0" cellpadding="0" cellspacing="0" id="ptable" style="width:400px; height:200px;border-collapse:collapse;background: azure; margin-top: 25%;margin-left: 40%;z-index: 999999;">
<!-- 											display: block; -->
		    
													<tr>
														<td>
															<img alt="" src="../res/styles/menu/EvaluateModels.png" style="margin-left: 50%;">
														</td>
													</tr>
													<tr>
														<td width="1"></td>
														<td colspan="4">
															模板名称:&nbsp;&nbsp;<input type="text" name="name" maxlength="20" style="width:190px;height:30px;border-radius:5px;">
														</td>
													</tr>
													<tr>
														<td></td>
														<td align="right" width="120">
															<a href="#" id="saveTemp" style="background: url('../assets/global/img/m_img/ok.png') 0px 0px no-repeat;width:94px;height:80px;display: block;" onclick="show()"></a>
														</td>
														<td align="left">
															<a href="#" style="background: url('../res/styles/menu/cancel.png') 0px 0px no-repeat; width:79px;height:37px;  display: block;margin-left: 30%;" onclick="colsedivs()"></a>
														</td>
													</tr>
												</table>
<!-- 								</div> -->
	                         </div>	
	                       </form>
	                      </div>
	                     	     	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>模板选择</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
<!-- 	                            		<lable class="control-label">选择模板：</lable> -->
									<div class="controls">
										<ul class="templet_list">
										<c:forEach var="evaluationTemplate" items="${evaluationTemplates}" varStatus="status">
											<li>
												<div>
													<c:if test="${sessionScope.user.type != 2}"><a href="#" onclick="showpaper(${evaluationTemplate.id})"><img src="../res/styles/menu/disk.png"></a></c:if>
													<c:if test="${sessionScope.user.type == 2}"><img src="../res/styles/menu/disk.png"> </c:if>
												</div>
												<c:if test="${evaluationTemplate.semester==1 }">
												  <c:choose>
													   <c:when test="${evaluationTemplate.status==2 }">
													       <p>上学期${evaluationTemplate.name}(禁用)</p>
													   </c:when>
													   <c:otherwise>
													      <p>上学期${evaluationTemplate.name}</p>
														</c:otherwise>
													</c:choose>
												</c:if>
												<c:if test="${evaluationTemplate.semester==2 }">
													<c:choose>
													    <c:when test="${evaluationTemplate.status==2}">
														   <p>下学期${evaluationTemplate.name}(禁用)</p>
														</c:when>
														<c:otherwise>
														   <p>下学期${evaluationTemplate.name }</p>
														</c:otherwise>
													</c:choose>
												</c:if>
												<p><input type="checkbox" name="eid" id="eid" value="${evaluationTemplate.id }"></p>
											</li>
										</c:forEach>
											</ul>
									</div>
<!-- 	                                <table class="table table-bordered table-hover"> -->
<!-- 	                                    <thead class="flip-content"> -->
<!-- 	                        http://192.168.0.31:8085/WisdomCampus/media/css/bootstrap.min.css                <tr> -->
<!-- 	                                            <th>模板名称</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                            <th>字段</th> -->
<!-- 	                                        </tr> -->
<!-- 	                                    </thead> -->
<!-- 	                                    <tbody id="tbody"> -->
<!-- <!-- 	                                       btn btn-sm green --> 
<!-- 	                                    </tbody> -->
<!-- 	                                </table> -->
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
	    <!-- 底部开始 -->
	    <%@ include file="/public_module/public_footer.jsp" %>
	    <!-- 底部结束 -->
	</body>
    <!-- 公共js开始 -->
    <%@ include file="/public_module/public_js.jsp" %>
    <!-- 公共js结束 -->
</html>
<script type="text/javascript">
$(function(){
	loadSubMenu("evaluationManager");
	 setActive("evaluationManager","setEvaluationTemplateManager");
});
	 
// function opendivshow(){
// 	openDivPage('400','200','1','新增模板');
// }

function show(){
	var a=document.getElementById("addEvaluationTemplate");
	a.action="<%=basePath%>evaluation/doAddEvaluationTemplate.do";
	a.submit();
	$("#saveTemp").hide();
}

function colsedivs(){
	window.location.href='<%=basePath%>evaluation/toEvaluationTemplate.do';
}

function forbiddenModel(){
	var eids="";
	var checks=document.getElementsByName("eid");
	for(var i=0;i<checks.length;i++){
		if(checks[i].checked){
			eids+=checks[i].value+",";
		}
	}
	if(eids!=""){
		alert("是否确定禁用模板!");
		document.getElementById("eids").value=eids;
		var a=document.getElementById("addEvaluationTemplate");
		a.action="<%=basePath%>evaluation/doDeleteEvaluationTemplate.do";
		a.submit();
	}else{
		alert("请选择要禁用的模板!");
		return;
	}
}
	
function showpaper(id){
	
	window.open("<%=request.getContextPath() %>/testpaper/teacherCreateTestpapers/testpaper.htm?"+id);
}

</script>






<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%> --%>
<%-- <%@ include file="/basepath.jsp"%> --%>

<!-- <!DOCTYPE html> -->
<!-- <!--[if IE 8]> <html lang="en" class="ie8"> <![endif]--> -->

<!-- <!--[if IE 9]> <html lang="en" class="ie9"> <![endif]--> -->

<!-- <!--[if !IE]><!-->  -->
<!-- <html lang="en"> <![endif] -->
<!--   <head> -->

<!-- 		<title></title> -->

<!-- 		<meta content="width=device-width, initial-scale=1.0" name="viewport" /> -->

<!-- 		<meta content="" name="description" /> -->

<!-- 		<meta content="" name="author" /> -->

<!-- 		<!-- BEGIN GLOBAL MANDATORY STYLES --> -->

<!-- 		<link href="../media/css/bootstrap.min.css" rel="stylesheet" type="text/css" /> -->

<!-- 		<link href="../media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" /> -->

<!-- 		<link href="../media/css/font-awesome.min.css" rel="stylesheet" type="text/css" /> -->

<!-- 		<link href="../media/css/style-metro.css" rel="stylesheet" type="text/css" /> -->

<!-- 		<link href="../media/css/style.css" rel="stylesheet" type="text/css" /> -->

<!-- 		<link href="../media/css/style-responsive.css" rel="stylesheet" type="text/css" /> -->

<!-- 		<!-- <link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color" /> --> -->

<!-- 		<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css" /> -->
			
<!-- 		<link href="../media/css/opendiv.css" rel="stylesheet" type="text/css" />	 -->

<!-- 		<link href="../media/css/pricing-tables.css" rel="stylesheet" type="text/css" /> -->

<!-- 		<link rel="stylesheet" type="text/css" href="../media/css/select2_metro.css" /> -->

<!-- 		<link rel="stylesheet" href="../media/css/DT_bootstrap.css" /> -->
		
<!-- 		<link rel="stylesheet" href="../media/css/skin.css" /> -->
<!-- 		<link href="../media/metronic_css_m/system_m.css" rel="stylesheet" type="text/css" media="screen" /> -->
		
<!-- 	<!-- 	<style type="text/css"> -->
<!-- 		      .control-group button {font-size: 14px;padding: 0 15px;margin: 20px;display: block;} -->
<!-- 			  .a1 a{background: url('../media/image_m/disk.png') 0px 0px no-repeat;display: block; width: 121px;height: 119px;} -->
<!-- 			  .a1 a:HOVER{background: url('../media/image_m/disk1.png') 0px 0px no-repeat;display: block; width: 121px;height: 119px;} -->
<!--         </style> --> -->
        
<!-- </head> -->

<!-- 	<body class="page-header-fixed"> -->

<!-- 			<div class="container-fluid"> -->

<!-- 				END PAGE HEADER -->

<!-- 				<div class="row-fluid"> -->

<!-- 					<div class="span12"> -->

<!-- 						BEGIN EXAMPLE TABLE PORTLET -->

<!-- 						<div class="portlet box green"> -->
						

<!-- 							<div class="portlet-body portlet-body form-horizontal"> -->
<!-- 								<div class="control-group"> -->
<!-- 									<label class="control-label">选择学期：</label> -->
<!-- 									<div class="controls"> -->
<!-- 									<div id="windown-box1"> -->
<!-- 										<div id="windown-title1"  style="width:410px; height: 50px;"><h2><span id="title_span">结果列表</span></h2><span id="windown-close1">关闭</span></div> -->
<!-- 										<div id="windown-content-border1"> -->
<!-- 											<div id="windown-content1"> -->
<!-- 												<div id="searchResult"> -->
<!-- 												<table border="0" cellpadding="0" cellspacing="0" id="ptable" style="width:400px; height: 200px;border-collapse:collapse;"> -->
													
<!-- 													<tr height="50"> -->
<!-- 														<td colspan="3" align="center"> -->
<!-- 															<img alt="" src="../media/image/EvaluateModels.png"> -->
<!-- 														</td> -->
<!-- 													</tr> -->
<!-- 													<tr> -->
<!-- 														<td width="70"></td> -->
<!-- 														<td colspan="2"> -->
<!-- 															模板名称:&nbsp;&nbsp;<input type="text" name="name" > -->
<!-- 														</td> -->
<!-- 													</tr> -->
<!-- 													<tr> -->
<!-- 														<td></td> -->
<!-- 														<td align="right" width="120"> -->
<!-- 															<a href="#" id="saveTemp" style="background: url('../media/image/ok.png') 0px 0px no-repeat;width:94px;height:44px;display: block;" onclick="show()"></a> -->
<!-- 														</td> -->
<!-- 														<td align="left"> -->
<!-- 															<a href="#" style="background: url('../media/image/cancel.png') 0px 0px no-repeat; width:79px;height:37px;  display: block;" onclick="colsedivs()"></a> -->
<!-- 														</td> -->
<!-- 													</tr> -->
<!-- 												</table> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
									
<%-- 									<input type="hidden" value="${userId}" name="userId" id="userId"/> --%>
<!-- 								</form> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="control-group"> -->
<!-- 									<lable class="control-label">选择模板：</lable> -->
<!-- 									<div class="controls"> -->
<!-- 										<ul class="templet_list"> -->
<%-- 										<c:forEach var="evaluationTemplate" items="${evaluationTemplates}" varStatus="status"> --%>
<!-- 											<li> -->
<!-- 												<div > -->
<%-- 													<c:if test="${sessionScope.user.type != 2}"><a href="#" onclick="showpaper(${evaluationTemplate.id})"><img src="../media/image_m/disk.png"></a></c:if> --%>
<%-- 													<c:if test="${sessionScope.user.type == 2}"><img src="../media/image_m/disk.png"> </c:if> --%>
<!-- 												</div> -->
<%-- 												<c:if test="${evaluationTemplate.semester==1 }"> --%>
<%-- 												  <c:choose> --%>
<%-- 													   <c:when test="${evaluationTemplate.status==2 }"> --%>
<%-- 													       <p>上学期${evaluationTemplate.name}(禁用)</p> --%>
<%-- 													   </c:when> --%>
<%-- 													   <c:otherwise> --%>
<%-- 													      <p>上学期${evaluationTemplate.name}</p> --%>
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose> --%>
<%-- 												</c:if> --%>
<%-- 												<c:if test="${evaluationTemplate.semester==2 }"> --%>
<%-- 													<c:choose> --%>
<%-- 													    <c:when test="${evaluationTemplate.status==2}"> --%>
<%-- 														   <p>下学期${evaluationTemplate.name}(禁用)</p> --%>
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<%-- 														   <p>下学期${evaluationTemplate.name }</p> --%>
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose> --%>
<%-- 												</c:if> --%>
<%-- 												<p><input type="checkbox" name="eid" id="eid" value="${evaluationTemplate.id }"></p> --%>
<!-- 											</li> -->
<%-- 										</c:forEach> --%>
<!-- 											</ul> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->

<!-- 						END EXAMPLE TABLE PORTLET -->

<!-- 					</div> -->

<!-- 				</div> -->
<!-- 				END PAGE CONTENT -->

<!-- 			</div> -->


<!-- 		<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) --> -->

<!-- 		<!-- BEGIN CORE PLUGINS --> -->
<!-- 		<script src="../media/js/jquery-2.1.1.min.js" type="text/javascript"></script> -->

<!-- 		<script src="../media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script> -->

<!-- 		<script src="../media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script> -->

<!-- 		<script src="../media/js/bootstrap.min.js" type="text/javascript"></script> -->

<!-- 		<!--[if lt IE 9]> -->

<!-- 	<script src="media/js/excanvas.min.js"></script> -->

<!-- 	<script src="media/js/respond.min.js"></script>   -->

<!-- 	<![endif]--> -->

<!-- 		<script src="../media/js/jquery.slimscroll.min.js" type="text/javascript"></script> -->

<!-- 		<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script> -->

<!-- 		<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script> -->

<!-- 		<script src="../media/js/jquery.uniform.min.js" type="text/javascript"></script> -->

<!-- 		<script type="text/javascript" src="../media/js/select2.min.js"></script> -->

<!-- 		<script type="text/javascript" src="../media/js/jquery.dataTables.min.js"></script> -->

<!-- 		<script type="text/javascript" src="../media/js/DT_bootstrap.js"></script> -->

		
<!-- 		<script src="../media/js/opendiv.js"></script> -->

<!-- 		<script src="../media/js/table-advanced.js"></script> -->

<!-- 		<script type="text/javascript" src="../media/js/My97DatePicker/WdatePicker.js"></script> -->
		
<!-- 		<script type="text/javascript" src="../media/js_m/public_js.js"></script> -->
<!-- 		<script src="../media/js/app.js"></script> -->
		
<!-- 		<script> -->
<%-- 			var basePath = "<%=basePath%>"; --%>

// 		jQuery(document).ready(function()
// 		 {    

// // 			App.init();
			
// 		});

	
<!-- 	</script>  -->
</html>