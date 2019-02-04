package com.guotop.palmschool.shopping.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.scheduler.entity.SchoolCountInfo;
import com.guotop.palmschool.scheduler.entity.SchoolCountInfoServiceHistory;
import com.guotop.palmschool.scheduler.service.CountService;
import com.guotop.palmschool.service.AgencyService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.shopping.service.OrdersService;
import com.guotop.palmschool.system.service.CardApplyAuditService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.PreciseCompute;

import dev.gson.GsonHelper;
/**
 * 财务报表
 * @author jfy
 * @date 2016年1月22日
 */
@Controller
@RequestMapping("/financialStatements")
public class FinancialStatementsController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(FinancialStatementsController.class);
	@Resource
	private OrdersService ordersService;
	@Resource
	private AgencyService agencyService;
	@Resource
	private CountService countService;
	@Resource
	private OrderMessageService orderMessageService;
	@Resource
	private CardApplyAuditService cardApplyAuditService;
	@Resource
	private SchoolService schoolService;
	/**
	 * 进入财务报表页面
	 * @return
	 */
	@RequestMapping(value="/toFinancialStatementsList.do")
	public String toFinancialStatementsList()
	{
		return "finance/financial_statements";
	}
	/**
	 * 加载各学校消费统计，代理商只能看到负责学校的统计数据
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/getFinancialStatementsList.do")
	public String getFinancialStatementsList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		User login = (User)session.getAttribute("user");
		Integer currentPage = 1;
		try
		{
			currentPage = Integer.valueOf(request.getParameter("cPage"));
		} catch (Exception e)
		{
			currentPage = 1;
		}
		String queryContent = request.getParameter("queryContent");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("queryContent", queryContent);
		boolean isPermission = false;
		if("sysadmin".equals(login.getUsername()) || "sysadmin".equals(login.getUserName())){
			//超级管理员
			isPermission = true;
		}else if(4 == login.getType()){
			//财务人员
			isPermission = true;
			paramMap.put("userId", login.getUserId());
		}
		Pages<SchoolCountInfo> pages = new Pages<SchoolCountInfo>();
		if(isPermission){
			this.getPages().setPageSize(20);
			pages = agencyService.getSchoolListByUserId(this.getPages().getPageSize(), currentPage, paramMap);
			List<SchoolCountInfo> list = pages.getList();
			if(!CollectionUtils.isEmpty(list)){
				for(SchoolCountInfo sci:list){
					DBContextHolder.setDBType(String.valueOf(sci.getSchoolId()));
					//获取智慧校园服务费总额,由于服务费是分学期缴纳的
					Double serviceTotalAmount = countService.getServiceTotalAmount(sci.getSchoolId(), null, null);
					sci.setServiceTotalAmount(serviceTotalAmount);
					//获取智慧校园卡总数
					Integer cardNumber = countService.getCardNumber(sci.getSchoolId(), null, null);
					sci.setCardNumber(cardNumber);
					//获取卡押金总额 
					Double cardTotalDepositAmount = countService.getCardTotalDepositAmount(sci.getSchoolId(), null, null);
					sci.setCardTotalDepositAmount(cardTotalDepositAmount);
				}
			}
			
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("pages", pages);
		resultMap.put("isPermission", isPermission);
		String json = GsonHelper.toJson(resultMap);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			logger.error("加载各学校消费统计失败,错误信息如下:"+e.getMessage());
		}
		
		return null;
	}
	/**
	 * 查看学校消费详情
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/toFinancialStatementsDetail.do")
	public String toFinancialStatementsDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		String schoolId = request.getParameter("schoolId");
		String condition = request.getParameter("condition");
		if (schoolId == null || "".equals(schoolId))
		{
			return "finance/financial_statements";
		}else
		{
			Long schoolIdLong = Long.valueOf(schoolId); 
			DBContextHolder.setDBType(schoolId);
			School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));
			/*
			 * 1.服务费缴费情况
			 */
			List<SchoolCountInfoServiceHistory> serviceHistorylist = countService.getServiceHistoryList(schoolIdLong,null,null);
			/*
			 * 2.卡押金统计
			 */
			Double cardTotalDepositAmount = countService.getCardTotalDepositAmount(schoolIdLong, null, null);
			Integer cardDepositCount = countService.getCardDepositCount(schoolIdLong, null, null);
			/*
			 * 3.补办卡缴纳人数
			 *  3.1 新办卡待审核人数
			 *  3.2 新办卡审核拒绝人数
			 *  3.3新办卡审核通过人数
			 *  3.4新办卡审核通过总金额
			 *  3.5 新办卡待审核人数
			 *  3.6 新办卡审核拒绝人数
			 *  3.7新办卡审核通过人数
			 *  3.8新办卡审核通过总金额
			 */
			//3.1 新办卡待审核人数
			Integer newApplyCardCount_watingAudit = cardApplyAuditService.getCountByTypeAndStatus(schoolIdLong,1, 0);
			//3.2 新办卡审核拒绝人数
			Integer newApplyCardCount_reduseAudit = cardApplyAuditService.getCountByTypeAndStatus(schoolIdLong,1, 2);
			//3.3新办卡审核通过人数
			Integer newApplyCardCount_passAudit = cardApplyAuditService.getCountByTypeAndStatus(schoolIdLong,1, 1);
			//3.4新办卡审核通过总金额
			Double newApplyAmountCount = cardApplyAuditService.getAmountCountByTypeAndStatus(schoolIdLong, 1, 1);
			//3.5 新办卡待审核人数
			Integer fillApplyCardCount_watingAudit = cardApplyAuditService.getCountByTypeAndStatus(schoolIdLong,0, 0);
			//3.6 新办卡审核拒绝人数
			Integer fillApplyCardCount_reduseAudit = cardApplyAuditService.getCountByTypeAndStatus(schoolIdLong,0, 2);
			//3.7新办卡审核通过人数
			Integer fillApplyCardCount_passAudit = cardApplyAuditService.getCountByTypeAndStatus(schoolIdLong,0, 1);
			//3.8新办卡审核通过总金额
			Double fillApplyAmountCount = cardApplyAuditService.getAmountCountByTypeAndStatus(schoolIdLong, 0, 1);
			/*
			 * 4.短信费用
			 */
			Integer mobileSmsCount = 0;
			Integer unicomSmsCount = 0;
			Integer telecomSmsCount = 0;
			SchoolCountInfo schoolCountInfo = countService.getCountInfoBySchoolIdAndStartTimeAndEndTime(schoolIdLong,null,null);
			if(schoolCountInfo != null){
				mobileSmsCount = schoolCountInfo.getMobileSmsCount();
				unicomSmsCount = schoolCountInfo.getUnicomSmsCount();
				telecomSmsCount = schoolCountInfo.getTelecomSmsCount();
			}
			//查找该校验证码总发送条数
			Integer authCodeCount = countService.getAuthCodeCountBySchoolIdAndStartTimeAndEndTime(schoolIdLong, null, null);
			//总短信条数
			Integer smsCount = authCodeCount+mobileSmsCount+unicomSmsCount+telecomSmsCount;
			//短信费总金额
			Double mobileSmsAmount = PreciseCompute.mul(mobileSmsCount, 0.04);
			Double unicomSmsAmount = PreciseCompute.mul(unicomSmsCount, 0.04);
			Double telecomSmsAmount = PreciseCompute.mul(telecomSmsCount, 0.04);
			Double authCodeSmsAmount = PreciseCompute.mul(authCodeCount, 0.04);
			Double smsTotalAmount = PreciseCompute.add(PreciseCompute.add(PreciseCompute.add(mobileSmsAmount, unicomSmsAmount),telecomSmsAmount),authCodeSmsAmount); 
			/*
			 * 5.消费类型
			 */
			
			/*
			 * 6.当前钱包余额
			 */
			Double accountAmount=countService.getAccountAmountBySchoolId(schoolIdLong);
			List<Integer> applyStatusList = new ArrayList<Integer>();
			//已通过提现总金额
			applyStatusList.add(2);
			Double passApplyCashAmount = countService.getApplyCashAmountByStatus(schoolIdLong, applyStatusList, null, null);
			//已拒绝提现总金额
			applyStatusList.clear();
			applyStatusList.add(4);
			Double refuseApplyCashAmount = countService.getApplyCashAmountByStatus(schoolIdLong, applyStatusList, null, null);
			//未处理提现金额
			applyStatusList.clear();
			applyStatusList.add(0);
			applyStatusList.add(1);
			Double watingApplyCashAmount = countService.getApplyCashAmountByStatus(schoolIdLong, applyStatusList, null, null);
			
			modelMap.addAttribute("serviceHistorylist", serviceHistorylist);
			modelMap.addAttribute("schoolName", school.getSchoolName());
			modelMap.addAttribute("cardTotalDepositAmount",cardTotalDepositAmount);
			modelMap.addAttribute("cardDepositCount",cardDepositCount);
			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("newApplyCardCount_watingAudit", newApplyCardCount_watingAudit);
			modelMap.addAttribute("newApplyCardCount_reduseAudit", newApplyCardCount_reduseAudit);
			modelMap.addAttribute("newApplyCardCount_passAudit", newApplyCardCount_passAudit);
			modelMap.addAttribute("newApplyAmountCount", newApplyAmountCount);
			modelMap.addAttribute("fillApplyCardCount_watingAudit", fillApplyCardCount_watingAudit);
			modelMap.addAttribute("fillApplyCardCount_reduseAudit", fillApplyCardCount_reduseAudit);
			modelMap.addAttribute("fillApplyCardCount_passAudit", fillApplyCardCount_passAudit);
			modelMap.addAttribute("fillApplyAmountCount", fillApplyAmountCount);
			modelMap.addAttribute("mobileSmsCount",mobileSmsCount);
			modelMap.addAttribute("unicomSmsCount",unicomSmsCount);
			modelMap.addAttribute("telecomSmsCount",telecomSmsCount);
			modelMap.addAttribute("authCodeCount",authCodeCount);
			modelMap.addAttribute("smsCount",smsCount);
			modelMap.addAttribute("smsTotalAmount",smsTotalAmount);
			modelMap.addAttribute("accountAmount",accountAmount);
			modelMap.addAttribute("passApplyCashAmount",passApplyCashAmount);
			modelMap.addAttribute("refuseApplyCashAmount",refuseApplyCashAmount);
			modelMap.addAttribute("watingApplyCashAmount",watingApplyCashAmount);
			modelMap.addAttribute("condition", condition);
			return "finance/financial_statements_detail";
		}
		
	}
}
