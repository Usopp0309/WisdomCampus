package com.guotop.palmschool.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.Groups;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.GroupsService;

@Service("groupsService")
public class GroupsServiceImpl extends BaseService implements GroupsService
{

	@Override
	public Integer addGroups(Groups groups)
	{
		return (Integer) getBaseDao().addObject("Groups.addGroups", groups);
	}

	@Override
	public void delGroupsBySchoolIdAndClzzId(Long schoolId, Integer clazzId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("schoolId", schoolId);
		paramMap.put("clazzId", clazzId);
		getBaseDao().deleteObject("Groups.delGroupsBySchoolIdAndClzzId", paramMap);
		
	}
	@Override
	public void delGroupsBySchoolIdAndDepartmentId(Long schoolId, Integer departmentId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("schoolId", schoolId);
		paramMap.put("departmentId", departmentId);
		getBaseDao().deleteObject("Groups.delGroupsBySchoolIdAndDepartmentId", paramMap);
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Groups> getGroupsBySchoolIdAndDepartmentId(Long schoolId, Integer departmentId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("schoolId", schoolId);
		paramMap.put("departmentId", departmentId);
		return getBaseDao().selectListByObject("Groups.getGroupsBySchoolIdAndDepartmentId", paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Groups> getGroupsBySchoolIdAndClazzId(Long schoolId, Integer clazzId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("schoolId", schoolId);
		paramMap.put("clazzId", clazzId);
		return getBaseDao().selectListByObject("Groups.getGroupsBySchoolIdAndClazzId", paramMap);
	}

	@Override
	public Groups getLastlyGroups()
	{
		return (Groups) getBaseDao().selectObjectByObject("Groups.getLastlyGroups", null);
	}


}
