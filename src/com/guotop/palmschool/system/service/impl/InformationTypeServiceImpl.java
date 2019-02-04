package com.guotop.palmschool.system.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.system.entity.InformationType;
import com.guotop.palmschool.system.service.InformationTypeService;

/**
 * 信息提醒类型
 */
@Service("informationTypeService")
public class InformationTypeServiceImpl extends BaseService implements InformationTypeService 
{
	
	/**
	 *  查找所有的信息提醒类型
	 */
	@SuppressWarnings("unchecked")
	public List<InformationType> getAllInformationType()
	{
		return (List<InformationType>)this.getBaseDao().selectListBySql("InformationType.getAllInformationType");
	}
	
	/**
	 *  查找parentId 为null 的所有的信息提醒类型
	 */
	@SuppressWarnings("unchecked")
	public List<InformationType> getInformationType()
	{
		return (List<InformationType>)this.getBaseDao().selectListBySql("InformationType.getInformationType");
	}
	
	/**
	 *  根据parentId查找的所有的信息提醒类型
	 */
	@SuppressWarnings("unchecked")
	public List<InformationType> getInformationTypeByParentId(Integer parentId)
	{
		return (List<InformationType>)this.getBaseDao().selectList("InformationType.getInformationTypeByParentId",parentId);
	}
	
	/**
	 *  根据Id更新信息提醒类型
	 */
	public void updateInformationTypeById(HashMap<String, Object> paramMap)
	{
		getBaseDao().updateObject("InformationType.updateInformationTypeById",paramMap);
	}
	
	/**
	 *  根据informationType更新信息提醒类型
	 */
	public InformationType getInformationTypeByInformationType(Integer informationType)
	{
		return (InformationType)getBaseDao().selectObject("InformationType.getInformationTypeByInformationType",informationType);
	}
	
}
