package com.guotop.palmschool.entity;

import com.google.gson.annotations.Expose;

/**
 * 用户绑定学校和入学年份
 */
public class UserBoundSchool extends School
{
	/**
	 * 用户id
	 */
	private Integer userId;

	/**
	 * 入学年份
	 */
	@Expose
	private String year;

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getYear()
	{
		return year;
	}

	public void setYear(String year)
	{
		this.year = year;
	}

}
