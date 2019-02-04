package com.guotop.palmschool.entity;

import java.util.HashMap;
import java.util.List;

public class ScoreShow
{
	private int userId;
	
	private String realName;
	
	private String testType;
	
	private String createTime;
	
	private List<HashMap<String,Object>> columes;

	public int getUserId()
	{
		return userId;
	}

	public void setUserId(int userId)
	{
		this.userId = userId;
	}

	public String getRealName()
	{
		return realName;
	}

	public void setRealName(String realName)
	{
		this.realName = realName;
	}

	public String getTestType()
	{
		return testType;
	}

	public void setTestType(String testType)
	{
		this.testType = testType;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public List<HashMap<String, Object>> getColumes()
	{
		return columes;
	}

	public void setColumes(List<HashMap<String, Object>> columes)
	{
		this.columes = columes;
	}
	
	
}
