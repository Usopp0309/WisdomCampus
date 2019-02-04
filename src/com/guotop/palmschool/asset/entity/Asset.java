package com.guotop.palmschool.asset.entity;

import com.google.gson.annotations.Expose;

/**
 * 资产实体类
 * 
 * @author taomingyue
 */
public class Asset
{
	@Expose
	private int id;

	@Expose
	private int assetId;

	/**
	 * 编码
	 */
	@Expose
	private String code;
	/**
	 * 名称
	 */
	@Expose
	private String name;
	/**
	 * 资产类型
	 */
	@Expose
	private Integer type;
	/**
	 * 资产属性0学校资产 1个人资产
	 */
	@Expose
	private Integer property;
	/**
	 * 
	 */
	private String manufacturer;
	/**
	 * 负责人ID
	 */
	private Integer respPersonId;
	/**
	 * 负责人
	 */
	@Expose
	private String respPerson;
	/**
	 * 规格
	 */
	private String spec;
	/**
	 * 型号
	 */
	private String model;
	/**
	 * 计数单位 台、个等
	 */
	private String units;
	/**
	 * 数量
	 */
	private Integer count;
	/**
	 * 单价
	 */
	private Double price;
	/**
	 * 存放位置
	 */
	private String site;
	/**
	 * 购买日期
	 */
	private String buyDate;
	/**
	 * 保质期
	 */
	private String qualityDate;
	/**
	 * 资产总价
	 */
	private Double totalPrice;
	/**
	 * 描述
	 */
	private String remark;
	/**
	 * 创建时间
	 */
	private String createTime;
	/**
	 * 更新时间
	 */
	private String updateTime;

	/**
	 * 领取人ID
	 */
	private Integer receiveId;
	/**
	 * 是否是蓝牙资产,0：不是，1：蓝牙路由器，2：蓝牙手表
	 */
	private Integer isBluetooth;
	
	/**
	 * 领取人
	 */
	@Expose
	private String receiver;
	/**
	 * 领取人时间
	 */
	@Expose
	private String receiveTime;

	public Integer getIsBluetooth() {
		return isBluetooth;
	}

	public void setIsBluetooth(Integer isBluetooth) {
		this.isBluetooth = isBluetooth;
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
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

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public Integer getProperty()
	{
		return property;
	}

	public void setProperty(Integer property)
	{
		this.property = property;
	}

	public String getManufacturer()
	{
		return manufacturer;
	}

	public void setManufacturer(String manufacturer)
	{
		this.manufacturer = manufacturer;
	}

	public Integer getRespPersonId()
	{
		return respPersonId;
	}

	public void setRespPersonId(Integer respPersonId)
	{
		this.respPersonId = respPersonId;
	}

	public String getRespPerson()
	{
		return respPerson;
	}

	public void setRespPerson(String respPerson)
	{
		this.respPerson = respPerson;
	}

	public String getSpec()
	{
		return spec;
	}

	public void setSpec(String spec)
	{
		this.spec = spec;
	}

	public String getModel()
	{
		return model;
	}

	public void setModel(String model)
	{
		this.model = model;
	}

	public String getUnits()
	{
		return units;
	}

	public void setUnits(String units)
	{
		this.units = units;
	}

	public Integer getCount()
	{
		return count;
	}

	public void setCount(Integer count)
	{
		this.count = count;
	}

	public Double getPrice()
	{
		return price;
	}

	public void setPrice(Double price)
	{
		this.price = price;
	}

	public String getSite()
	{
		return site;
	}

	public void setSite(String site)
	{
		this.site = site;
	}

	public String getBuyDate()
	{
		return buyDate;
	}

	public void setBuyDate(String buyDate)
	{
		this.buyDate = buyDate;
	}

	public Double getTotalPrice()
	{
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice)
	{
		this.totalPrice = totalPrice;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
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

	public String getQualityDate()
	{
		return qualityDate;
	}

	public void setQualityDate(String qualityDate)
	{
		this.qualityDate = qualityDate;
	}

	public Integer getReceiveId()
	{
		return receiveId;
	}

	public void setReceiveId(Integer receiveId)
	{
		this.receiveId = receiveId;
	}

	public String getReceiver()
	{
		return receiver;
	}

	public void setReceiver(String receiver)
	{
		this.receiver = receiver;
	}

	public String getReceiveTime()
	{
		return receiveTime;
	}

	public void setReceiveTime(String receiveTime)
	{
		this.receiveTime = receiveTime;
	}

	public int getAssetId()
	{
		return assetId;
	}

	public void setAssetId(int assetId)
	{
		this.assetId = assetId;
	}

}
