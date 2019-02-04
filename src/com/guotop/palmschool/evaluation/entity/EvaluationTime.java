package com.guotop.palmschool.evaluation.entity;

public class EvaluationTime
{
	/**
	 * ID
	 */
	private int id;
	
	/**
	 * 评价开始时间
	 */
	private String startTime;
	
	/**
	 * 评价结束时间
	 */
	private String endTime;
	
	/**
	 * 允许评价班级
	 */
	private Integer clazzId;
	
	/**
	 * 允许评价年级
	 */
	private Integer gradeId;

	/**
	 * 班级名称
	 */
	private String clazzName;
	
	/**
	 * 年级名称
	 */
	private String gradeName;
	
	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getStartTime()
	{
		return startTime;
	}

	public void setStartTime(String startTime)
	{
		this.startTime = startTime;
	}

	public String getEndTime()
	{
		return endTime;
	}

	public void setEndTime(String endTime)
	{
		this.endTime = endTime;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
	}

	public Integer getGradeId()
	{
		return gradeId;
	}

	public void setGradeId(Integer gradeId)
	{
		this.gradeId = gradeId;
	}

	public String getClazzName()
	{
		return clazzName;
	}

	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}

	public String getGradeName()
	{
		return gradeName;
	}

	public void setGradeName(String gradeName)
	{
		this.gradeName = gradeName;
	}
	
}
