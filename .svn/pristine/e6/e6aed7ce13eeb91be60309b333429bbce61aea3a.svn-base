package com.guotop.palmschool.schoolbus.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSchedule;
import com.guotop.palmschool.schoolbus.service.SchoolBusScheduleService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.TimeUtil;


/**
 * 校车时间设定控制类
 */
@RequestMapping("/schoolbusSchedule")
@Controller
public class SchoolBusScheduleController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private SchoolBusScheduleService schoolBusScheduleService;

	@Resource
	private UserService userService;

	/**
	 * 进入校车时间设定页面
	 */
	@RequestMapping(value = "/toSchoolBusScheduleList.do")
	public String toSchoolBusScheduleList()
	{
		return "schoolbus/schoolbus_schedule_list";
	}
	
	/**
	 *  加载校车时间设定List
	 */
	@RequestMapping(value = "/loadSchoolBusScheduleList.do")
	public String loadSchoolBusScheduleList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		User loginUser = (User) session.getAttribute("user");
		
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
			
			// 获取分页数据
			Pages pages = schoolBusScheduleService.getSchoolBusScheduleList(this.getPages().getPageSize(), currentPage, loginUser);

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
	 *  加载校车时间设定List
	 */
	@RequestMapping(value = "/getSchoolBusScheduleListByDay.do")
	public String getSchoolBusScheduleListByDay(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try {
			response.setCharacterEncoding("UTF-8");
			String date = request.getParameter("date");
			List<SchoolBusSchedule> list = schoolBusScheduleService.getSchoolBusScheduleListByDay(date);
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入增加时间设定页面
	 */
	@RequestMapping(value="/toAddSchoolBusSchedule.do")
	public String toAddSchoolBusSchedule(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");
		
		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", user);
		
		return "schoolbus/schoolbus_schedule_add";
	}
	
	/**
	 * 执行增加逻辑
	 */
	@RequestMapping(value="/doAddSchoolBusSchedule.do")
	public String doAddSchoolBusSchedule(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 开始日期 
		 */
		String startDay = request.getParameter("startDay");
		
		/**
		 *  结束日期
		 */
		String endDay = request.getParameter("endDay");
		
		/**
		 * 早上，下午，晚上的checkbox
		 */
		String[] timeCheckBox = request.getParameterValues("timeCheckBox");
		
		List<SchoolBusSchedule> scheduleList = getScheduleList(startDay, endDay);
		for (SchoolBusSchedule schedule : scheduleList)
		{
			if(null != timeCheckBox && timeCheckBox.length > 0)
			{	
				for (int i = 0; i < timeCheckBox.length; i++)
				{
					if ("morningOffSchoolBus".equals(timeCheckBox[i]))
					{
						schedule.setStartTime(request.getParameter("morningOffSchoolBusStart"));
						schedule.setEndTime(request.getParameter("morningOffSchoolBusEnd"));
						schedule.setType(2);
						schedule.setCreateTime(TimeUtil.getInstance().now());
						schoolBusScheduleService.addSchoolBusSchedule(schedule);
					}
					else if ("morningOnSchoolBus".equals(timeCheckBox[i]))
					{
						schedule.setStartTime(request.getParameter("morningOnSchoolBusStart"));
						schedule.setEndTime(request.getParameter("morningOnSchoolBusEnd"));
						schedule.setType(1);
						schedule.setCreateTime(TimeUtil.getInstance().now());
						schoolBusScheduleService.addSchoolBusSchedule(schedule);
					}
					else if ("afternoonOffSchoolBus".equals(timeCheckBox[i]))
					{
						schedule.setStartTime(request.getParameter("afternoonOffSchoolBusStart"));
						schedule.setEndTime(request.getParameter("afternoonOffSchoolBusEnd"));
						schedule.setType(2);
						schedule.setCreateTime(TimeUtil.getInstance().now());
						schoolBusScheduleService.addSchoolBusSchedule(schedule);
					}else if ("afternoonOnSchoolBus".equals(timeCheckBox[i]))
					{
						schedule.setStartTime(request.getParameter("afternoonOnSchoolBusStart"));
						schedule.setEndTime(request.getParameter("afternoonOnSchoolBusEnd"));
						schedule.setType(1);
						schedule.setCreateTime(TimeUtil.getInstance().now());
						schoolBusScheduleService.addSchoolBusSchedule(schedule);
					}
				}
			}
		}
		return "schoolbus/schoolbus_schedule_list";
	}
	
	
	/**
	 * 根据一个时间段获取该时间区间的作息表集合
	 * @param beginTime 起始时间
	 * @param endTime 结束时间
	 * @return 作息表集合
	 */
	public List<SchoolBusSchedule> getScheduleList(String beginTime, String endTime)
	{
		/**
		 * 时间格式
		 */
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
		
		List<SchoolBusSchedule> scheduleList = new ArrayList<SchoolBusSchedule>();
		
		try
		{
			Date beginDate = formatter.parse(beginTime);
			Date endDate = formatter.parse(endTime);
			List<Date> dateList = dateSplit(beginDate, endDate);
			
			for (Date date : dateList)
			{
				SchoolBusSchedule schoolBusSchedule = new SchoolBusSchedule();
				schoolBusSchedule.setDay(formatter.format(date));
				scheduleList.add(schoolBusSchedule);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return scheduleList;
	}
	
	/**
	 * 根据时间段划分一个时间区间
	 * @param startDate 起始时间
	 * @param endDate 结束时间
	 * @return 时间区间
	 * @throws Exception
	 */
	private List<Date> dateSplit(Date startDate, Date endDate) throws Exception 
    {
		Long spi = endDate.getTime() - startDate.getTime();
		Long step = spi / (24 * 60 * 60 * 1000);// 相隔天数

		List<Date> dateList = new ArrayList<Date>();
		dateList.add(startDate);
		for (int i = 0; i < step; i++) 
		{
			dateList.add(new Date(dateList.get(0 + i).getTime()
				+ (24 * 60 * 60 * 1000)));// 比上一天加一
		}
		return dateList;
	}
	
	/**
	 * 进入修改页面
	 */
	@RequestMapping(value="/toModifySchoolBusSchedule.do")
	public String toModifySchoolBusSchedule(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		Integer id = Integer.valueOf(request.getParameter("id"));
		
		modelMap.addAttribute("id", id);
		
		return "schoolbus/schoolbus_schedule_modify";
	}
	
	/**
	 * 加载信息(为了修改)
	 */
	@RequestMapping(value="/loadSchoolBusScheduleDetail.do")
	public String loadSchoolBusScheduleDetail(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{	
			Integer id = Integer.valueOf(request.getParameter("id"));
			SchoolBusSchedule schoolBusSchedule = schoolBusScheduleService.getSchoolBusScheduleById(id);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(schoolBusSchedule);
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
	 * 执行修改设备逻辑
	 */
	@RequestMapping(value="/doModifySchoolBusSchedule.do")
	public String doModifySchoolBusSchedule(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		Integer id = Integer.valueOf(request.getParameter("id"));
		
		
		/**
		 *  开始时间
		 */
		String startTime = request.getParameter("startTime");
		
		/**
		 * 结束时间
		 */
		String endTime = request.getParameter("endTime");
		
		paramMap.put("id",id);
		paramMap.put("startTime", startTime);
		paramMap.put("endTime",endTime);
		
		/**
		 * 修改时间
		 */
		schoolBusScheduleService.modifyschoolBusScheduleSById(paramMap);
		return "schoolbus/schoolbus_schedule_list";
	}

}
