package com.guotop.palmschool.entity;

/**
 * 短信套餐适用班级实体类
 * 
 */
public class OrderMessageClazz
{
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 套餐id
	 */
	private Integer orderMessageId;

	/**
	 * 班级id
	 */
	private Integer clazzId;

	/**
	 * 年级为选中 0否 其他是
	 */
	private Integer isSelected;

	/**
	 * 班级名称
	 */
	private String clazzName;

	/**
	 * 创建时间
	 */
	private String createTime;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getOrderMessageId()
	{
		return orderMessageId;
	}

	public void setOrderMessageId(Integer orderMessageId)
	{
		this.orderMessageId = orderMessageId;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
	}

	public String getClazzName()
	{
		return clazzName;
	}

	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}

	public Integer getIsSelected()
	{
		return isSelected;
	}

	public void setIsSelected(Integer isSelected)
	{
		this.isSelected = isSelected;
	}

}
