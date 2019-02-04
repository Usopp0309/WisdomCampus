package com.guotop.palmschool.check.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.check.cons.CheckCons;
import com.guotop.palmschool.check.entity.Stay;
import com.guotop.palmschool.check.entity.Total;
import com.guotop.palmschool.check.service.TotalService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Grade;
import com.guotop.palmschool.entity.Leave;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 考勤业务类实现类
 * @author zhou
 */
@Service("totalService")
public class TotalServiceImpl extends BaseService implements TotalService
{
	
	public Total getLastTotal(Map<String, Object> paramMap)
	{
		return (Total) getBaseDao().selectObjectByObject("Total.selectLastTotal", paramMap);
	}
	
	public Stay getFirstStay(int userType)
	{
		return (Stay) getBaseDao().selectObjectByObject("Total.selectFirstStay", userType);
	}
	
	public int totalDay(Date start, int userType, int type) {
		// 统计类别，0:全校，1:年级，2:班级，3:个人
		start = StringUtil.zeroClock(start);
		Calendar cal = Calendar.getInstance();
		cal.setTime(start);

		Date end = StringUtil.zeroClock();

		int t = 0;
		while (cal.getTimeInMillis() < end.getTime()) {
			Date day = new Date(cal.getTimeInMillis());
			if (type == 0) {
				t += totalBySchoolDay(day, userType);
			} else if (type == 1) {
				t += totalByGradeDay(day, userType);
			} else if (type == 2) {
				if (userType == 2)
					t += totalByClazzDay(day);
			} else {
				t += totalByPersonDay(day, userType);
			}
			cal.add(Calendar.DATE, 1); // 第二天
		}

		return t;
	}
	/**
	 * 页面展示---begin
	 */
	/**
	 * 页面加载考勤统计列表
	 * @param paramMap 参数map
	 * @param user 当前用户
	 * @return 考勤统计/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages loadTotalCheckList(int pageSize, int page, 
			Map<String, Object> paramMap, User user, Integer roleId)
	{
		Integer allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Total> list = new ArrayList<Total>();
		
		/**
		 * 优化方案:在统计的时候加个触发器，把总数写入一个表中，在此处直接单表查询即可，没必要count
		 * 数据量越大越慢
		 */
		/**
		 * 校长权限
		 * 
		 */
		if (Cons.ROLE_HEADMASTER.equals(roleId))
		{
			allRow = (Integer) this.getBaseDao().
					selectObjectByObject("Total.loadTotalCheckListCountAsHeadMasterCount", paramMap);
			
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
	
			list = this.getBaseDao().selectListByObject(
					"Total.loadTotalCheckListCountAsHeadMaster",
					paramMap);
			
	     }
		
