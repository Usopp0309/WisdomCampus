package com.guotop.palmschool.meeting.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.meeting.entity.Meeting;
import com.guotop.palmschool.meeting.entity.MeetingInout;
import com.guotop.palmschool.meeting.entity.MeetingInoutWifi;
import com.guotop.palmschool.meeting.service.MeetingService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 会议安排业务类实现类
 * 
 * @author
 */
@Service("meetingService")
public class MeetingServiceImpl extends BaseService implements MeetingService
{
	@Resource
	private CommonService commonService;

	/**
	 * 添加会议安排实体
	 * 
	 * @param check
	 *            待添加的会议安排实体 20151208
	 */
	public Integer addMeeting(Meeting meeting)
	{
		return (Integer) getBaseDao().addObject("Meeting.addMeeting", meeting);
	}

	/**
	 * 添加手机签到进出记录
	 * @param miw
	 */
	public void addMeetingInoutWifi(MeetingInoutWifi miw){
		getBaseDao().addObject("Meeting.addMeetingInoutWifi", miw);
		
		
	}
	
	/**
	 * 修改会议安排实体
	 * 
	 * @param check
	 *            待修改的会议安排实体
	 */
	public void updatedMeeting(Meeting meeting)
	{

		getBaseDao().updateObject("Meeting.updateMeetingById", meeting);
	}

	/**
	 * 编辑会议
	 * 
	 * @param check
	 *            待编辑会议安排实体 20151208
	 */
	public void editMeeting(Meeting meeting)
	{
		getBaseDao().updateObject("Meeting.editMeetingById", meeting);
	}

	/**
	 * 获取最近的一条会议名记录
	 * @return
	 */
	@Override
	public Meeting getLatestMeeting(User user){
		if(commonService.hasAdminPermission(user)){
			return (Meeting) getBaseDao().selectObjectByObject("Meeting.getLatestMeeting",null);
		}else{
			Map<String, Object> parmMap = new HashMap<String, Object>();
			parmMap.put("userId", user.getUserId());
			return (Meeting) getBaseDao().selectObjectByObject("Meeting.getLatestMeetingByUserId",parmMap);
		}
	}
	
	@Override
	public Meeting getMeetingByName(User user,String name){
		Map<String, Object> parmMap = new HashMap<String, Object>();
		if(commonService.hasAdminPermission(user)){
			parmMap.put("name", name);
			return (Meeting) getBaseDao().selectObjectByObject("Meeting.getMeetingByName",parmMap);
		}else{
			parmMap.put("name", name);
			parmMap.put("userId", user.getUserId());
			return (Meeting) getBaseDao().selectObjectByObject("Meeting.getLatestMeetingByUserIdAndName",parmMap);
		}
	}
	
