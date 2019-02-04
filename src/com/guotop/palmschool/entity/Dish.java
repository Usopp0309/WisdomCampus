package com.guotop.palmschool.entity;

import java.io.Serializable;

public class Dish implements Serializable
{
	private static final long serialVersionUID = 1L;

	private int id;
	private int recipeId;
	private String createTime;
	private String dishName;
	private String picName;
	private String picPath;
	private String dishType;
	private Integer praiseCount;
	private String pushDate;

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public int getRecipeId()
	{
		return recipeId;
	}

	public void setRecipeId(int recipeId)
	{
		this.recipeId = recipeId;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getDishName()
	{
		return dishName;
	}

	public void setDishName(String dishName)
	{
		this.dishName = dishName;
	}

	public String getPicName()
	{
		return picName;
	}

	public void setPicName(String picName)
	{
		this.picName = picName;
	}

	public String getPicPath()
	{
		return picPath;
	}

	public void setPicPath(String picPath)
	{
		this.picPath = picPath;
	}

	public String getDishType()
	{
		return dishType;
	}

	public void setDishType(String dishType)
	{
		this.dishType = dishType;
	}

	public Integer getPraiseCount()
	{
		return praiseCount;
	}

	public void setPraiseCount(Integer praiseCount)
	{
		this.praiseCount = praiseCount;
	}

	public String getPushDate()
	{
		return pushDate;
	}

	public void setPushDate(String pushDate)
	{
		this.pushDate = pushDate;
	}

}
