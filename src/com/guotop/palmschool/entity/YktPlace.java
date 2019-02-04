package com.guotop.palmschool.entity;

public class YktPlace  {


	/**
	 * ID
	 */
	private Integer id;
	
	private String consPlace;
	
	private String updateTime;

	private String createTime ;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getConsPlace()
	{
		return consPlace;
	}

	public void setConsPlace(String consPlace)
	{
		this.consPlace = consPlace;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
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
