package com.guotop.palmschool.system.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.system.service.SystemLogService;
import com.guotop.palmschool.util.Pages;

/**
 * 系统日志控制类
 * @author zhou
 */
@RequestMapping("/system")
@Controller
public class SystemLogController extends BaseController
{
	@Resource 
	private SystemLogService systemLogService;
	
	/**
	 * 进入系统日志页面
	 */
	@RequestMapping(value="/toSystemLogList.do")
	public String toSystemLogList()
	{
		return "system/systemLog_list";
	}
	
	/**
	 * 不同权限查看到不同的page
	 * 加载系统日志list
	 */
	@RequestMapping(value="/loadSystemLogList.do")
	public String loadSystemLogList(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
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
			}
			catch (Exception e)
			{
				currentPage = 1;
			}
			
			/**
			 * 获取分页数据
			 */
			Pages pages = systemLogService.loadSystemLogList(this.getPages().getPageSize(),
					currentPage, null);
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
