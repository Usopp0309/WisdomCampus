package com.guotop.palmschool.meeting.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.guotop.palmschool.meeting.entity.MeetingDetail;
import com.guotop.palmschool.meeting.service.MeetingDetailService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.CollectionUtil;
import com.guotop.palmschool.util.Pages;

/**
 * 会议记录控制类
 * 我的会议记录控制类
 * 
 * @author
 */
@RequestMapping("/meetingDetail")
@Controller
public class MeetingDetailController extends BaseController
{
	@Resource
	private MeetingDetailService meetingDetailService;

	@Resource
	private CommonService commonService;

	@Resource
	private UserService userService;

	/**
	 * 进入会议记录页面
	 */
	@RequestMapping(value = "/toMeetingDetailList.do")
	public String toMeetingDetailList()
	{
		return "meeting/my_meeting_list";
	}
	
	@RequestMapping(value = "/toMeetingDetailApp.do")
	public String toMeetingDetailApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		User user = (User) session.getAttribute("user");
		
		Integer meetingId = Integer.parseInt(request.getParameter("meetingId"));
		Integer currentPage = 1;
		try
		{
			currentPage = Integer.valueOf(request.getParameter("cPage"));
		} catch (Exception e)
		{
			currentPage = 1;
		}
		/**
		 * 获取分页数据
		 */
		this.getPages().setPageSize(50);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("meetingId", meetingId);
		
		List<MeetingDetail>details = meetingDetailService.getMeetingDetailByMeetingIdAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
		modelMap.addAttribute("meetingList", details);
		
		return "app/meeting/meeting_detail_list_app";
	}

	/**
	 * 不同权限查看到不同的page 查看不同的会议记录List 20151208
	 */
	@RequestMapping(value = "/loadMeetingDetailList.do")
	public String loadMeetingDetailList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			//分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			//会议名称
			String name = request.getParameter("name");
			//会议地点
			String meetingPlace = request.getParameter("meetingPlaceName");
			User user = (User) session.getAttribute("user");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", user.getUserId());
			paramMap.put("name", name);
			paramMap.put("meetingPlace", meetingPlace);

			this.getPages().setPageSize(50);
			Pages pages = meetingDetailService.getMeetingDetailByUserId(this.getPages().getPageSize(), currentPage, paramMap, user);

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
	 * 根据id查询
	 * @return
	 */
	@RequestMapping(value = "/selectMeetingDetailById.do")
	public String selectMeetingDetailById(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap){
		response.setCharacterEncoding("UTF-8");
		Integer id = Integer.parseInt(request.getParameter("id"));
		try {
			MeetingDetail detail = meetingDetailService.selectMeetingDetailById(id);
			Gson gson = new Gson();
			String json = gson.toJson(detail);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/* ----------手机端begin------------- */
	
	@RequestMapping(value = "/toMeetingDetailListByHuxinId.do")
	public String toMeetingDetailListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (user == null)
		{
			user = (User) session.getAttribute("user");
			if (user != null)
			{
				modelMap.addAttribute("apiKeyTimeOut", "2");
			} else
			{
				modelMap.addAttribute("apiKeyTimeOut", "1");
				return "app/meeting/my_meeting_list_app";
			}
		} else
		{
			modelMap.addAttribute("apiKeyTimeOut", "2");
		}
		
		session.setAttribute("user", user);
		DBContextHolder.setDBType(schoolId);
		String path = null;
		List<Permission> permissionList = user.getPermissionList();
		for (Permission permission : permissionList)
		{
			if ("meetingRecordManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
			{
				path = "app/meeting/my_meeting_list_app";
				break;
			}
		}
		try
		{
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			//会议名称 会议地点
			String queryContent = request.getParameter("queryContent");
			//参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", user.getUserId());
			paramMap.put("queryContent", queryContent);

			//获取分页数据
			this.getPages().setPageSize(20);
			List<MeetingDetail> list = meetingDetailService.getMeetingDetailByUserIdAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			if(!CollectionUtil.isEmpty(list)){
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				for(MeetingDetail md:list){
					String startTime = md.getStartTime();
					String endTime = md.getEndTime();
					  Date date = formatter.parse(endTime);
					  long startTimeMill = formatter.parse(startTime).getTime();
					  long endTimeMill = date.getTime();
					  
					  Date currentDate = new Date();
					  long currentTime = currentDate.getTime();
					
					  if(md.getInoutType() ==0){
						  md.setStatus(1);
						  continue;
					  }
					  //当前时间>=会议结束时间的情况下就不能签到了
					  if(currentTime >= endTimeMill){
						  md.setStatus(1);
					  }else{
						  //已经签到的同志不允许再次签到
						  if(md.getAttenStatus() == 0 || md.getAttenStatus() == 1 ){
							  md.setStatus(1);
						  }else{
							  //开会前15分钟才能签到
							  if(currentTime + 15*60*1000  >= startTimeMill){
								  md.setStatus(0); 
							  }else{
								  md.setStatus(1); 
							  }
						  }
					  }
				}
			}
			currentPage = currentPage + 1;
			modelMap.addAttribute("meetingList", list);
			modelMap.addAttribute("listSize", list.size());
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("queryContent", queryContent);
			
			String serverName = request.getServerName();
			if(!serverName.startsWith("192.168.0")){
				serverName = "121.199.27.191";
			}
			modelMap.addAttribute("userId", user.getUserId());
			modelMap.addAttribute("serverName", serverName);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return path;
	}

	/**
	 * 加载更多会议详情列表
	 */
	@RequestMapping(value = "/loadMoreMeetingDetailAPP.do")
	public String loadMoreMeetingDetailAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			//会议名称 会议地点
			String queryContent = request.getParameter("queryContent");
			User user = (User) session.getAttribute("user");

			//参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", user.getUserId());
			paramMap.put("queryContent", queryContent);

			this.getPages().setPageSize(20);
			List<MeetingDetail> list = meetingDetailService.getMeetingDetailByUserIdAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			if(!CollectionUtil.isEmpty(list)){
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				for(MeetingDetail md:list){
					String startTime = md.getStartTime();
					String endTime = md.getEndTime();
					  Date date = formatter.parse(endTime);
					  long time = date.getTime();
					  
					  Date currentDate = new Date();
					  long currentTime = currentDate.getTime();
					  //当前时间>=会议结束时间的情况下就不能签到了
					  if(currentTime >= time){
						  md.setStatus(1);
					  }else{
						  if(md.getAttenStatus() == 0 || md.getAttenStatus() == 1 ){
							  md.setStatus(1);
						  }else{
							  md.setStatus(0);
						  }
					  }
				}
			}
			currentPage = currentPage + 1;
			modelMap.addAttribute("meetingList", list);
			modelMap.addAttribute("listSize", list.size());
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("apiKey", apiKey);
			
			
			String serverName = request.getServerName();
			if(!serverName.startsWith("192.168.0")){
				serverName = "121.199.27.191";
			}
			modelMap.addAttribute("userId", user.getUserId());
			modelMap.addAttribute("serverName", serverName);

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
}
