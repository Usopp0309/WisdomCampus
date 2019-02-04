package com.guotop.palmschool.schoolnews.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.schoolnews.entity.ApplyInfo;
import com.guotop.palmschool.schoolnews.entity.TakePartInActivity;
import com.guotop.palmschool.schoolnews.service.ApplyInfoService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 报名申请业务类实现类
 */
@Service("applyInfoService")
public class ApplyInfoServiceImpl extends BaseService implements ApplyInfoService
{

	@Override
	public void addApplyInfo(ApplyInfo applyInfo)
	{
		this.getBaseDao().addObject("ApplyInfo.addApplyInfo", applyInfo);
	}
	
	/**
	 * 添加我要参加信息
	 * @param activity
	 */
	public void addTakePartInActivity(TakePartInActivity activity)
	{
		this.getBaseDao().addObject("ApplyInfo.addTakePartInActivity", activity);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pages getApplyInfoListInfo(int pageSize, int page, HashMap<String, Object> map)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<ApplyInfo> list = new ArrayList<ApplyInfo>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("ApplyInfo.getApplyInfoListCount", map);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		map.put("startIndex", offset);
		// 单页数据量
		map.put("length", length);
		list = this.getBaseDao().selectListByObject("ApplyInfo.getApplyInfoList", map);
		Pages pages = new Pages();
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}
	
	/**
	 * 加载所有的活动参加信息
	 * @param currentPage
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages getTakePartInActivity(int pageSize, int page, HashMap<String, Object> map)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<ApplyInfo> list = new ArrayList<ApplyInfo>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("ApplyInfo.getTakePartInActivityCount", map);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		map.put("startIndex", offset);
		// 单页数据量
		map.put("length", length);
		list = this.getBaseDao().selectListByObject("ApplyInfo.getTakePartInActivityList", map);
		Pages pages = new Pages();
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}
	
	/**
	 * 更新状态 为查看
	 * @param id
	 */
	public void updateStatus(Integer id)
	{
		getBaseDao().updateObject("ApplyInfo.updateStatus", id);
	}
}