	/**
	 * 根据条件查询会议安排 /分页查询
	 * 
	 * @param paramMap
	 *            参数map
	 * @return 会议安排记录/分页 20151207
	 */
	@SuppressWarnings("unchecked")
	public Pages getMeetingByRole(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Meeting> list = new ArrayList<Meeting>();
		allRow = this.getBaseDao().getAllRowCountByCondition("Meeting.getMeetingList", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("Meeting.getMeetingList", paramMap, offset, length);

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
	 * 以会议id查询
	 */
	@SuppressWarnings("unchecked")
	public List<Meeting> selectMeetingByMeetingId(Integer id)
	{
		return  (List<Meeting>) this.getBaseDao().selectList("Meeting.selectMeetingListById", id);
	}

	public Meeting selectGradeById(Integer gradeId)
	{
		return (Meeting) this.getBaseDao().selectObject("Meeting.selectGradeById", gradeId);
	}

	public Meeting selectTeacherById(Integer teacherId)
	{

		return (Meeting) this.getBaseDao().selectObject("Meeting.selectTeacherById", teacherId);
	}

	/**
	 * 根据条件查询会议刷卡记录 /分页查询
	 * 
	 * @param paramMap
	 *            参数map
	 * @return 会议刷卡记录/分页 20151209
	 */
	@SuppressWarnings("unchecked")
	public Pages getMeetingInoutList(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<MeetingInout> list = new ArrayList<MeetingInout>();

		/**
		 * 校长或者学校管理员（全校所有人）
		 */
//		if (commonService.hasAdminPermission(user))
//		{
			//每个人都可以看到每个会议的所有刷卡记录
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Meeting.getMeetingInoutCountAsAdminPermission", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Meeting.getMeetingInoutListAsAdminPermission", paramMap);
//		}
//		/**
//		 * 其他人查看自己的或者自己所管理部门的所有人员
//		 */
//		else
//		{
//			List<Integer> departmentIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "meetingInoutManager", 1);
//			paramMap.put("departmentIdList", departmentIdList);
//			allRow = (Integer) this.getBaseDao().selectObjectByObject("Meeting.getMeetingInoutCountAsTeacherStaff", paramMap);
//			totalPage = Pages.countTotalPage(pageSize, allRow);
//			final int offset = Pages.countOffset(pageSize, page);
//			final int length = pageSize;
//			currentPage = Pages.countCurrentPage(page);
//			// 解决ibatis框架的分页问题
//			// 起始数据坐标
//			paramMap.put("startIndex", offset);
//			// 单页数据量
//			paramMap.put("length", length);
//			list = this.getBaseDao().selectListByObject("Meeting.getMeetingInoutListAsTeacherStaff", paramMap);
//		}

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
	 * 根据条件查询会议刷卡记录 /分页查询(APP)
	 * @param paramMap  参数map
	 * @return 会议安排/分页 20160217
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingInout> getMeetingInoutListAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<MeetingInout> list = new ArrayList<MeetingInout>();
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
//		if (commonService.hasAdminPermission(user))
//		{
			list = this.getBaseDao().selectListByObject("Meeting.getMeetingInoutListAsAdminPermission", paramMap);
//		}
		/**
		 * 其他人查看自己的或者自己所管理部门的所有人员
		 */
//		else
//		{
//			List<Integer> departmentIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "meetingInoutManager", 1);
//			paramMap.put("departmentIdList", departmentIdList);
//			list = this.getBaseDao().selectListByObject("Meeting.getMeetingInoutListAsTeacherStaff", paramMap);
//		}

		return list;
	}
	
	/**
	 * 根据条件查询会议刷卡记录 /分页查询(APP)
	 * @param paramMap  参数map
	 * @return 会议安排/分页 20160217
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingInout> getMeetingInoutListWifiAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<MeetingInout> list = new ArrayList<MeetingInout>();
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		// 解决ibatis框架的分页问题
		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("Meeting.getMeetingInoutWifiList", paramMap);
		return list;
	}
	
	/**
	 * 根据条件查询会议安排/分页查询（APP）
	 * @param paramMap 参数map
	 * @return 会议安排记录/分页 
	 */
	@SuppressWarnings("unchecked")
	public List<Meeting> getMeetingByRoleAPP(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<Meeting> list = new ArrayList<Meeting>();

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("Meeting.getMeetingListAPP", paramMap);
		return list;
	}

	@Override
	@SuppressWarnings("unchecked")
	public Pages getMeetingInoutWifiList(int pageSize, int page, Map<String, Object> paramMap) {
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<MeetingInoutWifi> list = new ArrayList<MeetingInoutWifi>();

		allRow = (Integer) this.getBaseDao().selectObjectByObject("Meeting.getMeetingInoutWifiCount", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("Meeting.getMeetingInoutWifiList", paramMap);

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage) {
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();

		return pages;
	}

	@Override
	public void deleteMeetingByMeetingId(Integer meetingId) {
		this.getBaseDao().deleteObject("MeetingDetail.deleteMeetingDetail", meetingId);
		this.getBaseDao().deleteObjectById("Meeting.deleteMeetingById", meetingId);
		
	}

}
