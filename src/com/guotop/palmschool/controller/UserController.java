package com.guotop.palmschool.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.guotop.palmschool.apply.service.ApplyService;
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.curriculum.entity.Curriculum;
import com.guotop.palmschool.curriculum.entity.CurriculumSemester;
import com.guotop.palmschool.curriculum.entity.CurriculumTime;
import com.guotop.palmschool.curriculum.entity.Week;
import com.guotop.palmschool.curriculum.service.CurriculumService;
import com.guotop.palmschool.entity.Announcement;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Groupmember;
import com.guotop.palmschool.entity.Groups;
import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.entity.News;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.SchoolInfo;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.rest.entity.UserAuthorization;
import com.guotop.palmschool.service.AnnouncementService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.GroupmemberService;
import com.guotop.palmschool.service.GroupsService;
import com.guotop.palmschool.service.MenuService;
import com.guotop.palmschool.service.OrderMessagePermissionService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.PermissionService;
import com.guotop.palmschool.service.RoleService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.SmsService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.system.service.PersionnerService;
import com.guotop.palmschool.todayActivity.service.TodayActivityService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 用户操作类
 * 
 * 
 */
@RequestMapping("/user")
@Controller
public class UserController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(UserController.class);

	@Resource
	private UserService userService;
	@Resource
	private PermissionService permissionService;
	@Resource
	private RoleService roleService;
	@Resource
	private DepartmentService departmentService;
	@Resource
	private MenuService menuService;
	@Resource
	private ApplyService applyService;
	@Resource
	private SchoolService schoolService;
	@Resource
	private PersionnerService persionnerService;
	@Resource
	private AnnouncementService announcementService;
	@Resource
	private CommonService commonService;

	@Resource
	private CurriculumService curriculumService;

	@Resource
	private ScheduleService scheduleService;

	@Resource
	private TodayActivityService todayActivityService;

	@Resource
	private OrderMessageService orderMessageService;
	
	@Resource
	private GroupsService groupsService;
	
	@Resource
	private GroupmemberService groupmemberService;
	
	@Resource
	private SmsService smsService;

	@Resource
	private ClazzService clazzService;
	
	@Resource
	private OrderMessagePermissionService orderMessagePermissionService;
	
	private Logger log = LoggerFactory.getLogger(UserController.class);

	/**
	 * 执行登陆
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "/doLogin.do")
	public String doLogin(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		// 超级管理员，进入页面
		if ("sysadmin".equals(loginUser.getUsername()))
		{
			int count = applyService.getApplySchoolNum();
			modelMap.addAttribute("count", count);
			if(count > 0)
			{
				return "system/administrator_welcome";
			}else{
				return schoolManager(request,session,modelMap);
			}
		} else
		{
			if (loginUser.getType() == 2)// 代理商
			{
				String condition = request.getParameter("condition");
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("condition", condition);
				conditionMap.put("userId", loginUser.getUserId());
				//
				List<SchoolInfo> list = schoolService.getSchoolListByAgencyUserId(conditionMap);
				HashMap<Integer, List<SchoolInfo>> map = new HashMap<Integer, List<SchoolInfo>>();
				List<SchoolInfo> tempList = new ArrayList<SchoolInfo>();
				int j = 0;
				map.put(j, tempList);
				for (int i = 0; i < list.size(); i++)
				{
					if (i / 6 == j)
					{
						tempList.add(list.get(i));
					} else
					{
						j = i / 6;
						tempList = new ArrayList<SchoolInfo>();
						tempList.add(list.get(i));
						map.put(j, tempList);
					}
				}
				modelMap.addAttribute("schoolInfoMap", map);
				modelMap.addAttribute("condition", condition);
				return "system/school_Management";
			} else if (loginUser.getType() == 3)// 技术支持
			{
				String condition = request.getParameter("condition");
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("condition", condition);
				conditionMap.put("userId", loginUser.getUserId());
				//
				List<SchoolInfo> list = schoolService.getSchoolListBySupportUserId(conditionMap);
				HashMap<Integer, List<SchoolInfo>> map = new HashMap<Integer, List<SchoolInfo>>();
				List<SchoolInfo> tempList = new ArrayList<SchoolInfo>();
				int j = 0;
				map.put(j, tempList);
				for (int i = 0; i < list.size(); i++)
				{
					if (i / 6 == j)
					{
						tempList.add(list.get(i));
					} else
					{
						j = i / 6;
						tempList = new ArrayList<SchoolInfo>();
						tempList.add(list.get(i));
						map.put(j, tempList);
					}
				}
				modelMap.addAttribute("schoolInfoMap", map);
				modelMap.addAttribute("condition", condition);
				return "system/school_Management";
			} else if (loginUser.getType() == 4)// 财务人员
			{
				return "finance/financial_statements";
			} else
			{
				List<School> list = schoolService.getSchoolListByUserId(loginUser.getUserId());
				if (list != null && list.size() > 0)
				{
					loginUser.setSchoolId(String.valueOf(list.get(0).getSchoolId()));
					modelMap.put("schooId", loginUser.getSchoolId());
					return enterHomePage(request, session, modelMap);
				} else
				{
					return "../login";
				}

			}
		}
	}

	/**
	 * 进入学校首页
	 * 
	 * @param session
	 * @param modelMap
	 * @param loginUser
	 * @return
	 */
	@RequestMapping(value = "/toHomePage.do")
	public String enterHomePage(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		String schoolId = request.getParameter("schoolId");
		if (StringUtil.isEmpty(schoolId))
		{
			schoolId = loginUser.getSchoolId();
			if (StringUtil.isEmpty(schoolId))
			{
				schoolId = (String) modelMap.get("schoolId");
			}
		}
		if (!StringUtil.isEmpty(schoolId))
		{
			loginUser.setSchoolId(schoolId);
		}
		DBContextHolder.setDBType(loginUser.getSchoolId());

		if (userService.isManagerBySchoolIdAndUserId(Long.valueOf(loginUser.getSchoolId()), loginUser.getUserId()))// 学校管理员
		{
			List<Role> roleList = new ArrayList<Role>();
			List<Permission> permissionList = new ArrayList<Permission>();
			Role role = new Role();
			role.setRoleCode("admin");
			role.setRoleName("管理员");
			roleList.add(role);
			loginUser.setRoleList(roleList);

			Permission permission = new Permission();
			permission.setPermissionCode("admin");
			permission.setPermissionName("管理员");
			permissionList.add(permission);
			loginUser.setPermissionList(permissionList);
		} else
		{
			List<Role> roleList = roleService.getRoleList(loginUser.getUserId());
			List<Permission> permissionList = permissionService.getPermissionList(loginUser.getUserId());
			String clazzId = userService.getClazzIdByUserId(loginUser.getUserId());
			List<Department> departList = departmentService.getDepartListByUserId(loginUser.getUserId());
			loginUser.setRoleList(roleList);
			loginUser.setPermissionList(permissionList);
			loginUser.setDepartmentList(departList);
			if (null != clazzId)
			{
				loginUser.setClazzId(Integer.valueOf(clazzId));
			}
		}
		session.setAttribute("user", loginUser);
		School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(loginUser.getSchoolId()));
		Announcement announcement = announcementService.getSchoolAnnouncement();
		List<News> newsList = schoolService.getNewsList();
		school.setNewList(newsList);
		modelMap.addAttribute("name", loginUser.getRealName());
		modelMap.addAttribute("school", school);
		modelMap.addAttribute("announcement", announcement);
		// 加载课程表
		List<Role> roleList = loginUser.getRoleList();
		String roleCode = roleList.get(0).getRoleCode();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", loginUser);
		paramMap.put("userId", loginUser.getUserId());
		paramMap.put("permissionCode", "curriculumManager");
		paramMap.put("roleCode", roleCode);
		List<Clazz> clazzList = commonService.getClazzListByRoleCode(paramMap);
		Integer clazzId = 0;
		if (clazzList.size() > 0)
		{
			clazzId = clazzList.get(0).getId();
		}

		List<Week> weekList = curriculumService.getWeekList();

		CurriculumSemester semester = new CurriculumSemester();
		if (("0").equals(school.getSchoolCategory()))
		{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("date", TimeUtil.date());
			map.put("clazzId", clazzId);
			semester = todayActivityService.getTodayActivityByDate(map);
		} else
		{
			semester = curriculumService.getCurriculumServiceByDate(TimeUtil.date(), null, null);
		}

		String curriculumIsNull = "yes";
		if (semester != null)
		{
			// 上午
			List<CurriculumTime> curriculumMorningTimeList = curriculumService.getCurriculumTimeMorningBySemesterId(semester.getId());
			modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);

			if (curriculumMorningTimeList.size() > 0)
			{
				curriculumIsNull = "no";
				for (CurriculumTime curriculumTime : curriculumMorningTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			// 下午
			List<CurriculumTime> curriculumAfternoonTimeList = curriculumService.getCurriculumTimeAfternoonBySemesterId(semester.getId());
			modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);

			if (curriculumAfternoonTimeList.size() > 0)
			{
				curriculumIsNull = "no";
				for (CurriculumTime curriculumTime : curriculumAfternoonTimeList)
				{

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			// 晚上
			List<CurriculumTime> curriculumNightTimeList = curriculumService.getCurriculumTimeNightBySemesterId(semester.getId());
			modelMap.addAttribute("curriculumNightTimeList", curriculumNightTimeList);

			if (curriculumNightTimeList.size() > 0)
			{
				for (CurriculumTime curriculumTime : curriculumNightTimeList)
				{
					curriculumIsNull = "no";

					List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, loginUser, clazzId);

					if (curriculumList != null && curriculumList.size() > 0)
					{
						curriculumTime.setCurriculumList(curriculumList);
					}
				}
			}

			modelMap.addAttribute("startDay", semester.getBeginDate());
			modelMap.addAttribute("endDay", semester.getEndDate());
			modelMap.addAttribute("semesterId", semester.getId());
			modelMap.addAttribute("clazzId", clazzId);
		}

		modelMap.addAttribute("weekList", weekList);
		modelMap.addAttribute("curriculumIsNull", curriculumIsNull);

		// 如果有作息时间设置权限 作息时间截至的前一天 就弹框提醒
		List<Permission> permissionList = loginUser.getPermissionList();
		Integer timeRemind = 0;
		for (Permission permission : permissionList)
		{
			if (permission.getPermissionCode().equals("restTimeManager") || "admin".equals(permission.getPermissionCode()))
			{
				List<Schedule> list = scheduleService.selectScheduleListTime(TimeUtil.date());
				if (list.size() < 2)
				{
					String content = "";

					int pushType = PUSHTYPE.SETSCHEDULETIME.getType();
					int pushContentType = 0;
					String title = "作息时间设置";
					Schedule schedule = scheduleService.selectSchedule();
					if (schedule == null)
					{
						modelMap.addAttribute("timeIsNull", 1);
						content = "您学校的作息时间尚未设置，请前往作息时间页面进行设置!";
					} else
					{
						modelMap.addAttribute("timeIsNull", 2);
						modelMap.addAttribute("scheduleTime", schedule.getLiveingDate());
						content = "您设置的作息时间截至日期为" + schedule.getLiveingDate() + ",请前往作息时间页面进行设置!";
					}
					timeRemind = 1;
					List<PushItem> piList = new ArrayList<PushItem>();
					PushItem pi = new PushItem();
					pi.receiverId = loginUser.getUserId();
					pi.channels = loginUser.getBaiduChannelId();
					pi.deviceType = String.valueOf(loginUser.getDeviceType());
					pi.PushContent = content;
					pi.PushType = pushType;
					pi.PushContentType = pushContentType;
					pi.title = title;
					pi.schoolId = loginUser.getSchoolId();
					piList.add(pi);
					commonService.pushMsg(piList, true);// 消息推送
				}
			}
		}

		modelMap.addAttribute("timeRemind", timeRemind);

		/**
		 * 进入首页
		 */
		return "home/homepage";
	}

	/**
	 * 手机端进入学校首页
	 * 
	 * @param session
	 * @param modelMap
	 * @param loginUser
	 * @return
	 */
	@RequestMapping(value = "/toHomePage4App.do")
	public String enterHomePage4App(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (user != null)
		{
			session.setAttribute("user", user);
			School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(user.getSchoolId()));
			Announcement announcement = announcementService.getSchoolAnnouncement();
			List<News> newsList = schoolService.getNewsList();
			school.setNewList(newsList);
			modelMap.addAttribute("name", user.getRealName());
			modelMap.addAttribute("school", school);
			modelMap.addAttribute("announcement", announcement);

			// 加载课程表
			List<Role> roleList = user.getRoleList();

			String roleCode = roleList.get(0).getRoleCode();

			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("user", user);
			paramMap.put("userId", user.getUserId());

			paramMap.put("permissionCode", "curriculumManager");
			paramMap.put("roleCode", roleCode);

			List<Clazz> clazzList = commonService.getClazzListByRoleCode(paramMap);
			Integer clazzId = 0;
			if (clazzList.size() > 0)
			{
				clazzId = clazzList.get(0).getId();
			}

			List<Week> weekList = curriculumService.getWeekList();

			CurriculumSemester semester = new CurriculumSemester();
			if (("0").equals(school.getSchoolCategory()))
			{
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("date", TimeUtil.getInstance().date());
				map.put("clazzId", clazzId);
				semester = todayActivityService.getTodayActivityByDate(map);
			} else
			{
				semester = curriculumService.getCurriculumServiceByDate(TimeUtil.getInstance().date(), null, null);
			}

			String curriculumIsNull = "yes";
			if (semester != null)
			{
				// 上午
				List<CurriculumTime> curriculumMorningTimeList = curriculumService.getCurriculumTimeMorningBySemesterId(semester.getId());
				modelMap.addAttribute("curriculumMorningTimeList", curriculumMorningTimeList);

				if (curriculumMorningTimeList.size() > 0)
				{
					curriculumIsNull = "no";
					for (CurriculumTime curriculumTime : curriculumMorningTimeList)
					{

						List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, user, clazzId);

						if (curriculumList.size() > 0)
						{
							curriculumTime.setCurriculumList(curriculumList);
						}
					}
				}

				// 下午
				List<CurriculumTime> curriculumAfternoonTimeList = curriculumService.getCurriculumTimeAfternoonBySemesterId(semester.getId());
				modelMap.addAttribute("curriculumAfternoonTimeList", curriculumAfternoonTimeList);

				if (curriculumAfternoonTimeList.size() > 0)
				{
					curriculumIsNull = "no";
					for (CurriculumTime curriculumTime : curriculumAfternoonTimeList)
					{

						List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, user, clazzId);

						if (curriculumList.size() > 0)
						{
							curriculumTime.setCurriculumList(curriculumList);
						}
					}
				}

				// 晚上
				List<CurriculumTime> curriculumNightTimeList = curriculumService.getCurriculumTimeNightBySemesterId(semester.getId());
				modelMap.addAttribute("curriculumNightTimeList", curriculumNightTimeList);

				if (curriculumNightTimeList.size() > 0)
				{
					for (CurriculumTime curriculumTime : curriculumNightTimeList)
					{
						curriculumIsNull = "no";

						List<Curriculum> curriculumList = curriculumService.getCurriculumByTimeId(curriculumTime.getId(), roleCode, user, clazzId);

						if (curriculumList.size() > 0)
						{
							curriculumTime.setCurriculumList(curriculumList);
						}
					}
				}

				modelMap.addAttribute("startDay", semester.getBeginDate());
				modelMap.addAttribute("endDay", semester.getEndDate());
				modelMap.addAttribute("semesterId", semester.getId());
				modelMap.addAttribute("clazzId", clazzId);
			}

			modelMap.addAttribute("weekList", weekList);
			modelMap.addAttribute("curriculumIsNull", curriculumIsNull);

			// 如果有作息时间设置权限 作息时间截至的前一天 就弹框提醒
			List<Permission> permissionList = user.getPermissionList();
			Integer timeRemind = 0;
			for (Permission permission : permissionList)
			{
				if (permission.getPermissionCode().equals("restTimeManager") || "admin".equals(permission.getPermissionCode()))
				{
					List<Schedule> list = scheduleService.selectScheduleListTime(TimeUtil.getInstance().date());
					if (list.size() < 2)
					{
						String content = "";

						int pushType = PUSHTYPE.SETSCHEDULETIME.getType();
						int pushContentType = 0;
						String title = "作息时间设置";
						Schedule schedule = scheduleService.selectSchedule();
						if (schedule == null)
						{
							modelMap.addAttribute("timeIsNull", 1);
							content = "您学校的作息时间尚未设置，请前往作息时间页面进行设置!";
						} else
						{
							modelMap.addAttribute("timeIsNull", 2);
							modelMap.addAttribute("scheduleTime", schedule.getLiveingDate());
							content = "您设置的作息时间截至日期为" + schedule.getLiveingDate() + ",请前往作息时间页面进行设置!";
						}
						timeRemind = 1;
						List<PushItem> piList = new ArrayList<PushItem>();
						PushItem pi = new PushItem();
						pi.receiverId = user.getUserId();
						pi.channels = user.getBaiduChannelId();
						pi.deviceType = String.valueOf(user.getDeviceType());
						pi.PushContent = content;
						pi.PushType = pushType;
						pi.PushContentType = pushContentType;
						pi.title = title;
						pi.schoolId = schoolId;
						piList.add(pi);
						commonService.pushMsg(piList, false);// 消息推送
					}
				}
			}

			modelMap.addAttribute("timeRemind", timeRemind);

			/**
			 * 进入首页
			 */
			return "app/home/homepage";
		}
		return null;
	}

	/**
	 * 进入主页
	 * 
	 * @param request
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/enterMain.do")
	public String enterMain(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		if (loginUser.getType() == 2 || loginUser.getType() == 3)
		{
			List<Role> roleList = new ArrayList<Role>();
			Role role = new Role();
			role.setRoleCode("admin");
			role.setRoleName("管理员");
			roleList.add(role);
			loginUser.setRoleList(roleList);
			List<Permission> permissionList = new ArrayList<Permission>();
			Permission permission = new Permission();
			permission.setPermissionCode("admin");
			permission.setPermissionName("管理员");
			permissionList.add(permission);
			loginUser.setPermissionList(permissionList);
		}
		String id = request.getParameter("id");
		if (!StringUtil.isEmpty(id))
		{
			modelMap.addAttribute("menuId", id);
		}

		List<Menu> menuList = new ArrayList<Menu>();
		if (!StringUtil.isEmpty(loginUser.getSchoolId()))
		{
			DBContextHolder.setDBType(loginUser.getSchoolId());
			if (loginUser.getUserId() == 1)
			{
				menuList = menuService.getAllMenuInfoSysadmin(loginUser.getSchoolId(), null);
			} else
			{
				menuList = menuService.getAllMenuInfo(loginUser.getSchoolId(), 0);
			}
		} else
		{
			logger.error("menuList1_菜单错误信息登录人：" + loginUser.getUserId() + "," + loginUser.getRealName());
		}
		List<School> schoolList = schoolService.getSchoolListByUserId(loginUser.getUserId());

		session.setAttribute("menuList", menuList);
		session.setAttribute("schoolList", schoolList);
		modelMap.addAttribute("schoolList", schoolList);
		return "home/main";
	}

	/**
	 * 手机端进入主页
	 * 
	 * @param request
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/enterMain4App.do")
	public String enterMain4App(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (user != null)
		{
			session.setAttribute("user", user);
			String id = request.getParameter("id");
			if (!StringUtil.isEmpty(id))
			{
				modelMap.addAttribute("menuId", id);
			}
			List<Menu> menuList = new ArrayList<Menu>();
			DBContextHolder.setDBType(schoolId);
			if (user.getUserId() == 1)
			{
				menuList = menuService.getAllMenuInfoSysadmin(user.getSchoolId(), null);
			} else
			{
				menuList = menuService.getAllMenuInfo(user.getSchoolId(), 0);
			}
			List<School> schoolList = schoolService.getSchoolListByUserId(user.getUserId());
			session.setAttribute("menuList", menuList);
			modelMap.addAttribute("menuList", menuList);
			modelMap.addAttribute("schoolList", schoolList);

			return "home/main_frame";
		}
		return null;
	}

	/**
	 * 进入学校管理页面
	 * 
	 * @param request
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/schoolManager.do")
	public String schoolManager(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		if(loginUser == null )
		{
			return "redirect:/login.jsp";
		}
		// 超级管理员，进入页面
		if ("sysadmin".equals(loginUser.getUsername()) || loginUser.getType() == 2 || loginUser.getType() == 3)
		{
			return "system/school_Management";
		}

		return "redirect:/login.jsp";

	}

	/**
	 * 加载学校列表
	 * 
	 * @param request
	 * @param session
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getSchoolList.do")
	public String loadSchoolList(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		User loginUser = (User) session.getAttribute("user");
		String condition = request.getParameter("condition");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String country = request.getParameter("country");

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
		if (province != null && !"".equals(province))
		{
			province = province.substring(0, 2);
		}
		if (city != null && !"".equals(city) && city.endsWith("00"))
		{
			city = city.substring(0, 4);
		}
		this.getPages().setPageSize(12);
		Pages page = null;
		// 超级管理员，进入页面
		if ("sysadmin".equals(loginUser.getUsername()))
		{
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("condition", condition);
			paramMap.put("province", province);
			paramMap.put("city", city);
			paramMap.put("country", country);
			//
			page = schoolService.getAllSchoolInfo(this.getPages().getPageSize(), currentPage, paramMap);
		}
		if (loginUser.getType() == 2)// 代理商
		{
			HashMap<String, Object> conditionMap = new HashMap<String, Object>();
			conditionMap.put("condition", condition);
			conditionMap.put("userId", loginUser.getUserId());
			conditionMap.put("province", province);
			conditionMap.put("city", city);
			conditionMap.put("country", country);
			//
			page = schoolService.getSchoolListByAgencyUserId4Manage(this.getPages().getPageSize(), currentPage, conditionMap);

		} else if (loginUser.getType() == 3)// 技术支持
		{
			HashMap<String, Object> conditionMap = new HashMap<String, Object>();
			conditionMap.put("condition", condition);
			conditionMap.put("userId", loginUser.getUserId());
			conditionMap.put("province", province);
			conditionMap.put("city", city);
			conditionMap.put("country", country);
			//
			page = schoolService.getSchoolListBySupportUserId4Manage(this.getPages().getPageSize(), currentPage, conditionMap);

		}
		try
		{
			response.getWriter().write(GsonHelper.toJson(page));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 加载学校详情
	 * 
	 * @param request
	 * @param session
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getSchoolDetailBySchoolId.do")
	public String getSchoolDetailBySchoolId(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String schoolId = request.getParameter("schoolId");
		try
		{

			DBContextHolder.setDBType(schoolId);
			Map<String, Object> map = new HashMap<String, Object>();
			SchoolInfo schoolDetail = schoolService.getSchoolDetailBySchoolId(schoolId);
			int userCount = schoolDetail.getUserCount();
			int teacherCount = schoolDetail.getTeacherCount();
			int studentCount = schoolDetail.getStudentCount();
			schoolDetail.setParentCount(userCount - teacherCount - studentCount);
			map.put("schoolDetail", schoolDetail);
			Integer count = orderMessageService.getPalmOrderMessageCount();
			map.put("count", count);
			if (count > 0)
			{// 获取当前有效套餐购买人数
				Integer yesCount = orderMessageService.getOrderMessgeYesOrNo();
				map.put("yesCount", yesCount);
			}
			response.getWriter().write(GsonHelper.toJson(map));
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("加载学校详情出错-getSchoolDetailBySchoolId.do:" + e.getMessage());
		}
		return null;

	}

	/**
	 * 超管等进入学校
	 * 
	 * @param request
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/enterSchool.do")
	public String enterSchool(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		User loginUser = (User) session.getAttribute("user");
		String schoolId = request.getParameter("schoolId");
		loginUser.setSchoolId(schoolId);
		session.setAttribute("user", loginUser);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("status", 0);

		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}
		return null;
	}

	/**
	 * 通过互信id直接进入主页面
	 */
	@RequestMapping(value = "/toMainByHuxinId.do")
	public String toMainByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setHeader("Content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			/*
			 * 存session
			 */
			session.setAttribute("user", loginUser);

			List<Menu> menuList = new ArrayList<Menu>();
			DBContextHolder.setDBType(loginUser.getSchoolId());
			if (loginUser.getUserId() == 1)
			{
				menuList = menuService.getAllMenuInfoSysadmin(loginUser.getSchoolId(), null);
			} else
			{
				menuList = menuService.getAllMenuInfo(loginUser.getSchoolId(), 0);
			}
			session.setAttribute("menuList", menuList);
			modelMap.addAttribute("menuList", menuList);
			return "home/main";
		}
		return null;

	}
	/**
	 * E学习pad端进入智慧校园登陆页面
	 * @author chenyong
	 * @Time 2017年4月19日 下午2:13:05
	 */
	@RequestMapping("/toPadLogin.do")
	public String padWisdomLogin(Integer userId,Model model){
		model.addAttribute("userId", userId);
		return "pad/padWisdomLogin";
		
	}
	/**
	 * E学习pad端进入成绩云登陆页面
	 * @author chenyong
	 * @Time 2017年4月19日 下午2:13:05
	 */
	@RequestMapping("/toPadScoreLogin.do")
	public String toPadScoreLogin(Integer userId,Model model){
		User user=userService.getUserbaseByUserId(userId);
		List<User> listUser=userService.getUserSchoolByUserId(userId);
		if(user!=null){
			model.addAttribute("uuid", user.getUuserId());
		}else{
			model.addAttribute("uuid", "");	
		}
		
		if(listUser!=null && listUser.size()>0){
			model.addAttribute("schoolId", listUser.get(0).getSchoolId());	
		}else{
			model.addAttribute("schoolId", "");	
		}
		return "pad/padScoreLogin";
		
	}
	/**
	 * 执行验证
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "/doCheckUsernamePassword.do")
	public String doCheckUsernamePassword(HttpServletRequest request, HttpSession session, HttpServletResponse response,String userId) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		boolean reg = false; // 为false的时候检查通过
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Gson gson = new Gson();
		//传userId时是E学生pad登陆
		List<User> userList = userService.doLogin(username, password,userId);
		if (!CollectionUtils.isEmpty(userList))
		{
			User tempUser = userList.get(0);

			// 数据库platform.user_auth表中查看，有的话跳转到福建账号登陆（因为亦信会注册到platform）
			UserAuthorization ua_db = userService.getUserAuthorizationByUserId(tempUser.getUserId() + "");
			if (null != ua_db)
			{
				reg = false;
				resultMap.put("reg", reg);
				resultMap.put("fjReg", "0");
				String json = gson.toJson(resultMap);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}

			if ("sysadmin".equals(tempUser.getUsername()))// 超级管理员
			{
				List<Role> roleList = new ArrayList<Role>();
				List<Permission> permissionList = new ArrayList<Permission>();
				Role role = new Role();
				role.setRoleCode("admin");
				role.setRoleName("管理员");
				roleList.add(role);
				tempUser.setRoleList(roleList);

				Permission permission = new Permission();
				permission.setPermissionCode("admin");
				permission.setPermissionName("管理员");
				permissionList.add(permission);
				tempUser.setPermissionList(permissionList);

				session.setAttribute("user", tempUser);
				reg = false;
				resultMap.put("reg", reg);
				String json = gson.toJson(resultMap);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}

			if (!"1".equals(tempUser.getSource()))
			{
				reg = true;
				resultMap.put("reg", reg);
				String json = gson.toJson(resultMap);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}
			session.setAttribute("user", tempUser);
			reg = false;
			resultMap.put("reg", reg);
			String json = gson.toJson(resultMap);
			response.getWriter().write(json);
			response.getWriter().flush();

			return null;
		} else
		{
			// 智慧校园系统中找不到人的时候，到fjzyyptxx数据库中查询是否已经是认证福建用户
			String token = commonService.getAccesstoken(Cons.FJEDU_APPID, Cons.FJEDU_APPKEY);
			String fjResp = commonService.doFJlogin(token, username, StringUtil.toMD5(password), "0");
			if (!StringUtil.isEmpty(fjResp))
			{
				JSONObject obj = (JSONObject) JSONObject.fromObject(fjResp);
				String resultCode = (String) obj.get("result");
				if ("000000".equals(resultCode))
				{
					reg = false;
					resultMap.put("fjReg", "0");
				} else
				{
					reg = true;
				}
			} else
			{
				reg = true;
			}
			resultMap.put("reg", reg);
			String json = gson.toJson(resultMap);
			response.getWriter().write(json);
			response.getWriter().flush();
			return null;
		}
	}

	/**
	 * 从第三方应用跳转到智慧校园
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "/doLoginFrom3rdApp.do")
	public String doLoginFrom3rdApp(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap) throws IOException
	{
		String uuserId = request.getParameter("param");
		User loginUser = userService.getUserByUUserId(uuserId);
		/**
		 * 验证成功
		 */
		if (null != loginUser)
		{
			if (!"1".equals(loginUser.getSource()))
			{
				return null;
			}

			if ("sysadmin".equals(loginUser.getUsername()))// 超级管理员
			{
				List<Role> roleList = new ArrayList<Role>();
				List<Permission> permissionList = new ArrayList<Permission>();
				Role role = new Role();
				role.setRoleCode("admin");
				role.setRoleName("管理员");
				roleList.add(role);
				loginUser.setRoleList(roleList);

				Permission permission = new Permission();
				permission.setPermissionCode("admin");
				permission.setPermissionName("管理员");
				permissionList.add(permission);
				loginUser.setPermissionList(permissionList);

			}
			session.setAttribute("user", loginUser);

		} else
		{
			return null;
		}

		// 超级管理员，进入页面
		if ("sysadmin".equals(loginUser.getUsername()))
		{
			int count = applyService.getApplySchoolNum();
			modelMap.addAttribute("count", count);
			/**
			 * 进入首页
			 */
			return "system/administrator_welcome";
		} else
		{
			if (loginUser.getType() == 2)// 代理商
			{
				String condition = request.getParameter("condition");
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("condition", condition);
				conditionMap.put("userId", loginUser.getUserId());
				//
				List<SchoolInfo> list = schoolService.getSchoolListByAgencyUserId(conditionMap);
				HashMap<Integer, List<SchoolInfo>> map = new HashMap<Integer, List<SchoolInfo>>();
				List<SchoolInfo> tempList = new ArrayList<SchoolInfo>();
				int j = 0;
				map.put(j, tempList);
				for (int i = 0; i < list.size(); i++)
				{
					if (i / 6 == j)
					{
						tempList.add(list.get(i));
					} else
					{
						j = i / 6;
						tempList = new ArrayList<SchoolInfo>();
						tempList.add(list.get(i));
						map.put(j, tempList);
					}
				}
				modelMap.addAttribute("schoolInfoMap", map);
				modelMap.addAttribute("condition", condition);
				return "system/school_Management";
			} else if (loginUser.getType() == 3)// 技术支持
			{
				String condition = request.getParameter("condition");
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("condition", condition);
				conditionMap.put("userId", loginUser.getUserId());
				//
				List<SchoolInfo> list = schoolService.getSchoolListBySupportUserId(conditionMap);
				HashMap<Integer, List<SchoolInfo>> map = new HashMap<Integer, List<SchoolInfo>>();
				List<SchoolInfo> tempList = new ArrayList<SchoolInfo>();
				int j = 0;
				map.put(j, tempList);
				for (int i = 0; i < list.size(); i++)
				{
					if (i / 6 == j)
					{
						tempList.add(list.get(i));
					} else
					{
						j = i / 6;
						tempList = new ArrayList<SchoolInfo>();
						tempList.add(list.get(i));
						map.put(j, tempList);
					}
				}
				modelMap.addAttribute("schoolInfoMap", map);
				modelMap.addAttribute("condition", condition);
				return "system/school_Management";
			} else if (loginUser.getType() == 4)// 财务人员
			{
				return "finance/financial_statements";
			} else
			{
				List<School> list = schoolService.getSchoolListByUserId(loginUser.getUserId());
				if (list != null && list.size() > 0)
				{
					loginUser.setSchoolId(String.valueOf(list.get(0).getSchoolId()));
					return enterHomePage(request, session, modelMap);
				} else
				{
					return "../login";
				}

			}
		}

	}

	/**
	 * 回到主页
	 */
	@RequestMapping(value = "/toMain.do")
	public String toMain(HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");

		List<Menu> menuList = new ArrayList<Menu>();
		DBContextHolder.setDBType(loginUser.getSchoolId());
		if (loginUser.getUserId() == 1)
		{
			menuList = menuService.getAllMenuInfoSysadmin(loginUser.getSchoolId(), null);
		} else
		{
			menuList = menuService.getAllMenuInfo(loginUser.getSchoolId(), 0);
		}
		session.setAttribute("menuList", menuList);
		modelMap.addAttribute("menuList", menuList);
		return "home/main";
	}

	/**
	 * 进入主frame
	 */
	@RequestMapping(value = "/toMainFrame.do")
	public String toMainFrame(HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");

		List<Menu> menuList = new ArrayList<Menu>();
		DBContextHolder.setDBType(loginUser.getSchoolId());
		if (loginUser.getUserId() == 1)
		{
			menuList = menuService.getAllMenuInfoSysadmin(loginUser.getSchoolId(), null);
		} else
		{
			menuList = menuService.getAllMenuInfo(loginUser.getSchoolId(), 0);
		}

		School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(loginUser.getSchoolId()));
		session.setAttribute("menuList", menuList);
		modelMap.addAttribute("menuList", menuList);
		modelMap.addAttribute("school", school);

		return "home/main_frame";

	}

	/**
	 * 修改密码相关
	 */
	/**
	 * 进入修改密码页面
	 */
	@RequestMapping(value = "/toModifyPassword.do")
	public String toModifyPassword()
	{
		return "system/password_modify";
	}

	/**
	 * 进入修改密码页面
	 */
	@RequestMapping(value = "/doModifyPassword.do")
	public String doModifyPassword(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{
		String oldPassword = request.getParameter("oldPassword");
		// 当前登录用户的userid
		String newPassword = request.getParameter("newPassword");
		ResultInfo resultInfo = new ResultInfo();
		User user = (User) session.getAttribute("user");
		try
		{
			int count = 0;
			if (!StringUtil.isFjequals(user.getSchoolId()))
			{
				count = userService.modifyPassword(oldPassword, newPassword, user.getUserId());
			} else
			{
				count = userService.modifyPasswordFj(oldPassword, newPassword, user.getUserId());
			}
			if (count > 0)
			{
				resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
			} else
			{
				resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
			}
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

	/**
	 * 校验旧密码
	 */
	@RequestMapping(value = "/checkOldPassword.do")
	public String checkOldPassword(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{
		/**
		 * 旧密码
		 */
		String oldPassword = request.getParameter("oldPassword");

		User user = (User) session.getAttribute("user");

		/**
		 * 返回实体
		 */
		ResultInfo resultInfo = new ResultInfo();
		try
		{
			/**
			 * 判断密码是否存在
			 */
			if (userService.checkPasswordExist(oldPassword, user.getUserId()))
			{
				resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
			} else
			{
				resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
			}

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

	/**
	 * 进入变为用户页面
	 */
	@RequestMapping(value = "/toBecomeUser.do")
	public String toBecomeUser()
	{
		return "system/become_user";
	}

	/**
	 * 执行变为用户逻辑
	 */
	@RequestMapping(value = "/doBecomeUser.do")
	public String doBecomeUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		/**
		 * 变为用户名
		 */
		String becomeUserName = request.getParameter("becomeUserName");
		List<User> userList = userService.getUserListByBindPhone(becomeUserName);
		/**
		 * 存session
		 */
		Gson gson = new Gson();
		String json = "";
		if(!CollectionUtils.isEmpty(userList)){
			session.removeAttribute("user");
			session.removeAttribute("menuList");
			
			User tempUser = userList.get(0);
			List<School> schoolList = schoolService.getSchoolListByUserId(tempUser.getUserId());
			if (schoolList != null && schoolList.size() > 0)
			{
				tempUser.setSchoolId(String.valueOf(schoolList.get(0).getSchoolId()));
			}
			if ("sysadmin".equals(tempUser.getUsername()))// 超级管理员
			{
				List<Role> roleList = new ArrayList<Role>();
				List<Permission> permissionList = new ArrayList<Permission>();
				Role role = new Role();
				role.setRoleCode("admin");
				role.setRoleName("管理员");
				roleList.add(role);
				tempUser.setRoleList(roleList);

				Permission permission = new Permission();
				permission.setPermissionCode("admin");
				permission.setPermissionName("管理员");
				permissionList.add(permission);
				tempUser.setPermissionList(permissionList);
				tempUser.setSchoolId(DBContextHolder.getDBType());
			} else
			{
				List<Role> roleList = roleService.getRoleList(tempUser.getUserId());
				List<Permission> permissionList = permissionService.getPermissionList(tempUser.getUserId());
				String clazzId = userService.getClazzIdByUserId(tempUser.getUserId());
				List<Department> departList = departmentService.getDepartListByUserId(tempUser.getUserId());
				tempUser.setRoleList(roleList);
				tempUser.setPermissionList(permissionList);
				tempUser.setDepartmentList(departList);
				if (null != clazzId)
				{
					tempUser.setClazzId(Integer.valueOf(clazzId));
				}
			}
			session.removeAttribute("user");
			session.setAttribute("user", tempUser);
			json = gson.toJson(tempUser);
		}else{
			json = gson.toJson(null);
		}

		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 登出
	 */
	@RequestMapping(value = "/toLoginOut.do")
	public String toLoginOut(HttpSession session, HttpServletResponse response)
	{

		String reg = "true";
		/**
		 * 清除session
		 */
		if (null != session.getAttribute("user"))
		{
			session.removeAttribute("user");
			session.removeAttribute("menuList");
			session.invalidate();
			reg = "true";
		}

		Gson gson = new Gson();
		String json = gson.toJson(reg);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		/**
		 * 进入登陆页面
		 */
		return null;
	}
	
	@RequestMapping(value = "/clearSession.do",method=RequestMethod.POST)
	public String clearSession(HttpSession session, HttpServletResponse response)
	{

		String reg = "true";
		if (null != session.getAttribute("user"))
		{
			session.removeAttribute("user");
			session.removeAttribute("menuList");
			session.invalidate();
			reg = "true";
		}

		Gson gson = new Gson();
		String json = gson.toJson(reg);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		/**
		 * 进入登陆页面
		 */
		return null;
	}
	

	/**
	 * 根据用户名检查用户是否存在
	 */
	@RequestMapping(value = "/checkUserExist.do")
	public String checkUserExist(HttpServletRequest request, HttpServletResponse response)
	{
		String userName = request.getParameter("userName");
		boolean flag = userService.checkBindPhoneIsExist(userName);
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据用户名密码检查用户是否存在
	 */
	@RequestMapping(value = "/checkUserByNameAndPassWordExist.do")
	public String checkUserByNameAndPassWordExist(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		String passWord = request.getParameter("passWord");
		boolean isExist = userService.checkPasswordExist(passWord, 1);
		ResultInfo result = new ResultInfo();
		// 存在
		if (isExist)
		{
			result.setResultCode(ResultInfo.RESULT_SUCCESS);
		} else
		{
			result.setResultCode(ResultInfo.RESULT_ERROR);
		}

		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(result);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 切换学校
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/toChangeSchool.do")
	public String changeSchool(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String schoolId = request.getParameter("schoolId");
		User loginUser = (User) session.getAttribute("user");
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (!StringUtil.isEmpty(schoolId))
		{
			loginUser.setSchoolId(schoolId);
			map.put("status", 0);
			session.setAttribute("user", loginUser);
		} else
		{
			map.put("status", 1);
		}

		Gson gson = new Gson();
		String json = gson.toJson(map);
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
	 * 统计app下载次数
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addDownLoadNum.do")
	public String addDownLoadNum()
	{
		userService.addDownLoadNum();
		return null;
	}

	/**
	 * 判断用户手机号是否存在，用于修改手机号
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/checkPhoneIsExistByPhoneAndUserId.do")
	public String checkPhoneIsExistByPhoneAndUserId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String userId = request.getParameter("userId");
		String phone = request.getParameter("phone");
		HashMap<String, Object> param = new HashMap<String, Object>();
		try
		{
			param.put("userId", Integer.valueOf(userId));
			param.put("phone", phone);
			boolean flag = userService.isExistUserByPhoneAndUserId(param);
			String code = "0";
			if (flag)
			{
				code = "1";
			}
			response.getWriter().write(GsonHelper.toJson(code));
			response.getWriter().flush();
		} catch (Exception e)
		{

		}

		return null;
	}

	/**
	 * 判断是否登陆
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/isLogin.do")
	public void isLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String schoolId = request.getParameter("schoolId");
		String isLogin = "false";
		if (null != session.getAttribute("user"))
		{
			isLogin = "true";
			User user = (User) session.getAttribute("user");
			if (null == user.getSchoolId() || "".equals(user.getSchoolId()))
			{
				user.setSchoolId(schoolId);
				session.setAttribute("user", user);
			}
		}
		try
		{
			response.getWriter().write(GsonHelper.toJson(isLogin));
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 获得手机端技术支持的人员的手机号
	 * 
	 * @author chenyong
	 * @Time 2016年12月27日 下午6:34:09
	 */
	@RequestMapping(value = "/getTechnicalSupportInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public void getTechnicalSupportInfo(String schoolId, HttpServletResponse response)
	{
		RichHttpResponse<Map<String, Object>> rhr = new RichHttpResponse<Map<String, Object>>();
		try
		{
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
			String technicalSupportPhone = pro.getProperty("technicalSupportPhone");
			String technicalSupportInfo = pro.getProperty("technicalSupportInfo");
//			List<User> list = null;
//			if (!StringUtil.isEmpty(technicalSupportPhone))
//			{
//				list = userService.getTechnicalSupportPhone(technicalSupportPhone);
//			}
			if(StringUtil.isEmpty(schoolId)){
				
			}
			Map<String, Object> mapInfo = new HashMap<>();
			List<JSONObject> listPhone = new ArrayList<>();
			List<JSONObject> listVoip = new ArrayList<>();
			JSONObject mapVoip = null;
			JSONObject mapPhone = null;
			//获取公共的在线客服名单
			if(!StringUtil.isEmpty(technicalSupportInfo)){
				 net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(technicalSupportInfo);
				for (Object object : jsonArray.toArray()) {
					JSONObject jsonObject=JSONObject.fromObject(object);
					mapVoip = new JSONObject();
					mapVoip.put("realName",jsonObject.get("realName"));
					mapVoip.put("userId",jsonObject.get("userId"));
					mapVoip.put("voipAccount",jsonObject.get("voipAccount"));
					listVoip.add(mapVoip);
				}
			}
			
			//获取公共的电话咨询名单
			if(!StringUtil.isEmpty(technicalSupportPhone)){
				net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(technicalSupportPhone);
				for (Object object : jsonArray.toArray()) {
					JSONObject jsonObject=JSONObject.fromObject(object);
					mapPhone = new JSONObject();
					mapPhone.put("phone", jsonObject.get("phone"));
					mapPhone.put("realName", jsonObject.get("realName"));
					listPhone.add(mapPhone);
				}
			}
				
			//获取学校所在本地的代理商电话咨询名单
			String local_technicalSupportPhone = pro.getProperty(schoolId+"_technicalSupportPhone");
			if(!StringUtil.isEmpty(local_technicalSupportPhone)){
				net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(local_technicalSupportPhone);
				for (Object object : jsonArray.toArray()) {
					JSONObject jsonObject=JSONObject.fromObject(object);
					mapPhone = new JSONObject();
					mapPhone.put("phone", jsonObject.get("phone"));
					mapPhone.put("realName", jsonObject.get("realName"));
					listPhone.add(mapPhone);
				}
			}
			
			mapInfo.put("voipList", listVoip);
			mapInfo.put("phoneList", listPhone);
			rhr.ResponseCode = 0;
			rhr.ResponseResult = "获取成功";
			rhr.ResponseObject = mapInfo;
			String json = GsonHelper.toJson(rhr);

			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			logger.error("获取技术支持人员出错:"+e.getMessage());

		} 
	}
	
	/**
	 * 登录用户没有加入和自己有关系的的智慧校园班级群或智慧校园部门群
	 */
	@RequestMapping(value = "/getWisdomCampusClazzOrDepartGroup.do",method=RequestMethod.POST)
	public void getWisdomCampusClazzOrDepartGroup(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<Groups>> rhr = new RichHttpResponse<List<Groups>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");

		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				Integer userId = loginUser.getUserId();
				List<Role> roleList = loginUser.getRoleList();
				List<Groups> groupsList = new ArrayList<Groups>();
				for(Role role : roleList){
					String roleCode = role.getRoleCode();
					if((!"student".equals(roleCode)) && (!"parent".equals(roleCode))){
						//不是学生家长角色的需要判断智慧校园部门群
						List<Department> departList = loginUser.getDepartmentList();
						if(!CollectionUtils.isEmpty(departList)){
							for(Department department : departList){
								List<Groups> tmpGroupList = groupsService.getGroupsBySchoolIdAndDepartmentId(Long.valueOf(schoolId), department.getId());
								if(!CollectionUtils.isEmpty(tmpGroupList)){
									for(Groups group : tmpGroupList){
										Groupmember gm = groupmemberService.getByGroupIdAndUserId(group.getGroupId(), userId);
										if(gm == null){
											groupsList.add(group);
										}
									}
								}
							}
						}
					}
					//获取自己的班级
					List<Clazz> totalClazzList = new ArrayList<Clazz>();
					List<Clazz> clazzList1 = clazzService.getClazzListForSetPermission(userId);
					List<Clazz> clazzList2 = clazzService.getClazzListByParentId(userId);
					List<Clazz> clazzList3 = clazzService.getClazzListByStudentId(userId);
					Map<Integer, Object> map = new HashMap<Integer, Object>();
					totalClazzList.addAll(clazzList1);
					totalClazzList.addAll(clazzList2);
					totalClazzList.addAll(clazzList3);
					for(Clazz clazz : totalClazzList)
					{
						if(!map.containsKey(clazz.getId()))
						{
							map.put(clazz.getId(), clazz);
							List<Groups> tmpGroupList = groupsService.getGroupsBySchoolIdAndClazzId(Long.valueOf(schoolId), clazz.getId());
							if(!CollectionUtils.isEmpty(tmpGroupList))
							{
								for(Groups group : tmpGroupList)
								{
									Groupmember gm = groupmemberService.getByGroupIdAndUserId(group.getGroupId(), userId);
									if(gm == null)
									{
										groupsList.add(group);
									}
								}
							}
						}
					}
				}
				
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = groupsList;
				json = GsonHelper.toJson(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("获取智慧校园班级群或智慧校园部门群,json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("获取智慧校园班级群或智慧校园部门群失败：" + e.getMessage());
		}
	}
	

	/**
	 * 亦信登录获取该用户是否具有查看智慧校园功能的的权限
	 * @param request
	 * @param session
	 * @param modelMap 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getLoginUserHasWisdomPermissionByApiKey.do")
	public String getServicemanListByType(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Boolean> rhr = new RichHttpResponse<Boolean>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				boolean hasPermission = userService.getLoginUserHasPermission("allWisdomFunction", loginUser);
				
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = hasPermission;
				json = GsonHelper.toJsonWithAnnotation(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("getLoginUserHasWisdomPermissionByApiKey,json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("getLoginUserHasWisdomPermissionByApiKey,获取失败：" + e.getMessage());
		}
		return null;
	}
	
}