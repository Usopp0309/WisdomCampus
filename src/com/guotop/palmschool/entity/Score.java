package com.guotop.palmschool.entity;

/**
 * 成绩实体类
 * 
 * @author sheng
 */
public class Score
{
	/*
	 * 主键
	 */
	private Integer id;

	/*
	 * 用户id
	 */
	private Integer userId;

	/*
	 * 考试类型。例如：期中考试，期末考试
	 */
	private String testType;

	/*
	 * 考试科目
	 */
	private String subject;

	/*
	 * 考试成绩
	 */
	private String score;

	/*
	 * 班级名称
	 */
	private String clazzName;

	/*
	 * 年级名称
	 */
	private String gradeName;

	/*
	 * 创建时间
	 */
	private String createTime;

	/*
	 * 导入成绩人员
	 */
	private Integer createUserId;
	
	//班级ID
	private Integer clazzId;
	//姓名
	private String realName;

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

	public String getTestType()
	{
		return testType;
	}

	public void setTestType(String testType)
	{
		this.testType = testType;
	}

	public String getSubject()
	{
		return subject;
	}

	public void setSubject(String subject)
	{
		this.subject = subject;
	}

	public String getScore()
	{
		return score;
	}

	public void setScore(String score)
	{
		this.score = score;
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

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public Integer getCreateUserId()
	{
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId)
	{
		this.createUserId = createUserId;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
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
