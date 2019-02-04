package com.guotop.palmschool.service;

import java.util.HashMap;
import java.util.List;

import com.guotop.palmschool.entity.MorningCheck;
import com.guotop.palmschool.util.Pages;

/**
 * 晨检服务接口
 * @author jfy
 * @date 2016年1月30日
 */
public interface MorningCheckService
{
	/**
	 * 添加晨检信息
	 * @param morningChek
	 */
	public void addMorningCheck(MorningCheck morningCheck);
	/**
	 * 查找晨检记录
	 * @param pageSize
	 * @param page
	 * @param param
	 * @return
	 */
	public Pages getMorningCheckList(int pageSize, Integer page ,HashMap<String, Object> param);
	/**
	 * 根据ID获取晨检详情
	 * @param id
	 * @return
	 */
	public MorningCheck getDetailInfoById(int id);
	List<MorningCheck> getDetailInfoByUserId(HashMap<String, Object> param);
}
