package com.guotop.palmschool.main.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Announcement;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.Sms;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.main.entity.Parameters;
import com.guotop.palmschool.main.service.MainService;

/**
 * 首页控制类
 * 创建此类目的:提供统一入口，预计首页后期变动大，避免频繁修改污染其他类，main包其他类同这个意思.
 * @author zhou
 */
@RequestMapping("/main")
@Controller
public class MainController 
{
	@Resource
	private MainService mainService;
	
	@Resource
	private CommonService commonService;
	
	/**
	 * 第一排---begin
	 */
	/**
	 * 第一排左加载各项数据
	 */
	@RequestMapping(value="/loadParameters.do")
	public String loadParameters(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			User user = (User) session.getAttribute("user");
			Parameters parameters = mainService.selectParametersForMain(user);
			
			try 
			{
				/**
				 * flush到页面
				 */
				Gson gson = new Gson();
				String json = gson.toJson(parameters);
				response.getWriter().write(json);
				response.getWriter().flush();
			}
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 第一排右加载最新一条系统公告
	 */
	@RequestMapping(value="/loadLastSystemAnnouncement.do")
	public String loadLastSystemAnnouncement(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		try
		{
			Announcement announcement = mainService.selectAnnouncementForMain();
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(announcement);
			response.getWriter().write(json);
			response.getWriter().flush();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 第一排---end
	 */
	
	
	/**
	 * 第二排---begin
	 */
	/**
	 * 第二排左一 进出记录
	 */
	@RequestMapping(value="/loadAllInout.do")
	public String loadAllInout(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		try
		{
			Integer  inoutcount = mainService.selectAllInoutForMain();
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(inoutcount);
			response.getWriter().write(json);
			response.getWriter().flush();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 第二排---end
	 */
	
	
	/**
	 * 第三排---begin
	 */
	/**
	 * 左
	 */
	@RequestMapping(value="/loadSmsList.do")
	public String loadSmsList(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		try
		{
			List<Sms> smsList = mainService.selectSmsListForMain();
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(smsList);
			response.getWriter().write(json);
			response.getWriter().flush();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 第三排---end
	 */
	
	/**
	 * 第四排---begin
	 */
	/**
	 * 加载学校列表数据
	 */
	@RequestMapping(value="/loadSchoolList.do")
	public String loadSchoolList(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		try
		{
			List<School> schoolList = mainService.selectSchoolListForMain(); 
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(schoolList);
			response.getWriter().write(json);
			response.getWriter().flush();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 第四排---end
	 */
}
