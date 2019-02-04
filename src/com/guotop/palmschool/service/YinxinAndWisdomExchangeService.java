package com.guotop.palmschool.service;

import java.util.Set;



/**
 * 亦信用户转为智慧校园服务费
 * @author shengyinjiang
 *
 */
public interface YinxinAndWisdomExchangeService
{
	/**
	 * 亦信用户转为智慧校园用户
	 * @param userId 
	 * @param realName 真实姓名
	 * @param code 学号/工号
	 * @param roleCode 角色
	 * @param studentId 当roleCode为家长的时候使用
	 * @param departmentId 当roleCode为教职工的时候使用
	 * @param clazzId 当roleCode为学生的时候使用
	 * @param cardCodeSet
	 * @param schoolId
	 */
	public void yixinToWisdom(Integer userId,String realName,String code,String roleCode,Integer studentId,Integer departmentId,Integer clazzId,Set<String> cardCodeSet, Long schoolId);
	
	/**
	 * 智慧校园用户转亦信用户
	 * @param user
	 * @param roleCode
	 */
	public void wisdomToYinxin(Integer userId,String roleCode, Long schoolId);
}
