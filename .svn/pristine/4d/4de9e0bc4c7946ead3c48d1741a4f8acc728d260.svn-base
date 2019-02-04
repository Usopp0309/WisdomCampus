package com.guotop.palmschool.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.Groupmember;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.GroupmemberService;

@Service("groupmemberService")
public class GroupmemberServiceImpl extends BaseService implements GroupmemberService
{

	@Override
	public void addGroupmember(Groupmember groupmember)
	{
		getBaseDao().addObject("Groupmember.addGroupmember", groupmember);
	}

	@Override
	public Groupmember getByGroupIdAndUserId(Integer groupId, Integer userId)
	{
		Map<String, Object> parmMap = new HashMap<String, Object>();
		parmMap.put("groupId", groupId);
		parmMap.put("userId", userId);
		Groupmember gm = (Groupmember) getBaseDao().selectObjectByObject("Groupmember.getByGroupIdAndUserId", parmMap);
		return gm;
	}

}
