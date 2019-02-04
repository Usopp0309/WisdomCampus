package com.guotop.palmschool.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.ScheduleClazz;
import com.guotop.palmschool.entity.ScheduleTeacher;
import com.guotop.palmschool.entity.ScheduleTime;
import com.guotop.palmschool.entity.ScheduleTimeRelation;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.util.Pages;


/**
 * 作息时间表业务类实现类
 * @author zhou
 *
 */
@Service("scheduleService")
public class ScheduleServiceImpl extends BaseService implements ScheduleService
{
	
	/**
	 * 根据查询条件查询作息时间表 /分页查询
	 * @param paramMap 条件
	 * @return 作息时间表记录/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages loadScheduleList(int pageSize, int page, Map<String, Object> paramMap)
	{
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String time = formatter.format(new Date());
		paramMap.put("time", time);
		int allRow = this.getBaseDao().getAllRowCountByCondition(
				"Schedule.selectScheduleList",paramMap);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		List<Schedule> list = this.getBaseDao().queryForPageByCondition(
				"Schedule.selectScheduleList", paramMap, offset, length);
		
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
	 * 根据查询条件查询作息时间表 /分页查询
	 * @param paramMap 条件
	 * @return 作息时间表记录/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages loadScheduleListFj(int pageSize, int page, Map<String, Object> paramMap)
	{
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String time = formatter.format(new Date());
		paramMap.put("time", time);
		int allRow = this.getBaseDao().getAllRowCountByCondition(
				"Schedule.selectScheduleList",paramMap);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		List<Schedule> list = this.getBaseDao().queryForPageByCondition(
				"Schedule.selectScheduleList", paramMap, offset, length);
		
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
	 * 根据作息时间得出靠近当前时间最近五天工作日
	 */
	@SuppressWarnings("unchecked")
	public List<String> loadScheduleListInAPP(Map<String, Object> paramMap)
	{
		List<String> list = this.getBaseDao().selectListByObject("Schedule.selectFiveWorkingDays", paramMap);	
		return list;
	}
	/**
	 * 新增作息时间表
	 * @param schedule 待添加的作息时间表
	 */
	public Integer addSchedule(Schedule schedule)
	{
		return (Integer) getBaseDao().addObject("Schedule.addSchedule", schedule);
	}
	
	/**
	 * 根据主键查找作息时间表实体类
	 * @param scheduleId 作息时间表主键
	 * @return 作息时间实体
	 */
	public Schedule selectScheduleById(Integer scheduleId)
	{
		return (Schedule) getBaseDao().selectObject("Schedule.selectScheduleById", scheduleId);
	}
	
	/**
	 * 根据生效时间查找作息时间表集合
	 * @param liveingDate 作息时间
	 * @return List<Schedule> 作息时间集合表
	 */
	@SuppressWarnings("unchecked")
	public List<Schedule> selectScheduleListByLiveingDate(String liveingDate)
	{
		return getBaseDao().selectListByObject("Schedule.selectScheduleListByLiveingDate", liveingDate);
	}
	
	/**
	 * 修改作息时间表
	 * @param paramMap 参数列表
	 */
	public void updateScheduleById(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("Schedule.updateScheduleById", paramMap);
	}
	
	/**
	 * 判断今天是否上课
	 * true:上课  false:休息
	 */
	public boolean isWorkToday()
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String liveingDate = formatter.format(new Date());
		Schedule schedule = (Schedule) getBaseDao().selectObjectByObject("Schedule.isWorkToday", liveingDate);
		
		if (schedule!=null && Cons.SCHEDULE_CLASSES.equals(schedule.getStatus()))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	/**
	 * 删除作息时间表
	 * @param liveingDate 作息时间表日期
	 */
	public void deleteScheduleByLiveingDate(String liveingDate)
	{
		
		getBaseDao().deleteObject("Schedule.deleteScheduleByLiveingDate", liveingDate);
	}
	
