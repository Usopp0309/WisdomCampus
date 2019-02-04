package com.guotop.palmschool.growth.entity;

public class SelfGrowth
{
	private int id;
	//用户ID
	private int userId;
	//模板ID
	private int templateId;
	//年级名称
	private String gradeName;
	//学期 0 上学期 1 下学期
	private int term;
	//创建时间
	private String createTime;
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public int getUserId()
	{
		return userId;
	}
	public void setUserId(int userId)
	{
		this.userId = userId;
	}
	public int getTemplateId()
	{
		return templateId;
	}
	public void setTemplateId(int templateId)
	{
		this.templateId = templateId;
	}
	public String getGradeName()
	{
		return gradeName;
	}
	public void setGradeName(String gradeName)
	{
		this.gradeName = gradeName;
	}
	public int getTerm()
	{
		return term;
	}
	public void setTerm(int term)
	{
		this.term = term;
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
