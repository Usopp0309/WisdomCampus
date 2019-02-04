package com.guotop.palmschool.patrol.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

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

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.patrol.entity.Patrol;
import com.guotop.palmschool.patrol.entity.PatrolInout;
import com.guotop.palmschool.patrol.entity.PatrolPlace;
import com.guotop.palmschool.patrol.service.PatrolService;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 校务巡查巡更记录控制类
 * 
 * @author syj
 */
@RequestMapping("/patrol")
@Controller
public class PatrolController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(PatrolController.class);

	@Resource
	private PatrolService patrolService;

	@Resource
	private CommonService commonService;

	@Resource
	private UserService userService;

	@Resource
	private DepartmentService departmentService;

	/**
	 * 进入巡更记录页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPatrolList.do")
	public String toPatrolList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "patrol/list";
	}

	@RequestMapping(value = "/getPatrolList.do")
	public void getPatrolList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try
		{
			// 分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			String createDate = request.getParameter("createDate");
			if (!StringUtil.isEmpty(createDate))
			{
				paramMap.put("createDate", createDate);
			}
			String queryContent = request.getParameter("queryContent");
			if (!StringUtil.isEmpty(queryContent))
			{
				paramMap.put("queryContent", queryContent);
			}
			this.getPages().setPageSize(20);
			Pages<Patrol> pages = patrolService.getPatrolListByCreateDateAndRealName(this.getPages().getPageSize(), currentPage, createDate, queryContent);

			List<Patrol> list = pages.getList();
			if (!CollectionUtils.isEmpty(list))
			{
				for (Patrol patrol : list)
				{
					List<PatrolInout> inoutList = patrolService.getInoutList(createDate, patrol.getUserId(), patrol.getPlaceId());
					patrol.setInoutList(inoutList);
				}
			}
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("加载校务巡查巡更list出错，错误信息如下：" + e);
		}
	}

	/**
	 * 添加巡更页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPatrolAdd.do")
	public String toPatrolAdd(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "patrol/add";
	}

	/**
	 * 执行保存校务巡查巡更设置
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/doAddPatrol.do")
	public String doAddPatrol(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Gson gson = new Gson();
			boolean flag = false;
			String departmentId = request.getParameter("departmentId");
			String userId = request.getParameter("userId");
			String placeId = request.getParameter("placeId");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");

			if (StringUtil.isEmpty(departmentId) || StringUtil.isEmpty(userId) || StringUtil.isEmpty(placeId))
			{
				String json = gson.toJson(flag);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}

			if (StringUtil.isEmpty(startDate) || StringUtil.isEmpty(endDate) || StringUtil.isEmpty(startTime) || StringUtil.isEmpty(endTime))
			{
				String json = gson.toJson(flag);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}

			SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
			Long intervalTime = formatter2.parse(endDate).getTime() - formatter2.parse(startDate).getTime();
			int cycleTimes = 1;// 得出需要循环次数
			if (intervalTime == 0l)
			{
				cycleTimes = 1;
			} else if (intervalTime > 0l)
			{
				cycleTimes = ((int) (intervalTime / (24 * 60 * 60 * 1000))) + 1;
			}
			// 查询巡查人员信息
			User user = commonService.getUserDetailByUserId(Integer.valueOf(userId));
			Department department = departmentService.getDepartmentById(Integer.valueOf(departmentId));
			List<Patrol> patrolList = new ArrayList<Patrol>();
			String startDateTMP = startDate;
			for (int i = 0; i < cycleTimes; i++)
			{
				Patrol patrol = new Patrol();
				patrol.setUserId(Integer.valueOf(userId));
				patrol.setCode(user.getCode());
				patrol.setRealName(user.getRealName());
				patrol.setPhone(user.getPhone());
				patrol.setDepartmentId(Integer.valueOf(departmentId));
				patrol.setDepartmentName(department.getDepartmentName());
				patrol.setStartDate(startDateTMP);
				patrol.setStartTime(startDateTMP + " " + startTime);
				patrol.setEndDate(startDateTMP);
				patrol.setEndTime(startDateTMP + " " + endTime);
				patrol.setPlaceId(Integer.valueOf(placeId));
				patrolList.add(patrol);
				startDateTMP = TimeUtil.getInstance().getNextDay(startDateTMP);
			}
			if (!CollectionUtils.isEmpty(patrolList))
			{
				patrolService.batchAddPatrol(patrolList);
			}
			flag = true;
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("批量添加校务巡查巡更出错，错误信息如下：" + e);
		}
		return null;
	}

	/**
	 * 根据部门Id加载部门下教师列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/loadTeacherListByDepartmentId.do")
	public void loadTeacherListByDepartmentId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String departmentId = request.getParameter("departmentId");
		List<User> teacherList = new ArrayList<User>();
		if (!StringUtil.isEmpty(departmentId))
		{
			teacherList = commonService.getTeacherDetailByDepartmentId(Integer.valueOf(departmentId));
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(teacherList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("加载校务巡查巡更list出错，错误信息如下：" + e);
		}

	}

	/**
	 * 修改巡更页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPatrolEdit.do")
	public String toPatroledit(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		Patrol patrol = patrolService.getPatrolById(Integer.valueOf(id));
		modelMap.addAttribute("patrol", patrol);

		return "patrol/edit";
	}

	/**
	 * 执行保存校务巡查巡更设置
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/doUpdatePatrol.do")
	public String doUpdatePatrol(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Gson gson = new Gson();
			boolean flag = false;
			String departmentId = request.getParameter("departmentId");
			String userId = request.getParameter("userId");
			String placeId = request.getParameter("placeId");
			String patrolId = request.getParameter("patrolId");
			;

			if (StringUtil.isEmpty(departmentId) || StringUtil.isEmpty(userId) || StringUtil.isEmpty(placeId))
			{
				String json = gson.toJson(flag);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}

			Patrol patrol = patrolService.getPatrolById(Integer.valueOf(patrolId));
			User user = commonService.getUserDetailByUserId(Integer.valueOf(userId));
			Department department = departmentService.getDepartmentById(Integer.valueOf(departmentId));
			patrol.setDepartmentId(Integer.valueOf(departmentId));
			patrol.setDepartmentName(department.getDepartmentName());
			patrol.setCode(user.getCode());
			patrol.setRealName(user.getRealName());
			patrol.setPhone(user.getPhone());
			patrol.setPlaceId(Integer.valueOf(placeId));
			patrol.setUserId(Integer.valueOf(userId));
			patrolService.updatePatrol(patrol);

			flag = true;
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("批量添加校务巡查巡更出错，错误信息如下：" + e);
		}
		return null;
	}

	/**
	 * 根据部门Id加载部门下教师列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/clearPatrol.do")
	public void clearPatrol(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			patrolService.clearPatrol(TimeUtil.date());

			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("清空校务巡查巡更设置出错，错误信息如下：" + e);
		}

	}

	/**
	 * 进入巡更地点页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPatrolPlaceList.do")
	public String toPatrolPlaceList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		modelMap.addAttribute("schoolId", loginUser.getSchoolId());
		return "patrol/place_list";
	}

	/**
	 * 获取巡更地点列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/getPatrolPlaceList.do")
	public void getPatrolPlaceList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			// 0：获取分页数据 1:获取不分页数据
			int type = StringUtil.toint(request.getParameter("type"));
			if (type == 0)
			{
				this.getPages().setPageSize(20);
				Pages<PatrolPlace> pages = patrolService.getPatrolPlaceList(this.getPages().getPageSize(), currentPage);
				Gson gson = new Gson();
				String json = gson.toJson(pages);
				response.getWriter().write(json);
				response.getWriter().flush();
			} else
			{
				this.getPages().setPageSize(20);
				List<PatrolPlace> list = patrolService.getPatrolPlaceList();
				Gson gson = new Gson();
				String json = gson.toJson(list);
				response.getWriter().write(json);
				response.getWriter().flush();
			}
		} catch (Exception e)
		{
			logger.error("加载校务巡查巡更地点list出错，错误信息如下：" + e);
		}
	}

	/**
	 * 增加巡更地点
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/doAddPatrolPlace.do")
	public String doAddPatrolPlace(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String code = request.getParameter("code");
			String name = request.getParameter("name");
			String position = request.getParameter("position");

			PatrolPlace patrolplace = new PatrolPlace();
			boolean isAdd = false;
			if ((!StringUtil.isEmpty(code)))
			{
				patrolplace.setCode(code);
				isAdd = true;
			}
			if (!StringUtil.isEmpty(name))
			{
				patrolplace.setName(name);
				isAdd = true;
			}
			if (!StringUtil.isEmpty(position))
			{
				patrolplace.setPosition(position);
				isAdd = true;
			}
			if (isAdd)
			{
				patrolService.addPatrolPlace(patrolplace);
			}
		} catch (Exception e)
		{
			logger.error("增加校务巡查巡更地点出错，错误信息如下：" + e.getMessage());
		}
		return "patrol/place_list";
	}

	/**
	 * 根据巡更地点ID查找详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/getPatrolPlaceById.do")
	public void getPatrolPlaceById(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer id = StringUtil.toint(request.getParameter("id"));
			PatrolPlace patrolPlace = patrolService.getPatrolPlaceById(id);

			Gson gson = new Gson();
			String json = gson.toJson(patrolPlace);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("获取校务巡查巡更地点详情出错，错误信息如下：" + e.getMessage());
		}
	}

	/**
	 * 更新巡更地点
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/doUpdatePatrolPlace.do")
	public String doUpdatePatrolPlace(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer id = StringUtil.toint(request.getParameter("placeId"));
			String code = request.getParameter("code");
			String name = request.getParameter("name");
			String position = request.getParameter("position");
			PatrolPlace patrolplace = patrolService.getPatrolPlaceById(id);

			boolean isUpdate = false;
			if ((!StringUtil.isEmpty(code)) && (!code.equals(patrolplace.getCode())))
			{
				patrolplace.setCode(code);
				isUpdate = true;
			}
			if (!StringUtil.isEmpty(name) && (!name.equals(patrolplace.getName())))
			{
				patrolplace.setName(name);
				isUpdate = true;
			}
			if (!StringUtil.isEmpty(position) && (!position.equals(patrolplace.getPosition())))
			{
				patrolplace.setPosition(position);
				isUpdate = true;
			}
			if (isUpdate)
			{
				patrolService.updatePatrolPlace(patrolplace);
			}
		} catch (Exception e)
		{
			logger.error("更新校务巡查巡更地点出错，错误信息如下：" + e.getMessage());
		}
		return "patrol/place_list";
	}

	/**
	 * 删除巡更地点
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/doDeletePatrolPlace.do")
	public void doDeletePatrolPlace(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer id = StringUtil.toint(request.getParameter("id"));
			patrolService.deletePatrolPlace(id);

			boolean isDeleteSuccess = true;
			Gson gson = new Gson();
			String json = gson.toJson(isDeleteSuccess);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("删除校务巡查巡更地点出错，错误信息如下：" + e.getMessage());
		}
	}

	/**
	 * 进入巡更地图显示页面需要巡更数据
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getPatrolData.do")
	public void toViewMap(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String userId = request.getParameter("userId");
		String createDate = request.getParameter("createDate");
		String placeId = request.getParameter("placeId");
		try
		{
			User loginUser = (User) session.getAttribute("user");
			Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
			String schoolRange = pro.getProperty(loginUser.getSchoolId() + "_schoolRange");
			List<PatrolInout> inoutList = patrolService.getInoutListByCreateDateAndUserId(createDate, Integer.valueOf(userId));
			PatrolPlace patrolPlace = patrolService.getPatrolPlaceById(Integer.valueOf(placeId));
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("inoutList", inoutList);
			map.put("point", patrolPlace.getPosition());
			map.put("schoolRange", schoolRange);
			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("获取地图上巡更数据出错,错误信息如下:" + e.getMessage());
		}

	}

	/*---------手机端开始---------*/
	/**
	 * 进入巡更页面（APP）
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPatrolListByApiKey.do")
	public String toPatrolListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();

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
				return "app/patrol/patrol_list_app";
			}
		} else
		{
			modelMap.addAttribute("apiKeyTimeOut", "2");
		}

		session.setAttribute("user", user);
		DBContextHolder.setDBType(user.getSchoolId());
		String path = null;
		try
		{
			List<Permission> permissionList = user.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("patrol".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					path = "app/patrol/patrol_list_app";
					break;
				}
			}
			/*
			 * 接收页面请求参数---begin
			 */
			Integer userId = user.getUserId();
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			String createDate = request.getParameter("createDate");
			if (!StringUtil.isEmpty(createDate))
			{
				paramMap.put("createDate", createDate);
			} else
			{
				createDate = TimeUtil.date();
				paramMap.put("createDate", TimeUtil.date());
			}
			String queryContent = request.getParameter("queryContent");
			if (!StringUtil.isEmpty(queryContent))
			{
				paramMap.put("queryContent", queryContent);
			}
			this.getPages().setPageSize(20);
			List<Patrol> patrolList = patrolService.getPatrolListByCreateDateAndRealNameAPP(this.getPages().getPageSize(), currentPage, createDate, queryContent);
			if (!CollectionUtils.isEmpty(patrolList))
			{
				for (Patrol patrol : patrolList)
				{
					List<PatrolInout> inoutList = patrolService.getInoutList(createDate, patrol.getUserId(), patrol.getPlaceId());
					patrol.setInoutList(inoutList);
				}
			}
			currentPage = currentPage + 1;
			modelMap.addAttribute("patrolList", patrolList);
			modelMap.addAttribute("patrolListSize", patrolList.size());
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("createDate", createDate);

		} catch (Exception e)
		{
			logger.error("toPatrolListByApiKey.do出错，错误信息如下：" + e);
		}

		return path;
	}

	@RequestMapping(value = "/toPatrolListApp.do")
	public String toPatrolListApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		User loginUser = (User) session.getAttribute("user");
		DBContextHolder.setDBType(loginUser.getSchoolId());
		String path = null;
		try
		{
			/*
			 * 接收页面请求参数---begin
			 */
			Integer userId = loginUser.getUserId();
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			String createDate = request.getParameter("createDate");
			if (!StringUtil.isEmpty(createDate))
			{
				paramMap.put("createDate", createDate);
			}
			String queryContent = request.getParameter("queryContent");
			if (!StringUtil.isEmpty(queryContent))
			{
				paramMap.put("queryContent", queryContent);
			}
			this.getPages().setPageSize(20);
			List<Patrol> patrolList = patrolService.getPatrolListByCreateDateAndRealNameAPP(this.getPages().getPageSize(), currentPage, createDate, queryContent);
			if (!CollectionUtils.isEmpty(patrolList))
			{
				for (Patrol patrol : patrolList)
				{
					List<PatrolInout> inoutList = patrolService.getInoutList(createDate, patrol.getUserId(), patrol.getPlaceId());
					patrol.setInoutList(inoutList);
				}
			}
			currentPage = currentPage + 1;
			modelMap.addAttribute("patrolList", patrolList);
			modelMap.addAttribute("patrolListSize", patrolList.size());
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("createDate", createDate);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(modelMap);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			logger.error("toPatrolListApp.do出错，错误信息如下：" + e);
		}

		return path;
	}

	/**
	 * 【APP】进入巡更地点页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPatrolPlaceListApp.do")
	public String toPatrolPlaceListApp(HttpServletRequest request, ModelMap modelMap)
	{
		// 分页信息
		Integer currentPage = 1;
		try
		{
			currentPage = Integer.valueOf(request.getParameter("cPage"));
		} catch (Exception e)
		{
			currentPage = 1;
		}
		this.getPages().setPageSize(20);
		Pages<PatrolPlace> pages = patrolService.getPatrolPlaceList(this.getPages().getPageSize(), currentPage);

		currentPage = currentPage + 1;
		modelMap.addAttribute("patrolPlaceList", pages.getList());
		modelMap.addAttribute("patrolPlaceSize", pages.getList().size());
		modelMap.addAttribute("cPage", currentPage);
		return "app/patrol/patrol_place_app";
	}

	/**
	 * 【APP】获取巡更地点列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/getPatrolPlaceListApp.do")
	public void getPatrolPlaceListApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			// 0：获取分页数据 1:获取不分页数据
			int type = StringUtil.toint(request.getParameter("type"));
			if (type == 0)
			{
				this.getPages().setPageSize(20);
				Pages<PatrolPlace> pages = patrolService.getPatrolPlaceList(this.getPages().getPageSize(), currentPage);

				currentPage = currentPage + 1;
				modelMap.addAttribute("patrolPlaceList", pages.getList());
				modelMap.addAttribute("patrolPlaceSize", pages.getList().size());
				modelMap.addAttribute("cPage", currentPage);

				Gson gson = new Gson();
				String json = gson.toJson(modelMap);
				response.getWriter().write(json);
				response.getWriter().flush();
			} else
			{
				this.getPages().setPageSize(20);
				List<PatrolPlace> list = patrolService.getPatrolPlaceList();
				Gson gson = new Gson();
				String json = gson.toJson(list);
				response.getWriter().write(json);
				response.getWriter().flush();
			}
		} catch (Exception e)
		{
			logger.error("加载校务巡查巡更地点list出错，错误信息如下：" + e);
		}
	}

	/**
	 * 【APP】增加巡更地点
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/doAddPatrolPlaceApp.do")
	public String doAddPatrolPlaceApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String code = request.getParameter("code");
			String name = request.getParameter("name");
			String position = request.getParameter("position");

			PatrolPlace patrolplace = new PatrolPlace();
			boolean isAdd = false;
			if ((!StringUtil.isEmpty(code)))
			{
				patrolplace.setCode(code);
				isAdd = true;
			}
			if (!StringUtil.isEmpty(name))
			{
				patrolplace.setName(name);
				isAdd = true;
			}
			if (!StringUtil.isEmpty(position))
			{
				patrolplace.setPosition(position);
				isAdd = true;
			}
			if (isAdd)
			{
				patrolService.addPatrolPlace(patrolplace);
			}
		} catch (Exception e)
		{
			logger.error("增加校务巡查巡更地点出错，错误信息如下：" + e.getMessage());
		}
		return toPatrolPlaceListApp(request, modelMap);
	}

	/**
	 * 【app】更新巡更地点
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/doUpdatePatrolPlaceApp.do")
	public String doUpdatePatrolPlaceApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer id = StringUtil.toint(request.getParameter("placeId"));
			String code = request.getParameter("code");
			String name = request.getParameter("name");
			String position = request.getParameter("position");
			PatrolPlace patrolplace = patrolService.getPatrolPlaceById(id);

			boolean isUpdate = false;
			if ((!StringUtil.isEmpty(code)) && (!code.equals(patrolplace.getCode())))
			{
				patrolplace.setCode(code);
				isUpdate = true;
			}
			if (!StringUtil.isEmpty(name) && (!name.equals(patrolplace.getName())))
			{
				patrolplace.setName(name);
				isUpdate = true;
			}
			if (!StringUtil.isEmpty(position) && (!position.equals(patrolplace.getPosition())))
			{
				patrolplace.setPosition(position);
				isUpdate = true;
			}
			if (isUpdate)
			{
				patrolService.updatePatrolPlace(patrolplace);
			}
		} catch (Exception e)
		{
			logger.error("更新校务巡查巡更地点出错，错误信息如下：" + e.getMessage());
		}
		return toPatrolPlaceListApp(request, modelMap);
	}

	/**
	 * app进入巡更记录页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toPatrolSearchApp.do")
	public String toPatrolSearchLapp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String createDate = request.getParameter("createDate");
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("createDate", createDate);
		return "app/patrol/patrol_search_app";
	}
	
	/**
	 * 手机端进入地图显示
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toViewMapApp.do")
	public String toViewMapApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String placeId = request.getParameter("placeId");
		String userId = request.getParameter("userId");
		String createDate = request.getParameter("createDate");
		modelMap.addAttribute("placeId", placeId);
		modelMap.addAttribute("userId", userId);
		modelMap.addAttribute("createDate", createDate);
		return "app/patrol/map_app";
	}
	
	/**
	 * 手机端巡更点扫码
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/patrolScanCode.do")
	public String patrolScanCode(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RichHttpResponse<String> richHttpResponse = new RichHttpResponse<String>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String patrolCode = request.getParameter("patrolCode");
		String position = request.getParameter("position");
		try
		{
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				PatrolPlace patrolPlace = patrolService.getPatrolPlaceByCode(patrolCode);
				if (patrolPlace == null)
				{
					richHttpResponse.ResponseCode = -1;
					richHttpResponse.ResponseResult = "巡更点信息有误,请联系学校管理员";
				} else
				{
					if (!patrolCode.equals(patrolPlace.getCode()))
					{
						richHttpResponse.ResponseCode = -2;
						richHttpResponse.ResponseResult = "巡更点编号有误,请联系学校管理员";
					} else
					{
						if (StringUtil.isEmpty(position))
						{
							richHttpResponse.ResponseCode = -3;
							richHttpResponse.ResponseResult = "定位信息为空,请重新定位";
						} else
						{
							Patrol patrol = patrolService.getPatrolByPlaceIdUserIdAndStartDate(patrolPlace.getId(), loginUser.getUserId(), TimeUtil.date());
							if (patrol == null)
							{
								richHttpResponse.ResponseCode = -5;
								richHttpResponse.ResponseResult = "该巡更点没有关于你的巡更信息";
							} else
							{
								// 计算两点之间的距离
								String system_position = patrolPlace.getPosition();
								String[] system_positionArray = system_position.split(",");
								String system_latitude = system_positionArray[0]; // 系统中纬度
								String system_longitude = system_positionArray[1]; // 系统中经度

								String[] real_positionArray = position.split(",");
								String real_latitude = real_positionArray[0]; // 扫码时的纬度
								String real_longitude = real_positionArray[1]; // 扫码时的经度

								double distance = getDistance(Double.valueOf(real_longitude), Double.valueOf(real_latitude), Double.valueOf(system_longitude),
										Double.valueOf(system_latitude));
								System.out.println(distance);
								if (distance >= 30)
								{
									if (distance <= 100)
									{
										PatrolInout patrolInout = new PatrolInout();
										patrolInout.setUserId(loginUser.getUserId());
										patrolInout.setStatus(1);
										patrolInout.setPlaceId(patrolPlace.getId());
										patrolInout.setPlaceName(patrolPlace.getName());
										patrolInout.setPosition(position);
										patrolInout.setInoutDate(TimeUtil.date());
										patrolInout.setInoutTime(TimeUtil.getInstance().now());
										patrolService.addPatrolInout(patrolInout);
									}
									richHttpResponse.ResponseCode = -4;
									richHttpResponse.ResponseResult = "您的定位信息偏离巡更点位置超过30米,请您检查手机是否开机定位功能";
								} else
								{
									PatrolInout patrolInout = new PatrolInout();
									patrolInout.setUserId(loginUser.getUserId());
									patrolInout.setStatus(0);
									patrolInout.setPlaceId(patrolPlace.getId());
									patrolInout.setPlaceName(patrolPlace.getName());
									patrolInout.setPosition(position);
									patrolInout.setInoutDate(TimeUtil.date());
									patrolInout.setInoutTime(TimeUtil.getInstance().now());
									patrolService.addPatrolInout(patrolInout);
									richHttpResponse.ResponseCode = 0;
									richHttpResponse.ResponseResult = "扫码巡更成功";
								}
							}
						}
					}
				}
			} else
			{
//				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
//				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				richHttpResponse.ResponseCode = -5;
				richHttpResponse.ResponseResult = "你的系统在该学校不存在，巡更失败";
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("扫码巡更错误，错误信息如下:" + e.getMessage());
		}
		return null;
	}

	/**
	 * 根据两点间经纬度坐标（double值），计算两点间距离，单位为米
	 * 
	 * @param lng1
	 * @param lat1
	 * @param lng2
	 * @param lat2
	 * @return
	 */
	public static double getDistance(double lng1, double lat1, double lng2, double lat2)
	{
		double EARTH_RADIUS = 6378137;
		double radLat1 = rad(lat1);
		double radLat2 = rad(lat2);
		double a = radLat1 - radLat2;
		double b = rad(lng1) - rad(lng2);
		double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
		s = s * EARTH_RADIUS;
		s = Math.round(s * 10000) / 10000;
		return s;
	}

	// 把经纬度转为度（°）
	private static double rad(double d)
	{
		return d * Math.PI / 180.0;
	}

	public static void main(String[] args)
	{
		System.out.println(getDistance(118.771518, 31.976427, 118.771802, 31.976334));
	}
}
