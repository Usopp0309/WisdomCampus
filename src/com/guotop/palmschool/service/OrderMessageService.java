package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.OrderMessage;
import com.guotop.palmschool.entity.OrderMessageCardDeposit;
import com.guotop.palmschool.entity.OrderMessageClazz;
import com.guotop.palmschool.entity.OrderMessageSchool;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.OrderUserMessageDetail;
import com.guotop.palmschool.util.Pages;

/**
 * 设备业务类接口
 *
 */
public interface OrderMessageService {

	/**
	 * 加载所有短信套餐List 分页
	 * 
	 * @param pageSize
	 * @param currentPage
	 * @param paramMap
	 * @return
	 */
	public Pages<?> getAllMessageList(int pageSize, int page, Map<String, Object> paramMap);

	/**
	 * 获取短信套餐(不管套餐状态，因为套餐状态仅仅是用于是否能够在购买页面显示)
	 */
	public List<OrderMessage> getProduct();

	public List<OrderMessage>  getAllProduct();
	/**
	 * 根据用户Id获取对应的电话号码
	 */
	public String getUserPhoneByUserId(Integer userId);

	/**
	 * 根据状态获取短信套餐list
	 * 
	 * @param status
	 *            0:是 1:否
	 * @param rangeObject
	 *            套餐范围0:学校,1:个人
	 * @return
	 */
	public List<OrderMessage> getMessageListByStatus(Map<String, Object> map);

	/**
	 * 根据状态获取短信套餐list （手机端）
	 * 
	 * @param status
	 *            0:是 1:否
	 * @param rangeObject
	 *            套餐范围0:学校,1:个人
	 * @return
	 */
	public List<OrderMessage> getMessageListByStatusForApp(Map<String, Object> map);

	/**
	 * 根据id查找短信套餐
	 */
	public OrderMessage getMessageById(int id);

	/**
	 * 根据userId和状态查找用户套餐使用情况
	 * 
	 * @param paramMap
	 * @return
	 */
	public OrderMessageUser getOrderMessageUserByUserId(Map<String, Object> paramMap);

	/**
	 * 根据userId和状态查找用户购买卡押金
	 * 
	 * @param paramMap
	 * @return
	 */
	public OrderMessageCardDeposit getOrderMessageDepositByUserId(Map<String, Object> paramMap);

	/**
	 * 获得短信套餐表的数量
	 * 
	 * @author chenyong
	 * @date 2016年10月9日 下午5:37:34
	 * @return
	 */
	public Integer getPalmOrderMessageCount();

	/**
	 * 获得购买服务的学生人数
	 * 
	 * @author chenyong
	 * @date 2016年10月10日 上午11:20:51
	 * @return
	 */
	public Integer getOrderMessgeYesOrNo();

	/**
	 * 根据messageId获得购买或者免购买该套餐的学生人数
	 * @param messageId 套餐表主键
	 * @param type 0:已经购买人数  1:免购买人数
	 * @return
	 */
	public Integer getOrderMessgeFreeOrAlreadyPayCountByMessageId(Integer messageId,Integer type);
	
	/**
	 * 根据messageId获取服务费设置的学生总人数
	 * @param messageId
	 * @return
	 */
	public Integer getOrderMessageCountByMessageId(Integer messageId);
	
	/**
	 * 增加短信套餐
	 * 
	 * @param orderMessage
	 */
	public Integer addOrderMessage(OrderMessage orderMessage);

	/**
	 * 根据id修改短信套餐
	 * 
	 * @param orderMessage
	 */
	public void modifyMessageById(OrderMessage orderMessage);

	/**
	 * 更新服务费状态
	 */
	public void updateVirtualMessage(String status);

	/**
	 * 获取虚拟服务费状态
	 */
	public String getVirtualMessageStatus();

	/**
	 * 获取本校的定时服务费催缴通知是否开启
	 * 
	 * @return '0开启 1关闭'
	 */
	public Integer getOrderMessagePaymentNoticeStatus();

	/**
	 * 更新定时服务费催缴通知状态
	 * 
	 * @param status
	 */
	public void updateOrderMessagePaymentNoticeStatus(Integer status);

	/**
	 * 删除短信套餐
	 * 
	 * @param id
	 */
	public void deleteOrderMessage();

	/**
	 * 在学校的短信套餐学校信息表里插入对应的用户信息
	 */
	public void saveOrderMessageSchool(OrderMessageSchool orderMessageSchool);

	/**
	 * 修改学校的短信套餐学校信息表的中的状态为可用状态
	 */
	public void updateOrderMessageSchoolByOrederId(Integer orderId);

