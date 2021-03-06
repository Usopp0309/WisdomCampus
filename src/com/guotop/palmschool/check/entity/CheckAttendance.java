package com.guotop.palmschool.check.entity;

import java.io.Serializable;

public class CheckAttendance implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6810966318355600733L;

	private Integer id;
	
	private Integer userId;
	
	private Integer departmentId;
	
	private Integer clazzId;
	
	private String remark;
	
	private Integer status;
	
	private Integer type;
	
	private String createDate;
	
	private String createTime;
	
	private String inoutTime;
	
	/**
	 * 年级名
	 */
	private String gradeName;
	
	/**
	 * 工号
	 */
	private String code;
	
	/**
	 * 姓名
	 */
	private String name;
	//异常状态
	private String statusName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getClazzId() {
		return clazzId;
	}

	public void setClazzId(Integer clazzId) {
		this.clazzId = clazzId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}



	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getGradeName()
	{
		return gradeName;
	}

	public void setGradeName(String gradeName)
	{
		this.gradeName = gradeName;
	}

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getStatusName()
	{
		return statusName;
	}

	public void setStatusName(String statusName)
	{
		this.statusName = statusName;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public String getInoutTime()
	{
		return inoutTime;
	}

	public void setInoutTime(String inoutTime)
	{
		this.inoutTime = inoutTime;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}
	
	
}
