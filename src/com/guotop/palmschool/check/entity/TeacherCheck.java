package com.guotop.palmschool.check.entity;

/**
 * 老师考勤
 * @author zhou
 */
public class TeacherCheck 
{
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
	
	/**
	 * 手机号码
	 */
	private String phone;
	
	/**
	 * 电子卡
	 */
	private String cardCode;
	
	/**
	 * 状态
	 */
	private Integer status;
	
	/**
	 * 用户Id
	 */
	private Integer uId;
	
	/**
	 * 用户Id
	 */
	private String remark;
	
	/**
	 * 更新时间
	 */
	private String updateTime;

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

	public String getPhone() 
	{
		return phone;
	}

	public void setPhone(String phone) 
	{
		this.phone = phone;
	}

	public String getCardCode() 
	{
		return cardCode;
	}

	public void setCardCode(String cardCode)
	{
		this.cardCode = cardCode;
	}

	public Integer getStatus() 
	{
		return status;
	}

	public void setStatus(Integer status) 
	{
		this.status = status;
	}

	public String getUpdateTime() 
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime) 
	{
		this.updateTime = updateTime;
	}

	public Integer getuId()
	{
		return uId;
	}

	public void setuId(Integer uId)
	{
		this.uId = uId;
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
