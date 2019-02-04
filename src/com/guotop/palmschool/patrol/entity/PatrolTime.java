package com.guotop.palmschool.patrol.entity;

import java.io.Serializable;

/**
 * 校务巡查巡更设置实体
 * 
 * @author
 */

public class PatrolTime implements Serializable
{

	private static final long serialVersionUID = 1L;

	/**
	 * 开始时间 YYYY-MM-DD HH:mm:ss
	 */
	private String startTime;

	/**
	 * 结束时间 YYYY-MM-DD HH:mm:ss
	 */
	private String endTime;

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

}
