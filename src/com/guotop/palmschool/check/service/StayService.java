package com.guotop.palmschool.check.service;

import java.util.Map;

import com.guotop.palmschool.util.Pages;

/**
 * 在校时间业务类接口
 * @author admin
 */
public interface StayService 
{
	/**
	 * 根据条件查询在线时间记录 /分页查询
	 * @param paramMap 参数map
	 * @param roleId 权限ID
	 * @return 在线时间记录/分页
	 */
	public Pages loadStayList(int pageSize, int page, Map<String, Object> paramMap,
			Integer roleId);
}
