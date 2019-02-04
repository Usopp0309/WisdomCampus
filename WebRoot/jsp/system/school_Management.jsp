<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - 管理页面</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
</head>
  
  <body>
  	<%@include file="/public_module/header.jsp" %>
	<div class="richxManager m_background_null">
			
			<div class="pablic_search_box management_search_box">
						<div class="search_div" style="z-index: 999">
							<span>选择省份</span>
							<input type="hidden" name="province" id="provinceInput" value="${province }"/>
							<ul id="province">
							
							</ul>
						</div>
						<div class="search_div"style="z-index: 990">
							<span>选择市</span>
							<input type="hidden" name="city"  id="cityInput" value="${city }"/>
							<ul id="city" >
							
							</ul>
						</div>
						<div class="search_div"style="z-index: 949">
							<span>选择区县</span>
							<input type="hidden" name="country"  id="countryInput" value="${country }"/>
							<ul id="country" >
							
							</ul>
						</div>
						<div class="search_div">
						<button class="fa fa-search search_submit" type="button" onclick="loadSchoolList(0)"></button>
						<input type="text" value="" placeholder="请输入学校名称..." name="condition" class="search_text" id="condition">
						</div>
						<input type="hidden" value="0" id="status" name="status"> 
						<input type="hidden" value="" id="lastId" name="lastId">
						<input type="hidden" value="0" name="rowNum" id="rowNum">
				</div>
		<div class="School_Management_con School_Management_con_p">
		
		<ul >
			<li  class="768_li" id="schoolList">
			</li>
		</ul>
		 <%@include file="/public_module/public_page.jsp" %>
</div>
	</div>

  <%@include file="/public_module/public_footer.jsp" %>
  
  <div class="modal fade" id="static" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-md">
	            <div class="modal-content">
	            	<div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                    <h4 class="modal-title">人员信息</h4>
	                </div>
	                <div class="modal-body" id="schoolDetail"></div>
	                <div class="modal-footer">
	                    <button type="button" class="btn green" data-dismiss="modal">关闭</button>
	                </div>
	            </div>
	     </div>
	</div>
</body>
  <%@include file="/public_module/public_js.jsp" %>
