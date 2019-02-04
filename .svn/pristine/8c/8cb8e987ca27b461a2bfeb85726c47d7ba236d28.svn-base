package com.guotop.palmschool.todayActivity.service;

import java.util.Map;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.curriculum.entity.CurriculumSemester;
import com.guotop.palmschool.curriculum.entity.CurriculumTime;

/**
 * 今日活动业务类接口
 */
public interface TodayActivityService
{
	/**
	 * 根据日期查询对应的阶段
	 * 
	 * @param day
	 * @return
	 */
	public CurriculumSemester getTodayActivityByDate(Map<String, Object> paramMap);

	/**
	 * 根据semesterId查询中的时间段
	 * 
	 * @param semesterId
	 * @return
	 */
	public CurriculumTime getCurriculumTimeNoonBySemesterId(Integer semesterId);

	/**
	 * 修改时间
	 * 
	 * @param paramMap
	 */
	public void modifyTime(Map<String, Object> paramMap);

	/**
	 * 修改活动名称
	 * 
	 * @param paramMap
	 */
	public void modifyActivityName(Map<String, Object> paramMap);
	
	/**
	 * 校验日期是否存在
	 */
	public ResultInfo checkSemester(Map<String, Object> paramMap);
	
}
