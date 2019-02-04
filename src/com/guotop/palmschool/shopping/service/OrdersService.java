package com.guotop.palmschool.shopping.service;

import java.util.HashMap;
import java.util.List;

import com.guotop.palmschool.common.entity.Bill;
import com.guotop.palmschool.entity.OrderMessage;
import com.guotop.palmschool.entity.OrderMessageCardDeposit;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.shopping.entity.Orders;
import com.guotop.palmschool.util.Pages;

/**
 * 订单接口
 * @author jfy
 * @date 2016年1月8日
 */
public interface OrdersService
{
	/**
	 * 添加订单
	 * @param orders
	 */	
	public int addOrders(Orders orders);
	/**
	 * 修改订单支付状态
	 * @param orders
	 */
	public void updateOrders(Orders orders);
	/**
	 * 根据id获取订单信息
	 * @param id
	 * @return
	 */
	public Orders getOrdersById(Integer id);
	/**
	 * 获取订单列表
	 * @param params
	 * @return
	 */
	public Pages getOrdersList(int page,int pageSize,HashMap<String,Object> params);
	/**
	 * 发送短信通知用户
	 * @param content
	 * @param phone
	 */
	public void sendSms(String content,String phone);
	/**
	 * 获取个人订单列表
	 * @param params
	 * @return
	 */
	public List<Orders> getSelfOrdersList(HashMap<String,Object> params);
	/**
	 * 删除订单
	 * @param orderId
	 */
	public void deleteOrders(int orderId);
	/**
	 * 获取财务报表
	 * @param param
	 * @return
	 */
	public List<Orders> getFinancialStatementsList(HashMap<String, Object> param);
	/**
	 * 根据学校ID获取学校消费详情
	 * @param schoolId
	 * @return
	 */
	public List<Orders> getFinancialStatementsDetailListBySchoolId(HashMap<String, Object> param);
	
	/**
	 * 根据购买人的Id 查询其对应的学校Id
	 * @param userId
	 * @return
	 */
	public List<User> getUserSchoolIdByUserId(int userId);
	
	/**
	 * 根据商品名称查询对应的短信套餐
	 * @param goodsName
	 * @return
	 */
	public OrderMessage getOrderMessageByName(String goodsName);
	
	/**
	 * 在学校的短信套餐用户信息表里插入对应的用户信息
	 */
	public void saveOrderMessageUser(OrderMessageUser orderMessageUser);
	
	/**
	 * 批量在学校的短信套餐用户信息表里插入对应的用户信息
	 */
	public void saveOrderMessageUserBATCH(List<OrderMessageUser> orderMessageUserList,List<OrderMessageCardDeposit> orderMessageCardDepositList);
	
	/**
	 * 修改学校的短信套餐用户信息表的中的状态为可用状态
	 */
	public void updateOrderMessageUserByOrederId(Integer orderId);
	
	/**
	 * 添加账单
	 * @param bill
	 * @return
	 */
	public int addBill(Bill bill);
	
	/**
	 * 获取个人的账单列表
	 * @param userId
	 * @return
	 */
	public List<Bill> getBillListByUserId(Integer userId);
	
	/**
	 * 根据orderId  获取被代充人的信息
	 * @param orderId
	 * @return
	 */
	public List<User> getMessageUserDetailByOrderId(Integer orderId);
}
