<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>菜单管理-更改</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->  
 	<style type="text/css">
 	.sort{width:100px;height: 20px;border:none;margin:5px;padding: 20px;}
 	.table>tbody>tr>td{vertical-align:middle;padding: 0px;}
 	#modal_table tr td{padding:10px;}
 	#modal_table tr td:eq(0){background: rgb(245.245.245);}
 	#modal_table input[type='text']{border: 1px solid #f1f1f1;width: 160px;height: 30px;padding:10px;}
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
	                      <div class="portlet box green m_margin_15_auto_0">
	                        <div class="portlet-body">
	                           <table class="table table-bordered table-hover table-condensed" id="tab">
	                           <caption>
<!-- 	                              <button type="button" class="btn btn-default btn-sm"><i class="fa fa-file-text-o"></i>修改</button> -->
<!-- 	                              <button type="button" class="btn btn-default btn-sm"><i class="fa fa-trash-o"></i>删除</button> -->
<!-- 	                              <button type="button" class="btn btn-default btn-sm"><i class="fa fa-save"></i>保存排序</button> -->
	                              
	                              <a href="<%=basePath%>menu/cleanMenuCache.do"><button type="button" class="btn btn-default btn-sm"><i class="glyphicon glyphicon-repeat"></i>清楚菜单缓存</button></a>
	                              <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#add" onclick="addChildM(0,1);"><i class="fa fa-plus"></i>添加一级菜单</button>
	                           </caption>
	                                    <thead>
	                                        <tr>
	                                            <th style="width:50px;text-align:center;"><input type="checkbox" name=""/></th>
	                                            <th>名称</th>
												<th style="text-align:center;">链接</th>
	                                            <th style="width:200px;text-align: center;">排序</th>
	                                            <th style="width:100px;text-align: center;">状态</th>
												<th style="text-align: center;">权限标识</th>
	                                            <th style="text-align: center;">操作</th>
	                                       </tr>
	                                    </thead>
	                                    <tbody id="tbody">
	                                     </tbody>
	                                 </table>
		                        </div>
	                        </div>
	                        
	                        <!-- 查看 ，修改 ，添加 弹窗 start-->
						<div class="modal fade" id="update"  role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-lg">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 id="updateOrSee" class="modal-title"></h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                      <table class="table table-bordered table-condensed table-hover" id="modal_table">
						                            <tr>
<!-- 						                            <input type="text" id="upMenu"  placeholder="父级菜单"> -->
							                             <td>上级菜单：</td>
							                             <td>
							                             <input id="upSize" style="display: none;"/>
								                             <select id="parentSelect" onchange="chSelect(0);">
								                             </select> 
							                             </td>
							                             <td>名称：</td>
							                             <td><input type="text" id="upName"  placeholder="菜单名"></td>
						                            </tr>
						                            <tr>
							                             <td>链接：</td>
							                             <td><input type="text" id="upUrl" placeholder="地址（url）"></td>
							                             <td>图标：</td>
							                             <td><button type="button" class="btn btn-success">选择</button><button type="button" class="btn btn-default">清除</button></td>
							                            
							                         </tr>
						                            <tr>
							                             <td>排序：</td>
							                             <td><input type="text" id="upOrders" ></td>
							                             <td>状态：</td>
							                             <td>
							                             	<select id="upStatus">
							                             		<option value="0">启用</option>
							                             		<option value="1">禁用</option>
							                             	
							                             	</select>
							                             </td>
						                            </tr>
						                            <tr>
							                             <td>权限名称：</td>
							                             <td><input type="text" id="uPermissionName"></td>
							                             <td>权限标识：</td>
							                             <td><input type="text"  id="upPermissionCode" placeholder="权限编码" readonly="readonly"> </td>
							                        </tr>
