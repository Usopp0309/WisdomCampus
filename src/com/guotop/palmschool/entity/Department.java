package com.guotop.palmschool.entity;

import java.io.Serializable;
import java.util.List;

/**
 * 部门实体类
 * 
 * @author li
 */

public class Department implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5864720458463931837L;

	private Integer id;

	// 部门编号
	private String code;

	// 部门名称
	private String departmentName;

	// 更新时间
	private String updateTime;

	// 创建时间
	private String createTime;

	// 部门所属学校
	private Integer leaderId;

	// 人员名称
	private String name;

	private String departId;

	private String userId;

	private String roleId;
	private String gradeId;
	private String clazzId;

	private String leaderName;
	private String phone;

	// 部门人员创建时间
	private String personUpdatetime;

	private List<User> teacherList;
	
	private String isAttendance;
	
	//福建资源云学校Id
	private String fjSchoolId;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
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

	public String getDepartmentName()
	{
		return departmentName;
	}

	public void setDepartmentName(String departmentName)
	{
		this.departmentName = departmentName;
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

	public Integer getLeaderId()
	{
		return leaderId;
	}

	public void setLeaderId(Integer leaderId)
	{
		this.leaderId = leaderId;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getDepartId()
	{
		return departId;
	}

	public void setDepartId(String departId)
	{
		this.departId = departId;
	}

	public String getUserId()
	{
		return userId;
	}

	public void setUserId(String userId)
	{
		this.userId = userId;
	}

	public String getRoleId()
	{
		return roleId;
	}

	public void setRoleId(String roleId)
	{
		this.roleId = roleId;
	}

	public String getGradeId()
	{
		return gradeId;
	}

	public void setGradeId(String gradeId)
	{
		this.gradeId = gradeId;
	}

	public String getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(String clazzId)
	{
		this.clazzId = clazzId;
	}

	public String getLeaderName()
	{
		return leaderName;
	}

	public void setLeaderName(String leaderName)
	{
		this.leaderName = leaderName;
	}

	public String getPersonUpdatetime()
	{
		return personUpdatetime;
	}

	public void setPersonUpdatetime(String personUpdatetime)
	{
		this.personUpdatetime = personUpdatetime;
	}

	public List<User> getTeacherList()
	{
		return teacherList;
	}

	public void setTeacherList(List<User> teacherList)
	{
		this.teacherList = teacherList;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getIsAttendance()
	{
		return isAttendance;
	}

	public void setIsAttendance(String isAttendance)
	{
		this.isAttendance = isAttendance;
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
