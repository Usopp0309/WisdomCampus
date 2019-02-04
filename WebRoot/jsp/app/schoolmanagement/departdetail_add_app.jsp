<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>添加部门人员</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>


<body>

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>添加部门人员
		
			<a href="">
				<i class="itext icon_right">添加</i>
			</a>							
		
		
	</div>
	<ul class="depart_detail_add">
		<p>五年级组</p>
		<li>
			<p><i class="icon-chevron-down"></i><span>校办(10)</span><span class="num_s">已选取<em>0</em>人</span><span class="s_right">全选</span></p>
			<dl>
				<dd id="1">小飞1</dd>
				<dd id="2">小飞2</dd>
				<dd id="3">小飞3</dd>
				<dd id="4">小飞4</dd>
				<dd id="5">小飞5</dd>
				<dd id="6">小飞6</dd>
				<dd id="7">小飞7</dd>
			</dl>
		</li>
		<li>
			<p><i class="icon-chevron-down"></i><span>校办(10)</span><span class="num_s">已选取<em>0</em>人</span><span class="s_right">全选</span></p>
			<dl>
				<dd id="8">小飞8</dd>
				<dd id="9">小飞9</dd>
				<dd id="10">小飞10</dd>
				<dd id="1">小飞1</dd>
				<dd id="2">小飞2</dd>
				<dd id="3">小飞3</dd>
				<dd id="4">小飞4</dd>
			</dl>
		</li>
		<li>
			<p><i class="icon-chevron-down"></i><span>校办(10)</span><span class="num_s">已选取<em>0</em>人</span><span class="s_right">全选</span></p>
			<dl>
				<dd id="11">小飞11</dd>
				<dd id="12">小飞12</dd>
				<dd id="13">小飞13</dd>
				<dd id="14">小飞14</dd>
				<dd id="15">小飞15</dd>
				<dd id="16">小飞16</dd>
				<dd id="17">小飞17</dd>
			</dl>
		</li>
	</ul>
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	<script type="text/javascript">
		$(function(){
			$(".depart_detail_add p").on("click",function(){
				$(".depart_detail_add").find("dl").hide();
				$(this).siblings("dl").show();
				$(".depart_detail_add").find("i").addClass("icon-chevron-down");
				$(this).find("i").removeClass("icon-chevron-down").addClass("icon-chevron-right");
			})
			$(".depart_detail_add dl dd").on("click",function(){
				if($(this).hasClass("select")){
					$(this).removeClass("select");
				}else{
					$(this).addClass("select");
				}
				var size=$(".depart_detail_add").find(".select").size();
				var dd_num=$(this).parent().find("dd").size();
				$(this).parent().prev().find("em").text(size);
				if(size==dd_num){
					$(this).parent().prev().find(".s_right").text("取消全选");
				}else{
					$(this).parent().prev().find(".s_right").text("全选");
				}
			})
			$(".s_right").on("click",function(){
				var text=$(this).text();
				if(text=="全选"){
					$(this).parent().next().find("dd").addClass("select");
					$(this).text("取消全选")
					var size=$(this).parent().next().find(".select").size();
					$(this).siblings().find("em").text(size);
				}else{
					$(this).parent().next().find("dd").removeClass("select");
					$(this).text("全选")
					var size=$(this).parent().next().find(".select").size();
					$(this).siblings().find("em").text(size);
				}
				return false;
			})
		})
	</script>

</html>