package com.guotop.palmschool.service;

import java.util.List;

import com.guotop.palmschool.entity.Groups;

public interface GroupsService
{
	public Integer addGroups(Groups groups);
	
	public void delGroupsBySchoolIdAndClzzId(Long schoolId,Integer clazzId);

	public void delGroupsBySchoolIdAndDepartmentId(Long schoolId,Integer clazzId);
	
	public List<Groups> getGroupsBySchoolIdAndDepartmentId(Long schoolId, Integer departmentId);
	
	public List<Groups> getGroupsBySchoolIdAndClazzId(Long schoolId, Integer clazzId);
	
	public Groups getLastlyGroups();
	
}
