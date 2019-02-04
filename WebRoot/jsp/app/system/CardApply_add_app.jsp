<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>补办卡申请</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="history.go(-1);"></i>不办卡申请<i class="itext icon_right">保存</i>
	</div>
	<div class="schedule_add">
	<form action="" class="" method="post">
		<span>卡类型</span>
		<input type="text" id="startday">
		<span>数量</span>
		<input type="text" id="startday">
		
		<div class="tabbable tabbable-custom">

			<ul class="nav nav-tabs">

				<li class="active"><a data-toggle="tab" class="select_all_on" href="#tab_1_1">办卡</a></li>
				<li><a data-toggle="tab" class="select_all_off" href="#tab_1_2">补卡</a></li>

			</ul>

			<div class="tab-content">

				<div id="tab_1_1" class="tab-pane active">
					<span>办卡名单上传</span>
					<p class="btn fileinput-button" style="background-color:#f2f2f2;">

						<i class="icon-plus icon-white"></i>

						<span>添加附件</span>

						<input type="file" multiple="" name="files[]">

					</p>
					
				</div>

				<div id="tab_1_2" class="tab-pane">

					<div id="accordion1" class="accordion">

						<div class="accordion-group">
	
							<div class="accordion-heading">
	
								<a href="#collapse_1" data-parent="#accordion1" data-toggle="collapse" class="accordion-toggle collapsed">
								<i class=" icon-caret-down"></i>
								一年级
	
								</a>
	
							</div>
	
							<div class="accordion-body collapse" id="collapse_1" style="height: 0px;">
	
									<div class="accordion-group"style="border:none;">
		
										<div class="accordion-heading accord_head">
			
											<a href="#collapse_2" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle" >
												<i class=" icon-caret-down"></i>
												一班 (28)人
											</a>
											<span>已选取(<b class="select_num">0</b>)人</span><em><i class="icon-ok"></i>全选</em>
										</div>
		
										<div class="accordion-body collapse" id="collapse_2" style="height: 0px;">
											<dl>
												<dd>陈凯1</dd><dd>陈凯2</dd><dd>陈凯3</dd><dd>陈凯4</dd><dd>陈凯5</dd><dd>陈凯6</dd><dd>陈凯7</dd><dd>陈凯8</dd><dd>陈凯9</dd>
											</dl>
										</div>
										<div class="accordion-heading accord_head">
			
											<a href="#collapse_3" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle" >
												<i class=" icon-caret-down"></i>
												二班 (28)人
											</a>
											<span>已选取(<b class="select_num">0</b>)人</span><em><i class="icon-ok"></i>全选</em>
										</div>
		
										<div class="accordion-body collapse" id="collapse_3" style="height: 0px;">
											<dl>
												<dd>陈凯1</dd><dd>陈凯2</dd><dd>陈凯3</dd><dd>陈凯4</dd><dd>陈凯5</dd><dd>陈凯6</dd><dd>陈凯7</dd><dd>陈凯8</dd><dd>陈凯9</dd>
											</dl>
										</div>
		
								</div>
	
							</div>
							
	
						</div>

						

						

					</div>
					
					

				</div>

				

			</div>

		</div>
	</form>
	</div>
	<div class="select_all">总共选取(<em class="num">0</em>)人</div>
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">
		$(function(){
			$(".select_all_off").on("click",function(){
				$(".select_all").show();
			})
			$(".select_all_on").on("click",function(){
				$(".select_all").hide();
			})
			$("dd").on("click",function(){
				if($(this).hasClass("select_sub")){
					$(this).removeClass("select_sub");
					var num=$(this).parent().find(".select_sub").size();
					$(this).parent().parent().prev().find(".select_num").text(num);
					$(".num").text($(".accordion").find(".select_sub").size());
				}else{
					$(this).addClass("select_sub");
					var num=$(this).parent().find(".select_sub").size();
					$(this).parent().parent().prev().find(".select_num").text(num);
					$(".num").text($(".accordion").find(".select_sub").size());
				}
			})
			$(".icon-ok").on("click",function(){
				if($(this).hasClass("select")){
					$(this).removeClass("select");
					$(this).parent().parent().next().find("dd").removeClass("select_sub");
					$(this).parent().parent().find(".select_num").text($(this).parent().parent().next().find("dd").size());
					$(".num").text($(".accordion").find(".select_sub").size());
				}else{
					$(this).addClass("select");
					$(this).parent().parent().next().find("dd").addClass("select_sub");
					$(this).parent().parent().find(".select_num").text($(this).parent().parent().next().find("dd").size());
					$(".num").text($(".accordion").find(".select_sub").size());
				}
				
			})
		})
	</script>
	

</html>