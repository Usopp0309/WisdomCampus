package com.guotop.palmschool.schoolbus.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSmsDetail;
import com.guotop.palmschool.util.Pages;

/**
 * 校车信息业务类接口
 */
public interface SchoolBusSmsService 
{
	/**
	 * 根据条件查询校车记录 /分页查询
	 * @param paramMap 条件
	 * @return 进出校车记录/分页
	 * 20151210
	 */
   public Pages getSchoolBusSms(int pageSize, int page, Map<String, Object> paramMap, User user);
	
   /**
	 * 根据条件查询校车记录 /分页查询(APP)
	 * @param paramMap 条件
	 * @return 校车记录/分页
	 */
	public List<SchoolBusSmsDetail> getSchoolBusSmsAPP(int pageSize, int page, Map<String, Object> paramMap, User user);
}
