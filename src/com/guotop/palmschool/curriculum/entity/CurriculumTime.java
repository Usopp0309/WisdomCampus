package com.guotop.palmschool.curriculum.entity;

import java.util.List;

/**
 * 课程时间表实体类
 */
public class CurriculumTime {
	/**
	 * id
	 */
	private Integer id;
	
	/**
	 * 开始时间
	 */
	private String beginTime;
	
	/**
	 *结束时间
	 */
	private String endTime;
	
	/**
	 * 学期对应的Id
	 */
	private Integer semesterId;
	
	/**
	 * 更新时间
	 */
	private String updateTime;
	
	/**
	 * 创建时间
	 */
	private String createTime;
	
	/**
	 * 本时间段的科目
	 */
	private List<Curriculum> curriculumList;
	
	/**
	 * 表示是第几节课 1 第一节……
	 */
	private Integer num;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getBeginTime()
	{
		return beginTime;
	}

	public void setBeginTime(String beginTime)
	{
		this.beginTime = beginTime;
	}

	public String getEndTime()
	{
		return endTime;
	}

	public void setEndTime(String endTime)
	{
		this.endTime = endTime;
	}

	public Integer getSemesterId()
	{
		return semesterId;
	}

	public void setSemesterId(Integer semesterId)
	{
		this.semesterId = semesterId;
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

	public Integer getNum()
	{
		return num;
	}

	public void setNum(Integer num)
	{
		this.num = num;
	}

	public List<Curriculum> getCurriculumList()
	{
		return curriculumList;
	}

	public void setCurriculumList(List<Curriculum> curriculumList)
	{
		this.curriculumList = curriculumList;
	}
	
	
}
