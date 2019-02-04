package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.entity.Agency;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.scheduler.entity.SchoolCountInfo;
import com.guotop.palmschool.service.AgencyService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

@Service("/agencyService")
public class AgencyServiceImpl extends BaseService implements AgencyService
{

	@SuppressWarnings("unchecked")
	@Override
	public List<Agency> getAgencyList()
	{
		// TODO Auto-generated method stub
		return getBaseDao().selectListBySql("Agency.getAgencyList");
	}

	/**
	 * 获取一个代理商对应的技术支持人员
	 * @return
	 * 
	 * add by syj 20151215
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> getSupportUserListByAgencyId(Integer agencyId)
	{
		return getBaseDao().selectListByObject("User.getSupportUserListByAgencyId", agencyId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pages<SchoolCountInfo> getSchoolListByUserId(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SchoolCountInfo> countList = new ArrayList<SchoolCountInfo>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("Agency.getSchoolListCountByUserId", paramMap);

		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		countList = this.getBaseDao().selectListByObject("Agency.getSchoolListByUserId", paramMap);
		if(!CollectionUtils.isEmpty(countList)){
			
		}
		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(countList);
		pages.init();
		return pages;
	}

	
}
