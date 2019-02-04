package com.guotop.palmschool.tencent.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.common.entity.Bill;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.shopping.entity.Goods;
import com.guotop.palmschool.shopping.entity.Orders;
import com.guotop.palmschool.shopping.service.OrdersService;
import com.guotop.palmschool.shopping.service.ShoppingService;
import com.guotop.palmschool.tencent.service.UnifiedOrderService;
import com.guotop.palmschool.tencent.service.impl.UnifiedOrderServiceImpl;
import com.guotop.palmschool.util.StringUtil;
import com.tencent.common.XMLParser;
import com.tencent.protocol.unifiedorder.UnifiedOrderReqData;

@RequestMapping("/wcPayController")
@Controller
public class WcPayController extends BaseController
{
	@Resource
	private OrdersService ordersService;
	@Resource
	private ShoppingService shoppingService;
	
	private Logger log = LoggerFactory.getLogger(WcPayController.class); 
	/**
	 * 微信下单
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/getUnifiedOrders.do")
	public String getUnifiedOrders(HttpServletRequest request, HttpServletResponse response, HttpSession session,ModelMap modelMap)
	{
		int port = request.getServerPort();
		UnifiedOrderService unifiedOrderService = null;
		try
		{
			unifiedOrderService = new UnifiedOrderServiceImpl();
			String orderId = request.getParameter("WIDout_trade_no");
			Orders orders = ordersService.getOrdersById(Integer.valueOf(orderId));
			int goodsDetailId = orders.getGoodsDetailId();
			Goods goods = shoppingService.getGoodsByDetailId(goodsDetailId);

			try
			{
				String goodsName = "";
				if(goods != null)
				{
					goodsName = goods.getName();
				}
				else if(goodsDetailId==0 && StringUtil.isEmpty(goodsName))
				{
					goodsName = orders.getGoodsName();
				}
				UnifiedOrderReqData unifiedOrderReqData = new UnifiedOrderReqData(goodsName, "", String.valueOf(orders.getId()), (int)(Float.valueOf(orders.getAmount()) * 100), "WEB",
						"121.199.27.191", "NATIVE", Cons.CALLBACKURL.WC_NOTIFY_URL.getBasePathURL(port), String.valueOf(goodsDetailId));
				String responseString = unifiedOrderService.request(unifiedOrderReqData);
				Map<String, Object> map = XMLParser.getMapFromXML(responseString);
				String return_code = (String) map.get("return_code");
				String result_code = (String) map.get("result_code");
				if (return_code != null && return_code.equals("SUCCESS") && result_code != null && result_code.equals("SUCCESS"))
				{
					String code_url = (String) map.get("code_url");
					modelMap.addAttribute("code_url", code_url);
				}
			} catch (Exception e)
			{
				log.error("微信统一下单出错，错误信息如下："+ e.getMessage());
			}
			return "tencent/wcpayapi";
		} catch (Exception e1)
		{
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		return null;
	}
	/**
	 * 异步回调方法
	 * @return
	 */
	@RequestMapping(value="/notify_Url.do")
	public String notifyUrl(HttpServletRequest request, HttpServletResponse response)
	{
		ByteArrayOutputStream outStream = null;
		InputStream inStream = null;
		try
		{
			inStream = request.getInputStream();
			outStream = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int len = 0;
			while((len = inStream.read(buffer)) != -1)
			{
				outStream.write(buffer, 0 , len);
			}
			String result = new String(outStream.toByteArray(), "utf-8");
			Map<String, Object> map = XMLParser.getMapFromXML(result);
			if (map.get("return_code").toString().equalsIgnoreCase("SUCCESS") && map.get("result_code").toString().equalsIgnoreCase("SUCCESS"))//支付成功
			{
				response.setContentType("text/xml");
				response.getWriter().write(setXML("SUCCESS","OK"));//告知微信服务器，已收到信息，避免微信服务器重复通知
				Float totalAmount = Float.valueOf((String)map.get("total_fee"))/100l;
				String trade_no = (String)map.get("transaction_id");
				String out_trade_no = (String)map.get("out_trade_no");
				Orders reOrders = null;
				if (out_trade_no != null && !out_trade_no.equals(""))
				{
					Integer id = Integer.valueOf(out_trade_no);
					// 查询账款是否一致
					reOrders = StartupListener.ordersService.getOrdersById(id);
					if (totalAmount.equals(Float.valueOf(reOrders.getAmount())))
					{
						// 更新该订单状态为已付账，且写入交易号及支付渠道
						reOrders.setChannel(2);
						reOrders.setId(Integer.valueOf(out_trade_no));
						reOrders.setTradeNo(trade_no);
						reOrders.setStatus(1);
						StartupListener.ordersService.updateOrders(reOrders);
					} else
					{
						// 更新该订单状态为非全额支付，且写入交易号及支付渠道
						reOrders.setChannel(2);
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
					myBill.setAmount(Double.valueOf(reOrders.getAmount()));
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
					//如果是虚拟物品 则查找对应的学校  然后通过商品名称和学校的短信套餐进行匹配  如果相同则在该学校的短信套餐用户信息表里插入对应的用户信息
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
			}
		} catch (IOException e)
		{
			//TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e)
		{
			e.printStackTrace();
		}finally
		{
			try
			{
				if (outStream != null)
				{
					outStream.close();
				}
				if (inStream != null)
				{
					inStream.close();
				}
				
			} catch (IOException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
		return null;
	}
	/**
	 * 封装回复微信xml文件
	 * @param return_code
	 * @param return_msg
	 * @return
	 */
	private String setXML(String return_code, String return_msg)
	{
		return "<xml><return_code><![CDATA[" + return_code
				+ "]]></return_code><return_msg><![CDATA[" + return_msg
				+ "]]></return_msg></xml>";
	}
}
