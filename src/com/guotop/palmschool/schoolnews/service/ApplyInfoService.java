package com.guotop.palmschool.schoolnews.service;

import java.util.HashMap;

import com.guotop.palmschool.schoolnews.entity.ApplyInfo;
import com.guotop.palmschool.schoolnews.entity.TakePartInActivity;
import com.guotop.palmschool.util.Pages;

/**
 * 报名申请业务类接口
 */
public interface ApplyInfoService
{

	/**
	 * 添加报名申请
	 * @param applyInfo
	 */
	void addApplyInfo(ApplyInfo applyInfo);
	
	/**
	 * 添加我要参加信息
	 * @param activity
	 */
	public void addTakePartInActivity(TakePartInActivity activity);

	/**
	 * 加载所有的报名申请信息
	 * @param currentPage
	 * @param map
	 * @return
	 */
	Pages getApplyInfoListInfo(int pageSize, int currentPage, HashMap<String, Object> map);
	
	/**
	 * 加载所有的活动参加信息
	 * @param currentPage
	 * @param map
	 * @return
	 */
	public Pages getTakePartInActivity(int pageSize, int currentPage, HashMap<String, Object> map);
	
	/**
	 * 更新状态 为查看
	 * @param id
	 */
	public void updateStatus(Integer id);
}
