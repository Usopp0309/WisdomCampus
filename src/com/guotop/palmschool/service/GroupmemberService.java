package com.guotop.palmschool.service;

import com.guotop.palmschool.entity.Groupmember;


public interface GroupmemberService
{
	/**
	 * 添加群组人员
	 * @param groupmember
	 */
	public void addGroupmember(Groupmember groupmember);
	
	/**
	 * 根据群Id和userId查出在群组中信息
	 * @param groupId
	 * @param userId
	 * @return
	 */
	public Groupmember getByGroupIdAndUserId(Integer groupId, Integer userId);
}
