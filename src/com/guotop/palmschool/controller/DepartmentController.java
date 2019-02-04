package com.guotop.palmschool.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Groupmember;
import com.guotop.palmschool.entity.Groups;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserDepartment;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.GroupmemberService;
import com.guotop.palmschool.service.GroupsService;
import com.guotop.palmschool.service.PermissionService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.HttpClientUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.guotop.palmschool.util.XmlUtil;

import dev.gson.GsonHelper;

/**
 * 部门控制类
 * 
 * @author li
 * 
 */
@RequestMapping("/depart")
@Controller
public class DepartmentController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(DepartmentController.class);
	
	@Resource
	private CommonService commonService;

	@Resource
	private DepartmentService departmentService;

	@Resource
	private GroupsService groupsService;

	@Resource
	private GroupmemberService groupmemberService;
	
	@Resource
	private UserService userService;

	@Resource
	private SchoolService schoolService;
	
	@Resource
	private PermissionService permissionService;
	
	@Autowired
	private ThreadPoolTaskExecutor poolTaskExecutor;
	
	/**
	 * 进入部门管理页面
	 */
	@RequestMapping(value = "/toDepartList.do")
	public String toGradeList()
	{
		return "department/depart_list";
	}

	/**
	 * 获取部门信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return 20151126 tao
	 */
	@RequestMapping(value = "/getDepartList.do")
	public String getDepartList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
        User user=(User) session.getAttribute("user");
        String permissionCode = request.getParameter("permissionCode");
        if(StringUtil.isEmpty(permissionCode)){
        	permissionCode = "departManager";
        }
		try
		{
			List<Department> departList =null;
			if(!StringUtil.isFjequals(user.getSchoolId())){
				departList = departmentService.getDepartListByPermissionCode(user,permissionCode);
		    }else{
		    	Map<String, Object> map=new HashMap<String, Object>();
		    	map.put("fjSchoolId", user.getFjSchoolId());
		    	departList=departmentService.getDepartListFj(map);
		    }
			Gson gson = new Gson();
			String json = gson.toJson(departList);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 【接口】获取部门信息(资源云用的)
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return 陈勇
	 */
	@RequestMapping(value = "/getDepartListInteface.do")
	public String getDepartListInteface(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		try
		{
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
			StringBuilder sb = new StringBuilder();
			String line = null;

			while ((line = br.readLine()) != null)
			{
				sb.append(line);
			}
			String msgInfo = sb.toString();
			Gson gson = new Gson();
			Map<String, Object> param = gson.fromJson(msgInfo, new TypeToken<Map<String, Object>>(){}.getType());
			DBContextHolder.setDBType(param.get("schoolId")+"");
			String roleCode =(String) param.get("roleCode");
			String userId=(String) param.get("userId");
			Integer u=null;
			if (!StringUtil.isEmpty(userId))
			{
				u = Integer.valueOf(userId);
			}
			User user = commonService.getUserDetailByUserId(Integer.valueOf(userId));
			List<Permission>  pList = permissionService.getPermissionList(Integer.valueOf(userId));
			user.setPermissionList(pList);
			String permissionCode = "departManager";
			List<Department> departList = departmentService.getDepartListByPermissionCode(user,permissionCode);
			/**
			 * flush到页面
			 */
			String json = gson.toJson(departList);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 用作部门权限管理， 部门分页显示
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/loadDepartListByQueryContent.do")
	public String loadDepartList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

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
			/**
			 * 查询部门人员名字
			 */
			String queryContent = String.valueOf(request.getParameter("queryContent"));
			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("queryContent", queryContent);
			this.getPages().setPageSize(50);
			Pages pages = commonService.loadDepartList(this.getPages().getPageSize(), currentPage, paramMap);

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
	 * 进入修改部门权限页面 20151126 tao
	 */
	@RequestMapping(value = "/toModifyDepartment.do")
	public String toModifyDepartment(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User userList = (User) session.getAttribute("user");

		// 部门id
		String departmentId = request.getParameter("id");

		/*
		 * 部门管理员Id
		 */
		Integer leaderId = null;
		try
		{
			leaderId = Integer.valueOf(request.getParameter("leaderId"));
		} catch (Exception e)
		{
			// 请捕获异常
			e.getMessage();

		}

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", userList);
		modelMap.addAttribute("departmentId", departmentId);
		modelMap.addAttribute("leaderId", leaderId);

		return "department/department_modify";
	}

	/**
	 * 执行部门权限修改
	 * 
	 * 20151127
	 * 
	 * @param request
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/doModifyDepart.do")
	public void doModifyDepart(HttpServletRequest request, HttpSession session, ModelMap modelMap,HttpServletResponse response)
	{
		
        boolean f=true;
        try {
		/**
		 * 参数map
		 */
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		/**
		 * 部门Id
		 */
		Integer departmentId = Integer.valueOf(request.getParameter("departmentId"));

		/**
		 * 部门代码
		 */
		String code = request.getParameter("code");

		/**
		 * 部门名称
		 */
		String departmentName = request.getParameter("departmentName");

		/**
		 * 部门主管Id
		 */
		String leaderIdStr = request.getParameter("leaderId");
		Integer leaderId = 0;
		if (leaderIdStr != null)
		{
			leaderId = Integer.valueOf(request.getParameter("leaderId"));
		}
		/**
		 * 修改时间
		 */
		String updateTime = formatter.format(new Date());
		//是否参与考勤
		String isAttendance = request.getParameter("isAttendance");
		paramMap.put("departmentId", departmentId);
		paramMap.put("code", code);
		paramMap.put("departmentName", departmentName);
		paramMap.put("leaderId", leaderId);
		paramMap.put("updateTime", updateTime);
		paramMap.put("isAttendance",isAttendance);
		departmentService.modifyDepartmentById(paramMap);
		// //删除原部门主管权限
		// paramMap.put("userId", oldLeaderId);
		// paramMap.put("optDepartId", departmentId);
		// paramMap.put("roleCode", "departManager");
		// commonService.deleteUserRolePermission(paramMap);
		// //设置新部门主管角色
		// paramMap.put("userId", leaderId);
		// commonService.addUserRole(modelMap);
		//return "department/depart_list";
		} catch (Exception e) {
			f=false;
		}
        try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 加载部门详细信息 为修改
	 */
	@RequestMapping(value = "/getDepartDetailForModify.do")
	public String getDepartDetailForModify(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		Integer departmentId = Integer.valueOf(request.getParameter("departmentId"));
		Department depart = departmentService.getDepartmentById(departmentId);
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(depart);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据部门的id查部门人员 为修改
	 */
	@RequestMapping(value = "/loadDepartPeopleDetailList.do")
	public String loadDepartPeopleDetailList(HttpServletResponse response, HttpServletRequest request)
	{
		response.setCharacterEncoding("UTF-8");

		Integer id = null;
		try
		{
			id = Integer.valueOf(request.getParameter("id"));
		} catch (Exception e)
		{
			// 请捕获异常

		}

		try
		{
			List<Department> depart = departmentService.loadDepartPeopleDetailList(id);
			/**
			 * flush到页面
			 */
			for (Department dd : depart)

			{
				dd.getLeaderName();

			}
			Gson gson = new Gson();
			String json = gson.toJson(depart);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据部门id 查询该部门的详细人员 20151127 tao
	 */
	@RequestMapping(value = "/loadDepartDetailList.do")
	public String loadDepartDetailList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{

			// 部门id
			Integer departmentId = Integer.parseInt(request.getParameter("departmentId"));

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
			/**
			 * 查询部门人员名字
			 */
			String queryContent = String.valueOf(request.getParameter("queryContent"));
			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("departmentId", departmentId);
			paramMap.put("queryContent", queryContent);

			Pages pages = departmentService.getDepartDetailList(this.getPages().getPageSize(), currentPage, paramMap);

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
	 * 进入部门管理详情页面
	 * 
	 * 20151127 tao
	 */
	@RequestMapping(value = "/depart_detialSelect.do")
	public String depart_detialSelect(HttpServletRequest request, ModelMap modelMap)
	{

		Integer id = Integer.valueOf(request.getParameter("id"));
		modelMap.put("id", id);

		return "department/departDetail_list";
	}

	/**
	 * 进入增加部门页面
	 * 
	 * 20151126 tao
	 */
	@RequestMapping(value = "/toAddDepartment.do")
	public String toAddDepartment(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User userList = (User) session.getAttribute("user");

		String schoolId = userList.getSchoolId();
		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", userList);
		modelMap.put("schoolId", schoolId);
		return "department/depart_add";
	}

	/**
	 * 执行增加部门逻辑
	 */
	@RequestMapping(value = "/doAddDepartm.do")
	@ResponseBody
	public void doAddDepartm(HttpServletRequest request, HttpSession session, ModelMap modelMap,HttpServletResponse response)
	{
		boolean f=true;
		try {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		/**
		 * 部门编码
		 */
		String code = request.getParameter("code");

		/**
		 * 部门名称
		 */
		String name = request.getParameter("name");
		//是否参与考勤 0是 1否
		String isAttendance = request.getParameter("isAttendance");
		if(StringUtil.isEmpty(isAttendance)){
			isAttendance = "1";
		}

		Department depart = new Department();
		depart.setCode(code);
		depart.setDepartmentName(name);
		depart.setCreateTime(formatter.format(new Date()));
		depart.setUpdateTime(formatter.format(new Date()));
		depart.setIsAttendance(isAttendance);
		/**
		 * 添加部门
		 */
		departmentService.addDepart(depart);
		} catch (Exception e) {
		}
		try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//return "department/depart_list";
	}

	/**
	 * 进入增加部门人员页面
	 */
	@RequestMapping(value = "/toAddDepartmDetail.do")
	public String toAddDepartmDetial(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User userList = (User) session.getAttribute("user");

		/**
		 * 部门ID
		 */
		Integer departmentId = Integer.valueOf(request.getParameter("departmentId"));

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", userList);
		modelMap.put("departmentId", departmentId);

		return "department/departDetial_add";
	}

	/**
	 * 在部门管理中添加部门人员 20151127 tao
	 * 
	 * @param request
	 * @param session
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/doAddTeacherList.do")
	public String doAddTeacherList(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{

		/**
		 * 部门ID
		 */
		Integer departId = Integer.valueOf(request.getParameter("departmentId"));

		/**
		 * 接受前台选中教师或部门
		 */
		String ids = request.getParameter("ids");

		String[] receiverArr = ids.split(",");

		// set集合用户保存所有加入部门的教师
		Set<User> set = new HashSet<User>();

		for (int i = 0; i < receiverArr.length; i++)
		{
			// 获取首字母
			String firstChar = receiverArr[i].substring(0, 1);

			if (Cons.PRE_DEPARTMENT.equals(firstChar))
			{
				// 获取部门ID;
				String departmentId = receiverArr[i].substring(1);

				// 接下来是通过部门ID获取该年级下所有的老师信息
				List<User> receiverList = commonService.getTeacherListByDepartmentId(Integer.valueOf(departmentId));
				for (User receiver : receiverList)
				{
					set.add(receiver);

				}

			} else if (Cons.PRE_TEACHER.equals(firstChar))
			{
				// 获取接受教师ID 也就是userId
				String receiverId = receiverArr[i].substring(1);
				List<User> receiverList = commonService.selectUserInfoByUserId(Integer.valueOf(receiverId));
				for (User receiver : receiverList)
				{
					set.add(receiver);

				}

			}
		}

		/**
		 * 遍历所有加入部门的教师，并保存到数据库
		 */
		for (User receiver : set)
		{
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("departmentId", departId);
			paramMap.put("userId", receiver.getUserId());

			// 加入之前先判断该部门是否已经存在该教师
			List<UserDepartment> receiverList = departmentService.getTeacherByUserIdAndDepartmentId(paramMap);

			if (receiverList.size() < 1)
			{

				List<UserDepartment> departmentList = departmentService.selectDepartListForDelete(receiver.getUserId());

				if(departmentList.size()>0)
				{

					if (departmentList.get(0).getDepartmentId() == 0)
					{
						paramMap.put("departId", 0);
						departmentService.modifyDepartmentByUserIdAndDepartmentId(paramMap);
					} else
					{
						departmentService.doAddTeacherToDepartment(paramMap);
					}
				}
			}
		}

		/**
		 * 存放页面隐藏域
		 */
		modelMap.put("id", departId);

		return "department/departDetail_list";

	}

	/**
	 * 执行删除部门操作 20151129
	 */
	@RequestMapping(value = "/doDeleteDepartment.do")
	public void doDeleteDepartment(HttpServletRequest request, HttpSession session, ModelMap modelMap,HttpServletResponse response)
	{
		boolean f=true;
		try {
		/**
		 * 部门id
		 */
		Integer departmentId = Integer.valueOf(request.getParameter("deparid"));

		// 第一步 先查出部门下面所有人员
		List<User> teacherList = commonService.getTeacherListByDepartmentId(departmentId);
		
		// 第二步 将查出的该部门下所有人员更新到"其他"部门中
		for (User teacher : teacherList)
		{
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("departmentId", 0);
			paramMap.put("userId", teacher.getUserId());

			// 加入之前先判断该部门是否已经存在该教师
			List<UserDepartment> receiverList = departmentService.getTeacherByUserIdAndDepartmentId(paramMap);
			List<UserDepartment> userDepartList = departmentService.getTeacherList(departmentId);
			if (receiverList.size() < 1 && userDepartList.size() <1)
			{
				paramMap.put("departId", departmentId);
				departmentService.modifyDepartmentByUserIdAndDepartmentId(paramMap);
			}
		}
		// 第三步 1.删除部门 2.删除userrole中departmentId 为 departmentId的人员关系
		departmentService.deleteDepartment(departmentId);
		} catch (Exception e) {
			f=false;
		}
		try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 通过人员id 删除部门中 的人员 20151127
	 * 
	 * @return
	 */
	@RequestMapping(value = "/deleteTeacherById.do")
	public String deleteTeacherById(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		Integer i = null;

		/**
		 * 人员ID
		 */
		String departmentId = request.getParameter("departmentId");
		Integer userId = Integer.valueOf(request.getParameter("userId"));
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * 选定user
		 */
		paramMap.put("departmentId", departmentId);
		paramMap.put("userId", userId);

		// 根据部门人员的id查其所属的部门列表
		List<UserDepartment> departList = departmentService.selectDepartListForDelete(userId);

		Integer size = departList.size();
		if (size < 1 || size == 1)
		{

			i = 1;
			paramMap.put("departmentId", 0);
			departmentService.modifyDepartmentByUserId(paramMap);
		} else
		{
			i = 0;
			departmentService.deleteUserFromDepartmentById(paramMap);
		}

		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(i);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 表单校验---begin 校验部门编码
	 */
	@RequestMapping(value = "/checkDepartmCode.do")
	public String checkDepartmCode(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String code = request.getParameter("code");
			ResultInfo resultInfo = departmentService.checkDepartmCode(code);
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
	 * 表单校验---end
	 */

	/**
	 * 表单校验---begin 校验部门名称
	 */
	@RequestMapping(value = "/checkDepartmName.do")
	public String checkDepartmName(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String name = request.getParameter("name");

			ResultInfo resultInfo = departmentService.checkDepartmName(name);

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
	 * 表单校验---begin
	 */
	/**
	 * 部门修改表单 map 原部门编号和修改后的部门编号 20151127
	 */
	@RequestMapping(value = "/checkModifyDepartmentByCode.do")
	public String checkModifyDepartmentByCode(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String code = request.getParameter("code");
			String originalcode = request.getParameter("originalcode");
			modelMap.put("code", code);
			modelMap.put("originalcode", originalcode);

			ResultInfo resultInfo = departmentService.checkModifyDepartmentByCode(modelMap);

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
	 * 表单校验---begin 部门修改表单 map 原部门名称和修改后的部门名称 20151127
	 */
	@RequestMapping(value = "/checkModifyDepartmentByName.do")
	public String checkModifyDepartmentByName(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String name = request.getParameter("name");
			String originalName = request.getParameter("originalName");
			modelMap.put("name", name);
			modelMap.put("originalname", originalName);

			ResultInfo resultInfo = departmentService.checkModifyDepartmentByName(modelMap);
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
	 * 表单校验---end
	 */

	/**
	 * 加载部门信息 用于下拉框选择部门 20151127 tao
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getDepartmentList.do",method = RequestMethod.POST)
	public String getDepartmentList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		List<Department> departmentList = commonService.getDepartmentList();
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(departmentList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping(value = "/getDepartManagerList.do")
	public String getDepartManagerList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		List<User> list = departmentService.getDepartManagerList();
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping(value = "/createDepartGroup.do")
	public String createDepartGroup(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		String resultMsg = "";
		try
		{
			String departmentId = request.getParameter("departmentId");
			User loginUser = (User) session.getAttribute("user");
			Long schoolId = Long.valueOf(loginUser.getSchoolId());
			School school = schoolService.getSchoolInfoBySchoolId(schoolId);
			List<Groups> groupsList = groupsService.getGroupsBySchoolIdAndDepartmentId(schoolId, Integer.valueOf(departmentId));
			if (groupsList != null && groupsList.size() > 0)
			{
				resultMsg = "该群已经存在，不能继续创建";
			} else
			{
				List<User> schoolAdminList = commonService.getSchoolAdminBySchoolId(schoolId); // 查找学校管理员
				User schoolAdmin = new User();
				if (schoolAdminList != null)
				{
					schoolAdmin = schoolAdminList.get(0);
				}
				List<User> teacherList = commonService.getTeacherDetailByDepartmentIdInSms(Integer.valueOf(departmentId));
				if (teacherList != null && teacherList.size() > 0)
				{
					Groups lastlyGroups = groupsService.getLastlyGroups();
					int lastlyGroupsCode = 11111111;
					if(lastlyGroups != null){
						lastlyGroupsCode = Integer.valueOf(lastlyGroups.getGroupCode());
						lastlyGroupsCode++;
					}
					Department department = departmentService.getDepartmentById(Integer.valueOf(departmentId));
					String departmentName = department.getDepartmentName();
					String currentTime = TimeUtil.getInstance().now();
					Groups groups = new Groups();
					groups.setGroupName(school.getSchoolName()+"-"+departmentName + "群");
					groups.setGroupCode(String.valueOf(lastlyGroupsCode));
					groups.setPublicMessage("暂时还没有公开信息");
					groups.setGroupMessage("暂时还没有群公告");
					groups.setType(1);// 0-互信创建普通群，1-智慧校园创建部门群，2-智慧校园创建班级群，3-互信创建部门群，4-互信创建班级群
					groups.setModifiable(1);
					groups.setCreatetime(currentTime);
					groups.setActivetime(currentTime);
					groups.setAuthentication(1);
					groups.setDeClazzId(Integer.valueOf(departmentId));
					groups.setSchoolId(Long.valueOf(loginUser.getSchoolId()));
					groups.setCreateId(loginUser.getUserId());

					if (!loginUser.getUserId().equals(schoolAdmin.getUserId()))
					{
						groups.setGroupAdminMemberCount(2);// 班级群管理员个数 = 群主 +
															// 班主任
					} else
					{
						if (department.getLeaderId() != null && department.getLeaderId() != 0 && !(department.getLeaderId().equals(schoolAdmin.getUserId())))
						{
							groups.setGroupAdminMemberCount(2);// 班级群管理员个数 = 群主
																// + 班主任
						} else
						{
							groups.setGroupAdminMemberCount(1);// 班级群管理员个数 = 群主
																// + 班主任
						}
					}
					if (department.getLeaderId() == null)
					{
						groups.setGroupMemberCount(teacherList.size() + 2);
					} else
					{
						groups.setGroupMemberCount(teacherList.size() + 1);
					}

					// 创建容联云群
					Map<String, String> parMap = new HashMap<String, String>();
					parMap.put("name", departmentName);
					parMap.put("type", "1");// 群组类型 0：临时组(上限100人) 1：普通组(上限300人)
											// 2：普通组(上限500人)
					parMap.put("permission", "0");// 0：默认直接加入 1：需要身份验证 2：私有群组
					String xmlresult = HttpClientUtil.postXML(schoolAdmin.getVoipAccount(), "Group", "CreateGroup", parMap);
					String statusCode = XmlUtil.parseXml(xmlresult, "statusCode");
					if ("000000".equals(statusCode))
					{
						String yuntxGroupId = XmlUtil.parseXml(xmlresult, "groupId");
						groups.setYuntxGroupId(yuntxGroupId);
						Integer groupId = groupsService.addGroups(groups);

						Groupmember groupmember_leader = new Groupmember(); // 创建群主
						groupmember_leader.setUserId(schoolAdmin.getUserId());
						groupmember_leader.setGroupId(groupId);
						groupmember_leader.setShowName(schoolAdmin.getRealName());
						groupmember_leader.setPhone(schoolAdmin.getPhone());
						groupmember_leader.setType(0);// 0-群主，1-管理员 2-普通用户
						groupmember_leader.setModifiable(1);
						groupmember_leader.setCreatetime(currentTime);
						groupmember_leader.setActivetime(currentTime);
						groupmember_leader.setMyGroupCard(departmentName + "群组群主");
						groupmemberService.addGroupmember(groupmember_leader);

						Groupmember groupmember_admin = new Groupmember(); // 创建群管理员
						if (!loginUser.getUserId().equals(schoolAdmin.getUserId()))
						{
							if (department.getLeaderId() != null && department.getLeaderId() != 0 && !department.getLeaderId().equals(schoolAdmin.getUserId()))
							{
								groupmember_admin.setUserId(department.getLeaderId());
								groupmember_admin.setShowName(department.getLeaderName());
								groupmember_admin.setPhone(department.getPhone());
							} else if(department.getLeaderId() == null)
							{
								groupmember_admin.setUserId(loginUser.getUserId());
								groupmember_admin.setShowName(loginUser.getRealName());
								groupmember_admin.setPhone(loginUser.getPhone());
							}
							groupmember_admin.setGroupId(groupId);
							groupmember_admin.setType(1);// 0-群主，1-管理员 2-普通用户
							groupmember_admin.setModifiable(1);
							groupmember_admin.setCreatetime(currentTime);
							groupmember_admin.setActivetime(currentTime);
							groupmember_admin.setMyGroupCard(departmentName + "群组管理员");
							
							String groupmember_admin_voipAccount = userService.getVoipAccountByUserId(groupmember_admin.getUserId());
							// 加入容联云群组
							String parXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
									+ "<Request>"
									+ "<groupId>"+yuntxGroupId+"</groupId>"
									+ "<members>"
									+ "<member>"+groupmember_admin_voipAccount+"</member>"
									+ "</members>"
									+ "<confirm>1</confirm>"
									+ "</Request>";
							String inviteJoinGroupXmlresult = HttpClientUtil.postXMLInviteJoinGroup(schoolAdmin.getVoipAccount(), "Group", "InviteJoinGroup", parXml);
							String inviteJoinGroupStatusCode = XmlUtil.parseXml(inviteJoinGroupXmlresult, "statusCode");
							if ("000000".equals(inviteJoinGroupStatusCode))
							{
								groupmemberService.addGroupmember(groupmember_admin);
							}
						} else
						{
							groupmember_admin.setUserId(schoolAdmin.getUserId());
							if (department.getLeaderId() != null && department.getLeaderId() != 0 && !department.getLeaderId().equals(schoolAdmin.getUserId()))
							{
								groupmember_admin.setUserId(department.getLeaderId());
								groupmember_admin.setShowName(department.getLeaderName());
								groupmember_admin.setPhone(department.getPhone());
								groupmember_admin.setGroupId(groupId);
								groupmember_admin.setType(1);// 0-群主，1-管理员
																// 2-普通用户
								groupmember_admin.setModifiable(1);
								groupmember_admin.setCreatetime(currentTime);
								groupmember_admin.setActivetime(currentTime);
								groupmember_admin.setMyGroupCard(departmentName + "群组管理员");
								
								String groupmember_admin_voipAccount = userService.getVoipAccountByUserId(groupmember_admin.getUserId());
								// 加入容联云群组
								String parXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
										+ "<Request>"
										+ "<groupId>"+yuntxGroupId+"</groupId>"
										+ "<members>"
										+ "<member>"+groupmember_admin_voipAccount+"</member>"
										+ "</members>"
										+ "<confirm>1</confirm>"
										+ "</Request>";
								String inviteJoinGroupXmlresult = HttpClientUtil.postXMLInviteJoinGroup(schoolAdmin.getVoipAccount(), "Group", "InviteJoinGroup", parXml);
								String inviteJoinGroupStatusCode = XmlUtil.parseXml(inviteJoinGroupXmlresult, "statusCode");
								if ("000000".equals(inviteJoinGroupStatusCode))
								{
									groupmemberService.addGroupmember(groupmember_admin);
								}
							}
						}

						final List<User> teacherList_final = teacherList;
						final Integer groupId_final = groupId;
						final Groupmember groupmember_leader_final = groupmember_leader;
						final Groupmember groupmember_admin_final = groupmember_admin;
						final String departmentName_final = departmentName;
						final String yuntxGroupId_final = yuntxGroupId;
						final User schoolAdmin_final = schoolAdmin;
						poolTaskExecutor.execute(new Thread(new Runnable()
						{
							@Override
							public void run()
							{
								for (User teacher : teacherList_final)
								{
									try{
										Integer teacherId = teacher.getUserId();
										Groupmember groupmember = new Groupmember(); // 创建群成员,部门管理员是群管理员
										groupmember.setUserId(teacher.getUserId());
										groupmember.setGroupId(groupId_final);
										groupmember.setShowName(teacher.getRealName());
										groupmember.setPhone(teacher.getPhone());
										if (teacherId == groupmember_leader_final.getUserId() || teacherId == groupmember_admin_final.getUserId())
										{
											continue;
										} else
										{
											groupmember.setType(2);
											groupmember.setMyGroupCard(departmentName_final + "群组人员");
										}
										groupmember.setModifiable(0);
										groupmember.setCreatetime(TimeUtil.getInstance().now());
										groupmember.setActivetime(TimeUtil.getInstance().now());
										
										// 加入容联云群组
										String parXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
												+ "<Request>"
												+ "<groupId>"+yuntxGroupId_final+"</groupId>"
												+ "<members>"
												+ "<member>"+teacher.getVoipAccount()+"</member>"
												+ "</members>"
												+ "<confirm>1</confirm>"
												+ "</Request>";
										String inviteJoinGroupXmlresult = HttpClientUtil.postXMLInviteJoinGroup(schoolAdmin_final.getVoipAccount(), "Group", "InviteJoinGroup", parXml);
										String inviteJoinGroupStatusCode = XmlUtil.parseXml(inviteJoinGroupXmlresult, "statusCode");
										if ("000000".equals(inviteJoinGroupStatusCode))
										{
											groupmemberService.addGroupmember(groupmember);
										}
									}catch(Exception e)
									{
										logger.error("创建亦信部门群添加教师的时候出错,错误信息如下:"+e.getMessage());
										continue;
									}

								}
								
							}
						}));
						
						resultMsg = "部门群创建成功， 部门人员成功添加";
					} else
					{
						resultMsg = "亦信班级群创建失败，请稍后重试";
					}
				} else
				{
					resultMsg = "部门人数为空,不能创建亦信部门群";
				}
			}
			Gson gson = new Gson();
			String json = gson.toJson(resultMsg);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	
	@RequestMapping(value = "/delDepartGroup.do")
	public String delDepartGroup(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String departmentId = request.getParameter("departmentId");
		User loginUser = (User) session.getAttribute("user");
		Long schoolId = Long.valueOf(loginUser.getSchoolId());
		String json = "";
		Gson gson = new Gson();
		try{
			groupsService.delGroupsBySchoolIdAndDepartmentId(schoolId, Integer.valueOf(departmentId));
			json = gson.toJson(true);
		}catch (Exception e){
			json = gson.toJson(false);
		}
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException ie)
		{
			ie.printStackTrace();
		}
		return null;
	}

}
