package com.guotop.palmschool.check.entity;

import java.sql.Timestamp;


/**
 * 在校时间实体类
 * @author zhou
 */
public class Stay 
{
	/**
	 * ID
	 */
	private int id;
	
	/**
	 * 电子卡号
	 */
	private String code;

	/**
	 * 进入时间
	 */
	private String inTime;

	/**
	 * 外出时间
	 */
	private Timestamp outTime;
	
	/**
	 * 对应用户
	 */
	private Integer userId;
	
	/**
	 * 在校时长
	 */
	private float hours;
	
	
	/**
	 * 进出校的人
	 */
	private String userName;
	

	public int getId() 
	{
		return id;
	}

	public void setId(int id) 
	{
		this.id = id;
	}

	public String getCode() 
	{
		return code;
	}

	public void setCode(String code) 
	{
		this.code = code;
	}

	public String getInTime() 
	{
		return inTime;
	}

	public void setInTime(String inTime) 
	{
		this.inTime = inTime;
	}

	public Timestamp getOutTime() 
	{
		return outTime;
	}

	public void setOutTime(Timestamp outTime) 
	{
		this.outTime = outTime;
	}

	public Integer getUserId() 
	{
		return userId;
	}

	public void setUserId(Integer userId) 
	{
		this.userId = userId;
	}

	public float getHours() 
	{
		return hours;
	}

	public void setHours(float hours) 
	{
		this.hours = hours;
	}
	

	public String getUserName() 
	{
		return userName;
	}

	public void setUserName(String userName) 
	{
		this.userName = userName;
	}
}
