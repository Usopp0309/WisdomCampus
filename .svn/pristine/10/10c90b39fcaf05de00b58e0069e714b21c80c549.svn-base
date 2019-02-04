package com.guotop.palmschool.replacerecharge.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;


/**
 * 代充短信套餐业务类
 */
public interface ReplaceRechargeService 
{
	/**
	 * 根据角色 和userId 查询对应班级的学生和家长信息（班主任、家长）
	 * @param userId
	 * @param roleCode
	 * @return
	 */
	public List<User> getStudentListByParam(Map<String, Object> paramMap,String permissionCode);
	
	/**
	 * 手机端获取代充学生list
	 * @param paramMap
	 * @return
	 */
	public List<User> getStudentListForApp(Map<String,Object> paramMap);
	
}
