package com.guotop.palmschool.check.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.check.entity.Stay;
import com.guotop.palmschool.check.service.StayService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 在校时间业务类实现类
 * @author zhou
 */
@Service("stayService")
public class StayServiceImpl extends BaseService implements StayService
{
	/**
	 * 根据条件查询在线时间记录 /分页查询
	 * @param paramMap 参数map
	 * @param roleId 权限ID
	 * @return 在线时间记录/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages loadStayList(int pageSize, int page, Map<String, Object> paramMap,
			Integer roleId)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Stay> list = new ArrayList<Stay>();
		/**
		 * 新增权限划分
		 */
		/**
		 * 系统管理员
		 */
		if (Cons.ROLE_ADMIN.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Stay.selectStayListAsHeadMaster", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition(
					"Stay.selectStayListAsHeadMaster", paramMap, offset, length);
		}
		
		/**
		 * 学校管理员
		 */
		if (Cons.ROLE_SCHOOLADMIN.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Stay.selectStayListAsHeadMaster", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition(
					"Stay.selectStayListAsHeadMaster", paramMap, offset, length);
		}
		
		/**
		 * 校长权限
		 */
		if (Cons.ROLE_HEADMASTER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Stay.selectStayListAsHeadMaster", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition(
					"Stay.selectStayListAsHeadMaster", paramMap, offset, length);
		}
		
		/**
		 * 年级主任权限
		 */
		if (Cons.ROLE_GRADELEADER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Stay.selectStayListAsGradeLeader", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition(
					"Stay.selectStayListAsGradeLeader", paramMap, offset, length);
		}
		
		/**
		 * 班主任权限
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Stay.selectStayListAsHeadTeacher", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition(
					"Stay.selectStayListAsHeadTeacher", paramMap, offset, length);
		}
		
		/**
		 * 教师权限
		 */
		if (Cons.ROLE_NORMALTEACHER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Stay.selectStayListAsStudent",paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition(
					"Stay.selectStayListAsStudent", paramMap, offset, length);
		}
		
		/**
		 * 学生权限
		 */
		if (Cons.ROLE_STUDENT.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition(
					"Stay.selectStayListAsStudent",paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition(
					"Stay.selectStayListAsStudent", paramMap, offset, length);
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
}