<script type="text/javascript">
$(function() {
	loadProvince();
	loadSchoolList(0);
	//导航定位
	$(".School_Management_con_circle li").first().addClass("School_Management_con_circle-cur");
	$(".menu_li a").removeClass("hover");
	$("#menu3").addClass("hover");
	
	$(".search_div span").on("click",function(){
		if($(this).parent().find("ul").attr("style")){
			$(this).parent().find("ul").removeAttr("style");
		}else{
			$(".management_search_box ul").removeAttr("style");
			$(this).parent().find("ul").css({"display":"block"});
		}
	})
	
	var animateEnd = 1;
	$(".School_Management_con_circle li").click(function() {
		if (animateEnd == 0) {
			return
		}
		$(this).addClass("School_Management_con_circle-cur").siblings().removeClass("School_Management_con_circle-cur");
		var nextindex = $(this).index();
		var currentindex = $(".School_Management_con_cont li").first().attr("index");
		var curr = $(".School_Management_con_cont li").first().clone();
		if (nextindex > currentindex) {
			for (var i = 0; i < nextindex - currentindex; i++) {
				var firstItem = $(".School_Management_con_cont li").first();
				$(".School_Management_con_cont ul").append(firstItem)
			}
			$(".School_Management_con_cont ul").prepend(curr);
			var offset = ($(".School_Management_con_cont li").width()) * -1;
			if (animateEnd == 1) {
				animateEnd = 0;
				$(".School_Management_con_cont ul li").first().remove();
				$(".School_Management_con_cont ul li").first().css({"display":"block"});
				$(".School_Management_con_cont ul li:not(':first')").css({"display":"none"});
				animateEnd = 1
			}
		} else {
			var curt = $(".School_Management_con_cont li").last().clone();
			for (var i = 0; i < currentindex - nextindex; i++) {
				var lastItem = $(".School_Management_con_cont li").last();
				$(".School_Management_con_cont ul").prepend(lastItem)
			
			}
			$(".School_Management_con_cont ul").append(curt);
			var offset = ($(".School_Management_con_cont li").width()) * -1;
			$(".School_Management_con_cont").css("left", offset);
			if (animateEnd == 1) {
				$(".School_Management_con_cont ul li").last().remove();
				$(".School_Management_con_cont ul li").first().css({"display":"block"});
				$(".School_Management_con_cont ul li:not(':first')").css({"display":"none"});
				animateEnd = 1
			}
		}
	});
	
	
});
//加载省份
function loadProvince(){
	$.ajax({
		type: "post",
		url: "<%=basePath%>apply/getPronvice.do",
		data:{
				
			},
		success: function(data){
			var list = $.parseJSON(data);
			var appendHtml = '';
			$.each(list, function(n, value) {  
				appendHtml += '<li id="' + value.areaId + '">' + value.areaName + '</li>';
  			}); 
  			$("#province").html(appendHtml);
  			var provinceId = $("#provinceInput").val();
  			
  			if(provinceId != ""){
  				$("#provinceInput").parent().find("span").text($("#" + provinceId).text());
  				getChildrenArea('province', 'city');
  			}
  			$("#province").find("li").on("click",function(){
  				$(this).parent().parent().find("span").text($(this).text());
  				$(this).parent().parent().find("input").val($(this).attr("id"));
  				$(this).parent().removeAttr("style");
  				getChildrenArea('province', 'city');
  				$("#cityInput").val("");
  				$("#countryInput").val("");  				
  				loadSchoolList(0);
  				
  			})
		},
	});
	
}
//下拉框更改事件
function getChildrenArea(parentId, childId){
	if (parentId == 'province'){//根据省获取地市
		var cityId =  $("#cityInput").val();
		//$("#countryInput").val("");
		$.ajax({
			type: "post",
			url: "<%=basePath%>apply/getChildrens.do",
			data:{
					areaId : $("#provinceInput").val()
				},
			success: function(data){
				var list = $.parseJSON(data);
				var appendHtml = '';
				$.each(list, function(n, value) {  
					appendHtml += '<li id="' + value.areaId + '">' + value.areaName + '</li>';
      			}); 
      			$("#city").html(appendHtml);
      			if(cityId != ""){
      				$("#cityInput").parent().find("span").text($("#" + cityId).text());
      				getChildrenArea('city', 'country');
      			}
      			$("#city").find("li").on("click",function(){
      				$(this).parent().parent().find("span").text($(this).text());
      				$(this).parent().parent().find("input").val($(this).attr("id"));
      				$(this).parent().removeAttr("style");
      				getChildrenArea('city', 'country');
      				$("#countryInput").val("");
      				loadSchoolList(0);
      			});
			},
		});
	}else if(parentId == 'city'){//根据地市获取区县
		var countryId = $("#countryInput").val();
		$.ajax({
			type: "post",
			url: "<%=basePath%>apply/getChildrens.do",
			data:{
					areaId : $("#cityInput").val()
				},
			success: function(data){
				var list = $.parseJSON(data);
				var appendHtml = '';
				if(list.length == 0){
					appendHtml += '<li id="">城区 </li>';
					
				}else{
					$.each(list, function(n, value) {  
           				appendHtml += '<li id="' + value.areaId + '">' + value.areaName + '</li>';
          			}); 
					
				}
				
      			$("#country").html(appendHtml);
      			if(countryId != ""){
      				$("#countryInput").parent().find("span").text($("#" + countryId).text());
      			}
      			$("#country").find("li").on("click",function(){
      				$(this).parent().parent().find("span").text($(this).text());
      				$(this).parent().parent().find("input").val($(this).attr("id"));
      				$(this).parent().removeAttr("style");
      				loadSchoolList(0);
      			})
			},
		});
	}
}
function searchSchool(){
	var condition = $("#condition").val();
	if ($.trim(condition) == ""){
		return false;
	}else{
		loadSchoolList(0);
	}
	
}
function enterSchool(schoolId){
	$.ajax({
		type: "post",
		url: "<%=basePath%>user/enterSchool.do",
		data:{
				schoolId : schoolId
			},
		success: function(data){
			var data = $.parseJSON(data);
			if (data.status == 0){
				window.location.href = "<%=basePath%>user/enterMain.do"
			}
		},
	});
}
//显示学校明细
function showDetail(schoolId){
// 	$("#schoolDetail").html($("#" +schoolId).parent().parent().next(".management_detail").html());

	$.ajax({
		type: "post",
		url: "<%=basePath%>user/getSchoolDetailBySchoolId.do",
		data:{
				schoolId : schoolId
			},
		success: function(data){
			var obj= $.parseJSON(data);
			var schoolDetail=obj.schoolDetail;
			var appendHtml = '';
			appendHtml += '	<div class="management_detail">';
			appendHtml += '		<p style="width:100%;font-size:14px;">学校名称：<em>'+schoolDetail.schoolName+'</em></p>';
			appendHtml += '		<p style="width:100%;border-bottom:1px solid #ccc;font-size:14px;"><b>学校地址：<em>'+schoolDetail.schoolAddress+'</em></b></p>';
			appendHtml += '		<p>管理员：<em>'+schoolDetail.adminRealName+'</em></p>';
			appendHtml += '		<p>账号：<em>'+schoolDetail.adminUserName+'</em></p>';
			appendHtml += '	    <p>校长：<em>'+schoolDetail.president+'</em></p>';
			appendHtml += '	    <p>学校人数：<em>'+schoolDetail.userCount+'</em>人</p>';
			appendHtml += '		<p>教职工：<em>'+schoolDetail.teacherCount+'</em>人</p>';
			appendHtml += '		<p>学生家长：<em>'+(schoolDetail.parentCount)+'</em>人</p>';
			appendHtml += '		<p>学生：<em>'+(schoolDetail.studentCount)+'</em>人</p>';
			if(obj.count>0){//是否购买服务费
				appendHtml += '		<p>学生缴费：<em>'+(obj.yesCount)+'</em>人</p>';	
			}
			appendHtml += '		<p>校总短信量：<em>'+schoolDetail.smsCount+'</em>条</p>';
			appendHtml += '		<p>移动短信量：<em>'+schoolDetail.mobileSmsCount+'</em>条</p>';
			appendHtml += '		<p>联通短信量：<em>'+schoolDetail.unicomSmsCount+'</em>条</p>';
			appendHtml += '		<p>电信短信量：<em>'+schoolDetail.telecomSmsCount+'</em>条</p>	';
			appendHtml += '	</div>';
			
			$("#schoolDetail").html(appendHtml);
			$("#static").modal("show");
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
	
	
		//省
		var province = $("#provinceInput").val();
		//市
		var city = $("#cityInput").val();
		//县
		var country = $("#countryInput").val();
		
		//条件
		var condition = $("#condition").val();

		loadSchoolList(cPageInt);
	
	   $("#currentPage").html(cPageInt);
}
//加载进出记录列表
function loadSchoolList(cPage)
{
	
	$.ajax({
		type: "post",
		url: "<%=basePath%>user/getSchoolList.do",
		data:{
			province : $("#provinceInput").val(),
			city : $("#cityInput").val(),
			country : $("#countryInput").val(), 
			condition : $("#condition").val(),
			cPage : cPage
			},
		success: function(data){
			var page = $.parseJSON(data);
			$("#currentPage").html(page.currentPage);
			$("#totalPage").html(page.totalPage);
			var appendHtml = '';
			$.each(page.list, function(n, value) {  
				appendHtml += '<div class="School_Management_one">';
				appendHtml += '<div class="School_Management_one_header">';
				appendHtml += '<div class="logo">';
				if (value.schoolBadge == null || value.schoolBadge==""){
					appendHtml += '<img src="<%=basePath%>media/image/default.png">	';
				}else{
					appendHtml += '<img  src="<%=Cons.IMGBASEPATH %>'+value.schoolBadge+'">';
				}
						
				appendHtml += '</div>';
				appendHtml += '	<div class="text">';
				
				
				appendHtml += '		<p class="title"><a href="javascript:void(0)"  onclick="showDetail('+value.schoolId+')" id="'+value.schoolId+'"><b>'+value.schoolName+'</b></a><a href="javascript:void(0)"  onclick="showDetail('+value.schoolId+')" id="'+value.schoolId+'"><i class="fa fa-navicon"></i></a></p>';
				appendHtml += '		<p class="name" style="border-top:1px solid #ccc;"><a class="a_btn" href="javascript:enterSchool('+value.schoolId+')" >进入智慧校园系统<i class="icon-caret-right"></i></a></p>';
				appendHtml += '	</div>';
				appendHtml += '</div>';
				appendHtml += '</div>';
			});
  			$("#schoolList").html(appendHtml);
  			$(".School_Management_one").eq("0").css({"background-color":"#91c76a"})
  			$(".School_Management_one").eq("0").css({"background-color":"#91c76a"}).find(".logo").css({"border-right":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("0").css({"background-color":"#91c76a"}).find(".name").css({"border-top":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("1").css({"background-color":"#9b89bb"})
  			$(".School_Management_one").eq("2").css({"background-color":"#2870cd"})
  			$(".School_Management_one").eq("3").css({"background-color":"#f9b536"}).find(".logo").css({"border-right":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("3").css({"background-color":"#f9b536"}).find(".name").css({"border-top":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("4").css({"background-color":"#168ff3"})
  			$(".School_Management_one").eq("5").css({"background-color":"#f58d00"})
  			$(".School_Management_one").eq("6").css({"background-color":"#168ff3"})
  			$(".School_Management_one").eq("7").css({"background-color":"#2870cd"})
  			$(".School_Management_one").eq("8").css({"background-color":"#91c76a"})
  			$(".School_Management_one").eq("8").css({"background-color":"#91c76a"}).find(".logo").css({"border-right":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("8").css({"background-color":"#91c76a"}).find(".name").css({"border-top":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("9").css({"background-color":"#2870cd"})
  			$(".School_Management_one").eq("10").css({"background-color":"#91c76a"})
  			$(".School_Management_one").eq("10").css({"background-color":"#91c76a"}).find(".logo").css({"border-right":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("10").css({"background-color":"#91c76a"}).find(".name").css({"border-top":"1px solid #f2f2f2"})
  			$(".School_Management_one").eq("11").css({"background-color":"#168ff3"})
		},
	});
}
</script>
</html>