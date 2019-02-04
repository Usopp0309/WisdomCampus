package com.guotop.palmschool.service.impl;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.common.entity.Bill;
import com.guotop.palmschool.entity.UserAccount;
import com.guotop.palmschool.entity.UserAccountHistory;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.UserAccountService;
import com.guotop.palmschool.shopping.service.OrdersService;

/**
 * 个人账户接口
 *
 */
@Service("userAccountService")
public class UserAccountServiceImpl extends BaseService implements UserAccountService
{
	
	@Resource
	private OrdersService ordersService;
	
	public void addUserAccount(UserAccount userAccount)
	{
		getBaseDao().addObject("UserAccount.addUserAccount", userAccount);
	}

	public void addUserAccountHistory(UserAccountHistory userAccountHistory)
	{
		getBaseDao().addObject("UserAccountHistory.addUserAccountHistory", userAccountHistory);
	}

	public void updateUserAccount(UserAccount userAccount)
	{
		getBaseDao().updateObject("UserAccount.updateUserAccount", userAccount);
	}

	public UserAccount findUserAccountByUserId(Integer userId)
	{
		return (UserAccount) getBaseDao().selectObjectByObject("UserAccount.getUserAccount", userId);
	}

	@Override
	public int getUserAccountCountByUserIdAndPassWord(Integer userId, String passWord)
	{
		// TODO Auto-generated method stub
		HashMap<String,  Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("passWord", passWord);
		return (int)getBaseDao().selectObjectByObject("UserAccount.getUserAccountCountByUserIdAndPassWord", paramMap);
	}

	@Override
	public void delUserAccount(Integer userId)
	{
		getBaseDao().deleteObject("UserAccount.delUserAccount", userId);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void refund(UserAccount ua,UserAccountHistory uah, Bill bill)
	{
		updateUserAccount(ua);
		addUserAccountHistory(uah);
		ordersService.addBill(bill);
	}
}
