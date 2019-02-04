package com.guotop.palmschool.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.MorningCheck;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.MorningCheckService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;

import dev.gson.GsonHelper;

/**
 * 晨检
 * 
 * @author jfy
 *
 */
@RequestMapping("/morningCheck")
@Controller
public class MorningCheckController extends BaseController
{
	@Resource
	private MorningCheckService morningCheckService;
	@Resource
	private CommonService commonService;
	@Resource
	private UserService userService;

	/**
	 * 进入晨检列表页面
	 */
	@RequestMapping(value = "/toMorningCheckList.do")
	public String toCardList()
	{
		return "safe/morningCheck_list";
	}

	@RequestMapping(value = "/getAllMorningCheckList.do")
	public String getAllMorningCheckList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		// 选定user
		User loginUser = (User) session.getAttribute("user");
		String clazzId = request.getParameter("clazzId");
		String queryContent = request.getParameter("queryContent");
		String roleCode = request.getParameter("roleCode");
		String state = request.getParameter("state");
		String cPage = request.getParameter("cPage");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		// 分页信息
		Integer currentPage = 1;
		if (cPage != null && !"".equals(cPage))
		{
			currentPage = Integer.valueOf(request.getParameter("cPage"));
		}
		// 参数map
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if(clazzId != null && !"".equals(clazzId))
		{
			paramMap.put("clazzId", clazzId);
		}
		
		this.getPages().setPageSize(20);
		
		paramMap.put("queryContent", queryContent);
		paramMap.put("state", state);
		paramMap.put("startTime", startTime);
		paramMap.put("endTime", endTime);
		if (!commonService.hasAdminPermission(loginUser) || !roleCode.equals("parent"))// 管理员 家长
		{
			//有权限的人员
			List<Integer> clazzIds = commonService.getIdsByUserIdAndPermissionCode(loginUser.getUserId(), "morningCheck", 0);
			paramMap.put("clazzIds", clazzIds);
		}
		paramMap.put("userId", loginUser.getUserId());
		paramMap.put("roleCode", roleCode);
		
