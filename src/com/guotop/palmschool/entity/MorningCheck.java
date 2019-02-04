package com.guotop.palmschool.entity;

import java.io.Serializable;

import com.google.gson.annotations.Expose;

public class MorningCheck implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	
	private int userId;
	//体温
	@Expose
	private String temperature;
	//精神状况
	@Expose
	private String spirit;
	//口腔状况
	@Expose
	private String oralCavity;
	//形象
	@Expose
	private String surface;
	//体检老师ID
	private int teacherId;
	//创建时间
	private String createTime;
	//状态 0：正常 1异常
	private int state;
	//学生姓名
	@Expose
	private String name;
	//体检老师姓名
	@Expose
	private String teacherName;
	//班主任姓名
	@Expose
	private String leaderName;
	//班级名称
	@Expose
	private String clazzName;
	//老师头像地址
	@Expose
	private String teacherHeadImgUrl;
	//学生头像地址
	@Expose
	private String studentHeadImgUrl;
	//体检老师手机号
	@Expose
	private String teacherPhone;
	//卡号
	private String cardCode;
	//家长手机号
	private String parentPhone;
	//体检老师卡号
	private String teacherCardCode;
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public int getUserId()
	{
		return userId;
	}
	public void setUserId(int userId)
	{
		this.userId = userId;
	}
	public String getTemperature()
	{
		return temperature;
	}
	public void setTemperature(String temperature)
	{
		this.temperature = temperature;
	}
	public String getSpirit()
	{
		return spirit;
	}
	public void setSpirit(String spirit)
	{
		this.spirit = spirit;
	}
	public String getOralCavity()
	{
		return oralCavity;
	}
	public void setOralCavity(String oralCavity)
	{
		this.oralCavity = oralCavity;
	}
	public String getSurface()
	{
		return surface;
	}
	public void setSurface(String surface)
	{
		this.surface = surface;
	}
	public int getTeacherId()
	{
		return teacherId;
	}
	public void setTeacherId(int teacherId)
	{
		this.teacherId = teacherId;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public int getState()
	{
		return state;
	}
	public void setState(int state)
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
	public String getTeacherName()
	{
		return teacherName;
	}
	public void setTeacherName(String teacherName)
	{
		this.teacherName = teacherName;
	}
	public String getLeaderName()
	{
		return leaderName;
	}
	public void setLeaderName(String leaderName)
	{
		this.leaderName = leaderName;
	}
	public String getClazzName()
	{
		return clazzName;
	}
	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}
	public String getTeacherHeadImgUrl()
	{
		return teacherHeadImgUrl;
	}
	public void setTeacherHeadImgUrl(String teacherHeadImgUrl)
	{
		this.teacherHeadImgUrl = teacherHeadImgUrl;
	}
	public String getStudentHeadImgUrl()
	{
		return studentHeadImgUrl;
	}
	public String getCardCode()
	{
		return cardCode;
	}
	public void setCardCode(String cardCode)
	{
		this.cardCode = cardCode;
	}
	public String getParentPhone()
	{
		return parentPhone;
	}
	public void setParentPhone(String parentPhone)
	{
		this.parentPhone = parentPhone;
	}
	public void setStudentHeadImgUrl(String studentHeadImgUrl)
	{
		this.studentHeadImgUrl = studentHeadImgUrl;
	}
	public String getTeacherPhone()
	{
		return teacherPhone;
	}
	public void setTeacherPhone(String teacherPhone)
	{
		this.teacherPhone = teacherPhone;
	}
	public String getTeacherCardCode()
	{
		return teacherCardCode;
	}
	public void setTeacherCardCode(String teacherCardCode)
	{
		this.teacherCardCode = teacherCardCode;
	}
	
}