	/**
	 * 查询出购买学校范围的条数套餐余量
	 * 
	 * @return
	 */
	public Integer getRemainCountBySchoolIdForSchoolRange(String schoolId);

	/**
	 * 更新学校剩余条数
	 * 
	 * @param schoolId
	 */
	public void updateOrderMessageSchoolById(String schoolId);

	/**
	 * 获取学校购买的条数套餐
	 * 
	 * @param schoolId
	 * @return
	 */
	public List<OrderMessageSchool> getOrderMessageSchoolBySchoolId(String schoolId);

	/**
	 * 添加套餐和年级对应的关系
	 * 
	 * @param orderMessageClazz
	 */
	public void addOrderMessageClazz(OrderMessageClazz orderMessageClazz);

	/**
	 * 根据orderMessageId删除
	 * 
	 * @param paramMap
	 * @return
	 */
	public void deleteMessageGradeByOrderMessageId(Integer orderMessageId);

	/**
	 * 删除班级和短信套餐的关系
	 */
	public void deleteMessageClazz();

	/**
	 * 根据套餐id获取对应的班级
	 * 
	 * @return
	 */
	public List<OrderMessageClazz> getSelectedClazzListByOrderMessageId(Integer orderMessageId);

	/**
	 * 根据班级id和短信id orderMessageId获取信息
	 * 
	 * @param parem
	 * @return
	 */
	public OrderMessageClazz getMessageClazzByClazzIdAndOrderMessageId(Map<String, Object> paramMap);

	/**
	 * 获取学校类型的短信套餐
	 * 
	 * @return
	 */
	public List<OrderMessage> getMessageListByStatusAndRangeObject(int status, int rangeObject);
	/**
	 * 所有班级的套餐
	 * @author chenyong
	 * @Time 2017年4月19日 下午12:25:44
	 */
	public List<OrderMessage> getAllOrderMessageClazz();

	/**
	 * 根据班级ID获取对应的短信套餐（家长购买时使用）
	 * 
	 * @param map
	 * @return
	 */
	public List<OrderMessage> getMessageListByClazzIdForParent(Map<String, Object> map);

	/**
	 * 更新用户购买套餐数量
	 * 
	 * @param paramMap
	 */
	public void updateOrederMessageUserCount(Map<String, Object> paramMap);

	/**
	 * 添加服务费用户详情
	 * 
	 * @param messDetail
	 */
	public void addOrderUserMessageDetail(OrderUserMessageDetail messDetail);
	/**
	 * 根据学生UserId集合获得卡押金信息
	 * @author chenyong
	 * @Time 2017年3月24日 下午6:51:31
	 */
	public  List<OrderMessageCardDeposit> getOrderMessageUserDepositByUserIds(List<Integer> studentUserId);
	/**
	 * 设置学校服务费缴费方式
	 * @author chenyong
	 * @Time 2017年3月25日 下午2:34:41
	 */
	public void updateSchoolPay(Integer status);
	/**
	 * 获得学校的服务费缴费方式
	 * @author chenyong
	 * @Time 2017年3月25日 下午2:47:04
	 */
	public Integer getOrderMessagePay();
	/**
	 * 添加用户卡押金支付记录
	 * @author chenyong
	 * @Time 2017年3月25日 下午6:05:35
	 */
	public void saveOrderMessageCardDeposit(OrderMessageCardDeposit orderMessageCardDeposit);
	/**
	 * 根据订单获得卡押金支付情况
	 * @author chenyong
	 * @Time 2017年3月31日 下午6:32:26
	 */
	public OrderMessageCardDeposit getOrderMessageCardDepositByOrderId(Integer orderId);
	/**
	 * 根据订单获得服务费购买情况
	 * @author chenyong
	 * @Time 2017年3月31日 下午6:32:28
	 */
	public OrderMessageUser getOrderMessageUserByOrderId(Integer orderId);
	/**
	 * 根据学生Id获得卡押金支付情况
	 * @author chenyong
	 * @Time 2017年4月1日 下午1:29:47
	 */
	public List<OrderMessageCardDeposit> getOrderMessageCardDepositByStudengIds(List<Integer> studengIds);
	/**
	 * 根据学生Id获得服务费购买情况
	 * @author chenyong
	 * @Time 2017年4月1日 下午1:29:44
	 */
	public List<OrderMessageUser> getOrderMessageUserByStudengIds(List<Integer> studengIds);
	/**
	 * 请好友代付，重新下单，更新原有的订单
	 * @author chenyong
	 * @Time 2017年4月14日 下午1:37:05
	 */
	public void updateOrderIdByOrderId(Map<String,Integer> map);
}