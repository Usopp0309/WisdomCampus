package com.guotop.palmschool.system.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Agency;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.system.service.PersionnerService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 代理商控制类
 * 
 * @author jfy
 */
@RequestMapping("/persionner")
@Controller
public class PersionnerController extends BaseController
{
	@Resource
	private PersionnerService persionnerService;
	@Resource
	private SchoolService schoolService;

	/**
	 * 进入人员列表页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPersionner.do")
	public String toPersionner(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String status = request.getParameter("status");
		if (StringUtil.isEmpty(status))
		{
			status = "0";
		}
		modelMap.addAttribute("status", status);
		return "system/persionner";
	}

	/**
	 * 获取人员列表信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getPersionner.do")
	public String getPersionner(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String condition = request.getParameter("condition");
			String status = request.getParameter("status");
			if (status == null || status.equals(""))
			{
				status = (String) modelMap.get("status");
				if (StringUtil.isEmpty(status))
				{
					status = "0";
				}
			}
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("page"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			Pages pages = persionnerService.getPersonnerList(currentPage, 30, status, condition);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 新增代理商
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addAgency.do")
	public ModelAndView addAgency(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String name = request.getParameter("name");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String country = request.getParameter("country");
		String agentType = request.getParameter("agentType");
		String corporation = request.getParameter("corporation");
		String address = request.getParameter("address");
		String realName = request.getParameter("realName");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");

		String username = email;
		User user = new User();
		user.setRealName(realName);
		user.setNickName(realName);
		user.setPhone(phone);
		user.setUsername(username);
		user.setPassword(StringUtil.toMD5("123456"));
		user.setType(2);
		user.setUpdateTime(TimeUtil.getInstance().now());
		user.setCreateTime(TimeUtil.getInstance().now());
		user.setIsDefalutUserName(1);

		Agency agency = new Agency();
		agency.setName(name);
		agency.setAddress(address);
		agency.setAgentType(agentType);
		agency.setCity(city);
		agency.setCorporation(corporation);
		agency.setCountry(country);
		agency.setEmail(email);
		agency.setPhone(phone);
		agency.setProvince(province);
		agency.setCreateTime(TimeUtil.getInstance().now());

		persionnerService.addAgency(user, agency);
		modelMap.addAttribute("status", "0");
		return new ModelAndView("redirect:/persionner/toPersionner.do");
	}

	/**
	 * 修改代理商信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/modifyAgency.do")
	public String modifyAgency(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			String name = request.getParameter("name");
			String address = request.getParameter("address");
			String phone = request.getParameter("phone");
			String id = request.getParameter("agencyId");
			Agency agency = new Agency();
			agency.setId(Integer.valueOf(id));
			agency.setName(name);
			agency.setAddress(address);
			agency.setPhone(phone);
			persionnerService.modifyAgency(agency);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
		// return toPersionner(request, response, session, modelMap);
	}

	/**
	 * 获取代理商下拉框
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getAgencyList.do")
	public String getAgencyList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		List<Agency> list = persionnerService.getAgencyList(new HashMap<String, Object>());

		Gson gson = new Gson();
		String json = gson.toJson(list);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}
		return null;
	}

	/**
	 * 新增技术支持
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addSupport.do")
	public ModelAndView addSupport(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String realName = request.getParameter("realName");
		String supportEmail = request.getParameter("supportEmail");
		String supportPhone = request.getParameter("supportPhone");
		String agency = request.getParameter("agency");
		if (agency == null || "".equals(agency))
		{
			agency = "0";
		}
		String username = supportEmail;
		User user = new User();
		user.setUsername(username);
		user.setCreateTime(formatter.format(new Date()));
		user.setPassword(StringUtil.toMD5("123456"));
		user.setType(3);
		user.setUpdateTime(formatter.format(new Date()));
		user.setRealName(realName);
		user.setNickName(realName);
		user.setEmail(supportEmail);
		user.setPhone(supportPhone);
		user.setIsDefalutUserName(1);
		Agency agencyInfo = new Agency();
		agencyInfo.setId(Integer.valueOf(agency));

		persionnerService.addSupport(user, agencyInfo);

		modelMap.addAttribute("status", "1");
		return new ModelAndView("redirect:/persionner/toPersionner.do");
	}

	/**
	 * 修改技术支持人员信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/modifySupport.do")
	public String modifySupport(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			String realName = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String userId = request.getParameter("agencyId");

			User user = new User();
			user.setPalmUserName(phone);
			user.setEmail(email);
			user.setPhone(phone);
			user.setUserId(Integer.valueOf(userId));
			user.setRealName(realName);
			user.setUpdateTime(TimeUtil.getInstance().now());

			persionnerService.modifySupport(user);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
		// modelMap.addAttribute("status", "1");
		// return toPersionner(request, response, session, modelMap);
	}

	/**
	 * 新增财务
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addAccountant.do")
	public ModelAndView addAccountant(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String realName = request.getParameter("realName");
		String accountantEmail = request.getParameter("accountantEmail");
		String accountantPhone = request.getParameter("accountantPhone");
		String agency = request.getParameter("agency");
		if (agency == null || "".equals(agency))
		{
			agency = "0";
		}
		String username = accountantEmail;
		User user = new User();
		user.setUsername(username);
		user.setCreateTime(formatter.format(new Date()));
		user.setPassword(StringUtil.toMD5("123456"));
		user.setType(4);
		user.setUpdateTime(formatter.format(new Date()));
		user.setRealName(realName);
		user.setNickName(realName);
		user.setEmail(accountantEmail);
		user.setPhone(accountantPhone);
		user.setIsDefalutUserName(1);

		Agency agencyInfo = new Agency();
		agencyInfo.setId(Integer.valueOf(agency));

		persionnerService.addSupport(user, agencyInfo);

		modelMap.addAttribute("status", "2");
		return new ModelAndView("redirect:/persionner/toPersionner.do");
	}

	/**
	 * 修改财务人员信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/modifyAccountant.do")
	public String modifyAccountant(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			String realName = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String userId = request.getParameter("agencyId");

			User user = new User();
			user.setPalmUserName(phone);
			user.setEmail(email);
			user.setPhone(phone);
			user.setUserId(Integer.valueOf(userId));
			user.setRealName(realName);
			user.setUpdateTime(TimeUtil.getInstance().now());

			persionnerService.modifySupport(user);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
		// modelMap.addAttribute("status", "2");
		// return "redirect:" + toPersionner(request, response, session,
		// modelMap);
	}
}
