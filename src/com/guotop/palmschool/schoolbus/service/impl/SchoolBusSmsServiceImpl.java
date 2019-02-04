package com.guotop.palmschool.schoolbus.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSmsDetail;
import com.guotop.palmschool.schoolbus.service.SchoolBusSmsService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 校车信息业务类实现类
 * 
 * @author zhou
 */
@Service("schoolBusSmsService")
public class SchoolBusSmsServiceImpl extends BaseService implements SchoolBusSmsService
{
	@Resource
	public CommonService commonService;

	/**
	 * 根据条件查询校车记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @return 校车记录/分页 20151210
	 */
	@SuppressWarnings("unchecked")
	public Pages getSchoolBusSms(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SchoolBusSmsDetail> list = new ArrayList<SchoolBusSmsDetail>();

		String roleCode = (String) paramMap.get("roleCode");
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsAdminPermission", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsAdminPermission", paramMap, offset, length);
		}

		/**
		 * 家长看自己孩子的
		 */
		else if (roleCode != null && roleCode.equals("parent"))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsParent", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsParent", paramMap, offset, length);
		}

		/**
		 * 学生查看自己
		 */
		else if (roleCode != null && roleCode.equals("student"))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsStudent", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsStudent", paramMap, offset, length);
		}

		/**
		 * 班主任或者有查看此信息权限的人员
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "schoolBusSmsManager", 0);

			paramMap.put("clazzIdList", clazzIdList);

			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsTeachingStaff", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusSmsDetail.getSchoolBusSmsAsTeachingStaff", paramMap, offset, length);
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
	 * 根据条件查询校车记录 /分页查询(APP)
	 * 
	 * @param paramMap
	 *            条件
	 * @return 校车记录/分页
	 */
	@SuppressWarnings("unchecked")
	public List<SchoolBusSmsDetail> getSchoolBusSmsAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<SchoolBusSmsDetail> list = new ArrayList<SchoolBusSmsDetail>();

		String roleCode = (String) paramMap.get("roleCode");

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);

		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{

			list = this.getBaseDao().selectListByObject("SchoolBusSmsDetail.getSchoolBusSmsAsAdminPermissionAPP", paramMap);
		}

		/**
		 * 家长看自己孩子的
		 */
		else if (roleCode.equals("parent"))
		{
			list = this.getBaseDao().selectListByObject("SchoolBusSmsDetail.getSchoolBusSmsAsParentAPP", paramMap);
		}

		/**
		 * 学生查看自己
		 */
		else if (roleCode.equals("student"))
		{
			;
			list = this.getBaseDao().selectListByObject("SchoolBusSmsDetail.getSchoolBusSmsAsStudentAPP", paramMap);
		}

		/**
		 * 班主任或者有查看此信息权限的人员
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "schoolBusSmsManager", 0);

			paramMap.put("clazzIdList", clazzIdList);

			list = this.getBaseDao().selectListByObject("SchoolBusSmsDetail.getSchoolBusSmsAsTeachingStaffAPP", paramMap);
		}

		return list;
	}

}
