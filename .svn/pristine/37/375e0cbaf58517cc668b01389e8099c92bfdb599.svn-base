package com.guotop.palmschool.entity;

/**
 * 公告实体类
 * 
 * @author zhou
 */
public class Announcement
{
	/**
	 * ID
	 */
	private Integer id;
	
	/**
	 * ID
	 */
	private Integer announcementId;

	/**
	 * 公告内容
	 */
	private String content;

	/**
	 * 发布公告人
	 */
	private Integer userId;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 公告图片
	 */
	private String apic;

	/**
	 * 班级ID
	 */
	private Integer clazzId;

	/**
	 * 公告分类
	 */
	private int type;

	/**
	 * 年级ID
	 */
	private Integer departmentId;

	private String typeName;

	private String realName;

	private String departmentName;

	private String clazzName;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getApic()
	{
		return apic;
	}

	public void setApic(String apic)
	{
		this.apic = apic;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
	}

	public int getType()
	{
		return type;
	}

	public void setType(int type)
	{
		this.type = type;
	}

	public Integer getDepartmentId()
	{
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId)
	{
		this.departmentId = departmentId;
	}

	public String getTypeName()
	{
		return typeName;
	}

	public void setTypeName(String typeName)
	{
		this.typeName = typeName;
	}

	public String getDepartmentName()
	{
		return departmentName;
	}

	public void setDepartmentName(String departmentName)
	{
		this.departmentName = departmentName;
	}

	public String getClazzName()
	{
		return clazzName;
	}

	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}

	public String getRealName()
	{
		return realName;
	}

	public void setRealName(String realName)
	{
		this.realName = realName;
	}

	public Integer getAnnouncementId()
	{
		return announcementId;
	}

	public void setAnnouncementId(Integer announcementId)
	{
		this.announcementId = announcementId;
	}

	/**
	 * 如果对象类型是Announcement 的话 则返回true 去比较hashCode值
	 */
	@Override
	public boolean equals(Object obj) {  
	    if(this == obj)  
	        return false;  
	    if(obj == null)  
	        return false;  
	    if(getClass() != obj.getClass() )  
	        return false;  
	    Announcement announcement = (Announcement)obj;  

	    if(!id.equals(announcement.id))
	        return false;  
	    return true;  
	}  
  
	/**
	 * 重写hashcode 方法，返回的hashCode 不一样才认定为不同的对象
	 */
	@Override
	public int hashCode()
	{
		// 只比较id，id一样就不添加进集合
		return id.hashCode();
	}

	}