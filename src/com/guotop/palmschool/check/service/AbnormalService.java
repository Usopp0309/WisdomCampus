package com.guotop.palmschool.check.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.AbnormalInformation;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 考勤异常记录业务类接口
 * @author zhou
 *
 */
public interface AbnormalService 
{
	/**
	 * 新增异常信息
	 * @param abnormalInfo
	 */
	public void addAbnormalInfo(AbnormalInformation abnormalInfo);
	
	/**
	 * 根据条件查询考勤异常记录 /分页查询
	 * @param paramMap 参数map
	 * @param roleId 权限ID
	 * @return 考勤异常记录/分页
	 */
	public Pages getAbnormalList(int pageSize, int page, Map<String, Object> paramMap,
			User user);
	/*
	 * 导出记录
	 */
	public List<AbnormalInformation> getAbnormalListForExport(Map<String, Object> paramMap,  User user);
	
	/**
	 * 根据条件查询异常记录信息 /分页查询
	 * @param paramMap  参数map
	 * @return 考勤异常记录/分页
	 */
	public List<AbnormalInformation> getAbnormalListAPP(int pageSize, int page, Map<String, Object> paramMap, User user);
}
