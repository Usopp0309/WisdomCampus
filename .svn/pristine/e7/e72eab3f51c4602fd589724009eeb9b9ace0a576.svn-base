package com.guotop.palmschool.evaluation.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.service.TeacherEvaluationDetailService;
import com.guotop.palmschool.service.BaseService;

/**
 * 已评或未评教师业务类实现类
 */
@Service("teacherEvaluationDetailService")
@SuppressWarnings("unchecked")
public class TeacherEvaluationDetailServiceImpl extends BaseService implements TeacherEvaluationDetailService
{
	
	public List<TeacherEvaluateFormModel> getTeacherEvaluateForm(Map<String, Object> paramMap)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectListByObject("TeacherEvaluationDetail.getTeacherEvaluateForm", paramMap);
	}
	
	/**
	 * 根据clazzId查找已评价的教师
	 */
	public List<TeacherEvaluateFormModel> getTeacherEvaluateFormById(Integer id)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectList("TeacherEvaluationDetail.getTeacherEvaluateFormById", id);
	}
	
	/**
	 * 根据clazzId查找对应的评价
	 */
	public List<EvaluationClazzModel>  getEvaluationClazzModelById(Map<String, Object> paramMap)
	{
		return (List<EvaluationClazzModel>)getBaseDao().selectListByObject("TeacherEvaluationDetail.getEvaluationClazzModelById", paramMap);
	}
	
	public List<TeacherEvaluateFormModel> getTeacherNotInTwo(Integer id)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectList("TeacherEvaluationDetail.getTeacherNotInTwo", id);
	}
}
