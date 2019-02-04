package com.guotop.palmschool.shopping.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.entity.Bill;
import com.guotop.palmschool.common.entity.SmsMT;
import com.guotop.palmschool.entity.OrderMessage;
import com.guotop.palmschool.entity.OrderMessageCardDeposit;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.shopping.entity.Orders;
import com.guotop.palmschool.shopping.service.OrdersService;
import com.guotop.palmschool.util.Pages;
/**
 * 订单接口实现
 * @author jfy
 * @date 2016年1月8日
 */
@Service("ordersService")
public class OrdersServiceImpl extends BaseService implements OrdersService
{

	@Override
	public int addOrders(Orders orders)
	{
		return getBaseDao().addObject("Orders.addOrders", orders);
		
	}

	@Override
	public void updateOrders(Orders orders)
	{
		getBaseDao().updateObject("Orders.updateOrders", orders);
		
	}

	@Override
	public Orders getOrdersById(Integer id)
	{
		
		return (Orders)getBaseDao().selectObject("Orders.getInfoById", id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pages getOrdersList(int page,int pageSize,HashMap<String,Object> params)
	{
		int allRow = (Integer) this.getBaseDao().selectObjectByObject("Orders.getOrdersCountList", params);
		int totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		params.put("startIndex", offset);
		// 单页数据量
		params.put("length", length);
		List<Orders> list = getBaseDao().selectListByObject("Orders.getOrdersList", params);

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
		
	}

	@Override
	public void sendSms(String content, String phone)
	{
		// 对sms_mt进行插入操作
		SmsMT smsMt = new SmsMT();
		smsMt.setDestAddr(phone);
		smsMt.setMessage(content);
		smsMt.setOrgId(10001);
		smsMt.setSendUserId(0);

		Date date = new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		smsMt.setCreateTime(timestamp);
		smsMt.setPresendTime(timestamp);
		try
		{
			getBaseDao().addObject("SmsMT.addSmsMt", smsMt);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Orders> getSelfOrdersList(HashMap<String, Object> params)
	{
		// TODO Auto-generated method stub
		return getBaseDao().selectListByObject("Orders.getSelfOrdersList", params);
	}

	@Override
	public void deleteOrders(int orderId)
	{
		getBaseDao().deleteObject("Orders.deleteOrders", orderId);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Orders> getFinancialStatementsList(HashMap<String, Object> param)
	{
		List<Orders> list = new ArrayList<Orders>();
		if (((String)param.get("agency")) != null && ((String)param.get("agency")).equals("0"))
		{
			list = getBaseDao().selectListByObject("Orders.getAgencyFinancialStatementsList", param);
		}else
		{
			list = getBaseDao().selectListByObject("Orders.getSelfFinancialStatementsList", param);
		}
		// TODO Auto-generated method stub
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Orders> getFinancialStatementsDetailListBySchoolId(HashMap<String, Object> param)
	{
		return getBaseDao().selectListByObject("Orders.getFinancialStatementsDetailListBySchoolId", param);
	}
	
	
	/**
	 * 根据购买人的Id 查询其对应的学校Id
	 * @param userId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> getUserSchoolIdByUserId(int userId)
	{
		return (List<User>) getBaseDao().selectList("User.getSchoolIdByUserId", userId);
		
	}
	
	/**
	 * 根据商品名称查询对应的短信套餐
	 * @param goodsName
	 * @return
	 */
	public OrderMessage getOrderMessageByName(String goodsName)
	{
		return (OrderMessage)getBaseDao().selectObjectByObject("OrderMessage.getOrderMessageByName", goodsName);
	}
	
	/**
	 * 在学校的短信套餐用户信息表里插入对应的用户信息
	 */
	public void saveOrderMessageUser(OrderMessageUser orderMessageUser)
	{
		 getBaseDao().addObject("OrderMessage.saveOrderMessageUser", orderMessageUser);
	}
	
	public void saveOrderMessageUserBATCH(List<OrderMessageUser> orderMessageUserList,List<OrderMessageCardDeposit> orderMessageCardDepositList)
	{
		if(orderMessageUserList!=null && orderMessageUserList.size()>0){
			getBaseDao().addObject("OrderMessage.saveOrderMessageUserBATCH", orderMessageUserList);	
		}
		if(orderMessageCardDepositList!=null && orderMessageCardDepositList.size()>0){
			getBaseDao().addObject("OrderMessage.saveCardDepositBATCH", orderMessageCardDepositList);	
		}
		 
	}
	
	/**
	 * 修改学校的短信套餐用户信息表的中的状态为可用状态
	 */
	public void updateOrderMessageUserByOrederId(Integer orderId)
	{
		getBaseDao().updateObject("OrderMessage.updateOrderMessageUserByOrederId", orderId);
		getBaseDao().updateObject("OrderMessage.updateOrderMessagedepositByOrederId", orderId);
	}

	
	public int addBill(Bill bill)
	{
		return (int) this.getBaseDao().addObject("Bill.addBill", bill);
	}
	
	@SuppressWarnings("unchecked")
	public List<Bill> getBillListByUserId(Integer userId)
	{
		return (List<Bill>) getBaseDao().selectList("Bill.selectBillListByUserId", userId);
	}

	/**
	 * 根据orderId  获取被代充人的信息
	 * @param orderId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> getMessageUserDetailByOrderId(Integer orderId)
	{
		return (List<User>) getBaseDao().selectList("OrderMessage.getMessageUserDetailByOrderId", orderId);
	}
}
