package com.guotop.palmschool.scheduler.entity;

import java.io.Serializable;

/**
 * 学校服务费统计缴纳信息实体类
 * 
 * @author syj
 * @date 2017年03月29日
 */
public class SchoolCountInfoServiceHistory implements Serializable
{

	private static final long serialVersionUID = 2829384337817256855L;
	//主键
	private Integer id;
	// 学校ID
	private Long schoolId;
	// 用户总数
	private Integer userCount;
	// 老师总数
	private Integer teacherCount;
	// 学生总数
	private Integer studentCount;

	/**
	 * 已缴费人数
	 */
	private Integer alreadyPayCount;

	/**
	 * 未缴费人数
	 */
	private Integer unPayCount;

	/**
	 * 免缴费人数
	 */
	private Integer freePayCount;

	/**
	 * 服务费ID
	 */
	private Integer messageId;

	/**
	 * 服务费名称
	 */
	private String name;

	/**
	 * 价格（为carPrice与servicePrice之和）
	 */
	private double price;

	/**
	 * 有效开始时间
	 */
	private String startTime;

	/**
	 * 有效结束时间
	 */
	private String endTime;

	/**
	 * 类型0包时间段 1 单价/每条
	 */
	private Integer type;
	
	/**
	 * 状态 0可用 1失效
	 */
	private Integer status;

	/**
	 * 是否是虚拟套餐 0:是 1:否
	 */
	private String isVirtual;

	/**
	 * 套餐范围0:学校,1:个人
	 */
	private Integer rangeObject;

	/**
	 * 卡押金价格
	 */
	private Double cardPrice;

	/**
	 * 服务费价格
	 */
	private Double servicePrice;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 更新时间
	 */
	private String updateTime;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Long getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(Long schoolId)
	{
		this.schoolId = schoolId;
	}

	public Integer getUserCount()
	{
		return userCount;
	}

	public void setUserCount(Integer userCount)
	{
		this.userCount = userCount;
	}

	public Integer getTeacherCount()
	{
		return teacherCount;
	}

	public void setTeacherCount(Integer teacherCount)
	{
		this.teacherCount = teacherCount;
	}

	public Integer getStudentCount()
	{
		return studentCount;
	}

	public void setStudentCount(Integer studentCount)
	{
		this.studentCount = studentCount;
	}

	public Integer getAlreadyPayCount()
	{
		return alreadyPayCount;
	}

	public void setAlreadyPayCount(Integer alreadyPayCount)
	{
		this.alreadyPayCount = alreadyPayCount;
	}

	public Integer getUnPayCount()
	{
		return unPayCount;
	}

	public void setUnPayCount(Integer unPayCount)
	{
		this.unPayCount = unPayCount;
	}

	public Integer getFreePayCount()
	{
		return freePayCount;
	}

	public void setFreePayCount(Integer freePayCount)
	{
		this.freePayCount = freePayCount;
	}

	public Integer getMessageId()
	{
		return messageId;
	}

	public void setMessageId(Integer messageId)
	{
		this.messageId = messageId;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public double getPrice()
	{
		return price;
	}

	public void setPrice(double price)
	{
		this.price = price;
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

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public String getIsVirtual()
	{
		return isVirtual;
	}

	public void setIsVirtual(String isVirtual)
	{
		this.isVirtual = isVirtual;
	}

	public Integer getRangeObject()
	{
		return rangeObject;
	}

	public void setRangeObject(Integer rangeObject)
	{
		this.rangeObject = rangeObject;
	}

	public Double getCardPrice()
	{
		return cardPrice;
	}

	public void setCardPrice(Double cardPrice)
	{
		this.cardPrice = cardPrice;
	}

	public Double getServicePrice()
	{
		return servicePrice;
	}

	public void setServicePrice(Double servicePrice)
	{
		this.servicePrice = servicePrice;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
	}

}
