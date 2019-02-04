package com.guotop.palmschool.curriculum.controller;

import java.util.HashMap;
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
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.curriculum.entity.Classroom;
import com.guotop.palmschool.curriculum.service.ClassroomService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;

/**
 * 教室控制类
 */
@RequestMapping("/classroom")
@Controller
public class ClassroomController extends BaseController
{

	@Resource
	private ClassroomService classroomService;

	/**
	 * 进入教室页面
	 */
//	@RequestMapping(value = "/toClassroomList.do")
//	public String toClassroomList(HttpSession session, HttpServletResponse response)
//	{
//		response.setCharacterEncoding("UTF-8");
//
//		return "classroom/classroom_list";
//	}

	/**
	 * 加载教室List
	 * 
	 */
//	@RequestMapping(value = "/loadClassroomList.do")
//	public String loadClassroomList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
//	{
//		response.setCharacterEncoding("UTF-8");
//
//		try
//		{
//			/**
//			 * 分页信息
//			 */
//			Integer currentPage = 1;
//
//			try
//			{
//				currentPage = Integer.valueOf(request.getParameter("cPage"));
//			} catch (Exception e)
//			{
//				currentPage = 1;
//			}
//
//			/**
//			 * 设备名称
//			 */
//			String queryContent = request.getParameter("queryContent");
//
//			/**
//			 * 参数map
//			 */
//			Map<String, Object> paramMap = new HashMap<String, Object>();
//
//			paramMap.put("queryContent", queryContent);
//
//			Pages pages = classroomService.getClassroomList(this.getPages().getPageSize(), currentPage, paramMap);
//
//			/**
//			 * flush到页面
//			 */
//			Gson gson = new Gson();
//			String json = gson.toJson(pages);
//			response.getWriter().write(json);
//			response.getWriter().flush();
//		} catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//		return null;
//	}

	/**
	 * 进入添加教室页面
	 */
//	@RequestMapping(value = "/toAddClassroom.do")
//	public String toAddClassroom()
//	{
//		return "classroom/classroom_add";
//	}

	/**
	 * 添加教室
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
//	@RequestMapping(value = "/toSaveClassroom.do")
//	public String toSaveClassroom(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
//	{
//
//		response.setCharacterEncoding("UTF-8");
//
//		// 编码
//		String code = request.getParameter("code");
//
//		// 名称
//		String name = request.getParameter("name");
//
//		Classroom classroom = new Classroom();
//		classroom.setCode(code);
//		classroom.setName(name);
//
//		classroomService.saveClassroom(classroom);
//
//		return "classroom/classroom_list";
//
//	}

	/**
	 * 进入修改教室页面
	 */
//	@RequestMapping(value = "/toModifyClassroom.do")
//	public String toModifyClassroom(HttpServletRequest request, ModelMap modelMap)
//	{
//
//		try
//		{
//			Integer classroomId = StringUtil.toint(request.getParameter("classroomId"));
//			
//			Classroom classroom = classroomService.getClassroomById(classroomId);
//			
//			modelMap.addAttribute("classroomId", classroomId);
//			modelMap.addAttribute("name", classroom.getName());
//			
//		}catch (Exception e){
//			e.printStackTrace();
//		}
//
//		return "classroom/classroom_modify";
//	}

	/**
	 * 修改教室
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
//	@RequestMapping(value = "/doModifyClassroom.do")
//	public String doModifyClassroom(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
//	{
//
//		response.setCharacterEncoding("UTF-8");
//
//		Integer classroomId = StringUtil.toint(request.getParameter("classroomId"));
//
//		// 编码
//		String code = request.getParameter("code");
//
//		// 名称
//		String name = request.getParameter("name");
//
//		Classroom classroom = new Classroom();
//		classroom.setId(classroomId);
//		classroom.setCode(code);
//		classroom.setName(name);
//
//		classroomService.modifyClassroom(classroom);
//
//		return "classroom/classroom_list";
//
//	}

	/**
	 * 检测教室名称是否存在
	 * 
	 * @return
	 */
//	@RequestMapping(value = "/checkClassroom.do")
//	public String checkClassroom(HttpServletRequest request, HttpServletResponse response, HttpSession session)
//	{
//		response.setCharacterEncoding("UTF-8");
//
//		try
//		{
//			String name = request.getParameter("name");
//			String originalname = request.getParameter("originalname");
//
//			ResultInfo resultInfo = classroomService.checkClassroom(name,originalname);
//			/**
//			 * flush到页面
//			 */
//			Gson gson = new Gson();
//			String json = gson.toJson(resultInfo);
//			response.getWriter().write(json);
//			response.getWriter().flush();
//		} catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//		return null;
//	}

}
