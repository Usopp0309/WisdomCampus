package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Agency;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.scheduler.entity.SchoolCountInfo;
import com.guotop.palmschool.util.Pages;

/**
 * 代理商服务接口
 * @author jfy
 * @date 2015年12月14日
 */
public interface AgencyService
{
	/**
	 * 获取代理商列表
	 * @return
	 */
	public List<Agency> getAgencyList();
	
	/**
	 * 获取一个代理商对应的技术支持人员
	 * @return
	 * 
	 * add by syj 20151215
	 */
	public List<User> getSupportUserListByAgencyId(Integer agencyId);
	/**
	 * 根据财务账号Id获取学校的基本统计信息
	 * @param userId
	 * @return
	 */
	public Pages<SchoolCountInfo> getSchoolListByUserId(int pageSize, int page, Map<String, Object> paramMap);
}
