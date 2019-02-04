package com.guotop.palmschool.evaluation.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetail;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;
import com.guotop.palmschool.evaluation.service.EvaluationListService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 评价列表业务类实现类
 */
@Service("evaluationListService")
@SuppressWarnings("unchecked")
public class EvaluationListServiceImpl extends BaseService implements EvaluationListService
{
	
	/**
	 * 根据userId查询对应的班级(学生)
	 */
	public Clazz getClazzForStudentByUserId(Integer userId)
	{
		return (Clazz)getBaseDao().selectObject("EvaluationList.getClazzForStudentByUserId", userId);
		
	}
	
	/**
	 * 根据userId查询对应的班级(教师)
	 */
	public List<Integer> getClazzIdForTeacherByUserId(Integer userId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("date", TimeUtil.getInstance().date());
		
		//当前时间在不在学期内   如果在就去取本学期的科目对应的教师    如果不在则 查询上学期课程表对应的科目教师
		List<Integer> list = getBaseDao().selectListByObject("EvaluationList.getClazzIdForTeacherByUserIdForIn", paramMap);
		
		if(list.size()==0)
		{
			list = getBaseDao().selectListByObject("EvaluationList.getClazzIdForTeacherByUserIdForNotIn", paramMap);
		}
		
		return list;
		
	}
	