<!-- 						                            <tr> -->
<!-- 							                             <td>状态：</td> -->
<!-- 							                             <td><input type="text" id="upStatus"></td> -->
<!-- 							                             <input type="text" id="upType" style="display: none;"> -->
<!-- 							                        </tr> -->
							                        
						                     </table>	
						                </div>
						                <div class="modal-footer">
						                	<button type="button" class="btn green" onclick="updateM()" id="butt">确定</button>
						                    <button type="button" class="btn" data-dismiss="modal">关闭</button>
						                    <input id="upId" style="display: none;"/>
						                    <input type="text" id="upType" style="display: none;">
						                </div>  
						            </div>
						        </div>
						    </div>
					
						<div class="modal fade" id="add"  role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-lg">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">添加菜单</h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                      <table class="table table-bordered table-condensed table-hover" id="modal_table">
						                            <tr>
							                             <td>上级菜单：</td>
							                             <td>
							                              	<select id="parentSelect1" onchange="chSelect(1);" disabled="disabled">
								                             </select> 
							                             </td>
							                             <td>名称：</td>
							                             <td><input type="text" id="name" placeholder="菜单名"></td>
						                            </tr>
						                            <tr>
							                             <td>主键标识：</td>
							                             <td><input type="text" id="id"  placeholder="ID" onblur="getMenuById(this);"></td>
						                            </tr>
						                            <tr>
							                             <td>链接：</td>
							                             <td><input type="text" id="url" placeholder="地址（url）" ></td>
							                             <td>图标：</td>
							                             <td><button type="button"  class="btn btn-success">选择</button><button type="button" class="btn btn-default">清除</button></td>
							                         </tr>
							                             <td>权限描述(中文描述)：</td>
							                             <td><input type="text" id="permissionName"></td>
							                             <td>权限名称：</td>
							                             <td><input type="text" id="permissionCode" placeholder="权限编码" onblur="getPermiByCode(this,3);"> </td>
							                        </tr>
						                            <tr>
							                             <td>排序：</td>
							                             <td><input type="text" id="orders" readonly="readonly"></td>
<!-- 							                             <td>可见：</td> -->
<!-- 							                             <td><input type="radio" name="isVisible">显示<input type="radio" name="isVisible">隐藏</td> -->
						                            </tr>
						                            <tr>
						                     </table>	
						                </div>
						                <div class="modal-footer">
						                	<button type="button" class="btn green" onclick="addMenu();" id="addMenuB">确定</button>
						                    <button type="button" class="btn" data-dismiss="modal">关闭</button>
						                    <input id="size" style="display: none;"/>
						                </div>  
						            </div>
						        </div>
						    </div>
						    
						    
							<div class="modal fade" id="updatep"  role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-lg">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 id="butUpdateOrSee" class="modal-title"></h4>
						                    
						                </div>
						                <div class="modal-body m_padding_top_0">
						                      <table class="table table-bordered table-condensed table-hover" id="modal_table">
						                            <tr>
							                             <td>权限描述：</td>
							                             <td><input type="text" id="upPermissionNamep"  ></td>
							                             <td>父页面菜单权限：</td>
							                             <td><select id="upPermissionSelect" >
								                           </select> </td>
						                            </tr>
<!-- 							                             <td >类型：</td> -->
<!-- 							                             <td> -->
<!-- 							                             	<input id="upTypep"  type="text" readonly="readonly"/> -->
<!-- 							                             </td> -->
						                     </table>	
						                </div>
						                <div class="modal-footer">
						                	<button type="button" class="btn green" onclick="updatePermission()" id="perButt">确定</button>
						                    <button type="button" class="btn" data-dismiss="modal">关闭</button>
						                    <input id="upId" style="display: none;" type="text"/>
						                    <input id="upTypep" style="display: none;" type="text"/>
						                    <input type="text" id="upPermissionCodep" style="display: none;">
<!-- 						                    <input type="hidden"  name="assetId" id="assetId"> -->
						                </div>  
						            </div>
						        </div>
						    </div>
						        
						<div class="modal fade" id="addButtonPer"  role="dialog" aria-hidden="true">
						     <div class="modal-dialog modal-lg">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">添加按钮权限</h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                      <table class="table table-bordered table-condensed table-hover" id="modal_table">
						                            <tr>
							                             <td>父页面菜单权限：</td>
							                             <td><select id="upPermissionSelect1"  disabled="disabled">
								                           </select> </td>
								                           <td>权限名称</td>
								                           <td><input type="text" id="permissionCodep"  onblur="getPermiByCode(this,3);"></td>
							                        </tr>
						                            <tr>
							                             <td>权限描述：</td>
							                             <td><input type="text" id="permissionNamep"  ></td>
<!-- 							                             <td>类型：</td> -->
<!-- 							                             <td> -->
<!-- 							                             	<select id="typep"> -->
<!-- 							                             		<option value="0">菜单权限</option> -->
<!-- 							                             		<option value="1">按钮权限</option> -->
<!-- 							                             	</select> -->
							                             
