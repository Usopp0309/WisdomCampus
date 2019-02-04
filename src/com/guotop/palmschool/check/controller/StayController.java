package com.guotop.palmschool.check.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.check.service.StayService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 在校时间控制类
 * @author zhou
 */
@RequestMapping("/stay")
@Controller
public class StayController extends BaseController
{
	@Resource
	private CommonService commonService;
	
	@Resource
	private StayService stayService;
	
	/**
	 * 进入在校时间页面
	 */
	@RequestMapping(value="/toStayList.do")
	public String toStayList()
	{
		return "safeSchool/stay_list";
	}
	
	/**
	 * 不同权限查看到不同的page
	 * 加载在校时间list
	 */
	@RequestMapping(value="/loadStayList.do")
	public String loadStayList(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		try
		{
			/**
			 * 卡号
			 */
			String queryContent = request.getParameter("queryContent");
			
			/**
			 * 持有者
			 */
			//String name = request.getParameter("name");
			
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			}
			catch (Exception e)
			{
				currentPage = 1;
			}
			
			/**
			 * 师生类型
			 */
			Integer type = 0;
			try
			{
				type = Integer.valueOf(request.getParameter("type"));
				/**
				 * 全部即不设师生类型
				 */
				if (Cons.TCHSTUTYPE_ALL.equals(type))
				{
					type = null;
				}
			}
			catch (Exception e)
			{
				type = null;
			}
			
			
			/**
			 * 选定user
			 */
			User user = (User) session.getAttribute("user");
			paramMap.put("userId", user.getUserId());
			paramMap.put("schoolId", user.getSchoolId());
			
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("gradeId", user.getGradeId());
			
			
			paramMap.put("type", type);
		
			paramMap.put("queryContent", queryContent);
			//paramMap.put("name", name);
			
			Pages pages = stayService.loadStayList(this.getPages().getPageSize(),
					currentPage, paramMap, 0);
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
}
