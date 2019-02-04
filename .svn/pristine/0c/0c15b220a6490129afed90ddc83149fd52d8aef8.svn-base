package com.guotop.palmschool.check.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.check.service.AbnormalService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.AbnormalInformation;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 考勤异常记录业务类实现类
 * 
 * @author zhou
 */
@Service("abnormalService")
public class AbnormalServiceImpl extends BaseService implements AbnormalService
{
	@Resource
	private CommonService commonService;

	@Override
	public void addAbnormalInfo(AbnormalInformation abnormalInfo)
	{
		this.getBaseDao().addObject("AbnormalInformation.addAbnormalInfo", abnormalInfo);

	}

	/**
	 * 根据条件查询考勤异常记录 /分页查询
	 * 
	 * @param paramMap
	 *            参数map
	 * @param roleId
	 *            权限ID
	 * @return 考勤异常记录/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages getAbnormalList(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<AbnormalInformation> list = new ArrayList<AbnormalInformation>();
		String roleCode = (String) paramMap.get("roleCode");
		/**
		 * 系统管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("AbnormalInformation.getAbnormalInfo4Admin", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("AbnormalInformation.getAbnormalInfo4Admin", paramMap, offset, length);
		} else if (roleCode == null)// 有权限
		{
			List<Integer> classIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 0);
			List<Integer> departList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 1);
			if (!CollectionUtils.isEmpty(classIdList))
			{
				paramMap.put("classList", classIdList);
				paramMap.put("departList", departList);
				allRow = this.getBaseDao().getAllRowCountByCondition("AbnormalInformation.getAbnormalInfosByPriv", paramMap);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);
				list = this.getBaseDao().queryForPageByCondition("AbnormalInformation.getAbnormalInfosByPriv", paramMap, offset, length);
			}
		} else if (roleCode.equals("departManager"))// 部门管理员
		{
			List<Integer> departList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 1);
			if (!CollectionUtils.isEmpty(departList))
			{
				paramMap.put("departList", departList);
				allRow = this.getBaseDao().getAllRowCountByCondition("AbnormalInformation.getAbnormalInfos4DepartManager", paramMap);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);
				list = this.getBaseDao().queryForPageByCondition("AbnormalInformation.getAbnormalInfos4DepartManager", paramMap, offset, length);
			}
		} else if (roleCode.equals("classLeader"))// 班主任
		{
			List<Integer> classIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 0);
			if (!CollectionUtils.isEmpty(classIdList))
			{
				paramMap.put("classList", classIdList);
				allRow = this.getBaseDao().getAllRowCountByCondition("AbnormalInformation.getAbnormalInfos4ClassLeader", paramMap);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);
				list = this.getBaseDao().queryForPageByCondition("AbnormalInformation.getAbnormalInfos4ClassLeader", paramMap, offset, length);
			}
		} else
		// 查看自己的
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("AbnormalInformation.getAbnormalInfos4Self", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("AbnormalInformation.getAbnormalInfos4Self", paramMap, offset, length);
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
	 * 导出查询记录
	 */
	@SuppressWarnings("unchecked")
	public List<AbnormalInformation> getAbnormalListForExport(Map<String, Object> paramMap, User user)
	{
		List<AbnormalInformation> list = new ArrayList<AbnormalInformation>();
		String roleCode = (String) paramMap.get("roleCode");
		/**
		 * 系统管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfo4Admin", paramMap);
		} else if (roleCode == null)// 有权限
		{
			List<Integer> classIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 0);
			List<Integer> departList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 1);
			paramMap.put("classList", classIdList);
			paramMap.put("departList", departList);
			if (classIdList != null || departList != null)
			{
				list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfosByPriv", paramMap);
			}
			
		} else if (roleCode.equals("departManager"))// 部门管理员
		{
			List<Integer> departList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 1);
			paramMap.put("departList", departList);
			list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfos4DepartManager", paramMap);
		} else if (roleCode.equals("classLeader"))// 班主任
		{
			List<Integer> classIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 0);
			paramMap.put("classList", classIdList);
			list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfos4ClassLeader", paramMap);
		} else
		// 查看自己的
		{
			list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfos4Self", paramMap);
		}

		return list;
	}

	/**
	 * 根据条件查询异常记录信息 /分页查询
	 * @param paramMap  参数map
	 * @return 考勤异常记录/分页
	 */
	@SuppressWarnings("unchecked")
	public List<AbnormalInformation> getAbnormalListAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<AbnormalInformation> list = new ArrayList<AbnormalInformation>();
		String roleCode = (String) paramMap.get("roleCode");
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		/**
		 * 系统管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			
			list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfo4AdminAPP", paramMap);
			
		} else if (roleCode == null)// 有权限
		{
			List<Integer> classIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 0);
			List<Integer> departList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 1);
			if (!CollectionUtils.isEmpty(classIdList))
			{
				paramMap.put("classList", classIdList);
				paramMap.put("departList", departList);
				list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfosByPrivAPP", paramMap);
			}
			
		} else if (roleCode.equals("departManager"))// 部门管理员
		{
			List<Integer> departList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 1);
			if (!CollectionUtils.isEmpty(departList))
			{
				paramMap.put("departList", departList);
				list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfos4DepartManagerAPP", paramMap);
			}
			
		} else if (roleCode.equals("classLeader"))// 班主任
		{
			List<Integer> classIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "abnormal", 0);
			if (!CollectionUtils.isEmpty(classIdList))
			{
				paramMap.put("classList", classIdList);

				list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfos4ClassLeaderAPP", paramMap);
			}
			
		} else
		// 查看自己的
		{
			list = this.getBaseDao().selectListByObject("AbnormalInformation.getAbnormalInfos4SelfAPP", paramMap);
		}

		return list;
	}

}
