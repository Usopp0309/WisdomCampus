package com.guotop.palmschool.replacerecharge.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.OrderMessage;
import com.guotop.palmschool.entity.OrderMessageCardDeposit;
import com.guotop.palmschool.entity.OrderMessageClazz;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.replacerecharge.service.ReplaceRechargeService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.shopping.entity.Orders;
import com.guotop.palmschool.shopping.service.OrdersService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.PreciseCompute;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 代充值短信套餐控制类 (智慧校园服务 )
 *
 */
@RequestMapping("/replaceRecharge")
@Controller
public class ReplaceRechargeController extends BaseController
{

	private Logger log = LoggerFactory.getLogger(ReplaceRechargeController.class);

	@Resource
	private OrderMessageService orderMessageService;

	@Resource
	private OrdersService ordersService;

	@Resource
	private UserService userService;

	@Resource
	private ReplaceRechargeService replaceRechargeService;

	@Resource
	private CommonService commonService;

	@Resource
	private ClazzService clazzService;

	/**
	 * 进入代充短信套餐页面
	 */
	@RequestMapping(value = "/toReplaceRecharge.do")
	public String toReplaceRecharge(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");
		// 学校服务费缴费方式 0：学校统一缴费 1：线上缴费, 0时：所有学生家长显示所有服务费已购买
		Integer status = orderMessageService.getOrderMessagePay();
		modelMap.addAttribute("status", status);
		modelMap.addAttribute("schoolId", user.getSchoolId());
		return "replacerecharge/replace_recharge";
	}

