package com.guotop.palmschool.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.OrderMessage;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.OrderUserMessageDetail;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.Sms;
import com.guotop.palmschool.entity.SmsDetail;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.GradeService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.SmsService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.TeacherService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.HttpPostUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.whty.aam.client.util.HttpUtil;

/**
 * 短信相关控制类
 */
@RequestMapping("/sms")
@Controller
public class SmsController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(SmsController.class);
	@Resource
	private CommonService commonService;

	@Resource
	private SmsService smsService;

	@Resource
	private GradeService gradeService;

	@Resource
	private TeacherService teacherService;

	@Resource
	private StudentService studentService;

	@Resource
	private OrderMessageService orderMessageService;

	@Resource
	private UserService userService;

	@Resource
	private ScheduleService scheduleService;
	
	@Autowired
	private ThreadPoolTaskExecutor poolTaskExecutor;

	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 进入我的信息页面(类似于短信收件箱)
	 */
	@RequestMapping(value = "/toMySms.do")
	public String toMySms()
	{
		return "sms/mySms";
	}

	@RequestMapping(value = "/getAcceptSmsList.do")
	public String getAcceptSmsList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try
		{
			User user = (User) session.getAttribute("user");
			Integer userId = Integer.valueOf(request.getParameter("userId"));
			String roleCode = request.getParameter("roleCode");
			// 查询类型
			String queryContent = request.getParameter("queryContent");
			// 分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			List<Integer> ids = new ArrayList<Integer>();
			List<User> allChildren = null;
			// 家长可以看到所有小孩的信息
			if ("parent".equals(roleCode))
			{

				// 家长通过userId,查询他所有小孩的id
				if (!StringUtil.isFjequals(user.getSchoolId()))
				{// 非福建
					allChildren = commonService.getAllChildrenByUserId(userId);
				} else
				{
					allChildren = commonService.getAllChildrenByUserIdFj(userId);
				}

				for (User children : allChildren)
				{
					ids.add(children.getUserId());
				}

			}
			// 其余j看到的是自己
			else
			{
				ids.add(userId);
			}
			paramMap.put("receiverIdList", ids);
			paramMap.put("queryContent", queryContent);
			this.getPages().setPageSize(50);
			Pages pages = null;
			if (!StringUtil.isFjequals(user.getSchoolId()))
			{
				pages = smsService.getAcceptSmsList(this.getPages().getPageSize(), currentPage, paramMap);
			} else
			{
				paramMap.put("fjSchoolId", user.getFjSchoolId());
				pages = smsService.getAcceptSmsListFj(this.getPages().getPageSize(), currentPage, paramMap);
			}

			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}
		return null;
	}

	/**
	 * 进入成绩发送页面
	 */
	@RequestMapping(value = "/toScoreSending.do")
	public String toScoreSending(HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");

		// SchoolTrySms schoolTrySms =
		// commonService.getSchoolTrySms(user.getSchoolId());
		// if (schoolTrySms == null)
		// {
		// modelMap.addAttribute("schoolTrySms", "have");
		// } else
		// {
		// modelMap.addAttribute("schoolTrySms", "nothave");
		// }
		/*
		 * 先判断学校是否使用了学校条数套餐 1.返回值为空，代表没有使用,这种情况下直接发送 2.返回值为0或者剩余条数代表有使用， 2.1
		 * 如果【没有】其余的面向个人购买的套餐，说明学校只有【学校条数套餐】，所有【不】能够有发送按钮显示
		 * 2.2如果【有】其余的面向个人购买的套餐，说明学校可能有人购买了面向个人购买的套餐,所有能够有发送按钮显示
		 */
		// 定义学校是否能发送短信
		boolean isCanSendSms = false;
		// 定义代表学校是否使用过【学校条数套餐】
		boolean isSchoolUse = false;
		// 定义【学校条数套餐】是否有剩余
		boolean isSchoolBuy = false;
		Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(user.getSchoolId());
		if (null == remainCount)
		{
			isSchoolUse = false;
		} else
		{
			if (remainCount > 0)
			{
				isSchoolUse = true;
				isSchoolBuy = true;
			} else
			{
				isSchoolUse = true;
			}
		}

		if (isSchoolUse)
		{
			if (isSchoolBuy)
			{
				isCanSendSms = true;
			} else
			{
				// 学校虚拟套餐状态 0:可用 1：失效
				String status = orderMessageService.getVirtualMessageStatus();
				List<OrderMessage> messageList = new ArrayList<OrderMessage>();
				if (!"0".equals(status))
				{
					messageList = orderMessageService.getProduct();
					// 学校使用过学校条数套餐，但是如果没有其余的面向个人购买的套餐，说明学校只有【学校条数套餐】，所有不能发送
					if (CollectionUtils.isEmpty(messageList))
					{
						isCanSendSms = false;
					} else
					{
						isCanSendSms = true;
					}
				} else
				{
					isCanSendSms = true;
				}
			}
		} else
		{
			isCanSendSms = true;
		}

		if (isCanSendSms)
		{
			modelMap.addAttribute("schoolTrySms", "have");
		} else
		{
			modelMap.addAttribute("schoolTrySms", "nothave");
		}
		return "sms/scoreSending";
	}

	/**
	 * 进入成绩发送记录页面
	 */
	@RequestMapping(value = "/toScoreSendingSmsList.do")
	public String toScoreSendingSmsList()
	{
		return "sms/scoreSendingSms_list";
	}

	/**
	 * 加载成绩发送记录
	 * 
	 */
	@RequestMapping(value = "/getScoreSendingSmsList.do")
	public String getScoreSendingSmsList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try
		{

			/**
			 * 查询类型
			 */
			String queryContent = String.valueOf(request.getParameter("queryContent"));
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

			String roleCode = request.getParameter("roleCode");

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("queryContent", queryContent);
			paramMap.put("type", 2);// 查询所有成绩发送列表

			Pages pages = smsService.loadSmsList(this.getPages().getPageSize(), currentPage, paramMap, user);

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
	 * 进入成绩发送详细页面
	 */
	@RequestMapping(value = "/toScoreSendingSmsDetail.do")
	public String toScoreSendingSmsDetail(HttpServletRequest request, ModelMap modelMap)
	{

		Integer id = Integer.valueOf(request.getParameter("id"));
		modelMap.addAttribute("id", id);
		return "sms/scoreSendingSms_detail";
	}

	/**
	 * 加载成绩发送详情列表 20151203
	 */
	@RequestMapping(value = "/loadScoreSendingSmsDetail.do")
	public String loadScoreSendingSmsDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try
		{
			Integer id = Integer.parseInt(request.getParameter("messageId"));

			/**
			 * 查询内容
			 */
			String queryContent = null;

			try
			{
				queryContent = String.valueOf(request.getParameter("queryContent"));
			} catch (Exception e)
			{
				queryContent = null;
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

			paramMap.put("id", id);
			paramMap.put("queryContent", queryContent);
			this.getPages().setPageSize(50);
			Pages pages = smsService.loadScoreSendingSmsDetail(this.getPages().getPageSize(), currentPage, paramMap);

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
	 * 进入教师短信服务页面
	 */
	@RequestMapping(value = "/toTeacherSms.do")
	public String toTeacherSms(HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");
		// SchoolTrySms schoolTrySms =
		// commonService.getSchoolTrySms(user.getSchoolId());
		// if (schoolTrySms == null)
		// {
		// modelMap.addAttribute("schoolTrySms", "have");
		// } else
		// {
		// modelMap.addAttribute("schoolTrySms", "nothave");
		// }
		/*
		 * 
		 */

		/*
		 * 先判断学校是否使用了学校条数套餐 1.返回值为空，代表没有使用,这种情况下直接发送 2.返回值为0或者剩余条数代表有使用， 2.1
		 * 如果【没有】其余的面向个人购买的套餐，说明学校只有【学校条数套餐】，所有【不】能够有发送按钮显示
		 * 2.2如果【有】其余的面向个人购买的套餐，说明学校可能有人购买了面向个人购买的套餐,所有能够有发送按钮显示
		 */
		// 定义学校是否能发送短信
		boolean isCanSendSms = false;
		// 定义代表学校是否使用过【学校条数套餐】
		boolean isSchoolUse = false;
		// 定义【学校条数套餐】是否有剩余
		boolean isSchoolBuy = false;
		Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(user.getSchoolId());
		if (null == remainCount)
		{
			isSchoolUse = false;
		} else
		{
			if (remainCount > 0)
			{
				isSchoolUse = true;
				isSchoolBuy = true;
			} else
			{
				isSchoolUse = true;
			}
		}

		if (isSchoolUse)
		{
			if (isSchoolBuy)
			{
				isCanSendSms = true;
			} else
			{
				// 学校虚拟套餐状态 0:可用 1：失效
				String status = orderMessageService.getVirtualMessageStatus();
				List<OrderMessage> messageList = new ArrayList<OrderMessage>();
				if (!"0".equals(status))
				{
					messageList = orderMessageService.getProduct();
					// 学校使用过学校条数套餐，但是如果没有其余的面向个人购买的套餐，说明学校只有【学校条数套餐】，所有不能发送
					if (CollectionUtils.isEmpty(messageList))
					{
						isCanSendSms = false;
					} else
					{
						isCanSendSms = true;
					}
				} else
				{
					isCanSendSms = true;
				}
			}
		} else
		{
			isCanSendSms = true;
		}

		if (isCanSendSms)
		{
			modelMap.addAttribute("schoolTrySms", "have");
		} else
		{
			modelMap.addAttribute("schoolTrySms", "nothave");
		}
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		int smsWordLimit = PropertiesUtil.getInstance().getSmsWordLimit(pro, user.getSchoolId());
		modelMap.addAttribute("smsWordLimit", smsWordLimit);
		return "sms/teacherSms_add";
	}

	/**
	 * 查询所有教师，姓名， 部门, 用于发送短信息
	 * 
	 * @param type
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getTeacherList.do")
	public String getTeacherList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		// 登录用户
		User loginUser = (User) session.getAttribute("user");

		String permissionCode = request.getParameter("permissionCode");

		paramMap.put("user", loginUser);
		paramMap.put("userId", loginUser.getUserId());
		paramMap.put("permissionCode", permissionCode);
		List<Department> departmentList = null;
		if (!StringUtil.isFjequals(loginUser.getSchoolId()))
		{// 非福建
			// 获取部门列表（不同的人看到不同的部门列表）
			departmentList = commonService.getDepartList(paramMap);
		} else
		{
			paramMap.put("fjSchoolId", loginUser.getFjSchoolId());
			departmentList = commonService.getDepartListFj(paramMap);
		}

		// 对象部门循环，获取每个门下所有老师
		for (Department department : departmentList)
		{
			List<User> teacherList = commonService.getTeacherDetailByDepartmentId(department.getId());
			department.setTeacherList(teacherList);
		}

		/**
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(departmentList);
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
	 * 根据部门Id 获取对应的部门人员
	 * 
	 * @param type
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/loadTeacherListByDepartmentId.do")
	public String loadTeacherListByDepartmentId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		String departmentId = request.getParameter("departmentId");
		User user = (User) session.getAttribute("user");
		List<User> teacherList = null;
		if (!StringUtil.isFjequals(user.getSchoolId()))
		{
			teacherList = commonService.getTeacherDetailByDepartmentId(StringUtil.toint(departmentId));
		} else
		{
			teacherList = commonService.getTeacherDetailByDepartmentIdFj(StringUtil.toint(departmentId));
		}

		/**
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(teacherList);
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
	 * 进入学生短信服务页面
	 */
	@RequestMapping(value = "/toStudentSms.do")
	public String toStudentSms(HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");
		// SchoolTrySms schoolTrySms =
		// commonService.getSchoolTrySms(user.getSchoolId());
		// if (schoolTrySms == null)
		// {
		// modelMap.addAttribute("schoolTrySms", "have");
		// } else
		// {
		// modelMap.addAttribute("schoolTrySms", "nothave");
		// }

		/*
		 * 先判断学校是否使用了学校条数套餐 1.返回值为空，代表没有使用,这种情况下直接发送 2.返回值为0或者剩余条数代表有使用， 2.1
		 * 如果【没有】其余的面向个人购买的套餐，说明学校只有【学校条数套餐】，所有【不】能够有发送按钮显示
		 * 2.2如果【有】其余的面向个人购买的套餐，说明学校可能有人购买了面向个人购买的套餐,所有能够有发送按钮显示
		 */
		// 定义学校是否能发送短信
		boolean isCanSendSms = false;
		// 定义代表学校是否使用过【学校条数套餐】
		boolean isSchoolUse = false;
		// 定义【学校条数套餐】是否有剩余
		boolean isSchoolBuy = false;
		Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(user.getSchoolId());
		if (null == remainCount)
		{
			isSchoolUse = false;
		} else
		{
			if (remainCount > 0)
			{
				isSchoolUse = true;
				isSchoolBuy = true;
			} else
			{
				isSchoolUse = true;
			}
		}

		if (isSchoolUse)
		{
			if (isSchoolBuy)
			{
				isCanSendSms = true;
			} else
			{
				// 学校虚拟套餐状态 0:可用 1：失效
				String status = orderMessageService.getVirtualMessageStatus();
				List<OrderMessage> messageList = new ArrayList<OrderMessage>();
				if (!"0".equals(status))
				{
					messageList = orderMessageService.getProduct();
					// 学校使用过学校条数套餐，但是如果没有其余的面向个人购买的套餐，说明学校只有【学校条数套餐】，所有不能发送
					if (CollectionUtils.isEmpty(messageList))
					{
						isCanSendSms = false;
					} else
					{
						isCanSendSms = true;
					}
				} else
				{
					isCanSendSms = true;
				}
			}
		} else
		{
			isCanSendSms = true;
		}

		if (isCanSendSms)
		{
			modelMap.addAttribute("schoolTrySms", "have");
		} else
		{
			modelMap.addAttribute("schoolTrySms", "nothave");
		}

		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		int smsWordLimit = PropertiesUtil.getInstance().getSmsWordLimit(pro, user.getSchoolId());
		modelMap.addAttribute("smsWordLimit", smsWordLimit);
		return "sms/studentSms_add";
	}

	/**
	 * 查询所有学生，姓名， 班级, 用于发送短信息
	 * 
	 * @param type
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getStudentList.do")
	public String getStudentList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		// 登录用户
		User loginUser = (User) session.getAttribute("user");

		String permissionCode = request.getParameter("permissionCode");

		paramMap.put("user", loginUser);
		paramMap.put("userId", loginUser.getUserId());
		paramMap.put("permissionCode", permissionCode);
		// 获取班级列表（不同的人看到不同班级列表）
		List<Clazz> clazzList = commonService.getClazzList(paramMap);
		// 对班级循环，获取每个门下所有学生
		// TODO
		for (Clazz clazz : clazzList)
		{
			List<User> studentList = studentService.getStudentListByClazzIdInStudentSMS(clazz.getId());
			clazz.setStudentList(studentList);

		}

		/**
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(clazzList);
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
	 * 查询所有学生，姓名， 班级, 用于发送短信息
	 * 
	 * @param type
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getAllStudentList.do")
	public String getAllStudentList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		// 登录用户
		User loginUser = (User) session.getAttribute("user");

		String permissionCode = request.getParameter("permissionCode");

		paramMap.put("user", loginUser);
		paramMap.put("userId", loginUser.getUserId());
		paramMap.put("permissionCode", permissionCode);
		// 获取班级列表（不同的人看到不同班级列表）
		List<Clazz> clazzList = commonService.getClazzList(paramMap);
		// 对班级循环，获取每个门下所有学生
		List<User> studentList = studentService.getAllStudentList(loginUser.getSchoolId());// 所有的学生

		/**
		 * flush到页面
		 */
		Gson gson = new Gson();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clazzList", clazzList);
		map.put("studentList", studentList);
		String json = gson.toJson(map);
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
	 * 根据clazzId查询所有教师，姓名， 部门, 用于发送短信息
	 * 
	 * @param type
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/loadStudentListByClazzId.do")
	public String loadStudentListByClazzId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		String clazzId = request.getParameter("clazzId");

		List<User> studentList = studentService.getStudentListByClazzIdInStudentSMS(StringUtil.toint(clazzId));

		/**
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(studentList);
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
	 * 新增短信发送 教師
	 * 
	 * @return
	 * @throws ParseException
	 */

	@RequestMapping(value = "/doAddSms.do")
	public String doAddSms(HttpServletRequest request, HttpSession session)
	{

		// 登录用户
		User user = (User) session.getAttribute("user");
		/*
		 * 接受前台发送的短信内容
		 */
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		int smsWordLimit = PropertiesUtil.getInstance().getSmsWordLimit(pro, user.getSchoolId());
		String content = request.getParameter("content").trim();
		if (!StringUtil.isEmpty(content))
		{
			if (content.length() >= smsWordLimit)
			{
				content.substring(0, smsWordLimit);
			}
		}

		/*
		 * 发送类型
		 */
		Integer mode = Integer.valueOf(request.getParameter("mode"));

		/**
		 * 接受前台选中教师或部门
		 */
		String[] receiverArr = request.getParameterValues("selectedObj");

		// set集合用户保存所有接收者信息
		Set<User> set = new HashSet<User>();
		if (receiverArr != null)
		{
			for (int i = 0; i < receiverArr.length; i++)
			{
				// 获取首字母
				String firstChar = receiverArr[i].substring(0, 1);
				if ("D".equals(firstChar))
				{
					// 获取部门ID;
					String departmentId = receiverArr[i].substring(1);

					// 接下来是通过部门ID获取该年级下所有的老师信息
					List<User> teacherList = commonService.getTeacherDetailByDepartmentIdInSms(Integer.valueOf(departmentId));
					for (User teacher : teacherList)
					{
						set.add(teacher);
					}

				} else if ("T".equals(firstChar))
				{
					// 获取接受教师ID 也就是userid
					String teacherId = receiverArr[i].substring(1);
					User teacher = commonService.getUserDetailByUserId(Integer.valueOf(teacherId));
					set.add(teacher);

				}
			}
		}

		ArrayList<User> receiverList = new ArrayList<User>();
		receiverList.addAll(set);

		String sendTime = request.getParameter("startTime");

		// 下面启用线程发送正常短息
		final Integer modeFinal = mode;
		final ArrayList<User> receiverListFinal = receiverList;
		final String contentFinal = content;
		final String sendTimeFinal = sendTime;
		final User userFinal = user;

		new Thread(new Runnable()
		{
			public void run()
			{
				try
				{
					User user = userFinal;
					DBContextHolder.setDBType(user.getSchoolId());
					if (StringUtil.isEmpty(sendTimeFinal))
					{
						// 发送短信
						send(user, contentFinal, receiverListFinal, modeFinal, null);
					} else
					{
						send(user, contentFinal, receiverListFinal, modeFinal, sendTimeFinal);
					}

				} catch (Exception e)
				{
					log.error("发送短信失败,接收人id：" + userFinal.getUserId() + "\r\n" + e);
				}
			}
		}).start();

		return toSmsList();
	}

	/**
	 * 新增短信发送 學生
	 * 
	 * @return
	 * @throws ParseException
	 */

	@RequestMapping(value = "/doAddSmsForStudent.do")
	public String doAddSmsForStudent(HttpServletRequest request, HttpSession session)
	{

		// 登录用户
		User user = (User) session.getAttribute("user");
		/*
		 * 接受前台发送的短信内容
		 */
		String content = request.getParameter("content").trim();
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		int smsWordLimit = PropertiesUtil.getInstance().getSmsWordLimit(pro, user.getSchoolId());
		if (!StringUtil.isEmpty(content))
		{
			if (content.length() >= smsWordLimit)
			{
				content.substring(0, smsWordLimit);
			}
		}
		/*
		 * 发送类型
		 */
		Integer mode = Integer.valueOf(request.getParameter("mode"));

		/*
		 * 接受前台选中学生或班级
		 */
		String[] receiverArr = request.getParameterValues("selectedObj");

		// set集合用户保存所有接收者信息
		Set<User> set = new HashSet<User>();
		if (receiverArr != null)
		{
			//TODO 这一块可以优化，目前的问题是在循环中查询，增加数据库压力，可以循环之后，批量去数据库查询
			for (int i = 0; i < receiverArr.length; i++)
			{
				// 获取首字母
				String firstChar = receiverArr[i].substring(0, 1);
				if ("C".equals(firstChar))
				{
					// 获取班级ID;
					String clazzId = receiverArr[i].substring(1);

					// 接下来是通过班级ID获取该班级下所有的学生信息(这里包含学生家长手机号，学生和家长是一对多)
					List<User> studentList = studentService.getStudentListByClazzIdInRICHBOOK(Integer.valueOf(clazzId));
					for (User student : studentList)
					{
						set.add(student);
					}

				} else if ("S".equals(firstChar))
				{
					// 获取接受學生ID 也就是userid
					String studentId = receiverArr[i].substring(1);
					// 根据学生ID获取学生信息
					User student = studentService.getStudentById(Integer.valueOf(studentId));
					set.add(student);
				}
			}
		}

		ArrayList<User> receiverList = new ArrayList<User>();
		receiverList.addAll(set);

		String sendTime = request.getParameter("startTime");

		// 下面启用线程发送正常短息
		final Integer modeFinal = mode;
		final ArrayList<User> receiverListFinal = receiverList;
		final String contentFinal = content;
		final String sendTimeFinal = sendTime;
		final User userFinal = user;

		poolTaskExecutor.execute(new Runnable()
		{
			@Override
			public void run()
			{
				try
				{
					User user = userFinal;
					DBContextHolder.setDBType(user.getSchoolId());
					if (StringUtil.isEmpty(sendTimeFinal))
					{
						// 发送短信
						send(user, contentFinal, receiverListFinal, modeFinal, null);
					} else
					{
						send(user, contentFinal, receiverListFinal, modeFinal, sendTimeFinal);
					}

				} catch (Exception e)
				{
					log.error("发送短信失败,接收人id：" + userFinal.getUserId() + "\r\n" + e);
				}
			}
		});
		return toSmsList();
	}

	/**
	 * 
	 * @param user
	 * @param content
	 *            短信内容
	 * @param receiverList
	 * @param mode
	 *            发送短信类型，0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知 4:校车
	 * @param sendTime
	 *            yyyy-MM-dd HH:mm:ss
	 * @throws ParseException
	 */
	private void send(User user, String content, ArrayList<User> receiverList, Integer mode, String sendTime)
	{
		Map<String, Object> paramMap_sms = new HashMap<String, Object>();
		// 保存到sms表中
		Sms sms = new Sms();
		sms.setContent(content);
		sms.setSenderId(user.getUserId());
		sms.setSenderName(user.getRealName());
		sms.setSmsLength(content.length()); // 短信长度
		sms.setPhoneCount(receiverList.size()); // 发送人数
		sms.setResult(0);// 短信回执状态
		sms.setReportAmount(0);
		sms.setSuccAmount(0);
		sms.setCreateTime(TimeUtil.getInstance().now());

		if (StringUtil.isEmpty(sendTime))
		{
			sendTime = formatter.format(new Date());
			sms.setIsRealTime(Cons.SMS_REALTIME);// 1:即时发送
		} else
		{
			sms.setIsRealTime(Cons.SMS_TIMING);// 0:定时发送
		}
		sms.setSentTime(sendTime);

		if (mode == 0)
		{
			sms.setType("0"); // 0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知
			sms.setModule(Cons.MODULE_SCHOOLAFFAIRS); // 教师短信服务
		} else if (mode == 1)
		{
			sms.setType("1"); // 0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知
			sms.setModule(Cons.MODULE_STUDENTSERVICE); // 学生短信服务
		}

		Integer smsCount = 0;
		try
		{
			// 先查找24小时内是否发过该短信,超过可以重发, 要是不超过判断如果是同一个人就发送短信
			paramMap_sms.put("content", content);
			paramMap_sms.put("time", formatter.format((formatter.parse(sendTime).getTime() - 24 * 60 * 60 * 1000)));
			smsCount = smsService.loadSmsByContent(paramMap_sms);
		} catch (ParseException e1)
		{
			e1.printStackTrace();
		}

		// 获取数据库中最新一条数据的短信总数smsSum 和 errorSmsSum
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Sms lastSms = smsService.getLastOneFromSms(paramMap);
		int smsSum = 0; // 短信发送总数
		try
		{
			smsSum = lastSms.getSmsSum();
		} catch (Exception e)
		{

		}
		int errorSmsSum = 0; // 短信发送总数
		try
		{
			errorSmsSum = lastSms.getErrorSmsSum();
		} catch (Exception e)
		{

		}
		sms.setSmsSum(smsSum);
		sms.setErrorSmsSum(errorSmsSum);
		// 保存到数据库, 并且返回smsId
		int smsId = smsService.addSms(sms);
		// int count = (int)Math.ceil(content.length()/65);
		int count = ((int) content.length() / 65) + 1;
		List<PushItem> piList = new ArrayList<PushItem>();
		Map<Integer, Object> piMap = new HashMap<Integer, Object>();
		String schoolId = user.getSchoolId();
		
		boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐
		boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启
		boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐
		try{
			//蕉城实小schoolId="3509020027" ,发送人自己也需要收到短信
			if("3509020027".equals(schoolId) && (mode == 1)){
				if(!commonService.hasAdminPermission(user)){
					SmsDetail loginSmsDetail = new SmsDetail();
					loginSmsDetail.setContent(content);
					loginSmsDetail.setSenderId(user.getUserId());
					loginSmsDetail.setSenderName(user.getRealName());
					loginSmsDetail.setReceiverId(user.getUserId());
					loginSmsDetail.setPhone(user.getPhone());
					loginSmsDetail.setReceiverName(user.getRealName());
					loginSmsDetail.setSeq("");
					loginSmsDetail.setReport("");
					loginSmsDetail.setSmsId(smsId);
					loginSmsDetail.setReportTime(TimeUtil.getInstance().now());
					loginSmsDetail.setCreateTime(TimeUtil.getInstance().now());
					loginSmsDetail.setType(sms.getType());
					loginSmsDetail.setSentTime(sendTime);
					
					sendSmsByOrdermessage(0,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user, user,user, smsId,content, sendTime, loginSmsDetail, smsSum, 
							count, errorSmsSum);
				}
			}
		}catch(Exception e){
			//这边异常不处理
			log.error("PC TEACHER private void send2(" + e.getMessage());
		}
		
		for (User receiver : receiverList)
		{
			String receiverRealName = receiver.getRealName();
			try
			{
				List<User> parentList = new ArrayList<User>();
				if(mode == 0) //教师
				{
					PushItem pi = new PushItem();
					pi.title = PUSHTYPE.TEACHERPUSH.getName();
					pi.PushContent = content;
					pi.PushType = PUSHTYPE.TEACHERPUSH.getType();
					pi.PushContentType = PUSHTYPE.TEACHERPUSH.getContentType();
					String channelId = receiver.getBaiduChannelId();
					Integer deviceType = receiver.getDeviceType();
					if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
					{
						pi.channels = channelId;
						pi.deviceType = String.valueOf(deviceType);
					}
					pi.receiverId = receiver.getUserId();
					pi.schoolId = schoolId;
					if(!piMap.containsKey(receiver.getUserId())){
						piList.add(pi);
						piMap.put(receiver.getUserId(), pi);
					}
					
				}else if (mode == 1) //学生
				{
					parentList = commonService.getParentByStudentId(receiver.getUserId());
					for(User parent : parentList)
					{					
						PushItem pi = new PushItem();
						pi.title = PUSHTYPE.STUDENTPUSH.getName();
						//睢县育才学校不要加人名
						if("4114220090".equals(schoolId)||"3201140009".equals(schoolId)){
							pi.PushContent = content;
						}else{
							pi.PushContent = "["+receiverRealName+"]"+ content;
						}
						pi.PushType = PUSHTYPE.STUDENTPUSH.getType();
						pi.PushContentType = PUSHTYPE.STUDENTPUSH.getContentType();
						String channelId = parent.getBaiduChannelId();
						Integer deviceType = parent.getDeviceType();
						if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
						{
							pi.channels = channelId;
							pi.deviceType = String.valueOf(deviceType);
						}
						pi.receiverId = parent.getUserId();
						pi.schoolId = schoolId;
						if(!piMap.containsKey(parent.getUserId())){
							piList.add(pi);
							piMap.put(parent.getUserId(), pi);
						}
					}
				}
				
				SmsDetail smsDetail = new SmsDetail();
				smsDetail.setContent(content);
				smsDetail.setSenderId(user.getUserId());
				smsDetail.setSenderName(user.getRealName());
				smsDetail.setReceiverId(receiver.getUserId());
				smsDetail.setPhone(receiver.getPhone());
				smsDetail.setReceiverName(receiverRealName);
				smsDetail.setSeq("");
				smsDetail.setReport("");
				smsDetail.setSmsId(smsId);
				smsDetail.setReportTime(TimeUtil.getInstance().now());
				smsDetail.setCreateTime(TimeUtil.getInstance().now());
				smsDetail.setType(sms.getType());
				smsDetail.setSentTime(sendTime);

				/*
				 * 1.先判断学校有无套餐 ： 无--->则所有人都发送 ， 有--->判断学校虚拟套餐是否开启
				 * 1.2.判断学校虚拟套餐是否开启： 开启-->所有人正常发送 ， 未开启--->判断面向学校且类型是单条的套餐是否有
				 * 1.2.2.判断面向学校且类型是单条的套餐是否有： 有-->判断条数是否>0 是: 可以发送
				 * 否:学生判断是否有购买服务费： 没有：不发， 购买：判断的条数是否大于0或是否在有效期内 是发送 否不发; 教师不发送
				 * 没有-->:学生判断是否有购买服务费： 没有：不发， 购买：判断的条数是否大于0或是否在有效期内 是发送 否不发;
				 * 教师直接发送
				 */
				
				if(smsCount < 1){
					if(mode == 0) //教师
					{
						
						sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user, receiver,receiver, smsId,content,sendTime,smsDetail,smsSum, 
								count, errorSmsSum);
					}else if (mode == 1) //学生
					{
						/*
						 * TODO 目前这个功能只对蕉城实验小学和RICHX使用
						 * 	需要增加判断如果是两个家长的话，只发其中登录过亦信家长的短信(如果家长要求两个号码都能接收，在页面中设置即可)
						 *  需要判断条件是
						 *  1.如果只有一个家长的话正常发送
						 *  2.如果两个家长的话选择其中一个家长
						 *  	2.1如果两家长中只要有一个是教职工，那两个家长都发送
						 *  	2.2如果两个都是普通家长，选择登录亦信次数超过0,两个家长没有登录的选择其中一个家长
						 */
						if(!CollectionUtils.isEmpty(parentList)){
							if("3509020027".equals(schoolId) || "3201140009".equals(schoolId)){
								List<User> parentTmpList = new ArrayList<User>(); 
								if(parentList.size() < 2)
								{
									parentTmpList.addAll(parentList);
								}else{
									boolean isParent1Send = false;
									boolean isParent2Send = false;
									boolean isParent1SetRecive = false;//家长是否开启接收短信
									boolean isParent2SetRecive = false;//家长是否开启接收短信
									int parent1Count = 0;//家长1登录次数
									int parent2Count = 0;//家长2登录次数
									int parent1IsDefalutUserName = 0;//家长1是否是默认亦信号0:是 1:不是
									int parent2IsDefalutUserName = 0;//家长2是否是默认亦信号0:是 1:不是
									String parent1UserName = "";//家长1亦信号
									String parent2UserName = "";//家长2亦信号
									for(int i=0;i<parentList.size();i++){
										User parent = parentList.get(i);
										if(i == 0){
											parent1Count = parent.getCount();
											parent1IsDefalutUserName = parent.getIsDefalutUserName();
											parent1UserName = parent.getUserName();
											isParent1SetRecive = parent.getIsReciveSms() == 0?true:false;
										}else if(i == 1){
											parent2Count = parent.getCount();
											parent2IsDefalutUserName = parent.getIsDefalutUserName();
											parent2UserName = parent.getUserName();
											isParent2SetRecive = parent.getIsReciveSms() == 0?true:false;
										}
										if((!StringUtil.isEmpty(parent.getBaiduChannelId())) || parent.getCount() > 0){
											if(i == 0){
												isParent1Send = true;
											}else if(i == 1){
												isParent2Send = true;
											}
										}
									}
									
									if(isParent1SetRecive || isParent2SetRecive){
										if(isParent1SetRecive){
											parentTmpList.add(parentList.get(0));
										}
										if(isParent2SetRecive){
											parentTmpList.add(parentList.get(1));
										}
									}else{
										if(isParent2Send && isParent1Send){
											//两个家长同时能接收短信的情况下
											if(parent1IsDefalutUserName !=0 && parent2IsDefalutUserName !=0){
												if((!StringUtil.isEmpty(parent1UserName)) && (!StringUtil.isEmpty(parent2UserName))){
													if(parent1Count > parent2Count){
														parentTmpList.add(parentList.get(0));
													}else{
														parentTmpList.add(parentList.get(1));
													}
												}else{
													if(!StringUtil.isEmpty(parent1UserName)){
														parentTmpList.add(parentList.get(0));
													}
													if(!StringUtil.isEmpty(parent2UserName)){
														parentTmpList.add(parentList.get(1));
													}
													if(!((!StringUtil.isEmpty(parent1UserName)) || (!StringUtil.isEmpty(parent2UserName)))){
														parentTmpList.add(parentList.get(0));
													}
												}
											}else{
												if(parent1IsDefalutUserName !=0){
													parentTmpList.add(parentList.get(0));
												}
												if(parent2IsDefalutUserName !=0){
													parentTmpList.add(parentList.get(1));
												}
												if(!(parent1IsDefalutUserName !=0 || parent2IsDefalutUserName !=0)){
													parentTmpList.add(parentList.get(0));
												}
											}
										}else
										{
											if(isParent1Send){
												parentTmpList.add(parentList.get(0));
											}
											if(isParent2Send){
												parentTmpList.add(parentList.get(1));
											}
											
											if(!(isParent1Send || isParent2Send)){
												parentTmpList.add(parentList.get(0));
											}
										}
									}
									
								}
								for(User parentTmp : parentTmpList)
								{
									smsDetail.setPhone(parentTmp.getPhone());
									receiver.setPhone(parentTmp.getPhone());
									//睢县育才学校不要加人名
									if("4114220090".equals(schoolId)||"3201140009".equals(schoolId)){
										sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user,receiver,parentTmp, smsId,content,sendTime,smsDetail,smsSum, 
												count, errorSmsSum);
									}else{
										sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user,receiver,parentTmp, smsId,"["+receiverRealName+"]"+ content,sendTime,smsDetail,smsSum, 
												count, errorSmsSum);
									}
									
								}
							}else{
								for(User parent : parentList)
								{
									smsDetail.setPhone(parent.getPhone());
									receiver.setPhone(parent.getPhone());
									//睢县育才学校不要加人名
									if("4114220090".equals(schoolId)||"3201140009".equals(schoolId)){
										sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user,receiver,parent, smsId,content,sendTime,smsDetail,smsSum, 
												count, errorSmsSum);
									}else{
										sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user,receiver,parent, smsId,"["+receiverRealName+"]"+ content,sendTime,smsDetail,smsSum, 
												count, errorSmsSum);
									}
								}
							}
						}
					}
				}else{
					if(mode == 0) //教师
					{
						// 发送短信 如果2小时内已经发送成功， 就不用发送了，
						Map<String, Object> paramMap_smsDetail = new HashMap<String, Object>();
						paramMap_smsDetail.put("phone", receiver.getPhone());
						paramMap_smsDetail.put("content", content);
						paramMap_smsDetail.put("status", 0);// 查询成功的短信
						paramMap_smsDetail.put("time", paramMap_sms.get("time"));
						Integer smsDetailCount = smsService.loadSmsDetailByReceiverIdAndContent(paramMap_smsDetail);
						if (smsDetailCount < 1)
						{
							sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user, receiver, receiver,smsId,content, sendTime, smsDetail, smsSum, 
									count, errorSmsSum);
						} else
						{
							smsDetail.setStatus(0);// 发送成功
							addSmsDetail(smsDetail, smsId, smsSum, errorSmsSum);
						}
					}else if (mode == 1) //学生
					{						
						/*
						 * TODO 目前这个功能只对蕉城实验小学和RICHX使用
						 * 	需要增加判断如果是两个家长的话，只发其中登录过亦信家长的短信(如果家长要求两个号码都能接收，在页面中设置即可)
						 *  需要判断条件是
						 *  1.如果只有一个家长的话正常发送
						 *  2.如果两个家长的话选择其中一个家长
						 *  	2.1如果两家长中只要有一个是教职工，那两个家长都发送
						 *  	2.2如果两个都是普通家长，选择登录亦信次数超过0,两个家长没有登录的选择其中一个家长
						 */
						if(!CollectionUtils.isEmpty(parentList)){
							if("3509020027".equals(schoolId) || "3201140009".equals(schoolId)){
								List<User> parentTmpList = new ArrayList<User>(); 
								if(parentList.size() < 2)
								{
									parentTmpList.addAll(parentList);
								}else{
									boolean isTeacher = false;
									boolean isParent1Send = false;
									boolean isParent2Send = false;
									boolean isParent1SetRecive = false;//家长是否开启接收短信
									boolean isParent2SetRecive = false;//家长是否开启接收短信
									int parent1Count = 0;
									int parent2Count = 0;
									int parent1IsDefalutUserName = 0;//家长1是否是默认亦信号0:是 1:不是
									int parent2IsDefalutUserName = 0;//家长2是否是默认亦信号0:是 1:不是
									String parent1UserName = "";//家长1亦信号
									String parent2UserName = "";//家长2亦信号
									for(int i=0;i<parentList.size();i++){
										User parent = parentList.get(i);
										List<Role> roleList = parent.getRoleList();
										for(Role role : roleList){
											String roleCode = role.getRoleCode();
											if((!"student".equals(roleCode)) && (!"parent".equals(roleCode))){
												//说明是教职工
												isTeacher = true;
												break;
											}
										}
										if(i == 0){
											parent1Count = parent.getCount();
											parent1IsDefalutUserName = parent.getIsDefalutUserName();
											parent1UserName = parent.getUserName();
											isParent1SetRecive = parent.getIsReciveSms() == 0?true:false;
										}else if(i == 1){
											parent2Count = parent.getCount();
											parent2IsDefalutUserName = parent.getIsDefalutUserName();
											parent2UserName = parent.getUserName();
											isParent2SetRecive = parent.getIsReciveSms() == 0?true:false;
										}
										if((!StringUtil.isEmpty(parent.getBaiduChannelId())) || parent.getCount() > 0){
											if(i == 0){
												isParent1Send = true;
											}else if(i == 1){
												isParent2Send = true;
											}
										}
									}
									if(isTeacher){
										parentTmpList.addAll(parentList);
									}else{
										if(isParent1SetRecive || isParent2SetRecive){
											if(isParent1SetRecive){
												parentTmpList.add(parentList.get(0));
											}
											if(isParent2SetRecive){
												parentTmpList.add(parentList.get(1));
											}
										}else{
											if(isParent2Send && isParent1Send){
												//两个家长同时能接收短信的情况下
												if(parent1IsDefalutUserName !=0 && parent2IsDefalutUserName !=0){
													if((!StringUtil.isEmpty(parent1UserName)) && (!StringUtil.isEmpty(parent2UserName))){
														if(parent1Count > parent2Count){
															parentTmpList.add(parentList.get(0));
														}else{
															parentTmpList.add(parentList.get(1));
														}
													}else{
														if(!StringUtil.isEmpty(parent1UserName)){
															parentTmpList.add(parentList.get(0));
														}
														if(!StringUtil.isEmpty(parent2UserName)){
															parentTmpList.add(parentList.get(1));
														}
														if(!((!StringUtil.isEmpty(parent1UserName)) || (!StringUtil.isEmpty(parent2UserName)))){
															parentTmpList.add(parentList.get(0));
														}
													}
												}else{
													if(parent1IsDefalutUserName !=0){
														parentTmpList.add(parentList.get(0));
													}
													if(parent2IsDefalutUserName !=0){
														parentTmpList.add(parentList.get(1));
													}
													if(!(parent1IsDefalutUserName !=0 || parent2IsDefalutUserName !=0)){
														parentTmpList.add(parentList.get(0));
													}
												}
											}else
											{
												if(isParent1Send){
													parentTmpList.add(parentList.get(0));
												}
												if(isParent2Send){
													parentTmpList.add(parentList.get(1));
												}
												
												if(!(isParent1Send || isParent2Send)){
													parentTmpList.add(parentList.get(0));
												}
											}
										}
									}
								}
								for(User parentTmp : parentTmpList)
								{
									smsDetail.setPhone(parentTmp.getPhone());
									receiver.setPhone(parentTmp.getPhone());
									Map<String, Object> paramMap_smsDetail = new HashMap<String, Object>();
									paramMap_smsDetail.put("phone", parentTmp.getPhone());
									paramMap_smsDetail.put("content", content);
									paramMap_smsDetail.put("status", 0);// 查询成功的短信
									paramMap_smsDetail.put("time", paramMap_sms.get("time"));
									Integer smsDetailCount = smsService.loadSmsDetailByReceiverIdAndContent(paramMap_smsDetail);
									if (smsDetailCount < 1)
									{
										//睢县育才学校不要加人名
										if("4114220090".equals(schoolId)||"3201140009".equals(schoolId)){
											sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user, receiver,parentTmp, smsId,content, sendTime, smsDetail, smsSum, 
													count, errorSmsSum);
										}else{
											sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user, receiver,parentTmp, smsId,"["+receiverRealName+"]"+content, sendTime, smsDetail, smsSum, 
													count, errorSmsSum);
										}
									} else
									{
										smsDetail.setStatus(0);// 发送成功
										addSmsDetail(smsDetail, smsId, smsSum, errorSmsSum);
									}
								}
							}else{
								for(User parent : parentList){
									smsDetail.setPhone(parent.getPhone());
									receiver.setPhone(parent.getPhone());
									Map<String, Object> paramMap_smsDetail = new HashMap<String, Object>();
									paramMap_smsDetail.put("phone", parent.getPhone());
									paramMap_smsDetail.put("content", content);
									paramMap_smsDetail.put("status", 0);// 查询成功的短信
									paramMap_smsDetail.put("time", paramMap_sms.get("time"));
									Integer smsDetailCount = smsService.loadSmsDetailByReceiverIdAndContent(paramMap_smsDetail);
									if (smsDetailCount < 1)
									{
										//睢县育才学校不要加人名
										if("4114220090".equals(schoolId)||"3201140009".equals(schoolId)){
											sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user, receiver,parent, smsId,content, sendTime, smsDetail, smsSum, 
													count, errorSmsSum);
										}else{
											sendSmsByOrdermessage(mode,schoolHasMessage,isVirtualOpen,isSchoolSingleMsg,user, receiver,parent, smsId,"["+receiverRealName+"]"+content, sendTime, smsDetail, smsSum, 
													count, errorSmsSum);
										}
									} else
									{
										smsDetail.setStatus(0);// 发送成功
										addSmsDetail(smsDetail, smsId, smsSum, errorSmsSum);
									}
								}
							}
						}
					}
				}
				
				// smsService.addSmsDetail((SmsDetail)result_paramMap.get("smsDetail"));
				//
				// // 更新总共发送条数和发送失败总条数
				// Map<String, Object> paramMap_update = new HashMap<String,
				// Object>();
				// paramMap_update.put("id", smsId);
				// paramMap_update.put("smsSum",
				// (Integer)result_paramMap.get("smsSum"));
				// paramMap_update.put("errorSmsSum",
				// (Integer)result_paramMap.get("errorSmsSum"));
				// smsService.updateSms(paramMap_update);
			} catch (Exception e)
			{
				log.error("private void send2(" + e.getMessage());
				continue;
			}
		}
		//批量推送短信
		commonService.pushMsg(piList, false);
	}

	/**
	 * 根据每个人所属服务费套餐有效期来发送信息
	 * @param mode 0:教师  1:学生
	 * @param schoolHasMessage
	 * @param isVirtualOpen
	 * @param isSchoolSingleMsg
	 * @param user
	 * @param receiver
	 * @param parent (仅仅在mode==1的时候使用)
	 * @param smsId
	 * @param content
	 * @param sendTime
	 * @param smsDetail
	 * @param smsSum
	 * @param count
	 * @param errorSmsSum
	 */
	public void sendSmsByOrdermessage(
			int mode,
			boolean schoolHasMessage,
			boolean isVirtualOpen,
			boolean isSchoolSingleMsg,
			User user, User receiver, User parent,
			int smsId,String content, String sendTime, 
			SmsDetail smsDetail, int smsSum, 
			int count, int errorSmsSum){
		
		Map<String, Object> result_paramMap = new HashMap<String, Object>();
		if (mode == 0)// 教师
		{
			if (schoolHasMessage)
			{
				if (isVirtualOpen)
				{
					// 调用短信接口
					result_paramMap = sendSmsByDB(mode,user, receiver, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
					addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
							(Integer) result_paramMap.get("errorSmsSum"));
				} else
				{
					if (isSchoolSingleMsg)
					{
						// 学校条数套餐剩余条数
						Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(user.getSchoolId());
						if (null != remainCount && remainCount > 0)
						{
							// 调用短信接口
							result_paramMap = sendSmsByDB(mode,user, receiver, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
							addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
									(Integer) result_paramMap.get("errorSmsSum"));
							orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
						} else
						{
							// "1":发送失败 "2":没有缴纳服务费
							smsDetail.setStatus(2);// 发送失败
							errorSmsSum += count;// 发送失败+1
							addSmsDetail(smsDetail, smsId, smsSum, errorSmsSum);
						}
					} else
					{
						// 调用短信接口
						result_paramMap = sendSmsByDB(mode,user, receiver, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
						addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
								(Integer) result_paramMap.get("errorSmsSum"));
					}
				}
			} else
			{
				// 调用短信接口
				result_paramMap = sendSmsByDB(mode,user, receiver, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
				addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"), (Integer) result_paramMap.get("errorSmsSum"));
			}

		} else if (mode == 1)
		{
			if (schoolHasMessage)// 学校有短信套餐
			{
				if (isVirtualOpen)// 虚拟套餐开启直接发送
				{
					// 调用短信接口
					smsDetail.setPhone(parent.getPhone());
					result_paramMap = sendSmsByDB(mode,user, parent, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
					addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
							(Integer) result_paramMap.get("errorSmsSum"));
						
				} else
				// 虚拟套餐关闭
				{
					if (isSchoolSingleMsg)// 是否有学校单条套餐 有判断条数
					{
						smsDetail.setPhone(parent.getPhone());
						// 学校条数套餐剩余条数
						Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(user.getSchoolId());
						if (null != remainCount && remainCount > 0)// 有条数且大于0
						{
							// 调用短信接口
							smsDetail.setPhone(parent.getPhone());
							result_paramMap = sendSmsByDB(mode,user, parent, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
							addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
									(Integer) result_paramMap.get("errorSmsSum"));
							orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
						} else
						// 没有学校条数套餐 判断学生是否购买短信套餐
						{
							// 先判断学生有没有购买过
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("userId", receiver.getUserId());
							map.put("status", 0);
							OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(map);
							boolean isCharge = false;
							if (messageUser != null)
							{
								if (messageUser.getType() == 0)
								{
									if (TimeUtil.nowDateIsBetween(messageUser.getStartTime(), messageUser.getEndTime()))
									{
										isCharge = true;
									} else
									{
										isCharge = false;
									}

								} else
								{
									if (messageUser.getCount() > 0)
									{
										isCharge = true;
									} else
									{
										isCharge = false;
									}
								}
							}
							
							if(!isCharge){
								List<Role> roleList = parent.getRoleList();
								for(Role role : roleList){
									if((!"student".equals(role.getRoleCode())) && (!"parent".equals(role.getRoleCode()))){
										isCharge = true;
										break;
									}
								}
							}

							if (isCharge)
							{
								// 调用短信接口
								result_paramMap = sendSmsByDB(mode,user, parent, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
								addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
										(Integer) result_paramMap.get("errorSmsSum"));
								int smscount = ((int) content.length() / 65) + 1;
								int messcount = 0;
								if (messageUser != null)
								{
									if (messageUser.getType() == 1)
									{
										// 如果短信剩余条数小于本次短信条说
										// 剩余条数为0 如果大于等于本次短信条说
										// 则本次剩余条数为原剩余条数减本次短信条数
										if (messageUser.getCount() < smscount)
										{
											messcount = 0;
										} else
										{
											messcount = messageUser.getCount() - smscount;
										}
										map.put("count", messcount);
										map.put("id", messageUser.getId());
										orderMessageService.updateOrederMessageUserCount(map);

									}

									OrderUserMessageDetail messDetail = new OrderUserMessageDetail();
									messDetail.setCount(count);
									messDetail.setMessageId(messageUser.getMessageId());
									messDetail.setMessUserId(messageUser.getId());
									messDetail.setNowCount(messcount);
									messDetail.setOrgCount(messageUser.getCount());
									messDetail.setType(messageUser.getType());
									messDetail.setUserId(messageUser.getUserId());
									orderMessageService.addOrderUserMessageDetail(messDetail);
								}
							} else
							{
								// "1":发送失败 "2":没有缴纳服务费
								smsDetail.setStatus(2);// 发送失败
								errorSmsSum += count;// 发送失败+1
								addSmsDetail(smsDetail, smsId, smsSum, errorSmsSum);
							}
						}
							
					} else
					// 没有学校单条套餐的话判断学生是否购买服务费
					{
						smsDetail.setPhone(parent.getPhone());
						boolean isCharge = false;
						// 先判断学生有没有购买过
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("userId", receiver.getUserId());
						map.put("status", 0);
						OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(map);
						
						if (messageUser != null)
						{
							if (messageUser.getType() == 0)
							{
								if (TimeUtil.nowDateIsBetween(messageUser.getStartTime(), messageUser.getEndTime()))
								{
									isCharge = true;
								} else
								{
									isCharge = false;
								}

							} else
							{
								if (messageUser.getCount() > 0)
								{
									isCharge = true;
								} else
								{
									isCharge = false;
								}
							}
						}
						
						//是否教职工子女
						if(!isCharge){
							List<Role> roleList = parent.getRoleList();
							for(Role role : roleList){
								if((!"student".equals(role.getRoleCode())) && (!"parent".equals(role.getRoleCode()))){
									isCharge = true;
									break;
								}
							}
						}
						

						if (isCharge)
						{
							// 调用短信接口
							smsDetail.setPhone(parent.getPhone());
							result_paramMap = sendSmsByDB(mode,user, parent, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
							addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
									(Integer) result_paramMap.get("errorSmsSum"));
							int smscount = ((int) content.length() / 65) + 1;
							int messcount = 0;
							if (messageUser != null)
							{
								if (messageUser.getType() == 1)
								{
									// 如果短信剩余条数小于本次短信条说 剩余条数为0
									// 如果大于等于本次短信条说
									// 则本次剩余条数为原剩余条数减本次短信条数
									if (messageUser.getCount() < smscount)
									{
										messcount = 0;
									} else
									{
										messcount = messageUser.getCount() - smscount;
									}
									map.put("count", messcount);
									map.put("id", messageUser.getId());
									orderMessageService.updateOrederMessageUserCount(map);

								}

								OrderUserMessageDetail messDetail = new OrderUserMessageDetail();
								messDetail.setCount(count);
								messDetail.setMessageId(messageUser.getMessageId());
								messDetail.setMessUserId(messageUser.getId());
								messDetail.setNowCount(messcount);
								messDetail.setOrgCount(messageUser.getCount());
								messDetail.setType(messageUser.getType());
								messDetail.setUserId(messageUser.getUserId());
								orderMessageService.addOrderUserMessageDetail(messDetail);
							}
						} else
						{
							// "1":发送失败 "2":没有缴纳服务费
							smsDetail.setStatus(2);// 发送失败
							errorSmsSum += count;// 发送失败+1
							addSmsDetail(smsDetail, smsId, smsSum, errorSmsSum);
						}
					}
				}
			} else
			// 学校无短信套餐 直接发送
			{
				// 调用短信接口
				smsDetail.setPhone(parent.getPhone());
				result_paramMap = sendSmsByDB(mode,user, parent, content, sendTime, smsDetail, smsSum, count, errorSmsSum);
				addSmsDetail((SmsDetail) result_paramMap.get("smsDetail"), smsId, (Integer) result_paramMap.get("smsSum"),
						(Integer) result_paramMap.get("errorSmsSum"));
			}
		}
	}
	
	/**
	 * 封装保存到发送详情方法，并且更新实时更新发送总数
	 * @param smsDetail
	 * @param smsId
	 * @param smsSum
	 * @param errorSmsSum
	 */
	public void addSmsDetail(SmsDetail smsDetail, int smsId, int smsSum, int errorSmsSum)
	{
		try
		{
			smsService.addSmsDetail(smsDetail);

			// 更新总共发送条数和发送失败总条数
			Map<String, Object> paramMap_update = new HashMap<String, Object>();
			paramMap_update.put("id", smsId);
			paramMap_update.put("smsSum", smsSum);
			paramMap_update.put("errorSmsSum", errorSmsSum);
			smsService.updateSms(paramMap_update);
		} catch (Exception e)
		{
			log.error("SmsControl.addSmsDetail:" + e.getMessage());
		}
	}

	/**
	 * 封装发送短信方法
	 * @param user
	 * @param receiver
	 * @param content
	 * @param sendTime
	 * @param smsDetail
	 * @param smsSum
	 * @param count
	 * @param errorSmsSum
	 * @return
	 */
	public Map<String, Object> sendSmsByDB(int mode,User user, User receiver, String content, String sendTime, SmsDetail smsDetail, int smsSum, int count, int errorSmsSum)
	{
		// 调用短信接口
		try
		{
			boolean flag = false;
			if(mode == 0 ){
				//推送信息不在这里发送
//				flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TEACHERPUSH, receiver.getPhone(), receiver.getUserId(), content, sendTime, 3);.
				flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TEACHERPUSH, receiver.getPhone(), receiver.getUserId(), content, sendTime, 2);
			}else if(mode == 1){
				//推送信息不在这里发送
//				flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.STUDENTPUSH, receiver.getPhone(), receiver.getUserId(), content, sendTime, 3);
				flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.STUDENTPUSH, receiver.getPhone(), receiver.getUserId(), content, sendTime, 2);
			}
			if (flag)
			{
				smsDetail.setStatus(0);// 发送成功
				smsSum += count;
			} else
			{
				// "0":发送失败 "1":没有缴纳服务费
				smsDetail.setStatus(1);// 发送失败
				errorSmsSum += count;// 发送失败+1
			}

		} catch (Exception e)
		{
			log.error("private void send(" + e.getMessage());
			smsDetail.setStatus(1);// 发送失败
			errorSmsSum += count;// 发送失败+1
		}

		// 更新总共发送条数和发送失败总条数
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("smsDetail", smsDetail);
		paramMap.put("smsSum", smsSum);
		paramMap.put("errorSmsSum", errorSmsSum);

		return paramMap;
	}

	/**
	 * 查看历史发送短信列表
	 */
	@RequestMapping(value = "/toSmsList.do")
	public String toSmsList()
	{
		return "sms/sms_list";
	}

	/**
	 * 加载历史发送短信列表
	 */
	@RequestMapping(value = "/loadSmsList.do")
	public String loadSmsList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try
		{

			/**
			 * 查询类型
			 */
			String queryContent = String.valueOf(request.getParameter("queryContent"));
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

			String roleCode = request.getParameter("roleCode");

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("queryContent", queryContent);

			Pages pages = smsService.loadSmsList(this.getPages().getPageSize(), currentPage, paramMap, user);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}
		return null;
	}

	/**
	 * 进入信息详情页面20151203
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toSmsDetailView.do")
	public String toSmsDetailView(HttpServletRequest request, ModelMap modelMap)
	{
		Integer id = Integer.valueOf(request.getParameter("id"));

		Integer type = null;
		try
		{
			type = Integer.valueOf(request.getParameter("type"));
		} catch (Exception e)
		{
			type = null;
		}

		modelMap.put("id", id);

		if (type == 2)
		{
			return "sms/scoreSendingSms_detail";
		} else
		{

			return "sms/sms_list_Message_detailinfo";
		}
	}

	/**
	 * 查询 发送信息查看的详细信息 20151203
	 */
	@RequestMapping(value = "/loadSmsDetail.do")
	public String loadSmsDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Integer id = Integer.parseInt(request.getParameter("messageId"));

		List<SmsDetail> message = smsService.loadSmsDetail(id);

		/**
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(message);
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
	 * 一键购买服务费
	 * 
	 * @author chenyong
	 * @date 2016年11月2日 下午3:04:57
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/autoBuySmsService.do")
	@ResponseBody
	public void autoBuySmsService(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		User user = (User) session.getAttribute("user");
		int serverPort = request.getServerPort();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if (user != null)
		{
			String schoolId = user.getSchoolId();
			paramMap.put("schoolId", schoolId);
			// 获取所有未购买短信套餐和卡押金未支付的学生
			List<User> studentList = userService.getNotPurchaseStudentList(schoolId);
			PUSHTYPE pushtype = PUSHTYPE.SYSANNOUNCEMENTPUSH;
			if (!CollectionUtils.isEmpty(studentList))
			{
				for (User student : studentList)
				{
					String goodsName =student.getOrderMessageName();
					Integer productId=student.getOrderMessage();
					List<Integer> listStudent=new ArrayList<>();
					listStudent.add(student.getUserId());
					List<User> parentsInfo = userService.getParentIsTeacher(listStudent);
					double price=0;
					if(student.getType().intValue()==0){//没有买服务费
						
						if(parentsInfo!=null&&parentsInfo.size()>0){
							//教职工子女免服务费
						}else{
							//非教职工子女，服务费不免费
							price+=student.getServicePrice();	
						}
					}
					if(student.getCardPrice()>0 && student.getCardPay().intValue()==0){
						price+=student.getCardPrice();	//卡押金没有支付
					}
					paramMap.put("price", price);
					paramMap.put("studentId", student.getUserId());
					List<User> parentList = userService.getUserAccountMoreThanPrice(paramMap);
					if (!CollectionUtils.isEmpty(parentList))
					{
						HashMap<String, String> param;
						for (User parent : parentList)
						{
							try
							{
								param = new HashMap<String, String>();
								String pushUrl = HttpPostUtil.getWisdomCampusUrl(serverPort) + "orderMessage/toOrderMessagePayByApiKey.do?schoolId=" + schoolId + "&apiKey="
										+ parent.getApiKey() + "&productId=" + productId + "&studentId=" + student.getUserId() + "&realName=" + student.getRealName();// 下单
								String str = HttpUtil.doGet(pushUrl);
								JSONObject jsonObj = new JSONObject(str);
								if (jsonObj.get("ResponseCode").toString().equals("0"))
								{// 下单成功
									jsonObj = new JSONObject(jsonObj.get("ResponseObject").toString());
									String ordersId = jsonObj.get("ordersId").toString();
									pushUrl = HttpPostUtil.getRichBookUrl() + "userAccount/toPersonalWalletApp.do";
									param.put("amount", price + "");
									param.put("apiKey", parent.getApiKey());
									param.put("orderId", ordersId);
									param.put("goodsName", goodsName);
									param.put("payPassword", parent.getPassword());
									str = HttpPostUtil.postByForm(pushUrl, param);
									jsonObj = new JSONObject(str);
									if (jsonObj.get("ResponseCode").toString().equals("0"))
									{
										String content = student.getRealName() + "家长您好:您充值的" +price+ "已成功购买智慧校园服务费和卡押金，请放心使用！";
										// 购买成功发送短信xxx家长您好，您充值的80元已成功购买智慧校园服务费，请放心使用！
										boolean flag = commonService.sendSmsByDB(schoolId, pushtype, parent.getPhone(), parent.getUserId(), content, null, 1);
										if (flag)
										{
											smsService.saveSmsDetail(content, student, parent, 0, "10");
										} else
										{
											smsService.saveSmsDetail(content, student, parent, 1, "10");
										}
										break;
									}
								} else
								{
									continue;
								}
							} catch (Exception e)
							{
								e.printStackTrace();
								continue;
							}
						}
					}
				}
			}
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return;
	}

	/**
	 * 一键通知智慧校园服务费缴纳
	 * 
	 * @param request
	 * @param response
	 * @param session
	 */
	@RequestMapping("/autoPaymentNotice.do")
	@ResponseBody
	public String autoPaymentNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		User user = (User) session.getAttribute("user");
		try
		{
			String schoolId = user.getSchoolId();

			// 获取所有未购买短信套餐的学生
			List<User> studentList = userService.getNotPurchaseStudentList(schoolId);
			// 获取前台传递的短信通知内容
			String messageContent = request.getParameter("content");
			// String messageContent =
			// "家长您好，您小孩的智慧校园服务费尚未支付，为了不影响智慧校园正常使用，可以通过三种方式支付：1.在公司官网www.richx.cn下载“亦信”；在我的钱包中购买服务费(登录名和初始密码为您接收学校短信的手机号码);2.请本班学生家长或班主任请他们代支付;3.可以带现金给公司游经理15980551212请他代充。未支付将不能收到学校下发的信息和重要通知。感谢您的支持！";
			if (!CollectionUtils.isEmpty(studentList))
			{
				// 下面启用线程发送正常短息
				final List<User> receiverListFinal = studentList;
				final String contentFinal = messageContent;
				final User userFinal = user;
				new Thread(new Runnable()
				{
					public void run()
					{
						try
						{
							User user = userFinal;
							DBContextHolder.setDBType(user.getSchoolId());
							sendPaymentNotice(user, contentFinal, receiverListFinal);
						} catch (Exception e)
						{
							log.error("发送短信失败,接收人id：" + userFinal.getUserId() + "\r\n" + e);
						}
					}
				}).start();
			}

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 发送服务费通知信息
	 * 
	 * @param user
	 * @param content
	 * @param receiverList
	 */
	private void sendPaymentNotice(User user, String content, List<User> receiverList)
	{
		Map<String, Object> paramMap_sms = new HashMap<String, Object>();

		String sendTime = formatter.format(new Date());
		// 保存到sms表中
		Sms sms = new Sms();
		sms.setContent(content);
		sms.setSenderId(user.getUserId());
		sms.setSenderName(user.getRealName());
		sms.setSmsLength(content.length()); // 短信长度
		sms.setPhoneCount(receiverList.size()); // 发送人数
		sms.setResult(0);// 短信回执状态
		sms.setReportAmount(0);
		sms.setSuccAmount(0);
		sms.setCreateTime(TimeUtil.getInstance().now());
		sms.setIsRealTime(Cons.SMS_REALTIME);// 1:即时发送
		sms.setSentTime(sendTime);
		sms.setType("1"); // 0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知
		sms.setModule(Cons.MODULE_STUDENTSERVICE); // 学生短信服务

		Integer smsCount = 0;
		try
		{
			// 先查找2小时内是否发过该短信,超过可以重发, 要是不超过判断如果是同一个人就发送短信
			paramMap_sms.put("content", content);
			paramMap_sms.put("time", formatter.format((formatter.parse(sendTime).getTime() - 2 * 60 * 60 * 1000)));
			smsCount = smsService.loadSmsByContent(paramMap_sms);
		} catch (ParseException e1)
		{
			e1.printStackTrace();
		}

		// 获取数据库中最新一条数据的短信总数smsSum 和 errorSmsSum
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Sms lastSms = smsService.getLastOneFromSms(paramMap);
		int smsSum = 0; // 短信发送总数
		try
		{
			smsSum = lastSms.getSmsSum();
		} catch (Exception e)
		{

		}
		int errorSmsSum = 0; // 短信发送总数
		try
		{
			errorSmsSum = lastSms.getErrorSmsSum();
		} catch (Exception e)
		{

		}
		sms.setSmsSum(smsSum);
		sms.setErrorSmsSum(errorSmsSum);
		// 保存到数据库, 并且返回smsId
		int smsId = smsService.addSms(sms);
		// int count = (int)Math.ceil(content.length()/65);
		int count = ((int) content.length() / 65) + 1;
		
		List<PushItem> piList = new ArrayList<PushItem>();
		String schoolId = user.getSchoolId(); 
		for (User receiver : receiverList)
		{
			try
			{
				SmsDetail smsDetail = new SmsDetail();
				smsDetail.setContent(content);
				smsDetail.setSenderId(user.getUserId());
				smsDetail.setSenderName(user.getRealName());
				smsDetail.setReceiverId(receiver.getUserId());
				smsDetail.setPhone(receiver.getPhone());
				smsDetail.setReceiverName(receiver.getRealName());
				smsDetail.setSeq("");
				smsDetail.setReport("");
				smsDetail.setSmsId(smsId);
				smsDetail.setReportTime(TimeUtil.getInstance().now());
				smsDetail.setCreateTime(TimeUtil.getInstance().now());
				smsDetail.setType(sms.getType());
				smsDetail.setSentTime(sendTime);

				List<User> parentList = commonService.getParentByStudentId(receiver.getUserId());
				if (!CollectionUtils.isEmpty(parentList))
				{
					for (User parent : parentList)
					{
						PushItem pi = new PushItem();
						pi.title = PUSHTYPE.BUYSERVICEFEE.getName();
						pi.PushContent = content;
						pi.PushType = PUSHTYPE.BUYSERVICEFEE.getType();
						pi.PushContentType = PUSHTYPE.BUYSERVICEFEE.getContentType();
						String channelId = parent.getBaiduChannelId();
						Integer deviceType = parent.getDeviceType();
						if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
						{
							pi.channels = channelId;
							pi.deviceType = String.valueOf(deviceType);
						}
						pi.receiverId = parent.getUserId();
						pi.schoolId = schoolId;
						piList.add(pi);
						
						smsDetail.setPhone(parent.getPhone());
						receiver.setPhone(parent.getPhone());
						boolean flag = false;						
						if (smsCount < 1)
						{
							flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.BUYSERVICEFEE, parent.getPhone(), parent.getUserId(), content, sendTime, 2);//3-->2,因为推送批量提交
						}else{
							// 发送短信 如果2小时内已经发送成功， 就不用发送了，
							Map<String, Object> paramMap_smsDetail = new HashMap<String, Object>();
							paramMap_smsDetail.put("phone", receiver.getPhone());
							paramMap_smsDetail.put("content", content);
							paramMap_smsDetail.put("status", 0);// 查询成功的短信
							paramMap_smsDetail.put("time", paramMap_sms.get("time"));
							Integer smsDetailCount = smsService.loadSmsDetailByReceiverIdAndContent(paramMap_smsDetail);
							if (smsDetailCount < 1)
							{
								flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.BUYSERVICEFEE, parent.getPhone(), parent.getUserId(), content, sendTime, 2);//3-->2,因为推送批量提交
							}else{
								smsDetail.setStatus(0);// 发送成功
								smsService.addSmsDetail(smsDetail);
								continue;
							}
						}
						// 调用短信接口
						try
						{
							if (flag)
							{
								smsDetail.setStatus(0);// 发送成功
								smsSum += count;
								smsService.addSmsDetail(smsDetail);
							} else
							{
								smsDetail.setStatus(1);// 发送失败
								errorSmsSum += count;// 发送失败+1
								smsService.addSmsDetail(smsDetail);
							}
						} catch (Exception e)
						{
							log.error("private void send(" + e.getMessage());
							smsDetail.setStatus(1);// 发送失败
							errorSmsSum += count;// 发送失败+1
							smsService.addSmsDetail(smsDetail);
							continue;
						}
					}
				}

				// 更新总共发送条数和发送失败总条数
				Map<String, Object> paramMap_update = new HashMap<String, Object>();
				paramMap_update.put("id", smsId);
				paramMap_update.put("smsSum", smsSum);
				paramMap_update.put("errorSmsSum", errorSmsSum);
				smsService.updateSms(paramMap_update);
				
				//批量提交推送
				commonService.pushMsg(piList, false);
			} catch (Exception e)
			{
				log.error("private void send2(" + e.getMessage());
				continue;
			}
		}
	}

	/**
	 * 智慧校园补办卡通知
	 * 
	 * @param request
	 * @param response
	 * @param session
	 */
	@RequestMapping("/cardApplyNotice.do")
	@ResponseBody
	public String cardApplyNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		User user = (User) session.getAttribute("user");
		try
		{
			String schoolId = user.getSchoolId();

			String todayBegin = TimeUtil.getInstance().getBeforeWeek();// 今天00:00:00
			String todayEnd = TimeUtil.getInstance().getTodayBegin();// 今天23:59:59

			// 获取前台传递的短信通知内容
			String messageContent = request.getParameter("content");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schoolId", schoolId);
			map.put("todayBegin", todayBegin);
			map.put("todayEnd", todayEnd);
			// 获取今天没有打卡的所有学生
			List<User> studentList = studentService.getNoInoutStudentListByDate(map);

			if (!CollectionUtils.isEmpty(studentList))
			{
				// 下面启用线程推送信息
				final List<User> receiverListFinal = studentList;
				final String contentFinal = messageContent;
				final User userFinal = user;
				final String schoolIdinal = schoolId;
				new Thread(new Runnable()
				{
					public void run()
					{
						try
						{
							DBContextHolder.setDBType(schoolIdinal);
							List<PushItem> piList = new ArrayList<PushItem>();
							for (User student : receiverListFinal)
							{
								try{
									List<User> parentList = commonService.getParentByStudentId(student.getUserId());
									for (User parent : parentList)
									{
										PushItem pi = new PushItem();
										pi.receiverId = parent.getUserId();
										pi.channels = parent.getBaiduChannelId();
										pi.deviceType = String.valueOf(parent.getDeviceType());
										pi.PushContent = contentFinal;
										pi.PushType = PUSHTYPE.CARDAPPLY.getType();
										pi.PushContentType = PUSHTYPE.CARDAPPLY.getContentType();
										pi.title = PUSHTYPE.CARDAPPLY.getName();
										pi.schoolId = schoolIdinal;
										piList.add(pi);
									}
								}catch(Exception e){
									log.error("推送信息添加到piList中,接收人id：" + userFinal.getUserId() + "\r\n" + e);
									continue;
								}
							}
							if (!CollectionUtils.isEmpty(piList))
							{
								commonService.pushMsg(piList, false);// 消息推送
							}
						} catch (Exception e)
						{
							log.error("推送信息失败,接收人id：" + userFinal.getUserId() + "\r\n" + e);
						}
					}
				}).start();
			}

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

}
