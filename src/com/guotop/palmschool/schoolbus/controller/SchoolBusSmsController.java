package com.guotop.palmschool.schoolbus.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSmsDetail;
import com.guotop.palmschool.schoolbus.service.SchoolBusSmsService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;

/**
 * 校车信息控制类
 * 
 * @author zhou
 */
@RequestMapping("/schoolbusSms")
@Controller
public class SchoolBusSmsController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private SchoolBusSmsService schoolBusSmsService;

	@Resource
	private UserService userService;

	/**
	 * 进入校车短信页面
	 */
	@RequestMapping(value = "/toSchoolBusSms.do")
	public String toSchoolBusSms()
	{
		return "schoolbus/schoolbus_sms_list";
	}

	/**
	 * 不同权限查看到不同的page 加载上下校车列表 加载上下校车list 20151210
	 */
	@RequestMapping(value = "/loadSchoolBusSms.do")
	public String loadSchoolBusSms(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{

			/**
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

			// 获取页面请求参数
			// 接收者
			String queryContent = request.getParameter("queryContent");

			String time = request.getParameter("time");

			User user = (User) session.getAttribute("user");

			/**
			 * 查询
			 */
			String clazzList = null;
			try
			{
				clazzList = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzList = null;
			}

			String roleCode = request.getParameter("roleCode");

			paramMap.put("userId", user.getUserId());
			paramMap.put("clazzList", clazzList);
			paramMap.put("queryContent", queryContent);
			paramMap.put("roleCode", roleCode);
			paramMap.put("time", time);

			/**
			 * 获取分页数据
			 */
			Pages pages = schoolBusSmsService.getSchoolBusSms(this.getPages().getPageSize(), currentPage, paramMap, user);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/* 手机端begin */

	@RequestMapping(value = "/toSchoolBusSmsByHuxinId.do")
	public String toSchoolBusSmsByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

		String path = null;

		if (loginUser != null)
		{
			/*
			 * 存session
			 */
			session.setAttribute("user", loginUser);
			
			DBContextHolder.setDBType(loginUser.getSchoolId());

			List<Permission> permissionList = loginUser.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("schoolBusSmsManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					path = "app/schoolbus/schoolbus_sms_list_app";
					break;
				}
			}

			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			try
			{
				// 角色code
				String roleCode = request.getParameter("roleCode");

				if (roleCode == null || roleCode.equals(""))
				{
					roleCode = loginUser.getRoleList().get(0).getRoleCode();
				}

				/**
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

				// 获取页面请求参数
				// 接收者
				String queryContent = request.getParameter("queryContent");

				String time = request.getParameter("time");

				User user = (User) session.getAttribute("user");

				/**
				 * 查询
				 */
				String clazzList = null;
				try
				{
					clazzList = request.getParameter("clazzId");
				} catch (Exception e)
				{
					clazzList = null;
				}

				paramMap.put("userId", user.getUserId());
				paramMap.put("clazzList", clazzList);
				paramMap.put("queryContent", queryContent);
				paramMap.put("roleCode", roleCode);
				paramMap.put("time", time);

				/**
				 * 获取分页数据
				 */
				this.getPages().setPageSize(20);
				List<SchoolBusSmsDetail> list = schoolBusSmsService.getSchoolBusSmsAPP(this.getPages().getPageSize(), currentPage, paramMap, user);

				currentPage = currentPage + 1;
				modelMap.addAttribute("roleList", user.getRoleList());
				modelMap.addAttribute("roleListSize", user.getRoleList().size());
				modelMap.addAttribute("schoolbusSmsList", list);
				modelMap.addAttribute("listSize", list.size());
				modelMap.addAttribute("roleCode", roleCode);
				modelMap.addAttribute("cPage", currentPage);
				modelMap.addAttribute("queryContent", queryContent);
				modelMap.addAttribute("apiKey", apiKey);
				modelMap.addAttribute("schoolId", schoolId);
				modelMap.addAttribute("time", time);
				modelMap.addAttribute("clazzId", clazzList);

			} catch (Exception e)
			{
				e.printStackTrace();
			}

			modelMap.addAttribute("apiKeyTimeOut", "2");
		} else
		{
			modelMap.addAttribute("apiKeyTimeOut", "1");
			return "app/schoolbus/schoolbus_sms_list_app";
		}
		
		return path;
	}

	/**
	 * 加载校车短信记录页面（APP）
	 */
	@RequestMapping(value = "/toLoadMoreSchoolBusSmsList.do")
	public String toLoadMoreSchoolBusSmsList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");

			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			// 角色code
			String roleCode = request.getParameter("roleCode");

			/**
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

			// 获取页面请求参数
			// 接收者
			String queryContent = request.getParameter("queryContent");

			String time = request.getParameter("time");

			User user = (User) session.getAttribute("user");

			/**
			 * 查询
			 */
			String clazzList = null;
			try
			{
				clazzList = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzList = null;
			}

			paramMap.put("userId", user.getUserId());
			paramMap.put("clazzList", clazzList);
			paramMap.put("queryContent", queryContent);
			paramMap.put("roleCode", roleCode);
			paramMap.put("time", time);

			/**
			 * 获取分页数据
			 */
			List<SchoolBusSmsDetail> list = schoolBusSmsService.getSchoolBusSmsAPP(this.getPages().getPageSize(), currentPage, paramMap, user);

			currentPage = currentPage + 1;
			modelMap.addAttribute("roleList", user.getRoleList());
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			modelMap.addAttribute("schoolbusSmsList", list);
			modelMap.addAttribute("listSize", list.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("apiKey", apiKey);
			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("time", time);
			modelMap.addAttribute("clazzId", clazzList);

			Gson gson = new Gson();
			String json = gson.toJson(modelMap);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}
	
	/**
	 * 进入校车搜索页面
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toSchoolbusSmsListSearchAPP.do")
	public String toSchoolbusSmsListSearchAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");

		User user = (User) session.getAttribute("user");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", "schoolBusSmsManager");

		List<Clazz> clazzList = commonService.getClazzList(paramMap);

		modelMap.addAttribute("clazzList", clazzList);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("userId", user.getUserId());

		return "app/schoolbus/schoolbus_sms_list_search_app";
	}
}
