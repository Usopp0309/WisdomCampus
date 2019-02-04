package com.guotop.palmschool.entity;


public class Ykt {

	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 卡号
	 */
	private String cardCode;
	
	/**
	 * 用户ID
	 */
	private Integer userId;

	/**
	 * 卡号姓名
	 */
	private String userName;

	
	/**
	 * 消费金额
	 */
	private double consMoney;
	
	/**
	 * 卡余额
	 */
	private double balance;
	
	/**
	 * 原余额
	 */
	private double oldMoney;
	
	/**
	 * 消费时间
	 */
	private String consTime;
	
	/**
	 * 消费类型 0－消费，1－存款，2－取款，3－补助, 4－挂失，5－解挂，6－开户，7－撤户，8－纠错，9－换卡，10－补卡，11－变更，12－登陆，13－正常退出，14－非法退出 21—补助清零
	 */
	private String consStatus;
	
	/**
	 * 消费地点
	 */
	private String consPlace;
	
	/**
	 * 班级Id
	 */
	private Integer clazzId;
	
	/**
	 * 班级名称
	 */
	private String clazzName;
	
	/**
	 * 部门Id
	 */
	private Integer departmentId;
	
	/**
	 * 部门名称
	 */
	private String departmentName;

	/**
	 * 创建时间
	 */
	private String createTime;
	
	/**
	 * 部门(班级)名称
	 */
	private String itemName;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getCardCode()
	{
		return cardCode;
	}

	public void setCardCode(String cardCode)
	{
		this.cardCode = cardCode;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	public double getConsMoney()
	{
		return consMoney;
	}

	public void setConsMoney(double consMoney)
	{
		this.consMoney = consMoney;
	}

	public double getBalance()
	{
		return balance;
	}

	public void setBalance(double balance)
	{
		this.balance = balance;
	}

	public double getOldMoney()
	{
		return oldMoney;
	}

	public void setOldMoney(double oldMoney)
	{
		this.oldMoney = oldMoney;
	}

	public String getConsTime()
	{
		return consTime;
	}

	public void setConsTime(String consTime)
	{
		this.consTime = consTime;
	}

	public String getConsStatus()
	{
		return consStatus;
	}

	public void setConsStatus(String consStatus)
	{
		this.consStatus = consStatus;
	}

	public String getConsPlace()
	{
		return consPlace;
	}

	public void setConsPlace(String consPlace)
	{
		this.consPlace = consPlace;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
	}

	public Integer getDepartmentId()
	{
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId)
	{
		this.departmentId = departmentId;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getClazzName()
	{
		return clazzName;
	}

	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}

	public String getDepartmentName()
	{
		return departmentName;
	}

	public void setDepartmentName(String departmentName)
	{
		this.departmentName = departmentName;
	}

	public String getItemName()
	{
		return itemName;
	}

	public void setItemName(String itemName)
	{
		this.itemName = itemName;
	}

	
}
