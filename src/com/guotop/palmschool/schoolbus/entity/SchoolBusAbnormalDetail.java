package com.guotop.palmschool.schoolbus.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 校车异常类
 * @author 
 */
public class SchoolBusAbnormalDetail 
{
	private Integer id;
	
	private Integer userId;
	
	private String time;
	
	private Integer type;
	
	private String clazzName;
	
	private String code;
	
	private String realName;
	
	private String status;
	
	private String createTime;
	
	private String position;
	
	public SchoolBusAbnormalDetail()
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		this.time = formatter.format(new Date());
	}

	public Integer getId() 
	{
		return id;
	}

	public void setId(Integer id) 
	{
		this.id = id;
	}

	public Integer getUserId() 
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getTime() 
	{
		return time;
	}

	public void setTime(String time) 
	{
		this.time = time;
	}

	public Integer getType() 
	{
		return type;
	}

	public void setType(Integer type) 
	{
		this.type = type;
	}

	public String getClazzName()
	{
		return clazzName;
	}

	public void setClazzName(String clazzName) 
	{
		this.clazzName = clazzName;
	}

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	public String getRealName()
	{
		return realName;
	}

	public void setRealName(String realName)
	{
		this.realName = realName;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getPosition()
	{
		return position;
	}

	public void setPosition(String position)
	{
		this.position = position;
	}

}
