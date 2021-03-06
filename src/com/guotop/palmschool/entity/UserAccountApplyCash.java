package com.guotop.palmschool.entity;

import java.util.List;

import com.guotop.palmschool.common.entity.Bill;

/**
 * 提现申请表
 * @author Administrator
 *
 */
public class UserAccountApplyCash
{
	
	private int applyId;

	private Integer userId;

	private String userName;
	
	//申请提现金额
	private Double applyCash;
	
	//提现的第三方账号
	private String thirdAccount;
	
	//第三方账号类型 1支付宝 2微支付
	private Integer thirdType;
	
	//处理状态：0,待处理 1，待付款 2，提现成功 3，提现失败 4，驳回
	private Integer applyStatus;
	
	private String createTime;

	private String updateTime;
	
	private String dealDesc;
	
	private String userInfo;
	private User user;

	//账单列表
	private List<Bill> billList;
	public int getApplyId()
	{
		return applyId;
	}

	public void setApplyId(int applyId)
	{
		this.applyId = applyId;
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

	public Double getApplyCash()
	{
		return applyCash;
	}

	public void setApplyCash(Double applyCash)
	{
		this.applyCash = applyCash;
	}

	public String getThirdAccount()
	{
		return thirdAccount;
	}

	public void setThirdAccount(String thirdAccount)
	{
		this.thirdAccount = thirdAccount;
	}

	public Integer getThirdType()
	{
		return thirdType;
	}

	public void setThirdType(Integer thirdType)
	{
		this.thirdType = thirdType;
	}

	public Integer getApplyStatus()
	{
		return applyStatus;
	}

	public void setApplyStatus(Integer applyStatus)
	{
		this.applyStatus = applyStatus;
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

	public String getDealDesc()
	{
		return dealDesc;
	}

	public void setDealDesc(String dealDesc)
	{
		this.dealDesc = dealDesc;
	}

	public User getUser()
	{
		return user;
	}

	public void setUser(User user)
	{
		this.user = user;
	}

	public String getUserInfo()
	{
		return userInfo;
	}

	public void setUserInfo(String userInfo)
	{
		this.userInfo = userInfo;
	}

	public List<Bill> getBillList()
	{
		return billList;
	}

	public void setBillList(List<Bill> billList)
	{
		this.billList = billList;
	}
	
}