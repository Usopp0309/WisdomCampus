package com.guotop.palmschool.todayActivity.controller;

import java.io.IOException;
import java.util.Arrays;
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
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.curriculum.entity.Curriculum;
import com.guotop.palmschool.curriculum.entity.CurriculumSemester;
import com.guotop.palmschool.curriculum.entity.CurriculumTime;
import com.guotop.palmschool.curriculum.entity.Week;
import com.guotop.palmschool.curriculum.service.CurriculumService;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.todayActivity.service.TodayActivityService;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 今日活动控制类
 */
@RequestMapping("/todayActivity")
@Controller
public class TodayActivityController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private CurriculumService curriculumService;

	@Resource
	private UserService userService;

	@Resource
	private TodayActivityService todayActivityService;

	/**
	 * 进入每日活动页面
	 */
	@RequestMapping(value = "/toTodayActivity.do")
	public String toTodayActivity(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		User loginUser = (User) session.getAttribute("user");

		String roleCode = request.getParameter("roleCode");

		// 用于页面判断是否有每日活动
		Integer times = 0;

		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

		List<Role> roleList = loginUser.getRoleList();

		if (roleCode == null && roleList != null && roleList.size() > 0)
		{
			roleCode = roleList.get(0).getRoleCode();
		}

		if (clazzId == 0)
		{
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("user", loginUser);
			paramMap.put("userId", loginUser.getUserId());
			paramMap.put("permissionCode", "curriculumManager");
			paramMap.put("roleCode", roleCode);

			List<Clazz> clazzList = commonService.getClazzListByRoleCode(paramMap);
			if (clazzList.size() > 0)
			{
				clazzId = clazzList.get(0).getId();
			}
		}

		List<Week> weekList = curriculumService.getWeekList();

		// 开始日期
		String startDate = request.getParameter("startDate");

		if (StringUtil.isEmpty(startDate))
		{
			startDate = TimeUtil.getInstance().date();
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("date", startDate);
		paramMap.put("clazzId", clazzId);
		CurriculumSemester semester = todayActivityService.getTodayActivityByDate(paramMap);

		if (semester != null)
		{
			times = 1;
			// 上午
			List<CurriculumTime> curriculumMorningTimeList = curriculumService.getCurriculumTimeMorningBySemesterId(semester.getId());
			modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);

			if (curriculumMorningTimeList.size() > 0)
			{
				for (CurriculumTime curriculumTime : curriculumMorningTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			// 中午
			CurriculumTime curriculumNoonTime = todayActivityService.getCurriculumTimeNoonBySemesterId(semester.getId());
			modelMap.addAttribute("curriculumNoonTime", curriculumNoonTime);

			// 下午
			List<CurriculumTime> curriculumAfternoonTimeList = curriculumService.getCurriculumTimeAfternoonBySemesterId(semester.getId());
			modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);

			if (curriculumAfternoonTimeList.size() > 0)
			{
				for (CurriculumTime curriculumTime : curriculumAfternoonTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			modelMap.addAttribute("startDay", semester.getBeginDate());
			modelMap.addAttribute("semesterId", semester.getId());
		}

		modelMap.addAttribute("weekList", weekList);
		modelMap.addAttribute("times", times);
		modelMap.addAttribute("clazzId", clazzId);
		modelMap.addAttribute("roleCode", roleCode);

		return "todayactivity/today_activity";
	}

	/**
	 * 进入创建每日活动页面(班主任或有此权限的)
	 */
	@RequestMapping(value = "/toAddTodayActivity.do")
	public String toAddTodayActivity(ModelMap modelMap, HttpServletRequest request)
	{
		List<Week> weekList = curriculumService.getWeekList();
		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));
		modelMap.addAttribute("weekList", weekList);
		modelMap.addAttribute("clazzId", clazzId);
		return "todayactivity/today_activity_add";
	}

	/**
	 * 班主任或有此权限的创建每日活动
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toSaveTodayActivity.do")
	public String toSaveTodayActivity(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");

		User user = (User) session.getAttribute("user");

		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

		// 开始结束日期
		String startDay = request.getParameter("startDay");
		String endDay = request.getParameter("endDay");

		// 上午开始结束时间
		String[] startTimeAm = request.getParameterValues("startTimeAm");
		String[] endTimeAm = request.getParameterValues("endTimeAm");

		// 上午周一的课程
		String[] subAm1 = request.getParameterValues("subAm1");
		// 上午周二的课程
		String[] subAm2 = request.getParameterValues("subAm2");
		// 上午周三的课程
		String[] subAm3 = request.getParameterValues("subAm3");
		// 上午周四的课程
		String[] subAm4 = request.getParameterValues("subAm4");
		// 上午周五的课程
		String[] subAm5 = request.getParameterValues("subAm5");
		// 上午周六的课程
		String[] subAm6 = request.getParameterValues("subAm6");
		// 上午周七的课程
		String[] subAm7 = request.getParameterValues("subAm7");

		// 中午午开始结束时间
		String[] startTimeNoon = request.getParameterValues("startTimeNoon");
		String[] endTimeNoon = request.getParameterValues("endTimeNoon");

		// 下午开始结束时间
		String[] startTimePm = request.getParameterValues("startTimePm");

		String[] endTimePm = request.getParameterValues("endTimePm");
		// 下午周一的课程
		String[] subPm1 = request.getParameterValues("subPm1");
		// 下午周二的课程
		String[] subPm2 = request.getParameterValues("subPm2");
		// 下午周三的课程
		String[] subPm3 = request.getParameterValues("subPm3");
		// 下午周四的课程
		String[] subPm4 = request.getParameterValues("subPm4");
		// 下午周五的课程
		String[] subPm5 = request.getParameterValues("subPm5");
		// 下午周六的课程
		String[] subPm6 = request.getParameterValues("subPm6");
		// 下午周七的课程
		String[] subPm7 = request.getParameterValues("subPm7");

		//
		CurriculumSemester semester = new CurriculumSemester();
		semester.setBeginDate(startDay);
		semester.setEndDate(endDay);
		semester.setClazzId(clazzId);
		semester.setUsable(1);
		semester.setCreateTime(TimeUtil.getInstance().now());
		Integer semesterId = curriculumService.saveCurriculumSemester(semester);

		for (int i = 0; i < startTimeAm.length; i++)
		{
			CurriculumTime curriculumTime = new CurriculumTime();

			curriculumTime.setSemesterId(semesterId);
			curriculumTime.setBeginTime(startTimeAm[i]);
			curriculumTime.setEndTime(endTimeAm[i]);
			curriculumTime.setNum(1);
			curriculumTime.setCreateTime(TimeUtil.getInstance().now());
			Integer timeId = curriculumService.saveCurriculumTime(curriculumTime);

			for (int w = 1; w < 8; w++)
			{
				Curriculum curriculum = new Curriculum();
				curriculum.setClazzId(clazzId);
				curriculum.setSemesterId(semesterId);
				curriculum.setTimeId(timeId);
				if (w == 1)
				{
					curriculum.setSubjectName(subAm1[i]);
				} else if (w == 2)
				{
					curriculum.setSubjectName(subAm2[i]);
				} else if (w == 3)
				{
					curriculum.setSubjectName(subAm3[i]);
				} else if (w == 4)
				{
					curriculum.setSubjectName(subAm4[i]);
				} else if (w == 5)
				{
					curriculum.setSubjectName(subAm5[i]);
				} else if (w == 6)
				{
					curriculum.setSubjectName(subAm6[i]);
				} else if (w == 7)
				{
					curriculum.setSubjectName(subAm7[i]);
				}

				curriculum.setUserId(user.getUserId());
				curriculum.setWeekId(w);
				curriculum.setCreateTime(TimeUtil.getInstance().now());
				curriculumService.saveCurriculum(curriculum);
			}

		}

		for (int i = 0; i < startTimePm.length; i++)
		{
			CurriculumTime curriculumTime = new CurriculumTime();

			curriculumTime.setSemesterId(semesterId);
			curriculumTime.setBeginTime(startTimePm[i]);
			curriculumTime.setEndTime(endTimePm[i]);
			curriculumTime.setNum(2);
			curriculumTime.setCreateTime(TimeUtil.getInstance().now());

			Integer timeId = curriculumService.saveCurriculumTime(curriculumTime);
			for (int w = 1; w < 8; w++)
			{
				Curriculum curriculum = new Curriculum();
				curriculum.setClazzId(clazzId);
				curriculum.setSemesterId(semesterId);
				curriculum.setTimeId(timeId);
				if (w == 1)
				{
					curriculum.setSubjectName(subPm1[i]);
				} else if (w == 2)
				{
					curriculum.setSubjectName(subPm2[i]);
				} else if (w == 3)
				{
					curriculum.setSubjectName(subPm3[i]);
				} else if (w == 4)
				{
					curriculum.setSubjectName(subPm4[i]);
				} else if (w == 5)
				{
					curriculum.setSubjectName(subPm5[i]);
				} else if (w == 6)
				{
					curriculum.setSubjectName(subPm6[i]);
				} else if (w == 7)
				{
					curriculum.setSubjectName(subPm7[i]);
				}

				curriculum.setUserId(user.getUserId());
				curriculum.setWeekId(w);
				curriculum.setCreateTime(TimeUtil.getInstance().now());
				curriculumService.saveCurriculum(curriculum);
			}
		}

		for (int i = 0; i < startTimeNoon.length; i++)
		{
			if (!StringUtil.isEmpty(startTimeNoon[i]))
			{
				CurriculumTime curriculumTime = new CurriculumTime();

				curriculumTime.setSemesterId(semesterId);
				curriculumTime.setBeginTime(startTimeNoon[i]);
				curriculumTime.setEndTime(endTimeNoon[i]);
				curriculumTime.setNum(5);
				curriculumTime.setCreateTime(TimeUtil.getInstance().now());
				curriculumService.saveCurriculumTime(curriculumTime);
			}
		}

		return toTodayActivity(request, session, response, modelMap);

	}

	/**
	 * 进入编辑每日活动页面(班主任或有此权限的人)
	 */
	@RequestMapping(value = "/toEditTodayActivity.do")
	public String toEditTodayActivity(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			List<Week> weekList = curriculumService.getWeekList();
			String startDay = request.getParameter("startDay");
			Integer semesterId = StringUtil.toint(request.getParameter("semesterId"));
			Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));
			String roleCode = request.getParameter("roleCode");

			User loginUser = (User) session.getAttribute("User");

			// 上午
			List<CurriculumTime> curriculumMorningTimeList = curriculumService.getCurriculumTimeMorningBySemesterId(semesterId);
			modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);

			if (curriculumMorningTimeList.size() > 0)
			{
				for (CurriculumTime curriculumTime : curriculumMorningTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			// 中午
			CurriculumTime curriculumNoonTime = todayActivityService.getCurriculumTimeNoonBySemesterId(semesterId);
			modelMap.addAttribute("curriculumNoonTime", curriculumNoonTime);

			// 下午
			List<CurriculumTime> curriculumAfternoonTimeList = curriculumService.getCurriculumTimeAfternoonBySemesterId(semesterId);
			modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);

			if (curriculumAfternoonTimeList.size() > 0)
			{
				for (CurriculumTime curriculumTime : curriculumAfternoonTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			modelMap.addAttribute("weekList", weekList);
			modelMap.addAttribute("startDay", startDay);
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("semesterId", semesterId);
			modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);
			modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);

			return "todayactivity/today_activity_edit";
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 修改活动时间
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/modifyTime.do")
	public String modifyTime(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 时间名称
			String time = request.getParameter("time");
			// 时间Id
			String timeId = request.getParameter("timeId");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("updateTime", TimeUtil.getInstance().now());
			if (timeId.startsWith("B"))
			{
				paramMap.put("beginTime", time);
				paramMap.put("endTime", "");
				paramMap.put("timeId", StringUtil.toint(timeId.replace("B", "")));
			} else if (timeId.startsWith("E"))
			{
				paramMap.put("beginTime", "");
				paramMap.put("endTime", time);
				paramMap.put("timeId", StringUtil.toint(timeId.replace("E", "")));
			}
			todayActivityService.modifyTime(paramMap);

			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 修改活动名称
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/modifyActivityName.do")
	public String modifyActivityName(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 活动名称
			String activityName = request.getParameter("activityName");
			// 时间Id
			String activityId = request.getParameter("activityId");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("updateTime", TimeUtil.getInstance().now());
			paramMap.put("activityName", activityName);
			paramMap.put("id", StringUtil.toint(activityId));
			todayActivityService.modifyActivityName(paramMap);

			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 创建每日活动时校验日期是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toCheckSemester.do")
	public String toCheckSemester(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String startDay = request.getParameter("startDay");
			String endDay = request.getParameter("endDay");
			Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("startDay", startDay);
			paramMap.put("endDay", endDay);
			paramMap.put("clazzId", clazzId);

			ResultInfo resultInfo = todayActivityService.checkSemester(paramMap);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(resultInfo);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/********************* 手机端begin ************************/

	/**
	 * 进入每日活动页面(APP)
	 */
	@RequestMapping(value = "/toTodayActivityHuXin.do")
	public String toSetCurriculumHuXin(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

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
				return "app/activity/activity_detail_app";
			}
		} else
		{
			modelMap.addAttribute("apiKeyTimeOut", "2");
		}

		DBContextHolder.setDBType(user.getSchoolId());

		/*
		 * 存session
		 */
		session.setAttribute("user", user);
		try
		{

			String roleCode = request.getParameter("roleCode");

			// 用于页面判断是否有每日活动
			Integer times = 0;

			Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

			List<Role> roleList = user.getRoleList();

			if (roleCode == null && roleList != null && roleList.size() > 0)
			{
				roleCode = roleList.get(0).getRoleCode();
			}

			if (clazzId == 0)
			{
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("user", user);
				paramMap.put("userId", user.getUserId());
				paramMap.put("permissionCode", "curriculumManager");
				paramMap.put("roleCode", roleCode);

				List<Clazz> clazzList = commonService.getClazzListByRoleCode(paramMap);
				if (clazzList.size() > 0)
				{
					clazzId = clazzList.get(0).getId();
				}
			}

			List<Week> weekList = curriculumService.getWeekList();

			// 开始日期
			String startDate = request.getParameter("startDate");

			if (StringUtil.isEmpty(startDate))
			{
				startDate = TimeUtil.getInstance().date();
			}

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("date", startDate);
			paramMap.put("clazzId", clazzId);
			CurriculumSemester semester = todayActivityService.getTodayActivityByDate(paramMap);

			if (semester != null)
			{
				times = 1;
				// 上午
				List<CurriculumTime> curriculumMorningTimeList = curriculumService.getCurriculumTimeMorningBySemesterId(semester.getId());
				modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);

				if (curriculumMorningTimeList.size() > 0)
				{
					for (CurriculumTime curriculumTime : curriculumMorningTimeList)
					{

						List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, user, clazzId);

						if (curriculumList != null && curriculumList.size() > 0)
						{
							curriculumTime.setCurriculumList(curriculumList);
						}
					}
				}

				// 中午
				CurriculumTime curriculumNoonTime = todayActivityService.getCurriculumTimeNoonBySemesterId(semester.getId());
				modelMap.addAttribute("curriculumNoonTime", curriculumNoonTime);

				// 下午
				List<CurriculumTime> curriculumAfternoonTimeList = curriculumService.getCurriculumTimeAfternoonBySemesterId(semester.getId());
				modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);

				if (curriculumAfternoonTimeList.size() > 0)
				{
					for (CurriculumTime curriculumTime : curriculumAfternoonTimeList)
					{

						List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, user, clazzId);

						if (curriculumList != null && curriculumList.size() > 0)
						{
							curriculumTime.setCurriculumList(curriculumList);
						}
					}
				}

				modelMap.addAttribute("semesterId", semester.getId());
			}

			modelMap.addAttribute("startDate", startDate);
			modelMap.addAttribute("weekList", weekList);
			modelMap.addAttribute("times", times);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			modelMap.addAttribute("roleList", user.getRoleList());

			return "app/activity/activity_detail_app";

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 进入课程表搜索页面（管理员校长、班主任、家长）
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toTodayActivitySearchAPP.do")
	public String toTodayActivitySearchAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");

		User user = (User) session.getAttribute("user");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", "curriculumManager");
		paramMap.put("roleCode", roleCode);

		List<Clazz> clazzList = commonService.getClazzListByRoleCode(paramMap);

		modelMap.addAttribute("clazzList", clazzList);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("userId", user.getUserId());

		return "app/activity/activity_search_app";
	}

	/**
	 * 进入添加每日活动页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toAddTodayActivityAPP.do")
	public String toAddTodayActivityAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");
		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

		User user = (User) session.getAttribute("user");
		List<Week> weekList = curriculumService.getWeekList();
		weekList.remove(weekList.size() - 1);
		weekList.remove(weekList.size() - 1);

		modelMap.addAttribute("weekList", weekList);
		modelMap.addAttribute("clazzId", clazzId);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("userId", user.getUserId());

		return "app/activity/activity_add_app";
	}

	/**
	 * 【手机端】 班主任或有此权限的创建每日活动
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/saveTodayActivityByapiKey.do")
	public String saveTodayActivityByapiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");

		try
		{
			User user = (User) session.getAttribute("user");

			Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

			// 开始结束日期
			String startDay = request.getParameter("startDay");
			String endDay = request.getParameter("endDay");

			// 上午开始结束时间
			String[] startTimeAm = request.getParameterValues("startTimeAm");
			String[] endTimeAm = request.getParameterValues("endTimeAm");

			// 上午周一的课程
			String[] subAm1 = request.getParameterValues("subAm1");
			// 上午周二的课程
			String[] subAm2 = request.getParameterValues("subAm2");
			// 上午周三的课程
			String[] subAm3 = request.getParameterValues("subAm3");
			// 上午周四的课程
			String[] subAm4 = request.getParameterValues("subAm4");
			// 上午周五的课程
			String[] subAm5 = request.getParameterValues("subAm5");

			// 中午午开始结束时间
			String[] startTimeNoon = request.getParameterValues("startTimeNoon");
			String[] endTimeNoon = request.getParameterValues("endTimeNoon");

			// 下午开始结束时间
			String[] startTimePm = request.getParameterValues("startTimePm");

			String[] endTimePm = request.getParameterValues("endTimePm");
			// 下午周一的课程
			String[] subPm1 = request.getParameterValues("subPm1");
			// 下午周二的课程
			String[] subPm2 = request.getParameterValues("subPm2");
			// 下午周三的课程
			String[] subPm3 = request.getParameterValues("subPm3");
			// 下午周四的课程
			String[] subPm4 = request.getParameterValues("subPm4");
			// 下午周五的课程
			String[] subPm5 = request.getParameterValues("subPm5");

			//
			CurriculumSemester semester = new CurriculumSemester();
			semester.setBeginDate(startDay);
			semester.setEndDate(endDay);
			semester.setClazzId(clazzId);
			semester.setUsable(1);
			semester.setCreateTime(TimeUtil.getInstance().now());
			Integer semesterId = curriculumService.saveCurriculumSemester(semester);

			for (int i = 0; i < startTimeAm.length; i++)
			{
				CurriculumTime curriculumTime = new CurriculumTime();

				curriculumTime.setSemesterId(semesterId);
				curriculumTime.setBeginTime(startTimeAm[i]);
				curriculumTime.setEndTime(endTimeAm[i]);
				curriculumTime.setNum(1);
				curriculumTime.setCreateTime(TimeUtil.getInstance().now());
				Integer timeId = curriculumService.saveCurriculumTime(curriculumTime);

				for (int w = 1; w < 8; w++)
				{
					Curriculum curriculum = new Curriculum();
					curriculum.setClazzId(clazzId);
					curriculum.setSemesterId(semesterId);
					curriculum.setTimeId(timeId);
					if (w == 1)
					{
						curriculum.setSubjectName(subAm1[i]);
					} else if (w == 2)
					{
						curriculum.setSubjectName(subAm2[i]);
					} else if (w == 3)
					{
						curriculum.setSubjectName(subAm3[i]);
					} else if (w == 4)
					{
						curriculum.setSubjectName(subAm4[i]);
					} else if (w == 5)
					{
						curriculum.setSubjectName(subAm5[i]);
					}

					curriculum.setUserId(user.getUserId());
					curriculum.setWeekId(w);
					curriculum.setCreateTime(TimeUtil.getInstance().now());
					curriculumService.saveCurriculum(curriculum);
				}

			}

			for (int i = 0; i < startTimePm.length; i++)
			{
				CurriculumTime curriculumTime = new CurriculumTime();

				curriculumTime.setSemesterId(semesterId);
				curriculumTime.setBeginTime(startTimePm[i]);
				curriculumTime.setEndTime(endTimePm[i]);
				curriculumTime.setNum(2);
				curriculumTime.setCreateTime(TimeUtil.getInstance().now());

				Integer timeId = curriculumService.saveCurriculumTime(curriculumTime);
				for (int w = 1; w < 8; w++)
				{
					Curriculum curriculum = new Curriculum();
					curriculum.setClazzId(clazzId);
					curriculum.setSemesterId(semesterId);
					curriculum.setTimeId(timeId);
					if (w == 1)
					{
						curriculum.setSubjectName(subPm1[i]);
					} else if (w == 2)
					{
						curriculum.setSubjectName(subPm2[i]);
					} else if (w == 3)
					{
						curriculum.setSubjectName(subPm3[i]);
					} else if (w == 4)
					{
						curriculum.setSubjectName(subPm4[i]);
					} else if (w == 5)
					{
						curriculum.setSubjectName(subPm5[i]);
					}

					curriculum.setUserId(user.getUserId());
					curriculum.setWeekId(w);
					curriculum.setCreateTime(TimeUtil.getInstance().now());
					curriculumService.saveCurriculum(curriculum);
				}
			}

			for (int i = 0; i < startTimeNoon.length; i++)
			{
				if (!StringUtil.isEmpty(startTimeNoon[i]))
				{
					CurriculumTime curriculumTime = new CurriculumTime();

					curriculumTime.setSemesterId(semesterId);
					curriculumTime.setBeginTime(startTimeNoon[i]);
					curriculumTime.setEndTime(endTimeNoon[i]);
					curriculumTime.setNum(5);
					curriculumTime.setCreateTime(TimeUtil.getInstance().now());
					curriculumService.saveCurriculumTime(curriculumTime);
				}
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return toSetCurriculumHuXin(request, session, response, modelMap);

	}

	/**
	 * 【手机端】进入编辑每日活动页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toEditTodayActivityAPP.do")
	public String toEditTodayActivityAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");
		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

		try
		{
			List<Week> weekList = curriculumService.getWeekList();
			String startDate = request.getParameter("startDate");
			Integer semesterId = StringUtil.toint(request.getParameter("semesterId"));

			User loginUser = (User) session.getAttribute("User");

			// 上午
			List<CurriculumTime> curriculumMorningTimeList = curriculumService.getCurriculumTimeMorningBySemesterId(semesterId);
			modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);

			if (curriculumMorningTimeList.size() > 0)
			{
				for (CurriculumTime curriculumTime : curriculumMorningTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			// 中午
			CurriculumTime curriculumNoonTime = todayActivityService.getCurriculumTimeNoonBySemesterId(semesterId);
			modelMap.addAttribute("curriculumNoonTime", curriculumNoonTime);

			// 下午
			List<CurriculumTime> curriculumAfternoonTimeList = curriculumService.getCurriculumTimeAfternoonBySemesterId(semesterId);
			modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);

			if (curriculumAfternoonTimeList.size() > 0)
			{
				for (CurriculumTime curriculumTime : curriculumAfternoonTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			modelMap.addAttribute("apiKey", apiKey);
			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("weekList", weekList);
			modelMap.addAttribute("startDate", startDate);
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("semesterId", semesterId);
			modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);
			modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "app/activity/activity_edit_app";
	}
	
	
		
		/**
		 * 【手机端】修改每日活动的作息时间
		 */
		@RequestMapping(value = "/modifyTimeForApp.do")
		public String modifyTimeForApp(HttpServletRequest request, HttpServletResponse response, HttpSession session)
		{
			response.setCharacterEncoding("UTF-8");

			try
			{

				CurriculumTime[] htpa = GsonHelper.fromJson(request.getParameter("infoList"), CurriculumTime[].class);
				List<CurriculumTime> htpaList = Arrays.asList(htpa);
				boolean flag = true;
				for (CurriculumTime curriculumTime : htpaList)
				{
					try
					{
						Map<String, Object> paramMap = new HashMap<String, Object>();
						paramMap.put("beginTime", curriculumTime.getBeginTime());
						paramMap.put("endTime", curriculumTime.getEndTime());
						paramMap.put("updateTime", TimeUtil.getInstance().now());
						paramMap.put("timeId", curriculumTime.getId());
						//【手机端】修改每日活动的作息时间
						todayActivityService.modifyTime(paramMap);
					}catch(Exception e)
					{
						e.printStackTrace();
						flag = false;
						
					}
				}
				
				
				/**
				 * flush到页面
				 */
				Gson gson = new Gson();
				String json = gson.toJson(flag);
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (Exception e)
			{
				e.printStackTrace();
			}
			return null;
		}

	/********************* 手机端end ************************/

}
