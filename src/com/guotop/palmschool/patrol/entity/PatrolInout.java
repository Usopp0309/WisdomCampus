package com.guotop.palmschool.patrol.entity;

import java.io.Serializable;

/**
 * 校务巡查巡更刷卡记录实体类
 */
public class PatrolInout implements Serializable
{
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	private Integer id;

	/**
	 * 用户Id
	 */
	private Integer userId;

	/**
	 * 巡更状态的状态：0:范围内 1:范围外
	 */
	private Integer status;

	/**
	 * 巡更地点ID
	 */
	private Integer placeId;

	/**
	 * 实际输入的巡更点名称
	 */
	private String placeName;

	/**
	 * 实际巡更位置
	 */
	private String position;

	/**
	 * 刷卡日期
	 */
	private String inoutDate;

	/**
	 * 刷卡时间
	 */
	private String inoutTime;

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

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public Integer getPlaceId()
	{
		return placeId;
	}

	public void setPlaceId(Integer placeId)
	{
		this.placeId = placeId;
	}

	public String getPlaceName()
	{
		return placeName;
	}

	public void setPlaceName(String placeName)
	{
		this.placeName = placeName;
	}

	public String getPosition()
	{
		return position;
	}

	public void setPosition(String position)
	{
		this.position = position;
	}

	public String getInoutDate()
	{
		return inoutDate;
	}

	public void setInoutDate(String inoutDate)
	{
		this.inoutDate = inoutDate;
	}

	public String getInoutTime()
	{
		return inoutTime;
	}

	public void setInoutTime(String inoutTime)
	{
		this.inoutTime = inoutTime;
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
