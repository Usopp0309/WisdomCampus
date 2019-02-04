package com.guotop.palmschool.entity;
/**
 * 异常信息实体类
 * @author jfy
 * @date 2016年1月5日
 */
public class AbnormalInformation
{
	private int id;
	//内容
	private String content;
	//人员
	private int userId;
	//创建时间
	private String createTime;
	//类型 0迟到 1早退
	private int type;
	//名称
	private String realName;
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public int getUserId()
	{
		return userId;
	}
	public void setUserId(int userId)
	{
		this.userId = userId;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public int getType()
	{
		return type;
	}
	public void setType(int type)
	{
		this.type = type;
	}
	public String getRealName()
	{
		return realName;
	}
	public void setRealName(String realName)
	{
		this.realName = realName;
	}
}
