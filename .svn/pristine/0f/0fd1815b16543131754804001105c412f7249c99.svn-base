package com.guotop.palmschool.evaluation.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;
import com.guotop.palmschool.evaluation.service.StudentEvaluationViewService;
import com.guotop.palmschool.service.BaseService;

/**
 * 学生评价查看务类实现类
 */
@Service("studentEvaluationViewService")
@SuppressWarnings("unchecked")
public class StudentEvaluationViewServiceImpl extends BaseService implements StudentEvaluationViewService
{
	
	/**
	 * 根据Id查询对应的评价
	 * @param paramMap
	 * @return
	 */
	public List<EvaluationClazzModel> getEvaluateClazzByClazzId(Map<String, Object> paramMap)
	{
		return (List<EvaluationClazzModel>)getBaseDao().selectListByObject("StudentEvaluationView.getEvaluateClazzByClazzId", paramMap);
	}
	
	/**
	 * 查询评价信息
	 */
	public List<EvaluateModel> getStudentEvaluateForm(Map<String, Object> paramMap)
	{
		return (List<EvaluateModel>)getBaseDao().selectListByObject("StudentEvaluationView.getStudentEvaluateForm", paramMap);
	}
	
	/**
	 * 查询所有评价信息
	 */
	public List<TeacherEvaluateFormModel> getSteudentEvaluateFormAll(Map<String, Object> paramMap)
	{
		return (List<TeacherEvaluateFormModel>)getBaseDao().selectListByObject("StudentEvaluationView.getSteudentEvaluateFormAll", paramMap);
	}
	
	/**
	 * 查询所有的教师
	 */
	public List<User> getTeachers(Map<String, Object> paramMap)
	{
		return (List<User>)getBaseDao().selectListByObject("StudentEvaluationView.getTeachers", paramMap);
	}
	
	/**
	 * 根据模板Id查询对应的时间段
	 */
	public EvaluationTime getEvaluationTime(Map<String, Object> paramMap)
	{
		return (EvaluationTime)getBaseDao().selectObjectByObject("StudentEvaluationView.getEvaluationTime", paramMap);
	}
	
	 /**
	  * 根据Id查找评价信息
	  */
	public TeacherEvaluateFormModel getStudentEvaluateFormById(Integer id)
	{
		return (TeacherEvaluateFormModel)getBaseDao().selectObject("StudentEvaluationView.getStudentEvaluateFormById", id);
	}
	
	public List<TeacherEvaluateDetailModel> getStudentEvaluateDetailByStuNums(Integer id)
	{
		return (List<TeacherEvaluateDetailModel>)getBaseDao().selectList("StudentEvaluationView.getStudentEvaluateDetailByStuNums", id);
	}
	
	/**
	 * 根据Id查找 评价信息标题（选项数量）
	 */
	public List<EvaluateModel> getStudentEvaluateTitleList(Integer id)
	{
		return (List<EvaluateModel>)getBaseDao().selectList("StudentEvaluationView.getStudentEvaluateTitleList", id);
	}
	
	/**
	 * 根据Id查找 评价信息标题
	 */
	public List<TeacherEvaluateTitleModel> getStudentEvaluateTitleForLevel(Integer id)
	{
		return (List<TeacherEvaluateTitleModel>)getBaseDao().selectList("StudentEvaluationView.getStudentEvaluateTitleForLevel", id);
	}
	
	public Integer getSumLevel(Integer id)
	{
		return (Integer)getBaseDao().selectObject("StudentEvaluationView.getSumLevel", id);
	}
	
	/**
	 * 根据Id查找 评价短语 （感想建议题）
	 * @param formId
	 * @param modelId
	 * @return
	 */
	public List<TeacherEvaluatePhraseModel> getStudentEvaluatePhraseList(Integer formId,Integer modelId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("formId", formId);
		paramMap.put("modelId", modelId);
		return (List<TeacherEvaluatePhraseModel>)getBaseDao().selectListByObject("StudentEvaluationView.getStudentEvaluatePhraseList", paramMap);
	}
	
}
