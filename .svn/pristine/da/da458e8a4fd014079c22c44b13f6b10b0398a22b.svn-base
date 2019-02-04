package com.guotop.palmschool.schoolbus.service;


import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSchedule;
import com.guotop.palmschool.util.Pages;

/**
 * 校车时间设定业务类
 * 
 */
public interface SchoolBusScheduleService
{
	/**
	 * 添加校车时间
	 */
	public void addSchoolBusSchedule(SchoolBusSchedule schoolBusSchedule);

	/**
	 * 修改校车时间
	 */
	public void modifyschoolBusScheduleSById(Map<String, Object> paramMap);
	
	/**
	 * 加载校车时间设定List 20151212
	 */
	public Pages getSchoolBusScheduleList(int pageSize, int page, User user);
	
	/**
	 * 根据Id查找对应的时间 20151212
	 */
	public SchoolBusSchedule getSchoolBusScheduleById(Integer id);
	
	/**
	 * 加载某个时间段的校车
	 * @param date
	 * @return
	 */
	public List<SchoolBusSchedule> getSchoolBusScheduleListByDay(String date);
}
