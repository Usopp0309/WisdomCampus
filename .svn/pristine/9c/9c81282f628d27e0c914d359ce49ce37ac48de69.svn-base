package com.guotop.palmschool.schoolbus.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusAbnormal;
import com.guotop.palmschool.util.Pages;

/**
 * 校车异常业务类接口
 * @author zhou
 */
public interface SchoolBusAbnormalService 
{
	/**
	 * 根据条件查询校车记录 /分页查询
	 * @param paramMap 条件
	 * @param roleId 权限ID
	 * @return 进出校车记录/分页
	 */
	public Pages loadSchoolBusAbnormalList(int pageSize, int page, Map<String, Object> paramMap, 
			Integer roleId);
	
	/**
	 * 学生到点未上校车
	 * @param dormitoryNotLeaveBeginTime 正常上校车起始时间
	 * 
	 * @return List<User> 到点未上校车的学生
	 */
	public List<User> selectStudentNotOnBus(String schoolBusNotOnBeginTime,
			String schoolBusNotOnEndTime);
	
	/**
	 * 添加校车异常记录实体
	 * @param check 待添加的考勤异常记录实体
	 */
	public void addSchoolBusAbnormal(SchoolBusAbnormal schoolBusAbnormal);
	
	/**
	 * 查找进出记录(为了导出excel)
	 * @param paramMap 参数map
	 * @param roleId 权限ID
	 */
	public List<SchoolBusAbnormal>  loadSchoolBusAbnormalListForExport(Map<String, Object> paramMap, 
			Integer roleId);
}
