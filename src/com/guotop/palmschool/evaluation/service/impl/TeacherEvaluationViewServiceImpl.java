package com.guotop.palmschool.evaluation.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;
import com.guotop.palmschool.evaluation.service.TeacherEvaluationViewService;
import com.guotop.palmschool.service.BaseService;

/**
 * 教师评价务类实现类
 */
@Service("teacherEvaluationViewService")
@SuppressWarnings("unchecked")
public class TeacherEvaluationViewServiceImpl extends BaseService implements TeacherEvaluationViewService
{
	
	/**
	 *  根据clazzId 查询教师对应的评价
	 * @param paramMap
	 * @return
	 */
	public List<EvaluationClazzModel> getEvaluateClazzByClazzId(Map<String, Object> paramMap)
	{
		return (List<EvaluationClazzModel>)getBaseDao().selectListByObject("TeacherEvaluationView.getEvaluateClazzByClazzId", paramMap);
	}
	
	/**
	 *  根据clazzId 查询班级
	 * @param clazzId
	 * @return
	 */
	public Clazz getClazzById(Integer clazzId)
	{
		return (Clazz)getBaseDao().selectObject("TeacherEvaluationView.getClazzById", clazzId);
	}
	
	/**
	 *  根据clazzId 查询班级
	 * @param paramMap
	 * @return
	 */
	public List<EvaluateModel> getTeacherEvaluateForm(Map<String, Object> paramMap)
	{
		return (List<EvaluateModel>)getBaseDao().selectListByObject("TeacherEvaluationView.getTeacherEvaluateForm", paramMap);
	}
	
	/**
	 * 查询所有的评价信息
	 */
	public List<TeacherEvaluateFormModel> getTeacherEvaluateFormAll(Map<String, Object> paramMap)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectListByObject("TeacherEvaluationView.getTeacherEvaluateFormAll", paramMap);
	}
	
	/**
	 * 查询有多少学生参与了评价
	 */
	public List<TeacherEvaluateDetailModel> getTeacherEvaluateDetailByStu(Map<String, Object> paramMap)
	{
		return (List<TeacherEvaluateDetailModel>)getBaseDao().selectListByObject("TeacherEvaluationView.getTeacherEvaluateDetailByStu", paramMap);
	}
	
	/**
	 * 查询班级一共有多少学生
	 */
	public List<User> getStudents(Integer clazzId)
	{
		return (List<User>)getBaseDao().selectList("TeacherEvaluationView.getStudents", clazzId);
	}
	
	/**
	 * 根据Id查询评价信息
	 */
	public TeacherEvaluateFormModel getTeacherEvaluateFormById(Integer id)
	{
		return (TeacherEvaluateFormModel)getBaseDao().selectObject("TeacherEvaluationView.getTeacherEvaluateFormById", id);
	}
	
	public List<TeacherEvaluateDetailModel> getTeacherEvaluateDetailByStuNums(Integer id)
	{
		return (List<TeacherEvaluateDetailModel>)getBaseDao().selectList("TeacherEvaluationView.getTeacherEvaluateDetailByStuNums", id);
	}
	
	/**
	 * 根据Id查询评价信息（选项）
	 */
	public List<EvaluateModel> getTeacherEvaluateTitleList(Integer id)
	{
		return (List<EvaluateModel>)getBaseDao().selectList("TeacherEvaluationView.getTeacherEvaluateTitleList", id);
	}
	
	/**
	 * 根据Id查询评价信息
	 */
	public List<TeacherEvaluateTitleModel> getTeacherEvaluateTitleForLevel(Integer id)
	{
		return (List<TeacherEvaluateTitleModel>)getBaseDao().selectList("TeacherEvaluationView.getTeacherEvaluateTitleForLevel", id);
	}
	
	public Integer getSumLevel()
	{
		return (Integer)getBaseDao().selectObject("TeacherEvaluationView.getSumLevel", null);
	}
	
	/**
	 * 根据Id查询评价短语（感想建议题） 
	 */
	public List<TeacherEvaluatePhraseModel> getTeacherEvaluatePhraseList(Integer formId,Integer titleId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("formId", formId);
		paramMap.put("titleId", titleId);
		return (List<TeacherEvaluatePhraseModel>) getBaseDao().selectListByObject("TeacherEvaluationView.getTeacherEvaluatePhraseList", paramMap);
	}
	
}
