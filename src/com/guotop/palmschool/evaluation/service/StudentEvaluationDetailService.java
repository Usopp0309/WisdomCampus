package com.guotop.palmschool.evaluation.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;


/**
 * 教师评价查看业务类接口
 * 
 */
public interface StudentEvaluationDetailService
{
	
	public List<TeacherEvaluateFormModel> getStudentEvaluateForm(Map<String, Object> paramMap);
	
	/**
	 * 根据 查找学生对应的评价
	 * @param paramMap
	 * @return
	 */
	public  List<EvaluationClazzModel> getEvaluationClazzModelById(Map<String, Object> paramMap);
	
	/**
	 * 根据clazzId查找已评价过的学生
	 * @param id
	 * @return
	 */
	public List<TeacherEvaluateFormModel> getStudentEvaluateFormById(Integer id);
	
	public List<TeacherEvaluateFormModel> getTeacherNotInTwo(Integer id);
}

