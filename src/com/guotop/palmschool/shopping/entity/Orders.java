package com.guotop.palmschool.shopping.entity;

/**
 * 订单实体类
 * 
 * @author jfy
 * @date 2016年1月8日
 */
public class Orders
{
	private Integer id;
	// 物品详情ID
	private int goodsDetailId;
	// 总额
	private String amount;
	// 数量
	private int counts;
	// 收货人
	private String receiver;
	// 收货地址
	private String address;
	// 联系人电话
	private String phone;
	// 创建时间
	private String createTime;
	// 状态：0待支付 1支付成功 2支付失败 3已寄送
	private int status;
	// 支付渠道：0银联 1支付宝 2微支付 3个人账户
	private Integer channel;
	// 备注
	private String remark;
	// 更新时间
	private String updateTime;
	// 购买人ID
	private int userId;
	// 交易号
	private String tradeNo;
	// 物品名称
	private String goodsName;
	// 物品图片路径
	private String imgPath;
	// 学校名
	private String schoolName;
	// 代理商名
	private String agencyName;
	// 学校ID
	private String schoolId;
	// 1短信套餐 2实物 3充值 4转账 5代购买短信套餐 6购买学校单条套餐 7在线补办卡费用
	private int isVirtual;

	public Integer getChannel() {
		return channel;
	}

	public void setChannel(Integer channel) {
		this.channel = channel;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public int getGoodsDetailId()
	{
		return goodsDetailId;
	}

	public void setGoodsDetailId(int goodsDetailId)
	{
		this.goodsDetailId = goodsDetailId;
	}

	public String getAmount()
	{
		return amount;
	}

	public void setAmount(String amount)
	{
		this.amount = amount;
	}

	public int getCounts()
	{
		return counts;
	}

	public void setCounts(int counts)
	{
		this.counts = counts;
	}

	public String getReceiver()
	{
		return receiver;
	}

	public void setReceiver(String receiver)
	{
		this.receiver = receiver;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public int getStatus()
	{
		return status;
	}

	public void setStatus(int status)
	{
		this.status = status;
	}

	

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
	}

	public int getUserId()
	{
		return userId;
	}

	public void setUserId(int userId)
	{
		this.userId = userId;
	}

	public String getTradeNo()
	{
		return tradeNo;
	}

	public void setTradeNo(String tradeNo)
	{
		this.tradeNo = tradeNo;
	}

	public String getGoodsName()
	{
		return goodsName;
	}

	public void setGoodsName(String goodsName)
	{
		this.goodsName = goodsName;
	}

	public String getImgPath()
	{
		return imgPath;
	}

	public void setImgPath(String imgPath)
	{
		this.imgPath = imgPath;
	}

	public String getSchoolName()
	{
		return schoolName;
	}

	public void setSchoolName(String schoolName)
	{
		this.schoolName = schoolName;
	}

	public String getAgencyName()
	{
		return agencyName;
	}

	public void setAgencyName(String agencyName)
	{
		this.agencyName = agencyName;
	}

	public String getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}

	public int getIsVirtual()
	{
		return isVirtual;
	}

	public void setIsVirtual(int isVirtual)
	{
		this.isVirtual = isVirtual;
	}
	

}
