package com.alipay;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.guotop.palmschool.common.entity.Bill;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.shopping.entity.Orders;
import com.guotop.palmschool.util.StringUtil;

public class AlipayController
{
	private Logger logger = LoggerFactory.getLogger(AlipayController.class);

	/**
	 * 支付宝支付异步通知
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	public Orders notify_Url(String out_trade_no, String trade_no, String total_fee)
	{

		// 判断该笔订单是否在商户网站中已经做过处理
		// 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		// 请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
		// 如果有做过处理，不执行商户的业务程序

		// 注意：
		// 付款完成后，支付宝系统发送该交易状态通知
		Orders reOrders = null;
		try
		{
			if (out_trade_no != null && !out_trade_no.equals(""))
			{
				Integer id = Integer.valueOf(out_trade_no);
				// 查询账款是否一致
				reOrders = StartupListener.ordersService.getOrdersById(id);
				if (Float.valueOf(total_fee).equals(Float.valueOf(reOrders.getAmount())))
				{
					// 更新该订单状态为已付账，且写入交易号及支付渠道
					reOrders.setChannel(1);
					reOrders.setId(Integer.valueOf(out_trade_no));
					reOrders.setTradeNo(trade_no);
					reOrders.setStatus(1);
					StartupListener.ordersService.updateOrders(reOrders);

				} else
				{
					// 更新该订单状态为非全额支付，且写入交易号及支付渠道
					reOrders.setChannel(1);
					reOrders.setId(Integer.valueOf(out_trade_no));
					reOrders.setTradeNo(trade_no);
					reOrders.setStatus(4);
					StartupListener.ordersService.updateOrders(reOrders);
				}
				
				//start 添加自己的账单
				Bill myBill = new Bill();
				myBill.setTypeId(Cons.BILLTYPE_OUT_PURCHASE);
				myBill.setTradeNo(trade_no);
				myBill.setChannel(1);
				myBill.setUserId(reOrders.getUserId());
				myBill.setCounts(1);
				myBill.setAmount(Double.valueOf(total_fee));
				myBill.setPlatformCode(2);
				myBill.setOrderId(out_trade_no);
				myBill.setGoodsId(0);
				myBill.setOtherUserId(0);
				if(!StringUtil.isEmpty(reOrders.getGoodsName()))
				{
					myBill.setGoodsName(reOrders.getGoodsName());
					myBill.setCaption("购买:"+reOrders.getGoodsName());
				}

				// end 添加资源拥有者的账单
				StartupListener.ordersService.addBill(myBill);
				
				List<PushItem> piList = new ArrayList<PushItem>();
				
				// 如果是虚拟物品 则查找对应的学校 然后通过商品名称和学校的短信套餐进行匹配
				// 如果相同则在该学校的短信套餐用户信息表里插入对应的用户信息
				if (reOrders.getIsVirtual() == 1 || reOrders.getIsVirtual() == 5)
				{
					List<User> userList = StartupListener.ordersService.getUserSchoolIdByUserId(reOrders.getUserId());

					for(User user : userList)
					{
						// 根据设备查找数据源
						DBContextHolder.setDBType(user.getSchoolId());
						// 修改学校的短信套餐用户信息表的中的状态为可用状态
						StartupListener.ordersService.updateOrderMessageUserByOrederId(id);

						PushItem pi = new PushItem();
						pi.receiverId = user.getUserId();
						pi.channels = user.getBaiduChannelId();
						pi.deviceType = String.valueOf(user.getDeviceType());
						pi.PushType = 17;
						pi.PushContentType = 4;
						pi.title = "付款成功";
						pi.schoolId = String.valueOf(user.getSchoolId());
						
						if(reOrders.getIsVirtual() == 1)
						{
							pi.PushContent = "您已成功购买" + reOrders.getGoodsName() + "支付：" + reOrders.getAmount() + "元！";
						}
						else
						{
							pi.PushContent = "您已成功代充服务费："+ reOrders.getAmount() + "元！";
							
							List<User> userDetailList = StartupListener.ordersService.getMessageUserDetailByOrderId(id);
							for(User us : userDetailList)
							{
								PushItem pit = new PushItem();
								pit.receiverId = us.getUserId();
								pit.channels = us.getBaiduChannelId();
								pit.deviceType = String.valueOf(us.getDeviceType());
								pit.PushContent = "您好！"+user.getRealName()+"已成功为您代充服务费！";
								pit.PushType = 17;
								pit.PushContentType = 6;
								pit.title = "付款成功";
								pit.schoolId = String.valueOf(user.getSchoolId());
								piList.add(pit);
							}
						}
						piList.add(pi);
						StartupListener.commonService.pushMsg(piList, false);// 消息推送
						
					}
				}else if(reOrders.getIsVirtual() == 6){//6购买学校单条套餐
					//查询出学校
					List<User> userList = StartupListener.ordersService.getUserSchoolIdByUserId(reOrders.getUserId());
					for(User user : userList)
					{
						// 根据设备查找数据源
						DBContextHolder.setDBType(user.getSchoolId());
						// 修改学校的短信套餐学校信息表的中的状态为可用状态
						StartupListener.orderMessageService.updateOrderMessageSchoolByOrederId(id);
						
						PushItem pi = new PushItem();
						pi.receiverId = user.getUserId();
						pi.channels = user.getBaiduChannelId();
						pi.deviceType = String.valueOf(user.getDeviceType());
						pi.PushType = 17;
						pi.PushContentType = 4;
						pi.title = "付款成功";
						pi.schoolId = String.valueOf(user.getSchoolId());
						pi.PushContent = "您已成功购买学校套餐" + reOrders.getGoodsName() + "支付：" + reOrders.getAmount() + "元！";
						piList.add(pi);
						StartupListener.commonService.pushMsg(piList, false);// 消息推送
					}
				}

			}
		} catch (Exception ex)
		{
			logger.error("AlipayController_notify_Url:"+ex.getMessage());
		}
		return reOrders;
	}
}