		Pages pages = morningCheckService.getMorningCheckList(this.getPages().getPageSize(), currentPage, paramMap);
		try
		{
			response.getWriter().write(GsonHelper.toJson(pages));
			response.getWriter().flush();
		} catch (Exception e)
		{

		}
		return null;
	}
	/**
	 * 根据用户ID查找相应的晨检记录
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getDetailInfoByUserId.do")
	public String getDetailInfoByUserId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		String userId = request.getParameter("userId");
		String endDate = request.getParameter("endDate");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("endDate", endDate);
		List<MorningCheck> morningCheckList = null;
		if(null!=userId&&!"".equals(userId)&&null!=endDate&&!"".equals(endDate)){
			morningCheckList = morningCheckService.getDetailInfoByUserId(map);
		}
		try {
			response.getWriter().write(GsonHelper.toJson(morningCheckList));
			response.getWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查看详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/showDetail.do")
	public String showDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		User loginUser = (User) session.getAttribute("user");
		String id = request.getParameter("id");
		int idInt = 0;
		if (id != null && !"".equals(id))
		{
			idInt = Integer.valueOf(id);
			MorningCheck mc = morningCheckService.getDetailInfoById(idInt);
			mc.setSpirit(mc.getSpirit().replaceAll("@@##@@", "、"));
			modelMap.addAttribute("mc", mc);
			modelMap.addAttribute("schoolId", loginUser.getSchoolId());
		}

		return "safe/morningCheck_detail";
	}

	/**
	 * 进入晨检记录页面（APP）
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toMorningCheckListByApiKey.do")
	public String toMorningCheckListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

		if (user == null)
		{
			user = (User) session.getAttribute("user");

			if (user != null)
			{
				modelMap.addAttribute("apiKeyTimeOut", "2");
			} else
			{
				modelMap.addAttribute("apiKeyTimeOut", "1");
				return "app/safe/morningCheck_list_app";
			}
		} else
		{

			modelMap.addAttribute("apiKeyTimeOut", "2");
		}

		/*
		 * 存session
		 */
		session.setAttribute("user", user);

		DBContextHolder.setDBType(user.getSchoolId());

		try
		{
			/*
			 * 参数map
			 */
			HashMap<String, Object> paramMap = new HashMap<String, Object>();

			/*
			 * 分页信息
			 */
			Integer currentPage = 1;

			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			String roleCode = request.getParameter("roleCode");

			if (StringUtil.isEmpty(roleCode))
			{
				roleCode = user.getRoleList().get(0).getRoleCode();
			}

			/*
			 * 班级
			 */
			Integer clazzId = null;
			String clazz = request.getParameter("clazzId");

			if (!StringUtil.isEmpty(clazz))
			{
				clazzId = Integer.valueOf(clazz);
			}

			// 查询内容
			String queryContent = null;

			try
			{
				queryContent = request.getParameter("queryContent");
			} catch (Exception e)
			{
				queryContent = null;
			}

			// 开始日期
			String startDate = null;
			// 开始时间
			String startTime = null;
			String start = null;
			try
			{
				startDate = request.getParameter("startDate");
				startTime = request.getParameter("startTime");
				if (!StringUtil.isEmpty(startDate))
				{
					start = startDate + " " + startTime + ":00";
				}
			} catch (Exception e)
			{
				startTime = null;
			}

			// 结束日期
			String endDate = null;
			// 结束时间
			String endTime = null;
			String end = null;
			try
			{
				endDate = request.getParameter("endDate");
				endTime = request.getParameter("endTime");
				if (!StringUtil.isEmpty(endDate))
				{
					end = endDate + " " + endTime + ":00";
				}
			} catch (Exception e)
			{
				endTime = null;
				endDate = null;
			}

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("clazzId", clazzId);
			paramMap.put("queryContent", queryContent);
			paramMap.put("startTime", start);
			paramMap.put("endTime", end);

			this.getPages().setPageSize(20);
			DBContextHolder.setDBType(user.getSchoolId());
			List<MorningCheck> morningList = new ArrayList<MorningCheck>();
			if (commonService.hasAdminPermission(user))// 管理员
			{
				morningList = morningCheckService.getMorningCheckList(this.getPages().getPageSize(), currentPage, paramMap).getList();
			} else if (roleCode.equals("parent"))// 家长
			{

				paramMap.put("userId", user.getUserId());
				paramMap.put("roleId", roleCode);

				morningList = morningCheckService.getMorningCheckList(this.getPages().getPageSize(), currentPage, paramMap).getList();
			} else
			{
				List<Integer> clazzIds = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "morningCheck", 0);
				paramMap.put("userId", user.getUserId());
				paramMap.put("roleId", roleCode);
				paramMap.put("clazzIds", clazzIds);
				if (clazzIds != null && clazzIds.size() > 0)
				{
					morningList = morningCheckService.getMorningCheckList(this.getPages().getPageSize(), currentPage, paramMap).getList();
				}
			}

			currentPage = currentPage + 1;
			modelMap.addAttribute("roleList", user.getRoleList());
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			if (morningList != null)
			{
				modelMap.addAttribute("morningList", morningList);
				modelMap.addAttribute("morningListSize", morningList.size());
			}
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("startDate", startDate);
			modelMap.addAttribute("startTime", startTime);
			modelMap.addAttribute("endDate", endDate);
			modelMap.addAttribute("endTime", endTime);

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return "app/safe/morningCheck_list_app";
	}

	/**
	 * 加载晨检记录页面（APP）
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toLoadMoreMorningList4App.do")
	public String toLoadMoreMorningList4App(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		// 选定user
		User loginUser = (User) session.getAttribute("user");
		String clazzId = request.getParameter("clazzId");
		String queryContent = request.getParameter("queryContent");
		String roleCode = request.getParameter("roleCode");
		String state = request.getParameter("state");
		String cPage = request.getParameter("cPage");
		// 开始日期
		String startDate = null;
		// 开始时间
		String startTime = null;
		String start = null;
		try
		{
			startDate = request.getParameter("startDate");
			startTime = request.getParameter("startTime");
			if (!StringUtil.isEmpty(startDate))
			{
				start = startDate + " " + startTime + ":00";
			}
		} catch (Exception e)
		{
			startTime = null;
		}

		// 结束日期
		String endDate = null;
		// 结束时间
		String endTime = null;
		String end = null;
		try
		{
			endDate = request.getParameter("endDate");
			endTime = request.getParameter("endTime");
			if (!StringUtil.isEmpty(endDate))
			{
				end = endDate + " " + endTime + ":00";
			}
		} catch (Exception e)
		{
			endTime = null;
			endDate = null;
		}
		// 分页信息
		Integer currentPage = 1;
		if (cPage != null && !"".equals(cPage))
		{
			currentPage = Integer.valueOf(request.getParameter("cPage"));
		}
		/*
		 * 参数map
		 */
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", loginUser.getUserId());
		paramMap.put("roleCode", roleCode);
		paramMap.put("state", state);
		paramMap.put("queryContent", queryContent);
		paramMap.put("startTime", start);
		paramMap.put("endTime", end);
		paramMap.put("clazzId", clazzId);
		try
		{
			this.getPages().setPageSize(20);

			List<MorningCheck> morningList = new ArrayList<MorningCheck>();
			if (commonService.hasAdminPermission(loginUser))// 管理员
			{
				morningList = morningCheckService.getMorningCheckList(this.getPages().getPageSize(), currentPage, paramMap).getList();
			} else if (roleCode.equals("parent"))// 家长
			{

				paramMap.put("userId", loginUser.getUserId());
				paramMap.put("roleId", roleCode);

				morningList = morningCheckService.getMorningCheckList(this.getPages().getPageSize(), currentPage, paramMap).getList();
			} else
			{
				List<Integer> clazzIds = commonService.getIdsByUserIdAndPermissionCode(loginUser.getUserId(), "morningCheck", 0);
				paramMap.put("userId", loginUser.getUserId());
				paramMap.put("roleId", roleCode);
				paramMap.put("clazzIds", clazzIds);
				morningList = morningCheckService.getMorningCheckList(this.getPages().getPageSize(), currentPage, paramMap).getList();
			}

			currentPage = currentPage + 1;
			modelMap.addAttribute("morningList", morningList);
			modelMap.addAttribute("listSize", morningList.size());
			modelMap.addAttribute("cPage", currentPage);
			response.getWriter().write(GsonHelper.toJson(modelMap));
			response.getWriter().flush();

		} catch (Exception ex)
		{
			ex.printStackTrace();
		}

		return null;

	}
	/**
	 * 查看详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/showDetail4App.do")
	public String showDetail4App(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		User loginUser = (User) session.getAttribute("user");
		String id = request.getParameter("id");
		int idInt = 0;
		if (id != null && !"".equals(id))
		{
			idInt = Integer.valueOf(id);
			MorningCheck mc = morningCheckService.getDetailInfoById(idInt);
			mc.setSpirit(mc.getSpirit().replaceAll("@@##@@", "、"));
			modelMap.addAttribute("mc", mc);
			modelMap.addAttribute("schoolId", loginUser.getSchoolId());
		}

		return "app/safe/morningCheck_detail_app";
	}
}
