package com.guotop.palmschool.system.service;

import java.util.HashMap;
import java.util.List;

import com.guotop.palmschool.system.entity.InformationType;

/**
 * 信息提醒类型
 */
public interface InformationTypeService 
{
	
	/**
	 *  查找所有的信息提醒类型
	 */
	public List<InformationType> getAllInformationType();
	
	/**
	 *  查找parentId 为null 的所有的信息提醒类型
	 */
	public List<InformationType> getInformationType();
	
	/**
	 *  根据parentId查找的所有的信息提醒类型
	 */
	public List<InformationType> getInformationTypeByParentId(Integer parentId);
	
	/**
	 *  根据Id更新信息提醒类型
	 */
	public void updateInformationTypeById(HashMap<String, Object> paramMap);
	
	/**
	 *  根据informationType更新信息提醒类型
	 */
	public InformationType getInformationTypeByInformationType(Integer informationType);
}
