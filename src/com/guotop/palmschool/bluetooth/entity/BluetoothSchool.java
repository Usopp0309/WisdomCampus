package com.guotop.palmschool.bluetooth.entity;

import org.omg.CORBA.PRIVATE_MEMBER;

public class BluetoothSchool
{
	private Integer id;
	private String schoolId;
	private String startTime;
	private String endTime;
	private Integer jobKey;
	private String createDate;
	private String cronExpression;
	private String createTime;
	/**
	 * 任务循环时间(分钟)
	 */
	private Integer times;

	public Integer getTimes()
	{
		return times;
	}

	public void setTimes(Integer times)
	{
		this.times = times;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public Integer getJobKey()
	{
		return jobKey;
	}

	public void setJobKey(Integer jobKey)
	{
		this.jobKey = jobKey;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}

	public String getStartTime()
	{
		return startTime;
	}

	public void setStartTime(String startTime)
	{
		this.startTime = startTime;
	}

	public String getEndTime()
	{
		return endTime;
	}

	public void setEndTime(String endTime)
	{
		this.endTime = endTime;
	}

	public String getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(String createDate)
	{
		this.createDate = createDate;
	}

	public String getCronExpression()
	{
		return cronExpression;
	}

	public void setCronExpression(String cronExpression)
	{
		this.cronExpression = cronExpression;
	}

}