<!-- 							                             </td> -->
						                            </tr>
						                     </table>	
						                </div>
						                <div class="modal-footer">
						                	<button type="button" class="btn green" onclick="addPermission()" id="perButt">确定</button>
						                    <button type="button" class="btn" data-dismiss="modal">关闭</button>
						                    <input id="typep"  value="1" style="display: none;" type="text"/>
						                </div>  
						            </div>
						        </div>
						    </div>
						 <!-- 查看 ，修改 ，添加 弹窗 end-->
						
						
						<!-- 删除弹窗 start-->
						<div class="modal fade" id="delete" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-body">
									<div style="text-align:left;">
									  <h4>系统提示</h4>
									</div>
									<hr>
									<div style="text-align: center;">
									    <i class="layui-layer-ico layui-layer-ico3"></i>
									    <h3>要删除该菜单及所有子菜单项吗？</h3>
									</div>
									 </div>
									<div class="modal-footer"
										style="border-top: none; margin-right: 70px;">
										<input style="display: none;" id="dMenuId"  type="text"/>
										<button type="button" class="btn btn-success" onclick="onsubmit();">确定</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
									</div>
								</div>
							</div>
						</div>
						<!--删除弹窗end  -->
	                        
	                        
	                      </div>
	                    </div>
	                  </div>
	                <!--页面内容结束 -->
	            </div>
	        </div>
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
			loadMenuList();
			getAllMenu();
			getByParentCodeNull();
			
		});
      
      
      /*切换折叠指示图标*/
		function showHide(obj, idvlue) {
			
			$(obj).find("span").toggleClass("glyphicon-chevron-down");
			$(obj).find("span").toggleClass("glyphicon-chevron-up");
			    var id=$(obj).attr("id");
			if ($(obj).find("span").hasClass("glyphicon-chevron-down")) {
				$("tr[id^=" + idvlue + "_]").each(function() {
					$(this).show();
				});
			} else {
				 $("tr[id^='"+idvlue+"_']").each(function(){
	        		   $(this).hide();
	         	  });
				if (id) {
					$("tr[name^='" + id + "_']").each(function() {
						$(this).hide(500);
					});

				}

			}

		}
		//父级菜单下拉
		function getAllMenu() {
		
			$.ajax({
				type : "post",
				url : "<%=basePath%>menu/getAllMenus.do",
				data:{
				},
				success: function(data){
					var list = $.parseJSON(data);
					 var size =1;
					 appendHtml ='<option value="">--上级菜单 --</option>';
					$.each(list, function(n, value) {
						 appendHtml += '<option value="'+value.id+'">'+value.name+'</option>';
						 if(n==(list.length-1)){
							 size =value.orders
						 }
					}); 
					$("#parentSelect").html(appendHtml);
					$("#parentSelect1").html(appendHtml);
					$("#size").val(size+1);
					$("#upSize").val(size+1);
// 					alert(size);
					chSelect(1);
				}
			});
      }
     
   
		//根据ID查询菜单
		function getMapById(id,num){
			//1表示查看，2表示修改
			if(num == 1){
				$("#butt").hide();
				$("#updateOrSee").html("菜单查看");
			}else{
				$("#butt").show();
				$("#updateOrSee").html("菜单修改");
			}
			$.ajax({
				type: "post",
				url: "<%=basePath%>menu/getMenusById.do",
				data:{
					id:id
				},
				success: function(data){
					var m = $.parseJSON(data);
					var menu = m.Menu;
					var p = m.Permission;
					if(p != null){
						$("#uPermissionName").val(p.permissionName);
						$("#upType").val(p.type);
					}
					if(num == 11){
						$("#parentSelect").attr("disabled","disabled");
					}else{
						$('#parentSelect').attr("disabled",false); 
						$("#parentSelect").val(menu.parentId);
					}
					$("#upId").val(menu.id);
					$("#upName").val(menu.name);
					$("#upUrl").val(menu.url);
					$("#upPermissionCode").val(menu.permissionCode);
					$("#upOrders").val(menu.orders);
					$("#upStatus").val(menu.status);
					
				}
			});
		}
		//查询权限(判断是否重复)
		function getPermiByCode(code,num){
			//1表示查看，2表示修改
			if(num == 3){
				var id=$(code).attr("id");
				var value = $(code).val();
				code = value;
			}
			else if(num == 2){
				$("#perButt").show();
				$("#butUpdateOrSee").html("按钮权限修改");
			}else{
				$("#perButt").hide();
				$("#butUpdateOrSee").html("按钮权限查看");
			}
			
			$.ajax({
				type: "post",
				url: "<%=basePath%>menu/getPermiByCode.do",
				data:{
					permissionCode:code
				},
				success: function(data){
					
					var p = $.parseJSON(data);
					if(num == 3 ){
						if( p != null ){
							layer.tips('权限名称已存在，请重新输入！', '#'+id+'');
							$("#addMenuB").hide();
						}else{
							$("#addMenuB").show();
						}
					}else{
						$("#upPermissionNamep").val(p.permissionName);
						$("#upTypep").val(p.type);
						$("#upPermissionSelect").val(p.parentCode);
						$("#upPermissionCodep").val(p.permissionCode);
					}
					
				}
			});
		}
		//判断重复
		function getMenuById(obj){
			var id=$(obj).attr("id");
			var value = $(obj).val();
			$.ajax({
				type: "post",
				url: "<%=basePath%>menu/getMenuById.do",
				data:{
					id:value
				},
				success: function(data){
					var p = $.parseJSON(data);
					if(p != null){
						layer.tips('主键已存在，请重新输入！', '#'+id+'');
						$("#addMenuB").hide();
					}else{
						$("#addMenuB").show();
					}
				}
			});
		}
		
		//查询有父级的权限
		function getByParentCodeNull(){
			$.ajax({
				type: "post",
				url: "<%=basePath%>menu/getByParentCodeNull.do",
				data:{
				},
				success: function(data){
					var list = $.parseJSON(data);
					 appendHtml ='<option value="">--上级菜单 --</option>';
					$.each(list, function(n, value) {
						 appendHtml += '<option value="'+value.permissionCode+'">'+value.permissionName+'</option>';
					}); 
					$("#upPermissionSelect").html(appendHtml);
					$("#upPermissionSelect1").html(appendHtml);
				}
			});
		}
		//添加菜单
		function addMenu(){
			var flag =true;
			var id = $("#id").val();
			var name = $("#name").val();
			var parentId = $("#parentSelect1").val();
			var url = $("#url").val();
			var permissionCode = $("#permissionCode").val();
			var orders = $("#orders").val();
			var permissionName = $("#permissionName").val();
			
			if(id == null || id == '' || id.length>25){
				layer.msg('主键不能为空！且不能超过25字符！', {icon: 2}); 
			}
			if(parentId != null && parentId != ""){
				if(permissionCode == null || permissionCode == '' || permissionCode.length>25){
					layer.tips('权限标识不能为空！且不能超过25字符！', '#permissionCode');
					flag = false;
				}
				if(permissionName == null || permissionName == '' || permissionName.length>25){
					layer.tips('权限描述不能为空！且不能超过25字符！', '#permissionName');
					flag = false;
				}
			}else{
				if( permissionCode.length>25){
					layer.tips('不能超过25字符！', '#permissionCode');
					flag = false;
				}
				if( permissionName.length>25){
					layer.tips('不能超过25字符！', '#permissionName');
					flag = false;
				}
			}
			if(flag){
				$.ajax({
					type: "post",
					url: "<%=basePath%>menu/addMenus.do",
					data:{
						id:id,
						name:name,
						parentId:parentId,
						url:url,
						permissionCode:permissionCode,
						orders:orders,
						permissionName:permissionName
					},
					success: function(data){
						if(data == 0){
							layer.msg('添加成功！', {icon: 1});
							window.location.href="<%=basePath%>menu/toMenuConfig.do";
						}else{
							layer.msg('添加失败！', {icon: 2});
						}
					}
				});
			}
			
			
			
		}
		//修改菜单
		function updateM(){
			var flag = true;
			var id = $("#upId").val();
			var name = $("#upName").val();
			var parentId = $("#parentSelect").val();
			if(parentId==''){
				parentId=null;
			}
			var url = $("#upUrl").val();
			var permissionCode = $("#upPermissionCode").val();
			var orders = $("#upOrders").val();
			var status = $("#upStatus").val();
			var permissionName = $("#uPermissionName").val();
			var type = $("#upType").val();
			if(parentId !=null && parentId != ""){
				if(permissionCode == null || permissionCode == '' || permissionCode.length>25){
					layer.msg('权限标识不能为空！且不能超过25字符！', {icon: 2});
					flag = false;
				}
				if(permissionName == null || permissionName == '' || permissionName.length>25){
					layer.msg('权限描述不能为空！且不能超过25字符！', {icon: 2});
					flag = false;
				}
			} else{
				if(permissionCode.length>25){
					layer.msg('不能超过25字符！', {icon: 2});
					flag = false;
				}
				if(permissionName.length>25){
					layer.msg('不能超过25字符！', {icon: 2});
					flag = false;
				}
			}
			
			if(flag){
				$.ajax({
					type: "post",
					url: "<%=basePath%>menu/updateMenuById.do",
					data:{
						id:id,
						name:name,
						parentId:parentId,
						url:url,
						status:status,
						permissionCode:permissionCode,
						orders:orders,
						icon:null,
						permissionName:permissionName,
						type:type
					},
					success: function(data){
						if(data == 0){
							layer.msg('修改成功！', {icon: 1});
							window.location.href="<%=basePath%>menu/toMenuConfig.do";
						}else{
							layer.msg('修改失败！', {icon: 2});
						}
					}
				});
			}
		}
		
		
		//根据id删除菜单
		function deleteMenu(id,name){
			layer.msg('是否删除删     “  '+name+' ”  该菜单及所有子菜单项吗？', {
				  time: 0 //不自动关闭
				  ,btn: ['确定','取消']
				  ,yes: function(index){
				    layer.close(index);
				    $.ajax({
						type: "post",
						url: "<%=basePath%>menu/deleteMenuById.do",
						data:{
							id:id
						},
						success: function(data){
							if(data == 0){
								layer.msg('删除成功！', {icon: 1});
								window.location.href="<%=basePath%>menu/toMenuConfig.do";
							}else{
								layer.msg('删除失败！', {icon: 2});
							}
						}
					});
				    
				  }
				});
		}
		
		
		//添加按钮权限
		function addPermission(){
			var flag = true;
			var permissionName = $("#permissionNamep").val();
			var type = $("#typep").val();
			var parentCode = $("#upPermissionSelect1").val();
			var permissionCode = $("#permissionCodep").val();
			if(permissionName==null || permissionName=='' || permissionName.length>25){
				layer.tips('权限描述不能为空，且不能超过25字符！', '#permissionNamep');
				flag=false;
			}
			if(permissionCode==null || permissionCode=='' || permissionCode.length>25){
				layer.tips('权限名称不能为空，且不能超过25字符！', '#permissionCodep');
				flag=false;
			}
			if(parentCode==null || parentCode=='' ){
				layer.tips('父类权限不能为空！', '#upPermissionSelect1');
				flag=false;
			}
			if(flag){
				$.ajax({
					type: "post",
					url: "<%=basePath%>menu/addPermisssion.do",
					data:{
						permissionName:permissionName,
						type:type,
						parentCode:parentCode,
						permissionCode:permissionCode
					},
					success: function(data){
						if(data == 0){
							layer.msg('修改成功！', {icon: 1});
							window.location.href="<%=basePath%>menu/toMenuConfig.do";
						}else{
							layer.msg('修改失败！', {icon: 2});
						}
					}
				});
			}
			
		}
		
		//修改权限
		function updatePermission(){
			var permissionName = $("#upPermissionNamep").val();
			var type = $("#upTypep").val();
			var parentCode = $("#upPermissionSelect").val();
			var permissionCode = $("#upPermissionCodep").val();
			if( permissionName == null || permissionName== ''){
				layer.msg('修改成功！', {icon: 1});
			}
			$.ajax({
				type: "post",
				url: "<%=basePath%>menu/updatePermissiom.do",
				data:{
					permissionName:permissionName,
					type:type,
					parentCode:parentCode,
					permissionCode:permissionCode
				},
				success: function(data){
					if(data == 0){
						layer.msg('修改成功！', {icon: 1});
						window.location.href="<%=basePath%>menu/toMenuConfig.do";
					}else{
						layer.msg('修改失败！', {icon: 2});
					}
				}
			});
		}
		
		//通过code(主键)删除权限
		function deletePermession(code,name){
			layer.msg('是否删除     “  '+name+'  ”  权限？', {
				  time: 0 //不自动关闭
				  ,btn: ['确定','取消']
				  ,yes: function(index){
				    layer.close(index);
				    $.ajax({
						type: "post",
						url: "<%=basePath%>menu/deleteByPermissionCode.do",
						data:{
							permissionCode:code
						},
						success: function(data){
							if(data == 0){
								layer.msg('删除成功！', {icon: 1});
								window.location.href="<%=basePath%>menu/toMenuConfig.do";
							}else{
								layer.msg('删除失败！', {icon: 2});
							}
						}
					});
				    
				  }
				});
		}
		
		//加载所有数据
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
							for(var n =0;n<list.length;n++){
							var value = list[n];
							var permissionCode = value.permissionCode;
							var a = "a"+n;
							var url = value.url;
							if(permissionCode == 'undefined' || permissionCode == null){
								permissionCode = '';
							}
							if(url == 'undefined' || url == null){
								url = '';
							}
	                            appendHtml += '<tr><td style="text-align:center;"></td>';
	                            appendHtml += '<td><div class="panel-heading collapsed" style="background:none;" id="abc'+n+'" onclick="showHide(this,\''+a+'\');">';
	                            appendHtml += ' <h4 class="panel-title" style="font-size:14px;cursor:pointer;color:#23527c;">';
	                            appendHtml += '<span class="glyphicon glyphicon-chevron-up right" style="color:gray;font-size:12px;margin-right:5px;"></span>'+value.name+'</h4></div></td>';
	                            appendHtml += '<td>'+url+'</td>';
	                            appendHtml += ' <td><input type="text" class="sort" value="'+value.orders+'"/></td>';
	                            if(value.status == 0){
	                            	appendHtml += '<td style="text-align:center"><a type="button" class="btn btn-success btn-xs">启用</a></td>';
	                            }else{
	                            	appendHtml += '<td style="text-align:center"><a type="button" class="btn btn-danger btn-xs">禁用</a></td>';
	                            }
	                            appendHtml += '<td>'+permissionCode+'</td>';
	                            
	                            appendHtml += ' <td><a class="btn btn-info btn-xs"    data-toggle="modal" data-target="#update" onclick="getMapById(\''+value.id+'\',1)"><i class="fa fa-search-plus"></i>查看</a>';
	                            appendHtml += ' <a class="btn btn-success btn-xs" data-toggle="modal" data-target="#update" onclick="getMapById(\''+value.id+'\',11)"><i class="fa fa-edit"></i>修改</a>';
	                            appendHtml += '<a class="btn btn-danger btn-xs"  onclick="deleteMenu(\''+value.id+'\',\''+value.name+'\');" ><i class="fa fa-trash"></i>删除</a>';
	                            appendHtml += '<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#add" onclick="addChildM(\''+value.id+'\',1);"><i class="fa fa-plus"></i>添加下级菜单</a>';
	                            appendHtml += ' </td></tr>';
								var chList = value.subMenuList;
								for(var i = 0; i<chList.length; i++){
									var value1 = chList[i];	
									var permissionCode = value1.permissionCode;
									var url = value1.url;
									if(permissionCode == 'undefined' || permissionCode == null){
										permissionCode = '';
									}
									if(url == 'undefined' || url == null){
										url = '';
									}
									var id = value1.id
									var b = "b"+a+i;
									 appendHtml += ' <tr style="display: none;" id="'+a+'_'+i+'" onclick="showHide(this,\''+b+'\');">';
									 appendHtml += '<td style="text-align:center;"></td>';
									 appendHtml += '<td style="padding-left:20px;">';
									 appendHtml += '<div class="panel-heading collapsed" style="background:none;">';
									 appendHtml += '<h4 class="panel-title" style="font-size:14px;cursor:pointer;color:#23527c;">';
									 appendHtml += '<span class="glyphicon glyphicon-chevron-up right" style="color:gray;font-size:12px;margin-right:5px;"></span>'+value1.name+'</h4> </div></td>';
									 appendHtml += '<td>'+url+'</td>';
									 appendHtml += '<td><input type="text" class="sort" value="'+value1.orders+'"/></td>';
									 if(value1.status == 0){
			                            	appendHtml += '<td style="text-align:center"><a type="button" class="btn btn-success btn-xs">启用</a></td>';
			                            }else{
			                            	appendHtml += '<td style="text-align:center"><a type="button" class="btn btn-danger btn-xs">禁用</a></td>';
			                            }
// 									 appendHtml += '<td>显示</td>';
									 appendHtml += '<td>'+permissionCode+'</td>';
									
									 appendHtml += ' <td><a class="btn btn-info btn-xs"    data-toggle="modal" data-target="#update" onclick="getMapById(\''+value1.id+'\',1)"><i class="fa fa-search-plus"></i>查看</a>';
			                         appendHtml += ' <a class="btn btn-success btn-xs" data-toggle="modal" data-target="#update" onclick="getMapById(\''+value1.id+'\',2)"><i class="fa fa-edit"></i>修改</a>';
			                         appendHtml += '<a class="btn btn-danger btn-xs"  onclick="deleteMenu(\''+value1.id+'\',\''+value1.name+'\');" ><i class="fa fa-trash"></i>删除</a>';
			                         appendHtml += '<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#addButtonPer" onclick="addChildM(\''+value1.id+'\',2);"><i class="fa fa-plus"></i>添加按钮权限</a>';
			                         appendHtml += '</td></tr>';
									
		                            var subPermissionList = value1.subPermissionList;
										for(var j = 0; j<subPermissionList.length; j++){
		                            	 var value2 = subPermissionList[j];	
	                              		 appendHtml += '<tr style="display: none;" name="abc'+n+'_'+j+'" id="'+b+'_'+j+'">';
	                              		 appendHtml += '<td style="text-align:center;"></td>';
	                              		 appendHtml += '<td style="padding-left:40px;">';
	                              		 appendHtml += '<div class="panel-heading collapsed" style="background:none;">';
	                              		 appendHtml += '<h4 class="panel-title" style="font-size:14px;cursor:pointer;color:#23527c;"> '+value2.permissionName +'</h4></div></td>';
	                              		 appendHtml += '<td></td>';
	                              		 appendHtml += '<td></td>';
	                              		 appendHtml += '<td></td>';
	                              		 appendHtml += '<td>'+value2.permissionCode+'</td>';
	                              		 
	                              		 appendHtml += ' <td><a class="btn btn-info btn-xs"    data-toggle="modal" data-target="#updatep" onclick="getPermiByCode(\''+value2.permissionCode+'\',1)"><i class="fa fa-search-plus"></i>查看</a>';
		   		                         appendHtml += ' <a class="btn btn-success btn-xs" data-toggle="modal" data-target="#updatep" onclick="getPermiByCode(\''+value2.permissionCode+'\',2)"><i class="fa fa-edit"></i>修改</a>';
		   		                         appendHtml += '<a class="btn btn-danger btn-xs"   onclick="deletePermession(\''+value2.permissionCode+'\',\''+value2.permissionName+'\')"><i class="fa fa-trash"></i>删除</a>';
// 		   		                      	 appendHtml += '<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#addButtonPer" ><i class="fa fa-plus"></i>添加按钮权限</a>';
		   		                         appendHtml += '</td></tr>';
		                            }
		   		                         
		                            
		                            
								}
							
							}
	        			$("#tbody").html(appendHtml);
	        			
	        			//解锁UI
	        			App.unblockUI(body);
							
					}
				});
			}
		
		 //下拉事件
	      function chSelect(num){
	    	 var selectVal='';
	    	 if(num == 0){
	    		 selectVal = $("#parentSelect").val();//修改
	    		 if( selectVal=='' ||selectVal==null){
	    			 $("#upOrders").val(size);
	    	    	}else{
	    	    		$.ajax({
		 					type: "post",
		 					url: "<%=basePath%>menu/getChildCount.do",
		 					data:{
		 						parentId:selectVal
		 					},
		 					success: function(data){
		 						$("#upOrders").val(parseInt(data)+1);
		 					}
		 				});
	    	    	}
	    	 }
	    	 
	    	 if(num == 1){
				selectVal = $("#parentSelect1").val();//添加
	    		 if( selectVal=='' ||selectVal==null){
	    			 var size = $("#size").val();
	    		 	$("#orders").val(size);
	 	    	}else{
	 	    		$.ajax({
	 					type: "post",
	 					url: "<%=basePath%>menu/getChildCount.do",
	 					data:{
	 						parentId:selectVal
	 					},
	 					success: function(data){
	 						$("#orders").val(parseInt(data)+1);
	 					}
	 				});
	 	    	}
	    	 }
	    	 
	    	 
	      }
	     function addChildM(id,num){
	    	 
	    	 if(num==1){
	    		 if(id == 0){
	    			 id="";
	    		 }
	    	 	$("#parentSelect1").val(id);
	    	 	chSelect(1);
	    	 }else if(num==2){
	    		 $("#upPermissionSelect1").val(id);
	    	 }
	     }
	</script>
	</html>