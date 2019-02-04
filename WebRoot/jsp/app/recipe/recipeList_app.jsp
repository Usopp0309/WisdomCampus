<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
	<title>营养食谱</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body id="body" style="background-color: #f7f7f7;">
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);" id="icon_left"></i>营养食谱
	</div>
	<!-- <div class="week">
		<li><a href="javascript:;" id="priviousWeek">上周</a></li>
		<li class="select"><a href="javascript:;" id="Week">本周</a></li>
		<li><a href="javascript:;" id="nextWeek">下周</a></li>
	</div> -->
	<ul class="recipes_header">
		<c:forEach items="${dateList}" var="date">
			<c:choose>
				<c:when test="${parmDate eq date}">
					<li class="active">
						<p>${fn:substring(date, 5, -1)}</p>
						<p>(${dateMap[date]})</p>
					</li>
				</c:when>
				<c:otherwise>
					<li>
						<p>${fn:substring(date, 5, -1)}</p>
						<p>(${dateMap[date]})</p>
					</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>	
	</ul>
	
	<input type="text" value ="${currentDate}" id="currentDate" style="display: none"/>
	<input type="text" value ="${currentMonday}" id="currentMonday" style="display: none"/>
	<input type="hidden" value="${apiKey}" id="apiKey" name="apiKey">
	<input type="hidden" value="${schoolId}" id="schoolId" name="schoolId">
	<c:forEach items="${dateList}" var="date">
		<c:choose>
			<c:when test="${parmDate eq date}">
				<ul class="Recipes" style="display: block">
						<c:if test="${map[date].breakfastList != null && fn:length(map[date].breakfastList) > 0}">
							<li>
								<h2>早餐</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].breakfastList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].lunchList != null && fn:length(map[date].lunchList) > 0}">
							<li>
								<h2>午餐</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].lunchList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].snackList != null && fn:length(map[date].snackList) > 0}">
							<li>
								<h2>下午茶</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].snackList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].otherList != null && fn:length(map[date].otherList) > 0}">
							<li>
								<h2>其他</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].otherList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].lunchList eq null && map[date].breakfastList eq null && map[date].otherList eq null && map[date].snackList eq null}">
						       <img src="<%=basePath%>assets/global/img/m_img/food_null.png">
						</c:if>
				</ul>
			</c:when>
			<c:otherwise>
				<ul class="Recipes">
						<c:if test="${map[date].breakfastList != null && fn:length(map[date].breakfastList) > 0}">
							<li>
								<h2>早餐</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].breakfastList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].lunchList != null && fn:length(map[date].lunchList) > 0}">
							<li>
								<h2>午餐</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].lunchList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].snackList != null && fn:length(map[date].snackList) > 0}">
							<li>
								<h2>下午茶</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].snackList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].otherList != null && fn:length(map[date].otherList) > 0}">
							<li>
								<h2>其他</h2>
									<dl class="Recipes_dl">
												<c:forEach items="${map[date].otherList}" var="dish">
					 								
					 									<c:if test="${dish.dishName != null && fn:length(dish.dishName) >0 }">
					 										<dd>
																<span>${dish.dishName}</span>
																<img src="${dish.picPath}">
																<a href="#static" data-toggle="modal" id="${dish.id}"><i class="icon-thumbs-up"></i></a>
															</dd>
					 									</c:if>
												</c:forEach>
									</dl>
							</li>
						</c:if>
						<c:if test="${map[date].lunchList eq null && map[date].breakfastList eq null && map[date].otherList eq null && map[date].snackList eq null}">
						         <img src="<%=basePath%>assets/global/img/m_img/food_null.png">
						</c:if>
				</ul>
			</c:otherwise>
		</c:choose>
		
	</c:forEach>

	<div class="select_role">
		<dl>
			<dd class="role_search iconfont" id="search">&#xe602;</dd>
			<dd class="role_search fa fa-signal" id="favoriteFood"></dd>
		</dl>
		<span class="role_img iconfont">&#xe600;</span>
	</div>
</body>

		</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->
	<script type="text/javascript">
		$(function(){
			//初始化
			var liLength = $(".recipes_header li").length;
			var flag = true;
			 for(var i=0;i<liLength;i++){
				 if($(".recipes_header li").eq(i).hasClass("active")){
					 flag = false;
					 break;
				 }
			}

			if(flag){
				$(".recipes_header li").eq(0).addClass("active");
				$(".Recipes").hide();
				$(".Recipes").eq(0).show();
			}
			
			$(".recipes_header li").on("click",function(){
				$(".recipes_header li").removeClass("active");
// 				$(this).css({"border":"1px solid #29b3f2","background-color":"#29b3f2","color":"#fff"});
				$(this).addClass("active");
				$(".Recipes").hide();
				$(".Recipes").eq($(this).index()).show();
				})
			 $(".Recipes dd a").on("click",function(){
				 if($(this).find("i").attr("style")){
					var id = $(this).attr("id");
					delPraise(id);
					$(this).find("i").removeAttr("style");
					
				 }else{
					var id = $(this).attr("id");
					addPraise(id);
					$(this).find("i").css({"color":"#29b3f2"});
				
				}
			 })
			 
			 $("#priviousWeek").on("click",function(){
				 var currentMonday = $("#currentMonday").val();
				 standardPost('<%=basePath%>recipe/priviousRecipeList.do',{parmDate:currentMonday});
			 })
			 
			 $("#nextWeek").on("click",function(){
				 var currentMonday = $("#currentMonday").val();
				 standardPost('<%=basePath%>recipe/nextRecipeList.do',{parmDate:currentMonday});
			 })
			 
		<%-- 	  $("#Week").on("click",function(){
				 var currentMonday = $("#currentMonday").val();
				  standardPost('<%=basePath%>recipe/currentRecipeList.do',{parmDate:currentMonday});
			 }) --%>
			 
			if(isios()){
				$("#icon_left").attr("onclick","iosBack();");
			}else{
				$("#icon_left").attr("onclick","window.richbook.onFinish();");
			}

			$("#search").on("click",function(){
				var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				standardPost('<%=basePath%>jsp/app/recipe/recipeList_search_app.jsp',{apiKey:apiKey,schoolId:schoolId});
			})
			$("#favoriteFood").on("click",function(){
				var apiKey = $("#apiKey").val();
				var schoolId = $("#schoolId").val();
				standardPost('<%=basePath%>recipe/toRecipeListTopByApiKey.do',{apiKey:apiKey,schoolId:schoolId});
			})
			
		})
		
		function iosBack(){
			window.location.href="ios.jsp";
		}
		
		function isios(){
			var u = navigator.userAgent;
			//var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
			var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
			return isiOS;
		}
		function addPraise(id){
			$.ajax({
				type: "post",
				url: "<%=basePath%>recipe/addPraise.do",
				data:{
					id : id
				},
				success: function(data){}
			});
		}
		function delPraise(id){
			$.ajax({
				type: "post",
				url: "<%=basePath%>recipe/delPraise.do",
				data:{
					id : id
				},
				success: function(data){}
			});
		}
		
	</script>

</html>