package com.guotop.palmschool.evaluation.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;

/**
 * 教师评价查看业务类接口
 * 
 */
public interface TeacherEvaluationDetailService
{
	
	/**
	 * 根据Id查找未评价的教师
	 */
	public List<TeacherEvaluateFormModel> getTeacherEvaluateForm(Map<String, Object> paramMap);
	
	/**
	 * 根据clazzId查找已评价的教师
	 */
	public List<TeacherEvaluateFormModel> getTeacherEvaluateFormById(Integer id);
	
	/**
	 * 根据clazzId查找对应的评价
	 */
	public List<EvaluationClazzModel>  getEvaluationClazzModelById(Map<String, Object> paramMap);
	
	public List<TeacherEvaluateFormModel> getTeacherNotInTwo(Integer id);
}

