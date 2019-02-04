<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>资产列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->    
 	<style type="text/css">
 		input[type="radio"]{margin-left:-2px!important;}
 		table.table tbody#tbody thead th tr{padding: 10px;}
 		table.table tr td {
 		       padding: 10px;
 		       border: 1px solid #f1f1f1;
 		}
 		th{
 		   padding: 10px;
 		   border: 1px solid #f1f1f1;
 		}
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
	                        <li><span>资产信息</span></li>
	                    </ul>
	                </div>
	                <h3 class="page-title">资产信息</h3>
	                <div class="row">
	                    <div class="col-md-12 col-sm-12">
	                    	<div class="m_margin_0_0_15_0">
	                    		<!-- 角色切换开始 -->
	                    		<ul class="nav nav-tabs"  id="userTab">
	                                <c:forEach items="${sessionScope.user.roleList}" var="roleList">
									<r:right rightCode="assetInfoListManager">
										<c:if test="${roleList.roleCode ne 'parent' && roleList.roleCode ne 'student'}">
											<li class="roleLi">
												<a attr1="${sessionScope.user.userId}" attr2="${roleList.roleCode}" attr3="${sessionScope.user.permissionList}" >${sessionScope.user.realName}(${roleList.roleName})
											</a>
											</li>
										</c:if>
									</r:right>
								</c:forEach>	
	                            </ul>
	                    		<!-- 角色切换结束 -->
	                        </div>
	                        <!-- 添加功能菜单开始 -->
	                        <div class="portlet light form-fit m_margin_0_0_15_0">
	                        	<r:right rightCode="assetImportManager">
	                        		<a class="btn btn-default" href="<%=basePath%>asset/toAssetImport.do">资产导入</a>
	                        	</r:right>
	                        	<r:right rightCode="assetAddManager">
	                        		<a class="btn btn-default" href="<%=basePath%>asset/toAssetAdd.do">资产添加</a>
	                        	</r:right>
	                        	<a class="btn btn-default" onclick="exportQcode();">批量导出资产二维码</a>
	                        </div>
	                        <!-- 添加功能菜单结束 -->
	                        <!-- 页面搜索开始 -->
	                        <div class="portlet light form-fit bordered search_box">
	                        	
	                         <div class="row m_margin_10_auto">
	                         	<div class="col-md-3 col-sm-3 col-lg-2 m_margin_top-15">
	                         		<span class="m_span">资产所属：</span>
	                         		<select class="form-control m_select" id="personOrschool">
	                         			<option value="0">学校资产</option>
	                         			<option value="1">我的资产</option>
                                     </select>
	                         	</div>
	                         	<div class="col-md-3 col-sm-3 col-lg-2 m_margin_top-15">
	                         		<span class="m_span">资产类型：</span>
	                         		<select class="form-control m_select" id="type">
                                      </select>
	                         	</div>
								<div class="col-md-3 col-sm-3 col-lg-2 m_margin_top-15">
	                         		<span class="m_span">资产编号：</span>
	                         		<input class="m_input form-control" id="code" placeholder="输入资产编号……" type="text">
	                         	</div>
	                         	<div class="col-md-3 col-sm-3 col-lg-2 m_margin_top-15">
	                         		<span class="m_span">资产名称：</span>
	                         		<input class="m_input form-control" id="name" placeholder="输入资产名称……" type="text">
	                         	</div>
		                         <div class="col-md-3 col-sm-3 col-lg-2 m_margin_top-15">
			                         <button type="button" id="search" class="btn green">查找</button>
		                         </div>
	                         </div>
	                        </div>
	                       	<div class="portlet box green m_margin_15_auto_0">
	                            <div class="portlet-title">
	                                <div class="caption">
	                                    <i class="fa fa-list"></i>资产列表</div>
	                            </div>
	                            <div class="portlet-body flip-scroll">
	                                <table class="table table-bordered table-hover">
	                                    
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
						                    <h4 class="modal-title">资产详情</h4>
						                </div>
						                <div class="modal-body m_padding_top_0">
						                	
						                	<div class="row m_margin_10_auto search_box">
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产编号</span>
					                         		<input class="m_input form-control" name="newcode" id="newcode" type="text">
					                         		<input id="oldcode" name="oldcode" type="hidden">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产名称</span>
					                         		<input class="m_input form-control" name="dname" id="dname" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">厂商名称</span>
					                         		<input class="m_input form-control" name="manufacturer" id="manufacturer" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产规格</span>
					                         		<input class="m_input form-control" name="spec" id="spec" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">厂商型号</span>
					                         		<input class="m_input form-control"  name="model" id="model"  type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产类型</span>
					                         		<select class="form-control m_select" name="dtype" id="dtype">
		                                            </select>
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">计量单位</span>
					                         		<select class="form-control m_select" name="units" id="units">
		                                            </select>
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产数量</span>
					                         		<input class="m_input form-control" name="count" id="count" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">单价</span>
					                         		<input class="m_input form-control" name="price" id="price" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">资产属性</span>
					                         		<select class="form-control m_select" name="property" id="property">
					                         			<option value="0">学校资产</option>
					                         			<option value="1">个人资产</option>
		                                            </select>
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">负责人</span>
					                         		<select class="form-control select2me m_select asset_person" name="respPersonId" id="respPersonIdList">
                                                    </select>
                                                    <input type="hidden" name="respPerson" id="respPerson">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15" id="receiveIdGroup" style="display:none">
					                         		<span class="m_span">领取人</span>
					                         		<select class="form-control select2me m_select" name="receiveId" id="receiveIdList">
                                                    </select>
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">存放地点</span>
					                         		<input class="m_input form-control " name="site" id="site" type="text">
					                         	</div>
					                         </div>
					                         <div class="row m_margin_10_auto search_box">
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">购入时间</span>
					                         		<input class="m_input form-control asset_buy_day" name="buyDate" id="buyDate" readonly="readonly" type="text">
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15" style="padding-top:5px;">
					                         		<input type="radio" value="0" name="guaranteetime">半年
					                         		<input type="radio" value="1" name="guaranteetime">一年
					                         		<input type="radio" value="2" name="guaranteetime">两年
					                         		<input type="radio" value="3" name="guaranteetime">自定义
					                         	</div>
					                         	<div class="col-md-4 col-sm-4 col-lg-4 m_margin_top-15">
					                         		<span class="m_span">保修期至</span>
					                         		<input class="m_input form-control asset_validity" name="qualityDate" id="qualityDate" readonly="readonly" type="text">
					                         	</div>
					                         </div>
					                         <hr class="m_hr">
					                         <div class="row m_margin_10_auto search_box">
						                         <div class="col-md-12 col-sm-12 col-lg-12 m_margin_top-15">
						                         		<span class="m_display_inline m_float_left m_width_10">备注</span>
						                         		<textarea class="m_width_90 m_float_left form-control" id="remark" name="remark"></textarea>
					                         	</div>
					                         </div>
						                </div>
						                <div class="modal-footer">
						                	<r:right rightCode="assetModifyManager">
						                    	<button type="button" class="btn green" id="modifyAsset" onclick="modifyAsset()">修改</button>
						                    </r:right>
						                    <button type="button" class="btn" data-dismiss="modal">取消</button>
						                    <input type="hidden" name="assetId" id="assetId">
						                </div> 
						            </div>
						        </div>
						    </div>
						    <div class="modal fade" id="qrcodeHtml" tabindex="-1" role="dialog" aria-hidden="true">
						        <div class="modal-dialog modal-lg" style="width: 400px;">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						                    <h4 class="modal-title">资产详情二维码</h4>
						                </div>
						               <div style="height:10px;"></div>
						                  <div id="code_" style="margin-left:100px;"></div> 
						                  <a id="download" download="qrcode.jpg"></a>
						                   <div style="height:10px;"></div>
						                <div class="modal-footer">
						                <input value="" type="hidden" id="assetName_"> 
						                <button type="button" class="btn green" data-dismiss="modal" onclick="imgDownload();">下载</button>
						                <button type="button" class="btn" data-dismiss="modal">取消</button>
						                </div> 
						            </div>
						        </div>
						    </div>
						    <!-- 弹窗结束 -->
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
   <script type="text/javascript" src="<%=basePath%>assets/global/plugins/qrcode.js"></script> 
   <script type="text/javascript" src="<%=basePath%>assets/global/plugins/jquery.qrcode.js"></script> 
   <script type="text/javascript">
   	$(function(){
   		$('.asset_buy_day').datetimepicker({format:'Y-m-d',timepicker:false}); 
   	   	$("input[name='guaranteetime']").on("click",function(){
   	   		var input_num=$(this).val();
   	   		var asset_buy_day=$(".asset_buy_day").val();
	 		var asset=asset_buy_day.split("-")
   	   	    if(input_num=="0"){
   	   	  		$(".asset_validity").attr("readonly","readonly");
   	   	   	    asset[1]=parseInt(asset[1])+6;
   	   	   	    if(asset[1]<10){
   	   	   	   		asset[1]="0"+asset[1];
   	   	   	   	}
				$(".asset_validity").val(asset[0]+"-"+asset[1]+"-"+asset[2]);
   	   	   	}else if(input_num=="1"){
   	   	  		$(".asset_validity").attr("readonly","readonly");
   	   	  		var asset_buy_day=$(".asset_buy_day").val();
	 			var asset=asset_buy_day.split("-");
	 			asset[0]=parseInt(asset[0])+1;
	 			$(".asset_validity").val(asset[0]+"-"+asset[1]+"-"+asset[2]);
   	   	   	}else if(input_num=="2"){
   	   	  		$(".asset_validity").attr("readonly","readonly");
   	   	 		var asset_buy_day=$(".asset_buy_day").val();
				var asset=asset_buy_day.split("-");
				asset[0]=parseInt(asset[0])+2;
				$(".asset_validity").val(asset[0]+"-"+asset[1]+"-"+asset[2]);
   	   	   	}else if(input_num=="3"){
   	   	  		$(".asset_validity").removeAttr("readonly");
   	   	  		$('.asset_validity').datetimepicker({format:'Y-m-d',timepicker:false}); 
   	   	   	}
   	   	 })
   	    //选取当前菜单位置
   		setActive("assetManagement","assetInfoList"); 
   		
		loadAssetList(null, null, null,0, null);
		loadTyepList(1,null);
		//条件查询
		$("#search").click(function(){
			var code = $("#code").val();
			var name = $("#name").val();
			var type = $("#type").val();
			var personOrschool = $("#personOrschool").val();
			loadAssetList(code, name, type, personOrschool,null);
		});
		
		$("#personOrschool").change(function(){
			var code = $("#code").val();
			var name = $("#name").val();
			var type = $("#type").val();
			var personOrschool = $("#personOrschool").val();
			loadAssetList(code, name, type, personOrschool,null);
		});
		
		$("#type").change(function(){
			var code = $("#code").val();
			var name = $("#name").val();
			var type = $("#type").val();
			var personOrschool = $("#personOrschool").val();
			loadAssetList(code, name, type, personOrschool,null);
			
		});
		
		$("#property").change(function(){
			if($("#property").val()==1)
			{
				$("#receiveIdGroup").show();
			}
			else
			{
				$("#receiveIdGroup").hide();
			}
			
		});
   	})
   	function loadAssetList(code, name, type,personOrschool, cPage)
	{
		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/getAssetList.do",
			data:{
				code : code,
				name : name,
				type : type,
				personOrschool : personOrschool,
				pageSize : 20,
				page : cPage
			},
			success: function(data){
				var page = eval("(" + data + ")");
				$("#currentPage").html(page.currentPage);
				$("#totalPage").html(page.totalPage);
				var appendHtml = '';
				appendHtml += '<thead class="flip-content">'
				appendHtml += '<tr><th class="m_width_10 hidden-md hidden-sm">资产编号</th>'
				appendHtml += '<th class="m_width_10">资产名称</th>'
				appendHtml += '<th class="m_width_10">厂商名称</th>'
				appendHtml += '<th class="m_width_10">资产类型</th>'
				appendHtml += '<th class="m_width_5 hidden-md hidden-sm">单位</th>'
				appendHtml += '<th class="m_width_5">数量</th>'
				appendHtml += '<th class="m_width_5 hidden-md hidden-sm">单价</th>'
				appendHtml += '<th class="m_width_10">负责人</th>'
				if(personOrschool == 1){
					appendHtml +='<th class="m_width_10 hidden-md hidden-sm">领取人</th>';
				}
				appendHtml += '<th class="m_width_10">领取时间</th>'
				appendHtml += '<th class="m_width_15">编辑</th> </tr> </thead>'
				
				
				$.each(page.list, function(n, value) {  
					appendHtml += '<tr>';
       				appendHtml += '<td class="hidden-md hidden-sm">'+value.code+'</td>';
       				appendHtml += '<td>'+value.name+'</td>';
       				var manufacturer = value.manufacturer;
       				if(manufacturer == undefined)
   					{
       					manufacturer = "";
   					}
       				appendHtml += '<td>'+manufacturer+'</td>';
       				if(value.type == 0)
   					{
       					appendHtml += '<td>水电设施</td>';
   					}
       				else if(value.type == 1)
   					{
       					appendHtml += '<td>房屋建筑物</td>';
   					}
       				else if(value.type == 2)
   					{
       					appendHtml += '<td>办公设备</td>';
   					}
       				else if(value.type == 3)
   					{
       					appendHtml += '<td>网络信息</td>';
   					}
       				else if(value.type == 4)
   					{
       					appendHtml += '<td>仪器设备</td>';
   					}
       				else if(value.type == 5)
   					{
       					appendHtml += '<td>运输设备</td>';
   					}else if(value.type == 6)
   					{
       					appendHtml += '<td>体育用品</td>';
   					}else
   					{
       					appendHtml += '<td>其他</td>';
   					}
       				var units = value.units;
       				if(units == undefined)
   					{
       					units = "";
   					}
       				appendHtml += '<td class="hidden-md hidden-sm">'+units+'</td>';
       				appendHtml += '<td>'+value.count+'</td>';
       				appendHtml += '<td class="hidden-md hidden-sm">'+value.price+'</td>';
       				var respPerson = value.respPerson;
       				if(respPerson == undefined)
   					{
       					respPerson = "";
   					}
       				appendHtml += '<td>'+respPerson+'</td>';
       				var receiver = value.receiver;
       				if(receiver == undefined)
   					{
       					receiver = "";
   					}
       				if(personOrschool == 1){
       					appendHtml += '<td class="hidden-md hidden-sm">'+receiver+'</td>';
       				}
       				var receiveTime = value.receiveTime;
       				if(receiveTime == undefined)
   					{
       					receiveTime = "";
   					}
       				appendHtml += '<td>'+receiveTime+'</td>';
       				appendHtml += '<td>';
       				appendHtml += '<r:right rightCode="assetDetailManager">';
       				appendHtml += '<a class="btn btn-sm green" data-toggle="modal" href="#small" onclick="showDetail('+value.id+')">详情</a>';
       				appendHtml += '<a class="btn btn-sm default" data-toggle="modal" href="#qrcodeHtml" onclick="createQrcode('+value.id+',\''+value.name+'\')">二维码</a></r:right>';
       				appendHtml += '<r:right rightCode="assetDeleteManager">';
       				appendHtml += '  <a class="btn btn-sm red del" onclick="deleteAsset('+value.id+')">删除</a>';
       				appendHtml += '</r:right>';
       				appendHtml += '</td>';
       				appendHtml += '</tr>';
      			}); 
				
      			$("#tbody").html(appendHtml);
			},
		});
	}
   	//导出二维码
    function exportQcode(){
   		debugger;
    	var code = $("#code").val();
		var name = $("#name").val();
		var type = $("#type").val();
		var personOrschool = $("#personOrschool").val();
		var layerIndex=layer.confirm('确定要导出资产详情的二维码？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			var basePath="<%=basePath%>";
			var url=encodeURI(encodeURI(basePath+"asset/importQcode.do?code="+code+"&name="+name+"&type="+type+"&bashPath="+basePath+"&personOrschool="+personOrschool+"")); //用了2次encodeURI 
			window.location.href=url;
			layer.close(layerIndex);
		}, function(){
		 
		});
		
    }
   	
	function createQrcode(id,name){
		var schoolId=$("#schoolId").val();
		$("#code_").html("");
		$("#assetName_").val(name);
		var url="<%=basePath%>asset/toAppAssetDetail.do?id="+id+"&schoolId="+schoolId;
	    //生成二维码
		$("#code_").qrcode({ 
			render: "canvas", //table方式
		    width: 200, //宽度 
		    height:200, //高度
		    text: url //任意内容 
		});
   	}
	//下载二维码
	function imgDownload(){ 
		 var name=$("#assetName_").val();
		  var canvas = $('#code_').find("canvas").get(0); 
		  try {//解决IE转base64时缓存不足，canvas转blob下载
		        var blob = canvas.msToBlob();
		        navigator.msSaveBlob(blob, name+'.png');
		    } catch (e) {//如果为其他浏览器，使用base64转码下载
		    	$("#download").attr("download",name+".png");
		        var url = canvas.toDataURL('image/png');
		        $("#download").attr('href', url).get(0).click();
		    }
		    return false;
		}; 
   	//查看详情
   	function showDetail(id)
   	{
   		$(".asset_validity").attr("readonly","readonly");
   		$(".radio").find("span").removeAttr("class");
   		$("#modifyAsset").removeAttr("data-dismiss");
   		$('input[type="radio"]').removeAttr('checked')
   		$("#assetId").val(id);
   		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/getAssetDetailById.do",
			data:{
				id : id
			},
			success: function(data){
				var asset = eval("(" + data + ")");
				$("#newcode").val(asset.code);
				$("#oldcode").val(asset.code);
				$("#dname").val(asset.name);
				$("#manufacturer").val(asset.manufacturer);
				$("#spec").val(asset.spec);
				$("#model").val(asset.model);
				$("#count").val(asset.count);
				$("#price").val(asset.price);
				$("#site").val(asset.site);
				$("#buyDate").val(asset.buyDate);
				$("#qualityDate").val(asset.qualityDate);
				$("#remark").val(asset.remark);
				$("#property").val(asset.property);
				if(asset.property == 1)
				{
					$("#receiveIdGroup").show();
				}
				else
				{
					$("#receiveIdGroup").hide();
				}
				loadRespPerson(asset.respPersonId);
				loadReceiver(asset.receiveId);
				loadUnitsList(asset.units);
				loadTyepList(2,asset.type)
			},
		});
   	}
   	
   	function receiveAsset(id)
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/receiveAssetById.do",
			data:{
				id : id
			},
			success: function(data){
			   var data = eval("(" + data + ")");
               if(data)
           	   {
            	    layer.msg("领取成功");
					var scode = $("#code").val();
					var sname = $("#name").val();
					var stype = $("#type").val();
					$("#personOrschool").val(1);
					loadAssetList(scode, sname, stype,1, null);
           	   }
			},
		});
    }
   	function loadRespPerson(respPersonId)
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/getRespPerson.do",
			data:{
			},
			success: function(data){
				var list = eval("(" + data + ")");
                var appendHtml = '';
				$.each(list, function(n, value) {  
       				appendHtml += '<option value="'+value.userId+'">'+value.realName+'</option>';
      			}); 
      			$("#respPersonIdList").html(appendHtml);
      			$("#respPersonIdList").val(respPersonId);
      			var respPerson = $('#respPersonIdList option:selected').text();
      			if(respPerson == "")
   				{
      				$("#respPersonIdList").val("");
   				}
      			$("#respPersonIdList").change(function(){
    				$("#respPerson").val($('#respPersonIdList option:selected').text());
    			});
      			$("#respPerson").val(respPerson);
      			$("#select2-respPersonIdList-container").attr("title",respPerson);
      			$("#select2-respPersonIdList-container").text(respPerson);
			},
		});
    }
   	function loadReceiver(receiveId)
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/getRespPerson.do",
			data:{
			},
			success: function(data){
				var list = eval("(" + data + ")");
                var appendHtml = '';
                appendHtml += '<option value="">无</option>';
				$.each(list, function(n, value) {  
       				appendHtml += '<option value="'+value.userId+'">'+value.realName+'</option>';
      			}); 
      			$("#receiveIdList").html(appendHtml);
      			$("#receiveIdList").val(receiveId);
      			var receiver = $('#receiveIdList option:selected').text();
      			if(receiver == "")
   				{
      				$("#receiveIdList").val("");
   				}
      			$("#select2-receiveIdList-container").attr("title",receiver);
      			$("#select2-receiveIdList-container").text(receiver);
			},
		});
    }
    function loadTyepList(num,type)
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/getAssetTypeList.do",
			data:{
			},
			success: function(data){
				var list = eval("(" + data + ")");
                var appendHtml = '';
                if(num == 1)
               	{
                	appendHtml += '<option value="">全部</option>';
               	}
				$.each(list, function(n, value) {  
       				appendHtml += '<option value="'+value.id+'">'+value.name+'</option>';
      			}); 
				if(num == 1)
               	{
	      			$("#type").html(appendHtml);
               	}else{
               		$("#dtype").html(appendHtml);
	      			$("#dtype").val(type);
               	}
				
			},
		});
    }
	
    function loadUnitsList(units)
    {
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/getUnitsList.do",
			data:{
			},
			success: function(data){
				var list = eval("(" + data + ")");
                var appendHtml = '';
				$.each(list, function(n, value) {  
       				appendHtml += '<option value="'+value+'">'+value+'</option>';
      			}); 
      			$("#units").html(appendHtml);
      			$("#units").val(units);
			},
		});
    }
    
   	
   	//修改
   	function modifyAsset()
   	{
   		var newcode = $("#newcode").val();
		var oldcode = $("#oldcode").val();
   		if(newcode == "")
		{
   			layer.tips('编号不能为空', '#newcode');
			return;
		}
   		else if(checkCode(newcode,oldcode))
		{
			layer.tips('编号重复，请重新填写', '#newcode');
			return;
		}
		var name = $("#dname").val();
		if(name =="")
		{
			layer.tips('资产名称不能为空', '#dname');
			return;
		}
		var type = $("#dtype").val();
		var spec = $("#spec").val();
		var model = $("#model").val();
		var manufacturer = $("#manufacturer").val();
		var units = $("#units").val();
		var count = $("#count").val();
		if(count =="")
		{
			layer.tips('数量不能为空', '#count');
			return;
		}
		else if(count<=0)
		{
			layer.tips('数量大于0', '#count');
			return;
		}
		var price = $("#price").val();
		if(price =="")
		{
			layer.tips('单价不能为空', '#price');
			return;
		}
		else if(price<0)
		{
			layer.tips('单价不能小于0', '#price');
			return;
		}
		var site = $("#site").val();
		if(site =="")
		{
			layer.tips('存放位置不能为空', '#site');
			return;
		}
		var buyDate = $("#buyDate").val();
		if(buyDate =="")
		{
			layer.tips('购买日期不能为空', '#buyDate');
			return;
		}
		var qualityDate = $("#qualityDate").val();
		if(qualityDate =="")
		{
			layer.tips('保修期不能为空', '#qualityDate');
			return;
		}
		var remark = $("#remark").val();
		var assetId = $("#assetId").val();
		var respPerson = $("#respPerson").val();
		var respPersonId = $("#respPersonIdList").val();
		if(respPersonId == null || respPersonId == "")
		{
			layer.tips('请选择负责人', '.select2');
			return;
		}
		var receiveId = $("#receiveIdList").val();
		$("#modifyAsset").attr("data-dismiss","modal");
		$.ajax({
			type: "post",
			url: "<%=basePath%>asset/modifyAsset.do",
			data:{
				code : newcode,
				name : name,
				type : type,
				property : $("#property").val(),
				spec : spec,
				model : model,
				units : units,
				count : count,
				price : price,
				site : site,
				buyDate : buyDate,
				qualityDate : qualityDate,
				manufacturer : manufacturer,
				remark : remark,
				assetId : assetId,
				respPerson : respPerson,
				respPersonId : respPersonId,
				receiveId : receiveId
			},
			success: function(data){
				var data = eval("(" + data + ")");
				if(data)
				{
					layer.msg("修改成功",{icon: 1});
					var scode = $("#code").val();
					var sname = $("#name").val();
					var stype = $("#type").val();
					var personOrschool = $("#personOrschool").val();
					var cPage = $("#currentPage").html();
					var cPageInt = parseInt(cPage);
					loadAssetList(scode, sname, stype,personOrschool, cPageInt);
				}
				else
				{
					layer.msg("修改失败",{icon: 2});
				}
			},
		});
   	}
   	//删除
   	function deleteAsset(id)
   	{
   		layer.confirm('是否要删除本条资产信息', {
			  btn: ['删除','取消'] //按钮
			}, function(){
				$.ajax({
					type: "post",
					url: "<%=basePath%>asset/deleteAssetById.do",
					data:{
						id : id
					},
					success: function(data){
						var data = eval("(" + data + ")");
						if(data)
						{
							layer.msg("删除成功",{icon: 1});
							var scode = $("#code").val();
							var sname = $("#name").val();
							var stype = $("#type").val();
							var personOrschool = $("#personOrschool").val();
							var cPage = $("#currentPage").html();
							var cPageInt = parseInt(cPage);
							loadAssetList(scode, sname, stype,personOrschool,cPageInt);
						}
						else
						{
							layer.msg("删除失败",{icon: 2});
						}
						
					},
				});
			}, function(){
			}
		);
   	}
   
    
    function checkCode(code,oldcode)
    {
    	var flag = false;
    	$.ajax({
			type: "post",
			async: false,
			url: "<%=basePath%>asset/checkCode.do",
			data:{
				code : code,
				oldcode : oldcode
			},
			success: function(data){
				var data = eval("(" + data + ")");
				if(data)
				{
					flag = true;
				}
				else
				{
					flag = false;
				}
				
			},
		});
    	return flag;
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
		var code = $("#code").val();
		var name = $("#name").val();
		var type = $("#type").val();
		var personOrschool = $("#personOrschool").val();
		loadAssetList(code, name, type, personOrschool,cPageInt);
	    $("#currentPage").html(cPageInt);
	}
   </script>
</html>