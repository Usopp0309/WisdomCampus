package com.guotop.palmschool.entity;
/**
 * 用户与智能手表关系实体类
 * @author jfy
 * @date 2016年1月27日
 */
public class UserWatch
{
	private int id;
	//家长ID
	private int userId;
	//手表ID
	private String watchId;
	//创建时间
	private String createTime;
	//手表用户名称
	private String name;
	//手表使用者Id
	private int studentId;
	
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
	public String getWatchId()
	{
		return watchId;
	}
	public void setWatchId(String watchId)
	{
		this.watchId = watchId;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public int getStudentId()
	{
		return studentId;
	}
	public void setStudentId(int studentId)
	{
		this.studentId = studentId;
	}
	
	
}
