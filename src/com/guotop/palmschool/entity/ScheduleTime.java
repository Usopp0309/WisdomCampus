package com.guotop.palmschool.entity;

/**
 * 作息时间表实体类
 * 
 * @author zhou
 *
 */
public class ScheduleTime
{
	private Integer id;

	/**
	 * 0全天 1上午 2下午 3晚上
	 */
	private Integer type;

	/**
	 * 开始时间
	 */
	private String beginTime;

	/**
	 * 结束时间
	 */
	private String endTime;

	private String createTime;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public String getBeginTime()
	{
		return beginTime;
	}

	public void setBeginTime(String beginTime)
	{
		this.beginTime = beginTime;
	}

	public String getEndTime()
	{
		return endTime;
	}

	public void setEndTime(String endTime)
	{
		this.endTime = endTime;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	
}
