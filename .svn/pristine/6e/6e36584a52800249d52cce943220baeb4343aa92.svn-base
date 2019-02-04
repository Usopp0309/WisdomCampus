package com.guotop.palmschool.check.service;

import java.util.Date;
import java.util.Map;

import com.guotop.palmschool.check.entity.Stay;
import com.guotop.palmschool.check.entity.Total;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 考勤统计业务类接口
 * @author zhou
 */
public interface TotalService 
{
	/**
	 * 页面加载考勤统计列表
	 * @param paramMap 参数map
	 * @param user 当前用户
	 * @return 考勤统计/分页
	 */
	public Pages loadTotalCheckList(int pageSize, int page, 
			Map<String, Object> paramMap, User user, Integer roleId);

	public Total getLastTotal(Map<String, Object> paramMap);
	
	public Stay getFirstStay(int userType);
		
	/**
	 * 按人天统计
	 * @param startDay 统计日期
	 * @param userType 人员类型，1:教师，2:学生
	 */
	public int totalByPersonDay(Date startDay, int userType);
	
	public int totalDay(Date start, int userType, int type);
}
