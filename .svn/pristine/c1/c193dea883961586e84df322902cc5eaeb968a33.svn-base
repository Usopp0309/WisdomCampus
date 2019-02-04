package com.guotop.palmschool.service.impl;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.YktEmployee;
import com.guotop.palmschool.entity.YktPlace;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.YktService;
import com.guotop.palmschool.util.Pages;

/**
 * 一卡通业务类实现类
 *
 */
@Service("yktService")
public class YktServiceImpl extends BaseService implements YktService
{
	@Resource
	private CommonService commonService;
	/**
	 * 加载一卡通总览列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages  getYktTotalList(int pageSize, int page,Map<String, Object> paramMap , User user)
	{
		
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<YktEmployee> list = new ArrayList<YktEmployee>();
		
		String roleCode = (String)paramMap.get("roleCode");
		
		/**
		 * 校长或者学校管理员（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject(
					"Ykt.getYktTotalCountAsAdminPermission", paramMap);
			
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject( "Ykt.getYktTotalListAsAdminPermission", paramMap);
			
		}
		else if(roleCode.equals("parent"))
		{ 
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Ykt.getYktTotalCountAsParent",paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
			
			list = this.getBaseDao().selectListByObject( "Ykt.getYktTotalListAsParent", paramMap);
		}
		else
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Ykt.getYktTotalCountAsSelf",paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
			
			list = this.getBaseDao().selectListByObject( "Ykt.getYktTotalListAsSelf", paramMap);
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
		pages.setList(list);
		pages.init();
		return pages;
	}
	
	/**
	 * 加载一卡通信息总览列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages  getYktTotalInformationList(int pageSize, int page,Map<String, Object> paramMap , User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<YktEmployee> list = new ArrayList<YktEmployee>();
		String roleCode = (String)paramMap.get("roleCode");
		
		/**
		 * 校长或者学校管理员（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject(
					"Ykt.getYktTotalInformationCountAsAdminPermission", paramMap);
			
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject( "Ykt.getYktTotalInformationListAsAdminPermission", paramMap);
			
		}
		else if(roleCode.equals("parent"))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Ykt.getYktTotalInformationCountAsParent",paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
			
			list = this.getBaseDao().selectListByObject( "Ykt.getYktTotalInformationListAsParent", paramMap);
		}
		else
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Ykt.getYktTotalInformationCountAsSelf",paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			//解决ibatis框架的分页问题
			//起始数据坐标
			paramMap.put("startIndex", offset);
			//单页数据量
			paramMap.put("length", length);
			
			list = this.getBaseDao().selectListByObject( "Ykt.getYktTotalInformationListAsSelf", paramMap);
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
		pages.setList(list);
		pages.init();
		return pages;
	}
	
	
	/**
	 * 加载一卡通消费地点
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<YktPlace> getYktPlaceList()
	{
		return (List<YktPlace>) getBaseDao().selectListBySql("Ykt.getAllYktPlace");
	}
}
