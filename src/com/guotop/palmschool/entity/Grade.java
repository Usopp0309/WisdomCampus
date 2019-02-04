package com.guotop.palmschool.entity;

import java.util.List;

/**
 * 年级实体类
 * 
 * @author tao
 *
 */
public class Grade
{
	// ID
	private Integer id;
    
	//年级主键
    private Integer gradeId;
    
    private Integer gid;
    
	// 年级组长
	private String leaderId;

	// 更新时间
	private String updateTime;

	// 创建时间
	private String createTime;

	// 创建年份,用于计算当前属于几年级
	private String createYear;

	// 年级所属类: 0 幼儿园 1小学 2 初中 3 高中
	private String type;

	// 年级所属类: 0 可用 1不可用
	private String state;

	// 年级名称
	private String name;
	
	//福建资源晕学校Id
	private String fjSchoolId;

	// 班级List
	private List<Clazz> clazzList;

	public Integer getGid() {
		return gid;
	}

	public void setGid(Integer gid) {
		
		this.gid = gid;
	}

	public Integer getGradeId() {
		return gradeId;
	}

	public void setGradeId(Integer gradeId) {
		setGid(gradeId);
		this.gradeId = gradeId;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		if(id!=null){
			setGradeId(id);	
		}
		this.id = id;
	}

	public String getLeaderId()
	{
		return leaderId;
	}

	public void setLeaderId(String leaderId)
	{
		this.leaderId = leaderId;
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

	public String getCreateYear()
	{
		return createYear;
	}

	public void setCreateYear(String createYear)
	{
		this.createYear = createYear;
	}

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public String getState()
	{
		return state;
	}

	public void setState(String state)
	{
		this.state = state;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public List<Clazz> getClazzList()
	{
		return clazzList;
	}

	public void setClazzList(List<Clazz> clazzList)
	{
		this.clazzList = clazzList;
	}

	public String getFjSchoolId()
	{
		return fjSchoolId;
	}

	public void setFjSchoolId(String fjSchoolId)
	{
		this.fjSchoolId = fjSchoolId;
	}
	
}