	/**
	 * 根据班级Id 查询对应的年级
	 */
	public List<Integer> getGradeIdForTeacherByClazzId(List<Integer> clazzIdList)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("clazzIdList", clazzIdList);
		return (List<Integer>)getBaseDao().selectListByObject("EvaluationList.getGradeIdForTeacherByClazzId", paramMap);
		
	}
	
	/**
	 * 根据clazzId gradeId userType 查询对应的模板(学生)
	 */
	public List<EvaluationClazzModel> getEvaluationClazzModelListForStudent(Map<String, Object> paramMap)
	{
		return (List<EvaluationClazzModel>)getBaseDao().selectListByObject("EvaluationList.getEvaluationClazzModelListForStudent", paramMap);
	}
	
	/**
	 * 根据clazzId gradeId userType 查询对应的模板(教师)
	 */
	public List<EvaluationClazzModel> getEvaluationClazzModelListForTeacher(Map<String, Object> paramMap)
	{
		List<EvaluationClazzModel> list = (List<EvaluationClazzModel>)getBaseDao().selectListByObject("EvaluationList.getEvaluationClazzModelListForTeacher", paramMap);
		return list;
	}
	
	/**
	 * 根据clazzIdList查询对应的学生
	 */
	public List<User> getStudentListByClazzId(Map<String, Object> paramMap)
	{
		return (List<User>)getBaseDao().selectListByObject("User.getStudentListByClazzId", paramMap);
	}
	
	/**
	 * 查询用户是否已评
	 */
	public List<TeacherEvaluateDetail> getTeacherEvaluateDetailByUserId(Map<String, Object> paramMap)
	{
		return (List<TeacherEvaluateDetail>)getBaseDao().selectListByObject("EvaluationList.getTeacherEvaluateDetailByParamMap", paramMap);
	}
	
	/**
	 * 查找评价信息表(教师对学生 或者 学生对教师)
	 */
	public EvaluateFormModel  getEvaluateForm(Map<String, Object> paramMap)
	{
		return (EvaluateFormModel)getBaseDao().selectObjectByObject("EvaluationList.getEvaluateFormByParamMap", paramMap);
	}
	
	/**
	 * 添加评价信息
	 */
	public void addEvaluateFormModel(EvaluateFormModel evaluateFormModel)
	{
		 getBaseDao().addObject("EvaluationList.addEvaluateFormModel", evaluateFormModel);
	}
	
	/**
	 * 根据Id 查找评价信息
	 */
	public TeacherEvaluateFormModel getTeacherEvaluateForm(Integer id)
	{
		return (TeacherEvaluateFormModel)getBaseDao().selectObject("EvaluationList.getTeacherEvaluateForm", id);
	}
	
	/**
	 *添加评价信息
	 */
	public void addTeacherEvaluateFormModel(Integer id)
	{
		getBaseDao().addObject("EvaluationList.addTeacherEvaluateFormModel", id);
	}
	
	/**
	 * 根据Id查找评价信息标题
	 */
	public List<TeacherEvaluateTitleModel> getTeacherEvaluateTitleForLevel(Integer id)
	{
		return (List<TeacherEvaluateTitleModel>)getBaseDao().selectList("EvaluationList.getTeacherEvaluateTitleForLevel", id);
	}
	
	/**
	 * 添加评价信息标题
	 */
	public void addNewexercisesTitle(Map<String, Object> paramMap)
	{
		String type = (String) paramMap.get("type");
		
		if("评论选项".equals(type.trim()))
		{
			paramMap.put("titletype", 1);
			getBaseDao().addObject("EvaluationList.addNewexercisesTitle", paramMap);
		}else
		{
			paramMap.put("titletype", 2);
			getBaseDao().addObject("EvaluationList.addNewexercisesTitle", paramMap);
		}
	}
	
	/**
	 * 查询评价选项详情
	 */
	public List<TeacherEvaluateDetailModel> getTeacherEvaluateDetailList(Integer formId,Integer userId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(formId!=0)
		{
			paramMap.put("formId", formId);
			paramMap.put("userId", userId);
			return (List<TeacherEvaluateDetailModel>) getBaseDao().selectListByObject("EvaluationList.getTeacherEvaluateDetailList", paramMap);
		}else{
			paramMap.put("formId","");
			paramMap.put("userId", userId);
			return (List<TeacherEvaluateDetailModel>) getBaseDao().selectListByObject("EvaluationList.getTeacherEvaluateDetailList", paramMap);
		}
	}
	
	/**
	 * 单选问题插入新表
	 */
	public void addNewexercisesDetail(Map<String, Object> paramMap)
	{
		getBaseDao().addObject("EvaluationList.addNewexercisesDetail", paramMap);
	}
	
	/**
	 * 根据id查询评价详情信息表(感想/建议题)
	 */
	public List<TeacherEvaluatePhraseModel> getTeacherEvaluatePhraseList(Integer formId, Integer id)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(formId!=0){
			paramMap.put("formId", formId);
			paramMap.put("titleId", id);
			return (List<TeacherEvaluatePhraseModel>) getBaseDao().selectListByObject("EvaluationList.getTeacherEvaluatePhraseList", paramMap);
		}else{
			paramMap.put("formId","");
			paramMap.put("userId", id);
			return (List<TeacherEvaluatePhraseModel>) getBaseDao().selectListByObject("EvaluationList.getTeacherEvaluatePhraseList", paramMap);
		}
	}
	
	/**
	 * 添加评价短语（感想建议题）
	 */
	public void addNewEvaluatePhrase(TeacherEvaluatePhraseModel model)
	{
		if (model == null)
			return;
		getBaseDao().addObject("EvaluationList.addNewEvaluatePhrase", model);
	}
	
	/**
	 * 根据Id查找评价信息标题
	 */
	public List<TeacherEvaluateTitleModel> getTeacherEvaluateTitleIdById(Map<String, Object> paramMap)
	{
		return (List<TeacherEvaluateTitleModel>) getBaseDao().selectListByObject("EvaluationList.getTeacherEvaluateTitleIdById", paramMap);
	}
	
	
	/**
	 * 根据班级Id查询对应的教师（通过课程表查询教师）
	 */
	public List<User> getTeachers(Integer clazzId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("clazzId", clazzId);
		paramMap.put("date", TimeUtil.getInstance().date());
		
		//当前时间在不在学期内   如果在就去取本学期的科目对应的教师    如果不在则 查询上学期课程表对应的科目教师
		List<User> list = getBaseDao().selectListByObject("EvaluationList.getTeachersByThis", paramMap);
		
		if(list.size()==0)
		{
			list = getBaseDao().selectListByObject("EvaluationList.getTeachersByBefore", paramMap);
		}
		
		return list;
	}
}
