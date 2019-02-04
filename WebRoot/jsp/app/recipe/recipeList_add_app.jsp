<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
	<title>添加食谱</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body id="body" style="background-color: #f7f7f7;">
	<div class="app_head">
		<i class="m_icon-return icon_left" onclick="" id="icon_left"></i>食谱添加
	</div>
	
	<ul class="recipelist_add">
		<li>
			<dl>
				<dd>
					<div class="left">早餐</div>
					<div class="con">
						<input type="text">
						<a href="#static" data-toggle="modal"><img src=""></a>
						<a href="#static" data-toggle="modal"><img src=""></a>
					</div>
					<div class="right"><i class="icon-ok" style="background-color:#38b64b!important"></i></div>
				</dd>
				<dd>
					<div class="left"></div>
					<div class="con">
						<input type="text">
						<a href="#static" data-toggle="modal"><img src=""></a>
						<a href="#static" data-toggle="modal"><img src=""></a>
					</div>
					<div class="right"><i class="icon-ok"></i></div>
				</dd>
			</dl>
		</li>
		<li>
			<dl>
				<dd>
					<div class="left">午餐</div>
					<div class="con">
						<input type="text">
						<a href="#static" data-toggle="modal"><img src=""></a>
						<a href="#static" data-toggle="modal"><img src=""></a>
					</div>
					<div class="right"><i class="icon-ok"></i></div>
				</dd>
				<dd>
					<div class="left"></div>
					<div class="con">
						<input type="text">
						<a href="#static" data-toggle="modal"><img src=""></a>
						<a href="#static" data-toggle="modal"><img src=""></a>
					</div>
					<div class="right"><i class="icon-ok"></i></div>
				</dd>
			</dl>
		</li>
		<li>
			<dl>
				<dd>
					<div class="left">加餐</div>
					<div class="con">
						<input type="text">
						<a href="#static" data-toggle="modal"><img src=""></a>
						<a href="#static" data-toggle="modal"><img src=""></a>
					</div>
					<div class="right"><i class="icon-ok"></i></div>
				</dd>
				<dd>
					<div class="left"></div>
					<div class="con">
						<input type="text">
						<a href="#static" data-toggle="modal"><img src=""></a>
						<a href="#static" data-toggle="modal"><img src=""></a>
					</div>
					<div class="right"><i class="icon-ok"></i></div>
				</dd>
			</dl>
		</li>
	</ul>
	<div data-keyboard="false" data-backdrop="static" tabindex="-1" class="modal hide fade" id="static">
									<div class="modal-header">

										<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>

										<h3>上传照片</h3>

									</div>
									<div class="modal-body">

										
										<form action="#" class="form-horizontal">


											<div class="fileupload fileupload-new" data-provides="fileupload" style="text-align:center;">

												<div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

													<img src="media/image/AAAAAA&amp;text=no+image" alt="" />

												</div>

												<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 450px; max-height: 300px; line-height: 20px;" id="priview1"></div>

												<div>

													<span class="btn btn-file"><span class="fileupload-new">选择图片</span>

													<span class="fileupload-exists">修改图片</span>

													<input type="file" class="default"  id="imgFile1" name="file"/></span>

													<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除图片</a>
												</div>
											</div>
								</form>
										<div class="modal-footer">
										<button class="btn green"  type="button" onclick="saveImg(1)">提交</button>
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
			$(".icon-ok").on("click",function(){
			if($(this).attr("style")){
				$(this).removeAttr("style");
				}else{
				$(this).css({"background-color":"#38b64b!important"});
				}
			})
		})
		
	</script>

</html>