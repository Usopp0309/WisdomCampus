package com.guotop.palmschool.schoolnews.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.schoolnews.entity.ApplyInfo;
import com.guotop.palmschool.schoolnews.entity.TakePartInActivity;
import com.guotop.palmschool.schoolnews.service.ApplyInfoService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 报名信息管理
 */
@RequestMapping("/applyInfo")
@Controller
public class ApplyInfoController extends BaseController
{
	@Resource
	private ApplyInfoService applyInfoService;

	/**
	 * 跳转到招生列表
	 */
	@RequestMapping(value = "/toApplyInfoList.do")
	public String toApplyInfoList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "applyInfo/applyInfo_on_list";
	}

	/**
	 * 获取招生信息
	 */
	@RequestMapping(value = "/getApplyInfoListInfo.do")
	public void getApplyInfoListInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String createTime = request.getParameter("createTime");
			String status = request.getParameter("status");
			if (("-1").equals(status))
			{
				status = "";
			}
			String queryContent = request.getParameter("queryContent");
			HashMap<String, Object> map = new HashMap<String, Object>();
			User user = (User) session.getAttribute("user");
			map.put("createTime", createTime);
			map.put("status", status);
			map.put("queryContent", queryContent);
			map.put("schoolId", user.getSchoolId());
			int currentPage;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			Pages page = applyInfoService.getApplyInfoListInfo(this.getPages().getPageSize(), currentPage, map);
			Gson gson = new Gson();
			String json = gson.toJson(page);

			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 添加报名人信息
	 */
	@RequestMapping(value = "/addApplyInfo.do")
	public void addApplyInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String schoolId = request.getParameter("schoolId");
		String userName = request.getParameter("userName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String referrer = request.getParameter("referrer");
		String remark = request.getParameter("remark");
		String birth = request.getParameter("birth");
		String sex = request.getParameter("sex");
		String newsId = request.getParameter("newsId");
		ApplyInfo su = new ApplyInfo();
		su.setBirth(birth);
		su.setAddress(address);
		su.setReferrer(referrer);
		su.setRemark(remark);
		su.setPhone(phone);
		su.setSchoolId(schoolId);
		su.setSex(sex);
		su.setStatus("0");
		su.setUserName(userName);
		su.setNewsId(newsId);
		DBContextHolder.setDBType(schoolId);
		applyInfoService.addApplyInfo(su);
		Gson gson = new Gson();
		String json = gson.toJson("success");
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	

	/**
	 * 点击查看
	 */
	@RequestMapping(value = "/lookOver.do")
	public String lookOver(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			Integer id = StringUtil.toint(request.getParameter("id"));
			boolean flag = false;
			try
			{
				applyInfoService.updateStatus(id);
				flag = true;
			} catch (Exception e)
			{
				flag = false;
			}
			Gson gson = new Gson();
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入活动信息采集页面
	 */
	@RequestMapping(value = "/toActivityInfoList.do")
	public String toActivityInfoList()
	{
		return "applyInfo/activity_list";
	}
	
	/**
	 * 获取活动信息
	 */
	@RequestMapping(value = "/getTakePartInActivity.do")
	public void getTakePartInActivity(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String createTime = request.getParameter("createTime");
			String queryContent = request.getParameter("queryContent");
			HashMap<String, Object> map = new HashMap<String, Object>();
			User user = (User) session.getAttribute("user");
			map.put("createTime", createTime);
			map.put("queryContent", queryContent);
			map.put("schoolId", user.getSchoolId());
			int currentPage;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			Pages page = applyInfoService.getTakePartInActivity(this.getPages().getPageSize(), currentPage, map);
			Gson gson = new Gson();
			String json = gson.toJson(page);

			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 添加参加活动人员信息
	 */
	@RequestMapping(value = "/addTakePartInActivity.do")
	public void addTakePartInActivity(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String schoolId = request.getParameter("schoolId");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			String schoolYear = request.getParameter("schoolYear");
			String linkMan = request.getParameter("linkMan");
			String linkPhone = request.getParameter("linkPhone");
			String adultNum = request.getParameter("adultNum");
			String childNum = request.getParameter("childNum");
			String newsId = request.getParameter("newsId");
			TakePartInActivity activity = new TakePartInActivity();
			activity.setName(name);
			activity.setSex(StringUtil.toint(sex));
			activity.setSchoolYear(schoolYear);
			activity.setLinkMan(linkMan);
			activity.setLinkPhone(linkPhone);
			activity.setAdultNum(StringUtil.toint(adultNum));
			activity.setChildNum(StringUtil.toint(childNum));
			activity.setSchoolId(schoolId);
			activity.setNewsId(StringUtil.toint(newsId));
			activity.setCreateTime(TimeUtil.getInstance().now());
			DBContextHolder.setDBType(schoolId);

			applyInfoService.addTakePartInActivity(activity);
			Gson gson = new Gson();
			String json = gson.toJson("success");
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