		/**
		 * 班主任权限
		 * 
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			allRow = (Integer) this.getBaseDao().
					selectObjectByObject("Total.loadTotalCheckListCountAsHeadTeacherCount", paramMap);
			
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
	
			list = this.getBaseDao().selectListByObject("Total.loadTotalCheckListCountAsHeadTeacher",
					paramMap);
			
		}
		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}
	/**
	 * 页面展示---end
	 */
	
	
	/**
	 * 线程统计相关---begin
	 */
	
	
	@SuppressWarnings("rawtypes")
	private int totalBySchoolDay(Date day, int userType) {
		School school = (School) getBaseDao().selectListBySql("School.selectSchool");
		if (school == null)
		{
			return 0;
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * 待新增totalList
		 */
		List<Total> totalList = new ArrayList<Total>();
		
		Date start = day;
		Date end = StringUtil.nextDay(start);
		int type = 3; // 统计类别，0:全校，1:年级，2:班级，3:个人

		paramMap.put("userType", userType);
		paramMap.put("type", type);
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List result = (List) getBaseDao().selectListByObject("Total.selectTotalBySchoolDay", paramMap);
		
		if (result != null && result.size() > 0) {
			for (int i = 0; i < result.size(); i++) {
				Object[] o = (Object[]) result.get(i);

				Total total = new Total();
				total.setUserType(userType); // 人员类型，1:教师，2:学生
				total.setType(0); // 统计类别，0:全校，1:年级，2:班级，3:个人
				total.setPeriodType(1); // 统计类型，0:月，1:日，2:周

				total.setPeriod(StringUtil.toStr(day, "yyyyMMdd"));
				total.setPeriodTime(StringUtil.toStr(day, "yyyyMMdd"));

				//total.setObjId(school.getSchoolId());
				total.setCode(String.valueOf(school.getSchoolId()));
				total.setName(school.getSchoolName());

				Date arrivaltime = (Date) o[0];
				if (arrivaltime != null)
					total.setArrivalTime(StringUtil.toStr(arrivaltime, "yyyyMMdd HH:mm:ss"));

				Date leavetime = (Date) o[1];
				if (leavetime != null)
					total.setLeaveTime(StringUtil.toStr(leavetime, "yyyyMMdd HH:mm:ss"));

				Double hours = (Double) o[2];
				if (hours != null)
					total.setHours(hours.floatValue());

				Long latetimes = (Long) o[3];
				if (latetimes != null)
					total.setLateTimes(latetimes.intValue());

				Long leavetimes = (Long) o[4];
				if (leavetimes != null)
					total.setLeaveTimes(leavetimes.intValue());

				totalList.add(total);
				//添加total实体,加上触发器
				getBaseDao().addObject("Total.addTotal", total);
			}
		}

		return totalList.size();
	}

	@SuppressWarnings("rawtypes")
	private int totalByGradeDay(Date day, int userType) {
		Date start = day;
		Date end = StringUtil.nextDay(start);
		int type = 3; // 统计类别，0:全校，1:年级，2:班级，3:个人

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		/**
		 * 待新增totalList
		 */
		List<Total> totalList = new ArrayList<Total>();
		
		paramMap.put("userType", userType);
		paramMap.put("type", type);
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List result = (List) getBaseDao().selectListByObject("Total.selectTotalByGradeDay", paramMap);
		
		if (result != null && result.size() > 0) {
			for (int i = 0; i < result.size(); i++) {
				Object[] o = (Object[]) result.get(i);
				int gradeId = (Integer) o[0];

				Grade grade = (Grade) getBaseDao().selectObject("Grade.selectGradeById",gradeId);
				if (grade == null)
					continue;

				Total total = new Total();
				total.setUserType(userType); // 人员类型，1:教师，2:学生
				total.setType(1); // 统计类别，0:全校，1:年级，2:班级，3:个人
				total.setPeriodType(1); // 统计类型，0:月，1:日，2:周

				total.setPeriod(StringUtil.toStr(day, "yyyyMMdd"));
				total.setPeriodTime(StringUtil.toStr(day, "yyyyMMdd"));

				total.setObjId(grade.getId());
				//total.setCode(grade.getCode());
				total.setName(grade.getName());
				total.setGradeId(grade.getId());

				Timestamp arrivaltime = (Timestamp) o[1];
				if (arrivaltime != null)
					total.setArrivalTime(StringUtil.toStr(arrivaltime, "yyyyMMdd HH:mm:ss"));

				Timestamp leavetime = (Timestamp) o[2];
				if (leavetime != null)
					total.setLeaveTime(StringUtil.toStr(leavetime, "yyyyMMdd HH:mm:ss"));

				Double hours = (Double) o[3];
				if (hours != null)
					total.setHours(hours.floatValue());

				Long latetimes = (Long) o[4];
				if (latetimes != null)
					total.setLateTimes(latetimes.intValue());

				Long leavetimes = (Long) o[5];
				if (leavetimes != null)
					total.setLeaveTimes(leavetimes.intValue());

				totalList.add(total);
				//添加total实体,加上触发器
				getBaseDao().addObject("Total.addTotal", total);
			}
		}


		 return totalList.size();
	}

	@SuppressWarnings("rawtypes")
	private int totalByClazzDay(Date day) {
		List<Total> totals = new ArrayList<Total>();

		Date start = day;
		Date end = StringUtil.nextDay(start);
		int userType = 2; // 人员类型，1:教师，2:学生
		int type = 3; // 统计类别，0:全校，1:年级，2:班级，3:个人

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		/**
		 * 待新增totalList
		 */
		List<Total> totalList = new ArrayList<Total>();
		
		paramMap.put("userType", userType);
		paramMap.put("type", type);
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List result = (List) getBaseDao().selectListByObject("Total.selectTotalByClazzDay", paramMap);
		
		if (result != null && result.size() > 0) {
			for (int i = 0; i < result.size(); i++) {
				Object[] o = (Object[]) result.get(i);
				int clazzId = (Integer) o[0];

				Clazz clazz = (Clazz)getBaseDao().selectObject("Clazz.selectClazzById",clazzId);
				if (clazz == null)
					continue;

				Total total = new Total();
				total.setUserType(userType); // 人员类型，1:教师，2:学生
				total.setType(2); // 统计类别，0:全校，1:年级，2:班级，3:个人
				total.setPeriodType(1); // 统计类型，0:月，1:日，2:周

				total.setPeriod(StringUtil.toStr(day, "yyyyMMdd"));
				total.setPeriodTime(StringUtil.toStr(day, "yyyyMMdd"));

				total.setObjId(clazz.getId());
				total.setCode(clazz.getCode());
				//total.setName(clazz.getName());
				total.setClazzId(clazz.getId());
				//total.setGradeId(clazz.getGradeid());

				Date arrivaltime = (Date) o[1];
				if (arrivaltime != null)
					total.setArrivalTime(StringUtil.toStr(arrivaltime, "yyyyMMdd"));

				Date leavetime = (Date) o[2];
				if (leavetime != null)
					total.setLeaveTime(StringUtil.toStr(leavetime, "yyyyMMdd"));

				Double hours = (Double) o[3];
				if (hours != null)
					total.setHours(hours.floatValue());

				Long latetimes = (Long) o[4];
				if (latetimes != null)
					total.setLateTimes(latetimes.intValue());

				Long leavetimes = (Long) o[5];
				if (leavetimes != null)
					total.setLeaveTimes(leavetimes.intValue());

				totalList.add(total);
				//添加total实体,加上触发器
				getBaseDao().addObject("Total.addTotal", total);
			}
		}

		

		return totals.size();
	}
	
	/**
	 * 按人天统计
	 * @param startDay 统计日期
	 * @param userType 人员类型，1:教师，2:学生
	 */
	@SuppressWarnings("unchecked")
	public int totalByPersonDay(Date startDay, int userType)
	{
		Calendar cal = Calendar.getInstance();
		
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		int weekday = cal.get(Calendar.DAY_OF_WEEK);
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		/**
		 * 存放卡号
		 */
		Set<String> codeSet = new HashSet<String>();
		
		/**
		 * 开始时间
		 */
		String start = sdf.format(startDay);
		
		/**
		 * 结束时间，第二天
		 */
		String end = TimeUtil.getInstance().getNextDay(start);
		
		/**
		 * 最早到校时间
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userType", userType);
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		Map<String, String> arrivalTimeMap = getBaseDao().queryForMap("Total.selectArrivalTime", paramMap, 
				"code", "inTime");
		for (Object code : arrivalTimeMap.keySet())
		{
			codeSet.add(code.toString());
		}
		
		/**
		 * 最早离校时间
		 */
		Map<String, String> leaveTimeMap = getBaseDao().queryForMap("Total.selectLeaveTime", paramMap, 
				"code", "outTime");
		for (Object code : leaveTimeMap.keySet())
		{
			codeSet.add(code.toString());
		}
		
		/**
		 * 待新增totalList
		 */
		List<Total> totalList = new ArrayList<Total>();
		
		/**
		 * 遍历卡set新增total实体
		 */
		for (String code : codeSet)
		{
			/**
			 * 根据卡号查询卡的持有者
			 */
			User user = (User) getBaseDao().selectObjectByObject("User.selectUserByCardCode", code);
			
			if (null == user)
			{
				continue;
			}
			
			Total total = new Total();
			total.setUserType(userType); // 人员类型，1:教师，2:学生
			total.setType(Cons.TOTAL_SCALE_PERSON); // 统计规模，0:全校，1:年级，2:班级，3:个人
			total.setPeriodType(Cons.TOTAL_PERIOD_DAY); // 统计周期，0:月，1:周，2:日

			total.setPeriod(start);
			total.setPeriodTime(start);
			
			total.setObjId(user.getId());
			total.setCode(user.getCode());
			total.setName(user.getName());
			total.setGradeId(user.getGradeId());
			total.setClazzId(user.getClazzId());
			
			total.setCreateTime(TimeUtil.getInstance().now());
			
			//请假相关
			paramMap.put("userId", user.getId());
			Leave leave = (Leave) getBaseDao().selectObjectByObject("Leave.selectLeaveListForTotal", paramMap);
			
			if (null != leave && null != leave.getType())
			{
				if (Cons.LEAVETYPE_AFFAIR.equals(leave.getType()))
				{
					total.setAffairLeave(1);
				}
				else if (Cons.LEAVETYPE_SICK.equals(leave.getType()))
				{
					total.setSickLeave(1);
				}
				else if (Cons.LEAVETYPE_MATERNITY.equals(leave.getType()))
				{
					total.setMaternityLeave(1);
				}
				else if (Cons.LEAVETYPE＿BUSINESSTRIP.equals(leave.getType()))
				{
					total.setBusinessTrip(1);
				}
			}
			
			//最早到校时间相关
			if (arrivalTimeMap.containsKey(code))
			{
				String arriveTime = arrivalTimeMap.get(code);
				total.setArrivalTime(arriveTime);
				
				switch (userType)
				{
					case Cons.TOTAL_PEOPLETYPE_STUDENT:
						if (hour * 100 + minute > CheckCons.STUDENT_LATETIME
								&& weekday != Calendar.SUNDAY
								&& weekday != Calendar.SATURDAY)
						{
							total.setLeaveTimes(1);
						}
						else
						{
							total.setLeaveTimes(0);
						}
						break;
					case Cons.TOTAL_PEOPLETYPE_TEACHER:
						if (hour * 100 + minute > CheckCons.TEACHER_LATETIME
								&& weekday != Calendar.SUNDAY
								&& weekday != Calendar.SATURDAY)
						{
							total.setLeaveTimes(1);
						}
						else
						{
							total.setLeaveTimes(0);
						}
						break;
				}
			}
			
			//最晚离校时间
			if (leaveTimeMap.containsKey(code))
			{
				String leaveTime = leaveTimeMap.get(code);
				total.setLeaveTime(leaveTime);
				
				switch (userType)
				{
					case Cons.TOTAL_PEOPLETYPE_STUDENT:
						if (hour * 100 + minute < CheckCons.STUDENT_LEAVETIME
								&& weekday != Calendar.SUNDAY
								&& weekday != Calendar.SATURDAY)
						{
							total.setLeaveTimes(1);
						}
						else
						{
							total.setLeaveTimes(0);
						}
						break;
					case Cons.TOTAL_PEOPLETYPE_TEACHER:
						if (hour * 100 + minute < CheckCons.TEACHER_LEAVETIME
								&& weekday != Calendar.SUNDAY
								&& weekday != Calendar.SATURDAY)
						{
							total.setLeaveTimes(1);
						}
						else
						{
							total.setLeaveTimes(0);
						}
						break;
				}
			}
			
			
			totalList.add(total);
			
			//添加total实体,加上触发器
			getBaseDao().addObject("Total.addTotal", total);
		}
		     
		return totalList.size();
	}
	/**
	 * 线程统计相关---end
	 */

}
