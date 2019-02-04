package com.guotop.palmschool.evaluation.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.evaluation.entity.EvaluationExercises;
import com.guotop.palmschool.evaluation.entity.EvaluationExercisesDetail;
import com.guotop.palmschool.evaluation.entity.EvaluationTemplate;

/**
 * 评价模板设定业务类接口
 * 
 */
public interface EvaluationTemplateService
{
	
	/**
	 * 根据条件查询评价模板设定 （根据parentId）
	 */
	public List<EvaluationTemplate> getEvaluationTemplateListByParentId(Integer parentId);
	
	/**
	 * 添加评价模板
	 */
	public void addEvaluationTemplate(EvaluationTemplate evaluationTemplate);
	
	/**
	 * 添加试题
	 */
	public Integer addEvaluationTestQuestions(EvaluationTemplate evaluationTemplate);
	
	/**
	 * 添加 添加试题对应的内容
	 */
	public Integer addEvaluationExercise(EvaluationExercises evaluationExercises);
	
	/**
	 * 添加题目对应的选项 （ABCD……）
	 */
	public Integer addEvaluationExerciseDetail(EvaluationExercisesDetail evaluationExercisesDetail);
	
	/**
	 * 更新试题
	 */
	public String updateEvaluationTestQuestionsById(Map<String, Object> paramMap);
	
	/**
	 * 根据Id更新试题
	 */
	public String modifyEvaluationTestQuestionsById(Map<String, Object> paramMap);
	
	/**
	 * 删除评价模板
	 */
	public void modifyEvaluationTemplateStatus(Integer id);
	
	/**
	 * 根据paperId查询题目
	 */
	public List<EvaluationExercises> getEvaluationExercisesListByPaperId(Integer paperId);
	
	/**
	 * 根据Id查找模板
	 */
	public EvaluationTemplate getEvaluationTemplateById(Integer id);
	
	/**
	 * 根据Id 统计分数
	 */
	public boolean totalScorePaper(Integer id);
	
	/**
	 * 根据Id删除试题
	 */
	public String deletePaperBigQuestion(Integer id);
	
	/**
	 * 根据Id删除选项
	 */
	public String deleteEvaluationExerciseDetail(Integer id);
	
	/**
	 * 根据Id删除题目
	 */
	public String deleteEvaluationExercise(Integer id);
	
	/**
	 * 根据Id跟新html
	 */
	public String updateExercisesHtml(Map<String, Object> paramMap);
	
	/**
	 * 根据Id更新Integral
	 */
	public String updateExercisesDetailIntegral(Map<String, Object> paramMap);
	
	
	
}
