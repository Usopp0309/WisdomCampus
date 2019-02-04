package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.ScheduleClazz;
import com.guotop.palmschool.entity.ScheduleTeacher;
import com.guotop.palmschool.entity.ScheduleTime;
import com.guotop.palmschool.entity.ScheduleTimeRelation;
import com.guotop.palmschool.util.Pages;


/**
 * 作息时间表业务类接口
 * @author zhou
 *
 */
public interface ScheduleService 
{
	/**
	 * 根据查询条件查询作息时间表 /分页查询
	 * @param paramMap 条件
	 * @return 作息时间表记录/分页
	 */
	public Pages loadScheduleList(int pageSize, int page, Map<String, Object> paramMap);
	/**
	 * 根据查询条件查询作息时间表 /分页查询【福建专用】
	 * @param paramMap 条件
	 * @return 作息时间表记录/分页
	 */
	public Pages loadScheduleListFj(int pageSize, int page, Map<String, Object> paramMap);
	/**
	 * 新增作息时间表
	 * @param schedule 待添加的作息时间表
	 */
	public Integer addSchedule(Schedule schedule);
	
	/**
	 * 根据主键查找作息时间表实体类
	 * @param scheduleId 作息时间表主键
	 * @return 作息时间实体
	 */
	public Schedule selectScheduleById(Integer scheduleId);
	
	/**
	 * 根据生效时间查找作息时间表集合
	 * @param liveingDate 作息时间
	 * @return List<Schedule> 作息时间集合表
	 */
	public List<Schedule> selectScheduleListByLiveingDate(String liveingDate);
	
	/**
	 * 修改作息时间表
	 * @param scheduleId 作息时间表主键
	 */
	public void updateScheduleById(Map<String, Object> paramMap);
	
	/**
	 * 判断今天是否上课
	 * true:上课  false:休息
	 */
	public boolean isWorkToday();

	/**
	 * 删除作息时间表
	 * @param liveingDate 作息时间表日期
	 */
	public void deleteScheduleByLiveingDate(String liveingDate);
	
	
	/**
	 * 根据时间查找作息时间表集合
	 * @param time 查找的时间
	 * @return List<Schedule> 作息时间集合表
	 */
	public List<Schedule> selectScheduleListTime(String time);
	
	
	/**
	 * 查找作息时间的最后一条数据 （设置作息时间提醒用） 
	 */
	public Schedule selectSchedule();
	/**
	 * 查找作息时间
	 */
	public Schedule selectWorkingDays(Map<String,Object> map);
	
	/**
	 * 根据作息时间得出靠近当前时间最近五天工作日
	 */
	public List<String> loadScheduleListInAPP(Map<String, Object> paramMap);

	
	
	
	/***********************新的作息时间设置*****************************/
	
	/**
	 * 添加作息时间段
	 * @param scheduleTime
	 * @return
	 */
	public Integer saveScheduleTime(ScheduleTime scheduleTime);
	
	/**
	 * 添加作息时间和作息时间段的关系
	 * @param relation
	 */
	public void saveScheduleTimeRelation(ScheduleTimeRelation relation);
	
	/**
	 * 根据开始日期结束日期获取对应的时间段
	 * @param paramMap
	 * @return
	 */
	public List<ScheduleTime> getScheduleTimeListByStartDayAndEndDay(Map<String,Object> paramMap);
	
	/**
	 * 清空当前日期往后的作息时间
	 */
	public void clearSchedule(String liveingDate);
	/**
	 * 根据时间段id获取对应的时间段
	 * @param timeId
	 * @return
	 */
	public ScheduleTime getScheduleTimeById(Integer timeId);
	
	/**
	 * 添加班级对应的作息时间
	 * @param scheduleClazz
	 * @return
	 */
	public Integer saveScheduleClazz(ScheduleClazz scheduleClazz);
	
	/**
	 * 添加教师对应的作息时间
	 * @param scheduleTeacher
	 * @return
	 */
	public Integer saveScheduleTeacher(ScheduleTeacher scheduleTeacher);
	
	/**
	 * 根据生效日期以及年级Id或者班级Id,获取对应的考勤列表
	 * @param liveingDate
	 * @param gradeId
	 * @param clazzId
	 * @return
	 */
	public List<ScheduleClazz> getScheduleListByLiveingAndGradeIdOrClazzId(String liveingDate,String gradeId,String clazzId);
	
	/**
	 * 根据生效日期以及部门Id获取对应的考勤列表
	 * @param liveingDate
	 * @param gradeId
	 * @param clazzId
	 * @return
	 */
	public List<ScheduleTeacher> getScheduleListByLiveingAndDepartmentId(String liveingDate,String departmentId);
	
	/**
	 * 根据生效日期修改作息时间状态
	 * @param paramMap
	 */
	public void modifySchedule(Map<String,Object> paramMap);
	
	/**
	 * 根据生效日期修改班级作息时间状态
	 * @param paramMap
	 */
	public void modifyScheduleClazz(Map<String,Object> paramMap);
	/**
	 * 根据生效日期修改教师作息时间状态
	 * @param paramMap
	 */
	public void modifyScheduleTeacher(Map<String,Object> paramMap);
	
	/**
	 * 根据日期和用户id获取对应的作息时间
	 * @return
	 */
	public ScheduleClazz getScheduleClazzByUserIdAndLiveingDate(String date,Integer userId);
	/**
	 * 根据日期和班级id获取对应的作息时间
	 * @return
	 */
	public ScheduleClazz getScheduleClazzByClazzIdAndLiveingDate(String liveDate, Integer clazzId);
	
	/**
	 * 根据日期和用户id获取对应的作息时间
	 * @return
	 */
	public ScheduleTeacher getScheduleTeacherByUserIdAndLiveingDate(String date,Integer userId);
	
	/**
	 * 修改教师作息时间
	 * @param scheduleTeacher
	 */
	public void modifyScheduleTeacher(ScheduleTeacher scheduleTeacher);
	
	/**
	 * 修改教师作息时间
	 * @param scheduleTeacher
	 */
	public void modifyScheduleClazz(ScheduleClazz scheduleClazz);

}
