package com.guotop.palmschool.evaluation.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.util.Pages;

/**
 * 评价时间设定业务类接口
 * 
 */
public interface EvaluationTimeService
{
	
	/**
	 * 根据条件查询评价时间设定List /分页查询
	 * @param paramMap 条件
	 * @return 评价时间记录/分页
	 */
	public Pages getEvaluationTimeList(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 增加评价时间
	 * @return
	 */
	public Integer addEvaluationTime(EvaluationTime evaluationTime);
	
	public Integer addEvaluationClazzModel(EvaluationClazzModel evaluationClazzModel);
	
	/**
	 * 修改评价时间
	 */
	public void updateEvaluationTime(EvaluationTime evaluationTime);
	
	/**
	 * 根据Id查找时间
	 * @param id
	 * @return
	 */
	public EvaluationTime getEvaluationTimeById(Integer id);
	
	public void deleteEvaluationClazzModelById(Integer id);
	
	/**
	 * 根据Id 日期 查找时间
	 * @param paramMap
	 * @return
	 */
	public List<EvaluationTime> getEvaluationTimeByIdAndDate(Map<String, Object> paramMap);
	
	public List<EvaluationClazzModel> getEvaluationClazzByTimeId(Integer id);
	
}
