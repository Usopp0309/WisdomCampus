package com.guotop.palmschool.schoolbus.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusAbnormal;
import com.guotop.palmschool.schoolbus.service.SchoolBusAbnormalService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 校车异常业务类实现类
 * 
 * @author zhou
 */
@Service("schoolBusAbnormalService")
public class SchoolBusAbnormalServiceImpl extends BaseService implements SchoolBusAbnormalService
{
	/**
	 * 根据条件查询校车记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 校车记录/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages loadSchoolBusAbnormalList(int pageSize, int page, Map<String, Object> paramMap, Integer roleId)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SchoolBusAbnormal> list = new ArrayList<SchoolBusAbnormal>();
		/**
		 * 新增权限划分
		 */
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (Cons.ROLE_SCHOOLADMIN.equals(roleId) || Cons.ROLE_HEADMASTER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalList", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalList", paramMap, offset, length);
		}

		/**
		 * 年级组长权限
		 */
		if (Cons.ROLE_GRADELEADER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListGradeLeader", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListGradeLeader", paramMap, offset, length);
		}

		/**
		 * 班主任权限
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListHeadTeacher", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListHeadTeacher", paramMap, offset, length);
		}

		/**
		 * 教师权限
		 */
		if (Cons.ROLE_NORMALTEACHER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListTeacher", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListTeacher", paramMap, offset, length);
		}

		/**
		 * 学生(家长)权限
		 */
		if (Cons.ROLE_STUDENT.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListStudent", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("SchoolBusAbnormal.selectSchoolBusAbnormalListStudent", paramMap, offset, length);
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
	 * 检查相关---begin
	 */
	/**
	 * 学生到点未上校车
	 * 
	 * @param dormitoryNotLeaveBeginTime
	 *            正常上校车起始时间
	 * @param dormitoryNotLeaveEndTime
	 *            正常上校车结束时间
	 * @return List<User> 到点未上校车的学生
	 */
	@SuppressWarnings("unchecked")
	public List<User> selectStudentNotOnBus(String SchoolBusNotOnBeginTime, String SchoolBusNotOnEndTime)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * 时间区间: > 今天(时间格式"yyyy-MM-dd") + 配置最晚归校车时间
		 */

		paramMap.put("SchoolBusNotLeaveBeginTime", formatter.format(new Date()) + " " + SchoolBusNotOnBeginTime);
		paramMap.put("SchoolBusNotLeaveEndTime", formatter.format(new Date()) + " " + SchoolBusNotOnEndTime);
		paramMap.put("status", Cons.INOUTTYPE_OUT);

		List<User> studentList = getBaseDao().selectListByObject("SchoolBus.selectStudentNotLeave", paramMap);
		return studentList;
	}

	/**
	 * 添加校车异常记录实体
	 * 
	 * @param check
	 *            待添加的考勤异常记录实体
	 */
	public void addSchoolBusAbnormal(SchoolBusAbnormal schoolBusAbnormal)
	{
		getBaseDao().addObject("SchoolBusAbnormal.addSchoolBusAbnormal", schoolBusAbnormal);
	}

	/**
	 * 查找进出记录(为了导出excel)
	 * 
	 * @param paramMap
	 *            参数map
	 * @param roleId
	 *            权限ID
	 */
	@SuppressWarnings("unchecked")
	public List<SchoolBusAbnormal> loadSchoolBusAbnormalListForExport(Map<String, Object> paramMap, Integer roleId)
	{

		/**
		 * 校长权限
		 */
		if (Cons.ROLE_HEADMASTER.equals(roleId))
		{
			return getBaseDao().selectListByObject("SchoolBusAbnormal.selectSchoolBusAbnormalList", paramMap);
		}

		/**
		 * 年级主任权限
		 */
		if (Cons.ROLE_GRADELEADER.equals(roleId))
		{
			return getBaseDao().selectListByObject("SchoolBusAbnormal.selectSchoolBusAbnormalListGradeLeader", paramMap);
		}

		/**
		 * 班主任权限
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			return getBaseDao().selectListByObject("SchoolBusAbnormal.selectSchoolBusAbnormalListHeadTeacher", paramMap);
		}

		/**
		 * 教师权限
		 */
		if (Cons.ROLE_NORMALTEACHER.equals(roleId))
		{
			return getBaseDao().selectListByObject("SchoolBusAbnormal.selectSchoolBusAbnormalListTeacher", paramMap);
		}

		/**
		 * 学生权限
		 */
		if (Cons.ROLE_STUDENT.equals(roleId))
		{
			return getBaseDao().selectListByObject("SchoolBusAbnormal.selectSchoolBusAbnormalListStudent", paramMap);
		}
		return null;
	}

}
