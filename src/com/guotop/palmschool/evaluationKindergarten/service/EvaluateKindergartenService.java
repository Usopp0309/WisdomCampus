package com.guotop.palmschool.evaluationKindergarten.service;

import java.util.List;

import com.guotop.palmschool.evaluationKindergarten.entity.EvaluateKindergarten;

/**
 * 幼儿园评价类接口
 * 
 * @author sheng
 * 
 */
public interface EvaluateKindergartenService
{
	
	/**
	 * 添加评论
	 * @param user
	 */
	public void addEvaluateKindergarten(EvaluateKindergarten evaluateKindergarten);
	
	/**
	 * 根据学生id获取该学生【最近】的评价
	 * @param studentId
	 * @return
	 */
	public EvaluateKindergarten loadEvaluateKindergartenByStudentId(Integer studentId);
	
	/**
	 * 根据学生id获取该学生所有评价
	 * @param studentId
	 * @return
	 */
	public List<EvaluateKindergarten> loadEvaluateKindergartenListByStudentId(Integer studentId);
	
	/**
	 * 根据id获取该学生评价的详情
	 * @param studentId
	 * @return
	 */
	public EvaluateKindergarten loadEvaluateKindergartenByEvaluateId(Integer id);

	EvaluateKindergarten loadEvaluateKindergartenByUserId(Integer id,String endDate);
	
}
