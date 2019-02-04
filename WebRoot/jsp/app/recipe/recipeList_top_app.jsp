<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
	<title>喜欢食谱排行</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>
<body id="body" style="background-color: #f7f7f7;">
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);" id="icon_left"></i>喜爱食谱排名
	</div>
	
	<div class="tabbable tabbable-custom" style="margin:60px auto 0px;">
			<div class="container-fluid">
			<ul class="order row-fluid nav nav-tabs" style="margin:0px;">

				<li class="active"><a data-toggle="tab" href="#tab_1_1"><i class="fa fa-beer"></i>早餐</a></li>

				<li><a data-toggle="tab" href="#tab_1_2"><i class="fa fa-ticket"></i>午餐</a></li>

				<li><a data-toggle="tab" href="#tab_1_3"><i class="fa fa-lemon-o"></i>下午茶</a></li>
				
				<li><a data-toggle="tab" href="#tab_1_4"><i class="fa fa-ellipsis-h"></i>其他</a></li>

			</ul>
			</div>
			<div class="tab-content" style="margin:15px auto 0px;">

				<div id="tab_1_1" class="tab-pane active">

					<ul class="recipeList_top">
						<li>
							<span class="num"><b class="no1">1</b></span>
							<span class="name"><i class="no1"></i>西红柿鸡蛋</span>
							<span class="img"><img src=""></span>
							<span class="Like icon-thumbs-up">48</span>
						</li>
						<li>
							<span class="num"><b class="no2">2</b></span>
							<span class="name"><i class="no2"></i>西红柿鸡蛋</span>
							<span class="img"><img src=""></span>
							<span class="Like icon-thumbs-up">48</span>
						</li>
						<li>
							<span class="num"><b class="no3">3</b></span>
							<span class="name"><i class="no3"></i>西红柿鸡蛋</span>
							<span class="img"><img src=""></span>
							<span class="Like icon-thumbs-up">48</span>
						</li>
						<li>
							<span class="num"><b>1</b></span>
							<span class="name"><i class="no1"></i>西红柿鸡蛋</span>
							<span class="img"><img src=""></span>
							<span class="Like icon-thumbs-up">48</span>
						</li>
						<li>
							<span class="num"><b>1</b></span>
							<span class="name"><i class="no1"></i>西红柿鸡蛋</span>
							<span class="img"><img src=""></span>
							<span class="Like icon-thumbs-up">48</span>
						</li>
					</ul>

				</div>

				<div id="tab_1_2" class="tab-pane">
					<ul class="recipeList_top">
					</ul>
				</div>

				<div id="tab_1_3" class="tab-pane">
					<ul class="recipeList_top">
					</ul>

				</div>
				<div id="tab_1_4" class="tab-pane">
					<ul class="recipeList_top">
					</ul>

				</div>
			</div>

	</div>
	
