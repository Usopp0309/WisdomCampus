package com.guotop.palmschool.evaluationKindergarten.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.evaluationKindergarten.entity.EvaluateKindergarten;
import com.guotop.palmschool.evaluationKindergarten.service.EvaluateKindergartenService;
import com.guotop.palmschool.service.BaseService;

/**
 * 幼儿园评价类接口
 * 
 * @author sheng
 * 
 */
@Service("evaluateKindergartenService")
public class EvaluateKindergartenServiceImpl extends BaseService implements EvaluateKindergartenService
{
	@Override
	public void addEvaluateKindergarten(EvaluateKindergarten evaluateKindergarten)
	{
		getBaseDao().addObject("EvaluateKindergarten.addEvaluateKindergarten", evaluateKindergarten);
		
	}

	@Override
	public EvaluateKindergarten loadEvaluateKindergartenByStudentId(Integer studentId)
	{
		EvaluateKindergarten evaluateKindergarten = (EvaluateKindergarten) getBaseDao().selectObjectByObject("EvaluateKindergarten.loadEvaluateKindergartenByStudentId", studentId);
		return evaluateKindergarten;
	}
	/**
	 * 根据学生id获取该学生所有评价
	 * @param studentId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<EvaluateKindergarten> loadEvaluateKindergartenListByStudentId(Integer studentId)
	{
		return getBaseDao().selectListByObject("EvaluateKindergarten.loadEvaluateKindergartenListByStudentId", studentId);
	}

	/**
	 * 根据userid获取该学生评价的详情
	 * @param studentId
	 * @return
	 */
	@Override
	public EvaluateKindergarten loadEvaluateKindergartenByUserId(Integer id,String endDate)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("endDate", endDate);
		EvaluateKindergarten evaluateKindergarten = (EvaluateKindergarten) getBaseDao().selectObjectByObject("EvaluateKindergarten.loadEvaluateKindergartenByUserId", map);
		return evaluateKindergarten;
	}
	/**
	 * 根据id获取该学生评价的详情
	 * @param studentId
	 * @return
	 */
	@Override
	public EvaluateKindergarten loadEvaluateKindergartenByEvaluateId(Integer id)
	{
		EvaluateKindergarten evaluateKindergarten = (EvaluateKindergarten) getBaseDao().selectObjectByObject("EvaluateKindergarten.loadEvaluateKindergartenByEvaluateId", id);
		return evaluateKindergarten;
	}
	

}
