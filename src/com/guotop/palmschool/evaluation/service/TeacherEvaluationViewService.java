package com.guotop.palmschool.evaluation.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;

/**
 * 教师评价查看业务类接口
 * 
 */
public interface TeacherEvaluationViewService
{
	
	/**
	 *  根据clazzId 查询教师对应的评价
	 * @param paramMap
	 * @return
	 */
	public List<EvaluationClazzModel> getEvaluateClazzByClazzId(Map<String, Object> paramMap);
	
	/**
	 *  根据clazzId 查询班级
	 * @param clazzId
	 * @return
	 */
	public Clazz getClazzById(Integer clazzId);
	
	/**
	 *  根据clazzId 查询班级
	 * @param paramMap
	 * @return
	 */
	public List<EvaluateModel> getTeacherEvaluateForm(Map<String, Object> paramMap);
	
	/**
	 * 查询所有的评价信息
	 */
	public List<TeacherEvaluateFormModel> getTeacherEvaluateFormAll(Map<String, Object> paramMap);
	
	/**
	 * 查询有多少学生参与了评价
	 */
	public List<TeacherEvaluateDetailModel> getTeacherEvaluateDetailByStu(Map<String, Object> paramMap);
	
	/**
	 * 查询班级一共有多少学生
	 */
	public List<User> getStudents(Integer clazzId);
	
	/**
	 * 根据Id查询评价信息
	 */
	public TeacherEvaluateFormModel getTeacherEvaluateFormById(Integer id);
	
	public List<TeacherEvaluateDetailModel> getTeacherEvaluateDetailByStuNums(Integer id);
	
	/**
	 * 根据Id查询评价信息（选项）
	 */
	public List<EvaluateModel> getTeacherEvaluateTitleList(Integer id);
	
	/**
	 * 根据Id查询评价信息
	 */
	public List<TeacherEvaluateTitleModel> getTeacherEvaluateTitleForLevel(Integer id);
	
	public Integer getSumLevel();
	
	/**
	 * 根据Id查询评价短语（感想建议题） 
	 */
	public List<TeacherEvaluatePhraseModel> getTeacherEvaluatePhraseList(Integer formId,Integer titleId);
	
}

