package com.guotop.palmschool.common.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Grade;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.GradeService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.StringUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 基础数据控制类
 * 
 * @author zhou
 */
@RequestMapping("/baseData")
@Controller
public class BaseDataController
{
	@Resource
	private CommonService commonService;

	@Resource
	private GradeService gradeService;

	@Resource
	private ClazzService clazzService;
	
	@Resource
	private UserService userService;
	
	@Resource
	private StudentService studentService;

	/**
	 * 加载年级列表 20151223
	 * 
	 * @return
	 */
	@RequestMapping(value = "/loadGradeList.do")
	public String loadGradeList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();

		List<Grade> gradeList = gradeService.getGradeList();

		try
		{
			String json = gson.toJson(gradeList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 加载部门列表 20151207
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getDepartmentList.do")
	public String loadDepartmentList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		List<Department> departmentList = commonService.getDepartList();
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

	/**
	 * 通过select选取department加载不同的教师列表 20151127 tao
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getTeacherListByDepartmentId.do")
	public String getTeacherListByDepartmentId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{

		response.setCharacterEncoding("UTF-8");

		Gson gson = new Gson();

		/**
		 * select选择的 部门 号
		 */
		Integer departmentId = Integer.valueOf(request.getParameter("departmentId"));

		/**
		 * 根据部门ID加载教师列表
		 */
		List<User> teacherList = new ArrayList<User>();

		try
		{
			teacherList = commonService.getTeacherDetailByDepartmentId(departmentId);
		} catch (Exception e)
		{
			e.printStackTrace();
			teacherList = new ArrayList<User>();
		}
		try
		{
			String json = gson.toJson(teacherList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 根据年级ID选择班级list
	 */
	@RequestMapping(value = "/loadClazzListByGradeId.do")
	public List<Clazz> loadClazzListByGradeId(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();

		List<Clazz> clazzList = new ArrayList<Clazz>();

		String gradeId = request.getParameter("gradeId");
		try
		{
			if(!"all".equals(gradeId)){
				clazzList = clazzService.getClazzListByGradeId(Integer.valueOf(gradeId));
			}
		} catch (Exception e)
		{
			clazzList = new ArrayList<Clazz>();
			e.printStackTrace();
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
	 * 加载班级信息 20151207
	 * 
	 * @return
	 */
	@RequestMapping(value = "/loadClazzList.do")
	public String loadClazzList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();

		/*
		 * 取出选中的用户
		 */
		User user = (User) session.getAttribute("user");

		// 查询传入页面权限编码
		String permissionCode = request.getParameter("permissionCode");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", permissionCode);

		List<Clazz> clazzList = commonService.getClazzList(paramMap);

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
	 * 通过select选取clazz加载不同的学生列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/loadStudentList.do")
	public String loadStudentList(HttpServletRequest request, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");

		Gson gson = new Gson();

		/**
		 * select选择的班级号
		 */
		String clazzId = request.getParameter("clazzId");

		/**
		 * 根据班级ID加载学生列表
		 */
		List<User> studentList = new ArrayList<User>();

		try
		{
			studentList = commonService.selectStudentListByClazzId1(Integer.valueOf(clazzId));
		} catch (Exception e)
		{
			e.printStackTrace();
			studentList = new ArrayList<User>();
		}

		try
		{
			String json = gson.toJson(studentList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 加载年级信息 没有分页
	 * 
	 * @return update by shengyinjiang 20151128
	 */
	@RequestMapping(value = "/getGradeList.do")
	public String getGradeListInClazzAdd(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		List<Grade> gradeList = gradeService.getGradeList();

		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(gradeList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 根据gradeId加载班级信息 没有分页
	 * 
	 * @return tao 20160114
	 */
	@RequestMapping(value = "/getClazzListByGradeId.do")
	public String getClazzListByGradeId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		Integer gradeId = StringUtil.toint(request.getParameter("gradeId"));

		List<Clazz> clazzList = clazzService.getClazzListByGradeId(gradeId);

		try
		{
			Gson gson = new Gson();
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
	 * 根据gradeId加载班级信息 没有分页
	 * 
	 * @return tao 20160114
	 */
	@RequestMapping(value = "/getClazzListByGradeId4App.do")
	public String getClazzListByGradeId4App(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		Integer gradeId = StringUtil.toint(request.getParameter("gradeId"));

		List<Clazz> clazzList = clazzService.getClazzListByGradeId4App(gradeId);

		try
		{
			Gson gson = new Gson();
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
	 * 根据clazzId加载班级学生信息
	 * 如果是家长这查找本班级下自己的小孩   其他则查看本班级的所有学生
	 * @return tao 20160114
	 */
	@RequestMapping(value = "/loadStudentByClazzId.do")
	public String loadStudentByClazzId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String roleCode = request.getParameter("roleCode");
			Integer userId = StringUtil.toint(request.getParameter("userId"));
			Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));
			User user = (User) session.getAttribute("user");
		
			Map<String,Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", userId);
			paramMap.put("clazzId", clazzId);
			List<User> studentList = commonService.loadStudentByClazzId(roleCode,paramMap,user);

		
			Gson gson = new Gson();
			String json = gson.toJson(studentList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}
	
	/**
	 * 【手机端】根据clazzId获取对应的学生
	 */
	@RequestMapping(value = "/getStudentListByClazzIdByApiKey.do")
	public String getStudentListByClazzIdByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<User>> rhr = new RichHttpResponse<List<User>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String clazzId = request.getParameter("clazzId");
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				List<User> studentList = studentService.getStudentListByClazzIdInStudentSMS(StringUtil.toint(clazzId));

				rhr.ResponseCode = 0;
				rhr.ResponseObject = studentList;
				rhr.ResponseResult = "获取成功";
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
			
		}
		return null;
	}
	
	/**
	 * 验证登录账号是否存在
	 */
	@RequestMapping(value = "/checkUserName.do")
	public String checkUserName(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String userName = request.getParameter("userName");
			
			boolean flag = userService.checkUserName(userName);
		
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
}
