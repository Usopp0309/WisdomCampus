package com.guotop.palmschool.evaluation.entity;


public class EvaluationClazzModel {

	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 关联评价时间设定表
	 */
	private Integer evaluatetimeId;

	/**
	 * 关联评价模板表
	 */
	private Integer teachingfolderId;
	
	/**
	 * 状态
	 */

	private Integer status;
	
	
	private Integer userType;
	
	/**
	 * 学期 1 上学期 2 下学期
	 */

	private Integer semester;
	
	/**
	 * 班级Id
	 */

	private Integer clazzId;
	
	/**
	 * 年级Id
	 */

	private Integer gradeId;
	
	/**
	 * 模板名称
	 */

	private String name;


	public Integer getId()
	{
		return id;
	}


	public void setId(Integer id)
	{
		this.id = id;
	}


	public Integer getEvaluatetimeId()
	{
		return evaluatetimeId;
	}


	public void setEvaluatetimeId(Integer evaluatetimeId)
	{
		this.evaluatetimeId = evaluatetimeId;
	}


	public Integer getTeachingfolderId()
	{
		return teachingfolderId;
	}


	public void setTeachingfolderId(Integer teachingfolderId)
	{
		this.teachingfolderId = teachingfolderId;
	}


	public Integer getStatus()
	{
		return status;
	}


	public void setStatus(Integer status)
	{
		this.status = status;
	}


	public Integer getUserType()
	{
		return userType;
	}

	public void setUserType(Integer userType)
	{
		this.userType = userType;
	}

	public Integer getSemester()
	{
		return semester;
	}

	public void setSemester(Integer semester)
	{
		this.semester = semester;
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


	public String getName()
	{
		return name;
	}


	public void setName(String name)
	{
		this.name = name;
	}
	
}
