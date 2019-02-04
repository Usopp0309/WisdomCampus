package com.guotop.palmschool.entity;

/**
 * 学生详细信息
 * @author zhou
 */
public class StudentDetail 
{
	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * user主键
	 */
	private Integer userId;
	
	/**
	 * 出生年月
	 */
	private String birth;
	
	/**
	 * 担任职务
	 */
	private String ofJob;
	
	/**
	 * 政治面貌
	 */
	private String forPolitical;
	
	/**
	 * 籍贯
	 */
	private String nativePlace;
	
	/**
	 * 身高
	 */
	private String height;
	
	/**
	 * 体重
	 */
	private String weight;
	
	/**
	 * 视力
	 */
	private String vision;
	
	/**
	 * 入学时间
	 */
	private String insTime;
	
	/**
	 * qq
	 */
	private String qq;
	
	/**
	 * 邮箱
	 */
	private String email;
	
	/**
	 * 家庭住址
	 */
	private String address;

	/**
	 * 奖惩信息
	 */
	private String rewards;
	
	

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

	public String getBirth()
	{
		return birth;
	}

	public void setBirth(String birth) 
	{
		this.birth = birth;
	}

	public String getOfJob() 
	{
		return ofJob;
	}

	public void setOfJob(String ofJob) 
	{
		this.ofJob = ofJob;
	}

	public String getForPolitical() 
	{
		return forPolitical;
	}

	public void setForPolitical(String forPolitical) 
	{
		this.forPolitical = forPolitical;
	}

	public String getNativePlace() 
	{
		return nativePlace;
	}

	public void setNativePlace(String nativePlace) 
	{
		this.nativePlace = nativePlace;
	}

	public String getHeight()
	{
		return height;
	}

	public void setHeight(String height) 
	{
		this.height = height;
	}

	public String getWeight() 
	{
		return weight;
	}

	public void setWeight(String weight) 
	{
		this.weight = weight;
	}

	public String getVision() 
	{
		return vision;
	}

	public void setVision(String vision) 
	{
		this.vision = vision;
	}

	public String getInsTime() 
	{
		return insTime;
	}

	public void setInsTime(String insTime)
	{
		this.insTime = insTime;
	}

	public String getQq() 
	{
		return qq;
	}

	public void setQq(String qq) 
	{
		this.qq = qq;
	}

	public String getEmail() 
	{
		return email;
	}

	public void setEmail(String email) 
	{
		this.email = email;
	}

	public String getAddress() 
	{
		return address;
	}

	public void setAddress(String address) 
	{
		this.address = address;
	}
	
	public String getRewards() 
	{
		return rewards;
	}

	public void setRewards(String rewards) 
	{
		this.rewards = rewards;
	}
}
