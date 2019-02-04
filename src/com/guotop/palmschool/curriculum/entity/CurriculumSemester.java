package com.guotop.palmschool.curriculum.entity;

/**
 * 课程学期表实体类
 */
public class CurriculumSemester {
	/**
	 * id
	 */
	private Integer id;
	
	/**
	 * 开始日期
	 */
	private String beginDate;
	
	/**
	 *结束日期
	 */
	private String endDate;
	
	/**
	 * 班级Id 幼儿园版本使用类型 0 幼儿园 1小学 2 初中 3 高中
	 */
	private Integer clazzId;
	
	/**
	 * 1 可用 2 不可用
	 */
	private Integer usable;
	
	/**
	 * 更新时间
	 */
	private String updateTime;
	
	/**
	 * 创建时间
	 */
	private String createTime;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getBeginDate()
	{
		return beginDate;
	}

	public void setBeginDate(String beginDate)
	{
		this.beginDate = beginDate;
	}

	public String getEndDate()
	{
		return endDate;
	}

	public void setEndDate(String endDate)
	{
		this.endDate = endDate;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
	}

	public Integer getUsable()
	{
		return usable;
	}

	public void setUsable(Integer usable)
	{
		this.usable = usable;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
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
