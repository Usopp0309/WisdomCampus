package com.guotop.palmschool.evaluation.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetail;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;

/**
 * 评价列表设定业务类接口
 * 
 */
public interface EvaluationListService
{
	
	/**
	 * 根据userId查询对应的班级(学生)
	 */
	public Clazz getClazzForStudentByUserId(Integer userId);
	
	/**
	 * 根据userId查询对应的班级(教师)
	 */
	public List<Integer> getClazzIdForTeacherByUserId(Integer userId);
	
	/**
	 * 根据班级Id 查询对应的年级
	 */
	public List<Integer> getGradeIdForTeacherByClazzId(List<Integer> clazzIdList);
	
	/**
	 * 根据clazzId gradeId userType 查询对应的模板（学生）
	 */
	public List<EvaluationClazzModel> getEvaluationClazzModelListForStudent(Map<String, Object> paramMap);
	
	/**
	 * 根据clazzId gradeId userType 查询对应的模板（教师u）
	 */
	public List<EvaluationClazzModel> getEvaluationClazzModelListForTeacher(Map<String, Object> paramMap);
	
	/**
	 * 根据clazzIdList查询对应的学生
	 */
	public List<User> getStudentListByClazzId(Map<String, Object> paramMap);
	
	
	/**
	 * 查询用户是否已评
	 */
	public List<TeacherEvaluateDetail> getTeacherEvaluateDetailByUserId(Map<String, Object> paramMap);
	
	
	/**
	 * 查找评价信息表(教师对学生 或者 学生对教师)
	 */
	public EvaluateFormModel  getEvaluateForm(Map<String, Object> paramMap);
	
	/**
	 * 添加评价信息
	 * @param evaluateFormModel
	 */
	public void addEvaluateFormModel(EvaluateFormModel evaluateFormModel);
	
	/**
	 * 根据Id 查找评价信息
	 * @param id
	 * @return
	 */
	public TeacherEvaluateFormModel getTeacherEvaluateForm(Integer id);
	
	/**
	 *添加评价信息
	 */
	public void addTeacherEvaluateFormModel(Integer id);
	
	/**
	 * 根据Id查找评价信息标题
	 */
	public List<TeacherEvaluateTitleModel> getTeacherEvaluateTitleForLevel(Integer id);
	
	/**
	 * 添加评价信息标题
	 */
	public void addNewexercisesTitle(Map<String, Object> paramMap);
	
	/**
	 * 查询评价选项详情
	 */
	public List<TeacherEvaluateDetailModel> getTeacherEvaluateDetailList(Integer formId,Integer userId);
	
	/**
	 * 单选问题插入新表
	 */
	public void addNewexercisesDetail(Map<String, Object> paramMap);
	
	/**
	 * 根据id查询评价详情信息表(感想/建议题)
	 */
	public List<TeacherEvaluatePhraseModel> getTeacherEvaluatePhraseList(Integer formId, Integer userId);
	
	/**
	 * 添加评价短语（感想建议题）
	 */
	public void addNewEvaluatePhrase(TeacherEvaluatePhraseModel model);
	
	/**
	 * 根据Id查找评价信息标题
	 */
	public List<TeacherEvaluateTitleModel> getTeacherEvaluateTitleIdById(Map<String, Object> paramMap);
	
	
	/**
	 * 根据班级Id查询对应的教师（通过课程表查询教师）
	 */
	public List<User> getTeachers(Integer clazzId);
}

