package com.guotop.palmschool.dynamicGraph.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.dynamicGraph.entity.DynamicGraph;
import com.guotop.palmschool.dynamicGraph.service.DynamicGraphService;
import com.guotop.palmschool.service.BaseService;

/**
 * 宿舍管理业务类实现类
 * 
 * @author zhou
 */
@Service("dinamicGraphService")
public class DynamicGraphServiceImpl extends BaseService implements DynamicGraphService
{
	/**
	 * 添加动态图片
	 * @param dinamicGraph
	 */
	public Integer addDinamicGraph(DynamicGraph dynamicGraph)
	{
		return (Integer) getBaseDao().addObject("DynamicGraph.addDynamicGraph", dynamicGraph);
	}
	
	/**
	 * 加载所有的动态图
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<DynamicGraph> getAllGraphList()
	{
		return (List<DynamicGraph>)getBaseDao().selectListBySql("DynamicGraph.getAllGraphList");
	}
	
	/**
	 * 根据状态加载所有的动态图
	 * @param status
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<DynamicGraph> getGraphListByStatus(Integer status)
	{
		return (List<DynamicGraph>)getBaseDao().selectList("DynamicGraph.getGraphListByStatus",status);
	}
	
	/**
	 * 根据id修改动态图状态
	 * @param graphId
	 */
	public void modifyStatus(Map<String,Object> paramMap)
	{
		getBaseDao().updateObject("DynamicGraph.modifyStatus", paramMap);
	}
	
	/**
	 * 修改动态图状态
	 * @param type
	 */
	public void updateDynamicGraph(Integer type)
	{
		getBaseDao().updateObject("DynamicGraph.updateDynamicGraph", type);
	}
	
	/**
	 * 根据id删除动态图
	 * @param graphId
	 */
	public void deleteGraphById(Integer graphId)
	{
		getBaseDao().deleteObjectById("DynamicGraph.deleteGraphById", graphId);
	}
	
	/**
	 * 根据id加载动态图信息
	 * @param graphId
	 * @return
	 */
	public DynamicGraph getDynamicGraphById(Integer graphId)
	{
		return (DynamicGraph)getBaseDao().selectObject("DynamicGraph.getDynamicGraphById", graphId);
	}
	
	/**
	 * 根据id修改动态图信息
	 * @param graphId
	 * @return
	 */
	public void updateByGraphId(DynamicGraph dynamicGraph)
	{
		getBaseDao().updateObject("DynamicGraph.updateByGraphId", dynamicGraph);
	}
}
