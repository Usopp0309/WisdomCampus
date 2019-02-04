package com.guotop.palmschool.rest.entity;

/**
 * 发送公告选择
 * @author zhou
 *
 */
public class AnnounceSelect 
{
	/*
	 * 1: 学校公告   2: 部门公告   3 : 班级公告   4 ： 系统公告
	 */
	private Integer type;
	
	/*
	 * 
	 */
	private String itemId;
	
	/*
	 * 
	 */
	private String itemName;
	
	/*
	 * 
	 */
	private Integer userId;
	
	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type) 
	{
		this.type = type;
	}

	public String getItemId() 
	{
		return itemId;
	}

	public void setItemId(String itemId) 
	{
		this.itemId = itemId;
	}

	public String getItemName() 
	{
		return itemName;
	}

	public void setItemName(String itemName) 
	{
		this.itemName = itemName;
	}

	public Integer getUserId() 
	{
		return userId;
	}

	public void setUserId(Integer userId) 
	{
		this.userId = userId;
	}
}
