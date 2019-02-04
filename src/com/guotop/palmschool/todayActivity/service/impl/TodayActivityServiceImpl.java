package com.guotop.palmschool.todayActivity.service.impl;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.curriculum.entity.CurriculumSemester;
import com.guotop.palmschool.curriculum.entity.CurriculumTime;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.todayActivity.service.TodayActivityService;


/**
 * 今日活动业务类实现类
 */
@Service("todayActivityService")
public class TodayActivityServiceImpl extends BaseService implements TodayActivityService
{
	/**
	 * 根据日期查询对应的阶段
	 * @param day
	 * @return
	 */
	public CurriculumSemester getTodayActivityByDate(Map<String,Object> paramMap)
	{
		return (CurriculumSemester)getBaseDao().selectObjectByObject("TodayActivity.getTodayActivityByDate", paramMap);
	}
	
	/**
	 * 根据semesterId查询中的时间段
	 * @param semesterId
	 * @return
	 */
	public CurriculumTime getCurriculumTimeNoonBySemesterId(Integer semesterId)
	{
		return (CurriculumTime)getBaseDao().selectObject("TodayActivity.getCurriculumTimeNoonBySemesterId", semesterId);
	}
	
	/**
	 * 修改时间
	 * @param paramMap
	 */
	public void modifyTime(Map<String,Object> paramMap)
	{
		getBaseDao().updateObject("TodayActivity.modifyTime", paramMap);
	}
	
	/**
	 * 修改活动名称
	 * @param paramMap
	 */
	public void modifyActivityName(Map<String,Object> paramMap)
	{
		getBaseDao().updateObject("TodayActivity.modifyActivityName", paramMap);
	}
	
	/**
	 * 校验学期日期是否存在
	 */
	public ResultInfo checkSemester(Map<String, Object> paramMap)
	{
		Integer result = 0;

		try
		{
			result = (Integer) getBaseDao().selectObjectByObject("TodayActivity.checkSemester", paramMap);
		} catch (Exception e)
		{
			e.printStackTrace();
			result = 0;
		}
		ResultInfo resultInfo = new ResultInfo();
		if (result > 0)
		{
			resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
		} else
		{
			resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
		}
		return resultInfo;
	}
	
}
