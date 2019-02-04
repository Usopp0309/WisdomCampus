package com.guotop.palmschool.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.ScheduleClazz;
import com.guotop.palmschool.entity.ScheduleTeacher;
import com.guotop.palmschool.entity.ScheduleTime;
import com.guotop.palmschool.entity.ScheduleTimeRelation;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 作息时间表设定控制类
 * 
 * @author zhou
 */
@RequestMapping("/schedule")
@Controller
public class ScheduleController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(ScheduleController.class);

	@Resource
	private CommonService commonService;

	@Resource
	private ScheduleService scheduleService;

	@Resource
	private ClazzService clazzService;

	@Resource
	private UserService userService;

	/**
	 * 根据时间获得作息时间
	 */
	@RequestMapping(value = "/getScheduleByDate.do")
	public void getScheduleByDate(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		String liveingDate = request.getParameter("liveingDate");
		List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(liveingDate);
		Gson gson = new Gson();
		String json = gson.toJson(list);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 进入作息时间新增页面 20151129
	 */
	@RequestMapping(value = "/toAddSchedule.do")
	public String toAddSchedule(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		User user = (User) session.getAttribute("user");

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", user);

		return "schedule/schedule_add";
	}

	/**
	 * 执行作息时间新增逻辑
	 */
	@RequestMapping(value = "/doAddSchedule.do")
	public String doAddSchedule(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		User user = (User) session.getAttribute("user");

		/**
		 * 开始时间
		 */
		String startTime = request.getParameter("startTime");

		/**
		 * 结束时间
		 */
		String endTime = request.getParameter("endTime");
		// 分段 或整天
		String type = request.getParameter("type");

		/**
		 * 早上，下午，晚上的checkbox
		 */
		String[] timeCheckBox = request.getParameterValues("timeCheckBox");

		List<Schedule> scheduleList = TimeUtil.getInstance().getScheduleList(startTime, endTime);

		for (Schedule schedule : scheduleList)
		{
			String liveDate = schedule.getLiveingDate().substring(0, 10);
			if ("0".equals(type))
			{
				schedule.setType(0);
				if (null != timeCheckBox && timeCheckBox.length > 0)
				{
					for (int i = 0; i < timeCheckBox.length; i++)
					{
						if ("morning".equals(timeCheckBox[i]))
						{
							schedule.setAmStartTime(liveDate + " " + request.getParameter("morningBegin"));
							schedule.setAmEndTime(liveDate + " " + request.getParameter("morningEnd"));
						} else if ("afternoon".equals(timeCheckBox[i]))
						{
							schedule.setPmStartTime(liveDate + " " + request.getParameter("afternoonBegin"));
							schedule.setPmEndTime(liveDate + " " + request.getParameter("afternoonEnd"));
						} else
						{
							schedule.setNightStartTime(liveDate + " " + request.getParameter("nightBegin"));
							schedule.setNightEndTime(liveDate + " " + request.getParameter("nightEnd"));
						}
					}
					schedule.setUserId(user.getId());
					scheduleService.addSchedule(schedule);
				} else
				{
					schedule.setUserId(user.getId());
					scheduleService.addSchedule(schedule);
				}
			} else
			{
				schedule.setType(1);
				schedule.setBeginTime(liveDate + " " + request.getParameter("beginTime"));
				schedule.setEndTime(liveDate + " " + request.getParameter("end"));
				schedule.setUserId(user.getId());
				scheduleService.addSchedule(schedule);
			}

		}

		return toScheduleList();
	}

	/**
	 * 进入修改作息时间表页面
	 */
	@RequestMapping(value = "/toEditSchedule.do")
	public String toEditSchedule(HttpServletRequest request, ModelMap modelMap)
	{
		/**
		 * 生效时间
		 */
		String liveingDate = request.getParameter("liveingDate");
		List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(liveingDate);

		for (Schedule s : list)
		{
			if (s.getAmStartTime() != null)
			{
				s.setAmStartTime(s.getAmStartTime().replace(liveingDate + " ", ""));
				s.setAmEndTime(s.getAmEndTime().replace(liveingDate + " ", ""));
			}
			if (s.getPmStartTime() != null)
			{
				s.setPmStartTime(s.getPmStartTime().replace(liveingDate + " ", ""));
				s.setPmEndTime(s.getPmEndTime().replace(liveingDate + " ", ""));
			}
			if (s.getNightStartTime() != null)
			{
				s.setNightStartTime(s.getNightStartTime().replace(liveingDate + " ", ""));
				s.setNightEndTime(s.getNightEndTime().replace(liveingDate + " ", ""));
			}
			if (s.getBeginTime() != null)
			{
				s.setBeginTime(s.getBeginTime().replace(liveingDate + " ", ""));
				s.setEndTime(s.getEndTime().replace(liveingDate + " ", ""));
			}

		}
		/**
		 * 回写页面隐藏域
		 */
		modelMap.addAttribute("liveingDate", liveingDate);
		modelMap.addAttribute("list", list);

		return "schedule/schedule_edit";
	}

	/**
	 * 加载待修改作息时间表数据
	 */
	@RequestMapping(value = "/loadEditSchedule.do")
	public String loadEditSchedule(HttpServletRequest request, HttpServletResponse response)
	{
		/**
		 * schedule主键
		 */
		// Integer scheduleId =
		// Integer.valueOf(request.getParameter("scheduleId"));
		String liveingDate = request.getParameter("liveingDate");

		List<Schedule> scheduleList = scheduleService.selectScheduleListByLiveingDate(liveingDate);

		try
		{
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(scheduleList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 执行修改作息时间表逻辑
	 */
	@RequestMapping(value = "/doEditSchedule.do")
	public String doEditSchedule(HttpServletRequest request, ModelMap modelMap)
	{
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * schedule主键
		 */
		Integer scheduleId = Integer.valueOf(request.getParameter("scheduleId"));
		/**
		 * 生效时间
		 */
		String liveingDate = request.getParameter("liveingDate");

		// 以liveingDate清除以前的数据
		// scheduleService.deleteScheduleByLiveingDate(liveingDate);
		/**
		 * 上午
		 */
		String amStartHour = request.getParameter("amstarttime");
		String amStartTime = liveingDate + " " + amStartHour;

		String amEndHour = request.getParameter("amendtime");
		String amEndTime = liveingDate + " " + amEndHour;

		/**
		 * 下午
		 */
		String pmStartHour = request.getParameter("pmstarttime");
		String pmStartTime = liveingDate + " " + pmStartHour;

		String pmEndHour = request.getParameter("pmendtime");
		String pmEndTime = liveingDate + " " + pmEndHour;

		/**
		 * 晚上
		 */
		String nightStartHour = request.getParameter("nightstarttime");
		String nightStartTime = liveingDate + " " + nightStartHour;

		String nightEndHour = request.getParameter("nightendtime");
		String nightEndTime = liveingDate + " " + nightEndHour;

		String beginTime = liveingDate + " " + request.getParameter("beginTime");
		String endTime = liveingDate + " " + request.getParameter("endTime");
		/**
		 * 状态
		 */
		String status = request.getParameter("status");

		/**
		 * 放入入参
		 */
		paramMap.put("scheduleId", scheduleId);
		paramMap.put("amStartTime", amStartTime);
		paramMap.put("amEndTime", amEndTime);
		paramMap.put("pmStartTime", pmStartTime);
		paramMap.put("pmEndTime", pmEndTime);
		paramMap.put("nightStartTime", nightStartTime);
		paramMap.put("nightEndTime", nightEndTime);
		paramMap.put("status", status);
		paramMap.put("liveingDate", liveingDate);
		paramMap.put("beginTime", beginTime);
		paramMap.put("endTime", endTime);

		scheduleService.updateScheduleById(paramMap);

		return toScheduleList();
	}

	/**
	 * 检查作息时间
	 * 
	 * @author chenyong
	 * @date 2016年10月13日 上午9:45:13
	 * @param beginTime
	 * @param endTime
	 * @param response
	 */
	@RequestMapping("/checkScheule.do")
	public void checkScheule(String beginTime, String endTime, HttpServletResponse response, String scheduleId)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startDay", beginTime);
		map.put("endDay", endTime);
		Schedule schedule = scheduleService.selectWorkingDays(map);
		map = new HashMap<String, Object>();
		map.put("flag", "0");
		if (StringUtil.isEmpty(scheduleId))
		{// 添加
			if (schedule != null)
			{
				map.put("msg", "已存在作息日期：" + schedule.getLiveingDate());
				map.put("flag", "1");
			} else
			{
				map.put("msg", "");
			}
		} else
		{// 修改
			if (schedule != null && !scheduleId.equals(schedule.getId().toString()))
			{
				map.put("msg", "起始和结束日期与已存在作息日期：" + schedule.getLiveingDate());
				map.put("flag", "1");
			}
		}
		try
		{
			response.getWriter().write(GsonHelper.toJson(map));
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	/*********************** 新的作息时间设置 *****************************/

	/**
	 * 进入作息时间表页面
	 */
	@RequestMapping(value = "/toScheduleList.do")
	public String toScheduleList()
	{
		return "schedule/news_schedule_list";
	}

	/**
	 * 不同权限查看到不同的page 作息时间设定表 加载作息时间list
	 */
	@RequestMapping(value = "/loadScheduleList.do")
	public String loadScheduleList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
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

			User user = (User) session.getAttribute("user");

			paramMap.put("userId", user.getUserId());
			Pages pages = null;
			if (!StringUtil.isFjequals(user.getSchoolId()))
			{// 非福建
				pages = scheduleService.loadScheduleList(this.getPages().getPageSize(), currentPage, paramMap);
			} else
			{
				paramMap.put("fjSchoolId", user.getFjSchoolId());
			}
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

	/**
	 * 进入设置日期和时间段页面
	 */
	@RequestMapping(value = "/toSetScheduleTime.do")
	public String toSetScheduleTime()
	{
		return "schedule/news_schedule_add";
	}

	/**
	 * 执行作息时间新增逻辑
	 */
	@RequestMapping(value = "/doSaveSchedule.do")
	public String doSaveSchedule(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		User user = (User) session.getAttribute("user");

		SimpleDateFormat time = new SimpleDateFormat("HH:mm");

		/**
		 * 开始日期
		 */
		String startDay = request.getParameter("startDay");

		/**
		 * 结束日期
		 */
		String endDay = request.getParameter("endDay");

		/**
		 * 0分段 或 1整天
		 */
		String type = request.getParameter("type");

		List<Schedule> scheduleList = TimeUtil.getInstance().getScheduleList(startDay, endDay);

		List<Integer> scheduleIdList = new ArrayList<Integer>();

		List<Integer> scheduleTimeIdList = new ArrayList<Integer>();

		if ("0".equals(type))
		{
			// 上午开始结束时间
			String[] morningBeginArr = request.getParameterValues("morningBegin");
			String[] morningEndArr = request.getParameterValues("morningEnd");

			String amCheck = request.getParameter("amCheck");

			String morningBeginTime = null;
			String morningEndTime = null;
			if (!StringUtil.isEmpty(amCheck))
			{
				for (int i = 0; i < morningBeginArr.length; i++)
				{
					ScheduleTime scheduleTime = new ScheduleTime();
					scheduleTime.setType(1);// 0全天 1上午 2下午 3晚上
					scheduleTime.setBeginTime(morningBeginArr[i]);
					scheduleTime.setEndTime(morningEndArr[i]);
					scheduleTime.setCreateTime(TimeUtil.getInstance().now());
					Integer scheduleTimeId = scheduleService.saveScheduleTime(scheduleTime);// 添加时间段
					scheduleTimeIdList.add(scheduleTimeId);
					try
					{
						Date beginDate = time.parse(morningBeginArr[i]);
						Date endDate = time.parse(morningEndArr[i]);
						if (StringUtil.isEmpty(morningBeginTime) || beginDate.getTime() <= time.parse(morningBeginTime).getTime())
						{
							morningBeginTime = morningBeginArr[i];
						}
						if (StringUtil.isEmpty(morningEndTime) || endDate.getTime() >= time.parse(morningEndTime).getTime())
						{
							morningEndTime = morningEndArr[i];
						}
					} catch (ParseException e)
					{
						e.printStackTrace();
					}
				}
			}

			// 下午开始结束时间
			String[] afternoonBeginArr = request.getParameterValues("afternoonBegin");
			String[] afternoonEndArr = request.getParameterValues("afternoonEnd");

			String afternoonBeginTime = null;
			String afternoonEndTime = null;
			String pmCheck = request.getParameter("pmCheck");
			if (!StringUtil.isEmpty(pmCheck))
			{
				for (int i = 0; i < afternoonBeginArr.length; i++)
				{
					ScheduleTime scheduleTime = new ScheduleTime();
					scheduleTime.setType(2);// 0全天 1上午 2下午 3晚上
					scheduleTime.setBeginTime(afternoonBeginArr[i]);
					scheduleTime.setEndTime(afternoonEndArr[i]);
					scheduleTime.setCreateTime(TimeUtil.getInstance().now());
					Integer scheduleTimeId = scheduleService.saveScheduleTime(scheduleTime);// 添加时间段
					scheduleTimeIdList.add(scheduleTimeId);
					try
					{
						Date beginDate = time.parse(afternoonBeginArr[i]);
						Date endDate = time.parse(afternoonEndArr[i]);
						if (StringUtil.isEmpty(afternoonBeginTime) || beginDate.getTime() <= time.parse(afternoonBeginTime).getTime())
						{
							afternoonBeginTime = afternoonBeginArr[i];
						}

						if (StringUtil.isEmpty(afternoonEndTime) || endDate.getTime() >= time.parse(afternoonEndTime).getTime())
						{
							afternoonEndTime = afternoonEndArr[i];
						}

					} catch (ParseException e)
					{
						e.printStackTrace();
					}
				}
			}
			// 晚上开始结束时间
			String[] nightBeginArr = request.getParameterValues("nightBegin");
			String[] nightEndArr = request.getParameterValues("nightEnd");

			String nightBeginTime = null;
			String nightEndTime = null;
			String ngCheck = request.getParameter("ngCheck");
			if (!StringUtil.isEmpty(ngCheck))
			{
				for (int i = 0; i < nightBeginArr.length; i++)
				{
					ScheduleTime scheduleTime = new ScheduleTime();
					scheduleTime.setType(3);// 0全天 1上午 2下午 3晚上
					scheduleTime.setBeginTime(nightBeginArr[i]);
					scheduleTime.setEndTime(nightEndArr[i]);
					scheduleTime.setCreateTime(TimeUtil.getInstance().now());
					Integer scheduleTimeId = scheduleService.saveScheduleTime(scheduleTime);// 添加时间段
					scheduleTimeIdList.add(scheduleTimeId);
					try
					{
						Date beginDate = time.parse(nightBeginArr[i]);
						Date endDate = time.parse(nightEndArr[i]);
						if (StringUtil.isEmpty(nightBeginTime) || beginDate.getTime() <= time.parse(nightBeginTime).getTime())
						{
							nightBeginTime = nightBeginArr[i];
						}
						if (StringUtil.isEmpty(nightEndTime) || endDate.getTime() >= time.parse(nightEndTime).getTime())
						{
							nightEndTime = nightEndArr[i];
						}
					} catch (ParseException e)
					{
						e.printStackTrace();
					}
				}
			}

			for (Schedule schedule : scheduleList)
			{
				String liveDate = schedule.getLiveingDate().substring(0, 10);
				schedule.setType(0);
				if (!StringUtil.isEmpty(morningBeginTime))
				{
					schedule.setAmStartTime(liveDate + " " + morningBeginTime);
					schedule.setAmEndTime(liveDate + " " + morningEndTime);
				}
				if (!StringUtil.isEmpty(afternoonBeginTime))
				{
					schedule.setPmStartTime(liveDate + " " + afternoonBeginTime);
					schedule.setPmEndTime(liveDate + " " + afternoonEndTime);
				}
				if (!StringUtil.isEmpty(nightBeginTime))
				{
					schedule.setNightStartTime(liveDate + " " + nightBeginTime);
					schedule.setNightEndTime(liveDate + " " + nightEndTime);
				}
				schedule.setUserId(user.getId());
				Integer scheduleId = scheduleService.addSchedule(schedule);// 添加作息时间
				scheduleIdList.add(scheduleId);
			}

		} else
		{
			// 结束时间数组
			String[] beginTimeArr = request.getParameterValues("beginTime");
			String[] endTimeArr = request.getParameterValues("endTime");

			String beginTime = null;
			String endTime = null;
			for (int i = 0; i < beginTimeArr.length; i++)
			{
				ScheduleTime scheduleTime = new ScheduleTime();
				scheduleTime.setType(0);// 0全天 1上午 2下午 3晚上
				scheduleTime.setBeginTime(beginTimeArr[i]);
				scheduleTime.setEndTime(endTimeArr[i]);
				scheduleTime.setCreateTime(TimeUtil.getInstance().now());
				Integer scheduleTimeId = scheduleService.saveScheduleTime(scheduleTime);// 添加时间段
				scheduleTimeIdList.add(scheduleTimeId);
				try
				{
					Date beginDate = time.parse(beginTimeArr[i]);
					Date endDate = time.parse(endTimeArr[i]);
					if (StringUtil.isEmpty(beginTime) || beginDate.getTime() <= time.parse(beginTime).getTime())
					{
						beginTime = beginTimeArr[i];
					}
					if (StringUtil.isEmpty(endTime) || endDate.getTime() >= time.parse(endTime).getTime())
					{
						endTime = endTimeArr[i];
					}
				} catch (ParseException e)
				{
					e.printStackTrace();
				}
			}

			for (Schedule schedule : scheduleList)
			{
				String liveDate = schedule.getLiveingDate().substring(0, 10);
				schedule.setType(1);
				schedule.setBeginTime(liveDate + " " + beginTime);
				schedule.setEndTime(liveDate + " " + endTime);
				schedule.setUserId(user.getId());
				Integer scheduleId = scheduleService.addSchedule(schedule);// 添加作息时间
				scheduleIdList.add(scheduleId);
			}
		}

		int j, k;
		for (j = 0; j < scheduleTimeIdList.size(); j++)
		{
			for (k = 0; k < scheduleIdList.size(); k++)
			{
				ScheduleTimeRelation relation = new ScheduleTimeRelation();
				relation.setScheduleId(scheduleIdList.get(k));
				relation.setTimeId(scheduleTimeIdList.get(j));
				relation.setCreateTime(TimeUtil.getInstance().now());
				scheduleService.saveScheduleTimeRelation(relation);// 添加作息时间和时间段的关系
			}
		}

		return toSetScheduleObject(request, modelMap, session);
	}

	/**
	 * 进入设置人员（年级Or班级）和作息时间的关系页面
	 */
	@RequestMapping(value = "/toSetScheduleObject.do")
	public String toSetScheduleObject(HttpServletRequest request, ModelMap modelMap, HttpSession session)
	{
		User user = (User) session.getAttribute("user");
		/**
		 * 开始日期
		 */
		String startDay = request.getParameter("startDay");

		/**
		 * 结束日期
		 */
		String endDay = request.getParameter("endDay");

		/**
		 * 结束日期
		 */
		String type = request.getParameter("type");

		modelMap.addAttribute("startDay", startDay);
		modelMap.addAttribute("endDay", endDay);
		modelMap.addAttribute("type", type);
		modelMap.addAttribute("userId", user.getUserId());

		return "schedule/news_schedule_person";
	}

	/**
	 * 根据开始日期结束日期获取对应的时间段
	 */
	@RequestMapping(value = "/getScheduleTimeListByStartDayAndEndDay.do")
	public String getScheduleTimeListByStartDayAndEndDay(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			/**
			 * 开始日期
			 */
			String startDay = request.getParameter("startDay");
			/**
			 * 结束日期
			 */
			String endDay = request.getParameter("endDay");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("startDay", startDay);
			paramMap.put("endDay", endDay);

			List<ScheduleTime> scheduleTimeList = scheduleService.getScheduleTimeListByStartDayAndEndDay(paramMap);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(scheduleTimeList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据部门idlist获取对应的教师信息
	 */
	@RequestMapping(value = "/loadTeacherListByDepartmentIdArray.do")
	public String loadTeacherListByDepartmentIdArray(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			/**
			 * 部门id集合
			 */
			String departmentIdArray = request.getParameter("departmentIdArray");

			// 这个是所有选择的权限map集合 key=二级菜单权限 value=子权限list
			List<Integer> departmentIdList = GsonHelper.fromJson(departmentIdArray, new TypeToken<List<Integer>>()
			{
			}.getType());

			List<User> teacherList = new ArrayList<>();
			if (departmentIdList.size() > 0)
			{
				teacherList = userService.getTeacherListByDepartmentIdList(departmentIdList);
			}

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(teacherList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 执行保存作息时间作用对象
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/saveScheduleObject.do")
	public String saveScheduleObject(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			/**
			 * 操作对象 0教师 1学生
			 */
			String objectType = request.getParameter("objectType");

			/**
			 * 开始日期
			 */
			String startDay = request.getParameter("startDay");

			/**
			 * 结束日期
			 */
			String endDay = request.getParameter("endDay");

			/**
			 * 类型
			 */
			Integer type = StringUtil.toint(request.getParameter("type"));

			/**
			 * 教师集合
			 */
			String teacherMapJSON = request.getParameter("teacherMap");

			/**
			 * 年级集合
			 */
			String gradeMapJSON = request.getParameter("gradeMap");

			/**
			 * 时间集合
			 */
			String timeIdMapJSON = request.getParameter("timeIdMap");
			Map<Integer, String[]> timeMap = GsonHelper.fromJson(timeIdMapJSON, new TypeToken<Map<Integer, String[]>>()
			{
			}.getType());

			List<Schedule> scheduleList = TimeUtil.getInstance().getScheduleList(startDay, endDay);

			// 登录用户
			User user = (User) session.getAttribute("user");

			final Integer typeFinal = type;
			final String objectTypeFinal = objectType;
			final List<Schedule> scheduleListFinal = scheduleList;
			final String teacherMapJSONFinal = teacherMapJSON;
			final String gradeMapJSONFinal = gradeMapJSON;
			final Map<Integer, String[]> timeMapFinal = timeMap;
			final User userFinal = user;

			new Thread(new Runnable()
			{
				public void run()
				{
					User user = userFinal;
					DBContextHolder.setDBType(user.getSchoolId());

					try
					{
						saveScheduleObject(typeFinal, objectTypeFinal, scheduleListFinal, teacherMapJSONFinal, gradeMapJSONFinal, timeMapFinal);

					} catch (Exception e)
					{
						log.error("保存作息时间作用对象出错" + e.getMessage());
					}
				}
			}).start();

			Thread.currentThread().sleep(3000);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			Gson gson = new Gson();
			String json = gson.toJson(false);
			try
			{
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (IOException e1)
			{
				e1.printStackTrace();
			}
			e.printStackTrace();
		}

		return null;
	}

	public void saveScheduleObject(Integer type, String objectType, List<Schedule> scheduleList, String teacherMapJSON, String gradeMapJSON,
			Map<Integer, String[]> timeMap) throws Exception
	{

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if ("0".equals(objectType))// 教师
		{

			Map<String, Integer> teacherMap = GsonHelper.fromJson(teacherMapJSON, new TypeToken<HashMap<String, Integer>>()
			{
			}.getType());

			if (teacherMap != null)
			{
				// 将Map value 转化为List
				List<Integer> teacherIdList = new ArrayList<Integer>(teacherMap.values());
				if (teacherIdList.size() > 0)
				{
					for (int i = 0; i < teacherIdList.size(); i++)
					{
						for (Schedule schedule : scheduleList)
						{
							String liveDate = schedule.getLiveingDate().substring(0, 10);
							String week = TimeUtil.getInstance()._getWeekDay(sdf.parse(liveDate));// 根据日期获取对应的周几
							ScheduleTeacher scheduleTeacher = new ScheduleTeacher();
							scheduleTeacher.setStatus(schedule.getStatus());
							scheduleTeacher.setLiveingDate(liveDate);
							scheduleTeacher.setType(type);
							scheduleTeacher.setTeacherId(teacherIdList.get(i));
							Set<Integer> timeSet = timeMap.keySet();
							for (Iterator<Integer> timeIter = timeSet.iterator(); timeIter.hasNext();)
							{
								Integer timeId = (Integer) timeIter.next();
								String[] weekArr = (String[]) timeMap.get(timeId);
								if (StringUtil.arrayContainsString(weekArr, week))
								{
									ScheduleTime scheduleTime = scheduleService.getScheduleTimeById(timeId);
									if (scheduleTime.getType() == 0)
									{
										scheduleTeacher.setBeginTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setEndTime(liveDate + " " + scheduleTime.getEndTime());
									} else if (scheduleTime.getType() == 1)
									{
										scheduleTeacher.setAmStartTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setAmEndTime(liveDate + " " + scheduleTime.getEndTime());
									} else if (scheduleTime.getType() == 2)
									{
										scheduleTeacher.setPmStartTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setPmEndTime(liveDate + " " + scheduleTime.getEndTime());
									} else if (scheduleTime.getType() == 3)
									{
										scheduleTeacher.setNightStartTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setNightEndTime(liveDate + " " + scheduleTime.getEndTime());
									}
								}
							}
							scheduleService.saveScheduleTeacher(scheduleTeacher);// 添加教师作息时间
						}
					}

				}
			}

		} else
		{

			Map<String, Integer> gradeMap = GsonHelper.fromJson(gradeMapJSON, new TypeToken<HashMap<String, Integer>>()
			{
			}.getType());

			if (gradeMap != null)
			{
				// 将Map value 转化为List
				List<Integer> gradeIdList = new ArrayList<Integer>(gradeMap.values());
				// 通过年级idList获取对应的班级
				List<Clazz> clazzList = clazzService.getClazzListByGradeIdList(gradeIdList);

				for (Clazz clazz : clazzList)
				{
					for (Schedule schedule : scheduleList)
					{
						String liveDate = schedule.getLiveingDate().substring(0, 10);
						String week = TimeUtil.getInstance()._getWeekDay(sdf.parse(liveDate));// 根据日期获取对应的周几
						ScheduleClazz scheduleClazz = new ScheduleClazz();
						scheduleClazz.setClazzId(clazz.getId());
						scheduleClazz.setGradeId(clazz.getGradeId());
						scheduleClazz.setStatus(schedule.getStatus());
						scheduleClazz.setLiveingDate(liveDate);
						scheduleClazz.setType(type);
						Set<Integer> timeSet = timeMap.keySet();
						for (Iterator<Integer> timeIter = timeSet.iterator(); timeIter.hasNext();)
						{
							Integer timeId = (Integer) timeIter.next();
							String[] weekArr = (String[]) timeMap.get(timeId);
							if (StringUtil.arrayContainsString(weekArr, week))
							{
								ScheduleTime scheduleTime = scheduleService.getScheduleTimeById(timeId);
								if (scheduleTime.getType() == 0)
								{
									scheduleClazz.setBeginTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setEndTime(liveDate + " " + scheduleTime.getEndTime());
								} else if (scheduleTime.getType() == 1)
								{
									scheduleClazz.setAmStartTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setAmEndTime(liveDate + " " + scheduleTime.getEndTime());
								} else if (scheduleTime.getType() == 2)
								{
									scheduleClazz.setPmStartTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setPmEndTime(liveDate + " " + scheduleTime.getEndTime());
								} else if (scheduleTime.getType() == 3)
								{
									scheduleClazz.setNightStartTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setNightEndTime(liveDate + " " + scheduleTime.getEndTime());
								}
							}
						}
						scheduleService.saveScheduleClazz(scheduleClazz);// 添加班级作息时间
					}
				}
			}
		}
	}

	/**
	 * 进入修改作息时间表页面
	 */
	@RequestMapping(value = "/toModifySchedule.do")
	public String toModifySchedule(HttpServletRequest request, ModelMap modelMap)
	{
		/**
		 * 生效时间
		 */
		String liveingDate = request.getParameter("liveingDate");
		List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(liveingDate);
		Schedule schedule = new Schedule();
		if (list.size() > 0)
		{
			schedule = list.get(0);
		}
		/**
		 * 回写页面隐藏域
		 */
		modelMap.addAttribute("liveingDate", liveingDate);
		modelMap.addAttribute("schedule", schedule);

		return "schedule/new_schedule_modify";
	}

	/**
	 * 清空所有作息时间
	 */
	@RequestMapping(value = "/clearSchedule.do")
	public String clearSchedule(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			/**
			 * 清空作息时间处理如下表 注意事项，只清空当前时间往后的作息时间 1.palm_scheduledetail
			 * 2.palm_schedule_time 3.palm_schedule_time_relation
			 * 4.palm_schedule_clazz 5.palm_schedule_teacher
			 */

			boolean reslult = true;
			try
			{
				scheduleService.clearSchedule(TimeUtil.getInstance().date());
				reslult = true;
			} catch (Exception e)
			{
				reslult = false;
			}
			Gson gson = new Gson();
			String json = gson.toJson(reslult);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入作息时间详情页面(根据livingDate)
	 */
	@RequestMapping(value = "/toLoadScheduleDetail.do")
	public String toLoadScheduleDetail(HttpServletRequest request, ModelMap modelMap)
	{

		String liveingDate = request.getParameter("liveingDate");
		String objectType = request.getParameter("objectType");
		String departIdOrGradeId = request.getParameter("departIdOrGradeId");
		modelMap.addAttribute("liveingDate", liveingDate);
		modelMap.addAttribute("objectType", objectType);
		modelMap.addAttribute("departIdOrGradeId", departIdOrGradeId);
		return "schedule/news_schedule_detail";
	}

	/**
	 * 执行修改作息时间表逻辑
	 */
	@RequestMapping(value = "/doModifySchedule.do")
	public String doModifySchedule(HttpServletRequest request, ModelMap modelMap)
	{
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * schedule主键
		 */
		Integer scheduleId = Integer.valueOf(request.getParameter("scheduleId"));
		/**
		 * 生效时间
		 */
		String liveingDate = request.getParameter("liveingDate");

		/**
		 * 状态
		 */
		String status = request.getParameter("status");

		/**
		 * 放入入参
		 */
		paramMap.put("scheduleId", scheduleId);
		paramMap.put("status", status);
		paramMap.put("liveingDate", liveingDate);

		scheduleService.modifySchedule(paramMap);
		scheduleService.modifyScheduleClazz(paramMap);
		scheduleService.modifyScheduleTeacher(paramMap);

		return toScheduleList();
	}

	/**
	 * 加载作息时间详情
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/loadScheduleByLiveingDate.do")
	public String loadScheduleByLiveingDate(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		String liveingDate = request.getParameter("liveingDate");
		String objectType = request.getParameter("objectType");
		if ("0".equals(objectType))
		{
			// 教师
			String departmentId = request.getParameter("departmentId");
			if ("all".equals(departmentId))
			{
				departmentId = null;
			}
			// 查询部门下人员对应的考勤
			List<ScheduleTeacher> scheduleTeacherlist = scheduleService.getScheduleListByLiveingAndDepartmentId(liveingDate, departmentId);
			Gson gson = new Gson();
			try
			{
				String json = gson.toJson(scheduleTeacherlist);
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (Exception e)
			{

			}
		} else
		{
			// 学生
			String gradeId = request.getParameter("gradeId");
			String clazzId = request.getParameter("clazzId");
			if ("all".equals(gradeId))
			{
				gradeId = null;
			}
			if ("all".equals(clazzId))
			{
				clazzId = null;
			}
			// 查询年级下所有班级对应的考勤或者单个班级对应的考勤
			List<ScheduleClazz> scheduleClazzlist = scheduleService.getScheduleListByLiveingAndGradeIdOrClazzId(liveingDate, gradeId, clazzId);
			Gson gson = new Gson();
			try
			{
				String json = gson.toJson(scheduleClazzlist);
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (Exception e)
			{

			}
		}
		return null;
	}

	/**
	 * 进入作息时间修改页面(根据livingDate)
	 * 
	 * @throws IOException
	 * @throws ServletException
	 * @throws JSONException
	 */
	@RequestMapping(value = "/toScheduleModifyPage.do")
	public String toScheduleModifyPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws ServletException, IOException
	{

		String liveingDate = request.getParameter("liveingDate");
		Integer objectType = Integer.valueOf(request.getParameter("objectType"));
		String departIdOrGradeId = request.getParameter("departIdOrGradeId");
		String mapJSON = request.getParameter("map");

		try
		{
			Map<Integer, List<Map<Integer, String>>> map = GsonHelper.fromJson(mapJSON, new TypeToken<HashMap<Integer, List<HashMap<Integer, String>>>>()
			{
			}.getType());
			List<User> teacherList = new ArrayList<User>();
			List<Clazz> clazzList = new ArrayList<Clazz>();
			// 获取组织机构ID
			Set<Integer> idSet = map.keySet();
			for (Integer id : idSet)
			{
				List<Map<Integer, String>> list = map.get(id);
				for (int i = 0; i < list.size(); i++)
				{
					Map<Integer, String> map2 = list.get(i);
					if (!map2.isEmpty())
					{
						Set<Integer> id2Set = map2.keySet();
						for (Integer id2 : id2Set)
						{
							if (0 == objectType)
							{
								// 教职工
								User user = new User();
								user.setUserId(id2);
								user.setRealName(map2.get(id2));
								user.setDepartmentId(id);
								teacherList.add(user);
							} else
							{
								// 班级
								Clazz clazz = new Clazz();
								clazz.setClazzId(id2);
								clazz.setClazzName(map2.get(id2));
								clazz.setGradeId(id);
								clazzList.add(clazz);
							}
						}
					}
				}
			}

			modelMap.addAttribute("liveingDate", liveingDate);
			modelMap.addAttribute("objectType", objectType);
			modelMap.addAttribute("teacherList", teacherList);
			modelMap.addAttribute("clazzList", clazzList);
			modelMap.addAttribute("departIdOrGradeId",departIdOrGradeId);
		} catch (JSONException je)
		{
			log.error("toScheduleModifyPage ： " + je.getMessage());
		}
		return "schedule/news_schedule_person_update";
	}

	/**
	 * 执行修改作息时间作用对象
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/doScheduleObjectModify.do")
	public String doScheduleObjectModify(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			// 操作对象 0教师 1学生
			String objectType = request.getParameter("objectType");
			// 开始日期
			String startDay = request.getParameter("startDay");
			// 结束日期
			String endDay = request.getParameter("endDay");
			// 教师集合
			String teacherList = request.getParameter("teacherList");
			// 班级集合
			String clazzList = request.getParameter("clazzList");
			//部门Id或者年级ID
			String departIdOrGradeId = request.getParameter("departIdOrGradeId");
			
			// 时间集合
			String timeIdMapJSON = request.getParameter("timeIdMap");

			Map<Integer, String[]> timeMap = GsonHelper.fromJson(timeIdMapJSON, new TypeToken<Map<Integer, String[]>>()
			{
			}.getType());

			List<Schedule> scheduleList = TimeUtil.getInstance().getScheduleList(startDay, endDay);

			// 登录用户
			User user = (User) session.getAttribute("user");

			final String objectTypeFinal = objectType;
			final List<Schedule> scheduleListFinal = scheduleList;
			final String teacherListFinal = teacherList;
			final String clazzListFinal = clazzList;
			final Map<Integer, String[]> timeMapFinal = timeMap;
			final User userFinal = user;

			new Thread(new Runnable()
			{
				public void run()
				{
					User user = userFinal;
					DBContextHolder.setDBType(user.getSchoolId());

					try
					{
						modifyScheduleObject(objectTypeFinal, scheduleListFinal, teacherListFinal, clazzListFinal, timeMapFinal);

					} catch (Exception e)
					{
						log.error("保存作息时间作用对象出错" + e.getMessage());
					}
				}
			}).start();

			Thread.currentThread().sleep(3000);

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return toLoadScheduleDetail(request, modelMap);
	}

	public void modifyScheduleObject(String objectType, List<Schedule> scheduleList, String teaList, String claList, Map<Integer, String[]> timeMap)
			throws Exception
	{

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if ("0".equals(objectType))// 教师
		{

			Map<String, Integer> teacherMap = GsonHelper.fromJson(teaList, new TypeToken<HashMap<String, Integer>>()
			{
			}.getType());

			if (teacherMap != null)
			{
				// 将Map value 转化为List
				List<Integer> teacherIdList = new ArrayList<Integer>(teacherMap.values());
				if (teacherIdList.size() > 0)
				{
					for (int i = 0; i < teacherIdList.size(); i++)
					{
						for (Schedule schedule : scheduleList)
						{
							String liveDate = schedule.getLiveingDate().substring(0, 10);
							String week = TimeUtil.getInstance()._getWeekDay(sdf.parse(liveDate));// 根据日期获取对应的周几
							ScheduleTeacher scheduleTeacher = new ScheduleTeacher();
							scheduleTeacher.setStatus(schedule.getStatus());
							scheduleTeacher.setLiveingDate(liveDate);
							scheduleTeacher.setTeacherId(teacherIdList.get(i));
							Set<Integer> timeSet = timeMap.keySet();
							for (Iterator<Integer> timeIter = timeSet.iterator(); timeIter.hasNext();)
							{
								Integer timeId = (Integer) timeIter.next();
								String[] weekArr = (String[]) timeMap.get(timeId);
								if (StringUtil.arrayContainsString(weekArr, week))
								{
									ScheduleTime scheduleTime = scheduleService.getScheduleTimeById(timeId);
									if (scheduleTime.getType() == 0)
									{
										scheduleTeacher.setType(1);
										scheduleTeacher.setBeginTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setEndTime(liveDate + " " + scheduleTime.getEndTime());
									} else if (scheduleTime.getType() == 1)
									{
										scheduleTeacher.setType(0);
										scheduleTeacher.setAmStartTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setAmEndTime(liveDate + " " + scheduleTime.getEndTime());
									} else if (scheduleTime.getType() == 2)
									{
										scheduleTeacher.setType(0);
										scheduleTeacher.setPmStartTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setPmEndTime(liveDate + " " + scheduleTime.getEndTime());
									} else if (scheduleTime.getType() == 3)
									{
										scheduleTeacher.setType(0);
										scheduleTeacher.setNightStartTime(liveDate + " " + scheduleTime.getBeginTime());
										scheduleTeacher.setNightEndTime(liveDate + " " + scheduleTime.getEndTime());
									}
								}
							}

							ScheduleTeacher scheduleTea = scheduleService.getScheduleTeacherByUserIdAndLiveingDate(liveDate, teacherIdList.get(i));
							if (scheduleTea == null)
							{
								scheduleService.saveScheduleTeacher(scheduleTeacher);// 添加教师作息时间
							} else
							{
								scheduleService.modifyScheduleTeacher(scheduleTeacher);// 修改教师作息时间
							}
						}
					}

				}
			}

		} else
		{

			List<Clazz> clazzList = GsonHelper.fromJson(claList, new TypeToken<List<Clazz>>()
			{
			}.getType());

			if (clazzList != null)
			{
				for (Clazz clazz : clazzList)
				{
					for (Schedule schedule : scheduleList)
					{
						String liveDate = schedule.getLiveingDate().substring(0, 10);
						String week = TimeUtil.getInstance()._getWeekDay(sdf.parse(liveDate));// 根据日期获取对应的周几
						ScheduleClazz scheduleClazz = new ScheduleClazz();
						scheduleClazz.setClazzId(clazz.getClazzId());
						scheduleClazz.setGradeId(clazz.getGradeId());
						scheduleClazz.setStatus(schedule.getStatus());
						scheduleClazz.setLiveingDate(liveDate);
						Set<Integer> timeSet = timeMap.keySet();
						for (Iterator<Integer> timeIter = timeSet.iterator(); timeIter.hasNext();)
						{
							Integer timeId = (Integer) timeIter.next();
							String[] weekArr = (String[]) timeMap.get(timeId);
							if (StringUtil.arrayContainsString(weekArr, week))
							{
								ScheduleTime scheduleTime = scheduleService.getScheduleTimeById(timeId);
								if (scheduleTime.getType() == 0)
								{
									scheduleClazz.setType(1);
									scheduleClazz.setBeginTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setEndTime(liveDate + " " + scheduleTime.getEndTime());
								} else if (scheduleTime.getType() == 1)
								{
									scheduleClazz.setType(0);
									scheduleClazz.setAmStartTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setAmEndTime(liveDate + " " + scheduleTime.getEndTime());
								} else if (scheduleTime.getType() == 2)
								{
									scheduleClazz.setType(0);
									scheduleClazz.setPmStartTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setPmEndTime(liveDate + " " + scheduleTime.getEndTime());
								} else if (scheduleTime.getType() == 3)
								{
									scheduleClazz.setType(0);
									scheduleClazz.setNightStartTime(liveDate + " " + scheduleTime.getBeginTime());
									scheduleClazz.setNightEndTime(liveDate + " " + scheduleTime.getEndTime());
								}
							}
						}

						ScheduleClazz scheduleCla = scheduleService.getScheduleClazzByClazzIdAndLiveingDate(liveDate, clazz.getClazzId());

						if (scheduleCla == null)
						{
							scheduleService.saveScheduleClazz(scheduleClazz);// 添加班级作息时间
						} else
						{
							scheduleService.modifyScheduleClazz(scheduleClazz);// 修改班级作息时间
						}
					}
				}
			}
		}
	}
	
	/**
	 * 进入作息时间新增页面 20151129
	 */
	@RequestMapping(value = "/toSuccessPage.do")
	public String toSuccessPage(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		User user = (User) session.getAttribute("user");
		modelMap.addAttribute("user", user);

		return "schedule/news_schedule_person_success";
	}
}
