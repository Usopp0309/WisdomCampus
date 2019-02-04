<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]--><!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]--><!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>RichX智慧校园 - ${schoolName }</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
 	<link href="<%=basePath%>assets/global/css/skin_m.css" rel="stylesheet" type="text/css" />
 	<link href="<%=basePath%>assets/global/css/demoTable.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<%@include file="/public_module/header.jsp" %>
    <div class="richxManager">
        <!--<h3 class="margin_top_15">购物订单</h3>-->
        <ul class="mtabs margin_top_15" id="orderTab">
            <li class="active" id="page1"><a>智慧校园服务费</a></li>
            <li class="" id="page2"><a>补办卡</a></li>
            <li class="" id="page3"><a>短信费</a></li>
            <li class="" id="page4"><a>短信表</a></li>
            <li class="" id="page2"><a>消费类型</a></li>
            <li class="" id="page3"><a>我的钱包</a></li>
            <li class="" id="page4"><a>总支付</a></li>
        </ul>
        <div class="pageOn richDiv">
            <h4 class="margin_top_15">服务费统计</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="m_width_20"></th>
                            <th class="m_width_20">服务费价格</th>
                            <th class="m_width_20">已交费人数</th>
                            <th class="m_width_20">未交费人数</th>
                            <th class="m_width_20">免交费人数</th>
                            <th class="m_width_20">学生总人数</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        	<c:forEach items="${serviceHistorylist}" var="serviceHistory">
								<tr>
									
									<c:if test="${serviceHistory.status == 0}">
										<th class="m_width_20">${serviceHistory.name }(有效)</th>
									</c:if>
									<c:if test="${serviceHistory.status == 1}">
										<th class="m_width_20">${serviceHistory.name }(失效)</th>
									</c:if>
									<th class="m_width_20">￥${serviceHistory.servicePrice }</th>
	                                <td class="m_width_20">${serviceHistory.alreadyPayCount }</td>
	                                <td class="m_width_20">${serviceHistory.unPayCount }</td>
	                                <td class="m_width_20">${serviceHistory.freePayCount }</td>
	                                <td class="m_width_20">${serviceHistory.studentCount }</td>
                            	</tr>	
							</c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="richDiv">
            <h4 class="margin_top_15">卡押金统计</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="m_width_20">卡押金缴费总人数</th>
                            <th class="m_width_20">卡押金缴费总金额</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        <tr>
                            <td class="m_width_20">${cardDepositCount }</td>
                            <td class="m_width_20">￥${cardTotalDepositAmount}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="richDiv">
            <h4 class="margin_top_15">个人补办卡统计</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                        	<th class="m_width_30"></th>
                            <th class="m_width_30">待审核</th>
                            <th class="m_width_30">审核拒绝</th>
                            <th class="m_width_30">审核通过</th>
                            <th class="m_width_30">审核通过总金额</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        <tr>
                            <td class="m_width_30">新办卡</td>
                            <td class="m_width_30">${newApplyCardCount_watingAudit }</td>
                            <td class="m_width_30">${newApplyCardCount_reduseAudit }</td>
                            <td class="m_width_30">${newApplyCardCount_passAudit }</td>
                            <td class="m_width_30">￥${newApplyAmountCount }</td>
                        </tr>
                        <tr>
                            <td class="m_width_30">补办卡</td>
                            <td class="m_width_30">${fillApplyCardCount_watingAudit }</td>
                            <td class="m_width_30">${fillApplyCardCount_reduseAudit }</td>
                            <td class="m_width_30">${fillApplyCardCount_passAudit }</td>
                            <td class="m_width_30">￥${fillApplyAmountCount }</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="richDiv">
            <h4 class="margin_top_15">短信支出费用统计</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="m_width_10">移动</th>
                            <th class="m_width_10">联通</th>
                            <th class="m_width_10">电信</th>
                            <th class="m_width_20">验证码</th>
                            <th class="m_width_20">总条数</th>
                            <th class="m_width_20">总金额</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        <tr>
                            <td class="m_width_10">${mobileSmsCount }条</td>
                            <td class="m_width_10">${unicomSmsCount }条</td>
                            <td class="m_width_10">${telecomSmsCount }条</td>
                            <td class="m_width_20">${authCodeCount }条</td>
                            <td class="m_width_20">${smsCount }条</td>
                            <td class="m_width_20">￥${smsTotalAmount }</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="richDiv">
            <h4 class="margin_top_15">我的钱包</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="m_width_10">钱包总额</th>
                            <th class="m_width_10">已通过提现总金额</th>
                            <th class="m_width_10">已拒绝提现总金额</th>
                            <th class="m_width_20">未处理提现金额</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        <tr>
                            <td class="m_width_10">￥${accountAmount }</td>
                            <td class="m_width_10">￥${passApplyCashAmount }</td>
                            <td class="m_width_10">￥${refuseApplyCashAmount }</td>
                            <td class="m_width_20">￥${watingApplyCashAmount }</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="richDiv">
            <h4 class="margin_top_15">消费类型-等待统计</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="m_width_30">智慧校园服务费</th>
                            <th class="m_width_10">卡押金</th>
                            <th class="m_width_10">补办卡费</th>
                            <th class="m_width_10">短信费</th>
                            <th class="m_width_20">资源购买</th>
                            <th class="m_width_20">其他</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        <tr>
                            <td class="m_width_30">请求</td>
                            <td class="m_width_10">55</td>
                            <td class="m_width_10">11</td>
                            <td class="m_width_10">13</td>
                            <td class="m_width_20">367331</td>
                            <td class="m_width_20">44</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="richDiv">
            <h4 class="margin_top_15">总支付-等待统计</h4>
            <div class="con">
                <div class="tab-content">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="m_width_20">内容</th>
                            <th class="m_width_10">设备数</th>
                            <th class="m_width_10">校园卡</th>
                            <th class="m_width_10">安装调试</th>
                            <th class="m_width_10">短信支付</th>
                            <th class="m_width_10">维修/更换</th>
                            <th class="m_width_10">差旅费</th>
                            <th class="m_width_20">其他</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">
                        <tr>
                            <td class="m_width_20">请求</td>
                            <td class="m_width_10">55</td>
                            <td class="m_width_10">11</td>
                            <td class="m_width_10">13</td>
                            <td class="m_width_10">367331</td>
                            <td class="m_width_10">44</td>
                            <td class="m_width_10">367331</td>
                            <td class="m_width_20">44</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>



    </div>
		
	</div>
	<%@include file="/public_module/public_footer.jsp" %>
	<%@include file="/public_module/public_js.jsp" %>
	
	<script type="text/javascript">
		var oLi = document.querySelectorAll('.mtabs li');
	    var oPage = document.querySelectorAll('.richDiv');
	    var index = 0;
	    for(var i=0;i<oLi.length;i++){
	        oLi[i].i = i;
	        oLi[i].onclick = function(){
	            oLi[index].className =" ";
	            oPage[index].className = "richDiv";
	            index = this.i;
	            oLi[index].className ="active";
	            oPage[index].className = "pageOn richDiv";
	        }
	    }
	</script>
</body>
</html>