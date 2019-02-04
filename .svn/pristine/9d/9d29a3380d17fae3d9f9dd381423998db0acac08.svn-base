package com.guotop.palmschool.evaluation.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.evaluation.entity.EvaluationExercises;
import com.guotop.palmschool.evaluation.entity.EvaluationExercisesDetail;
import com.guotop.palmschool.evaluation.entity.EvaluationTemplate;
import com.guotop.palmschool.evaluation.service.EvaluationTemplateService;
import com.guotop.palmschool.service.BaseService;

/**
 * 评价模板业务类实现类
 */
@Service("evaluationTemplateService")

@SuppressWarnings("unchecked")
public class EvaluationTemplateServiceImpl extends BaseService implements EvaluationTemplateService
{
	
	/**
	 * 根据条件查询评价模板设定 （根据parentId）
	 */
	public List<EvaluationTemplate> getEvaluationTemplateListByParentId(Integer parentId)
	{
		return  getBaseDao().selectList("EvaluationTemplate.getEvaluationTemplateListByParentId",parentId);
		
	}
	
	/**
	 * 根据paperId查询题目
	 */
	public List<EvaluationExercises> getEvaluationExercisesListByExFolderId(Integer exFolderId)
	{
		return  getBaseDao().selectList("EvaluationTemplate.getEvaluationExercisesListByExFolderId",exFolderId);
		
	}
	
	/**
	 * 根据paperId查询题目
	 */
	public List<EvaluationExercises> getEvaluationExercisesListByPaperId(Integer paperId)
	{
		List<EvaluationExercises> list = (List<EvaluationExercises>)getBaseDao().selectList("EvaluationTemplate.getEvaluationExercisesListByPaperId",paperId);
		
		for (int i=0;i<list.size();i++)
		{
			Integer exId = list.get(i).getId();
			List<EvaluationExercisesDetail> detailList = (List<EvaluationExercisesDetail>)getBaseDao().selectList("EvaluationTemplate.selectEvaluationExercisesDetailByExId",exId);
			list.get(i).setDetail(detailList);
		}
		
		return list;
		
	}
		
	/**
	 * 添加评价模板
	 */
	public void addEvaluationTemplate(EvaluationTemplate evaluationTemplate)
	{
		getBaseDao().addObject("EvaluationTemplate.addEvaluationTemplate", evaluationTemplate);
	}

	/**
	 * 禁用评价模板
	 */
	public void modifyEvaluationTemplateStatus(Integer id)
	{
		getBaseDao().updateObject("EvaluationTemplate.modifyEvaluationTemplateStatus", id);
	}

	/**
	 * 添加试题
	 */
	public Integer addEvaluationTestQuestions(EvaluationTemplate evaluationTemplate)
	{
		Integer id = getBaseDao().addObject("EvaluationTemplate.addEvaluationTestQuestions", evaluationTemplate);
		
		return id;
		
	}
	
	/**
	 *  添加试题对应的内容
	 */
	public Integer addEvaluationExercise(EvaluationExercises evaluationExercises)
	{
		Integer id = getBaseDao().addObject("EvaluationTemplate.addEvaluationExercise", evaluationExercises);
		
		return id;
		
	}
	
	/**
	 * 添加题目对应的选项 （ABCD……）
	 */
	public Integer addEvaluationExerciseDetail(EvaluationExercisesDetail evaluationExercisesDetail)
	{
		Integer id = getBaseDao().addObject("EvaluationTemplate.addEvaluationExerciseDetail", evaluationExercisesDetail);
		
		return id;
		
	}

	/**
	 * 根据Id更新试题
	 */
	public String updateEvaluationTestQuestionsById(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("EvaluationTemplate.updateEvaluationTestQuestionsById", paramMap);
		return "success";
	}
	
	/**
	 * 根据Id更新试题
	 */
	public String modifyEvaluationTestQuestionsById(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("EvaluationTemplate.modifyEvaluationTestQuestionsById", paramMap);
		return "success";
	}
	
	
	
	/**
	 * 根据Id查找模板
	 */
	public EvaluationTemplate getEvaluationTemplateById(Integer id)
	{
		return  (EvaluationTemplate)getBaseDao().selectObject("EvaluationTemplate.getEvaluationTemplateById", id);
		
	}

	/**
	 * 根据Id 统计查找分数
	 */
	public boolean totalScorePaper(Integer id)
	{
		try {
			
			getBaseDao().updateObject("EvaluationTemplate.totalScorePaper", id);
			
		} catch (RuntimeException re) {
			re.printStackTrace();
			return false;
		}
		
		return true;
	}

	/**
	 * 根据Id删除试题
	 */
	public String deletePaperBigQuestion(Integer id)
	{
		EvaluationTemplate evaluationTemplateget = getEvaluationTemplateById(id);
		
		if(evaluationTemplateget.getParentId()==0)
		{
			Integer parentId = id;
			List<EvaluationTemplate>  evaluationTemplateList = getEvaluationTemplateListByParentId(parentId);
			for(EvaluationTemplate evaluationTemplate : evaluationTemplateList)
			{
				destroyFolder(evaluationTemplate.getId());
			}
			getBaseDao().deleteObject("EvaluationTemplate.deletePaperByParentId", parentId);
			
		}else 
		{
			destroyFolder(id);
		}
		
		return "success";
	}
	
	public void destroyFolder(Integer id)
	{
		List<EvaluationExercises> evaluationExercisesList = getEvaluationExercisesListByExFolderId(id);
		
		for(EvaluationExercises evaluationExercises : evaluationExercisesList)
		{
			Integer exId = evaluationExercises.getId();
			getBaseDao().deleteObject("EvaluationTemplate.deleteEvaluationExercisesDetailByExId",exId);
		}
		
		getBaseDao().deleteObject("EvaluationTemplate.deleteEvaluationExercisesByExFolderId", id);
		
		getBaseDao().deleteObject("EvaluationTemplate.deletePaperBigQuestion", id);
		
	}
	
	/**
	 * 删除题目
	 */
	public String deleteEvaluationExercise(Integer id)
	{
		List<EvaluationExercises> evaluationExercisesList = getEvaluationExercisesListByExFolderId(id);
		
		for(EvaluationExercises evaluationExercises : evaluationExercisesList)
		{
			Integer exId = evaluationExercises.getId();
			getBaseDao().deleteObject("EvaluationTemplate.deleteEvaluationExercisesDetailByExId",exId);
		}
		
		getBaseDao().deleteObject("EvaluationTemplate.deleteEvaluationExercisesById", id);
		
		return "success";
		
	}
	
	/**
	 * 根据Id删除选项
	 */
	public String deleteEvaluationExerciseDetail(Integer id)
	{
		getBaseDao().deleteObject("EvaluationTemplate.deleteEvaluationExerciseDetail", id);
		return "success";
	}
	
	/**
	 * 根据Id更新html
	 */
	public String updateExercisesHtml(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("EvaluationTemplate.updateExercisesHtml", paramMap);
		return "success";
	}
	
	/**
	 * 根据Id更新Integral
	 */
	public String updateExercisesDetailIntegral(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("EvaluationTemplate.updateExercisesDetailIntegral", paramMap);
		return "success";
	}
	
}
