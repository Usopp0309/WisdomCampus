package com.guotop.palmschool.check.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.guotop.palmschool.check.entity.AttendanceCurrentDateInout;
import com.guotop.palmschool.check.entity.AttendanceStatistic;
import com.guotop.palmschool.check.entity.CheckAttendance;
import com.guotop.palmschool.check.entity.StudentCheck;
import com.guotop.palmschool.check.entity.TeacherAttendance;
import com.guotop.palmschool.check.entity.TeacherCheck;
import com.guotop.palmschool.check.service.CheckService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.guotop.palmschool.util.WebWriteFile;

import dev.gson.GsonHelper;

/**
 * 考勤相关控制类
 * 
 * @author zhou
 */

@RequestMapping("/check")
@Controller
public class CheckController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(CheckController.class);
	@Resource
	private CommonService commonService;

	@Resource
	private CheckService checkService;

	@Resource
	private UserService userService;
	
	@Resource
	private ScheduleService scheduleService;
	
	@Resource
	private DepartmentService departmentService;
	/**
	 * 进入检测记录页面
	 */
	@RequestMapping(value = "/toCheckList.do")
	public String toCheckList()
	{
		return "safeSchool/check_list";
	}

	@RequestMapping(value = "/toCheckListByHuxinId.do")
	public String toCheckListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
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
			return "safeSchool/check_list";
		} else
		{
			return null;
		}
	}

	/**
	 * 不同权限查看到不同的page 加载检测记录list
	 */
	@RequestMapping(value = "/loadCheckList.do")
	public String loadCheckList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			// Integer userId = Integer.valueOf(request.getParameter("userId"));
			// Integer roleId = Integer.valueOf(request.getParameter("roleId"));
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
			//
			//
			// List<User> loginUser = (List<User>) session.getAttribute("user");
			//
			// /**
			// * 选定user
			// */
			// User user =
			// commonService.selectUserFromSessionByUserId(loginUser, userId,
			// roleId);
			/*
			 * 获取数据
			 */
			/*
			 * 检测类型
			 */
			Integer period = 1;
			try
			{
				period = Integer.valueOf(request.getParameter("period"));
				if (-1 == period)
				{
					period = null;
				}
			} catch (Exception e)
			{
				period = null;
			}

			paramMap.put("period", period);

			Pages pages = checkService.loadCheckList(this.getPages().getPageSize(), currentPage, paramMap);

			/**
			 * flush到页面
			 */
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
	 * 不同权限查看到不同的page 加载教师考勤记录list
	 */
	@RequestMapping(value = "/toTeacherCheckList.do")
	public String toTeacherCheckList()
	{
		return "check/teacher_checklist";
	}

	/**
	 * 不同权限查看到不同的page 加载教师考勤list
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loadTeacherCheckList.do",method = RequestMethod.POST)
	public String loadTeacherCheckList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			User loginUser = (User) session.getAttribute("user");
			Integer userId = loginUser.getUserId();
			//分页信息
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			
			//form 1:教师考勤  2.教师考勤补录  
			String from =request.getParameter("from");
			//科室ID/部门
			Integer departmentId = null;
			try
			{
				String d=request.getParameter("departmentId");
				if (StringUtil.isEmpty(d))
				{
					departmentId = null;
				}else{
					departmentId = Integer.valueOf(d);
				}
			} catch (Exception e)
			{
				departmentId = null;
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

			String createDate = request.getParameter("createDate");
			if(!StringUtil.isEmpty(createDate)){
				paramMap.put("createDate", createDate);
			}
			paramMap.put("departmentId", departmentId);
			if(!StringUtil.isEmpty(queryContent)){
				paramMap.put("queryContent", queryContent);
			}
			
			if(!StringUtil.isEmpty(startTime) && startTime !="null"){
				paramMap.put("startTime", startTime);
			}
			if(!StringUtil.isEmpty(endTime) && endTime !="null"){
				paramMap.put("endTime", endTime);
			}
			
			paramMap.put("userId", userId);

			this.getPages().setPageSize(100);
			Pages pages = checkService.getTeacherCheckList(this.getPages().getPageSize(), currentPage, paramMap, loginUser);
			if("1".equals(from)){
				List<Schedule> schedulelist = scheduleService.selectScheduleListByLiveingDate(TimeUtil.getInstance().date());
				Integer scheduleType = 1;
				if(!CollectionUtils.isEmpty(schedulelist))
				{
					Schedule schedule = schedulelist.get(0);
					scheduleType = schedule.getType();
				}
				List<TeacherAttendance> list = pages.getList();
				Map<String,TeacherAttendance> attendanceMap = new HashMap<String, TeacherAttendance>();
				final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				if(!CollectionUtils.isEmpty(list)){
					for(TeacherAttendance teacherAttendance : list){
						teacherAttendance.setScheduleType(scheduleType);
						AttendanceCurrentDateInout inout = new AttendanceCurrentDateInout();
						if(!StringUtil.isEmpty(teacherAttendance.getInoutTime())){
							inout.setInoutTime(teacherAttendance.getInoutTime().split(" ")[1]);
						}else{
							inout.setInoutTime(teacherAttendance.getRemark());
						}
						inout.setRemark(teacherAttendance.getRemark());
						inout.setStatus(teacherAttendance.getStatus());
						inout.setStatusName(teacherAttendance.getStatusName());
						
						//以createTime和userId作为分组的条件
						String key =teacherAttendance.getuId() + "_"+teacherAttendance.getCreateTime(); 
						if(!attendanceMap.containsKey(key)){
							teacherAttendance.getCurrentDateInoutlist().add(inout);					
							attendanceMap.put(key, teacherAttendance);
						}else{
							teacherAttendance = attendanceMap.get(key);
							teacherAttendance.getCurrentDateInoutlist().add(inout);
						}
						if(!CollectionUtils.isEmpty(teacherAttendance.getCurrentDateInoutlist())){
							Collections.sort(teacherAttendance.getCurrentDateInoutlist(), new Comparator<AttendanceCurrentDateInout>()
									{
										public int compare(AttendanceCurrentDateInout ac1, AttendanceCurrentDateInout ac2)
										{
											try
											{
												return ac1.getStatus().compareTo(ac2.getStatus());
											} catch (Exception e)
											{
												return -1;
											}
										}
									});
						}
					}
				}
				
				List<TeacherAttendance> newList = new ArrayList<TeacherAttendance>(attendanceMap.values());
				Collections.sort(newList, new Comparator<TeacherAttendance>()
						{
							public int compare(TeacherAttendance tc1, TeacherAttendance tc2)
							{
								try
								{
									Long millionSeconds1 = sdf.parse(tc1.getTime()).getTime();
									Long millionSeconds2 = sdf.parse(tc2.getTime()).getTime();//毫秒
									return millionSeconds2.compareTo(millionSeconds1);
								} catch (ParseException e)
								{
									return -1;
								}
							}
						});
				pages.setList(newList);
			}
			
			
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("加载教师考勤list，错误信息如下："+e);
		}
		return null;
	}

	/**
	 * 不同权限查看到不同的page 加载学生考勤记录list
	 */
	@RequestMapping(value = "/toStudentCheckList.do")
	public String toStudentCheckList()
	{
		return "check/student_checklist";
	}

	/**
	 * 不同权限查看到不同的page 加载学生考勤list
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loadStudentCheckList.do",method = RequestMethod.POST)
	public String loadStudentCheckList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		Map<String, Object> paramMap = new HashMap<String, Object>();

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

			//form 1:学生考勤  2.学生考勤补录  
			String from =request.getParameter("from");
			/**
			 * 学号
			 */
			String queryContent = request.getParameter("queryContent");
			// 角色
			String roleCode = request.getParameter("roleCode");
			//日期
			String todayTime = request.getParameter("todayTime");

			User user = (User) session.getAttribute("user");
			
			Integer clazzId = null;
			try
			{
				clazzId = Integer.valueOf(request.getParameter("clazzId"));
				if (0 == clazzId)
				{
					clazzId = null;
				}
			} catch (Exception e)
			{
				clazzId = null;
			}

			paramMap.put("clazzId", clazzId);
			paramMap.put("roleCode", roleCode);
			paramMap.put("queryContent", queryContent);
			paramMap.put("todayTime", todayTime);

			this.getPages().setPageSize(100);
			Pages pages = checkService.loadStudentCheckList(this.getPages().getPageSize(), currentPage, paramMap, user);
			if("1".equals(from)){
				List<Schedule> schedulelist = scheduleService.selectScheduleListByLiveingDate(TimeUtil.date());
				Integer scheduleType = 1;
				if(!CollectionUtils.isEmpty(schedulelist))
				{
					Schedule schedule = schedulelist.get(0);
					scheduleType = schedule.getType();
				}
				List<StudentCheck> list = pages.getList();
				Map<String,StudentCheck> studentCheckMap = new HashMap<String, StudentCheck>();
				if(!CollectionUtils.isEmpty(list)){
					for(StudentCheck studentCheck : list){
						studentCheck.setScheduleType(scheduleType);
						AttendanceCurrentDateInout inout = new AttendanceCurrentDateInout();
						if(!StringUtil.isEmpty(studentCheck.getInoutTime())){
							inout.setInoutTime(studentCheck.getInoutTime().split(" ")[1]);
						}else{
							inout.setInoutTime(studentCheck.getRemark());
						}
						inout.setStatus(studentCheck.getStatus());
						inout.setStatusName(studentCheck.getStatusName());
						
						//以createTime和userId作为分组的条件
						String key =studentCheck.getuId() + "_"+studentCheck.getUpdateTime(); 
						if(!studentCheckMap.containsKey(key)){
							studentCheck.getCurrentDateInoutlist().add(inout);					
							studentCheckMap.put(key, studentCheck);
						}else{
							studentCheck = studentCheckMap.get(key);
							studentCheck.getCurrentDateInoutlist().add(inout);
						}
					}
				}
				
				List<StudentCheck> newList = new ArrayList<StudentCheck>(studentCheckMap.values());
				final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				Collections.sort(newList, new Comparator<StudentCheck>()
						{
							public int compare(StudentCheck sc1, StudentCheck sc2)
							{
								try
								{
									Long millionSeconds1 = sdf.parse(sc1.getTime()).getTime();
									Long millionSeconds2 = sdf.parse(sc2.getTime()).getTime();//毫秒
									return millionSeconds2.compareTo(millionSeconds1);
								} catch (ParseException e)
								{
									return -1;
								}
							}
						});
				pages.setList(newList);
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
	
	
	/**
	 * 加载班级信息 20160307
	 * @return
	 */
	@RequestMapping(value = "/loadClazzList.do",method=RequestMethod.POST)
	public String loadClazzList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();

		/*
		 * 取出选中的用户
		 */
		User user = (User) session.getAttribute("user");

		// 查询传入页面权限编码
		String permissionCode = request.getParameter("permissionCode");
		
		String roleCode = request.getParameter("roleCode");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", permissionCode);
		paramMap.put("roleCode", roleCode);

		List<Clazz> clazzList = commonService.getClazzListByRoleCode(paramMap);

		try
		{
			String json = gson.toJson(clazzList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 导出查询记录 学生卡考勤记录
	 */
	@RequestMapping(value = "/doExportExcelForStudent.do")
	public void doExportExcelForStudent(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			//部门Id
			String clazzId = request.getParameter("clazzId");
			// 角色
			String roleCode = request.getParameter("roleCode");
			// 开始时间
			String startTime = request.getParameter("startTime");
			// 结束时间
			String endTime = request.getParameter("endTime");
			User user = (User) session.getAttribute("user");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", user.getUserId());
			paramMap.put("schoolId", user.getSchoolId());
			
			if((!StringUtil.isEmpty(clazzId)) && (!"all".equals(clazzId))){
				paramMap.put("clazzId", clazzId);	
			}		
			paramMap.put("roleCode", roleCode);
			paramMap.put("startTime", startTime+" 00:00:00");
			paramMap.put("endTime", endTime+" 23:59:59");
			paramMap.put("permissionCode", "studentAttendanceManager");
			
			List<StudentCheck> studentCheckList = checkService.getStudentCheckListForExcel(paramMap, user);
			List<Schedule> schedulelist = scheduleService.selectScheduleListByLiveingDate(TimeUtil.date());
			//（0分段，1整天)
			Integer scheduleType = 1;
			if(!CollectionUtils.isEmpty(schedulelist))
			{
				Schedule schedule = schedulelist.get(0);
				scheduleType = schedule.getType();
			} 
			//key:班级名字     value:第二个Map userId_班级名字  value：StudentCheck
			Map<String, Map<String, StudentCheck>> clazzNameMap = new HashMap<String, Map<String, StudentCheck>>();
			//key：userId+班级名字  StudentCheck
			Map<String, StudentCheck> userIdAndClazzTAMap = new HashMap<String, StudentCheck>();; 
			//key：userId+createDate value ： StudentCheck
			Map<String,StudentCheck> dateTAMap = new HashMap<String, StudentCheck>();
				for(StudentCheck tmp : studentCheckList)
				{
					String clazzName =  tmp.getGradeName();
					String createDate = tmp.getUpdateTime();
					Integer userId = tmp.getuId();
					String inoutTime = tmp.getInoutTime();
					
					AttendanceCurrentDateInout inout = new AttendanceCurrentDateInout();
					if(!StringUtil.isEmpty(inoutTime)){
						inout.setInoutTime(inoutTime.split(" ")[1]);
					}else{
						if(StringUtil.isEmpty(tmp.getRemark())){
							inout.setInoutTime("无刷卡");
						}else{
							inout.setInoutTime(tmp.getRemark());
						}
						
					}
					inout.setRemark(tmp.getRemark());
					inout.setStatus(tmp.getStatus());
					inout.setStatusName(tmp.getStatusName());
					
					//以userId和createDate作为分组的条件
					String dateTAMap_key = userId + "_"+createDate; 
					if(!dateTAMap.containsKey(dateTAMap_key))
					{
						tmp.getCurrentDateInoutlist().add(inout);					
						dateTAMap.put(dateTAMap_key, tmp);
					}else
					{
						tmp = dateTAMap.get(dateTAMap_key);
						tmp.getCurrentDateInoutlist().add(inout);
					}
					
					if(!clazzNameMap.containsKey(clazzName))
					{
						userIdAndClazzTAMap = new HashMap<String, StudentCheck>();
						clazzNameMap.put(clazzName, userIdAndClazzTAMap);
					}else{
						userIdAndClazzTAMap = clazzNameMap.get(clazzName);
					}
					
					//以userId和部门名称组成的key
					String userIdAndClazzTAMap_key = userId+"_"+clazzName;
					StudentCheck studentCheck;
					if(!userIdAndClazzTAMap.containsKey(userIdAndClazzTAMap_key))
					{
						studentCheck = tmp;
						studentCheck.setScheduleType(scheduleType);						
						studentCheck.getDateMap().put(createDate, tmp);
						userIdAndClazzTAMap.put(userIdAndClazzTAMap_key, studentCheck);
					}else
					{
						studentCheck = userIdAndClazzTAMap.get(userIdAndClazzTAMap_key);
						studentCheck.getDateMap().put(createDate, tmp);
					}
				}
				// 创建Excel的工作书册 Workbook,对应到一个excel文档
				HSSFWorkbook wb = new HSSFWorkbook();
				Set<String> keySet = clazzNameMap.keySet();
				if(!CollectionUtils.isEmpty(keySet)){
					for(String key:keySet)
					{
						String clazzName = key;
						// 创建Excel的工作sheet,对应到一个excel文档的tab
						HSSFSheet sheet = wb.createSheet(clazzName);
						// 创建字体样式
						HSSFFont font = wb.createFont();
						// 创建单元格样式
						HSSFCellStyle style = wb.createCellStyle();
						WebWriteFile.getInstance().init(wb, sheet, font, style);
						
						HSSFRow row = sheet.createRow(0);
						row.setHeight((short) 500);// 设定行的高度
						// 创建一个Excel的单元格
						HSSFCell cell = row.createCell(0);
						// 给Excel的单元格设置样式和赋值
						cell.setCellValue("班级");

						style.setWrapText(true);
						cell = row.createCell(1);
						cell.setCellValue("学号");

						style.setWrapText(true);
						cell = row.createCell(2);
						cell.setCellValue("姓名");
						
						SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
						Long intervalTime = formatter2.parse(endTime).getTime()-formatter2.parse(startTime).getTime();
						int cycleTimes = 1;//得出需要循环次数
						if(intervalTime == 0l){
							cycleTimes = 1;
						}else if(intervalTime > 0l){
							cycleTimes = ((int) (intervalTime/(24*60*60*1000))) + 1;
						}
						
						int column = 3;
						String columnName = startTime;
						List<String> dateList = new ArrayList<String>();
						for(int i = 0; i < cycleTimes; i++){
							style.setWrapText(true);
							cell = row.createCell(column);
							cell.setCellValue(columnName);
							
							dateList.add(columnName);
							column++;
							columnName = TimeUtil.getInstance().getNextDay(columnName);
						}
						
						//key:userId+班级名字  value：StudentCheck
						Map<String, StudentCheck> map = clazzNameMap.get(clazzName);
						if(!CollectionUtils.isEmpty(map)){
							//获取该部门下所有考勤列表
							List<StudentCheck> list = new ArrayList<StudentCheck>(map.values());
							Collections.sort(list, new Comparator<StudentCheck>()
									{
										public int compare(StudentCheck sc1, StudentCheck sc2)
										{
											return sc1.getuId().compareTo(sc2.getuId());
										}
									});
							int i = 1;
							for (StudentCheck sc : list)
							{
								row = sheet.createRow(i);
								row.setHeight((short) 500);// 设定行的高度
								// 创建一个Excel的单元格
								cell = row.createCell(0);
								// 给Excel的单元格设置样式和赋值
								cell.setCellValue(sc.getGradeName());

								style.setWrapText(true);
								cell = row.createCell(1);
								cell.setCellValue(sc.getCode());

								style.setWrapText(true);
								cell = row.createCell(2);
								cell.setCellValue(sc.getName());

								Map<String, StudentCheck> dateMap = sc.getDateMap();
								int tmp_column = 3;
								for(String date : dateList){
									style.setWrapText(true);
									cell = row.createCell(tmp_column);	
									StringBuffer coulumnValue = new StringBuffer();
									StudentCheck tmpSc = dateMap.get(date);
									if(tmpSc != null){
										List<AttendanceCurrentDateInout> currentDateInoutlist = tmpSc.getCurrentDateInoutlist();
										if(!CollectionUtils.isEmpty(currentDateInoutlist)){
											for(AttendanceCurrentDateInout inout : currentDateInoutlist){
												String statusName = inout.getStatusName();
												coulumnValue.append(statusName+" "+ inout.getInoutTime()+"; \r\n");
											}
										}
									}
									if(coulumnValue.length() > 0){
										cell.setCellValue(coulumnValue.toString());
									}else{
										cell.setCellValue("无考勤数据");
									}
									tmp_column++;
								}
								i++;
							}
						}
					}
				}else{
					// 创建Excel的工作sheet,对应到一个excel文档的tab
					HSSFSheet sheet = wb.createSheet("考勤列表");
					// 创建字体样式
					HSSFFont font = wb.createFont();
					// 创建单元格样式
					HSSFCellStyle style = wb.createCellStyle();
					WebWriteFile.getInstance().init(wb, sheet, font, style);
					
				}

				
				File fp = new File("C:\\report\\");
				// 创建目录
				if (!fp.exists())
				{
					fp.mkdirs();// 目录不存在的情况下，创建目录。
				}
				/**
				 * 磁盘创建文件并生出输出流
				 */
				File file = new File("C:\\report\\" + new Date().getTime() + ".xls");
				FileOutputStream os = new FileOutputStream(file);
				wb.write(os);
				os.close();

				WebWriteFile.getInstance().write(file, response, "学生考勤.xls");
				file.delete();
				fp.deleteOnExit();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 导出查询记录 教师考勤记录
	 */
	@RequestMapping(value = "/doExportExcelForTeacher.do")
	public void doExportExcelForTeacher(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			//部门Id
			String departmentId = request.getParameter("departmentId");
			// 开始时间
			String startTime = request.getParameter("startTime");
			// 结束时间
			String endTime = request.getParameter("endTime");
			User user = (User) session.getAttribute("user");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", user.getUserId());
			paramMap.put("schoolId", user.getSchoolId());
			
			if((!StringUtil.isEmpty(departmentId)) && (!"all".equals(departmentId))){
				paramMap.put("departmentId", departmentId);	
			}		
			paramMap.put("startTime", startTime+" 00:00:00");
			paramMap.put("endTime", endTime+" 23:59:59");
			paramMap.put("permissionCode", "teacherAttendanceManager");
			//获取教师考勤列表
			List<TeacherAttendance> teacherAttendanceList = checkService.getTeacherCheckListForExcel(paramMap, user);
			List<Schedule> schedulelist = scheduleService.selectScheduleListByLiveingDate(TimeUtil.date());
			//（0分段，1整天)
			Integer scheduleType = 1;
			if(!CollectionUtils.isEmpty(schedulelist))
			{
				Schedule schedule = schedulelist.get(0);
				scheduleType = schedule.getType();
			} 
			//key:部门名字     value:第二个Map userId_部门名字  value：TeacherAttendance
			Map<String, Map<String, TeacherAttendance>> departmentNameMap = new HashMap<String, Map<String, TeacherAttendance>>();
			//key：userId+部门名字  value：TeacherAttendance
			Map<String, TeacherAttendance> userIdAndDepartmentTAMap = new HashMap<String, TeacherAttendance>();; 
			//key：userId+createDate value ： TeacherAttendance
			Map<String,TeacherAttendance> dateTAMap = new HashMap<String, TeacherAttendance>();
				for(TeacherAttendance tmp : teacherAttendanceList)
				{
					String deparentmentName =  tmp.getGradeName();
					String createDate = tmp.getCreateTime();
					Integer userId = tmp.getuId();
					String inoutTime = tmp.getInoutTime();
					
					AttendanceCurrentDateInout inout = new AttendanceCurrentDateInout();
					if(!StringUtil.isEmpty(inoutTime)){
						inout.setInoutTime(inoutTime.split(" ")[1]);
					}else{
						if(StringUtil.isEmpty(tmp.getRemark())){
							inout.setInoutTime("无刷卡");
						}else{
							inout.setInoutTime(tmp.getRemark());
						}
						
					}
					inout.setRemark(tmp.getRemark());
					inout.setStatus(tmp.getStatus());
					inout.setStatusName(tmp.getStatusName());
					
					//以userId和createDate作为分组的条件
					String dateTAMap_key = userId + "_"+createDate; 
					if(!dateTAMap.containsKey(dateTAMap_key))
					{
						tmp.getCurrentDateInoutlist().add(inout);					
						dateTAMap.put(dateTAMap_key, tmp);
					}else
					{
						tmp = dateTAMap.get(dateTAMap_key);
						tmp.getCurrentDateInoutlist().add(inout);
					}
					
					if(!departmentNameMap.containsKey(deparentmentName))
					{
						userIdAndDepartmentTAMap = new HashMap<String, TeacherAttendance>();
						departmentNameMap.put(deparentmentName, userIdAndDepartmentTAMap);
					}else{
						userIdAndDepartmentTAMap = departmentNameMap.get(deparentmentName);
					}
					
					//以userId和部门名称组成的key
					String userIdAndDepartmentTAMap_key = userId+"_"+deparentmentName;
					TeacherAttendance teacherAttendance;
					if(!userIdAndDepartmentTAMap.containsKey(userIdAndDepartmentTAMap_key))
					{
						teacherAttendance = tmp;
						teacherAttendance.setScheduleType(scheduleType);						
						teacherAttendance.getDateMap().put(createDate, tmp);
						userIdAndDepartmentTAMap.put(userIdAndDepartmentTAMap_key, teacherAttendance);
					}else
					{
						teacherAttendance = userIdAndDepartmentTAMap.get(userIdAndDepartmentTAMap_key);
						teacherAttendance.getDateMap().put(createDate, tmp);
					}
				}
				// 创建Excel的工作书册 Workbook,对应到一个excel文档
				HSSFWorkbook wb = new HSSFWorkbook();
				Set<String> keySet = departmentNameMap.keySet();
				if(!CollectionUtils.isEmpty(keySet)){
					for(String key:keySet)
					{
						String departmentName = key;
						// 创建Excel的工作sheet,对应到一个excel文档的tab
						HSSFSheet sheet = wb.createSheet(departmentName);
						// 创建字体样式
						HSSFFont font = wb.createFont();
						// 创建单元格样式
						HSSFCellStyle style = wb.createCellStyle();
						WebWriteFile.getInstance().init(wb, sheet, font, style);
						
						HSSFRow row = sheet.createRow(0);
						row.setHeight((short) 500);// 设定行的高度
						// 创建一个Excel的单元格
						HSSFCell cell = row.createCell(0);
						// 给Excel的单元格设置样式和赋值
						cell.setCellValue("部门");

						style.setWrapText(true);
						cell = row.createCell(1);
						cell.setCellValue("工号");

						style.setWrapText(true);
						cell = row.createCell(2);
						cell.setCellValue("姓名");
						
						SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
						Long intervalTime = formatter2.parse(endTime).getTime()-formatter2.parse(startTime).getTime();
						int cycleTimes = 1;//得出需要循环次数
						if(intervalTime == 0l){
							cycleTimes = 1;
						}else if(intervalTime > 0l){
							cycleTimes = ((int) (intervalTime/(24*60*60*1000))) + 1;
						}
						
						int column = 3;
						String columnName = startTime;
						List<String> dateList = new ArrayList<String>();
						for(int i = 0; i < cycleTimes; i++){
							style.setWrapText(true);
							cell = row.createCell(column);
							cell.setCellValue(columnName);
							
							dateList.add(columnName);
							column++;
							columnName = TimeUtil.getInstance().getNextDay(columnName);
						}
						
						//key:userId+部门名字  value：TeacherAttendance
						Map<String, TeacherAttendance> map = departmentNameMap.get(departmentName);
						if(!CollectionUtils.isEmpty(map)){
							//获取该部门下所有考勤列表
							List<TeacherAttendance> list = new ArrayList<TeacherAttendance>(map.values());
							Collections.sort(list, new Comparator<TeacherAttendance>()
									{
										public int compare(TeacherAttendance ta1, TeacherAttendance ta2)
										{
											return ta1.getuId().compareTo(ta2.getuId());
										}
									});
							int i = 1;
							for (TeacherAttendance ta : list)
							{
								row = sheet.createRow(i);
								row.setHeight((short) 500);// 设定行的高度
								// 创建一个Excel的单元格
								cell = row.createCell(0);
								// 给Excel的单元格设置样式和赋值
								cell.setCellValue(ta.getGradeName());

								style.setWrapText(true);
								cell = row.createCell(1);
								cell.setCellValue(ta.getCode());

								style.setWrapText(true);
								cell = row.createCell(2);
								cell.setCellValue(ta.getName());

								Map<String, TeacherAttendance> dateMap = ta.getDateMap();
								int tmp_column = 3;
								for(String date : dateList){
									style.setWrapText(true);
									cell = row.createCell(tmp_column);	
									StringBuffer coulumnValue = new StringBuffer();
									TeacherAttendance tmpTa = dateMap.get(date);
									if(tmpTa != null){
										List<AttendanceCurrentDateInout> currentDateInoutlist = tmpTa.getCurrentDateInoutlist();
										if(!CollectionUtils.isEmpty(currentDateInoutlist)){
											for(AttendanceCurrentDateInout inout : currentDateInoutlist){
												String statusName = inout.getStatusName();
												coulumnValue.append(statusName+" "+ inout.getInoutTime()+"; \r\n");
											}
										}
									}
									if(coulumnValue.length() > 0){
										cell.setCellValue(coulumnValue.toString());
									}else{
										cell.setCellValue("无考勤数据");
									}
									tmp_column++;
								}
								i++;
							}
						}
					}
				}else{
					
					// 创建Excel的工作sheet,对应到一个excel文档的tab
					HSSFSheet sheet = wb.createSheet("考勤列表");
					// 创建字体样式
					HSSFFont font = wb.createFont();
					// 创建单元格样式
					HSSFCellStyle style = wb.createCellStyle();
					WebWriteFile.getInstance().init(wb, sheet, font, style);
				}
				
				File fp = new File("C:\\report\\");
				// 创建目录
				if (!fp.exists())
				{
					fp.mkdirs();// 目录不存在的情况下，创建目录。
				}
				/**
				 * 磁盘创建文件并生出输出流
				 */
				File file = new File("C:\\report\\" + new Date().getTime() + ".xls");
				FileOutputStream os = new FileOutputStream(file);
				wb.write(os);
				os.close();

				WebWriteFile.getInstance().write(file, response, "教师考勤.xls");
				file.delete();
				fp.deleteOnExit();
			

		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 进入教师考勤统计页面
	 */
	@RequestMapping(value = "/toCheckReport.do")
	public String toCheckReport(ModelMap modelMap)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(today);
		modelMap.put("type", 0);
		if (list != null && list.size() > 0)
		{
			modelMap.put("type", list.get(0).getType());
		}
		return "check/check_report_teacher";
	}
	/**
	 * 进入学生考勤统计页面
	 */
	@RequestMapping(value = "/toCheckReportStudent.do")
	public String toCheckReportStudent(ModelMap modelMap)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(today);
		modelMap.put("type", 0);
		if (list != null && list.size() > 0)
		{
			modelMap.put("type", list.get(0).getType());
		}
		return "check/check_report_student";
	}
	@RequestMapping(value = "/toCheckReportByHuxinId.do")
	public String toCheckReportByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
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
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String today = formatter.format(new Date());
			List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(today);
			modelMap.put("type", 0);
			if (list != null && list.size() > 0)
			{
				modelMap.put("type", list.get(0).getType());
			}
			List<Permission> permissionList = loginUser.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("attendanceStatisticsManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					return "check/check_report_teacher";
				}
			}
		}
		return null;

	}

	/**
	 * 【教师】加载报表统计总数据(上午)
	 */
	@RequestMapping(value = "/loadAmTotalData.do")
	public String loadAmTotalData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		User user = (User) session.getAttribute("user");

		String time = "";
		try
		{
			time = request.getParameter("time");
			if (null == time || "".equals(time))
			{
				time = today;
			}
			
			String departmentId = request.getParameter("departmentId");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			if((!"all".equals(departmentId)) && (!StringUtil.isEmpty(departmentId))){
				paramMap.put("departmentId", Integer.valueOf(departmentId));
			}

			List<CheckAttendance> checkAttendance = checkService.checkAMTeacherAttendance(paramMap, user);
			response.getWriter().write(getAttendanceData(checkAttendance, time));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 【教师】加载报表统计总数据(下午)
	 */
	@RequestMapping(value = "/loadPmTotalData.do")
	public String loadPmTotalData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());

		/**
		 * 选定user
		 */
		User user = (User) session.getAttribute("user");

		String time = "";

		try
		{
			time = request.getParameter("time");
			if (null == time || "".equals(time))
			{
				time = today;
			}

			String departmentId = request.getParameter("departmentId");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			if((!"all".equals(departmentId)) && (!StringUtil.isEmpty(departmentId))){
				paramMap.put("departmentId", Integer.valueOf(departmentId));
			}

			List<CheckAttendance> checkAttendance = checkService.checkPMTeacherAttendance(paramMap, user);
			response.getWriter().write(getAttendanceData(checkAttendance, time));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 【教师】加载报表统计总数据
	 */
	@RequestMapping(value = "/loadTotalData.do")
	public String loadTotalData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		User user = (User) session.getAttribute("user");
		String time = "";
		try
		{
			time = request.getParameter("time");
			if (null == time || "".equals(time))
			{
				time = today;
			}
			String departmentId = request.getParameter("departmentId");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			if((!"all".equals(departmentId)) && (!StringUtil.isEmpty(departmentId))){
				paramMap.put("departmentId", Integer.valueOf(departmentId));
			}
			List<CheckAttendance> checkAttendance = checkService.checkTeacherAttendance(paramMap, user);
			response.getWriter().write(getAttendanceData(checkAttendance, time));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 【学生】加载报表统计总数据
	 */
	@RequestMapping(value = "/loadStudentTotalData.do")
	public String loadStudentTotalData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		User user = (User) session.getAttribute("user");

		String time = "";
		try
		{
			time = request.getParameter("time");
			if (StringUtil.isEmpty(time))
			{
				time = today;
			}

			String clazzId = request.getParameter("clazzId");
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			if((!"all".equals(clazzId)) && (!StringUtil.isEmpty(clazzId))){
				paramMap.put("clazzId", Integer.valueOf(clazzId));
			}
			List<CheckAttendance> checkAttendanceList = checkService.checkStudentAttendance(paramMap, user);
			response.getWriter().write(getAttendanceData(checkAttendanceList, time));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 【学生】加载报表统计总数据(上午)
	 */
	@RequestMapping(value = "/loadStudentAmTotalData.do")
	public String loadStudentAmTotalData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		User user = (User) session.getAttribute("user");
		String time = "";
		try
		{
			time = request.getParameter("time");
			if (null == time || "".equals(time))
			{
				time = today;
			}
			String clazzId = request.getParameter("clazzId");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			if((!"all".equals(clazzId)) && (!StringUtil.isEmpty(clazzId))){
				paramMap.put("clazzId", Integer.valueOf(clazzId));
			}
			List<CheckAttendance> checkAttendance = checkService.checkAMStudentAttendance(paramMap, user);
			response.getWriter().write(getAttendanceData(checkAttendance, time));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 【学生】加载报表统计总数据(下午)
	 */
	@RequestMapping(value = "/loadStudentPmTotalData.do")
	public String loadStudentPmTotalData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		User user = (User) session.getAttribute("user");
		String time = "";
		try
		{
			time = request.getParameter("time");
			if (null == time || "".equals(time))
			{
				time = today;
			}
			String clazzId = request.getParameter("clazzId");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			if((!"all".equals(clazzId)) && (!StringUtil.isEmpty(clazzId))){
				paramMap.put("clazzId", Integer.valueOf(clazzId));
			}
			List<CheckAttendance> checkAttendance = checkService.checkPMStudentAttendance(paramMap, user);
			response.getWriter().write(getAttendanceData(checkAttendance, time));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	private String getAttendanceData(List<CheckAttendance> checkAttendanceList, String time)
	{

		AttendanceStatistic attendanceStatistic = new AttendanceStatistic();
		for (CheckAttendance checkAttendance : checkAttendanceList)
		{
			if (checkAttendance.getStatus() == 5)
			{
				attendanceStatistic.onWorkNormalList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 2)
			{
				attendanceStatistic.latelList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 3)
			{
				attendanceStatistic.leavelList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 4)
			{
				attendanceStatistic.offWorkNormalList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 1)
			{
				attendanceStatistic.absenteeismList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 11)
			{
				attendanceStatistic.onWorkNormalList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 9)
			{
				attendanceStatistic.latelList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 10)
			{
				attendanceStatistic.leavelList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 12)
			{
				attendanceStatistic.offWorkNormalList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 8)
			{
				attendanceStatistic.absenteeismList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 6)
			{
				attendanceStatistic.abnormalInList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 7)
			{
				attendanceStatistic.abnormalOutList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 13)
			{
				attendanceStatistic.abnormalInList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 14)
			{
				attendanceStatistic.abnormalOutList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 22)// 正常上班
			{
				attendanceStatistic.onWorkNormalList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 23)// 迟到
			{
				attendanceStatistic.latelList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 24)// 早退
			{
				attendanceStatistic.leavelList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 25)// 正常下班
			{
				attendanceStatistic.offWorkNormalList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 26)// 旷工
			{
				attendanceStatistic.absenteeismList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 27)// 非正常进校
			{
				attendanceStatistic.abnormalInList.add(checkAttendance);
			} else if (checkAttendance.getStatus() == 28)// 非正常出校
			{
				attendanceStatistic.abnormalOutList.add(checkAttendance);
			}
		}

		attendanceStatistic.setTime(time);

		Integer sum = commonService.getTeacherCount();
		attendanceStatistic.setSum(sum);

		Gson gson = new Gson();
		String json = gson.toJson(attendanceStatistic);
		return json;
	}

	/**
	 * 教师考勤补录
	 */
	@RequestMapping(value = "/toAttendanceRecord.do")
	public String toAttendanceRecord()
	{
		return "check/attendance_record";
	}

	/**
	 * 学生教师考勤补录
	 */
	@RequestMapping(value = "/toStudentAttendanceRecord.do")
	public String toStudentAttendanceRecord()
	{
		return "check/attendance_record_student";
	}
	
	@RequestMapping(value = "/toAttendanceRecordByHuxinId.do")
	public String toAttendanceRecordByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
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
				if ("attendanceRecordManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					return "check/attendance_record";
				}
			}
		}
		return null;
	}

	/**
	 * 执行更新考勤状态
	 */
	@RequestMapping(value = "/toUpdateStatus.do")
	@ResponseBody
	public void toUpdateStatus(HttpServletRequest request, HttpSession session, ModelMap modelMap,HttpServletResponse response)
	{
		String f="1";
		try {
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		/**
		 * teacherId
		 */
		Integer uId = Integer.valueOf(request.getParameter("uId"));
		Integer status = Integer.valueOf(request.getParameter("status"));
		Integer newStatus = Integer.valueOf(request.getParameter("newStatus"));
		String createDate = request.getParameter("createDate");
		paramMap.put("userId", uId);
		paramMap.put("status", status);
		paramMap.put("newStatus", newStatus);
		paramMap.put("createDate", createDate);
		paramMap.put("remark", "补录");
		/**
		 * 修改班级信息
		 */
		checkService.toUpdateStatus(paramMap);
		} catch (Exception e) {
			f="0";	
		}
		try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/* -------------------手机端------------------------ */
	
	/**
	 * 进入教师考勤页面（APP）
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toTeacherCheckListByHuxinId.do")
	public String toTeacherCheckListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
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
				return  "app/check/teacher_check_list_app";
			}
		}else
		{
			modelMap.addAttribute("apiKeyTimeOut", "2");
		}
		

		session.setAttribute("user", user);
		DBContextHolder.setDBType(user.getSchoolId());
		String path = null;
		try{
			List<Permission> permissionList = user.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("teacherAttendanceManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					path = "app/check/teacher_check_list_app";
					break;
				}
			}
			String roleCode = request.getParameter("roleCode");
			if (StringUtil.isEmpty(roleCode))
			{
				roleCode = user.getRoleList().get(0).getRoleCode();
			}
			/*
			 * 接收页面请求参数---begin
			 */
			Integer userId = user.getUserId();
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			Integer departmentId = null;
			try
			{
				departmentId = Integer.valueOf(request.getParameter("departmentId"));
				if (0 == departmentId)
				{
					departmentId = null;
				}
			} catch (Exception e)
			{
				departmentId = null;
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
			
			String createDate = request.getParameter("createDate");
			if(StringUtil.isEmpty(createDate)){
				createDate = TimeUtil.date();
			}

			paramMap.put("departmentId", departmentId);
			paramMap.put("queryContent", queryContent);
			paramMap.put("createDate", createDate);
			paramMap.put("userId", userId);

			this.getPages().setPageSize(20);
			List<TeacherCheck> checklist = checkService.getTeacherCheckListAPP(this.getPages().getPageSize(), currentPage, paramMap, user);

			currentPage = currentPage + 1;
			modelMap.addAttribute("checklist", checklist);
			modelMap.addAttribute("checklistSize", checklist.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("departmentId", departmentId);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("createDate", createDate);

		}catch(Exception e)
		{
			logger.error("toTeacherCheckListByHuxinId.do出错，错误信息如下："+e);
		}

		return path;
	}
	
	/**
	 * 不同权限查看到不同的page 加载教师考勤list
	 */
	@RequestMapping(value = "/loadTeacherCheckListAPP.do")
	public String loadTeacherCheckListAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			User loginUser = (User) session.getAttribute("user");
			/**
			 * 接收页面请求参数---begin
			 */
			Integer userId = loginUser.getUserId();

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

			/**
			 * 科室ID/部门
			 */
			Integer departmentId = null;
			try
			{
				departmentId = Integer.valueOf(request.getParameter("departmentId"));
				if (0 == departmentId)
				{
					departmentId = null;
				}
			} catch (Exception e)
			{
				departmentId = null;
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
			
			String createDate = request.getParameter("createDate");
			if(StringUtil.isEmpty(createDate)){
				createDate = TimeUtil.date();
			}
			
			String roleCode = request.getParameter("roleCode");
			
			paramMap.put("departmentId", departmentId);
			paramMap.put("queryContent", queryContent);
			paramMap.put("createDate", createDate);
			paramMap.put("userId", userId);

			this.getPages().setPageSize(20);
			
			List<TeacherCheck> checklist = checkService.getTeacherCheckListAPP(this.getPages().getPageSize(), currentPage, paramMap, loginUser);

			currentPage = currentPage + 1;
			modelMap.addAttribute("checklist", checklist);
			modelMap.addAttribute("checklistSize", checklist.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("departmentId", departmentId);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("createDate", createDate);

			/**
			 * flush到页面
			 */
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
	
	
	@RequestMapping(value = "/toTeacherSearchJspApp.do")
	public String toTeacherSearchJspApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");
		
		List<Department> departmentList = commonService.getDepartmentList();
		modelMap.addAttribute("departmentList", departmentList);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		
		return "app/check/teacher_check_list_search_app";
	}
	
	
	
	
	/**
	 * 进入学生考勤页面（APP）
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toStudentCheckListByHuxinId.do")
	public String toStudentCheckListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
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
				return  "app/check/student_check_list_app";
			}
		}else
		{
			
			modelMap.addAttribute("apiKeyTimeOut", "2");
		}
		
		/*
		 * 存session
		 */
		session.setAttribute("user", user);
		
		DBContextHolder.setDBType(user.getSchoolId());
		
		String path = null;

		try{

			List<Permission> permissionList = user.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("studentAttendanceManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					path = "app/check/student_check_list_app";
					break;
				}
			}

			String roleCode = request.getParameter("roleCode");

			if (StringUtil.isEmpty(roleCode))
			{
				roleCode = user.getRoleList().get(0).getRoleCode();
			}

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

			/**
			 * 学号
			 */
			String queryContent = request.getParameter("queryContent");

			Integer clazzId = null;
			try
			{
				clazzId = Integer.valueOf(request.getParameter("clazzId"));
				if (0 == clazzId)
				{
					clazzId = null;
				}
			} catch (Exception e)
			{
				clazzId = null;
			}
			String createDate = request.getParameter("createDate");
			if(StringUtil.isEmpty(createDate)){
				createDate = TimeUtil.date();
			}
			
			Integer userId = user.getUserId();

			//TODO 
			paramMap.put("clazzId", clazzId);
			paramMap.put("roleCode", roleCode);
			paramMap.put("queryContent", queryContent);
			paramMap.put("userId", userId);
			paramMap.put("todayTime", createDate);
			this.getPages().setPageSize(20);
			
			List<TeacherCheck> checklist = checkService.loadStudentCheckListAPP(this.getPages().getPageSize(), currentPage, paramMap, user);

			currentPage = currentPage + 1;
			modelMap.addAttribute("checklist", checklist);
			modelMap.addAttribute("checklistSize", checklist.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			modelMap.addAttribute("roleList", user.getRoleList());
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("createDate", createDate);
		}catch(Exception e)
		{
			e.printStackTrace();
		}

		return path;
	}

	/**
	 * 不同权限查看到不同的page 加载学生考勤list
	 */
	@RequestMapping(value = "/loadStudentCheckListAPP.do")
	public String loadStudentCheckListAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			User loginUser = (User) session.getAttribute("user");

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

			/**
			 * 学号
			 */
			String queryContent = request.getParameter("queryContent");

			Integer clazzId = null;
			try
			{
				clazzId = Integer.valueOf(request.getParameter("clazzId"));
				if (0 == clazzId)
				{
					clazzId = null;
				}
			} catch (Exception e)
			{
				clazzId = null;
			}
			
			String roleCode = request.getParameter("roleCode");
			String createDate = request.getParameter("createDate");
			if(StringUtil.isEmpty(createDate)){
				createDate = TimeUtil.date();
			}
			paramMap.put("clazzId", clazzId);
			paramMap.put("roleCode", roleCode);
			paramMap.put("queryContent", queryContent);
			paramMap.put("todayTime", createDate);
			List<TeacherCheck> checklist = checkService.loadStudentCheckListAPP(this.getPages().getPageSize(), currentPage, paramMap, loginUser);

			currentPage = currentPage + 1;
			modelMap.addAttribute("checklist", checklist);
			modelMap.addAttribute("checklistSize", checklist.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("clazzId", clazzId);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("roleListSize", loginUser.getRoleList().size());
			modelMap.addAttribute("roleList", loginUser.getRoleList());
			modelMap.addAttribute("createDate", createDate);
			/**
			 * flush到页面
			 */
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
	
	@RequestMapping(value = "/toStudentSearchJspApp.do")
	public String toStudentSearchJspApp(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");

		User user = (User) session.getAttribute("user");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", "studentAttendanceManager");
		paramMap.put("roleCode", roleCode);
		
		
		List<Clazz> clazzList = commonService.getClazzListByRoleCode(paramMap);
		
		modelMap.addAttribute("clazzList", clazzList);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		
		return "app/check/student_check_list_search_app";
	}

	private String getStatusNameByStatus(Integer status){
		String statusName = "";
		switch (status)
		{
		case 1:
			statusName = "上午旷工";
			break;
		case 2:
			statusName = "上午迟到";
			break;
		case 3:
			statusName = "上午早退";
			break;
		case 4:
			statusName = "上午正常下班";
			break;
		case 5:
			statusName = "上午正常上班";
			break;
		case 6:
			statusName = "上午非正常进校";
			break;
		case 7:
			statusName = "上午非正常出校";
			break;
		case 8:
			statusName = "下午旷工";
			break;
		case 9:
			statusName = "下午迟到";
			break;
		case 10:
			statusName = "下午早退";
			break;
		case 11:
			statusName = "下午正常上班";
			break;
		case 12:
			statusName = "下午正常下班";
			break;
		case 13:
			statusName = "下午正常下班";
			break;
		case 14:
			statusName = "下午非正常出校";
			break;
		case 15:
			statusName = "晚上旷工";
			break;
		case 16:
			statusName = "晚上迟到";
			break;
		case 17:
			statusName = "晚上早退";
			break;
		case 18:
			statusName = "晚上正常上班";
			break;
		case 19:
			statusName = "晚上正常下班";
			break;
		case 20:
			statusName = "晚上非正常进校";
			break;
		case 21:
			statusName = "晚上非正常出校";
			break;
		case 22:
			statusName = "正常上班";
			break;
		case 23:
			statusName = "迟到";
			break;
		case 24:
			statusName = "早退";
			break;
		case 25:
			statusName = "正常下班";
			break;
		case 26:
			statusName = "旷工";
			break;
		case 27:
			statusName = "非正常进校";
			break;
		case 28:
			statusName = "非正常出校";
			break;
		default:
			statusName = "正常上班";
			break;
		}
		
		return statusName;
	}
}
