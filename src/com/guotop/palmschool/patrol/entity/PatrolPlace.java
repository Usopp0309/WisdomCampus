package com.guotop.palmschool.patrol.entity;

import java.io.Serializable;

/**
 * 校务巡查点设置实体
 * 
 * @author
 */

public class PatrolPlace implements Serializable
{

	private static final long serialVersionUID = 1L;
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 巡更点编号
	 */
	private String code;

	/**
	 * 巡更点名称
	 */
	private String name;

	/**
	 * 巡更点纬度，经度
	 */
	private String position;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 更新时间
	 */
	private String updateTime;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getPosition()
	{
		return position;
	}

	public void setPosition(String position)
	{
		this.position = position;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
	}

}
