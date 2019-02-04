package com.guotop.palmschool.meeting.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.meeting.entity.MeetingDetail;
import com.guotop.palmschool.meeting.service.MeetingDetailService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 会议安排业务类实现类
 * @author 
 */
@Service("meetingDetailService")
public class MeetingDetailServiceImpl extends BaseService implements MeetingDetailService
{
	/**
	 * 添加会议记录实体
	 * @param check 待添加的会议记录实体
	 */
	public void addMeetingDetail(MeetingDetail meetingDetail)
	{
		getBaseDao().addObject("MeetingDetail.addMeetingDetail", meetingDetail);
	}
	
	/**
	 * 删除会议详情
	 * @param 
	 */
	public void deleteMeetingDetail(Integer meetingId)
	{
		getBaseDao().deleteObjectById("MeetingDetail.deleteMeetingDetail", meetingId);
	}
	
	/**
	 * 更新会议记录实体
	 * @param check 待更新的会议记录实体
	 * 20151208
	 */
	public void updateMeetingDetail(MeetingDetail meetingDetail)
	{
		getBaseDao().addObject("MeetingDetail.updateMeetingDetail", meetingDetail);
	}
	
	/**
	 * 更新我的会议详情签到状态
	 */
	public void updateAttensta(Map<String, Object> parmMap)
	{
		getBaseDao().addObject("MeetingDetail.updateAttensta", parmMap);
	}
	/**
	 * 根据会议Id查询会议记录 /分页查询
	 * @param paramMap 参数map
	 * @return 会议记录/分页
	 * 20151208
	 */
	@SuppressWarnings("unchecked")
	public Pages getMeetingDetailByMeetingId(int pageSize, int page, Map<String, Object> paramMap,User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<MeetingDetail> list = new ArrayList<MeetingDetail>();
		allRow = this.getBaseDao().getAllRowCountByCondition("MeetingDetail.getMeetingDetailListByMeetingId", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);
			
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("MeetingDetail.getMeetingDetailListByMeetingId", paramMap, offset, length);
		
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
	 * 根据userId查询会议记录 /分页查询
	 * @param paramMap 参数map
	 * @return 会议记录/分页
	 * 查看自己参加会议List
	 * 20151208
	 */
	@SuppressWarnings("unchecked")
	public Pages getMeetingDetailByUserId(int pageSize, int page, Map<String, Object> paramMap,User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<MeetingDetail> list = new ArrayList<MeetingDetail>();
		allRow = this.getBaseDao().getAllRowCountByCondition("MeetingDetail.getMeetingDetailListByUserId", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);
			
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("MeetingDetail.getMeetingDetailListByUserId", paramMap, offset, length);
		
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
	 * 根据meetingId查询会议详情
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDetail> selectMeetingDetailByMeetingId(Integer meetingId)
	{
		return (List<MeetingDetail>) this.getBaseDao().selectList("MeetingDetail.selectMeetingDetailByMeetingId",meetingId);
	}
	
	
	/**
	 * 根据会议Id查询会议记录 /分页查询(APP)
	 * @param paramMap 参数map
	 * @return 会议记录/分页
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDetail> getMeetingDetailByMeetingIdAPP(int pageSize, int page, Map<String, Object> paramMap,User user)
	{
		List<MeetingDetail> list = new ArrayList<MeetingDetail>();
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		list = this.getBaseDao().selectListByObject("MeetingDetail.getMeetingDetailListByMeetingIdAPP", paramMap);
		
		return list;
	}
	
	
	/**
	 * 根据userId查询会议记录 /分页查询(APP)
	 * @param paramMap 参数map
	 * @return 会议记录/分页
	 * 查看自己参加会议List
	 * 20151208
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDetail> getMeetingDetailByUserIdAPP(int pageSize, int page, Map<String, Object> paramMap,User user)
	{
		List<MeetingDetail> list = new ArrayList<MeetingDetail>();
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("MeetingDetail.getMeetingDetailListByUserIdAPP", paramMap);
		
		return list;
	}

	@Override
	public MeetingDetail selectMeetingDetailById(Integer id) {
		return (MeetingDetail) this.getBaseDao().selectObject("MeetingDetail.selectMeetingDetailById", id);
	}
	
 }
