package com.guotop.palmschool.entity;

/**
 * 购买卡押金记录
 * 
 * @author chenyong
 *
 */
public class OrderMessageCardDeposit {
	private Integer id;
	/**
	 * 商品名称
	 */
	private String name;
	/**
	 * 用户名
	 */
	private String realName;

	private Integer userId;

	private String createTime;

	private String updateTime;

	private Integer orderId;
	
	
	private Double cardPrice;
	
	/**
	 * 卡数量
	 */
	private Integer count;
	
	/**
	 * 状态 0可用 1不可用
	 */
	private Integer status;

	/**
	 * 对应的套餐id
	 */
	private Integer messageId;
	/**
	 * 代充人Id
	 */
	private Integer replaceUserId;
	/**
	 * 代充人姓名
	 */
	private String replaceRealName;
	/**
	 * 家庭id
	 */
	private String familyId;

	public Double getCardPrice() {
		return cardPrice;
	}

	public void setCardPrice(Double cardPrice) {
		this.cardPrice = cardPrice;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getMessageId() {
		return messageId;
	}

	public void setMessageId(Integer messageId) {
		this.messageId = messageId;
	}

	public Integer getReplaceUserId() {
		return replaceUserId;
	}

	public void setReplaceUserId(Integer replaceUserId) {
		this.replaceUserId = replaceUserId;
	}

	public String getReplaceRealName() {
		return replaceRealName;
	}

	public void setReplaceRealName(String replaceRealName) {
		this.replaceRealName = replaceRealName;
	}

	public String getFamilyId() {
		return familyId;
	}

	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

}
