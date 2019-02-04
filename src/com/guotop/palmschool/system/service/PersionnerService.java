package com.guotop.palmschool.system.service;

import java.util.HashMap;
import java.util.List;

import com.guotop.palmschool.entity.Agency;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 代理商及技术支持人员管理
 * @author jfy
 * @date 2015年12月14日
 */
public interface PersionnerService
{
	/**
	 * 根据条件获取代理商列表
	 * @param map
	 * @return
	 */
	public List<Agency> getAgencyList(HashMap<String, Object> map);
	/**
	 * 根据代理商ID获取代理商绑定学校列表
	 * @param agencyId
	 * @return
	 */
	public List<School> getSchoolListByAgencyId(Integer agencyId);
	/**
	 * 添加代理商
	 * @param user
	 * @param agency
	 */
	
	public void addAgency(User user, Agency agency);
	/**
	 * 修改代理商信息
	 * @param agency
	 */
	public void modifyAgency(Agency agency);
	/**
	 * 获取技术支持列表
	 * @param map
	 * @return
	 */
	public List<Agency> getSupportList(HashMap<String, Object> map);
	/**
	 * 添加技术支持人员
	 * @param user
	 * @param agency
	 */
	public void addSupport(User user, Agency agency);
	/**
	 * 修改技术支持人员信息
	 * @param user
	 */
	public void modifySupport(User user);
	/**
	 * 获取财务人员列表
	 * @param map
	 * @return
	 */
	public List<Agency> getAccountantList(HashMap<String, Object> map);
	
	/**
	 * 根据不同的status获取对应的人员列表
	 * @param page
	 * @param pageSize
	 * @param status
	 * @param condition
	 * @return
	 */
	public Pages getPersonnerList(int page,int pageSize,String status,String condition);
}