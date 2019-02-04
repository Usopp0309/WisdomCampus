<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>蓝牙手环课程</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<!--公共css开始-->
<%@ include file="/public_module/public_css_new.jsp"%>
<!--公共css结束-->
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed"
	id="body">
	<input class="themes" type="hidden" value="<%=ThemePath%>">
	<input type="hidden" value="${schoolId}" id="schoolId">
	<input type="hidden" value="${sessionScope.user.userId}" id="userId">
	<!-- 公共顶部开始-->
	<%@ include file="/public_module/public_header.jsp"%>
	<!--公共顶部结束-->
	<div class="clearfix"></div>
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
							<li><a href="<%=basePath%>user/enterMain.do">首页</a><i
								class="fa fa-circle"></i></li>
							<li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i
								class="fa fa-circle"></i></li>
							<li><span>蓝牙手环课程</span></li>
						</ul>
					</div>
					<h3 class="page-title">蓝牙手环课程</h3>
					<div class="row">
						<div class="col-md-12 col-sm-12">
							<!-- 添加功能菜单结束 -->
							<div class="portlet box green m_margin_15_auto_0">

								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-list"></i>蓝牙手环课程列表
									</div>
								</div>
							</div>

							<div class="portlet light form-fit m_margin_0_0_15_0"
								style="margin-top: 10px;">
									<a class="btn btn-default" onclick="$('#courseName').val('');" data-toggle="modal" data-target="#addCourse">添加</a>
									<a class="btn btn-default" onclick="history.go(-1)">返回</a>
							</div>

							<div class="portlet-body flip-scroll">
								<table class="table table-hover table-bordered table-condensed"
									cellpadding="0" cellspacing="0">
									<thead>
										<th>名称</th>
										<th>创建人</th>
										<th>更新时间</th>
									</thead>
									<tbody id="tbody">

									</tbody>
								</table>
							</div>
						</div>
				<!--添加课程-->
				<div class="modal fade" id="addCourse" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-body">
							<div style="text-align:left;">
							  <h4>添加手环课程</h4>
							</div>
							<hr>
							<div style="text-align: center;">
							    <div class="modal-body">
									<div class="form-group">
									<label class="control-label col-md-3 col-lg-3" style="margin-top: 8px;">课程名称</label> 
									<input id="courseName" placeholder="请输入课程名称(30个汉字)" class="m_input form-control" type="text" style="width: 400px;">

									</div>
							</div>
							 </div>
							<div class="modal-footer" style="border-top: none; margin-right: 70px;">
								<button type="button" class="btn btn-success"  onclick="saveCourse(this);">确定</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							</div>
						</div>
					</div>
		        </div>
		        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部开始 -->
	<%@ include file="/public_module/public_footer.jsp"%>
	<script src="<%=basePath%>assets/global/plugins/map.js" type="text/javascript" ></script>
	<!-- 底部结束 -->
</body>
<!-- 公共js开始 -->
<%@ include file="/public_module/public_js.jsp"%>
<!-- 公共js结束 -->
<script type="text/javascript">
    var clazzUserMap=new Map();
    $(function(){
    	loadSubMenu("assetManagement");  
		//选取当前菜单位置
		setActive("assetManagement","bluetoothList");   
		init();
    });
    //初始化数据
    function init(){
    var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
   	 $.ajax({
			type: "post",
			url: "<%=basePath%>bracelet/getAllBluetoothCourse.do",
			dataType:"json",
			data:{},
			success: function(data){
				var html='';
				if(data!=null && data.length>0){
					for(var i=0;i<data.length;i++){
						html+='<tr>';
						html+='<td>'+data[i].name+'</td>';
						html+='<td>'+data[i].userName+'</td>';
						html+='<td>'+data[i].updateTime+'</td>';
						html+='<tr>';
					}
				}
				$("#tbody").html(html);
			layer.close(indexlayer);
			}
		});
    }
    //添加课程
    function saveCourse(obj){
    	var courseName=$.trim($("#courseName").val());
    	if(courseName==""){
    		layer.tips("请输入课程名称",$("#courseName"));
    		return;
    	}else if(courseName.length>30){
    		layer.tips("最多30个字",$("#courseName"));
    		return;
    	}
    	 var indexlayer = layer.msg('正在保存数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
    	 $.ajax({
  			type: "post",
  			url: "<%=basePath%>bracelet/saveCourse.do",
  			dataType:"json",
  			data:{
  				"name":courseName
  				},
  			success: function(data){
  				layer.close(indexlayer);
  				if(data==200){
  					layer.msg("保存成功",{icon:1,time:1000}); 
  					$(obj).next().click();
  					init();
  				}else{
  					layer.msg("保存失败",{icon:2,time:1000}); 
  				}
  			}
  		});
    }
    </script>
</html>