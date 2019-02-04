package com.guotop.palmschool.check.entity;

/**
 * 宿管异常统计
 * @author zhou
 */
public class InoutAbnormalTotal 
{
	private Integer id;

	private Integer studentSum;
	
	private Integer studentAbnormal;
	
	private String time;
	
	private Integer type;
	
	private Integer scale;
	
	private Integer itemId;
	
	private String itemName;
	
	/**
	 * 时间戳
	 */
	private String timeStamp;

	public Integer getId() 
	{
		return id;
	}

	public void setId(Integer id) 
	{
		this.id = id;
	}
	
	public Integer getStudentSum()
	{
		return studentSum;
	}

	public void setStudentSum(Integer studentSum) 
	{
		this.studentSum = studentSum;
	}

	public Integer getStudentAbnormal() 
	{
		return studentAbnormal;
	}

	public void setStudentAbnormal(Integer studentAbnormal) 
	{
		this.studentAbnormal = studentAbnormal;
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

	public Integer getScale() 
	{
		return scale;
	}

	public void setScale(Integer scale) 
	{
		this.scale = scale;
	}

	public Integer getItemId() 
	{
		return itemId;
	}

	public void setItemId(Integer itemId) 
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

	public String getTimeStamp() 
	{
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) 
	{
		this.timeStamp = timeStamp;
	}
}
