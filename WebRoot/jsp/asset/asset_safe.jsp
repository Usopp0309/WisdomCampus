<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>安全隐患排查表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->
 	<style type="text/css">
 		input[type="radio"]{margin-left:-2px!important;}
 		#asset_detailed{margin-left:16%;}
 	</style>
</head>
	<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed" id="body">
		<input class="themes" type="hidden" value="<%=ThemePath%>">
		<input  type="hidden" value="${schoolId}" id=schoolId>
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
	                        <li><a href="<%=basePath%>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
	                        <li><a href="<%=basePath%>asset/toAssetInfoList.do">资产管理</a><i class="fa fa-circle"></i></li>
	                        <li><span>安全隐患排查表</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">安全隐患排查表</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
										<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
											</li>
										</c:if>
								</c:forEach>
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
		                        <r:right rightCode="assetServicemanManager">
	                        		<a class="btn blue btn-default" href="<%=basePath%>securityDanger/toAddSecurityDanger.do">添加排查人员</a>
		                        </r:right>	
		                        	<a class="btn green btn-default" href="<%=basePath%>securityDanger/toDangerPersonList.do">查看排查人员</a>
	                        </div>
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	                         	<div style="width: 20.6666%;" class="col-md-3 col-sm-3 col-lg-2 m_margin_top-15">
	                         		<span style="text-align: left;width:25%;" class="m_span">隐患类型：</span>
	                         		<select style="width: 70%;" class="form-control m_select" id="type" onchange="initData(1);">
	                         		
                                      </select>
	                         	</div>
		                         <div class="col-md-3 col-sm-3 col-lg-2 m_margin_top-15">
			                         <button type="button" id="search" class="btn green">查找</button>
		                         </div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>安全隐患排查表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    <thead class="flip-content">
	                                        <tr>
	                                            <th class="m_width_10 hidden-md hidden-sm">隐患类型</th>
	                                            <th class="m_width_45">隐患描述</th>
	                                            <th class="m_width_10">上报人</th>
	                                            <th class="m_width_10">上报人号码</th>
	                                            <th class="m_width_15">上报时间</th>
	                                            <th style="text-align: center;" class="m_width_5">操作</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="tbody">
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                       <!-- 列表展现开始 -->
	                        <!-- 分页开始 -->
	                        <%@include file="/public_module/public_page.jsp" %>
	                        <!-- 分页结束 -->
	                        <!-- 弹窗开始  大小参数：modal-lg, modal-sm-->
						    <div class="modal fade" id="small"  role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-lg">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">安全隐患排查表详情</h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                	<div class="row m_margin_10_auto search_box">
						                		<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">隐患类型：</span>
					                         		<input class="m_input form-control"  id="dtype" readonly="readonly" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">上报人：</span>
					                         		<input class="m_input form-control"  readonly="readonly" id="dname" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">上报人号码：</span>
					                         		<input class="m_input form-control"  readonly="readonly" id="dphone" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">上报时间：</span>
					                         		<input class="m_input form-control"  readonly="readonly" id="dtime" type="text">
					                         	</div>
					                         </div>
					                         <div class="row m_margin_10_auto search_box">
					                          
						                         <div style="margin-left:49px;" class="col-md-11 col-sm-11 col-lg-11 m_margin_top-15">
						                         		<span class="m_display_inline m_float_left m_width_10">排查人员</span>
						                         		<textarea readonly="readonly" style="margin-left: -12px;height:70px;background-color: #fff;" class="m_width_90 m_float_left form-control" id="person_" ></textarea>
					                         	</div>
						                         <div style="margin-left:49px;" class="col-md-11 col-sm-11 col-lg-11 m_margin_top-15">
						                         		<span class="m_display_inline m_float_left m_width_10">隐患描述</span>
						                         		<textarea readonly="readonly" style="margin-left: -12px;height:100px;background-color: #fff;" class="m_width_90 m_float_left form-control" id="remark"></textarea>
					                         	</div>
					                         </div>
					                         <div class="col-md-6 col-sm-6 col-lg-6 m_margin_top-15">
					                         		<span style="position: absolute;left:20%;" class="m_span">图片</span>
					                         		<div style="margin-left:28%;width:100%;" id="img_">
					                         		
					                         		</div>
					                         		
					                         </div>
						                </div>
						                <div class="modal-footer">
						                    <button type="button" class="btn" data-dismiss="modal">关闭</button>
						                </div> 
						            </div>
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
    <script src="<%=basePath%>assets/global/plugins/map.js" type="text/javascript"></script>
    <!-- 公共js结束 -->
   <script type="text/javascript">
   var map=new Map();
   	$(function(){
   	    //选取当前菜单位置
   		setActive("assetManagement","securityDanger"); 
   	    var jsons=eval(${typeJson});
   	    var option='<option value="">全部</option>';
   	    for(var i=0;i<jsons.length;i++){
   	    	option+='<option value="'+jsons[i].id+'">'+jsons[i].name+'</option>';
   	    	map.put(jsons[i].id,jsons[i].name);
   	    }
   	    $("#type").html(option);
   		initData(1);
   	});
   	//初始化数据
   	function initData(cPage)
	{
   		var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
   		var type=$("#type").val();
   		var roleId = $("#userTab li.active").find('a').attr("attr2");
		$.ajax({
			type: "post",
			url: "<%=basePath%>securityDanger/getPages.do",
			data:{
				roleCode:roleId,
				type : type,
				page:cPage
			},
			dataType:"json",
			error:function(){
				layer.close(indexlayer);
				},
			success: function(data){
				$("#currentPage").html(data.currentPage);
				$("#totalPage").html(data.totalPage);
				var appendHtml = '';
				var list=data.list;
				if(list!=null && list.length>0){
					for(var i=0;i<list.length;i++){
						appendHtml+='<tr><td>'+map.get(list[i].type)+'</td><td>'+list[i].desc+'</td><td>'+list[i].userName+'</td><td>'+list[i].phone+'</td><td>'+list[i].createTime+'</td><td><a  class="btn btn-sm green" data-toggle="modal" href="#small" onclick="showDetail('+list[i].id+')">详情</a></td></tr>';	
					}
				}
				$("#person_").css({"width":(900*0.8)});
				$("#img_").css({"width":(900*0.8)});
      			$("#tbody").html(appendHtml);
      			layer.close(indexlayer);
			},
		});
	}
   	//获得详细
   	function showDetail(id){
   		var indexlayer = layer.msg('正在加载数据,请稍候。。。',{icon: 16,time:0,shade:0.3});
   		$.ajax({
			type: "post",
			url: "<%=basePath%>securityDanger/getSecurityDangerDetails.do",
			data:{
				id:id
			},
			dataType:"json",
			error:function(){
			layer.close(indexlayer);
			},
			success: function(data){
				$("#dtype").val(map.get(data.type));
				$("#dname").val(data.userName);
				$("#dphone").val(data.phone);
				$("#dtime").val(data.createTime);
				$("#dname").val(data.userName);
				$("#remark").val(data.desc);
				var details=data.details;
				var person=[];
				for(var i=0;i<details.length;i++){
					person.push(details[i].realName);
				}
				$("#person_").text(person.join(","));
				var imgHtml='';
				var attachments=data.attachments;
				for(var i=0;i<attachments.length;i++){
					imgHtml+='<img src="'+attachments[i].url+'" style="width:200px;height:150px;float: left;">';
				}
				$("#img_").html(imgHtml);
				layer.close(indexlayer);
			}
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
		initData(cPageInt);
	    $("#currentPage").html(cPageInt);
	}
   </script>
</html>