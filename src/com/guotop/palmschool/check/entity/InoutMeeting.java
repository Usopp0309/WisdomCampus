package com.guotop.palmschool.check.entity;

import com.guotop.palmschool.entity.Inout;

/**
 * 会议考勤记录
 * @author zhou
 */
public class InoutMeeting extends Inout
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer meetingId;

	public Integer getMeetingId() 
	{
		return meetingId;
	}

	public void setMeetingId(Integer meetingId) 
	{
		this.meetingId = meetingId;
	}
	
}
