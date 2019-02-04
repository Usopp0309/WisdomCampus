package com.guotop.palmschool.service;

import com.guotop.palmschool.common.entity.Bill;
import com.guotop.palmschool.entity.UserAccount;
import com.guotop.palmschool.entity.UserAccountHistory;

/**
 * 个人账户接口
 *
 */
public interface UserAccountService
{

	/**
	 * 添加个人账户
	 * 
	 * @param userAccount
	 */
	public void addUserAccount(UserAccount userAccount);

	/**
	 * 添加个人账户 消费历史纪录
	 * 
	 * @param userAccountHistory
	 */
	public void addUserAccountHistory(UserAccountHistory userAccountHistory);

	/**
	 * 更新个人账户
	 * 
	 * @param userAccount
	 */
	public void updateUserAccount(UserAccount userAccount);

	/**
	 * 通过userId 获取个人账户详情
	 * 
	 * @param userId
	 * @return
	 */
	public UserAccount findUserAccountByUserId(Integer userId);
	/**
	 * 根据用户ID及密码查找用户数量，用于校验支付
	 * @param userId
	 * @param passWord
	 * @return
	 */
	public int getUserAccountCountByUserIdAndPassWord(Integer userId, String passWord);
	
	/**
	 * 删除账户
	 * @param userId
	 */
	public void delUserAccount(Integer userId);
	
	/**
	 * 退款
	 */
	public void refund(UserAccount ua,UserAccountHistory uah,Bill bill);
}
