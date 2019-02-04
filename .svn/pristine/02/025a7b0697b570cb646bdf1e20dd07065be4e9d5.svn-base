package com.guotop.palmschool.dormitory.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.dormitory.entity.DormitoryAbnormal;
import com.guotop.palmschool.dormitory.entity.InoutDormitory;
import com.guotop.palmschool.dormitory.service.DormitoryService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 宿舍管理业务类实现类
 * 
 * @author zhou
 */
@Service("dormitoryService")
public class DormitoryServiceImpl extends BaseService implements DormitoryService
{
	@Resource
	private CommonService commonService;

	/**
	 * 根据条件查询进出宿舍记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出宿舍记录/分页 20151204
	 */
	@SuppressWarnings("unchecked")
	public Pages getDormitoryInoutList(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();

		String roleCode = (String) paramMap.get("roleCode");

		/**
		 * 校长或者学校管理员（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Dormitory.getDormitoryInoutCount", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutList", paramMap);

		}
		/**
		 * 家长 （自己孩子的记录）
		 */
		else if (roleCode.equals("parent"))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.getDormitoryInoutCountAsParent", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutListAsParent", paramMap);
		}
		/**
		 * 学生 （自己的记录）
		 */
		else if (roleCode.equals("student"))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.getDormitoryInoutCountAsStudent", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutListAsStudent", paramMap);
		}
		/**
		 * 教职工（ 教师，部门管理员，职工，班主任根据权限来判断能查到的信息）
		 */
		else
		{

			List<Integer> departmentIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryInoutManager", 1);

			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryInoutManager", 0);

			paramMap.put("departmentIdList", departmentIdList);
			paramMap.put("clazzIdList", clazzIdList);
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.getDormitoryInoutCountAsTeachingStaff", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutListAsTeachingStaff", paramMap);
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
	 * 学生到点未出宿舍(住校生)
	 * 
	 * @param dormitoryNotLeaveBeginTime
	 *            正常回宿舍起始时间
	 * @param dormitoryNotLeaveEndTime
	 *            正常回宿舍结束时间
	 * @return List<User> 到点未出宿舍的学生
	 */
	@SuppressWarnings("unchecked")
	public List<User> selectStudentNotLeave(String dormitoryNotLeaveBeginTime, String dormitoryNotLeaveEndTime)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * 时间区间: > 今天(时间格式"yyyy-MM-dd") + 配置最晚归宿舍时间
		 */

		paramMap.put("dormitoryNotLeaveBeginTime", formatter.format(new Date()) + " " + dormitoryNotLeaveBeginTime);
		paramMap.put("dormitoryNotLeaveEndTime", formatter.format(new Date()) + " " + dormitoryNotLeaveEndTime);
		paramMap.put("status", Cons.INOUTTYPE_OUT);

		List<User> studentList = getBaseDao().selectListByObject("Dormitory.selectStudentNotLeave", paramMap);
		return studentList;
	}

	/**
	 * 学生到点未进宿舍(住校生)
	 * 
	 * @param dormitoryNotEnterBeginTime
	 *            正常回宿舍起始时间
	 * @param dormitoryNotEnterEndTime
	 *            正常回宿舍结束时间
	 * @return List<User> 到点未进宿舍的学生
	 */
	@SuppressWarnings("unchecked")
	public List<User> selectStudentNotEnter(String dormitoryNotEnterBeginTime, String dormitoryNotEnterEndTime)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * 时间区间: > 今天(时间格式"yyyy-MM-dd") + 配置最晚归宿舍时间
		 */

		paramMap.put("dormitoryNotEnterBeginTime", formatter.format(new Date()) + " " + dormitoryNotEnterBeginTime);
		paramMap.put("dormitoryNotEnterEndTime", formatter.format(new Date()) + " " + dormitoryNotEnterEndTime);
		paramMap.put("status", Cons.INOUTTYPE_IN);

		List<User> studentList = getBaseDao().selectListByObject("Dormitory.selectStudentNotEnter", paramMap);
		return studentList;
	}

	/**
	 * 添加宿舍考勤异常详细实体
	 * 
	 * @param dormitoryAbnormal
	 *            待添加的宿舍考勤异常实体
	 */
	public void addDormitoryAbnormalDetail(DormitoryAbnormal dormitoryAbnormal)
	{
		getBaseDao().addObject("Dormitory.addDormitoryAbnormalDetail", dormitoryAbnormal);
	}

	/**
	 * 添加宿舍考勤异常实体
	 * 
	 * @param dormitoryAbnormal
	 *            待添加的宿舍考勤异常实体
	 */
	public void addDormitoryAbnormal(DormitoryAbnormal dormitoryAbnormal)
	{
		getBaseDao().addObject("Dormitory.addDormitoryAbnormal", dormitoryAbnormal);
	}

	/**
	 * 检查相关---end
	 */

	/**
	 * 加载宿舍异常详细信息
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 宿舍异常详细信息
	 */
	@SuppressWarnings("unchecked")
	public List<DormitoryAbnormal> loadDetailData(Map<String, Object> paramMap, String roleCode)
	{
		List<DormitoryAbnormal> dormitoryAbnormalList = new ArrayList<DormitoryAbnormal>();

		/**
		 * 新增权限划分
		 */
		/**
		 * 班主任
		 */
		if ("classLeader".equals(roleCode))
		{
			dormitoryAbnormalList = getBaseDao().selectListByObject("Dormitory.selectDetailDataAsHeadTeacher", paramMap);
		} else
		{
			dormitoryAbnormalList = getBaseDao().selectListByObject("Dormitory.selectDetailDataAsHeadMaster", paramMap);
		}

		return dormitoryAbnormalList;
	}

	@SuppressWarnings("unchecked")
	public Pages loadDormitorAbnormalList(int pageSize, int page, Map<String, Object> paramMap, Integer roleId)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		/**
		 * 新增权限划分
		 */
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (Cons.ROLE_SCHOOLADMIN.equals(roleId) || Cons.ROLE_HEADMASTER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.selectDormitoryAbnormalInoutList", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("Dormitory.selectDormitoryAbnormalInoutList", paramMap, offset, length);
		}

		/**
		 * 年级组长权限
		 */
		if (Cons.ROLE_GRADELEADER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.selectDormitoryAbnormalInoutListAsGradeLeader", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("Dormitory.selectDormitoryAbnormalInoutListAsGradeLeader", paramMap, offset, length);
		}

		/**
		 * 班主任权限
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.selectDormitoryAbnormalInoutListAsHeadTeacher", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("Dormitory.selectDormitoryAbnormalInoutListAsHeadTeacher", paramMap, offset, length);
		}

		/**
		 * 教师权限
		 */
		if (Cons.ROLE_NORMALTEACHER.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.selectDormitoryAbnormalInoutListAsTeaAndStu", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("Dormitory.selectDormitoryAbnormalInoutListAsTeaAndStu", paramMap, offset, length);
		}

		/**
		 * 学生权限
		 */
		if (Cons.ROLE_STUDENT.equals(roleId))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Dormitory.selectDormitoryAbnormalInoutListAsTeaAndStu", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("Dormitory.selectDormitoryAbnormalInoutListAsTeaAndStu", paramMap, offset, length);
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

	public InoutDormitory selectInoutDormitoryByUserId(Map<String, Object> paramMap)
	{

		return (InoutDormitory) getBaseDao().selectObjectByObject("Dormitory.selectInoutDormitoryByUserId", paramMap);
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
	public List<InoutDormitory> loadInoutDormitoryListForExport(Map<String, Object> paramMap, Integer roleId)
	{

		/**
		 * 校长权限
		 */
		if (Cons.ROLE_HEADMASTER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryInoutList", paramMap);
		}

		/**
		 * 年级主任权限
		 */
		if (Cons.ROLE_GRADELEADER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryInoutListAsGradeLeader", paramMap);
		}

		/**
		 * 班主任权限
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryInoutListAsHeadTeacher", paramMap);
		}

		/**
		 * 教师权限
		 */
		if (Cons.ROLE_NORMALTEACHER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryInoutListAsTeaAndStu", paramMap);
		}

		/**
		 * 学生权限
		 */
		if (Cons.ROLE_STUDENT.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryInoutListAsTeaAndStu", paramMap);
		}
		return null;
	}

	/**
	 * 查找进出异常记录(为了导出excel)
	 * 
	 * @param paramMap
	 *            参数map
	 * @param roleId
	 *            权限ID
	 */
	@SuppressWarnings("unchecked")
	public List<InoutDormitory> loadDormitorAbnormalListForExport(Map<String, Object> paramMap, Integer roleId)
	{

		/**
		 * 校长权限
		 */
		if (Cons.ROLE_HEADMASTER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryAbnormalInoutList", paramMap);
		}

		/**
		 * 年级主任权限
		 */
		if (Cons.ROLE_GRADELEADER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryAbnormalInoutListAsGradeLeader", paramMap);
		}

		/**
		 * 班主任权限
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryAbnormalInoutListAsHeadTeacher", paramMap);
		}

		/**
		 * 教师权限
		 */
		if (Cons.ROLE_NORMALTEACHER.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryAbnormalInoutListAsTeaAndStu", paramMap);
		}

		/**
		 * 学生权限
		 */
		if (Cons.ROLE_STUDENT.equals(roleId))
		{
			return getBaseDao().selectListByObject("Dormitory.selectDormitoryAbnormalInoutListAsTeaAndStu", paramMap);
		}
		return null;
	}

	/**
	 * 进宿舍未刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public Pages getInNoSwingCard(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer)this.getBaseDao().selectObjectByObject("Dormitory.getInNoSwingCardAsAdminPermissionCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			list = this.getBaseDao().selectListByObject("Dormitory.getInNoSwingCardAsAdminPermission", paramMap);
		}
		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);
			
			allRow = (Integer)this.getBaseDao().selectObjectByObject("Dormitory.getInNoSwingCardAsTeacherCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Dormitory.getInNoSwingCardAsTeacher", paramMap);
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
	 * 进宿舍已刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public Pages getInSwingCard(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer)this.getBaseDao().selectObjectByObject("Dormitory.getInSwingCardAsAdminPermissionCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			list = this.getBaseDao().selectListByObject("Dormitory.getInSwingCardAsAdminPermission", paramMap);
		}

		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);
			
			allRow = (Integer)this.getBaseDao().selectObjectByObject("Dormitory.getInSwingCardTeacherCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Dormitory.getInSwingCardTeacher", paramMap);
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
	 * 出宿舍未刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public Pages getOutNoSwingCard(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Dormitory.getOutNoSwingCardAsAdminPermissionCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().queryForPageByCondition("Dormitory.getOutNoSwingCardAsAdminPermission", paramMap, offset, length);
		}

		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{
			
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);
			
			allRow = (Integer)this.getBaseDao().selectObjectByObject("Dormitory.getOutNoSwingCardAsTeacherCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Dormitory.getOutNoSwingCardAsTeacher", paramMap);
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
	 * 出宿舍已刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public Pages getOutSwingCard(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);

		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer)this.getBaseDao().selectObjectByObject("Dormitory.getOutSwingCardAsAdminPermissionCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Dormitory.getOutSwingCardAsAdminPermission", paramMap);
		}

		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);
			allRow = (Integer)this.getBaseDao().selectObjectByObject("Dormitory.getOutSwingCardTeacherCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Dormitory.getOutSwingCardTeacher", paramMap);
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
	 * 获取宿舍进出记录List（APP）
	 */
	@SuppressWarnings("unchecked")
	public List<InoutDormitory> getDormitoryInoutListApp(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();

		String roleCode = (String) paramMap.get("roleCode");

		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		/**
		 * 校长或者学校管理员（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{
			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutList", paramMap);
		}
		/**
		 * 家长 （自己孩子的记录）
		 */
		else if (roleCode.equals("parent"))
		{
			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutListAsParent", paramMap);
		}
		/**
		 * 学生 （自己的记录）
		 */
		else if (roleCode.equals("student"))
		{

			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutListAsStudent", paramMap);
		}
		/**
		 * 教职工（ 教师，部门管理员，职工，班主任根据权限来判断能查到的信息）
		 */
		else
		{

			List<Integer> departmentIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryInoutManager", 1);

			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryInoutManager", 0);

			paramMap.put("departmentIdList", departmentIdList);
			paramMap.put("clazzIdList", clazzIdList);

			list = this.getBaseDao().selectListByObject("Dormitory.getDormitoryInoutListAsTeachingStaff", paramMap);
		}

		return list;
	}
	
	
	/**
	 * 进宿舍未刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public List<InoutDormitory> getInNoSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{

			
			list = this.getBaseDao().selectListByObject("Dormitory.getInNoSwingCardAsAdminPermission", paramMap);
		}
		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);

			list = this.getBaseDao().selectListByObject("Dormitory.getInNoSwingCardAsTeacher", paramMap );
		}

		return list;
	}

	/**
	 * 进宿舍已刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public List<InoutDormitory> getInSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{

			list = this.getBaseDao().selectListByObject("Dormitory.getInSwingCardAsAdminPermission", paramMap);
		}

		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);

			list = this.getBaseDao().selectListByObject("Dormitory.getInSwingCardTeacher", paramMap);
		}

		return list;
	}

	/**
	 * 出宿舍未刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public List<InoutDormitory> getOutNoSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{

			list = this.getBaseDao().selectListByObject("Dormitory.getOutNoSwingCardAsAdminPermission", paramMap);
		}

		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{

			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);
			
			list = this.getBaseDao().selectListByObject("Dormitory.getOutNoSwingCardAsTeacher", paramMap);
		}

		return list;
	}

	/**
	 * 出宿舍已刷卡 20151207
	 */
	@SuppressWarnings("unchecked")
	public List<InoutDormitory> getOutSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<InoutDormitory> list = new ArrayList<InoutDormitory>();

		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (commonService.hasAdminPermission(user))
		{

			list = this.getBaseDao().selectListByObject("Dormitory.getOutSwingCardAsAdminPermission", paramMap);
		}

		/**
		 * 班主任或者有宿舍异常管理权限的教职工
		 */
		else
		{
			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "dormitoryAbnormalManager", 0);

			paramMap.put("clazzIdList", clazzIdList);

			list = this.getBaseDao().selectListByObject("Dormitory.getOutSwingCardTeacher", paramMap);
		}
		return list;
	}

}
