package com.guotop.palmschool.evaluationKindergarten.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluationKindergarten.entity.EvaluateKindergarten;
import com.guotop.palmschool.evaluationKindergarten.service.EvaluateKindergartenService;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.MenuService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 老师评价(幼儿园版)
 * 
 * @author sheng
 * 
 */
@RequestMapping("/evaluateKindergarten")
@Controller
public class TeacherEvaluationController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private UserService userService;

	@Resource
	private StudentService studentService;

	@Resource
	private ClazzService clazzService;

	@Resource
	private EvaluateKindergartenService evaluateKindergartenService;

	@Resource
	private MenuService menuService;

	/**
	 * 教师进入评价页面，能够给学生评价 家长进入能看到自己家小孩的评价列表 如果有两个身份，默认进入家长身份的页面
	 */
	@RequestMapping(value = "/toEvaluate.do")
	public String toEvaluate(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		// 判断是否有权限，无则跳转到首页
		User user = (User) session.getAttribute("user");
		List<Permission> permissionList = user.getPermissionList();
		boolean hasPriv = false;
		String returUrl = "evaluateKindergarten/evaluation_list";
		if (permissionList != null)
		{
			for (Permission permission : permissionList)
			{
				if ("admin".equals(permission.getPermissionCode()) || "evaluateKindergartenListManager".equals(permission.getPermissionCode()))
				{
					hasPriv = true;
					break;
				}
			}
		}
		if (!hasPriv)
		{
			List<Menu> menuList = new ArrayList<Menu>();
			DBContextHolder.setDBType(user.getSchoolId());
			if(user.getUserId() == 1)
			{
				menuList = menuService.getAllMenuInfoSysadmin(user.getSchoolId(),null);
			}else
			{
				menuList = menuService.getAllMenuInfo(user.getSchoolId(), 0);
			}
			session.setAttribute("menuList", menuList);
			modelMap.addAttribute("menuList", menuList);
			returUrl = "home/main";
			return returUrl;
		}
		return returUrl;
	}

	/**
	 * 加载班级信息 20160409
	 * 
	 * @return
	 */
	@RequestMapping(value = "/loadClazzList.do")
	public String loadClazzList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();

		String roleCode = request.getParameter("roleCode");
		User user = (User) session.getAttribute("user");
		List<Clazz> clazzList = new ArrayList<Clazz>();
		// modelMap存放搜索框里面的数据，搜索框里是班级列表，
		if (roleCode.equals("parent"))
		{
			// 如果拥有家长身份，默认进入家长身份的页面
			// 查找出家长对于小孩所在的班级
			clazzList = clazzService.getClazzListByParentId(user.getUserId());
		} else if (roleCode.equals("student"))
		{
			// 角色为小孩的时候查出自己班级所在的班级
			clazzList = clazzService.getClazzListByStudentId(user.getUserId());
		} else
		{

			if (commonService.hasAdminPermission(user))
			{
				// 拥有admin权限的人可以看到所有人
				clazzList = commonService.getClazzListInEvalution();
			} else
			{
				// 角色为其他的时候需要根据权限【evaluateKindergartenListManager】 获取班级列表
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId", user.getUserId());
				paramMap.put("permissionCode", "evaluateKindergartenListManager");
				clazzList = commonService.getClazzListInEvalution(paramMap);
			}
		}
		try
		{
			String json = gson.toJson(clazzList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 获取学生列表，不同身份的人员看到他相关的的班级，已经相关联的人
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getStudentListInPC.do")
	public String getStudentList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		User loginUser = (User) session.getAttribute("user");
		Gson gson = new Gson();
		String json ="";
		try
		{
			String clazzId = request.getParameter("clazzId");
			String clazzIds = request.getParameter("clazzIds");
			String queryContent = request.getParameter("queryContent");
			String roleCode = request.getParameter("roleCode");
			Integer currentPage = 1;
			
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			List<Integer> clazzList = new ArrayList<Integer>();
			if (clazzId.equals("0"))
			{
				if (!StringUtil.isEmpty(clazzIds))
				{
					String[] clazzIdArry = clazzIds.split(",");
					for (int i = 0; i < clazzIdArry.length; i++)
					{
						clazzList.add(Integer.valueOf(clazzIdArry[i]));
					}
				}
			} else
			{
				clazzList.add(Integer.valueOf(clazzId));
			}

			// 参数map，dateTime：用于当前时间向前推7天，有评论的学生就不能评论了
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("clazzList", clazzList);
			paramMap.put("queryContent", queryContent);
			paramMap.put("currentPage", currentPage);
			paramMap.put("dateTime", getQuarters());// 这个参数的作用是传当前

			this.getPages().setPageSize(50);
			Pages pages = new Pages();
			
			if (roleCode.equals("parent"))
			{
				paramMap.put("parentUserId", loginUser.getUserId());
				// 家长身份的情况下，看到班级下自己的小孩的信息
				pages = studentService.getStudentListByClazzIdListAndParentUserIdInEvaluate(this.getPages().getPageSize(), currentPage, paramMap);
			} else if (roleCode.equals("student"))
			{
				// 角色为小孩的时候查出自己的信息
				paramMap.put("studentId", loginUser.getUserId());
				pages = studentService.getStudentListByClazzIdListAndStudentIdInEvaluate(this.getPages().getPageSize(), currentPage, paramMap);
			} else
			{
				pages = studentService.getStudentListByClazzIdListInEvaluate(this.getPages().getPageSize(), currentPage, paramMap);
			}

			json = gson.toJson(pages);
			
		} catch (Exception e)
		{
			json = gson.toJson("");
		}

		try{
			response.getWriter().write(json);
			response.getWriter().flush();
		}catch(IOException io){
			System.out.println(io.getMessage());
		}
		
		return null;
	}

	/**
	 * 根据用户ID获取最近时间的一条评价详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toEvaluateDetailByUserId.do")
	public String toEvaluateDetailByUserId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String studentId = request.getParameter("studentId");
		String endDate = request.getParameter("endDate");
		EvaluateKindergarten evaluateKindergarten = null;
		if (null != studentId && !"".equals(studentId) && null != endDate && !"".equals(endDate))
		{
			evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByUserId(Integer.valueOf(studentId), endDate);
		}
		Gson gson = new Gson();
		String json = gson.toJson(evaluateKindergarten);
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

	@RequestMapping(value = "/toEvaluateDetail.do")
	public String toEvaluateDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String studentId = request.getParameter("studentId");
		User student = studentService.getStudentById(Integer.valueOf(studentId));
		String clazzName = clazzService.getClazzByIdInRICHBOOK(student.getClazzId());
		modelMap.addAttribute("clazzName", clazzName);
		modelMap.addAttribute("student", student);
		return "evaluateKindergarten/evaluation_detail";
	}

	@RequestMapping(value = "/loadEvaluateKindergartenListByStudentId.do")
	public String loadEvaluateKindergartenListByStudentId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		String studentId = request.getParameter("studentId");
		// 获取第一个小孩的所有评价分
		List<EvaluateKindergarten> evaluateKindergartenList = evaluateKindergartenService.loadEvaluateKindergartenListByStudentId(Integer.valueOf(studentId));
		try
		{
			String json = gson.toJson(evaluateKindergartenList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping(value = "/loadEvaluateKindergartenByEvaluateId.do")
	public String loadEvaluateKindergartenByEvaluateId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		String evaluateId = request.getParameter("evaluateId");
		String studentId = request.getParameter("studentId");
		EvaluateKindergarten evaluateKindergarten = new EvaluateKindergarten();
		if (evaluateId.equals("0") || StringUtil.isEmpty(evaluateId))
		{
			evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByStudentId(Integer.valueOf(studentId));
		} else
		{
			evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByEvaluateId(Integer.valueOf(evaluateId));
		}

		try
		{
			String json = gson.toJson(evaluateKindergarten);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping(value = "/toAddEvaluate.do")
	public String toAddEvaluate(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String studentId = request.getParameter("studentId");
		User student = studentService.getStudentById(Integer.valueOf(studentId));
		String clazzName = clazzService.getClazzByIdInRICHBOOK(student.getClazzId());
		modelMap.addAttribute("student", student);
		modelMap.addAttribute("clazzName", clazzName);
		return "evaluateKindergarten/evaluation_add";
	}

	/**
	 * 添加评价
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/doAddEvaluation.do")
	public String doAddEvaluation(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String clazzId = request.getParameter("clazzId");
		String studentId = request.getParameter("studentId");
		String conductStar = request.getParameter("conductStar");
		String conductText = request.getParameter("conductText");
		String sportStar = request.getParameter("sportStar");
		String sportText = request.getParameter("sportText");
		String studyStar = request.getParameter("studyStar");
		String studyText = request.getParameter("studyText");
		String lifeStar = request.getParameter("lifeStar");
		String lifeText = request.getParameter("lifeText");

		User loginUser = (User) session.getAttribute("user");
		if (loginUser != null)
		{
			EvaluateKindergarten evaluateKindergarten = new EvaluateKindergarten();
			evaluateKindergarten.setTeacherId(loginUser.getUserId());
			evaluateKindergarten.setStudentId(Integer.valueOf(studentId));
			evaluateKindergarten.setCreateTime(TimeUtil.getInstance().date());
			evaluateKindergarten.setConductStar(conductStar);
			evaluateKindergarten.setConduct(conductText);
			evaluateKindergarten.setSportStar(sportStar);
			evaluateKindergarten.setSport(sportText);
			evaluateKindergarten.setStudyStar(studyStar);
			evaluateKindergarten.setStudy(studyText);
			evaluateKindergarten.setLifeStar(lifeStar);
			evaluateKindergarten.setLife(lifeText);
			evaluateKindergarten.setClazzId(clazzId);
			evaluateKindergartenService.addEvaluateKindergarten(evaluateKindergarten);

			session.setAttribute("user", loginUser);
		} else
		{
			return null;
		}
		User student = studentService.getStudentById(Integer.valueOf(studentId));
		// 最新评价推送给家长
		List<User> parentList = studentService.getParentByStudentId(Integer.valueOf(studentId));
		List<PushItem> list = new ArrayList<PushItem>();
		for (User parent : parentList)
		{
			// 有studentId查找家长Id
			PushItem pi = new PushItem();
			pi.receiverId = parent.getUserId();
			pi.channels = parent.getBaiduChannelId();
			pi.deviceType = String.valueOf(parent.getDeviceType());
			pi.PushContent = "尊敬的" + parent.getRealName() + "," + student.getRealName() + "小朋友最新老师评价," + "品德:" + conductStar + "星,评价内容:" + conductText + ",体育:" + sportStar
					+ "星,评价内容:" + sportText + ",学习:" + studyStar + "星,评价内容:" + studyText + ",生活:" + lifeStar + "星,评价内容:" + lifeText;
			pi.PushContentType = PUSHTYPE.TEACHEREVALUATE.getContentType();
			pi.title = PUSHTYPE.TEACHEREVALUATE.getName();
			pi.PushType = PUSHTYPE.TEACHEREVALUATE.getType();
			pi.schoolId = loginUser.getSchoolId();

			list.add(pi);
		}
		commonService.pushMsg(list, true);
		request.setAttribute("studentId", studentId);
		return toEvaluateDetail(request, response, session, modelMap);
	}

	/**
	 * ------------以上是PC端老师评价，以下是MOBILE端老师评价------
	 * -----------------------------------------------------------------
	 * 教师进入评价页面，能够给学生评价 家长进入能看到自己家小孩的评价列表 如果有两个身份，默认进入家长身份的页面
	 */
	@RequestMapping(value = "/toEvaluateByApiKey.do")
	public String toEvaluateByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");

		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			// 存session
			session.setAttribute("user", loginUser);
			try
			{
				List<Role> roleList = loginUser.getRoleList();
				modelMap.addAttribute("roleList", roleList);
				modelMap.addAttribute("roleListSize", roleList.size());
				for (Role role : roleList)
				{
					List<User> studentList = new ArrayList<User>();
					if (role.getRoleCode().equals("parent"))
					{
						// 如果拥有家长身份，默认进入家长身份的页面
						// 获取两个小孩的信息，已经小孩的被评价情况
						studentList = studentService.getStudentListByParentId(loginUser.getUserId());
						if (studentList != null && studentList.size() > 0)
						{
							List<Clazz> clazzList = clazzService.getClazzListByStudentId(studentList.get(0).getUserId());
							if(clazzList != null && clazzList.size() > 0 ){
								modelMap.addAttribute("clazz", clazzList.get(0));
							}
							modelMap.addAttribute("studentList", studentList);
							modelMap.addAttribute("student", studentList.get(0));
							// 获取第一个小孩的最近评价分
							EvaluateKindergarten evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByStudentId(studentList.get(0).getUserId());
							modelMap.addAttribute("studentScore", evaluateKindergarten);// 默认小孩的评价分
						}
						return "app/evaluateKindergarten/evaluation_parent_app";
					} else if (role.getRoleCode().equals("student"))
					{
						studentList.add(loginUser);
						modelMap.addAttribute("studentList", studentList);
						modelMap.addAttribute("student", loginUser);
						List<Clazz> clazzList = clazzService.getClazzListByStudentId(loginUser.getUserId());
						if(clazzList != null && clazzList.size() > 0 ){
							modelMap.addAttribute("clazz", clazzList.get(0));
						}
						// 获取自己的最近评价分
						EvaluateKindergarten evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByStudentId(loginUser.getUserId());
						modelMap.addAttribute("studentScore", evaluateKindergarten);// 默认小孩的评价分
						return "app/evaluateKindergarten/evaluation_parent_app";
					}
				}
				return getStudentList(request, response, session, modelMap);
			} catch (Exception e)
			{
				return null;
			}
		} else
		{
			return null;
		}
	}

	/**
	 * 【家长身份】进入搜索页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toEvaluateParentSearchByApiKey.do")
	public String toEvaluateParentSearchByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		// 存session
		User loginUser = (User) session.getAttribute("user");
		try
		{
			List<Role> roleList = loginUser.getRoleList();
			modelMap.addAttribute("roleList", roleList);
			modelMap.addAttribute("roleListSize", roleList.size());
			for (Role role : roleList)
			{
				List<User> studentList = new ArrayList<User>();
				if (role.getRoleCode().equals("parent"))
				{
					// 如果拥有家长身份，默认进入家长身份的页面
					// 获取两个小孩的信息，已经小孩的被评价情况
					studentList = studentService.getStudentListByParentId(loginUser.getUserId());
					if (studentList != null && studentList.size() > 0)
					{
						modelMap.addAttribute("studentList", studentList);
						modelMap.addAttribute("student", studentList.get(0));
					}
					return "app/evaluateKindergarten/evaluation_parent_search_app";
				} else if (role.getRoleCode().equals("student"))
				{
					studentList.add(loginUser);
					modelMap.addAttribute("studentList", studentList);
					modelMap.addAttribute("student", loginUser);
					return "app/evaluateKindergarten/evaluation_parent_search_app";
				}
			}
		} catch (Exception e)
		{
			return null;
		}
		return null;
	}

	/**
	 * 【教职工身份】进入筛选班级页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toEvaluateTeacherSearchByApiKey.do")
	public String toEvaluateTeacherSearchByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		// 存session
		User loginUser = (User) session.getAttribute("user");
		try
		{			
			// 教师评价权限编码
			String permissionCode = "evaluateKindergartenListManager";
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("user", loginUser);
			paramMap.put("userId", loginUser.getUserId());
			paramMap.put("permissionCode", permissionCode);
			// 获取班级列表（不同的人看到不同班级列表）
			List<Clazz> clazzList = new ArrayList<Clazz>();
			if (commonService.hasAdminPermission(loginUser))
			{
				// 拥有admin权限的人可以看到所有人
				clazzList = commonService.getClazzListInEvalution();
			} else
			{
				clazzList = commonService.getClazzListInEvalution(paramMap);
			}
			modelMap.addAttribute("clazzList",clazzList);
			return "app/evaluateKindergarten/evaluation_teacher_search_app";
		} catch (Exception e)
		{
			return null;
		}
	}
	
	/**
	 * 【教职工身份】进入筛选评价时间页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toEvaluateTimeSearchByApiKey.do")
	public String toEvaluateTimeSearchByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String studentId = request.getParameter("studentId");
		String clazzId = request.getParameter("clazzId");
		try
		{			
			List<EvaluateKindergarten> evaluateKindergartenList = evaluateKindergartenService.loadEvaluateKindergartenListByStudentId(StringUtil.toint(studentId));
			modelMap.addAttribute("evaluateKindergartenList",evaluateKindergartenList);
			modelMap.addAttribute("studentId",studentId);
			modelMap.addAttribute("clazzId",clazzId);
			return "app/evaluateKindergarten/evaluation_teacher_evaluateTime_search_app";
		} catch (Exception e)
		{
			return null;
		}
	}
	
	/**
	 * 【家长身份】根据evaluateId 查询学生评价
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toSearchEvaluateByEvaluateId.do")
	public String toSearchEvaluateByEvaluateId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String studentId = request.getParameter("studentId");
		String evaluateId = request.getParameter("evaluateId");
		User student = studentService.getStudentById(StringUtil.toint(studentId));
		
		User loginUser = (User) session.getAttribute("user");
		List<Role> roleList = loginUser.getRoleList();
		modelMap.addAttribute("roleList", roleList);
		modelMap.addAttribute("roleListSize", roleList.size());
		if (!StringUtil.isEmpty(evaluateId))
		{
			EvaluateKindergarten evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByEvaluateId(Integer.valueOf(evaluateId));
			modelMap.addAttribute("studentScore", evaluateKindergarten);
		} else
		{
			EvaluateKindergarten evaluateKindergarten = new EvaluateKindergarten();
			modelMap.addAttribute("studentScore", evaluateKindergarten);
		}
		modelMap.addAttribute("student", student);
		List<Clazz> clazzList = clazzService.getClazzListByStudentId(StringUtil.toint(studentId));
		if(clazzList != null && clazzList.size() > 0 ){
			modelMap.addAttribute("clazz", clazzList.get(0));
		} 
		return "app/evaluateKindergarten/evaluation_parent_app";
	}

//	/**
//	 * 家长切换学生
//	 * 
//	 * @param request
//	 * @param response
//	 * @param session
//	 * @param modelMap
//	 * @return
//	 */
//	@SuppressWarnings("unused")
//	@RequestMapping(value = "/toChangeByStudentId.do")
//	public String toChangeByStudentId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
//	{
//		String studentId = request.getParameter("studentId");
//		User loginUser = (User) session.getAttribute("user");
//		List<Role> roleList = loginUser.getRoleList();
//		modelMap.addAttribute("roleList", roleList);
//		modelMap.addAttribute("roleListSize", roleList.size());
//		// 如果拥有家长身份，默认进入家长身份的页面
//		// 获取两个小孩的信息，已经小孩的被评价情况
//		List<User> studentList = studentService.getStudentListByParentId(loginUser.getUserId());
//		if (loginUser != null)
//		{
//			if (studentList != null && studentList.size() > 0)
//			{
//				modelMap.addAttribute("studentList", studentList);
//				if (!StringUtil.isEmpty(studentId))
//				{
//					for (User student : studentList)
//					{
//						if (Integer.valueOf(studentId).equals(student.getUserId()))
//						{
//							modelMap.addAttribute("student", student);
//							EvaluateKindergarten evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByStudentId(Integer.valueOf(studentId));
//							modelMap.addAttribute("studentScore", evaluateKindergarten);// 默认小孩的评价分
//							break;
//						}
//					}
//				} else
//				{
//					modelMap.addAttribute("student", studentList.get(0));
//					EvaluateKindergarten evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByStudentId(studentList.get(0).getUserId());
//					modelMap.addAttribute("studentScore", evaluateKindergarten);// 默认小孩的评价分
//				}
//			}
//			return "app/evaluateKindergarten/evaluation_parent_app";
//		} else
//		{
//			return null;
//		}
//	}

	/**
	 * 进入班级列表页面（包含学生）
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getStudentList.do")
	public String getStudentList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String clazzId = request.getParameter("clazzId");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, List<User>> studentMap = new HashMap<String, List<User>>();
		HashMap<String, Object> clazzMap = new HashMap<String, Object>();
		// 登录用户
		User loginUser = (User) session.getAttribute("user");
		if (loginUser != null)
		{
			List<Role> roleList = loginUser.getRoleList();
			// 教师评价权限编码
			String permissionCode = "evaluateKindergartenListManager";
			paramMap.put("user", loginUser);
			paramMap.put("userId", loginUser.getUserId());
			paramMap.put("permissionCode", permissionCode);
			// 获取班级列表（不同的人看到不同班级列表）
			List<Clazz> clazzList = new ArrayList<Clazz>();
			if (commonService.hasAdminPermission(loginUser))
			{
				// 拥有admin权限的人可以看到所有人
				clazzList = commonService.getClazzListInEvalution();
			} else
			{
				clazzList = commonService.getClazzListInEvalution(paramMap);
			}
			// 获取当前时间的前一天
			paramMap.put("dateTime", getQuarters());
			// 对班级循环，获取每个门下所有学生
			if (clazzList != null && clazzList.size() > 0)
			{
				for (Clazz clazz : clazzList)
				{
					paramMap.put("clazzId", clazz.getId());
					// 学生得分为已评论
					List<User> alreadyCommentStudentList = studentService.getAlreadyCommentStudentListByClazzIdInEvaluation(paramMap);
					// 学生得分为未评论
					List<User> noCommentStudentList = studentService.getNoCommentStudentListByClazzIdInEvaluation(paramMap);
					studentMap.put(clazz.getId() + "a", alreadyCommentStudentList);
					studentMap.put(clazz.getId() + "n", noCommentStudentList);

					clazzMap.put(clazz.getId() + "", clazz);
				}
				modelMap.addAttribute("clazzList", clazzList);
				if (!StringUtil.isEmpty(clazzId))
				{
					modelMap.addAttribute("clazz", clazzMap.get(clazzId));
					modelMap.addAttribute("alreadyCommentStudentList", studentMap.get(clazzId + "a"));
					modelMap.addAttribute("noCommentStudentList", studentMap.get(clazzId + "n"));
				} else
				{
					modelMap.addAttribute("clazz", clazzList.get(0));
					modelMap.addAttribute("alreadyCommentStudentList", studentMap.get(clazzList.get(0).getId() + "a"));
					modelMap.addAttribute("noCommentStudentList", studentMap.get(clazzList.get(0).getId() + "n"));
				}
			}
			modelMap.addAttribute("roleListSize", roleList.size());
			modelMap.addAttribute("roleList", roleList);
			return "app/evaluateKindergarten/evaluation_list_app";
		} else
		{
			return null;
		}
	}
	
	/**
	 * 进入班级列表页面（包含学生）
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getEvaluateDetailByEvaluateId.do")
	public String getEvaluateDetailByEvaluateId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String evaluateId = request.getParameter("evaluateId");
		String studentId = request.getParameter("studentId");
		String clazzId = request.getParameter("clazzId");
		
		User student = studentService.getStudentById(StringUtil.toint(studentId));
		String clazzName = clazzService.getClazzByIdInRICHBOOK(StringUtil.toint(clazzId));
		Clazz clazz = new Clazz();
		clazz.setId(StringUtil.toint(clazzId));
		clazz.setClazzId(StringUtil.toint(clazzId));
		clazz.setClazzName(clazzName);
		// 登录用户
		User loginUser = (User) session.getAttribute("user");
		if (loginUser != null)
		{
			EvaluateKindergarten evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByEvaluateId(StringUtil.toint(evaluateId));
			modelMap.addAttribute("evaluateKindergarten", evaluateKindergarten);
			modelMap.addAttribute("student", student);
			modelMap.addAttribute("clazzName", clazzName);
			return "app/evaluateKindergarten/evaluation_detail_app";
		} else
		{
			return null;
		}
	}

	/**
	 * 进入教师评价页面(已经评论过的就不能再评论了)
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toEvaluationTeacher.do")
	public String toEvaluationTeacher(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String userId = request.getParameter("userId");
		String attr1 = request.getParameter("attr1");
		String clazzId = request.getParameter("clazzId");

		Clazz clazz = clazzService.getClazzById(Integer.valueOf(clazzId + ""));
		String clazzName = clazzService.getClazzByIdInRICHBOOK(Integer.valueOf(clazzId + ""));
		User student = studentService.getStudentById(Integer.valueOf(Integer.valueOf(userId + "")));
		User loginUser = (User) session.getAttribute("user");
		if (loginUser != null)
		{
			List<Role> roleList = loginUser.getRoleList();
			modelMap.addAttribute("roleList", roleList);
			modelMap.addAttribute("roleListSize", roleList.size());
			if (attr1.equals("already"))
			{
				// 已经评价的学生显示评价分数
				// 获取学生最近一次分数
				EvaluateKindergarten evaluateKindergarten = evaluateKindergartenService.loadEvaluateKindergartenByStudentId(Integer.valueOf(userId + ""));
				modelMap.addAttribute("evaluateKindergarten", evaluateKindergarten);
				modelMap.addAttribute("clazz", clazz);
				modelMap.addAttribute("clazzName", clazzName);
				modelMap.addAttribute("attr1", attr1);
				modelMap.addAttribute("student", student);
				return "app/evaluateKindergarten/evaluation_teacher_app";
			} else if (attr1.equals("no"))
			{
				// 未评论的学生不显示任何数据
				EvaluateKindergarten evaluateKindergarten = new EvaluateKindergarten();
				modelMap.addAttribute("evaluateKindergarten", evaluateKindergarten);
				modelMap.addAttribute("clazz", clazz);
				modelMap.addAttribute("clazzName", clazzName);
				modelMap.addAttribute("attr1", attr1);
				modelMap.addAttribute("student", student);
				return "app/evaluateKindergarten/evaluation_teacher_app";
			}
		} else
		{
			return null;
		}
		return null;
	}

	/**
	 * 添加评价
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addEvaluation.do")
	public String addEvaluation(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String clazzId = request.getParameter("clazzId");
		String studentId = request.getParameter("studentId");
		String conductStar = request.getParameter("conductStar");
		String conductText = request.getParameter("conductText");
		String sportStar = request.getParameter("sportStar");
		String sportText = request.getParameter("sportText");
		String studyStar = request.getParameter("studyStar");
		String studyText = request.getParameter("studyText");
		String lifeStar = request.getParameter("lifeStar");
		String lifeText = request.getParameter("lifeText");

		User loginUser = (User) session.getAttribute("user");
		if (loginUser != null)
		{
			EvaluateKindergarten evaluateKindergarten = new EvaluateKindergarten();
			evaluateKindergarten.setTeacherId(loginUser.getUserId());
			evaluateKindergarten.setStudentId(Integer.valueOf(studentId));
			evaluateKindergarten.setCreateTime(TimeUtil.getInstance().date());
			evaluateKindergarten.setConductStar(conductStar);
			evaluateKindergarten.setConduct(conductText);
			evaluateKindergarten.setSportStar(sportStar);
			evaluateKindergarten.setSport(sportText);
			evaluateKindergarten.setStudyStar(studyStar);
			evaluateKindergarten.setStudy(studyText);
			evaluateKindergarten.setLifeStar(lifeStar);
			evaluateKindergarten.setLife(lifeText);
			evaluateKindergarten.setClazzId(clazzId);
			evaluateKindergartenService.addEvaluateKindergarten(evaluateKindergarten);

			session.setAttribute("user", loginUser);

			// 最新评价推送给家长
			List<User> parentList = studentService.getParentByStudentId(Integer.valueOf(studentId));
			List<PushItem> list = new ArrayList<PushItem>();
			for (User parent : parentList)
			{
				// 有studentId查找家长Id
				PushItem pi = new PushItem();
				pi.receiverId = parent.getUserId();
				pi.channels = parent.getBaiduChannelId();
				pi.deviceType = String.valueOf(parent.getDeviceType());
				pi.PushContent = "尊敬的" + parent.getRealName() + "," + loginUser.getRealName() + "小朋友最新老师评价," + "品德:" + conductStar + "星,评价内容:" + conductText + ",体育:" + sportStar
						+ "星,评价内容:" + sportText + ",学习:" + studyStar + "星,评价内容:" + studyText + ",生活:" + lifeStar + "星,评价内容:" + lifeText;
				pi.PushContentType = PUSHTYPE.TEACHEREVALUATE.getContentType();
				pi.title = PUSHTYPE.TEACHEREVALUATE.getName();
				pi.PushType = PUSHTYPE.TEACHEREVALUATE.getType();
				pi.schoolId = loginUser.getSchoolId();

				list.add(pi);
			}
			commonService.pushMsg(list, false);
		} else
		{
			return null;
		}
		request.setAttribute("clazzId", clazzId);
		return getStudentList(request, response, session, modelMap);
	}

	/**
	 * 当前时间减去1day
	 * 
	 * @return
	 */
	public String getQuarters()
	{
		Date d = new Date();
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		gc.setTime(d);
		gc.add(Calendar.DATE, -1);
		gc.set(gc.get(Calendar.YEAR), gc.get(Calendar.MONTH), gc.get(Calendar.DATE));
		return sf.format(gc.getTime());
	}

}
