<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
        <meta charset="utf-8" />
        <title>学校信息修改</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
         <!--公共css开始-->
		<%@ include file="/public_module/public_css_new.jsp"%>
	 	<!--公共css结束--> 
	 	<link href="<%=basePath%>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
        </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed">
    	<input class="themes" type="hidden" value="<%=basePath%>">
        <!-- 公共顶部开始-->
        <%@ include file="/public_module/public_header.jsp"%>    
        <!--公共顶部结束-->
        <div class="clearfix"> </div>
        <!-- 内容页开始 -->
        <div class="page-container">
            <!--主菜单开始-->
            <%@include file="/public_module/public_menu.jsp"%>
            <!--主菜单结束-->
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content m_overflow_hidden m_page_content">
                	<div class="col-md-12 col-sm-12 m_page_con">
                    <div class="page-bar m_margin_0_0_0_0">
                        <ul class="page-breadcrumb">
                            <li><a href="<%=basePath %>user/enterMain.do">首页</a><i class="fa fa-circle"></i></li>
                            <li><a href="<%=basePath %>user/enterMain.do">系统管理</a><i class="fa fa-circle"></i></li>
                            <li><span>学校信息修改</span></li>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="portlet light portlet-fit portlet-form bordered m_margin_15_auto_0" id="form_wizard_1">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">学校信息修改</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                   <form action="<%=basePath %>school/doModifyInfo.do" class="form-horizontal" method="post" id="submitForm" enctype="multipart/form-data">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="control-label col-md-3">学校名称</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input name="schoolName" type="text" readonly="readonly" class="form-control" id="schoolName" value="${schoolInfo.schoolName }">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputError">学校地址</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input name="schoolAddress" id="schoolAddress" type="text"  class="form-control" id="lastName" value="${schoolInfo.schoolAddress }">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">学校电话</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input name="schoolTelephone" id="schoolTelephone" type="text"  class="form-control" value="${schoolInfo.schoolTelephone }">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">成立时间</label>
                                                <div class="col-md-9 col-lg-4">
													<input type="text"  class="form-control" readonly="readonly" style="cursor: pointer;"  name="createDate" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" id="createDate" value="${schoolInfo.createDate }" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">学校校徽</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new">选择图片</span>
                                                                <span class="fileinput-exists">换一张</span>
                                                                <input type="file" name="schoolBadge"></span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                                        </div>
														<span class="help-block">图片格式：jpg，png，gif，bmp等图片格式 ，大小请在200X200像素以内</span>
                                                	</div>
                                            	</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess"></label>
                                                <div class="col-md-9 col-lg-4">
													<c:if test="${schoolInfo.schoolBadge ne '' && schoolInfo.schoolBadge ne null }">
														<img  src="<%=Cons.IMGBASEPATH%>${schoolInfo.schoolBadge}" width="200" >
													</c:if>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">学校介绍</label>
                                                <div class="col-md-9 col-lg-4">
													<textarea name="introduction" id="introduction" rows="3" class="form-control" >${schoolInfo.introduction }</textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3" for="inputSuccess">学校介绍图</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new">选择图片</span>
                                                                <span class="fileinput-exists">换一张</span>
                                                                <input type="file" name="introductionImg"></span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                                        </div>
														<span class="help-block">图片格式：jpg，png，gif，bmp等图片格式 ，大小请在200X200像素以内</span>
                                                	</div>
													
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3"></label>
                                                <div class="col-md-9 col-lg-4">
                                                    <c:if test="${schoolInfo.introductionImg ne '' && schoolInfo.introductionImg ne null  }">
														<img  src="<%=Cons.IMGBASEPATH%>${schoolInfo.introductionImg}" width="200">
													</c:if>
                                                </div>
                                            </div>
                                            <h3 class="form-section">校长信息</h3>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">校长名称</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <input name="president" id="president" type="text"  class="form-control" value="${schoolInfo.president }" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">校长照片</label>
                                                <div class="col-md-9 col-lg-4">
                                                	<div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new">选择图片</span>
                                                                <span class="fileinput-exists">换一张</span>
                                                                <input type="file" name="headmasterMottoPhoto"></span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput">移除</a>
                                                        </div>
														<span class="help-block">图片格式：jpg，png，gif，bmp等图片格式 ，大小请在800X600像素以内</span>
                                                	</div>
                                                    
														

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3"></label>
                                                <div class="col-md-9 col-lg-4">
                                                    <c:if test="${schoolInfo.headmasterMottoPhoto ne '' && schoolInfo.headmasterMottoPhoto ne null}">
															<img  src="<%=Cons.IMGBASEPATH%>${schoolInfo.headmasterMottoPhoto}" width="200">
													</c:if>
												</div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3">校长寄语</label>
                                                <div class="col-md-9 col-lg-4">
                                                    <textarea name="headmasterMotto" id="headmasterMotto" rows="3" class="form-control" >${schoolInfo.headmasterMotto }</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                <c:if test="${sessionScope.user.type != 2}">
													<button class="btn green" id="submitButton" type="button" >保存</button>
													<button type="button" class="btn" id="cancel">返回</button>
												</c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                                </div>
                        </div>
                    </div>
                    </div>
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
         <script src="<%=basePath %>assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
        <!-- 公共js结束 -->
	<script type="text/javascript">
	$(function(){
		loadSubMenu("schoolManager"); 
		//选取当前菜单位置
		setActive("schoolManager","schoolInfoManage"); 
		
		//验证手机号是否正确
		
		$("#submitButton").click(function(){
			 var img=true;
			 $(".fileinput-filename").each(function(){
				 var fileName=$.trim($(this).text());
				 fileName=fileName.toLowerCase();
				 if(fileName.indexOf("jpg")!=-1 || fileName.indexOf("png")!=-1 || fileName.indexOf("gif")!=-1 || fileName.indexOf("bmp")!=-1 || fileName.indexOf("jpeg")!=-1){
				 }else if(fileName!=""){
					 layer.msg("请选择：jpg，png，gif，bmp,jpeg格式的图片",{icon:5,time:3000,offset:['500px']});
					 img=false;
					 return false; 
				 }
			 });
			 if(checkSchoolPhone() && img)
			 {
				 $("#submitForm").submit();
			 }
		});
	
	})
	
	function checkSchoolPhone()
	{
		var flag = true;
		var schoolTelephone = $("#schoolTelephone").val();
		if(schoolTelephone != "")
		{
			if(!checkSubmitMobil(schoolTelephone) && !checkTelePhone(schoolTelephone))
			{
				layer.msg("请输入正确的电话号码");
				flag = false;
			}else
			{
				flag = true;
			}
		}else
		{
			flag = true;
		}
		return flag;
	}
	
	</script>
</html>