	/**
	 * 进入代充短信套餐页面
	 */
	@RequestMapping(value = "/loadReplaceRecharge.do")
	public String loadReplaceRecharge(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		try
		{
			User user = (User) session.getAttribute("user");

			String roleCode = request.getParameter("roleCode");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("status", 0);
			map.put("rangeObject", 1);
			map.put("roleCode", roleCode);
			map.put("user", user);
			map.put("userId", user.getUserId());
			map.put("schoolId", user.getSchoolId());
			map.put("permissionCode", "replaceRechargeManager");

			// 查询出服务范围是个人的套餐
			List<OrderMessage> messageList = orderMessageService.getMessageListByStatus(map);
			for (OrderMessage orderMessage : messageList)
			{
				if ("3509020027".equals(user.getSchoolId()) || "3201140009".equals(user.getSchoolId()))
				{
					if (!StringUtil.isEmpty(orderMessage.getStartTime()))
					{
						orderMessage.setStartTime(formatter.format(formatter.parse(orderMessage.getStartTime())));
					}
					if (!StringUtil.isEmpty(orderMessage.getEndTime()))
					{
						orderMessage.setEndTime(formatter.format(formatter.parse(orderMessage.getEndTime())) + "学年");
					}
				}
			}
			Gson gson = new Gson();
			String json = gson.toJson(messageList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据班主任和家长所在班级的Id查询对应的学生
	 */
	@RequestMapping(value = "/loadStudentByClazzId.do")
	public String loadStudentByClazzId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{

			User user = (User) session.getAttribute("user");
			String roleCode = request.getParameter("roleCode");
			String content = request.getParameter("content");
			Integer orderMessageId = StringUtil.toint(request.getParameter("orderMessageId"));
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			Map<Integer,Integer> mapOmd=new HashMap<>();//存放已支付卡押金的 Key:学生Id
			paramMap.put("user",user);
			paramMap.put("userId",user.getUserId());
			paramMap.put("roleCode",roleCode);
			paramMap.put("content",content);
			paramMap.put("orderMessageId",orderMessageId);
			paramMap.put("schoolId",user.getSchoolId());
			List<User> userList = replaceRechargeService.getStudentListByParam(paramMap, "replaceRechargeManager");
			OrderMessage mess = orderMessageService.getMessageById(orderMessageId);
			List<User> list3=new ArrayList<>();
			if(userList!=null && userList.size()>0){
				List<Integer> list1=new ArrayList<>();
				for (User u : userList) {
					list1.add(u.getUserId());
				}
				List<User> list2=userService.getParentIsTeacher(list1);
				Map<Integer,Integer> map1=new HashMap<>();
				if(list2!=null && list2.size()>0){
					for (User user2 : list2) {
						map1.put(user2.getStudentId(), user2.getUserId());
					}
					
				}
				List<OrderMessageCardDeposit> omd=orderMessageService.getOrderMessageCardDepositByStudengIds(list1);
				if(!CollectionUtils.isEmpty(omd)){
					for (OrderMessageCardDeposit orderMessageCardDeposit : omd) {
						mapOmd.put(orderMessageCardDeposit.getUserId(), orderMessageCardDeposit.getUserId());
					}
				}
				for (User u : userList) {
					if(mess.getServicePrice()==0 && mess.getCardPrice()==0){
						continue;
					}else if(mess.getServicePrice()>0 && map1.containsKey(u.getUserId()) && (mess.getCardPrice()==0 || mapOmd.containsKey(u.getUserId()))){//教职工子女，免套餐
						continue;
					}else if(mess.getServicePrice()>0 && u.getType()==null){//服务费没有购买
						
					}else if(mess.getCardPrice()>0 && !mapOmd.containsKey(u.getUserId())){//押金没有支付
						
					}
					list3.add(u);
				}
			}else{
				list3=userList;
			}
			Gson gson = new Gson();
			String json = gson.toJson(list3);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入付款页面(PC)
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toOrderMessagePay.do")
	public String toOrderMessagePay(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		try
		{

			User loginUser = (User) session.getAttribute("user");
			Integer productId = StringUtil.toint(request.getParameter("productId"));
			Integer count = StringUtil.toint(request.getParameter("count"));
			Map<String, String> studentMap = GsonHelper.fromJson(request.getParameter("studentList"), Map.class);
			OrderMessage mess = orderMessageService.getMessageById(productId);
			Map<String,Integer> map1=new HashMap<>();//存放含父母是教职工的，Key:学生Id
			Map<String,Integer> mapOmu =new HashMap<>();//存放已购买服务费的 Key:学生Id
			Map<String,Integer> mapOmd=new HashMap<>();//存放已支付卡押金的 Key:学生Id
			List<Integer> studengIds=new ArrayList<>();
			for (Map.Entry<String, String> entry : studentMap.entrySet())
			{
				studengIds.add(Integer.parseInt(entry.getKey()));
			}
			Integer ordersId=null;
			double price=0;
			//下订单,计算服务费，卡押金购买情况
			if(studengIds!=null && studengIds.size()>0){
				List<User> list1=userService.getParentIsTeacher(studengIds);
				if(list1!=null && list1.size()>0){
					for (User u : list1) {
						map1.put(u.getStudentId()+"", u.getUserId());
					}
				}
			}
			List<OrderMessageUser> omu=orderMessageService.getOrderMessageUserByStudengIds(studengIds);
			List<OrderMessageCardDeposit> omd=orderMessageService.getOrderMessageCardDepositByStudengIds(studengIds);
			if(!CollectionUtils.isEmpty(omu)){
				for (OrderMessageUser orderMessageUser : omu) {
					mapOmu.put(orderMessageUser.getUserId()+"", orderMessageUser.getUserId());
				}
			}
			if(!CollectionUtils.isEmpty(omd)){
				for (OrderMessageCardDeposit orderMessageCardDeposit : omd) {
					mapOmd.put(orderMessageCardDeposit.getUserId()+"", orderMessageCardDeposit.getUserId());
				}
			}
			double cardPrice=0;
			double servicePrice=0;
			for (Map.Entry<String, String> entry : studentMap.entrySet()) {
				//计算总卡押金
				if(mess.getCardPrice()>0 && !mapOmd.containsKey(entry.getKey())){
					cardPrice+=mess.getCardPrice();
				}
				//没买服务费，且非教职工子女,map1存放教职工子女
				if(mess.getServicePrice()>0 && !mapOmu.containsKey(loginUser.getUserId()) && !map1.containsKey(entry.getKey())){
					servicePrice+=mess.getServicePrice();
				}
			}
			if (mess.getType() == 0)
			{
				servicePrice = PreciseCompute.mul(servicePrice, 1);
			} else if (mess.getType() == 1)
			{
				
				servicePrice = PreciseCompute.mul(servicePrice,count);
			}
			price=PreciseCompute.add(servicePrice, cardPrice);
			String phone = orderMessageService.getUserPhoneByUserId(loginUser.getUserId());
			Orders orders = new Orders();
			orders.setGoodsName(mess.getName());
			orders.setAmount(String.valueOf(price));
			orders.setCounts(count);
			orders.setReceiver(loginUser.getRealName());
			orders.setPhone(phone);
			orders.setGoodsDetailId(productId);
			orders.setUserId(loginUser.getUserId());
			orders.setCreateTime(TimeUtil.getInstance().now());
			orders.setIsVirtual(5);
			orders.setSchoolId(loginUser.getSchoolId());
			ordersId = ordersService.addOrders(orders);
			if(ordersId!=null){
				List<OrderMessageUser> orderMessageUserList = new ArrayList<OrderMessageUser>();
				List<OrderMessageCardDeposit> orderMessageCardDepositList = new ArrayList<OrderMessageCardDeposit>();
				for (Map.Entry<String, String> entry : studentMap.entrySet())
				{
					if(mess.getServicePrice()>0 && !mapOmu.containsKey(entry.getKey()) && !map1.containsKey(entry.getKey())){
					// 获得的是自1970-1-01 00:00:00.000 到当前时刻的时间距离,类型为long
					long ct = System.currentTimeMillis();
					String currentTime = String.valueOf(ct);
					// 手机端代充的情况下，由于传递过来的是学生Id，先把学生添加到palm_order_message_user表
					OrderMessageUser messUser = new OrderMessageUser();
					messUser.setName(mess.getName());
					messUser.setRealName(entry.getValue());
					messUser.setUserId(Integer.valueOf(entry.getKey()));
					messUser.setStartTime(mess.getStartTime());
					messUser.setEndTime(mess.getEndTime());
					messUser.setType(mess.getType());
					messUser.setCount(count);
					messUser.setCreateTime(TimeUtil.getInstance().now());
					messUser.setOrderId(ordersId);
					messUser.setStatus(1);
					messUser.setMessageId(productId);
					messUser.setReplaceUserId(loginUser.getUserId());
					messUser.setReplaceRealName(loginUser.getRealName());
					messUser.setFamilyId(entry.getKey() + currentTime);
					messUser.setServicePrice(mess.getServicePrice());
					orderMessageUserList.add(messUser);
				   }
					if(mess.getCardPrice()>0 && !mapOmd.containsKey(entry.getKey())){
					OrderMessageCardDeposit deposit=new OrderMessageCardDeposit();
			        long ct = System.currentTimeMillis();
					String currentTime = String.valueOf(ct);
			        deposit.setCreateTime(TimeUtil.getInstance().now());
					deposit.setFamilyId(entry.getKey() + currentTime);
					deposit.setMessageId(productId);
					deposit.setName(mess.getName());
					deposit.setOrderId(ordersId);
					deposit.setCardPrice(mess.getCardPrice());
					deposit.setRealName(entry.getValue());
					deposit.setReplaceUserId(loginUser.getUserId());
					deposit.setReplaceRealName(loginUser.getRealName());
					deposit.setStatus(1);
					deposit.setCount(1);
					deposit.setUpdateTime(TimeUtil.getInstance().now());
					deposit.setUserId(Integer.valueOf(entry.getKey()));
					orderMessageCardDepositList.add(deposit);
					}
				}
				ordersService.saveOrderMessageUserBATCH(orderMessageUserList,orderMessageCardDepositList);	
			}
			modelMap.addAttribute("amount", price);
			modelMap.addAttribute("goodsName", mess.getName());
			modelMap.addAttribute("ordersId", ordersId);
			return "ordermessage/sms_order_pay";
		} catch (JSONException e)
		{
			e.printStackTrace();
		}
		return "ordermessage/sms_order_pay";
	}

	/**
	 * 【手机端】根据userId 和roleCode 获取对应的学生和家长信息
	 */
	@RequestMapping(value = "/getStudentListByApiKey.do")
	public String getStudentListByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Collection<Clazz>> rhr = new RichHttpResponse<Collection<Clazz>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String content = request.getParameter("content");
		Integer orderMessageId = StringUtil.toint(request.getParameter("productId"));
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId",loginUser.getUserId());
				paramMap.put("orderMessageId",orderMessageId);
				paramMap.put("schoolId",schoolId);
				paramMap.put("content",content);
				paramMap.put("permissionCode","replaceRechargeManager");
				
				List<User> userList = replaceRechargeService.getStudentListForApp(paramMap);
				
				Map<Integer, User> userMap = new HashMap<Integer, User>();
				Map<Integer, Clazz> clazzMap = new HashMap<Integer, Clazz>();
				List<Integer> listStudent=new ArrayList<>();
				for (User user : userList)
				{
					listStudent.add(user.getUserId());
				}
				Map<Integer,Integer> map=new HashMap<>();
				Map<Integer,Integer> mapOmd=new HashMap<>();//存放已支付卡押金的 Key:学生Id
				List<OrderMessageCardDeposit> omd=orderMessageService.getOrderMessageCardDepositByStudengIds(listStudent);
				OrderMessage mess = orderMessageService.getMessageById(orderMessageId);
				if(!CollectionUtils.isEmpty(omd)){
					for (OrderMessageCardDeposit orderMessageCardDeposit : omd) {
						mapOmd.put(orderMessageCardDeposit.getUserId(), orderMessageCardDeposit.getUserId());
					}
				}
				if(listStudent!=null && listStudent.size()>0){
				List<User> parentsInfo = userService.getParentIsTeacher(listStudent);
				if(parentsInfo!=null && parentsInfo.size()>0){
					  for (User user : parentsInfo) {
						  map.put(user.getStudentId(),user.getUserId());
					  }	
				}
				  
				}
				for (User user : userList)
				{
					//if(!StringUtil.isEmpty(user.getRealName()) && user.getParentList()!=null && user.getParentList().size()>0){
					Integer userId = user.getUserId();
					if (userMap.containsKey(userId))
					{
						// 学生已经存在的情况下直接下一个循环
						continue;
					} else
					{
						//是教职工子女，免套餐，页面不显示,但是卡押金需要支付
                        if(mess.getServicePrice()==0 && mess.getCardPrice()==0){
                        	 continue;
                        }else if(map.containsKey(user.getUserId()) && mess.getCardPrice()>0 && mapOmd.containsKey(user.getUserId()) ){
                             continue;	
						}else if (mess.getServicePrice()>0 && user.getType()==null)//服务费没有支付
						{
							user.setType(0);// 可选择
							
						}else if(mess.getCardPrice()>0 && !mapOmd.containsKey(user.getUserId())){//卡押金没有支付
							user.setType(0);// 可选择
						}else{
							//user.setType(1);
							//不可选，页面不需要
							continue;
						}
						userMap.put(userId, user);
					}
					Integer clazzId = user.getClazzId();
					if (!clazzMap.containsKey(clazzId))
					{
						Clazz clazz = new Clazz();
						clazz.setClazzId(clazzId);
						clazz.setClazzName(user.getClazzName());
						List<User> studentList = new ArrayList<User>();
						studentList.add(user);
						clazz.setStudentList(studentList);
						clazzMap.put(clazzId, clazz);
					} else
					{
						Clazz clazz = clazzMap.get(clazzId);
						clazz.getStudentList().add(user);
					}
				//}
				}
				Collection<Clazz> clazzList = clazzMap.values();
				List<Clazz> newClazzlist = new ArrayList<Clazz>(clazzList);
				Collections.sort(newClazzlist, new Comparator<Clazz>()
						{
							public int compare(Clazz c1, Clazz c2)
							{
								return c1.getClazzId().compareTo(c2.getClazzId());
							}
						});
				rhr.ResponseCode = 0;
				rhr.ResponseObject = newClazzlist;
				rhr.ResponseResult = "获取成功";
				json = GsonHelper.toJson(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		}
		return null;
	}

//	/**
//	 * TODO IOS和安卓版本更新之后需要删除 【手机端】根据userId 和roleCode 获取对应的学生和家长信息
//	 */
//	@RequestMapping(value = "/getStudentByClazzIdByApiKey.do")
//	public String getStudentByClazzIdByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
//	{
//		response.setCharacterEncoding("UTF-8");
//		response.setContentType("application/json;charset=UTF-8");
//		RichHttpResponse<List<User>> rhr = new RichHttpResponse<List<User>>();
//		String apiKey = request.getParameter("apiKey");
//		String schoolId = request.getParameter("schoolId");
//		try
//		{
//			String json;
//			// 这边是利用apikey 进行模拟登录
//			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
//			if (loginUser != null)
//			{
//				session.setAttribute("user", loginUser);
//				DBContextHolder.setDBType(loginUser.getSchoolId());
//
//				String roleCode = request.getParameter("roleCode");
//				String content = request.getParameter("content");
//				List<User> userList = replaceRechargeService.loadStudentByClazzId(loginUser.getUserId(), roleCode, content, "replaceRechargeManager");
//				for (User user : userList)
//				{
//					if (user.getType() == null)
//					{
//						user.setType(0);// 可选择
//					} else
//					{
//						user.setType(1);
//					}
//				}
//
//				rhr.ResponseCode = 0;
//				rhr.ResponseObject = userList;
//				rhr.ResponseResult = "获取成功";
//				json = GsonHelper.toJsonWithAnnotation(rhr);
//			} else
//			{
//				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
//				rhr.ResponseObject = null;
//				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
//				json = GsonHelper.toJson(rhr);
//			}
//			response.getWriter().write(json);
//			response.getWriter().flush();
//		} catch (IOException e)
//		{
//			log.error("json转换失败：" + e.getMessage());
//		}
//		return null;
//	}

	/**
	 * 【手机端代付下单】进入支付页面
	 */
	@RequestMapping(value = "/toOrderMessagePayByApiKey.do")
	public String toOrderMessagePayByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Map<String, Object>> rhr = new RichHttpResponse<Map<String, Object>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String json=null;
		try
		{
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				Integer productId = StringUtil.toint(request.getParameter("productId"));
				Integer count = StringUtil.toint(request.getParameter("count"));

				String studentListJson = request.getParameter("studentList");
				OrderMessage mess = orderMessageService.getMessageById(productId);
				// 学校服务费缴费方式 0：学校统一缴费 1：线上缴费, 0时：所有学生家长显示所有服务费已购买
				Integer status = orderMessageService.getOrderMessagePay();
				if (status == 0) {
					rhr.ResponseCode = -2;
					rhr.ResponseResult = "由学校统一缴费，不支持线上缴费！";
					json = GsonHelper.toJson(rhr);
					response.getWriter().write(json);
					response.getWriter().flush();
					return null;
				}else if(mess.getCardPrice()<=0 && mess.getServicePrice()<=0){
					rhr.ResponseCode = -2;
					rhr.ResponseResult = "没有需要购买的服务费！";
					json = GsonHelper.toJson(rhr);
					response.getWriter().write(json);
					response.getWriter().flush();
					return null;	
				}
				List<User> studentList = GsonHelper.fromJson(studentListJson, new TypeToken<ArrayList<User>>()
				{
				}.getType());
				Map<Integer,Integer> map1=new HashMap<>();//存放含父母是教职工的，Key:学生Id
				Map<Integer,Integer> mapOmu =new HashMap<>();//存放已购买服务费的 Key:学生Id
				Map<Integer,Integer> mapOmd=new HashMap<>();//存放已支付卡押金的 Key:学生Id
				List<Integer> studengIds=new ArrayList<>();
				Integer ordersId=null;
				double price=0;
				//下订单,计算服务费，卡押金购买情况
				if (!CollectionUtils.isEmpty(studentList))
				{
					for (User user : studentList) {
						studengIds.add(user.getUserId());
					}
					if(studengIds!=null && studengIds.size()>0){
						List<User> list1=userService.getParentIsTeacher(studengIds);
						if(list1!=null && list1.size()>0){
							for (User u : list1) {
								map1.put(u.getStudentId(), u.getUserId());
							}
						}
					}
					List<OrderMessageUser> omu=orderMessageService.getOrderMessageUserByStudengIds(studengIds);
					List<OrderMessageCardDeposit> omd=orderMessageService.getOrderMessageCardDepositByStudengIds(studengIds);
					if(!CollectionUtils.isEmpty(omu)){
						for (OrderMessageUser orderMessageUser : omu) {
							mapOmu.put(orderMessageUser.getUserId(), orderMessageUser.getUserId());
						}
					}
					if(!CollectionUtils.isEmpty(omd)){
						for (OrderMessageCardDeposit orderMessageCardDeposit : omd) {
							mapOmd.put(orderMessageCardDeposit.getUserId(), orderMessageCardDeposit.getUserId());
						}
					}
					double cardPrice=0;
					double servicePrice=0;
					for (User user : studentList) {
						//计算总卡押金
						if(mess.getCardPrice()>0 && !mapOmd.containsKey(user.getUserId())){
							cardPrice+=mess.getCardPrice();
						}
						//没买服务费，且非教职工子女,map1存放教职工子女
						if(mess.getServicePrice()>0 && !mapOmu.containsKey(user.getUserId()) && !map1.containsKey(user.getUserId())){
							servicePrice+=mess.getServicePrice();
						}
					}
					if (mess.getType() == 0)
					{
						servicePrice = PreciseCompute.mul(servicePrice, 1);
					} else if (mess.getType() == 1)
					{
						if(count < 1){
							rhr.ResponseCode = -3;
							rhr.ResponseResult = "购买条数不能小于1";
							json = GsonHelper.toJsonWithAnnotation(rhr);
							response.getWriter().write(json);
							response.getWriter().flush();
							return null; 
						}
						servicePrice = PreciseCompute.mul(servicePrice,count);
					}
					price=PreciseCompute.add(servicePrice, cardPrice);
					String phone = orderMessageService.getUserPhoneByUserId(loginUser.getUserId());
					Orders orders = new Orders();
					orders.setGoodsName(mess.getName());
					orders.setAmount(String.valueOf(price));
					orders.setCounts(count);
					orders.setReceiver(loginUser.getRealName());
					orders.setPhone(phone);
					orders.setGoodsDetailId(productId);
					orders.setUserId(loginUser.getUserId());
					orders.setCreateTime(TimeUtil.getInstance().now());
					orders.setRemark("寻找好友代付");
					orders.setIsVirtual(5);
					orders.setSchoolId(schoolId);
					ordersId = ordersService.addOrders(orders);
				}
				
				if (!CollectionUtils.isEmpty(studentList) && ordersId!=null)
				{
					try{
						List<OrderMessageUser> orderMessageUserList = new ArrayList<OrderMessageUser>();
						List<OrderMessageCardDeposit> orderMessageCardDepositList = new ArrayList<OrderMessageCardDeposit>();
						for (User student : studentList)
						{
							if(mess.getServicePrice()>0 && !mapOmu.containsKey(student.getUserId()) && !map1.containsKey(student.getUserId())){
							// 获得的是自1970-1-01 00:00:00.000 到当前时刻的时间距离,类型为long
							long ct = System.currentTimeMillis();
							String currentTime = String.valueOf(ct);
							// 手机端代充的情况下，由于传递过来的是学生Id，先把学生添加到palm_order_message_user表
							OrderMessageUser messUser = new OrderMessageUser();
							messUser.setName(mess.getName());
							messUser.setRealName(student.getRealName());
							messUser.setUserId(student.getUserId());
							messUser.setStartTime(mess.getStartTime());
							messUser.setEndTime(mess.getEndTime());
							messUser.setType(mess.getType());
							messUser.setCount(count);
							messUser.setCreateTime(TimeUtil.getInstance().now());
							messUser.setOrderId(ordersId);
							messUser.setStatus(1);
							messUser.setMessageId(productId);
							messUser.setReplaceUserId(loginUser.getUserId());
							messUser.setReplaceRealName(loginUser.getRealName());
							messUser.setFamilyId(String.valueOf(student.getUserId()) + currentTime);
							messUser.setServicePrice(mess.getServicePrice());
							orderMessageUserList.add(messUser);
						   }
							if(mess.getCardPrice()>0 && !mapOmd.containsKey(student.getUserId())){
							OrderMessageCardDeposit deposit=new OrderMessageCardDeposit();
					        long ct = System.currentTimeMillis();
							String currentTime = String.valueOf(ct);
					        deposit.setCreateTime(TimeUtil.getInstance().now());
							deposit.setFamilyId(String.valueOf(student.getUserId()) + currentTime);
							deposit.setMessageId(productId);
							deposit.setName(mess.getName());
							deposit.setOrderId(ordersId);
							deposit.setCardPrice(mess.getCardPrice());
							deposit.setRealName(student.getRealName());
							deposit.setReplaceUserId(loginUser.getUserId());
							deposit.setReplaceRealName(loginUser.getRealName());
							deposit.setStatus(1);
							deposit.setCount(1);
							deposit.setUpdateTime(TimeUtil.getInstance().now());
							deposit.setUserId(student.getUserId());
							orderMessageCardDepositList.add(deposit);
							}
						}
						ordersService.saveOrderMessageUserBATCH(orderMessageUserList,orderMessageCardDepositList);
						
					}catch(Exception e){
						log.error("提交订单失败：" + e.getMessage());
						rhr.ResponseCode = -2;
						rhr.ResponseObject = null;
						rhr.ResponseResult = "提交订单失败，请稍后重试";
						json = GsonHelper.toJson(rhr);
						
						response.getWriter().write(json);
						response.getWriter().flush();
						return null;
					}
				}
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("amount", price);
				paramMap.put("goodsName", mess.getName());
				paramMap.put("ordersId", ordersId);

				rhr.ResponseCode = 0;
				rhr.ResponseObject = paramMap;
				rhr.ResponseResult = "获取成功";
				json = GsonHelper.toJsonWithAnnotation(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
		} catch (Exception e)
		{
			rhr.ResponseCode =-2;
			rhr.ResponseObject = null;
			rhr.ResponseResult ="代购服务费下订单失败";
			json = GsonHelper.toJson(rhr);
			log.error("提交订单失败：" + e.getMessage());
		}
		try {
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/********** 服务费设置begin **************/
	/**
	 * 进入服务费列表页面
	 */
	@RequestMapping(value = "/toServiceFeeList.do")
	public String toServiceFeeList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		//获取使用套餐状态
		String virtualstatus = orderMessageService.getVirtualMessageStatus();
		modelMap.addAttribute("status", virtualstatus);
		//获取定时推送服务费缴纳状态
		Integer paymentNoticeStatus = orderMessageService.getOrderMessagePaymentNoticeStatus();
		modelMap.addAttribute("paymentNoticeStatus", paymentNoticeStatus);
		//学校服务费缴费方式
		Integer status=orderMessageService.getOrderMessagePay();
		modelMap.addAttribute("schoolPay", status);
		return "system/service_fee_list";
	}

	/**
	 * 加载所有的短信 分页
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getAllMessageList.do")
	public String getAllMessageList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			/**
			 * 分页信息
			 */
			Integer currentPage = StringUtil.toint(request.getParameter("cPage"));

			/**
			 * 搜索内容
			 */
			String queryContent = request.getParameter("queryContent");

			/**
			 * 类型
			 */
			String type = request.getParameter("type");

			/**
			 * 状态
			 */
			String status = request.getParameter("status");

			User user = (User) session.getAttribute("user");

			/**
			 * 参数
			 */
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("queryContent", queryContent);
			paramMap.put("type", type);
			paramMap.put("status", status);
			paramMap.put("user", user);
			paramMap.put("userId", user.getUserId());

			this.getPages().setPageSize(10);

			Pages<?> pages = orderMessageService.getAllMessageList(this.getPages().getPageSize(), currentPage, paramMap);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 删除短信套餐
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/deleteMessage.do")
	public String deleteMessage(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			boolean flag = false;

			try
			{
				orderMessageService.deleteMessageClazz();
				orderMessageService.deleteOrderMessage();
				flag = true;
			} catch (Exception e)
			{
				flag = false;
				e.printStackTrace();
			}

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入增加短信套餐页面
	 */
	@RequestMapping(value = "/toAddMessage.do")
	public String toAddMessage(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		return "system/service_fee_add";
	}

	/**
	 * 执行增加增加短信套餐逻辑
	 */
	@RequestMapping(value = "/doAddMessage.do")
	public String doAddMessage(HttpServletResponse response, HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");

		/**
		 * 服务范围0:学校,1:个人
		 */
		Integer rangeObject = StringUtil.toint(request.getParameter("rangeObject"));

		/**
		 * 名称
		 */
		String name = request.getParameter("name");

		/**
		 * 服务费
		 */
		String servicePrice = request.getParameter("servicePrice");
		if(StringUtil.isEmpty(servicePrice)){
			servicePrice="0";
		}
		/**
		 * 卡押金
		 */
		String cardPrice = request.getParameter("cardPrice");
		if(StringUtil.isEmpty(cardPrice)){
			cardPrice="0";
		}
		/**
		 * 类型
		 */
		Integer type = StringUtil.toint(request.getParameter("type"));

		/**
		 * 开始日期
		 */
		String startTime = request.getParameter("startTime");

		/**
		 * 结束日期
		 */
		String endTime = request.getParameter("endTime");

		OrderMessage orderMessage = new OrderMessage();
		orderMessage.setName(name);
		orderMessage.setServicePrice(Double.valueOf(servicePrice));
		orderMessage.setCardPrice(Double.valueOf(cardPrice));
		//总费用：卡押金+服务费
		orderMessage.setPrice(PreciseCompute.add(orderMessage.getCardPrice(),orderMessage.getServicePrice()));
		orderMessage.setStatus(0);
		orderMessage.setType(type);
		orderMessage.setRangeObject(rangeObject);
		if (type == 0)
		{
			orderMessage.setStartTime(startTime);
			orderMessage.setEndTime(endTime);
		}
		orderMessage.setCreateTime(TimeUtil.getInstance().now());
		// 添加套餐
		Integer orderMessageId = orderMessageService.addOrderMessage(orderMessage);

		/**
		 * 年级或班级的数组
		 */
		String[] selectedObjArr = request.getParameterValues("selectedObj");

		if (selectedObjArr != null)
		{
			for (int i = 0; i < selectedObjArr.length; i++)
			{

				if (selectedObjArr[i].startsWith("G"))
				{
					// 获取年级ID;
					Integer gradeId = StringUtil.toint(selectedObjArr[i].substring(1));
					List<Clazz> clazzList = clazzService.getClazzListByGradeId(gradeId);
					for (Clazz clazz : clazzList)
					{
						OrderMessageClazz orderMessageClazz = new OrderMessageClazz();
						orderMessageClazz.setOrderMessageId(orderMessageId);
						orderMessageClazz.setClazzId(clazz.getId());
						orderMessageClazz.setCreateTime(TimeUtil.getInstance().now());
						orderMessageService.addOrderMessageClazz(orderMessageClazz);
					}
				} else if (selectedObjArr[i].startsWith("C"))
				{
					OrderMessageClazz orderMessageClazz = new OrderMessageClazz();
					orderMessageClazz.setOrderMessageId(orderMessageId);
					orderMessageClazz.setClazzId(StringUtil.toint(selectedObjArr[i].substring(1)));
					orderMessageClazz.setCreateTime(TimeUtil.getInstance().now());
					orderMessageService.addOrderMessageClazz(orderMessageClazz);
				}
			}
		}
        //获取使用套餐状态
		String virtualstatus = orderMessageService.getVirtualMessageStatus();
		modelMap.addAttribute("status", virtualstatus);
		//获取定时推送服务费缴纳状态
		Integer paymentNoticeStatus = orderMessageService.getOrderMessagePaymentNoticeStatus();
		modelMap.addAttribute("paymentNoticeStatus", paymentNoticeStatus);
		//学校服务费缴费方式
		Integer status=orderMessageService.getOrderMessagePay();
		modelMap.addAttribute("schoolPay", status);
		return "system/service_fee_list";
	}

	/**
	 * 进入修改短信套餐页面
	 */
	@RequestMapping(value = "/modifyMessage.do")
	public String modifyMessage(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		Integer id = Integer.valueOf(request.getParameter("id"));

		// 根据id查询对应的短信套餐
		OrderMessage message = orderMessageService.getMessageById(id);

		if (message.getRangeObject() == 1)
		{
			List<OrderMessageClazz> selectedClazzList = orderMessageService.getSelectedClazzListByOrderMessageId(id);
			modelMap.addAttribute("selectedClazzList", selectedClazzList);
		}
		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("id", id);
		modelMap.addAttribute("message", message);

		return "system/service_fee_modify";
	}

	/**
	 * 执行增加增加短信套餐逻辑
	 */
	@RequestMapping(value = "/doModifyMessage.do")
	public String doModifyMessage(HttpServletResponse response, HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");

		/**
		 * id
		 */
		Integer id = Integer.valueOf(request.getParameter("id"));

		/**
		 * 名称
		 */
		String name = request.getParameter("name");
		/**
		 * 服务费
		 */
		String servicePrice = request.getParameter("servicePrice");
		if(StringUtil.isEmpty(servicePrice)){
			servicePrice="0";
		}

		/**
		 * 服务范围0:学校,1:个人
		 */
		Integer rangeObject = StringUtil.toint(request.getParameter("rangeObject"));
		/**
		 * 卡押金
		 */
		String cardPrice = request.getParameter("cardPrice");
		if(StringUtil.isEmpty(cardPrice)){
			cardPrice="0";
		}
		/**
		 * 类型
		 */
		Integer type = StringUtil.toint(request.getParameter("type"));

		/**
		 * 状态status
		 */
		Integer status = StringUtil.toint(request.getParameter("status"));

		/**
		 * 开始日期
		 */
		String startTime = request.getParameter("startTime");

		/**
		 * 结束日期
		 */
		String endTime = request.getParameter("endTime");

		OrderMessage orderMessage = new OrderMessage();
		orderMessage.setId(id);
		orderMessage.setName(name);
		orderMessage.setServicePrice(Double.valueOf(servicePrice));
		orderMessage.setCardPrice(Double.valueOf(cardPrice));
		//总费用：卡押金+服务费
		orderMessage.setPrice(PreciseCompute.add(orderMessage.getCardPrice(),orderMessage.getServicePrice()));
		orderMessage.setStatus(status);
		orderMessage.setType(type);
		orderMessage.setRangeObject(rangeObject);
		if (type == 0)
		{
			orderMessage.setStartTime(startTime);
			orderMessage.setEndTime(endTime);
		}
		orderMessage.setUpdateTime(TimeUtil.getInstance().now());
		orderMessageService.modifyMessageById(orderMessage);

		/**
		 * 年级或班级的数组
		 */
		String[] selectedObjArr = request.getParameterValues("selectedObj");
        if(status.intValue()==1){//失效
        	orderMessageService.deleteMessageGradeByOrderMessageId(id);
        }
		//Map<String, Object> parem = new HashMap<String, Object>();
		if (selectedObjArr != null)
		{
			orderMessageService.deleteMessageGradeByOrderMessageId(id);

			for (int i = 0; i < selectedObjArr.length; i++)
			{

				if (selectedObjArr[i].startsWith("G"))
				{
					// 获取年级ID;
					Integer gradeId = StringUtil.toint(selectedObjArr[i].substring(1));
					List<Clazz> clazzList = clazzService.getClazzListByGradeId(gradeId);
					for (Clazz clazz : clazzList)
					{
				    OrderMessageClazz orderMessageClazz=new OrderMessageClazz();
					orderMessageClazz = new OrderMessageClazz();
					orderMessageClazz.setOrderMessageId(id);
					orderMessageClazz.setClazzId(clazz.getId());
					orderMessageClazz.setCreateTime(TimeUtil.getInstance().now());
					orderMessageService.addOrderMessageClazz(orderMessageClazz);
					}
				} else if (selectedObjArr[i].startsWith("C"))
				{
					Integer clazzId = StringUtil.toint(selectedObjArr[i].substring(1));
				    OrderMessageClazz orderMessageClazz=new OrderMessageClazz();
					orderMessageClazz = new OrderMessageClazz();
					orderMessageClazz.setOrderMessageId(id);
					orderMessageClazz.setClazzId(clazzId);
					orderMessageClazz.setCreateTime(TimeUtil.getInstance().now());
					orderMessageService.addOrderMessageClazz(orderMessageClazz);
				}
			}
		}

		 //获取使用套餐状态
		String virtualstatus = orderMessageService.getVirtualMessageStatus();
		modelMap.addAttribute("status", virtualstatus);
		//获取定时推送服务费缴纳状态
		Integer paymentNoticeStatus = orderMessageService.getOrderMessagePaymentNoticeStatus();
		modelMap.addAttribute("paymentNoticeStatus", paymentNoticeStatus);
		//学校服务费缴费方式
		Integer schoolStatus=orderMessageService.getOrderMessagePay();
		modelMap.addAttribute("schoolPay", schoolStatus);
		return "system/service_fee_list";
	}

	/**
	 * 是否开启虚拟套餐
	 */
	@RequestMapping(value = "/updateVirtualMessage.do")
	public void updateVirtualMessage(HttpServletResponse response, HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		String status = request.getParameter("status");
		boolean flag = true;
		try
		{
			orderMessageService.updateVirtualMessage(status);
		} catch (Exception e)
		{
			flag = false;
		}
		Gson gson = new Gson();
		try
		{
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * 更新定时推送服务费状态
	 */
	@RequestMapping(value = "/updatePaymentNoticeStatus.do")
	public void updatePaymentNoticeStatus(HttpServletResponse response, HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		String status = request.getParameter("status");
		boolean flag = true;
		try
		{
			orderMessageService.updateOrderMessagePaymentNoticeStatus(Integer.valueOf(status));
		} catch (Exception e)
		{
			flag = false;
		}
		Gson gson = new Gson();
		try
		{
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}
    /**
     * 设置服务费是否是学校统一缴费
     * @author chenyong
     * @Time 2017年3月25日 下午2:31:03
     */
	@RequestMapping("/updateSchoolPay.do")
	@ResponseBody
	public void updateSchoolPay(HttpServletResponse response, HttpServletRequest request, HttpSession session, ModelMap modelMap){
		response.setCharacterEncoding("UTF-8");
		String status = request.getParameter("status");
		boolean flag = true;
		try
		{
			orderMessageService.updateSchoolPay(Integer.valueOf(status));
		} catch (Exception e)
		{
			flag = false;
		}
		Gson gson = new Gson();
		try
		{
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}
	/********** 服务费设置end **************/
	
	
	
	
	
	/********** 手机端begin **************/
	
	/**
	 * 【手机端】获取所有的短信套餐（服务费购买列表 针对家长）
	 *  学校服务费缴费方式 0：学校统一缴费 1：线上缴费, 0时：所有学生家长显示所有服务费已购买
	 *  教职工子女:只支付卡押金，服务费免费
	 *  非教职工子女:支付卡押金和服务费
	 */
	@RequestMapping(value = "/getOrderMessageListByApiKeyForParent.do")
	public String getOrderMessageListByApiKeyForParent(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<OrderMessage>> rhr = new RichHttpResponse<List<OrderMessage>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			//学校服务费缴费方式
			Integer status=orderMessageService.getOrderMessagePay();
			if(status==null){
				status=1;
			}
			if (loginUser != null)
			{
				int isTeacher=0;//0：非教师子女，1：教师子女
				List<Role> roles=loginUser.getRoleList();
				if(roles!=null && roles.size()>0){
					for (Role role : roles) {
						if(!"student".equals(role.getRoleCode()) && !"parent".equals(role.getRoleCode())){
							isTeacher=1;
							break;
						}
					}	
				}
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("status", 0);
				map.put("rangeObject", 1);
				map.put("schoolId", loginUser.getSchoolId());
				map.put("userId", loginUser.getUserId());

				List<OrderMessage> messageList = new ArrayList<OrderMessage>();
				
				List<User> studentList = userService.getStudentListByParentIdAndSchoolId(map);
				//卡押金信息================================
				List<Integer> studengIdList=new ArrayList<>();
				if(studentList!=null && studentList.size()>0){
					for (User u : studentList) {
						studengIdList.add(u.getUserId());	
					}
				}
				List<OrderMessageCardDeposit> listDeposit=null;
				Map<Integer,Integer> depositMap=new HashMap<>();
				if(studengIdList!=null && studengIdList.size()>0){
					//对应学生的卡押金支付情况
					listDeposit=orderMessageService.getOrderMessageUserDepositByUserIds(studengIdList);
				if(listDeposit!=null && listDeposit.size()>0){
					for (OrderMessageCardDeposit orderMessageUserDeposit : listDeposit) {
						//存放押金购买信息
						depositMap.put(orderMessageUserDeposit.getUserId(),orderMessageUserDeposit.getStatus());
					}
				 }
				}
				
				String phone = orderMessageService.getUserPhoneByUserId(loginUser.getUserId());
				if (studentList.size() > 0)
				{
					Map<Integer,Integer> mapParent=new HashMap<>();
					if(isTeacher==0){//防止是教师小孩的另一个非教师的父母购买
						List<Integer> listStudent=new ArrayList<>();
						for (User student : studentList)
						{
							listStudent.add(student.getUserId());
						}
						if(listStudent!=null && listStudent.size()>0){
						//根据学生
						List<User> parentsInfo = userService.getParentIsTeacher(listStudent);
						for (User user : parentsInfo) {
							mapParent.put(user.getStudentId(), user.getUserId());
						}
					}
					}
					
					for (User student : studentList)
					{
						if (student.getType() == null)
						{
							student.setType(0);// 可选择
						} else
						{
							student.setType(1);
						}
						student.setPhone(phone);
						map.put("clazzId", student.getClazzId());
						// 查询出服务范围是个人的套餐
						List<OrderMessage> orderMessageList = orderMessageService.getMessageListByClazzIdForParent(map);
						for (OrderMessage orderMessage : orderMessageList)
						{
							if ("3509020027".equals(schoolId) || "3201140009".equals(schoolId))
							{
								if (!StringUtil.isEmpty(orderMessage.getStartTime()))
								{
									orderMessage.setStartTime(formatter.format(formatter.parse(orderMessage.getStartTime())));
								}
								if (!StringUtil.isEmpty(orderMessage.getEndTime()))
								{
									orderMessage.setEndTime(formatter.format(formatter.parse(orderMessage.getEndTime())) + "学年");
								}
							}
							if(isTeacher==0){
								if(!mapParent.isEmpty() && mapParent.containsKey(student.getUserId())){//存在家长的角色是teacher或classLeader及该学生是教师子女
									orderMessage.setIsTeacher(1);
								}else{
									orderMessage.setIsTeacher(0);
								}
							}else{
								orderMessage.setIsTeacher(isTeacher);	
							}
							//卡押金支付情况（0：已支付，1：未支付）
							if(orderMessage.getCardPrice()==0){
								student.setCardPay(2);
							}else if(depositMap.containsKey(student.getUserId())){
								student.setCardPay(0);
							}else{
								student.setCardPay(1);	
							}
							if(orderMessage.getIsTeacher().intValue()==1){//教师子女免
								//0:可选择(未购买) 1:不可选择(已购买)
								student.setType(1);//已购买
							}else if(orderMessage.getServicePrice()==0){
								student.setType(2);//没有服务费	
							}
							orderMessage.setUser(student);
							orderMessage.setPayType(status);
							messageList.add(orderMessage);
						}
					}
				}
				rhr.ResponseCode = 0;
				rhr.ResponseObject = messageList;
				rhr.ResponseResult = "获取成功";
				json = GsonHelper.toJsonWithAnnotation(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("json转换失败：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 【手机端】获取所有的短信套餐（服务费代充列表 针对家长、班主任）
	 */
	@RequestMapping(value = "/getOrderMessageListByApiKeyForCLassLeader.do")
	public String getOrderMessageListByApiKeyForCLassLeader(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<OrderMessage>> rhr = new RichHttpResponse<List<OrderMessage>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("status", 0);
				map.put("rangeObject", 1);
				map.put("schoolId", loginUser.getSchoolId());
				map.put("userId", loginUser.getUserId());
				map.put("permissionCode", "replaceRechargeManager");
				//查询出服务范围是个人的套餐
				List<OrderMessage> messageList = orderMessageService.getMessageListByStatusForApp(map);
				for (OrderMessage orderMessage : messageList)
				{
					if ("3509020027".equals(schoolId) || "3201140009".equals(schoolId))
					{
						if (!StringUtil.isEmpty(orderMessage.getStartTime()))
						{
							orderMessage.setStartTime(formatter.format(formatter.parse(orderMessage.getStartTime())));
						}
						if (!StringUtil.isEmpty(orderMessage.getEndTime()))
						{
							orderMessage.setEndTime(formatter.format(formatter.parse(orderMessage.getEndTime())) + "学年");
						}
					}
				}
				rhr.ResponseCode = 0;
				rhr.ResponseObject = messageList;
				rhr.ResponseResult = "获取成功";
				json = GsonHelper.toJsonWithAnnotation(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("json转换失败：" + e.getMessage());
		}
		return null;
	}
	
	
	/********** 手机端end **************/
	
	
	
	
}