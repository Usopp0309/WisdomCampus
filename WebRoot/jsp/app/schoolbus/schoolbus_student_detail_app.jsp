<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<head>
	<title>校车管理</title>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<!--公共css开始-->
	<%@ include file="/public_module/app_public_css.jsp"%>
	<!--公共css结束--> 
</head>

<body>

	<div class="app_head">
		<i class="  m_icon-return icon_left" onclick="window.richbook.onFinish();"></i>校车管理
			
	</div>
	
	
		<div class="map" style="background-color:#f00;width:100%;height:100%;overflow:hidden;">
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	<p>11</p>
	</div>
	<div class="info_bottom">
		<div class="student_info_left">
		<p>刘晓军</p>
		<span>南京市白下区紫峰大厦</span>
		</div>
		<div class="student_info_right">
		<p>刷卡下车</p>
		<span>2015-10-16 13:30</span>
		</div>
	</div>
	
	
	</body>
	<!--公共js开始-->
	<%@ include file="/public_module/app_public_js.jsp"%>
	<!--公共js结束--> 
	

	<script type="text/javascript">

    $(function() {    

		$(".select_role dl dd").on("click",function(){
			$(".select_role dl dd").hide();
			//alert($(this).attr("id"));
			$("#roleCode").val($(this).attr("id"));
			var s=document.getElementById("addForm");
			s.submit();
		})

		var timeOut = $("#apiKeyTimeOut").val();
		if(timeOut == '1')
		{
			alert("您的apiKey已过期,您的账户可能被别人登陆，请修改密码或重新登陆");
		}
	      
	});
	function seturl(){
		
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var roleCode = $("#roleCode").val();
		standardPost('<%=basePath%>schoolbus/toSchoolbusOnListSearchAPP.do',{apiKey:apiKey,schoolId:schoolId,roleCode:roleCode}); 
	}
  	//查看更多
	function loadMoreList()
	{
		var apiKey = $("#apiKey").val();
		var schoolId = $("#schoolId").val();
		var type = $("#type").val();
		var queryContent = $("#queryContent").val();
		var clazzId = $("#clazzId").val();
		var cPage = $("#cPage").val();
		var roleCode = $("#roleCode").val();

		$.ajax({
			type: "post",
			url: "<%=basePath%>schoolbus/toLoadMoreSchoolBusInoutList.do",
			data:{
					apiKey : apiKey,
					schoolId : schoolId,
					type : type,
					clazzId : clazzId,
					queryContent : queryContent,
					roleCode : roleCode,
					cPage : cPage
			},
			success: function(data){

				var data = eval("(" + data + ")");
				
				$("#type").val(data.type);
   				$("#clazzId").val(data.clazzId);
   				$("#queryContent").val(data.queryContent);
   				$("#cPage").val(data.cPage);

   				var listSize = data.listSize;
   				if(listSize < 19)
   	   			{
   					$("#op_all_save").hide();
   	   	   		}
   				
				var appendHtml = '';
				
				$.each(data.schoolbusList, function(n, value) {  

					appendHtml += '<li>';
		           
					var status = value.status;
					if(status == 1)
					{
       					appendHtml += '<em class="Push">上</em>';
               		}else if(status == 2)
               		{
               			appendHtml += '<em class="sms">下</em>';
               		}
       				else
           			{
       					appendHtml += '<em class="error_enter">刷</em>';
               		}
					  
		             
		          
		          
					appendHtml += '<p class="top_p">';
   					appendHtml += '<span class="span_left">'+value.realName+'</span>';
   					appendHtml += '<span class="span_right" name="createTime">'+value.createTime+'</span>';
   					appendHtml += '</p>';
   					appendHtml += '<p>';
   					appendHtml += '<i class="fa fa-list-alt"></i>';
   					appendHtml += '<span class="span2">'+value.clazzName+'</span>';
   					appendHtml += '</p>';
   					appendHtml += '<p>';
   					appendHtml += '<i class="fa fa-bus"></i>';
   					appendHtml += '<span class="span3" name="projectId">'+value.position+'11111111111</span>';
   					if (value.driverName == null)
					{
	   					appendHtml += '<span class="span3"></span>';
					}
					else
					{
	   					appendHtml += '<span class="span3">'+value.driverName+'</span>';
					}
   					appendHtml += '<span class="span_right" onclick="mapInfo(this)">查看轨迹</span>'
   					appendHtml += '</p>';
               			
       				appendHtml += '</li>';

      			}); 
      			
      			$(".inout_list").append(appendHtml);
			},
		});
	}
	function mapInfo(obj){
		var cardId=$(obj).parent().parent().find("[name='projectId']").html();
		var createTime=$(obj).parent().parent().find("[name='createTime']").html();
		standardPost('<%=basePath%>locationInfo/showLocationInfo.do',{cardId:cardId,createTime:createTime});
	}
    </script>

</html>