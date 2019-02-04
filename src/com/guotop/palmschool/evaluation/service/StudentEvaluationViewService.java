package com.guotop.palmschool.evaluation.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;

/**
 * 学生评价查看业务类接口
 * 
 */
public interface StudentEvaluationViewService
{
	
	/**
	 * 根据Id查询对应的评价
	 * @param paramMap
	 * @return
	 */
	public List<EvaluationClazzModel> getEvaluateClazzByClazzId(Map<String, Object> paramMap);
	
	/**
	 * 查询评价信息
	 */
	public List<EvaluateModel> getStudentEvaluateForm(Map<String, Object> paramMap);
	
	/**
	 * 查询所有评价信息
	 */
	public List<TeacherEvaluateFormModel> getSteudentEvaluateFormAll(Map<String, Object> paramMap);
	
	/**
	 * 根据模板Id查询对应的时间段
	 */
	public EvaluationTime getEvaluationTime(Map<String, Object> paramMap);
	
	/**
	 * 查询所有教师
	 */
	public List<User> getTeachers(Map<String, Object> paramMap);
	
	 /**
	  * 根据Id查找评价信息
	  */
	public TeacherEvaluateFormModel getStudentEvaluateFormById(Integer id);
	
	public List<TeacherEvaluateDetailModel> getStudentEvaluateDetailByStuNums(Integer id);
	
	/**
	 * 根据Id查找 评价信息标题（选项数量）
	 */
	public List<EvaluateModel> getStudentEvaluateTitleList(Integer id);
	
	/**
	 * 根据Id查找 评价信息标题
	 */
	public List<TeacherEvaluateTitleModel> getStudentEvaluateTitleForLevel(Integer id);
	
	public Integer getSumLevel(Integer id);
	
	/**
	 * 根据Id查找 评价短语 （感想建议题）
	 * @param formId
	 * @param modelId
	 * @return
	 */
	public List<TeacherEvaluatePhraseModel> getStudentEvaluatePhraseList(Integer formId,Integer modelId);
	
}

