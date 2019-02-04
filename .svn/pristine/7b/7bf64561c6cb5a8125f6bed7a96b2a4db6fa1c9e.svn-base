package com.guotop.palmschool.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.check.entity.CheckAttendance;
import com.guotop.palmschool.check.service.CheckService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Leave;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.OrderUserMessageDetail;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserRole;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.LeaveService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.SmsService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.system.entity.InformationType;
import com.guotop.palmschool.system.service.InformationTypeService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 请假控制类
 * 
 * @author zhou
 *
 */
@RequestMapping("/leave")
@Controller
public class LeaveController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(LeaveController.class);
	@Resource
	private CommonService commonService;

	@Resource
	private LeaveService leaveService;

	@Resource
	private UserService userService;

	@Resource
	private SchoolService schoolService;

	@Resource
	private InformationTypeService informationTypeService;

	@Resource
	private SmsService smsService;

	@Resource
	private OrderMessageService orderMessageService;

	@Resource
	private CheckService checkService;
	
	@Resource
	private ScheduleService scheduleService;
	
	@Resource
	private ClazzService clazzService;
	
	@Resource
	private DepartmentService departmentService;
	
	@Autowired
	private ThreadPoolTaskExecutor poolTaskExecutor;
	
	
	/**
	 * 进入请假列表页面
	 */
	@RequestMapping(value = "/toLeaveList.do")
	public String toLeaveList()
	{
		return "leave/leave_list";
	}

	/**
	 * 不同权限查看到不同的page 历史请假列表 加载请假list 20151130
	 */
	@RequestMapping(value = "/getLeaveList.do")
	public String getLeaveList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try
		{
			//分页信息
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
			Pages pages = leaveService.getLeaveList(this.getPages().getPageSize(), currentPage, paramMap);

			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
		}
		return null;
	}

	/**
	 * 获取假条详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getLeaveDetail.do")
	public String getLeaveDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{		
		response.setCharacterEncoding("UTF-8");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			Integer leaveId = Integer.valueOf(request.getParameter("leaveId"));
			Leave leave = leaveService.selectLeaveById(leaveId);

			String json = GsonHelper.toJson(leave);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("获取假条详情失败：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 进入申请请假页面
	 * 
	 * 20151130
	 */
	@RequestMapping(value = "/toAddLeave.do")
	public String toAddLeave(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");
		String roleCode = request.getParameter("roleCode");
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("roleCode", roleCode);

		return "leave/leave_add";
	}

	/**
	 * 执行请假申请逻辑 20151130
	 */
	@RequestMapping(value = "/doAddLeave.do")
	public String doAddLeave(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		User login = (User) session.getAttribute("user");

		School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(login.getSchoolId()));
		//开始时间
		String startTime = request.getParameter("startTime");
		//结束时间
		String endTime = request.getParameter("endTime");
		//请假类型
		String type = request.getParameter("type");
		//请假事由
		String remark = request.getParameter("remark");
		//审核人
		Integer auditId = Integer.valueOf(request.getParameter("auditId"));
		//申请人
		Integer applyUserId = Integer.valueOf(request.getParameter("applyUserId"));
		//申请人角色
		String roleCode = request.getParameter("roleCode");
		
		int resultCode = TimeUtil.compare_date(startTime,endTime);
		if(resultCode < 0)
		{
			return toLeaveList();
		}
		
		Leave leave = new Leave();
		leave.setStartTime(startTime);
		leave.setEndTime(endTime);
		leave.setType(Integer.valueOf(type));
		leave.setRemark(remark);
		leave.setApplyUserId(applyUserId);
		leave.setAuditId(auditId);

		Integer leaveId = leaveService.addLeave(leave);
		// 申请人信息
		User applyUser = leaveService.getUserInfoByUserId(applyUserId);
		// 消息推送
		User auditor = leaveService.getUserInfoByUserId(auditId);

		PushItem pi = new PushItem();
		pi.receiverId = auditor.getUserId();
		pi.channels = auditor.getBaiduChannelId();
		pi.deviceType = String.valueOf(auditor.getDeviceType());
		if ("student".equals(roleCode) || "parent".equals(roleCode))
		{
			pi.PushContent = "您好,您的学生" + applyUser.getRealName() + "于" + TimeUtil.getInstance().now() + "提出请假申请，请及时处理。" + school.getSchoolName();
		} else
		{
			pi.PushContent = "您好," + applyUser.getRealName() + "老师于" + formatter.format(new Date()) + "提出请假申请，请及时处理。" + school.getSchoolName();
		}

		pi.PushContentType = PUSHTYPE.LEAVEAUDITPUSH.getContentType();
		pi.title = PUSHTYPE.LEAVEAUDITPUSH.getName();
		pi.PushType = PUSHTYPE.LEAVEAUDITPUSH.getType();
		pi.schoolId = login.getSchoolId();
		pi.OperationapplyId = leaveId;

		InformationType informationType = informationTypeService.getInformationTypeByInformationType(2001);
		sendMsgOrPushMsgInAddLeave(auditor,school,pi,informationType);

		return toLeaveList();
	}

	/**
	 * 进入请假审核列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLeaveAudit.do")
	public String toLeaveAudit()
	{
		return "leave/leave_auditlist";
	}

	
	/**
	 * 进入请假审核列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLeaveAuditByHuxinId.do")
	public String toLeaveAuditByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			session.setAttribute("user", loginUser);

			List<Permission> permissionList = loginUser.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("leaveAuditManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					return "leave/leave_auditlist";
				}
			}
		}
		return null;

	}

	/**
	 * 不同权限查看到不同的page 历史请假审核列表 加载请假审核list 20151130
	 */
	@RequestMapping(value = "/getLeaveAuditList.do")
	public String getLeaveAuditList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			User user = (User) session.getAttribute("user");

			/**
			 * 查询审核者ID为自己的请假信息
			 */
			paramMap.put("userId", user.getUserId());
			paramMap.put("auditId", user.getUserId());
			Pages pages = leaveService.getLeaveAuditList(this.getPages().getPageSize(), currentPage, paramMap);
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
	 * 进入请假审核页面 20151130
	 */
	@RequestMapping(value = "/toAuditLeave.do")
	public String toAuditLeave(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		//请假单ID
		Integer leaveId = Integer.valueOf(request.getParameter("leaveId"));
		Leave leave = leaveService.selectLeaveById(leaveId);
		User user = (User) session.getAttribute("user");

		/**
		 * 回写页面
		 */
		//审核人
		modelMap.addAttribute("user", user);
		//请假单
		modelMap.addAttribute("leave", leave);

		return "leave/leave_audit";
	}

	/**
	 * 获取申请人名单 
	 */
	@RequestMapping(value = "/getApplyPerson.do")
	public String getApplyPerson(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		//请假人Id
		Integer userId = Integer.valueOf(request.getParameter("userId"));
		//请假人对应的角色
		String roleCode = request.getParameter("roleCode");
		List<User> userList = new ArrayList<User>();
		if (roleCode.equals("parent"))
		{
			// 如果是家长 获得对应的孩子信息
			List<User> childrenList = commonService.getAllChildrenByUserId(userId);
			userList.addAll(childrenList);
		}
		if (!roleCode.equals("parent"))
		{
			// 如果不是家长 就获取自己的信息
			List<User> selfList = commonService.getUserByUserId(userId);
			userList.addAll(selfList);
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(userList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 获取审核人名单 20151130
	 */
	@RequestMapping(value = "/getAuditPerson.do")
	public String getAuditPerson(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		//请假人Id
		Integer applyPersonId = Integer.valueOf(request.getParameter("applyPersonId"));
		//请假人对应的角色
		String roleCode = request.getParameter("roleCode");
		List<User> userList = null;
		if (roleCode.equals("parent") || roleCode.equals("student"))
		{
			// 如果是家长和学生 根据申请人Id 查找对应的班级Id 找到对应的请假审核人
			userList = leaveService.getAuditPersonByApplyPersonIdFromParentOrStudent(applyPersonId);
		} else
		{
			// 如果不是家长和学生 根据申请人Id 查找对应学校请假审核人
			userList = leaveService.getAuditPersonByApplyPersonId(applyPersonId);
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(userList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}
	

	/**
	 * 执行请假审核逻辑
	 */
	@RequestMapping(value = "/doLeaveAudit.do")
	public String doLeaveAudit(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		User login = (User) session.getAttribute("user");

		School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(login.getSchoolId()));
		//请假单ID
		Integer leaveId = Integer.valueOf(request.getParameter("leaveId"));
		//审核结果
		String auditStatus = request.getParameter("auditStatus");
		//审核备注
		String auditRemark = request.getParameter("auditRemark");
		// 申请人
		String applyUserId = request.getParameter("applyUserId");

		Leave leave = leaveService.selectLeaveById(leaveId);
		if(leave == null)
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			if (apiKey != null && !"".equals(apiKey))
			{
				request.setAttribute("apiKey", apiKey);
				request.setAttribute("schoolId", schoolId);

				return toLeaveAuditApp(request, response, session, modelMap);
			} else
			{
				return toLeaveAudit();
			}
		}
		//执行审核操作
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("leaveId", leaveId);
		paramMap.put("auditStatus", auditStatus);
		paramMap.put("auditRemark", auditRemark);

		leaveService.updateLeaveById(paramMap);

		// 消息推送
		if (!"0".equals(auditStatus))
		{
			boolean flag = auditStatus.equals("1");
			Integer informationType = null;
			PUSHTYPE pushStatesEnum;
			if (flag)
			{
				informationType = 2002;
				pushStatesEnum = PUSHTYPE.LEAVEPASSPUSH;
			} else
			{
				informationType = 2003;
				pushStatesEnum = PUSHTYPE.LEAVENOTPASSPUSH;
			}

			InformationType information = informationTypeService.getInformationTypeByInformationType(informationType);
			List<UserRole> userRole = commonService.getUserRoleByUserId(StringUtil.toint(applyUserId));
			String roleCode = "";
			if (userRole.size() > 0)
			{
				roleCode = userRole.get(0).getRoleCode();
			}
			if (roleCode.equals("student"))
			{
				List<User> parentList = leaveService.getParentInfoByStudentId(Integer.valueOf(applyUserId));
				for (User applyUser : parentList)
				{
					PushItem pi = new PushItem();
					pi.receiverId = applyUser.getUserId();
					pi.channels = applyUser.getBaiduChannelId();
					pi.deviceType = String.valueOf(applyUser.getDeviceType());
					pi.PushContent = "您好：您的请假申请" + (flag ? "审核通过" : "未通过审核") + "。" + school.getSchoolName();
					pi.PushContentType = pushStatesEnum.getContentType();
					pi.title = pushStatesEnum.getName();
					pi.PushType = pushStatesEnum.getType();
					pi.OperationapplyId = leaveId;
					
					sendMsgOrPushMsgInAudit(applyUser,Integer.valueOf(applyUserId),school,pi,information,pushStatesEnum);
				}
				
				if(flag)
				{
					try{
						Map<String,Object> map = getByStartTimeAndEnd(leave.getStartTime(),leave.getEndTime());
						List<String> scheduleDateList = (List<String>) map.get("scheduleDate");
						List<Clazz> clazzList = clazzService.getClazzListByStudentId(Integer.valueOf(applyUserId));
						if((!CollectionUtils.isEmpty(scheduleDateList)) && (!CollectionUtils.isEmpty(clazzList))){
							Integer clazzId = clazzList.get(0).getId();
							Map<String, Integer> valueMap = null;
							for(String scheduleDate : scheduleDateList){
								valueMap = (Map<String, Integer>) map.get(scheduleDate);
								if(valueMap != null){
									Integer scheduleType = valueMap.get("scheduleType");
									if(scheduleType == 0 ){
										Integer amStatus = valueMap.get("am");
										Integer pmStatus = valueMap.get("pm");
										if(amStatus != null){
											CheckAttendance checkAttendance = new CheckAttendance();
											checkAttendance.setUserId(Integer.valueOf(applyUserId));
											checkAttendance.setClazzId(clazzId);
											checkAttendance.setStatus(amStatus);
											checkAttendance.setRemark("今天请假");
											checkAttendance.setType(1);
											checkAttendance.setCreateDate(scheduleDate);
											checkService.addCheckAttendance(checkAttendance);
										}
										if(pmStatus != null){
											CheckAttendance checkAttendance = new CheckAttendance();
											checkAttendance.setUserId(Integer.valueOf(applyUserId));
											checkAttendance.setClazzId(clazzId);
											checkAttendance.setStatus(pmStatus);
											checkAttendance.setRemark("今天请假");
											checkAttendance.setType(1);
											checkAttendance.setCreateDate(scheduleDate);
											checkService.addCheckAttendance(checkAttendance);
										}
									}else{
										Integer allStatus = valueMap.get("all");
										if(allStatus != null){
											CheckAttendance checkAttendance = new CheckAttendance();
											checkAttendance.setUserId(Integer.valueOf(applyUserId));
											checkAttendance.setClazzId(clazzId);
											checkAttendance.setStatus(allStatus);
											checkAttendance.setRemark("今天请假");
											checkAttendance.setType(1);
											checkAttendance.setCreateDate(scheduleDate);
											checkService.addCheckAttendance(checkAttendance);
										}
									}
								}
							}
						}
					}catch(Exception e){
						logger.error("添加学生考勤列表的时候报错");
					}
				}
			} else
			{
				User applyUser = leaveService.getUserInfoByUserId(Integer.valueOf(applyUserId));
				PushItem pi = new PushItem();
				pi.receiverId = applyUser.getUserId();
				pi.channels = applyUser.getBaiduChannelId();
				pi.deviceType = String.valueOf(applyUser.getDeviceType());
				pi.PushContent = "您好：您的请假申请" + (flag ? "审核通过" : "未通过审核") + "。" + school.getSchoolName();
				pi.PushContentType = pushStatesEnum.getContentType();
				pi.title = pushStatesEnum.getName();
				pi.PushType = pushStatesEnum.getType();
				pi.OperationapplyId = leaveId;
				List<PushItem> list = new ArrayList<PushItem>();
				list.add(pi);

				sendMsgOrPushMsgInAudit(applyUser,Integer.valueOf(applyUserId),school,pi,information,pushStatesEnum);
				
				if(flag)
				{
					try{
						Map<String,Object> map = getByStartTimeAndEnd(leave.getStartTime(),leave.getEndTime());
						List<String> scheduleDateList = (List<String>) map.get("scheduleDate");
						List<Department> departmentList = departmentService.getDepartListByUserId(Integer.valueOf(applyUserId));
						if((!CollectionUtils.isEmpty(scheduleDateList)) && (!CollectionUtils.isEmpty(departmentList))){
							Integer departmentId = departmentList.get(0).getId();
							Map<String, Integer> valueMap = null;
							for(String scheduleDate : scheduleDateList){
								valueMap = (Map<String, Integer>) map.get(scheduleDate);
								if(valueMap != null){
									Integer scheduleType = valueMap.get("scheduleType");
									if(scheduleType == 0 ){
										Integer amStatus = valueMap.get("am");
										Integer pmStatus = valueMap.get("pm");
										if(amStatus != null){
											CheckAttendance checkAttendance = new CheckAttendance();
											checkAttendance.setUserId(Integer.valueOf(applyUserId));
											checkAttendance.setDepartmentId(departmentId);
											checkAttendance.setStatus(amStatus);
											checkAttendance.setRemark("今天请假");
											checkAttendance.setType(0);
											checkAttendance.setCreateDate(scheduleDate);
											checkService.addCheckAttendance(checkAttendance);
										}
										if(pmStatus != null){
											CheckAttendance checkAttendance = new CheckAttendance();
											checkAttendance.setUserId(Integer.valueOf(applyUserId));
											checkAttendance.setDepartmentId(departmentId);
											checkAttendance.setStatus(pmStatus);
											checkAttendance.setRemark("今天请假");
											checkAttendance.setType(0);
											checkAttendance.setCreateDate(scheduleDate);
											checkService.addCheckAttendance(checkAttendance);
										}
									}else{
										Integer allStatus = valueMap.get("all");
										if(allStatus != null){
											CheckAttendance checkAttendance = new CheckAttendance();
											checkAttendance.setUserId(Integer.valueOf(applyUserId));
											checkAttendance.setDepartmentId(departmentId);
											checkAttendance.setStatus(allStatus);
											checkAttendance.setRemark("今天请假");
											checkAttendance.setType(0);
											checkAttendance.setCreateDate(scheduleDate);
											checkService.addCheckAttendance(checkAttendance);
										}
									}
								}
							}
						}
					}catch(Exception e){
						logger.error("添加教师考勤列表的时候报错");
					}
				}
			}
			
			
		}
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		if (apiKey != null && !"".equals(apiKey))
		{
			request.setAttribute("apiKey", apiKey);
			request.setAttribute("schoolId", schoolId);

			return toLeaveAuditApp(request, response, session, modelMap);
		} else
		{
			return toLeaveAudit();
		}

	}
	
	/* 手机端begin */
	/**
	 * 进入请假列表页面（APP）
	 */
	@RequestMapping(value = "/toLeaveAppList.do")
	public String toLeaveAppList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 参数map
		 */
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
				return "app/leave/leave_list_app";
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

			String roleCode = request.getParameter("roleCode");

			if (StringUtil.isEmpty(roleCode))
			{
				roleCode = user.getRoleList().get(0).getRoleCode();
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

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);

			this.getPages().setPageSize(20);
			List<Leave> leaveList = leaveService.getLeaveListApp(this.getPages().getPageSize(), currentPage, paramMap);

			currentPage = currentPage + 1;
			modelMap.addAttribute("leaveList", leaveList);
			modelMap.addAttribute("leaveListSize", leaveList.size());
			modelMap.addAttribute("roleList", user.getRoleList());
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "app/leave/leave_list_app";
	}

	/**
	 * 不同权限查看到不同的page 历史请假列表 加载请假list 20151130
	 */
	@RequestMapping(value = "/getLeaveListApp.do")
	public String getLeaveListApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
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

			String roleCode = request.getParameter("roleCode");

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			this.getPages().setPageSize(20);
			List<Leave> leaveList = leaveService.getLeaveListApp(this.getPages().getPageSize(), currentPage, paramMap);

			currentPage = currentPage + 1;
			modelMap.addAttribute("leaveList", leaveList);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("listSize", leaveList.size());

			/**
			 * flush到页面
			 */
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
	 * 进入app请假申请页面
	 */
	@RequestMapping(value = "/toLeaveAppAdd.do")
	public String toLeaveAppAdd(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap, HttpSession session)
	{
		User user = (User) session.getAttribute("user");

		String roleCode = request.getParameter("roleCode");
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("userId", user.getUserId());
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);

		return "app/leave/leave_add_app";

	}

	/**
	 * 执行请假申请逻辑 20151130 手机端
	 */
	@RequestMapping(value = "/doAddLeaveApp.do")
	public String doAddLeaveApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		/*
		 * 开始日期
		 */
		String startTime = request.getParameter("startTime");

		/*
		 * 结束日期
		 */
		String endTime = request.getParameter("endTime");

		// /*
		// * 开始时间
		// */
		//
		// String starttime = request.getParameter("starttime");
		//
		// String endtime = request.getParameter("endtime");

		/*
		 * 请假类型
		 */
		String type = request.getParameter("type");

		/*
		 * 请假事由
		 */
		String remark = request.getParameter("remark");

		/*
		 * 审核人
		 */
		// Integer auditId = Integer.valueOf(request.getParameter("auditId"));
		Integer auditId = StringUtil.toint(request.getParameter("auditId"));

		/*
		 * 申请人
		 */
		Integer applyUserId = Integer.valueOf(request.getParameter("applyUserId"));

		// String startDate = startTime + " " + starttime;
		// String endDate = endTime + " " + endtime;
		Leave leave = new Leave();
		leave.setStartTime(startTime);
		leave.setEndTime(endTime);
		leave.setType(Integer.valueOf(type));
		leave.setRemark(remark);
		leave.setApplyUserId(applyUserId);
		leave.setAuditId(auditId);

		leaveService.addLeave(leave);

		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		request.setAttribute("apiKey", apiKey);
		request.setAttribute("schoolId", schoolId);

		return toLeaveAppList(request, response, session, modelMap);

		// return "app/leave/leave_list_app";
	}

	/**
	 * 进入APP请假审核列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLeaveAuditApp.do")
	public String toLeaveAuditApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

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
				if ("leaveAuditManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode())
						|| "leaveAuditForStudent".equals(permission.getPermissionCode()))
				{
					path = "app/leave/leave_auditlist_app";
					// return "app/leave/leave_auditlist_app";
					break;
				}
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

			User user = (User) session.getAttribute("user");

			/**
			 * 查询审核者ID为自己的请假信息
			 */
			paramMap.put("auditId", user.getUserId());

			List<Leave> leaveAuditList = leaveService.getLeaveAuditAPPList(this.getPages().getPageSize(), currentPage, paramMap);

			currentPage = currentPage + 1;
			/**
			 * 存放页面隐藏域
			 */
			modelMap.addAttribute("leaveAuditList", leaveAuditList);
			modelMap.addAttribute("leaveAuditListSize", leaveAuditList.size());
			modelMap.addAttribute("apiKey", apiKey);
			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("userId", user.getUserId());

			modelMap.addAttribute("apiKeyTimeOut", "2");
		} else
		{
			modelMap.addAttribute("apiKeyTimeOut", "1");
			return "app/leave/leave_auditlist_app";
		}

		return path;

	}

	/**
	 * 不同权限查看到不同的page 历史请假审核列表 加载请假审核list 20151130
	 */
	@RequestMapping(value = "/getLeaveAuditListApp.do")
	public String getLeaveAuditListApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
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

			/**
			 * 查询审核者ID为自己的请假信息
			 */
			paramMap.put("auditId", user.getUserId());
			List<Leave> leaveAuditList = leaveService.getLeaveAuditAPPList(this.getPages().getPageSize(), currentPage, paramMap);

			currentPage = currentPage + 1;
			modelMap.addAttribute("leaveAuditList", leaveAuditList);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("listSize", leaveAuditList.size());

			/**
			 * flush到页面
			 */
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
	 * 进入请假审核页面 20151130
	 */
	@RequestMapping(value = "/toAuditLeave_App.do")
	public String toAuditLeave_App(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 请假单ID
		 */
		Integer leaveId = 0;

		try
		{
			leaveId = Integer.valueOf(request.getParameter("leaveId"));
		} catch (Exception e)
		{
			leaveId = 0;
		}

		Leave leave = leaveService.selectLeaveById(leaveId);

		/**
		 * 从session中取出指定的user
		 */
		User user = (User) session.getAttribute("user");

		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("userId", user.getUserId());
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("leave", leave);

		return "app/leave/leave_audit_app";
	}

	/**
	 * 封装在线请假【申请过程中】发送信息或推送
	 * @param auditor
	 * @param school
	 * @param pi
	 * @param informationType
	 */
	private void sendMsgOrPushMsgInAddLeave(User auditor,School school,PushItem pi,InformationType informationType){
		DBContextHolder.setDBType(String.valueOf(school.getSchoolId()));
		//请假申请的发送短信和请假人是学校老师不需要判断教师有没有购买
		boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐
		boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启
		boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐
		if (informationType.getType() == 1 || informationType.getType() == 3)// 只发送短信
		{
			int status = 0;
			if (schoolHasMessage)// 学校有短信套餐
			{
				if (isVirtualOpen)
				{
					// 调用短信接口
					boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), PUSHTYPE.LEAVEAUDITPUSH, auditor.getPhone(),
							auditor.getUserId(), pi.PushContent, null, informationType.getType());
					if (flag)
					{
						status = 0;
					} else
					{
						status = 1;
					}
				} else
				{
					if (isSchoolSingleMsg)
					{
						// 学校条数套餐剩余条数
						Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
						if (null != remainCount && remainCount > 0)
						{
							// 调用短信接口
							boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), PUSHTYPE.LEAVEAUDITPUSH, auditor.getPhone(),
									auditor.getUserId(), pi.PushContent, null, informationType.getType());
							if (flag)
							{
								status = 0;
							} else
							{
								status = 1;
							}
							orderMessageService.updateOrderMessageSchoolById(String.valueOf(school.getSchoolId()));
						} else
						{
							status = 2;
						}
					} else
					{
						// 调用短信接口
						boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), PUSHTYPE.LEAVEAUDITPUSH, auditor.getPhone(),
								auditor.getUserId(), pi.PushContent, null, informationType.getType());
						if (flag)
						{
							status = 0;
						} else
						{
							status = 1;
						}
					}
				}
			} else// 学校无短信套餐 直接发送
			{
				// 调用短信接口
				boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), PUSHTYPE.LEAVEAUDITPUSH, auditor.getPhone(), auditor.getUserId(),
						pi.PushContent, null, informationType.getType());
				if (flag)
				{
					status = 0;
				} else
				{
					status = 1;
				}
			}
			smsService.saveSmsDetail(pi.PushContent,auditor,auditor,status,"9");
		} else if (informationType.getType() == 2)// 只推送
		{
			List<PushItem> list = new ArrayList<PushItem>();
			list.add(pi);
			commonService.pushMsg(list, false);
		}

	}
	
	/**
	 * 封装在线请假【审核过后】发送信息或推送
	 * @param applyUser
	 * @param applyUserId
	 * @param school
	 * @param pi
	 * @param information
	 * @param flag true:同意  false:拒绝
	 */
	private void sendMsgOrPushMsgInAudit(User applyUser,Integer applyUserId,School school,PushItem pi,InformationType information,PUSHTYPE pushStatesEnum){
		DBContextHolder.setDBType(String.valueOf(school.getSchoolId()));
		boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐
		boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启
		boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐

		if (information.getType() == 1 || information.getType() == 3)// 只发送短信
		{
			if (schoolHasMessage)// 学校有短信套餐
			{
				if (isVirtualOpen)// 虚拟套餐开启直接发送
				{
					boolean smsResultflag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), pushStatesEnum,
							applyUser.getPhone(), applyUser.getUserId(), pi.PushContent, null, information.getType());
					if (smsResultflag)
					{
						smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 0,"9");
					} else
					{
						smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 1,"9");
					}
				} else
				{
					if (isSchoolSingleMsg)// 是否有学校单条套餐 有判断条数
					{
						// 学校条数套餐剩余条数
						Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
						if (null != remainCount && remainCount > 0)// 有条数且大于0
						{
							// 调用短信接口
							boolean smsResultflag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), pushStatesEnum,
									applyUser.getPhone(), applyUser.getUserId(), pi.PushContent, null, information.getType());
							if (smsResultflag)
							{
								smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 0,"9");
							} else
							{
								smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 1,"9");
							}
							orderMessageService.updateOrderMessageSchoolById(String.valueOf(school.getSchoolId()));
						} else// 没有学校条数套餐 判断学生是否购买短信套餐
						{
							// 先判断学生有没有购买过
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("userId", applyUserId);
							map.put("status", 0);
							OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(map);
							boolean isCharge = false;
							if (messageUser != null)
							{
								if (messageUser.getType() == 0)
								{
									TimeUtil.getInstance();
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

							if (isCharge)
							{
								// 调用短信接口
								boolean smsResultflag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), pushStatesEnum,
										applyUser.getPhone(), applyUser.getUserId(), pi.PushContent, null, information.getType());
								if (smsResultflag)
								{
									smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 0,"9");
								} else
								{
									smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 1,"9");
								}

								int smscount = ((int) pi.PushContent.length() / 65) + 1;
								int messcount = 0;
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
								messDetail.setCount(smscount);
								messDetail.setMessageId(messageUser.getMessageId());
								messDetail.setMessUserId(messageUser.getId());
								messDetail.setNowCount(messcount);
								messDetail.setOrgCount(messageUser.getCount());
								messDetail.setType(messageUser.getType());
								messDetail.setUserId(messageUser.getUserId());
								orderMessageService.addOrderUserMessageDetail(messDetail);
							} else
							{
								smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 2,"9");
								List<PushItem> list = new ArrayList<PushItem>();
								list.add(pi);
								commonService.pushMsg(list, false);
							}
						}
					} else
					{
						// 先判断学生有没有购买过
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("userId", applyUserId);
						map.put("status", 0);
						OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(map);
						boolean isCharge = false;
						if (messageUser != null)
						{
							if (messageUser.getType() == 0)
							{
								TimeUtil.getInstance();
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

						if (isCharge)
						{
							// 调用短信接口
							boolean smsResultflag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), pushStatesEnum,
									applyUser.getPhone(), applyUser.getUserId(), pi.PushContent, null, information.getType());
							if (smsResultflag)
							{
								smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 0,"9");
							} else
							{
								smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 1,"9");
							}

							int smscount = ((int) pi.PushContent.length() / 65) + 1;
							int messcount = 0;
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
							messDetail.setCount(smscount);
							messDetail.setMessageId(messageUser.getMessageId());
							messDetail.setMessUserId(messageUser.getId());
							messDetail.setNowCount(messcount);
							messDetail.setOrgCount(messageUser.getCount());
							messDetail.setType(messageUser.getType());
							messDetail.setUserId(messageUser.getUserId());
							orderMessageService.addOrderUserMessageDetail(messDetail);
						} else
						{
							smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 2,"9");
							List<PushItem> list = new ArrayList<PushItem>();
							list.add(pi);
							commonService.pushMsg(list, false);
						}
					}
				}
			} else
			{
				boolean smsResultflag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), pushStatesEnum,
						applyUser.getPhone(), applyUser.getUserId(), pi.PushContent, null, information.getType());
				if (smsResultflag)
				{
					smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 0,"9");
				} else
				{
					smsService.saveSmsDetail(pi.PushContent, applyUser, applyUser, 1,"9");
				}
			}

		} else if (information.getType() == 2)// 只推送
		{
			List<PushItem> list = new ArrayList<PushItem>();
			list.add(pi);
			commonService.pushMsg(list, false);
		}

	}
	
	/*-------------APP端新的请假申请接口 start---------------*/
	
	/**
	 * 【手机端】获取请假人列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getApplyPersonByApiKey.do")
	public String getApplyPersonByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<User>> rhr = new RichHttpResponse<List<User>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		//请假人对应的角色
		String roleCode = request.getParameter("roleCode");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				//请假人Id
				Integer userId = loginUser.getUserId();
				List<User> userList = new ArrayList<User>();
				if ("parent".equals(roleCode))
				{
					// 如果是家长 获得对应的孩子信息
					List<User> childrenList = commonService.getAllChildrenByUserId(userId);
					userList.addAll(childrenList);
				}else
				{
					// 如果不是家长 就获取自己的信息
					List<User> selfList = commonService.getUserByUserId(userId);
					userList.addAll(selfList);
				}
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = userList;
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("获取请假请人失败：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 【手机端】获取审核人名单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getAuditPersonByApiKey.do")
	public String getAuditPersonByApiKey(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<User>> rhr = new RichHttpResponse<List<User>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		//请假人Id
		Integer applyUserId = Integer.valueOf(request.getParameter("applyUserId"));
		//请假人对应的角色
		String roleCode = request.getParameter("roleCode");

		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				List<User> userList = new ArrayList<User>();
				if ("parent".equals(roleCode) || "student".equals(roleCode))
				{
					// 如果是家长和学生 根据申请人Id 查找对应的班级Id 找到对应的请假审核人
					userList = leaveService.getAuditPersonByApplyPersonIdFromParentOrStudent(applyUserId);
				} else
				{
					// 如果不是家长和学生 根据申请人Id 查找对应学校请假审核人
					userList = leaveService.getAuditPersonByApplyPersonId(applyUserId);
				}
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = userList;
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("获取审核人列表失败：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 【手机端】获取请假类型列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getTypeListByApiKey.do")
	public String getTypeListByApiKey(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<Map<Integer, String>>> rhr = new RichHttpResponse<List<Map<Integer, String>>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		//请假人对应的角色
		String roleCode = request.getParameter("roleCode");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				//0事假1病假2产假3出差
				List<Map<Integer, String>> typeList = new ArrayList<Map<Integer, String>>();
				Map<Integer, String> nameMap = new HashMap<Integer, String>();
				nameMap.put(0, "事假");
				nameMap.put(1, "病假");
				if((!"student".equals(roleCode)) && (!"parent".equals(roleCode)))
				{
					nameMap.put(2, "产假");
					nameMap.put(3, "出差");
				}
				typeList.add(nameMap);
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = typeList;
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("获取审核人列表失败：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 【手机端】提交请假申请 
	 */
	@RequestMapping(value = "/doAddLeaveByApiKey.do")
	public String doAddLeaveByApiKey(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Object> rhr = new RichHttpResponse<Object>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				final School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));
				//开始时间
				String startTime = request.getParameter("startTime");
				//结束时间
				String endTime = request.getParameter("endTime");
				//请假类型
				String type = request.getParameter("type");
				//请假事由
				String remark = request.getParameter("remark");
				//审核人
				Integer auditId = Integer.valueOf(request.getParameter("auditId"));
				//申请人
				Integer applyUserId = Integer.valueOf(request.getParameter("applyUserId"));
				//申请人角色
				String roleCode = request.getParameter("roleCode");
				
				int resultCode = TimeUtil.compare_date(startTime,endTime);
				if(resultCode < 0){
					if(resultCode == -1){
						rhr.ResponseCode = -1;
						rhr.ResponseResult = "请输入正确的请假时间";
						rhr.ResponseObject = null;
					}else if(resultCode == -2){
						rhr.ResponseCode = -2;
						rhr.ResponseResult = "最多请假三天";
						rhr.ResponseObject = null;
					}
				}else{
					Leave leave = new Leave();
					leave.setStartTime(startTime);
					leave.setEndTime(endTime);
					leave.setType(Integer.valueOf(type));
					leave.setRemark(remark);
					leave.setApplyUserId(applyUserId);
					leave.setAuditId(auditId);

					Integer leaveId = leaveService.addLeave(leave);
					// 申请人信息
					User applyUser = leaveService.getUserInfoByUserId(applyUserId);
					// 消息推送
					final User auditor = leaveService.getUserInfoByUserId(auditId);

					PushItem pi = new PushItem();
					pi.receiverId = auditor.getUserId();
					pi.channels = auditor.getBaiduChannelId();
					pi.deviceType = String.valueOf(auditor.getDeviceType());
					if ("student".equals(roleCode) || "parent".equals(roleCode))
					{
						pi.PushContent = "您好,您的学生" + applyUser.getRealName() + "于" + TimeUtil.getInstance().now() + "提出请假申请，请及时处理。" + school.getSchoolName();
					} else
					{
						pi.PushContent = "您好," + applyUser.getRealName() + "老师于" + TimeUtil.getInstance().now() + "提出请假申请，请及时处理。" + school.getSchoolName();
					}

					pi.PushContentType = PUSHTYPE.LEAVEAUDITPUSH.getContentType();
					pi.title = PUSHTYPE.LEAVEAUDITPUSH.getName();
					pi.PushType = PUSHTYPE.LEAVEAUDITPUSH.getType();
					pi.schoolId = loginUser.getSchoolId();
					pi.OperationapplyId = leaveId;

					final InformationType informationType = informationTypeService.getInformationTypeByInformationType(2001);
					final PushItem piFinal = pi; 
					poolTaskExecutor.execute(new Runnable()
					{
						public void run()
						{
							sendMsgOrPushMsgInAddLeave(auditor,school,piFinal,informationType);
						}
					});
					
					rhr.ResponseCode = 0;
					rhr.ResponseResult = "提交请假申请成功";
					rhr.ResponseObject = null;
				}

			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("提交请假申请失败：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 【手机端】获取请假列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getLeaveListByApiKey.do")
	public String getLeaveListByApiKey(HttpServletRequest request, HttpServletResponse response)
	{		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Pages<Leave>> rhr = new RichHttpResponse<Pages<Leave>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				Integer currentPage = 1;
				try
				{
					currentPage = Integer.valueOf(request.getParameter("currentPage"));
				} catch (Exception e)
				{
					currentPage = 1;
				}
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId", loginUser.getUserId());
				this.getPages().setPageSize(10);
				Pages<Leave> pages = leaveService.getLeaveList(this.getPages().getPageSize(), currentPage, paramMap);
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = pages;
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("获取请假列表失败：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 【手机端】根据leaveId获取假条详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getLeaveDetailByApiKey.do")
	public String getLeaveDetailByApiKey(HttpServletRequest request, HttpServletResponse response)
	{		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Leave> rhr = new RichHttpResponse<Leave>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				Integer leaveId = Integer.valueOf(request.getParameter("leaveId"));
				Leave leave = leaveService.selectLeaveById(leaveId);
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = leave;
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("获取假条详情失败：" + e.getMessage());
		}
		return null;
	}
	
	
	/**
	 * 【手机端】获取自己的请假审核列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getLeaveAuditListByApiKey.do")
	public String getLeaveAuditListByApiKey(HttpServletRequest request, HttpServletResponse response)
	{		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Pages<Leave>> rhr = new RichHttpResponse<Pages<Leave>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				List<Permission> permissionList = loginUser.getPermissionList();
				boolean isHasPermisson = false;
				for (Permission permission : permissionList)
				{
					if ("leaveAuditManager".equals(permission.getPermissionCode()) 
							|| "admin".equals(permission.getPermissionCode()))
					{
						isHasPermisson = true;
						break;
					}
				}
				if(isHasPermisson)
				{
					Integer currentPage = 1;
					try
					{
						currentPage = Integer.valueOf(request.getParameter("currentPage"));
					} catch (Exception e)
					{
						currentPage = 1;
					}
					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("auditId", loginUser.getUserId());
					this.getPages().setPageSize(10);
					Pages pages = leaveService.getLeaveAuditList(this.getPages().getPageSize(), currentPage, paramMap);
					rhr.ResponseCode = 0;
					rhr.ResponseResult = "获取成功";
					rhr.ResponseObject = pages;
				}else
				{
					rhr.ResponseCode = -1;
					rhr.ResponseResult = "你没有请假审核权限";
					rhr.ResponseObject = null;
				}
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("获取自己的请假审核列表失败：" + e.getMessage());
		}
		return null;
	}
	
	
	/**
	 * 【手机端】执行请假审核逻辑
	 */
	@RequestMapping(value = "/doLeaveAuditByApiKey.do")
	public String doLeaveAuditByApiKey(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Pages<Leave>> rhr = new RichHttpResponse<Pages<Leave>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		try
		{			
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));
				//请假单ID
				Integer leaveId = Integer.valueOf(request.getParameter("leaveId"));
				
				Leave leave = leaveService.selectLeaveById(leaveId);
				if(leave == null)
				{
					rhr.ResponseCode = 0;
					rhr.ResponseResult = "审核失败，参数传递失败";
					rhr.ResponseObject = null;
					return null;
				}
				//审核状态
				String auditStatus = request.getParameter("auditStatus");
				//审核备注
				String auditRemark = request.getParameter("auditRemark");
				// 申请人
				String applyUserId = request.getParameter("applyUserId");

				//执行审核操作
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("leaveId", leaveId);
				paramMap.put("auditStatus", auditStatus);
				paramMap.put("auditRemark", auditRemark);
				leaveService.updateLeaveById(paramMap);

				// 消息推送
				if (!"0".equals(auditStatus))
				{
					boolean flag = auditStatus.equals("1");
					Integer informationType = null;
					PUSHTYPE pushStatesEnum;
					if (flag)
					{
						informationType = 2002;
						pushStatesEnum = PUSHTYPE.LEAVEPASSPUSH;
					} else
					{
						informationType = 2003;
						pushStatesEnum = PUSHTYPE.LEAVENOTPASSPUSH;
					}

					InformationType information = informationTypeService.getInformationTypeByInformationType(informationType);
					List<UserRole> userRole = commonService.getUserRoleByUserId(StringUtil.toint(applyUserId));
					String roleCode = "";
					if (userRole.size() > 0)
					{
						roleCode = userRole.get(0).getRoleCode();
					}
					if ("student".equals(roleCode))
					{
						List<User> parentList = leaveService.getParentInfoByStudentId(Integer.valueOf(applyUserId));
						for (User applyUser : parentList)
						{
							PushItem pi = new PushItem();
							pi.receiverId = applyUser.getUserId();
							pi.channels = applyUser.getBaiduChannelId();
							pi.deviceType = String.valueOf(applyUser.getDeviceType());
							pi.PushContent = "您好：您的请假申请" + (flag ? "审核通过" : "未通过审核") + "。" + school.getSchoolName();
							pi.PushContentType = pushStatesEnum.getContentType();
							pi.title = pushStatesEnum.getName();
							pi.PushType = pushStatesEnum.getType();
							pi.OperationapplyId = leaveId;
							
							sendMsgOrPushMsgInAudit(applyUser,Integer.valueOf(applyUserId),school,pi,information,pushStatesEnum);
						}
						if(flag)
						{
							try{
								Map<String,Object> map = getByStartTimeAndEnd(leave.getStartTime(),leave.getEndTime());
								List<String> scheduleDateList = (List<String>) map.get("scheduleDate");
								List<Clazz> clazzList = clazzService.getClazzListByStudentId(Integer.valueOf(applyUserId));
								if((!CollectionUtils.isEmpty(scheduleDateList)) && (!CollectionUtils.isEmpty(clazzList))){
									Integer clazzId = clazzList.get(0).getId();
									Map<String, Integer> valueMap = null;
									for(String scheduleDate : scheduleDateList){
										valueMap = (Map<String, Integer>) map.get(scheduleDate);
										if(valueMap != null){
											Integer scheduleType = valueMap.get("scheduleType");
											if(scheduleType == 0 ){
												Integer amStatus = valueMap.get("am");
												Integer pmStatus = valueMap.get("pm");
												if(amStatus != null){
													CheckAttendance checkAttendance = new CheckAttendance();
													checkAttendance.setUserId(Integer.valueOf(applyUserId));
													checkAttendance.setClazzId(clazzId);
													checkAttendance.setStatus(amStatus);
													checkAttendance.setRemark("今天请假");
													checkAttendance.setType(1);
													checkAttendance.setCreateDate(scheduleDate);
													checkService.addCheckAttendance(checkAttendance);
												}
												if(pmStatus != null){
													CheckAttendance checkAttendance = new CheckAttendance();
													checkAttendance.setUserId(Integer.valueOf(applyUserId));
													checkAttendance.setClazzId(clazzId);
													checkAttendance.setStatus(pmStatus);
													checkAttendance.setRemark("今天请假");
													checkAttendance.setType(1);
													checkAttendance.setCreateDate(scheduleDate);
													checkService.addCheckAttendance(checkAttendance);
												}
											}else{
												Integer allStatus = valueMap.get("all");
												if(allStatus != null){
													CheckAttendance checkAttendance = new CheckAttendance();
													checkAttendance.setUserId(Integer.valueOf(applyUserId));
													checkAttendance.setClazzId(clazzId);
													checkAttendance.setStatus(allStatus);
													checkAttendance.setRemark("今天请假");
													checkAttendance.setType(1);
													checkAttendance.setCreateDate(scheduleDate);
													checkService.addCheckAttendance(checkAttendance);
												}
											}
										}
									}
								}
							}catch(Exception e){
								logger.error("【手机端】添加学生考勤列表的时候报错");
							}
						}
					} else
					{
						User applyUser = leaveService.getUserInfoByUserId(Integer.valueOf(applyUserId));
						PushItem pi = new PushItem();
						pi.receiverId = applyUser.getUserId();
						pi.channels = applyUser.getBaiduChannelId();
						pi.deviceType = String.valueOf(applyUser.getDeviceType());
						pi.PushContent = "您好：您的请假申请" + (flag ? "审核通过" : "未通过审核") + "。" + school.getSchoolName();
						pi.PushContentType = pushStatesEnum.getContentType();
						pi.title = pushStatesEnum.getName();
						pi.PushType = pushStatesEnum.getType();
						pi.OperationapplyId = leaveId;
						List<PushItem> list = new ArrayList<PushItem>();
						list.add(pi);

						sendMsgOrPushMsgInAudit(applyUser,Integer.valueOf(applyUserId),school,pi,information,pushStatesEnum);
						
						if(flag)
						{
							try{
								Map<String,Object> map = getByStartTimeAndEnd(leave.getStartTime(),leave.getEndTime());
								List<String> scheduleDateList = (List<String>) map.get("scheduleDate");
								List<Department> departmentList = departmentService.getDepartListByUserId(Integer.valueOf(applyUserId));
								if((!CollectionUtils.isEmpty(scheduleDateList)) && (!CollectionUtils.isEmpty(departmentList))){
									Integer departmentId = departmentList.get(0).getId();
									Map<String, Integer> valueMap = null;
									for(String scheduleDate : scheduleDateList){
										valueMap = (Map<String, Integer>) map.get(scheduleDate);
										if(valueMap != null){
											Integer scheduleType = valueMap.get("scheduleType");
											if(scheduleType == 0 ){
												Integer amStatus = valueMap.get("am");
												Integer pmStatus = valueMap.get("pm");
												if(amStatus != null){
													CheckAttendance checkAttendance = new CheckAttendance();
													checkAttendance.setUserId(Integer.valueOf(applyUserId));
													checkAttendance.setDepartmentId(departmentId);
													checkAttendance.setStatus(amStatus);
													checkAttendance.setRemark("今天请假");
													checkAttendance.setType(0);
													checkAttendance.setCreateDate(scheduleDate);
													checkService.addCheckAttendance(checkAttendance);
												}
												if(pmStatus != null){
													CheckAttendance checkAttendance = new CheckAttendance();
													checkAttendance.setUserId(Integer.valueOf(applyUserId));
													checkAttendance.setDepartmentId(departmentId);
													checkAttendance.setStatus(pmStatus);
													checkAttendance.setRemark("今天请假");
													checkAttendance.setType(0);
													checkAttendance.setCreateDate(scheduleDate);
													checkService.addCheckAttendance(checkAttendance);
												}
											}else{
												Integer allStatus = valueMap.get("all");
												if(allStatus != null){
													CheckAttendance checkAttendance = new CheckAttendance();
													checkAttendance.setUserId(Integer.valueOf(applyUserId));
													checkAttendance.setDepartmentId(departmentId);
													checkAttendance.setStatus(allStatus);
													checkAttendance.setRemark("今天请假");
													checkAttendance.setType(0);
													checkAttendance.setCreateDate(scheduleDate);
													checkService.addCheckAttendance(checkAttendance);
												}
											}
										}
									}
								}
							}catch(Exception e){
								logger.error("【手机端】添加教师考勤列表的时候报错");
							}
						}
					}
					rhr.ResponseCode = 0;
					rhr.ResponseResult = "审核成功";
					rhr.ResponseObject = null;
				}
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				rhr.ResponseObject = null;
			}
			String json = GsonHelper.toJson(rhr);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			logger.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			logger.error("请假审核失败：" + e.getMessage());
		}
		return null;
	}
	/*-------------APP端新的请假申请接口 end---------------*/
	
	/**
	 * 计算两个时间段有几个上午，几个下午,以及几个全天
	 * @param startTime
	 * @param endTime
	 * @return 
	 * @throws ParseException 
	 */
	private Map<String,Object> getByStartTimeAndEnd(String startTime, String endTime) throws ParseException
	{
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		List<Schedule> scheduleList = new ArrayList<Schedule>();
		Schedule schedule = new Schedule();
		Date scheduleAmStart;//考勤上午开始时间
		Date scheduleAmEnd;//考勤上午结束时间
		Date schedulePmStart;//考勤下午开始时间
		Date schedulePmEnd;//考勤下午结束时间
		Date scheduleStart;//考勤全天开始时间
		Date scheduleEnd;//考勤全天结束时间
		Map<String, Object> returnMap = new HashMap<String,Object>();
		String newStartDate = startTime.split(" ")[0];
		String newStartTime = startTime.split(" ")[1];
		String newEndDate = endTime.split(" ")[0];
		String newEndTime = endTime.split(" ")[1];
		List<String> scheduleDateList = new ArrayList<String>();
		
		SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
		Long intervalTime = formatter2.parse(newEndDate).getTime()-formatter2.parse(newStartDate).getTime();
		int cycleTimes = 1;//得出需要循环次数
		if(intervalTime == 0l){
			cycleTimes = 1;
		}else if(intervalTime > 0l){
			cycleTimes = ((int) (intervalTime/(24*60*60*1000))) + 1;
		}
		
		//查询作息时间的生效时间
		String scheduleDate = newStartDate;
		for(int i=0; i < cycleTimes; i++){
			if(i == 0){
				//第一次循环
				scheduleDate = newStartDate;
			}else if(i != 0 && i == (cycleTimes-1)){
				//最后一次循环
				scheduleDate = newEndDate;
			}else{
				scheduleDate = TimeUtil.getInstance().getNextDay(scheduleDate);
			}
			scheduleDateList.add(scheduleDate);
			//请假开始时间
			Date leaveStartTime = formatter1.parse(scheduleDate+ " "+newStartTime);
			//请假结束时间
			Date leaveEndTime = formatter1.parse(scheduleDate+" "+newEndTime);
			
			scheduleList = scheduleService.selectScheduleListByLiveingDate(scheduleDate);
			if(!CollectionUtils.isEmpty(scheduleList))
			{
				Map<String, Integer> valueMap = new HashMap<String, Integer>();
				schedule = scheduleList.get(0);
				//status 0 正常上课日期，1.休息日
				if(schedule.getStatus() == 0)
				{
					//考勤类型（0分段 1全天）
					Integer scheduleType = schedule.getType();
					valueMap.put("scheduleType", scheduleType);
					if(scheduleType == 0)
					{
						//分上午下午
						scheduleAmStart = formatter1.parse(schedule.getAmStartTime());
						scheduleAmEnd = formatter1.parse(schedule.getAmEndTime());
						schedulePmStart = formatter1.parse(schedule.getPmStartTime());
						schedulePmEnd = formatter1.parse(schedule.getPmEndTime());
						
						/*
						 *	在考勤分段的情况下请假【导致】情况分析
						 *	1.上午正常，下午正常	leaveEndTime <= scheduleAmStart || leaveStartTime >= schedulePmEnd || (leaveStartTime >=scheduleAmEnd && leaveEndTime <= schedulePmStart)  
						 *	2.上午正常，下午迟到	leaveStartTime >= scheduleAmEnd && leaveEndTime < schedulePmEnd
						 *	3.上午正常，下午旷工	leaveStartTime >= scheduleAmEnd && leaveStartTime <= schedulePmStart && leaveEndTime >= schedulePmEnd
						 *	4.上午正常，下午早退	leaveStartTime >= schedulePmStart && leaveEndTime < schedulePmEnd
						 *	5.上午迟到，下午正常	leaveEndTime < scheduleAmEnd &&  leaveEndTime >= scheduleAmStart
						 *	6.上午迟到，下午迟到	不会有这个情况存在
						 *	7.上午迟到，下午旷工	不会有这个情况存在
						 *	8.上午迟到，下午早退	不会有这个情况存在
						 *	9.上午早退，下午正常	leaveStartTime > schedulePmStart && leaveStartTime < scheduleAmEnd && leaveEndTime <= schedulePmStart
						 *	10.上午早退，下午迟到	leaveStartTime > schedulePmStart && leaveStartTime < scheduleAmEnd && leaveEndTime > schedulePmStart && leaveEndTime < schedulePmEnd
						 *	11.上午早退，下午旷工	leaveStartTime > schedulePmStart && leaveStartTime < scheduleAmEnd && leaveEndTime >= schedulePmEnd
						 *	12.上午早退，下午早退	不会有这个情况存在
						 *	13.上午旷工，下午正常	leaveStartTime <= scheduleAmStart && leaveEndTime >= scheduleAmEnd && leaveEndTime <= schedulePmStart
						 *	14.上午旷工，下午迟到	leaveStartTime <= scheduleAmStart && leaveEndTime >= scheduleAmEnd && leaveEndTime > schedulePmStart && leaveEndTime <= schedulePmEnd
						 *	15.上午旷工，下午旷工	leaveStartTime <= scheduleAmStart && leaveEndTime >= schedulePmEnd
						 *	16.上午旷工，下午早退	不会有这个情况存在
						 */
						if(leaveEndTime.getTime() <= scheduleAmStart.getTime() 
								|| leaveStartTime.getTime() >= schedulePmEnd.getTime() 
								|| (leaveStartTime.getTime() >= scheduleAmEnd.getTime() && leaveEndTime.getTime() <= schedulePmStart.getTime()) ){
							//1.上午正常，下午正常
						}else if(leaveStartTime.getTime() >= scheduleAmEnd.getTime() 
								&& leaveEndTime.getTime() < schedulePmEnd.getTime()){
							//2.上午正常，下午迟到
							valueMap.put("pm", 9);
						}else if(leaveStartTime.getTime() >= scheduleAmEnd.getTime() 
								&& leaveStartTime.getTime() <= schedulePmStart.getTime() 
								&& leaveEndTime.getTime() >= schedulePmEnd.getTime()){
							//3.上午正常，下午旷工
							valueMap.put("pm", 8);
						}else if(leaveStartTime.getTime() >= schedulePmStart.getTime() 
								&& leaveEndTime.getTime() < schedulePmEnd.getTime()){
							//4.上午正常，下午早退
							valueMap.put("pm", 10);
						}else if(leaveEndTime.getTime() < scheduleAmEnd.getTime() 
								&& leaveEndTime.getTime() >= scheduleAmStart.getTime()){
							//5.上午迟到，下午正常
							valueMap.put("am", 2);
						}else if(leaveStartTime.getTime() > schedulePmStart.getTime() 
								&& leaveStartTime.getTime() < scheduleAmEnd.getTime() 
								&& leaveEndTime.getTime() <= schedulePmStart.getTime()){
							//9.上午早退，下午正常
							valueMap.put("am", 3);
						}else if(leaveStartTime.getTime() > schedulePmStart.getTime() 
								&& leaveStartTime.getTime() < scheduleAmEnd.getTime() 
								&& leaveEndTime.getTime() > schedulePmStart.getTime() 
								&& leaveEndTime.getTime() < schedulePmEnd.getTime()){
							//10.上午早退，下午迟到
							valueMap.put("am", 3);
							valueMap.put("pm", 9);
						}else if(leaveStartTime.getTime() > schedulePmStart.getTime() 
								&& leaveStartTime.getTime() < scheduleAmEnd.getTime() 
								&& leaveEndTime.getTime() >= schedulePmEnd.getTime()){
							//11.上午早退，下午旷工
							valueMap.put("am", 3);
							valueMap.put("pm", 8);
						}else if(leaveStartTime.getTime() <= scheduleAmStart.getTime() 
								&& leaveEndTime.getTime() >= scheduleAmEnd.getTime() 
								&& leaveEndTime.getTime() <= schedulePmStart.getTime()){
							//13.上午旷工，下午正常
							valueMap.put("am", 1);
						}else if(leaveStartTime.getTime() <= scheduleAmStart.getTime() 
								&& leaveEndTime.getTime() >= scheduleAmEnd.getTime() 
								&& leaveEndTime.getTime() > schedulePmStart.getTime() 
								&& leaveEndTime.getTime() <= schedulePmEnd.getTime()){
							//14.上午旷工，下午迟到
							valueMap.put("am", 1);
							valueMap.put("pm", 9);
						}else if(leaveStartTime.getTime() <= scheduleAmStart.getTime() && leaveEndTime.getTime() >= schedulePmEnd.getTime()){
							//15.上午旷工，下午旷工
							valueMap.put("am", 1);
							valueMap.put("pm", 8);
						}
					}else
					{
						//全天
						scheduleStart = formatter1.parse(schedule.getBeginTime());
						scheduleEnd = formatter1.parse(schedule.getEndTime());
						
						/*
						 *	在考勤不分段的情况下请假【导致】情况分析
						 *	1.迟到	leaveStartTime <= scheduleStart && leaveEndTime > scheduleStart && leaveEndTime < scheduleEnd
						 *	2.早退	leaveStartTime > scheduleStart && leaveStartTime < scheduleEnd && leaveEndTime >= scheduleEnd
						 *	3.旷工	leaveStartTime <= scheduleStart && leaveEndTime >= scheduleEnd
						 */
						if(leaveStartTime.getTime() <= scheduleStart.getTime() 
								&& leaveEndTime.getTime() > scheduleStart.getTime() 
								&& leaveEndTime.getTime() < scheduleEnd.getTime()){
							//1.迟到
							valueMap.put("all", 23);
						}else if(leaveStartTime.getTime() > scheduleStart.getTime() 
								&& leaveStartTime.getTime() < scheduleEnd.getTime() 
								&& leaveEndTime.getTime() >= scheduleEnd.getTime()){
							//2.早退
							valueMap.put("all", 24);
						}else if(leaveStartTime.getTime() <= scheduleStart.getTime() 
								&& leaveEndTime.getTime() >= scheduleEnd.getTime()){
							//3.旷工
							valueMap.put("all", 26);
						}
						
					}
					returnMap.put(scheduleDate, valueMap);
				}
			}
		}
		returnMap.put("scheduleDate", scheduleDateList);
		return returnMap;
	} 
}