</body>

	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束-->  
	
	<script type="text/javascript">
		$(function(){
			$(".recipeList_top li").on("click",".Like",function(){
			var set_val=parseInt($(this).text())+1;
			$(this).text(set_val);
			})
			favoriteFood();
		})
	//获取喜爱食物的排名
	function favoriteFood(){
		$.ajax({
			type: "post",
			url: "<%=basePath%>recipe/loadFavoriteFood.do",
			success: function(data)
			{
				var list = $.parseJSON(data);
				var breakfastHtml = '<ul class="recipeList_top">';
				var lunchHtml = '<ul class="recipeList_top">';
				var snackHtml = '<ul class="recipeList_top">';
				var otherHtml = '<ul class="recipeList_top">';
				$.each(list.bList, function(b, breakfast) 
				{
					breakfastHtml += '<li>';
					if(b < 3)
					{
						breakfastHtml += '<span class="num"><b class="no'+(b+1)+'">'+(b+1)+'</b></span>';
						breakfastHtml += '<span class="name"><i class="no'+(b+1)+' fa fa-vimeo"></i>'+breakfast.dishName+'</span>';
					}else{
						breakfastHtml += '<span class="num"><b>'+(b+1)+'</b></span>';
						breakfastHtml += '<span class="name"><i class="no1"></i>'+breakfast.dishName+'</span>';
					}
					if(breakfast.picPath=="")
					{
						breakfastHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						breakfastHtml += '<span class="img"><img src="'+ breakfast.picPath+'"></span>';
					}
					breakfastHtml += '<span class="Like"><em class="icon-thumbs-up">'+breakfast.praiseCount+'</em></span>';
					breakfastHtml += '</li>';
					
				});
				breakfastHtml += '</ul>';
				$("#tab_1_1").html(breakfastHtml);
				
				$.each(list.lList, function(l, lunch) 
				{
					lunchHtml += '<li>';
					if(l < 3)
					{
						lunchHtml += '<span class="num"><b class="no'+(l+1)+'">'+(l+1)+'</b></span>';
						lunchHtml += '<span class="name"><i class="no'+(l+1)+' fa fa-vimeo"></i>'+lunch.dishName+'</span>';
					}else{
						lunchHtml += '<span class="num"><b>'+(l+1)+'</b></span>';
						lunchHtml += '<span class="name"><i class="no1"></i>'+lunch.dishName+'</span>';
					}
					if(lunch.picPath=="")
					{
						lunchHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						lunchHtml += '<span class="img"><img src="'+ lunch.picPath+'"></span>';
					}
					lunchHtml += '<span class="Like"><em class="icon-thumbs-up">'+lunch.praiseCount+'</em></span>';
					lunchHtml += '</li>';
					
				});
				lunchHtml += '</ul>';
				$("#tab_1_2").html(lunchHtml);
				
				$.each(list.sList, function(s, snack) 
				{
					snackHtml += '<li>';
					if(s < 3)
					{
						snackHtml += '<span class="num"><b class="no'+(s+1)+'">'+(s+1)+'</b></span>';
						snackHtml += '<span class="name"><i class="no'+(s+1)+' fa fa-vimeo"></i>'+snack.dishName+'</span>';
					}else{
						snackHtml += '<span class="num"><b>'+(s+1)+'</b></span>';
						snackHtml += '<span class="name"><i class="no1"></i>'+snack.dishName+'</span>';
					}
					if(snack.picPath=="")
					{
						snackHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						snackHtml += '<span class="img"><img src="'+ snack.picPath+'"></span>';
					}
					snackHtml += '<span class="Like"><em class="icon-thumbs-up">'+snack.praiseCount+'</em></span>';
					snackHtml += '</li>';
					
				});
				snackHtml += '</ul>';
				$("#tab_1_3").html(snackHtml);
				
				$.each(list.oList, function(o, other) 
				{
					otherHtml += '<li>';
					if(o < 3)
					{
						otherHtml += '<span class="num"><b class="no'+(o+1)+'">'+(o+1)+'</b></span>';
						otherHtml += '<span class="name"><i class="no'+(o+1)+' fa fa-vimeo"></i>'+other.dishName+'</span>';
					}else{
						otherHtml += '<span class="num"><b>'+(o+1)+'</b></span>';
						otherHtml += '<span class="name"><i class="no1"></i>'+other.dishName+'</span>';
					}
					if(other.picPath=="")
					{
						otherHtml += '<span class="img"><img src="<%=basePath%>assets/global/img/m_img/null_img.jpg"></span>';
					}else
					{
						otherHtml += '<span class="img"><img src="'+ other.picPath+'"></span>';
					}
					otherHtml += '<span class="Like"><em class="icon-thumbs-up">'+other.praiseCount+'</em></span>';
					otherHtml += '</li>';
				}); 
				otherHtml += '</ul>';
				$("#tab_1_4").html(otherHtml);
				$(".Like").on("click","em",function(){
					
					var set_val=parseInt($(this).text())+1;
					$(this).text(set_val);
					})
			},
		});
	}		
	</script>

</html>