package com.guotop.palmschool.schoolbus.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.PublicResult;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.schoolbus.entity.OnSchoolBus;
import com.guotop.palmschool.schoolbus.entity.PointInfo;
import com.guotop.palmschool.schoolbus.entity.SchoolBusAbnormalDetail;
import com.guotop.palmschool.schoolbus.entity.SchoolBusAbnormalTotal;
import com.guotop.palmschool.schoolbus.service.SchoolBusService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.InoutService;
import com.guotop.palmschool.service.LocationInfoService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.MapDistanceUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.WebWriteFile;

/**
 * 校车管理控制类
 * 
 * @author zhou
 */
@RequestMapping("/schoolbus")
@Controller
public class SchoolBusController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private SchoolBusService schoolBusService;

	@Resource
	private UserService userService;
	
	@Resource
	private ScheduleService scheduleService;
	
	@Resource
	private LocationInfoService locationInfoService;
	
	@Resource
	private InoutService inoutService;
	
	@Resource
	private ClazzService clazzService;

	/**
	 * 进入校车记录页面
	 */
	@RequestMapping(value = "/toSchoolBusOnList.do")
	public String toSchoolBusOnList(HttpSession session, ModelMap modelMap)
	{
		User user = (User)session.getAttribute("user");
		boolean isClassLeader = false;
		OnSchoolBus bus = new OnSchoolBus();
		for (Role role : user.getRoleList()) {
			if(role.getRoleCode().equals("classLeader")){
				isClassLeader = true;
			}
		}
		if(isClassLeader){
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			Date nowDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			long nowDateComp = nowDate.getTime();
			String paramDate = sdf.format(nowDate).split(" ")[0];
			String createTime = paramDate+" 05:00:00";
			String endTime = paramDate+" 22:00:00";
			List<Schedule> scheduleList = scheduleService.selectScheduleListByLiveingDate(paramDate);
			String beginTime="";
			int shangxia = 0;
			String type="1";
			try {
				if(null!=scheduleList){
					for (Schedule schedule : scheduleList) {
						long morningMin = sdf.parse(createTime).getTime();
						long affternoonMin = sdf.parse(endTime).getTime();
						long morningMax = sdf.parse(schedule.getBeginTime()+":00").getTime();
						long affternoonMax = sdf.parse(schedule.getEndTime()+":00").getTime();
						if(morningMin<nowDateComp&&nowDateComp<morningMax){
							beginTime = schedule.getBeginTime();
							shangxia = 1;
						}else if(affternoonMax<nowDateComp&&nowDateComp<affternoonMin){
							beginTime = schedule.getEndTime();
							shangxia=2;
						}
					}
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			bus.setUserId(user.getUserId());
			switch (shangxia) {
				case 1:
					createTime = beginTime.substring(0,10)+"05:00:00";
					endTime = beginTime+":00";
					break;
				case 2:
					createTime =  beginTime+":00";
					endTime = beginTime.substring(0,10)+"22:00:00";
					break;
			}
			paramMap.put("createTime", createTime);
			paramMap.put("endTime", endTime);
			paramMap.put("type", type);
			paramMap.put("userId", user.getUserId());
			List<Clazz> classes =  commonService.loadClazzListByLeaderId(user.getUserId());
			List<OnSchoolBus> codeList = locationInfoService.getPositionListByClassLeaderId(paramMap);
			List<OnSchoolBus> busList = locationInfoService.getBusListByClassLeaderId(paramMap);
			String isZouDu = "false";
			List<User> userList = clazzService.getUserIdListByClazzId(classes.get(0).getId());
			for (User user2 : userList) {
				if(getTypeByUserId(user2.getUserId().toString(),beginTime).getIsZoudu()){
					isZouDu="true";
				}
			}
			modelMap.put("busList", busList);
			modelMap.put("isZoudu", isZouDu);
			modelMap.put("codeList", codeList);
			modelMap.put("bus", bus);
			if("".equals(beginTime)){
				beginTime = sdf.format(new Date());
			}
			modelMap.put("createTime", beginTime);
			return "watchLocation/class_location";
		}
		return "schoolbus/schoolbus_on_list";
	}
	
	/**
	 * 班主任根据姓名查询坐标点，校车最后一次轨迹：画点
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/getSchoolBusPoint.do")
	public void getSchoolBusPoint(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap){
		response.setCharacterEncoding("UTF-8");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String createTime = request.getParameter("createTime");
		String endTime = request.getParameter("endTime");
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String positionId = request.getParameter("positionId");
		String type="1";
		//查询学生
		if(null!=userName&&!"".equals(userName)){
			type="2";
		}
		if(null!=positionId&&!"".equals(positionId)&&!"all".equals(positionId)&&positionId.length()==10){
			PointInfo point = new PointInfo();
			try {
				point.setCreateTime(sdf.parse(createTime));
				point.setEndTime(sdf.parse(endTime));
				point.setCarId(positionId);
				List<PointInfo> pointList = inoutService.findPointByDevide(point);
				Gson gson = new Gson();
				String json = gson.toJson(pointList);
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			try {
				paramMap.put("type", type);
				paramMap.put("userName", userName);
				paramMap.put("createTime", createTime);
				paramMap.put("endTime", endTime);
				paramMap.put("userId", userId);
				List<OnSchoolBus> codeList = locationInfoService.getPositionListByClassLeaderId(paramMap);
				List<OnSchoolBus> busList = locationInfoService.getBusListByClassLeaderId(paramMap);
				List<PointInfo> endPointList = new ArrayList<PointInfo>();
				for (OnSchoolBus onSchoolBus : busList) {
					PointInfo point = new PointInfo();
					point.setCreateTime(sdf.parse(createTime));
					point.setEndTime(sdf.parse(endTime));
					point.setCarId(onSchoolBus.getPosition());
					List<PointInfo> pointList = inoutService.findPointByDevide(point);
					if(null!=pointList&&pointList.size()>0)
					endPointList.add(pointList.get(pointList.size()-1));
				}
				PublicResult pr = new PublicResult();
				pr.setBusList(busList);
				pr.setPointBusList(codeList);
				pr.setPointList(endPointList);
				Gson gson = new Gson();
				String json = gson.toJson(pr);
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 班主任根据姓名查询坐标点，校车轨迹：画线
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 */
	@RequestMapping(value = "/getSchoolBusClassPoint.do")
	public void getSchoolBusClassPoint(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap){
		response.setCharacterEncoding("UTF-8");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String createTime = request.getParameter("createTime");
		String endTime = request.getParameter("endTime");
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String positionId = request.getParameter("position");
		String type="1";
		//查询学生
		if(null!=userName&&!"".equals(userName)){
			type="2";
		}
		try {
			paramMap.put("type", type);
			paramMap.put("userName", userName);
			paramMap.put("createTime", createTime);
			paramMap.put("endTime", endTime);
			paramMap.put("userId", userId);
			List<OnSchoolBus> codeList = locationInfoService.getPositionListByClassLeaderId(paramMap);
			List<OnSchoolBus> busList = locationInfoService.getBusListByClassLeaderId(paramMap);
			PointInfo point = new PointInfo();
			point.setCreateTime(sdf.parse(createTime));
			point.setEndTime(sdf.parse(endTime));
			point.setCarId(positionId);
			List<PointInfo> pointList = inoutService.findPointByDevide(point);
			PublicResult pr = new PublicResult();
			pr.setPointList(pointList);
			pr.setPointBusList(codeList);
			pr.setBusList(busList);
			Gson gson = new Gson();
			String json = gson.toJson(pr);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 进入校车当前位置页面
	 */
	@RequestMapping(value = "/toSchoolBusNowPoint.do")
	public String toSchoolBusNowPoint()
	{
		return "schoolbus/schoolbus_nowpoint_list";
	}
	/**
	 * 手机进入校车当前位置页面
	 */
	@RequestMapping(value = "/toSchoolBusNowPointByPhone.do")
	public String toSchoolBusNowPointByPhone(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String nowPoint = request.getParameter("nowPoint");
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("nowPoint", nowPoint);
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
			}
		}else{
			session.setAttribute("user", user);
			modelMap.addAttribute("apiKeyTimeOut", "2");
			// 角色code
			String roleCode = user.getRoleCode();

			if (roleCode == null || roleCode.equals(""))
			{
				roleCode = user.getRoleList().get(0).getRoleCode();
			}
			modelMap.addAttribute("roleCode", roleCode);
		}
		return "app/schoolbus/schoolbus_status_app";
	}
	/**
	 * 查询该学生是否有查看轨迹按钮（走读生、家长只有上午下午时间段才有，寄宿生都有）
	 * 
	 */
	public OnSchoolBus getTypeByUserId(String userId,String createTime)
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:00");
		long timeHour;
		OnSchoolBus bus = new OnSchoolBus();
		boolean isShow = false;
		boolean isZoudu = true;
		try {
			if(createTime.equals("")){
				timeHour = new Date().getTime();
				createTime = sdf.format(new Date());
			}else{
				timeHour = sdf.parse(createTime+":00").getTime();
			}
			createTime = createTime.split(" ")[0];
			List<Schedule> scheduleList = scheduleService.selectScheduleListByLiveingDate(createTime);
			List<User> userList = userService.getTypeByUserId(userId);
			for (User user : userList) {
				if(null!=user.getType()){
					if(user.getType()==1){
						isZoudu = false;
					}
				}
			}
			if(isZoudu){
				if(null!=scheduleList){
					for (Schedule schedule : scheduleList) {
						long morningMin = sdf.parse(createTime+" 05:00:00").getTime();
						long affternoonMin = sdf.parse(createTime+" 22:00:00").getTime();
						long morningMax = sdf.parse(schedule.getBeginTime()+":00").getTime();
						long affternoonMax = sdf.parse(schedule.getEndTime()+":00").getTime();
						if((morningMin<timeHour&&timeHour<morningMax)||(affternoonMax<timeHour&&timeHour<affternoonMin)){
							isShow = true;
						}
					}
				}
			}else{
				isShow = true;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		bus.setIsZoudu(isZoudu);
		bus.setShow(isShow);
		return bus;
	}
	/**
	 * 手机进入校车当前位置页面
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toSchoolBusNowPointAPP.do")
	public String toSchoolBusNowPointAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		User user = (User)session.getAttribute("user");
		String nowPoint = request.getParameter("nowPoint");
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		try
		{
			// 角色code
			String roleCode = request.getParameter("roleCode");
			// 权限code
			String permissionCode = request.getParameter("permissionCode");
			// 分页数据
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 查询内容
			String queryContent = request.getParameter("queryContent");
			
			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("schoolId", user.getSchoolId());
			paramMap.put("queryContent", queryContent);
			paramMap.put("startPoint", nowPoint);
			
			// 获取分页数据
			Pages pages = schoolBusService.loadAllSchoolBusNowPointsList(this.getPages().getPageSize(), currentPage, paramMap, user);
			List<PointInfo> list = pages.getList();
			for (PointInfo pointInfo : list) {
				PointInfo pi = locationInfoService.getnowPoint(pointInfo.getCarId());
				pointInfo.setDistanceKm(MapDistanceUtil.getDistance(nowPoint, pi.getX()+","+pi.getY()));
			}
			sort(list);
			pages.setList(list);
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
	//按照DistanceKm升序
	private static void sort(List<PointInfo> data) {
		 
        Collections.sort(data, new Comparator<PointInfo>() {
 
			@Override
			public int compare(PointInfo o1, PointInfo o2) {
				Double a = o1.getDistanceKm();
				Double b = o2.getDistanceKm();
                // 升序
                return a.compareTo(b);
			}
        });
    }

	/**
	 * 不同权限查看到不同的page 加载上下校车列表 加载上下校车list
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loadSchoolBusOnList.do")
	public String loadSchoolBusOnList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		User loginUser = (User) session.getAttribute("user");
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			// 用户id
			Integer userId = 0;
			if (request.getParameter("userId") != null && !"undefined".equals(request.getParameter("userId")))
			{
				userId = Integer.valueOf(request.getParameter("userId"));
			}
			// 角色code
			String roleCode = request.getParameter("roleCode");
			// 权限code
			String permissionCode = request.getParameter("permissionCode");
			// 分页数据
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 类型
			String type = "1";
			try
			{
				type = request.getParameter("type");
			} catch (Exception e)
			{
				type = "1";
			}
			// 查询内容
			String queryContent = request.getParameter("queryContent");
			// 班级id
			String clazzId = null;
			try
			{
				clazzId = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzId = null;
			}

			paramMap.put("userId", userId);
			paramMap.put("roleCode", roleCode);
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("schoolId", loginUser.getSchoolId());
			paramMap.put("clazzId", clazzId);
			paramMap.put("type", type);
			paramMap.put("queryContent", queryContent);

			// 获取分页数据
			Pages pages = schoolBusService.loadSchoolBusOnList(this.getPages().getPageSize(), currentPage, paramMap, loginUser);
			List<OnSchoolBus> busList = new ArrayList<OnSchoolBus>();
			for (OnSchoolBus schoolBus : (List<OnSchoolBus>)pages.getList()) {
				OnSchoolBus ob = getTypeByUserId(schoolBus.getUserId().toString(),schoolBus.getCreateTime());
				schoolBus.setShow(ob.isShow());
				schoolBus.setIsZoudu(ob.getIsZoudu());
				busList.add(schoolBus);
			}
			pages.setList(busList);
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
	 * 不同权限查看到不同的page 校车当前位置
	 */
	@RequestMapping(value = "/loadSchoolBusNowPointsList.do")
	public String loadSchoolBusNowPointsList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		User loginUser = (User) session.getAttribute("user");
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		try
		{
			// 用户id
			Integer userId = 0;
			if (request.getParameter("userId") != null && !"undefined".equals(request.getParameter("userId")))
			{
				userId = Integer.valueOf(request.getParameter("userId"));
			}
			// 角色code
			String roleCode = request.getParameter("roleCode");
			// 权限code
			String permissionCode = request.getParameter("permissionCode");
			// 分页数据
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 查询内容
			String queryContent = request.getParameter("queryContent");
			// 班级id
			String clazzId = null;
			try
			{
				clazzId = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzId = null;
			}
			
			paramMap.put("userId", userId);
			paramMap.put("roleCode", roleCode);
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("schoolId", loginUser.getSchoolId());
			paramMap.put("clazzId", clazzId);
			paramMap.put("queryContent", queryContent);
			
			// 获取分页数据
			Pages pages = schoolBusService.loadSchoolBusNowPointsList(this.getPages().getPageSize(), currentPage, paramMap, loginUser);
			
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
	 * 进入校车报表页面
	 */
	@RequestMapping(value = "/toSchoolBusReport.do")
	public String toDormitoryReport()
	{
		return "schoolbus/schoolbus_report";
	}

	@RequestMapping(value = "/toSchoolBusReportByHuxinId.do")
	public String toDormitoryReportByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			/*
			 * 存session
			 */
			session.setAttribute("user", loginUser);

			List<Permission> permissionList = loginUser.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("schoolBusReportManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					return "schoolbus/schoolbus_report";
				}
			}
		}
		return null;

	}

	/**
	 * 加载报表统计总数据 20151209
	 */
	@RequestMapping(value = "/loadTotalData.do")
	public String loadTotalData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());

		User user = (User) session.getAttribute("user");

		String time = "";

		Integer type = Cons.ONSCHOOLBUS_NOSWINGCARD;
		try
		{
			time = request.getParameter("time");

			if (null == time || "".equals(time))
			{
				time = today;
			}

			try
			{
				type = Integer.valueOf(request.getParameter("type"));
			} catch (Exception e)
			{
				type = Cons.ONSCHOOLBUS_NOSWINGCARD;
			}

			String roleCode = request.getParameter("roleCode");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			paramMap.put("type", type);
			paramMap.put("roleCode", roleCode);

			Integer studentSum = schoolBusService.getStudentSum(paramMap, user);

			Integer studentSwingCaerd = schoolBusService.getStudentSwingCard(paramMap, user);

			SchoolBusAbnormalTotal schoolBusAbnormalTotal = new SchoolBusAbnormalTotal();

			if (studentSwingCaerd != 0)
			{

				Integer studentAbnormal = studentSum - studentSwingCaerd;

				schoolBusAbnormalTotal.setStudentSum(studentSum);
				schoolBusAbnormalTotal.setStudentAbnormal(studentAbnormal);
			}

			schoolBusAbnormalTotal.setTime(time);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(schoolBusAbnormalTotal);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 加载报表分组数据
	 */
	@RequestMapping(value = "/loadGroupData.do")
	public String loadGroupData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());

		Integer roleId = Integer.valueOf(request.getParameter("roleId"));
		User user = (User) session.getAttribute("user");

		String time = "";
		Integer type = Cons.ONSCHOOLBUS_NOSWINGCARD;

		try
		{

			time = request.getParameter("time");
			if (null == time || "".equals(time))
			{
				time = today;
			}

			try
			{
				type = Integer.valueOf(request.getParameter("type"));
			} catch (Exception e)
			{
				type = Cons.ONSCHOOLBUS_NOSWINGCARD;
			}

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			paramMap.put("type", type);
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("gradeId", user.getGradeId());
			List<SchoolBusAbnormalTotal> schoolBusAbnormalTotalList = schoolBusService.loadGroupData(paramMap, roleId);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(schoolBusAbnormalTotalList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 加载报表详细数据 20151209
	 */
	@RequestMapping(value = "/loadDetailData.do")
	public String loadDetailData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		String today = formatter.format(new Date());

		User user = (User) session.getAttribute("user");

		String time = "";

		Integer type = Cons.ONSCHOOLBUS_NOSWINGCARD;

		try
		{

			time = request.getParameter("time");

			if (null == time || "".equals(time))
			{
				time = today;
			}

			try
			{
				type = Integer.valueOf(request.getParameter("type"));
			} catch (Exception e)
			{
				type = Cons.ONSCHOOLBUS_NOSWINGCARD;
			}

			/**
			 * 查询
			 */
			String clazzList = null;
			try
			{
				clazzList = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzList = null;
			}

			String itemName = request.getParameter("itemName");

			String queryContent = request.getParameter("queryContent");

			String roleCode = request.getParameter("roleCode");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			paramMap.put("type", type);
			paramMap.put("itemName", itemName);
			paramMap.put("clazzList", clazzList);
			paramMap.put("queryContent", queryContent);
			paramMap.put("roleCode", roleCode);

			List<SchoolBusAbnormalDetail> schoolBusAbnormalDetailList = null;

			if (itemName.startsWith("已刷卡"))
			{
				schoolBusAbnormalDetailList = schoolBusService.getSwingCardDetailData(paramMap, user);
			}
			if (itemName.startsWith("未刷卡"))
			{
				schoolBusAbnormalDetailList = schoolBusService.getNoSwingCardDetailData(paramMap, user);
			}

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(schoolBusAbnormalDetailList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 导出查询记录
	 */
	@RequestMapping(value = "/doExportExcel.do")
	@ResponseBody
	public void doExportExcel(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			response.setCharacterEncoding("UTF-8");
			request.setCharacterEncoding("UTF-8");
			OutputStream outputStream = null;
			outputStream = new BufferedOutputStream(response.getOutputStream());
			Map<String, Object> paramMap = new HashMap<String, Object>();
			/**
			 * 初始化excel各项参数---begin
			 */
			// 创建Excel的工作书册 Workbook,对应到一个excel文档
			HSSFWorkbook wb = new HSSFWorkbook();
			// 创建Excel的工作sheet,对应到一个excel文档的tab
			HSSFSheet sheet = wb.createSheet("校车记录");
			// 创建字体样式
			HSSFFont font = wb.createFont();
			// 创建单元格样式
			HSSFCellStyle style = wb.createCellStyle();
			WebWriteFile.getInstance().init(wb, sheet, font, style);
			/**
			 * 初始化excel各项参数---end
			 */
			HSSFRow row = sheet.createRow(0);
			row.setHeight((short) 500);// 设定行的高度
			// 创建一个Excel的单元格
			HSSFCell cell = row.createCell(0);
			// 给Excel的单元格设置样式和赋值
			cell.setCellValue("卡号");

			style.setWrapText(true);
			cell = row.createCell(1);
			cell.setCellValue("拥有者");

			style.setWrapText(true);
			cell = row.createCell(2);
			cell.setCellValue("状态");

			style.setWrapText(true);
			cell = row.createCell(3);
			cell.setCellValue("电池状态");

			style.setWrapText(true);
			cell = row.createCell(4);
			cell.setCellValue("地点");

			style.setWrapText(true);
			cell = row.createCell(5);
			cell.setCellValue("创建时间");

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
			} catch (Exception e)
			{
				type = null;
			}

			// 获取页面请求参数
			// 卡号
			// String code = request.getParameter("code");

			// 持有者
			// String name = request.getParameter("name");

			// 地点
			String queryContent = request.getParameter("queryContent");
			String roleCode = request.getParameter("roleCode");

			/**
			 * 选定user
			 */
			User user = (User) session.getAttribute("user");
			paramMap.put("userId", user.getUserId());
			paramMap.put("schoolId", user.getSchoolId());
			// System.out.println(user.getName());
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("type", type);
			paramMap.put("gradeId", user.getGradeId());
			paramMap.put("queryContent", queryContent);
			paramMap.put("roleCode", roleCode);
			// paramMap.put("name", name);
			// paramMap.put("position", position);
			paramMap.put("userid", user.getUserId());

			List<OnSchoolBus> OnSchoolBusList = schoolBusService.exportSchoolBusOnList(paramMap, user);
			/**
			 * 页面数据加载---end
			 */

			/**
			 * 将数据写入excel中---begin
			 */
			int i = 1;
			for (OnSchoolBus schoolbus : OnSchoolBusList)
			{
				row = sheet.createRow(i);
				row.setHeight((short) 500);// 设定行的高度
				// 创建一个Excel的单元格
				cell = row.createCell(0);
				// 给Excel的单元格设置样式和赋值
				cell.setCellValue(schoolbus.getCode());

				style.setWrapText(true);
				cell = row.createCell(1);
				// cell.setCellValue(schoolbus.getUserName());
				cell.setCellValue(schoolbus.getRealName());

				style.setWrapText(true);
				cell = row.createCell(2);
				 //System.out.println(schoolbus.getStatus());
				if(schoolbus.getStatus()==null){
					continue;
				}
				switch (schoolbus.getStatus())
				{
				case 0:
					cell.setCellValue("上车");
					break;
				case 1:
					cell.setCellValue("上车");
					break;
				case 2:
					cell.setCellValue("下车");
					break;
				default:
					cell.setCellValue("下车");
					break;
				}

				style.setWrapText(true);
				cell = row.createCell(3);
				// switch (schoolbus.getBattery())
				// {
				// case 0:
				// cell.setCellValue("电压正常");
				// break;
				// case 1:
				// cell.setCellValue("电压正常");
				// break;
				// default:
				// cell.setCellValue("电压正常");
				// break;
				// }

				style.setWrapText(true);
				cell = row.createCell(4);
				cell.setCellValue(schoolbus.getPositionName());

				style.setWrapText(true);
				cell = row.createCell(5);
				cell.setCellValue(schoolbus.getCreateTime());
				i++;
			}
			/**
			 * 将数据写入excel中---end
			 */

			/**
			 * 磁盘创建文件并生出输出流
			 */
			outputStream = new BufferedOutputStream(
					response.getOutputStream());
			// 清空response
			response.reset();
			// 设置response的Header
			response.setHeader( "Content-Disposition", "attachment;filename=" + new String( "校车记录.xls".getBytes("gb2312"), "ISO8859-1" ) ); 
			response.setContentType("application/octet-stream");
			wb.write(outputStream); //将excel文件写入到输出流中
			outputStream.flush();
			response.flushBuffer();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/* 手机端 begin */

	/**
	 * 通过互信ID来访问校车记录 后台接口
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/toSchoolBusOnListByHuxinId.do")
	public String toSchoolBusOnListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
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
				return "app/schoolbus/schoolbus_on_list_app";
			}
		} else
		{
			
			modelMap.addAttribute("apiKeyTimeOut", "2");
		}
		boolean isClassLeader = false;
		for (int i = 0; i < user.getRoleList().size(); i++) {
			Role ur = user.getRoleList().get(i);
			if(ur.getRoleCode().equals("classLeader")){
				isClassLeader = true;
			}
		}
		/*
		 * 存session
		 */
		session.setAttribute("user", user);
		
		DBContextHolder.setDBType(user.getSchoolId());

		Integer userId = user.getUserId();

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		try
		{

			// 角色code
			String roleCode = request.getParameter("roleCode");

			if (roleCode == null || roleCode.equals(""))
			{
				roleCode = user.getRoleList().get(0).getRoleCode();
			}
			
			// 权限code
			String permissionCode = "schoolBusOnManager";
			if(isClassLeader){
				HashMap<String, Object> pm = new HashMap<String, Object>();
				Date nowDate = new Date();
				OnSchoolBus bus = new OnSchoolBus();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				long nowDateComp = nowDate.getTime();
				String paramDate = sdf.format(nowDate).split(" ")[0];
				String createTime = paramDate+" 05:00:00";
				String endTime = paramDate+" 22:00:00";
				List<Schedule> scheduleList = scheduleService.selectScheduleListByLiveingDate(paramDate);
				String beginTime="";
				int shangxia = 0;
				String type="1";
				try {
					if(null!=scheduleList){
						for (Schedule schedule : scheduleList) {
							long morningMin = sdf.parse(createTime).getTime();
							long affternoonMin = sdf.parse(endTime).getTime();
							long morningMax = sdf.parse(schedule.getBeginTime()+":00").getTime();
							long affternoonMax = sdf.parse(schedule.getEndTime()+":00").getTime();
							if(morningMin<nowDateComp&&nowDateComp<morningMax){
								beginTime = schedule.getBeginTime();
								shangxia = 1;
							}else if(affternoonMax<nowDateComp&&nowDateComp<affternoonMin){
								beginTime = schedule.getEndTime();
								shangxia=2;
							}
						}
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
				bus.setUserId(user.getUserId());
				switch (shangxia) {
					case 1:
						createTime = beginTime.substring(0,10)+"05:00:00";
						endTime = beginTime+":00";
						break;
					case 2:
						createTime =  beginTime+":00";
						endTime = beginTime.substring(0,10)+"22:00:00";
						break;
				}
				pm.put("createTime", createTime);
				pm.put("endTime", endTime);
				pm.put("type", type);
				pm.put("userId", user.getUserId());
				List<Clazz> classes =  commonService.loadClazzListByLeaderId(user.getUserId());
				List<OnSchoolBus> codeList = locationInfoService.getPositionListByClassLeaderId(pm);
				List<OnSchoolBus> busList = locationInfoService.getBusListByClassLeaderId(pm);
				String isZouDu = "false";
				List<User> userList = clazzService.getUserIdListByClazzId(classes.get(0).getId());
				for (User user2 : userList) {
					if(getTypeByUserId(user2.getUserId().toString(),beginTime).getIsZoudu()){
						isZouDu="true";
					}
				}
				modelMap.put("busList", busList);
				modelMap.put("isZoudu", isZouDu);
				modelMap.put("codeList", codeList);
				modelMap.put("bus", bus);
				if("".equals(beginTime)){
					beginTime = sdf.format(new Date());
				}
				modelMap.put("createTime", beginTime);
				return "watchLocation/class_location";
			}
			// 分页数据
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 类型
			Integer type = 1;
			try
			{
				type = Integer.valueOf(request.getParameter("type"));
			} catch (Exception e)
			{
				type = 1;
			}
			// 查询内容
			String queryContent = request.getParameter("queryContent");
			// 班级id
			String clazzId = null;
			try
			{
				clazzId = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzId = null;
			}

			paramMap.put("userId", userId);
			paramMap.put("roleCode", roleCode);
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("schoolId", user.getSchoolId());
			paramMap.put("clazzId", clazzId);
			paramMap.put("type", type);
			paramMap.put("queryContent", queryContent);

			// 获取分页数据
			List<OnSchoolBus> list = schoolBusService.loadSchoolBusOnListAPP(this.getPages().getPageSize(), currentPage, paramMap, user);

			currentPage = currentPage + 1;
			modelMap.addAttribute("roleList", user.getRoleList());
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			modelMap.addAttribute("schoolbusList", list);
			modelMap.addAttribute("listSize", list.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("type", type);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("queryContent", queryContent);
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return "app/schoolbus/schoolbus_on_list_app";

	}

	/**
	 * 加载校车记录页面（APP）
	 */
	@RequestMapping(value = "/toLoadMoreSchoolBusInoutList.do")
	public String toLoadMoreSchoolBusInoutList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");

			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			// 角色code
			String roleCode = request.getParameter("roleCode");
			// 权限code
			String permissionCode = "schoolBusOnManager";
			// 分页数据
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 类型
			String type = "1";
			try
			{
				type = request.getParameter("type");
			} catch (Exception e)
			{
				type = "1";
			}
			// 查询内容
			String queryContent = request.getParameter("queryContent");
			// 班级id
			String clazzId = null;
			try
			{
				clazzId = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzId = null;
			}

			User user = (User) session.getAttribute("user");

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("schoolId", schoolId);
			paramMap.put("clazzId", clazzId);
			paramMap.put("type", type);
			paramMap.put("queryContent", queryContent);

			List<OnSchoolBus> list = schoolBusService.loadSchoolBusOnListAPP(this.getPages().getPageSize(), currentPage, paramMap, user);

			currentPage = currentPage + 1;
			modelMap.addAttribute("roleList", user.getRoleList());
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			modelMap.addAttribute("schoolbusList", list);
			modelMap.addAttribute("listSize", list.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("type", type);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("apiKey", apiKey);
			modelMap.addAttribute("schoolId", schoolId);

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
	 * 进入校车搜索页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toSchoolbusOnListSearchAPP.do")
	public String toSchoolbusOnLIstSearchAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");

		User user = (User) session.getAttribute("user");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", "schoolBusOnManager");

		List<Clazz> clazzList = commonService.getClazzList(paramMap);

		modelMap.addAttribute("clazzList", clazzList);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("userId", user.getUserId());

		return "app/schoolbus/schoolbus_on_list_search_app";
	}
	/**
	 * 进入校车当前位置
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toSchoolbusNowPointSearchAPP.do")
	public String toSchoolbusNowPointSearchAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");
		
		User user = (User) session.getAttribute("user");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", "schoolBusOnManager");
		
		List<Clazz> clazzList = commonService.getClazzList(paramMap);
		
		modelMap.addAttribute("clazzList", clazzList);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("userId", user.getUserId());
		
		return "app/schoolbus/schoolbus_on_list_search_app";
	}

}
