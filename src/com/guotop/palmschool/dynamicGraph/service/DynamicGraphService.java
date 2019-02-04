package com.guotop.palmschool.dynamicGraph.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.dynamicGraph.entity.DynamicGraph;


/**
 * 宿舍管理业务类接口
 */
public interface DynamicGraphService
{
	/**
	 * 添加动态图片
	 * @param dinamicGraph
	 */
	public Integer addDinamicGraph(DynamicGraph dynamicGraph);
	
	/**
	 * 加载所有的动态图
	 * @return
	 */
	public List<DynamicGraph> getAllGraphList();
	
	/**
	 * 根据状态加载所有的动态图
	 * @param status
	 * @return
	 */
	public List<DynamicGraph> getGraphListByStatus(Integer status);
	
	/**
	 * 根据id修改动态图状态
	 * @param graphId
	 */
	public void modifyStatus(Map<String,Object> paramMap);
	
	/**
	 * 修改动态图状态
	 * @param type
	 */
	public void updateDynamicGraph(Integer type);
	
	/**
	 * 根据id删除动态图
	 * @param graphId
	 */
	public void deleteGraphById(Integer graphId);
	
	/**
	 * 根据id加载动态图信息
	 * @param graphId
	 * @return
	 */
	public DynamicGraph getDynamicGraphById(Integer graphId);
	
	/**
	 * 根据id修改动态图信息
	 * @param graphId
	 * @return
	 */
	public void updateByGraphId(DynamicGraph dynamicGraph);

}
