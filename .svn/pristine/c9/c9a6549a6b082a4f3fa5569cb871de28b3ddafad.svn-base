package com.guotop.palmschool.meeting.controller;

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
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.meeting.entity.Meeting;
import com.guotop.palmschool.meeting.entity.MeetingInout;
import com.guotop.palmschool.meeting.service.MeetingService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;

/**
 * 会议刷卡记录控制类
 * 
 * @author zhou
 *
 */
@RequestMapping("/meetingInout")
@Controller
public class MeetingInoutController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private MeetingService meetingService;

	@Resource
	private UserService userService;

	/**
	 * 进入进出记录页面
	 */
	@RequestMapping(value = "/toMeetingInout.do")
	public String toMeetingInoutList(HttpServletRequest request, ModelMap modelMap, HttpSession session)
	{
		User user = (User) session.getAttribute("user");
		// 获取最近的会议名称刷卡记录
		Meeting meeting = meetingService.getLatestMeeting(user);
		if (meeting != null)
		{
			modelMap.addAttribute("queryContent", meeting.getName());
			modelMap.addAttribute("inoutType", meeting.getInoutType());
		} else
		{
			modelMap.addAttribute("queryContent", null);
			modelMap.addAttribute("inoutType", null);
		}

		String serverName = request.getServerName();
		if (!serverName.startsWith("192.168.0"))
		{
			serverName = "121.199.27.191";
		}
		modelMap.addAttribute("schoolId", user.getSchoolId());
		modelMap.addAttribute("userId", user.getUserId());
		modelMap.addAttribute("serverName", serverName);
		return "meeting/meeting_inout_list";
	}

	/**
	 * 不同权限查看到不同的page 历史出入记录列表 加载出入记录list 20151209
	 */
	@RequestMapping(value = "/loadMeetingInoutList.do")
	public String loadMeetingInoutList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 出勤状态
			Integer status = 0;
			try
			{
				status = Integer.valueOf(request.getParameter("status"));
			} catch (Exception e)
			{
				status = null;
			}
			// 查询内容
			String queryContent = null;
			try
			{
				queryContent = request.getParameter("queryContent");
			} catch (Exception e)
			{
				queryContent = null;
			}
			// 开始时间
			String startTime = null;
			try
			{
				startTime = request.getParameter("startTime");
			} catch (Exception e)
			{
				startTime = null;
			}
			// 结束时间
			String endTime = null;
			try
			{
				endTime = request.getParameter("endTime");
			} catch (Exception e)
			{
				endTime = null;
			}

			String roleCode = request.getParameter("roleCode");
			int inoutType = StringUtil.toint(request.getParameter("inoutType"));
			User user = (User) session.getAttribute("user");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("status", status);
			paramMap.put("queryContent", queryContent);
			paramMap.put("startTime", startTime);
			paramMap.put("endTime", endTime);

			this.getPages().setPageSize(50);
			Pages pages = null;
			if (inoutType == 0)
			{
				pages = meetingService.getMeetingInoutList(this.getPages().getPageSize(), currentPage, paramMap, user);
			} else
			{
				pages = meetingService.getMeetingInoutWifiList(this.getPages().getPageSize(), currentPage, paramMap);
			}
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

	/* ----------------------手机端 begin--------------------------- */
	@RequestMapping(value = "/toMeetingInoutByHuxinId.do")
	public String toMeetingInoutListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String path = null;

		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			session.setAttribute("user", loginUser);
			DBContextHolder.setDBType(loginUser.getSchoolId());

			List<Permission> permissionList = loginUser.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("meetingInoutManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					path = "app/meeting/meeting_inout_list_app";
					break;
				}
			}
			try
			{
				// 分页信息
				Integer currentPage = 1;
				try
				{
					currentPage = Integer.valueOf(request.getParameter("cPage"));
				} catch (Exception e)
				{
					currentPage = 1;
				}
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId", loginUser.getUserId());

				String queryContent = request.getParameter("queryContent");
				int inoutType = StringUtil.toint(request.getParameter("inoutType"));
				if (!StringUtil.isEmpty(queryContent))
				{
					Meeting meeting = meetingService.getMeetingByName(loginUser, queryContent);
					if (meeting != null)
					{
						queryContent = meeting.getName();
						inoutType = StringUtil.toint(meeting.getInoutType());
					}
				} else
				{
					// 获取最近的会议名称刷卡记录
					Meeting meeting = meetingService.getLatestMeeting(loginUser);
					if (meeting != null)
					{
						queryContent = meeting.getName();
						inoutType = StringUtil.toint(meeting.getInoutType());
					}
				}
				paramMap.put("queryContent", queryContent);
				// 出勤状态
				Integer status = 0;
				try
				{
					status = Integer.valueOf(request.getParameter("status"));
				} catch (Exception e)
				{
					status = null;
				}
				paramMap.put("status", status);
				this.getPages().setPageSize(20);
				List<MeetingInout> list = new ArrayList<MeetingInout>();
				if (inoutType == 0)
				{ // 会议签到方式0:刷卡 1:wifi签到
					list = meetingService.getMeetingInoutListAPP(this.getPages().getPageSize(), currentPage, paramMap, loginUser);
				} else if (inoutType == 1)
				{
					list = meetingService.getMeetingInoutListWifiAPP(this.getPages().getPageSize(), currentPage, paramMap, loginUser);
				}
				currentPage = currentPage + 1;
				modelMap.addAttribute("meetingInoutList", list);
				modelMap.addAttribute("listSize", list.size());
				modelMap.addAttribute("cPage", currentPage);
				modelMap.addAttribute("queryContent", queryContent);
				modelMap.addAttribute("inoutType", inoutType);
				modelMap.addAttribute("status", status);
			} catch (Exception e)
			{
				e.printStackTrace();
			}
			modelMap.addAttribute("apiKeyTimeOut", "2");
		} else
		{
			modelMap.addAttribute("apiKeyTimeOut", "1");
			return "app/meeting/meeting_inout_list_app";
		}
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("apiKey", apiKey);
		return path;
	}

	/**
	 * 不同权限查看到不同的page 历史出入记录列表 加载出入记录list 20151209
	 */
	@RequestMapping(value = "/loadMoreMeetingInoutListAPP.do")
	public String loadMoreMeetingInoutListAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			String apiKeyTimeOut = request.getParameter("apiKeyTimeOut");
			// 分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 查询内容
			String queryContent = null;
			try
			{
				queryContent = request.getParameter("queryContent");
			} catch (Exception e)
			{
				queryContent = null;
			}
			// 出勤状态
			Integer status = 0;
			try
			{
				status = Integer.valueOf(request.getParameter("status"));
			} catch (Exception e)
			{
				status = null;
			}
			int inoutType = StringUtil.toint(request.getParameter("inoutType"));
			User user = (User) session.getAttribute("user");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", user.getUserId());
			paramMap.put("queryContent", queryContent);
			paramMap.put("status", status);
			List<MeetingInout> list = new ArrayList<MeetingInout>();
			this.getPages().setPageSize(20);
			if (inoutType == 0)
			{ // 会议签到方式0:刷卡 1:wifi签到
				list = meetingService.getMeetingInoutListAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			} else if (inoutType == 1)
			{
				list = meetingService.getMeetingInoutListWifiAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			}
			currentPage = currentPage + 1;
			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("apiKey", apiKey);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("meetingInoutList", list);
			modelMap.addAttribute("inoutType", inoutType);
			modelMap.addAttribute("apiKeyTimeOut", apiKeyTimeOut);
			modelMap.addAttribute("status", status);

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
	 * 进入会议进程搜索页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toMeetingInoutSearchAPP.do")
	public String toMeetingInoutSearchAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		// 出勤状态
		Integer status = 0;
		try
		{
			status = Integer.valueOf(request.getParameter("status"));
		} catch (Exception e)
		{
			status = null;
		}
		// 查询内容
		String queryContent = null;
		try
		{
			queryContent = request.getParameter("queryContent");
		} catch (Exception e)
		{
			queryContent = null;
		}

		User user = (User) session.getAttribute("user");
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("status", status);
		modelMap.addAttribute("queryContent", queryContent);
		modelMap.addAttribute("userId", user.getUserId());

		return "app/meeting/meeting_inout_list_search_app";
	}
}