	/**
	 * 根据时间查找作息时间表集合
	 * @param time 查找的时间
	 * @return List<Schedule> 作息时间集合表
	 */
	@SuppressWarnings("unchecked")
	public List<Schedule> selectScheduleListTime(String time)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("time", time);
		return getBaseDao().selectListByObject("Schedule.selectScheduleList", paramMap);
	}
	
	/**
	 * 查找作息时间的最后一条数据 （设置作息时间提醒用） 
	 */
	public Schedule selectSchedule()
	{
		return (Schedule)getBaseDao().selectObject("Schedule.selectSchedule",null);
	}
	/**
	 * 查找作息时间
	  @author chenyong
	  @date 2016年10月13日 上午10:55:01
	 * @return
	 */
	@Override
	public Schedule selectWorkingDays(Map<String,Object> map)
	{
		
		return (Schedule) getBaseDao().selectObjectByObject("Schedule.selectWorkingDays", map);
	}
	
	/***********************新的作息时间设置*****************************/
	
	/**
	 * 添加作息时间段
	 * @param scheduleTime
	 * @return
	 */
	public Integer saveScheduleTime(ScheduleTime scheduleTime)
	{
		return (Integer)getBaseDao().addObject("Schedule.saveScheduleTime", scheduleTime);
	}
	
	/**
	 * 添加作息时间和作息时间段的关系
	 * @param relation
	 */
	public void saveScheduleTimeRelation(ScheduleTimeRelation relation)
	{
		getBaseDao().addObject("Schedule.saveScheduleTimeRelation", relation);
	}
	
	/**
	 * 根据开始日期结束日期获取对应的时间段
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ScheduleTime> getScheduleTimeListByStartDayAndEndDay(Map<String,Object> paramMap)
	{
		return (List<ScheduleTime>)getBaseDao().selectListByObject("Schedule.getScheduleTimeListByStartDayAndEndDay", paramMap);
	}
	
	/**
	 * 清空当前日期往后的作息时间
	 */
	
	public void clearSchedule(String liveingDate){
		getBaseDao().deleteObject("Schedule.deleteScheduleDetail", liveingDate);
		getBaseDao().deleteObject("Schedule.deleteScheduleClazz", liveingDate);
		getBaseDao().deleteObject("Schedule.deleteScheduleTeacher", liveingDate);
	}
	
	/**
	 * 根据时间段id获取对应的时间段
	 * @param timeId
	 * @return
	 */
	public ScheduleTime getScheduleTimeById(Integer timeId)
	{
		return (ScheduleTime)getBaseDao().selectObject("Schedule.getScheduleTimeById", timeId);
	}
	
	/**
	 * 添加班级对应的作息时间
	 * @param scheduleClazz
	 * @return
	 */
	public Integer saveScheduleClazz(ScheduleClazz scheduleClazz)
	{
		return (Integer) getBaseDao().addObject("Schedule.saveScheduleClazz", scheduleClazz);
	}
	
	/**
	 * 添加教师对应的作息时间
	 * @param scheduleTeacher
	 * @return
	 */
	public Integer saveScheduleTeacher(ScheduleTeacher scheduleTeacher)
	{
		return (Integer) getBaseDao().addObject("Schedule.saveScheduleTeacher", scheduleTeacher);
	}
	
	/**
	 * 根据生效日期以及年级Id或者班级Id,获取对应的考勤列表
	 * @param liveingDate
	 * @param gradeId
	 * @param clazzId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ScheduleClazz> getScheduleListByLiveingAndGradeIdOrClazzId(String liveingDate,String gradeId,String clazzId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("liveingDate", liveingDate);
		paramMap.put("gradeId", gradeId);
		paramMap.put("clazzId", clazzId);
		return getBaseDao().selectListByObject("Schedule.getScheduleListByLiveingAndGradeIdOrClazzId", paramMap);
	}
	
	/**
	 * 根据生效日期以及部门Id获取对应的考勤列表
	 * @param liveingDate
	 * @param gradeId
	 * @param clazzId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ScheduleTeacher> getScheduleListByLiveingAndDepartmentId(String liveingDate,String departmentId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("liveingDate", liveingDate);
		paramMap.put("departmentId", departmentId);
		return getBaseDao().selectListByObject("Schedule.getScheduleListByLiveingAndDepartmentId", paramMap);
	}
	
	/**
	 * 根据生效日期修改作息时间状态
	 * @param paramMap
	 */
	public void modifySchedule(Map<String,Object> paramMap)
	{
		getBaseDao().addObject("Schedule.modifySchedule", paramMap);
	}
	
	/**
	 * 根据生效日期修改班级作息时间状态
	 * @param paramMap
	 */
	public void modifyScheduleClazz(Map<String,Object> paramMap)
	{
		getBaseDao().addObject("Schedule.modifyScheduleClazz", paramMap);
	}
	/**
	 * 根据生效日期修改教师作息时间状态
	 * @param paramMap
	 */
	public void modifyScheduleTeacher(Map<String,Object> paramMap)
	{
		getBaseDao().addObject("Schedule.modifyScheduleTeacher", paramMap);
	}
	
	/**
	 * 根据日期和用户id获取对应的作息时间
	 * @return
	 */
	public ScheduleClazz getScheduleClazzByUserIdAndLiveingDate(String date,Integer userId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("liveingDate", date);
		paramMap.put("userId", userId);
		return (ScheduleClazz)getBaseDao().selectObjectByObject("Schedule.getScheduleClazzByUserIdAndLiveingDate", paramMap);
	}
	
	/**
	 * 根据日期和班级id获取对应的作息时间
	 * @return
	 */
	public ScheduleClazz getScheduleClazzByClazzIdAndLiveingDate(String liveDate, Integer clazzId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("liveingDate", liveDate);
		paramMap.put("clazzId", clazzId);
		return (ScheduleClazz)getBaseDao().selectObjectByObject("Schedule.getScheduleClazzByClazzIdAndLiveingDate", paramMap);
	}
	
	/**
	 * 根据日期和用户id获取对应的作息时间
	 * @return
	 */
	public ScheduleTeacher getScheduleTeacherByUserIdAndLiveingDate(String date,Integer userId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("liveingDate", date);
		paramMap.put("userId", userId);
		return (ScheduleTeacher)getBaseDao().selectObjectByObject("Schedule.getScheduleTeacherByUserIdAndLiveingDate", paramMap);
	}
	
	/**
	 * 修改教师作息时间
	 * @param scheduleTeacher
	 */
	public void modifyScheduleTeacher(ScheduleTeacher scheduleTeacher)
	{
		getBaseDao().updateObject("Schedule.updateScheduleTeacher", scheduleTeacher);
	}
	
	/**
	 * 修改教师作息时间
	 * @param scheduleTeacher
	 */
	public void modifyScheduleClazz(ScheduleClazz scheduleClazz)
	{
		getBaseDao().updateObject("Schedule.updateScheduleClazz", scheduleClazz);
	}
}
