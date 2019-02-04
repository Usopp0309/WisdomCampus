package com.guotop.palmschool.meeting.entity;

/**
 * 会议手机签到信息实体类
 */
public class MeetingInoutWifi
{
	/**
	 * id
	 */
	private Integer id;

	/**
	 * 0:正常出勤 1:迟到 2.早退 3.缺勤
	 */
	private Integer status;

	/**
	 * 定位信息;纬度,经度
	 */
	private String position;

	/**
	 * wifi信息
	 */
	private String wifi;

	/**
	 * 设备信息
	 */
	private String device;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 用户ID
	 */
	private Integer userId;

	/**
	 * 会议Id
	 */
	private Integer meetingId;

	/**
	 * 记录点名字
	 */
	private String positionName;

	/**
	 * 会议名称
	 */
	private String meetingName;

	/**
	 * 用户名
	 */
	private String realName;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public String getWifi()
	{
		return wifi;
	}

	public void setWifi(String wifi)
	{
		this.wifi = wifi;
	}

	public String getDevice()
	{
		return device;
	}

	public void setDevice(String device)
	{
		this.device = device;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public Integer getMeetingId()
	{
		return meetingId;
	}

	public void setMeetingId(Integer meetingId)
	{
		this.meetingId = meetingId;
	}

	public String getPosition()
	{
		return position;
	}

	public void setPosition(String position)
	{
		this.position = position;
	}

	public String getPositionName()
	{
		return positionName;
	}

	public void setPositionName(String positionName)
	{
		this.positionName = positionName;
	}

	public String getMeetingName()
	{
		return meetingName;
	}

	public void setMeetingName(String meetingName)
	{
		this.meetingName = meetingName;
	}

	public String getRealName()
	{
		return realName;
	}

	public void setRealName(String realName)
	{
		this.realName = realName;
	}

}
