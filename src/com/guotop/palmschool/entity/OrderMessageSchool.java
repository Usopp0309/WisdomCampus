package com.guotop.palmschool.entity;

/**
 * 短信套餐学校购买实体类
 */
public class OrderMessageSchool
{
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 商品名称
	 */
	private String name;

	/**
	 * 学校Id
	 */
	private String schoolId;

	/**
	 * 购买人Id
	 */
	private Integer userId;

	/**
	 * 开始生效时间
	 */
	private String startTime;

	/**
	 * 结束时间
	 */
	private String endTime;

	/**
	 * 类型0包时间段 1 单价/每条
	 */
	private Integer type;

	/**
	 * 条数
	 */
	private Integer count;
	
	/**
	 * 剩余条数
	 */
	private Integer remainCount;
	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 更新时间
	 */
	private String updateTime;

	/**
	 * 订单id
	 */
	private Integer orderId;

	/**
	 * 状态 0可用 1不可用
	 */
	private Integer status;

	/**
	 * 对应的套餐id
	 */
	private Integer messageId;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
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

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public Integer getCount()
	{
		return count;
	}

	public void setCount(Integer count)
	{
		this.count = count;
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

	public Integer getOrderId()
	{
		return orderId;
	}

	public void setOrderId(Integer orderId)
	{
		this.orderId = orderId;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public Integer getMessageId()
	{
		return messageId;
	}

	public void setMessageId(Integer messageId)
	{
		this.messageId = messageId;
	}

	public Integer getRemainCount()
	{
		return remainCount;
	}

	public void setRemainCount(Integer remainCount)
	{
		this.remainCount = remainCount;
	}
	

}
