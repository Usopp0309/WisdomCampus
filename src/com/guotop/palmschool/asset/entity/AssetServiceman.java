package com.guotop.palmschool.asset.entity;

import com.google.gson.annotations.Expose;

/**
 * 资产维修人员列表
 * @author taomingyue
 */
public class AssetServiceman
{
	private int id;
	/**
	 * 资产ID
	 */
	private Integer assetId;
	/**
	 * 维修人员
	 */
	@Expose
	private String serviceman;
	/**
	 * 维修人员ID
	 */
	@Expose
	private Integer servicemanId;
	
	@Expose
	private String servicemanHeadImg;
	/**
	 * 联系方式
	 */
	private String phone;
	/**
	 * 维修人员工号
	 */
	private String code;
	/**
	 * 维修类型
	 */
	private Integer type;
	/**
	 * 领导1
	 */
	private Integer leaderIdOne;
	/**
	 * 领导1
	 */
	private String leaderOne;
	/**
	 * 领导2
	 */
	private Integer leaderIdTwo;
	/**
	 * 领导2
	 */
	private String leaderTwo;
	/**
	 * 创建时间
	 */
	private String createTime;
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public Integer getAssetId()
	{
		return assetId;
	}
	public void setAssetId(Integer assetId)
	{
		this.assetId = assetId;
	}
	public String getPhone()
	{
		return phone;
	}
	public void setPhone(String phone)
	{
		this.phone = phone;
	}
	public String getServiceman()
	{
		return serviceman;
	}
	public void setServiceman(String serviceman)
	{
		this.serviceman = serviceman;
	}
	public Integer getServicemanId()
	{
		return servicemanId;
	}
	public void setServicemanId(Integer servicemanId)
	{
		this.servicemanId = servicemanId;
	}
	public String getCode()
	{
		return code;
	}
	public void setCode(String code)
	{
		this.code = code;
	}
	public Integer getType()
	{
		return type;
	}
	public void setType(Integer type)
	{
		this.type = type;
	}
	public Integer getLeaderIdOne()
	{
		return leaderIdOne;
	}
	public void setLeaderIdOne(Integer leaderIdOne)
	{
		this.leaderIdOne = leaderIdOne;
	}
	public String getLeaderOne()
	{
		return leaderOne;
	}
	public void setLeaderOne(String leaderOne)
	{
		this.leaderOne = leaderOne;
	}
	public Integer getLeaderIdTwo()
	{
		return leaderIdTwo;
	}
	public void setLeaderIdTwo(Integer leaderIdTwo)
	{
		this.leaderIdTwo = leaderIdTwo;
	}
	public String getLeaderTwo()
	{
		return leaderTwo;
	}
	public void setLeaderTwo(String leaderTwo)
	{
		this.leaderTwo = leaderTwo;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public String getServicemanHeadImg()
	{
		return servicemanHeadImg;
	}
	public void setServicemanHeadImg(String servicemanHeadImg)
	{
		this.servicemanHeadImg = servicemanHeadImg;
	}
}
