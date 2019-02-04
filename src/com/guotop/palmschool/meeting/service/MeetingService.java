package com.guotop.palmschool.meeting.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.meeting.entity.Meeting;
import com.guotop.palmschool.meeting.entity.MeetingInout;
import com.guotop.palmschool.meeting.entity.MeetingInoutWifi;
import com.guotop.palmschool.util.Pages;

/**
 * 会议安排业务类接口
 * @author zhou
 *
 */
public interface MeetingService 
{
	/**
	 * 添加会议安排实体
	 * @param check 待添加的会议安排实体
	 * 20151208
	 */
	public Integer addMeeting(Meeting meeting);
	
	/**
	 * 添加手动签到进出记录
	 * @param miw
	 */
	public void addMeetingInoutWifi(MeetingInoutWifi miw);
	
	/**
	 * 根据条件查询会议安排 /分页查询
	 * @param paramMap 参数map
	 * @return 会议安排/分页
	 * 20151207
	 */
	public Pages getMeetingByRole(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 获取最近的一条会议名记录
	 * @return
	 */
	public Meeting getLatestMeeting(User user);
	
	/**
	 * 根据会议名称获取会议
	 * @return
	 */
	public Meeting getMeetingByName(User user,String name);
	
	/**
	 * 修改会议安排实体
	 * @param check 待修改的会议安排实体
	 */
	public void updatedMeeting(Meeting meeting);
	
	/**
	 * 编辑会议
	 * @param check 待编辑会议安排实体
	 */
	public void editMeeting(Meeting meeting);
	
	/**
     * 以会议id查询会议详情
     */
	public List<Meeting> selectMeetingByMeetingId(Integer id);
	
	public Meeting selectGradeById(Integer gradeId);
	
	public Meeting selectTeacherById(Integer teacherId);
	
	public void deleteMeetingByMeetingId(Integer meetingId);
	
	/**
	 * 根据条件查询会议刷卡记录 /分页查询
	 * @param paramMap 参数map
	 * @return 会议安排/分页
	 * 20151209
	 */
	public Pages getMeetingInoutList(int pageSize, int page, Map<String, Object> paramMap,User user);
	
	/**
	 * Wife
	 * 根据条件查询会议刷卡记录 /分页查询
	 * @param paramMap 参数map
	 * @return 会议安排/分页
	 * 20151209
	 */
	public Pages getMeetingInoutWifiList(int pageSize, int page, Map<String, Object> paramMap);
	
	
	/**
	 * 根据条件查询会议刷卡记录 /分页查询(APP)
	 * @param paramMap 参数map
	 * @return 会议安排/分页
	 * 20160217
	 */
	public List<MeetingInout> getMeetingInoutListAPP(int pageSize, int page, Map<String, Object> paramMap,User user);
	
	/**
	 * 根据条件查询会议wifi签到记录 /分页查询(APP)
	 * @param paramMap 参数map
	 * @return 会议安排/分页
	 * 20170508
	 */
	public List<MeetingInout> getMeetingInoutListWifiAPP(int pageSize, int page, Map<String, Object> paramMap,User user);
	
	/**
	 * 根据条件查询会议安排/分页查询（APP）
	 * @param paramMap 参数map
	 * @return 会议安排记录/分页 
	 */
	public List<Meeting> getMeetingByRoleAPP(int pageSize, int page, Map<String, Object> paramMap, User user);
	
}
