package com.guotop.palmschool.evaluation.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.evaluation.service.EvaluationTimeService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 评价时间业务类实现类
 */
@Service("evaluationTimeService")
@SuppressWarnings("unchecked")
public class EvaluationTimeServiceImpl extends BaseService implements EvaluationTimeService
{
	
	/**
	 * 根据条件查询评价时间设定List /分页查询
	 * @param paramMap 条件
	 * @return 评价时间记录/分页
	 */
	public Pages getEvaluationTimeList(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<EvaluationTime> list = new ArrayList<EvaluationTime>();

		allRow = this.getBaseDao().getAllRowCountByCondition("EvaluationTime.getEvaluationTimeList",paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("EvaluationTime.getEvaluationTimeList", paramMap, offset, length);
		
		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}
	
	/**
	 * 增加评价时间
	 * @return
	 */
	public Integer addEvaluationTime(EvaluationTime evaluationTime)
	{
		return (Integer)getBaseDao().addObject("EvaluationTime.addEvaluationTime", evaluationTime);
	}
	
	/**
	 * 修改评价时间
	 */
	public void updateEvaluationTime(EvaluationTime evaluationTime)
	{
		getBaseDao().updateObject("EvaluationTime.updateEvaluationTime", evaluationTime);
	}
	
	public Integer addEvaluationClazzModel(EvaluationClazzModel evaluationClazzModel)
	{
		return (Integer)getBaseDao().addObject("EvaluationTime.addEvaluationClazzModel", evaluationClazzModel);
	}
	
	public void deleteEvaluationClazzModelById(Integer id)
	{
		getBaseDao().deleteObjectById("EvaluationTime.deleteEvaluationClazzModelById", id);
	}
	
	/**
	 * 根据Id查找时间
	 * @param id
	 * @return
	 */
	public EvaluationTime getEvaluationTimeById(Integer id)
	{
		return (EvaluationTime)getBaseDao().selectObject("EvaluationTime.getEvaluationTimeById", id);
	}
	
	/**
	 * 根据Id 日期 查找时间
	 * @param id
	 * @return
	 */
	public List<EvaluationTime> getEvaluationTimeByIdAndDate(Map<String, Object> paramMap)
	{
		List<EvaluationTime> list = (List<EvaluationTime>)getBaseDao().selectListByObject("EvaluationTime.getEvaluationTimeByIdAndDate", paramMap);
		return list;
	}
	
	public List<EvaluationClazzModel> getEvaluationClazzByTimeId(Integer id)
	{
		return (List<EvaluationClazzModel>)getBaseDao().selectList("EvaluationTime.getEvaluationClazzByTimeId", id);
	}
	
}
