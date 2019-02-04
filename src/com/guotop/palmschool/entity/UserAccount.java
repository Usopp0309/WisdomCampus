package com.guotop.palmschool.entity;

public class UserAccount{

	/**
	 * 用户ID
	 */
	private int userId;
	/**
	 * 账户余额
	 */
	private String balance;
	/**
	 * 创建时间
	 */
	private String createTime;
	/**
	 * 禁用时间
	 */
	private String endTime;
	/**
	 * 是否短信验证 0启用1禁用
	 */
	private int isSmsValidate;
	/**
	 * 支取密码
	 */
	private String password;
	/**
	 * 状态 0启用 1禁用
	 */
	private int status;
	/**
	 * 更新时间
	 */
	private String updateTime;
	
	/**
	 * 提现金额
	 */
	private String applyBalance;
	
	public UserAccount() {
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getBalance() {
		return this.balance;
	}

	public void setBalance(String balance) {
		this.balance = balance;
	}

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getIsSmsValidate() {
		return this.isSmsValidate;
	}

	public void setIsSmsValidate(int isSmsValidate) {
		this.isSmsValidate = isSmsValidate;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getApplyBalance()
	{
		return applyBalance;
	}

	public void setApplyBalance(String applyBalance)
	{
		this.applyBalance = applyBalance;
	}

}