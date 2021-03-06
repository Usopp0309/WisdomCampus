<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>菜单管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->  
 	<style type="text/css">
 	.menuconfig{}
 	.menuconfig .checkbox{display:inline-block;margin:0px 15px;}
 		
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
	                        <li><a href="">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="">系统管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>菜单管理</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">菜单管理</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">学校类型:</span>
	                         		<input class="m_input form-control" type="text" disabled="disabled" value="${version}">
	                         	</div>
	                         	<div class="col-md-4 col-sm-4 col-lg-3 m_margin_top-15">
	                         		<span class="m_span">学校：</span>
	                         		<input class="m_input form-control" type="text" disabled="disabled" value="${schoolName}">
	                         	</div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>菜单列表 <small>注：请勾选您需要的功能</small></div>
	                            </div>
	                            <div class="portlet-body">
	                                <table class="table table-bordered table-hover menuconfig">
	                                    <thead>
	                                        <tr>
	                                            <th class="m_width_15">一级菜单</th>
												<th class="m_width_85">二级菜单</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="tbody">
	                                       
	                                    </tbody>
	                                </table>
		                            <button type="button" onclick="submitMenu()" class="btn green">确定</button>
		                       		<button type="button" class="btn" id="cancel">返回</button>
	                            </div>
	                        </div>
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
			loadSubMenu("systemManage"); 
			//选取当前菜单位置
			setActive("systemManage","menuConfig"); 
			//加载初始化数据
			loadMenuList();
		});
		//加载教师页面
		function loadMenuList()
		{
			var body = $("#body");
			App.blockUI(body);
			$.ajax({
				type: "post",
				url: "<%=basePath%>menu/getMenusInfo.do",
				data:{
				},
				success: function(data){
					var list = $.parseJSON(data);
					var appendHtml = '';
					$.each(list, function(n, value) {  
           				appendHtml += '<tr><td class="firstMenu" style="text-align:left;padding-left:10px;">';
           				if (value.status=='0'){
           					
           					appendHtml += '<label class="checkbox"><input type="checkbox" name="menu" class="menuCheck" id="' + value.id + '" checked="true"/>' + value.name + '</label>';
           				}else{
           					appendHtml += '<label class="checkbox"><input type="checkbox" name="menu" class="menuCheck" id="' + value.id + '"/>' + value.name + '</label></td>';
           				}
           				appendHtml += '<td class="otherMenu" style="text-align:left;background-color:#fff">';
           				$.each(value.subMenuList, function(k,value1){
           					if (value1.status=='0'){
           						appendHtml += '<label class="checkbox"><input type="checkbox" name="menu" class="menuCheck" id="' + value1.id + '" checked="true"/>' + value1.name + '</label></label>';
           					}else{
           						appendHtml += '<label class="checkbox"><input type="checkbox" name="menu" class="menuCheck" id="' + value1.id + '"/>' + value1.name + '</label>';
           					}
           				});
           				appendHtml += '</td></tr>';
          			}); 
          			$("#tbody").html(appendHtml);
          			
          			//解锁UI
          			App.unblockUI(body);
          			$(".firstMenu").find("input").on("click",function(event){
						$(this).parent().parent().next().find("input").prop("checked",this.checked);
          			});
          		
	      			$(".otherMenu").find("input").on("click",function(){
	      				if(!$(this).is(':checked')){
		      				if($(this).parent().parent().find(":checked").length>0){
	  							$(this).parent().parent().prev().find("input").attr("checked",true);
							}else{
								$(this).parent().parent().prev().find("input").removeAttr("checked");
							}	
						}
	      				else
      					{
	      					$(this).parent().parent().prev().find("input").prop("checked",true);
      					}
	      				
					});
						
	          	
				}
			});
		}

		function submitMenu()
		{
			var l_=layer.confirm('是否确认修改菜单？', {
				  btn: ['确定', '取消'] //可以无限个按钮
				  
				}, function(){
					var d_ = layer.msg('正在修改,请稍候。。。',{icon: 16,time:0,shade:0.3});
					notCheckMenuId =[];
					checkMenuId =[];
					$("input:checkbox[name='menu']:checked").each(function(i)
					{
						checkMenuId.push($(this).attr("id"));
					});
					
					$("input:checkbox").not("input:checked").each(function(i)
					{
						notCheckMenuId.push($(this).attr("id"));
					});
					
					$.ajax({
						type: "post",
						url: "<%=basePath%>menu/doMenuConfig.do",
						data:{
							checkMenuId : JSON.stringify(checkMenuId),
							notCheckMenuId : JSON.stringify(notCheckMenuId)
						},
						success: function(data){
							if (data == '0'){
								layer.msg("修改成功！");
								loadMenuList();
							}
							layer.close(l_);
			        	    layer.close(d_);
						},
					});
				  
				}, function(){
					 layer.close(l_);
				});
			
		}
	</script>
	</html>