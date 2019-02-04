package com.guotop.palmschool.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.ScoreService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.TimeUtil;
/**
 * 成绩查看
 * @author jfy
 * @date 2016年1月7日
 */
@RequestMapping("/score")
@Controller
public class ScoreController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(ScoreController.class);
	@Resource
	private ScoreService scoreService;
	/**
	 * 进入成绩查看页面
	 * @return
	 */
	@RequestMapping(value="/toScoreList.do")
	public String toScoreList( ModelMap modelMap)
	{
		return "growthArchives/score_list";
	}

	/**
	 * 获取成绩查看列表
	 * @param request
	 * @param session
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/getScoreList.do")
	public String getScoreList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
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
		User login = (User)session.getAttribute("user");
		String queryCondition = request.getParameter("queryContent");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String clazz = request.getParameter("clazz");
		String roleCode = request.getParameter("roleCode");
		if (startTime == null || startTime.equals(""))
		{
			startTime = TimeUtil.getInstance().getTodayBegin();
		}
		if (endTime == null || endTime.equals(""))
		{
			endTime = TimeUtil.getInstance().getTodayEnd();
		}
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("queryCondition", queryCondition);
		param.put("startTime", startTime);
		param.put("endTime", endTime);
		param.put("clazz", clazz);
		param.put("roleCode", roleCode);
		try
		{
			Pages pages = scoreService.getScoreList(this.getPages().getPageSize(), currentPage, param, login);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		}catch(Exception ex)
		{
			log.error(ex.getMessage());
		}
		return null;
	}
}
