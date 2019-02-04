package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.YktPlace;
import com.guotop.palmschool.util.Pages;



/**
 * 一卡通业务接口
 *
 */
public interface YktService 
{
	/**
	 * 加载一卡通总览列表
	 * @return
	 */
	public Pages  getYktTotalList(int pageSize, int page,Map<String, Object> paramMap , User user);
	
	/**
	 * 加载一卡通信息总览列表
	 * @return
	 */
	public Pages  getYktTotalInformationList(int pageSize, int page,Map<String, Object> paramMap , User user);
	
	
	/**
	 * 加载一卡通消费地点
	 * @return
	 */
	public List<YktPlace> getYktPlaceList();
}
	