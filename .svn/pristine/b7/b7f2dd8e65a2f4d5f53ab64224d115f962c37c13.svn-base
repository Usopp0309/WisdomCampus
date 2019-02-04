package com.guotop.palmschool.evaluation.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.service.StudentEvaluationDetailService;
import com.guotop.palmschool.service.BaseService;

/**
 * 已评或未评学生业务类实现类
 */
@Service("studentEvaluationDetailService")
@SuppressWarnings("unchecked")
public class StudentEvaluationDetailServiceImpl extends BaseService implements StudentEvaluationDetailService
{
	
	public List<TeacherEvaluateFormModel> getStudentEvaluateForm(Map<String, Object> paramMap)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectListByObject("StudentEvaluationDetail.getStudentEvaluateForm", paramMap);
	}
	
	/**
	 * 根据clazzId查找已评价过的学生
	 */
	public List<TeacherEvaluateFormModel> getStudentEvaluateFormById(Integer id)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectList("StudentEvaluationDetail.getStudentEvaluateFormById", id);
	}
	
	/**
	 * 根据 查找学生对应的评价
	 * @param paramMap
	 * @return
	 */
	public  List<EvaluationClazzModel> getEvaluationClazzModelById(Map<String, Object> paramMap)
	{
		return (List<EvaluationClazzModel>)getBaseDao().selectListByObject("StudentEvaluationDetail.getEvaluationClazzModelById", paramMap);
	}
	
	public List<TeacherEvaluateFormModel> getTeacherNotInTwo(Integer id)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectList("StudentEvaluationDetail.getStudentNotInTwo", id);
	}
}
