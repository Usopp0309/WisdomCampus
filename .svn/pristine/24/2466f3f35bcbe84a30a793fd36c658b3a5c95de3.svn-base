package com.guotop.palmschool.system.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.guotop.palmschool.common.controller.BaseUploadController;
import com.guotop.palmschool.common.entity.Bill;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.SchoolInfo;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserAccount;
import com.guotop.palmschool.entity.UserAccountHistory;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserAccountService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.shopping.entity.Orders;
import com.guotop.palmschool.shopping.service.OrdersService;
import com.guotop.palmschool.system.entity.CardApplyAudit;
import com.guotop.palmschool.system.entity.CardApplyAudit_person;
import com.guotop.palmschool.system.service.CardApplyAuditService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.PreciseCompute;
import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 在线审核申请控制类
 * 
 * @author jfy
 */
@RequestMapping("/cardApply")
@Controller
public class CardApplyAuditController extends BaseUploadController
{
	private Logger log = LoggerFactory.getLogger(CardApplyAuditController.class);
	@Resource
	private CardApplyAuditService cardApplyAuditService;
	@Resource
	private UserService userService;

	@Resource
	private StudentService studentService;

	@Resource
	private OrdersService ordersService;
	
	@Resource
	private UserAccountService userAccountService;

	@Autowired
	private CommonService commonService;
	
	@Resource
	private SchoolService schoolService;

	/**
	 * 进入个人补办卡页面
	 */
	@RequestMapping(value = "/toCardApplyPerson.do")
	public String toCardApplyPerson(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "system/cardApply_Person";
	}

	/**
	 * 进入在线审核申请页面
	 */
	@RequestMapping(value = "/toCardApplyAuditList.do")
	public String toCardApplyAuditList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "system/fill_Card";
	}

	/**
	 * 加载补办卡数据
	 */
	@RequestMapping(value = "/loadCardApplyAuditList.do")
	public String loadCardApplyAuditList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			String status = request.getParameter("status");
			String condition = request.getParameter("condition");
			if (StringUtil.isEmpty(status))
			{
				status = "1";
			}
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("page"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			User loginUser = (User) session.getAttribute("user");
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("status", status);
			params.put("condition", condition);
			if("sysadmin".equals(loginUser.getUsername()) || "sysadmin".equals(loginUser.getUserName())){
				//超级管理员
			}else if(2 == loginUser.getType()){
				//代理商
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("userId", loginUser.getUserId());
				List<SchoolInfo> list = schoolService.getSchoolListByAgencyUserId(conditionMap);
				if(!CollectionUtils.isEmpty(list)){
					params.put("schoolList", list);
				}
			}else if(3 == loginUser.getType()){
				//技术支持
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("userId", loginUser.getUserId());
				List<SchoolInfo> list = schoolService.getSchoolListBySupportUserId(conditionMap);
				if(!CollectionUtils.isEmpty(list)){
					params.put("schoolList", list);
				}
			}
			Pages  page = cardApplyAuditService.getCardApplyForPages(currentPage,30,params);
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(page);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 修改状态
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/modifyStatus.do")
	public String modifyStatus(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		HashMap<String, Object> map = new HashMap<String, Object>();
		try
		{
			map.put("id", Integer.valueOf(id));
			map.put("status", status);
			cardApplyAuditService.modifyStatus(map);
			map.clear();
			map.put("status", 0);
		} catch (Exception ex)
		{
			map.put("status", 1);
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 面向个人的补办卡申请表修改
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/modifyReissuedcardPerson.do")
	@ResponseBody
	public void modifyReissuedcardPerson(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		String remark = request.getParameter("remark");
		String applyUserId = request.getParameter("applyUserId");
		String schoolId = request.getParameter("schoolId");
		Integer receiverId = 0;
		if (!StringUtil.isEmpty(applyUserId))
		{
			receiverId = Integer.parseInt(applyUserId);
		}
		
		CardApplyAudit_person caap = cardApplyAuditService.getReissuedcardPersonById(Integer.parseInt(id));
		String f = "1";
		try
		{
			//拒绝理由
			String refuseContent = "您的补办卡申请已被拒绝，请联系管理员"; 
			String currentTime = TimeUtil.getInstance().now();
			
			if("2".equals(status) && (caap.getOrderStatue() == 1 || caap.getOrderStatue() == 3) ){
				refuseContent = "您的补办卡申请已被拒绝，您支付的费用已经退还到你的亦信钱包中，请注意查收";
			}
			cardApplyAuditService.updateCardApplyPerson(Integer.parseInt(id), status, remark);
			
			String amount = caap.getOrderMoney(); 			
			//拒绝补卡的情况下需要加上退款 而且需要判断必须支付成功才能退款
			if("2".equals(status) && (caap.getOrderStatue() == 1 || caap.getOrderStatue() == 3) ){
				UserAccount userAccount = userAccountService.findUserAccountByUserId(receiverId);
				if(userAccount == null){
					//创建UserAccount
					userAccount = new UserAccount();
					userAccount.setUserId(receiverId);
					userAccount.setBalance("0");
					userAccount.setCreateTime(currentTime);
					userAccount.setUpdateTime(currentTime);
					userAccount.setStatus(0);
					userAccount.setPassword("e10adc3949ba59abbe56e057f20f883e");// 设置初始支付密码123456的MD5值
					userAccount.setIsSmsValidate(0);
					userAccount.setApplyBalance("0");
					userAccountService.addUserAccount(userAccount);
					
					UserAccountHistory userAccountHistory = new UserAccountHistory();
					userAccountHistory.setUserId(receiverId);
					userAccountHistory.setNewBalance("0");
					userAccountHistory.setOldBalance("0");
					userAccountHistory.setDescription("亦信钱包第一次使用");
					userAccountHistory.setCreateTime(currentTime);
					userAccountHistory.setType(1);
					userAccountService.addUserAccountHistory(userAccountHistory);
				}
				
				//退款补办卡费用到钱包
				String billDesc = "补办卡费用退款，亦信钱包退款:" + amount + "元";
				Bill myBill = new Bill();
				myBill.setTypeId(Cons.BILLTYPE_IN_REFUND);
				myBill.setTradeNo("");
				myBill.setChannel(3);
				myBill.setUserId(receiverId);
				myBill.setCounts(1);
				myBill.setAmount(Double.valueOf(amount));
				myBill.setPlatformCode(0);
				myBill.setOrderId(caap.getOrderId()+"");
				myBill.setGoodsId(0);
				myBill.setOtherUserId(0);
				myBill.setGoodsName("补办卡退款");
				myBill.setCaption(billDesc);
				
				String origBalance = userAccount.getBalance();
				double newBalance = PreciseCompute.add(Double.valueOf(origBalance), Double.valueOf(amount));
				userAccount.setBalance(newBalance+"");
				
				UserAccountHistory userAccountHistory = new UserAccountHistory();
				userAccountHistory.setUserId(receiverId);
				userAccountHistory.setNewBalance(newBalance+"");
				userAccountHistory.setOldBalance(origBalance);
				userAccountHistory.setDescription("补办卡退款");
				userAccountHistory.setCreateTime(currentTime);
				userAccountHistory.setType(1);
				
				userAccountService.refund(userAccount,userAccountHistory,myBill);
			}
			

			//推送信息发送
			User push = commonService.getUserByUserIdForPush(receiverId);
			PushItem pi = new PushItem();
			List<PushItem> piList = new ArrayList<PushItem>();
			if ("1".equals(status))
			{// 通过
				pi.PushContent = "您的补办卡申请已通过，请耐心等待";
				pi.PushContentType = 2;
			} else if ("2".equals(status))
			{// 拒绝
				pi.PushContent = refuseContent;
				pi.PushContentType = 3;
			}
			pi.receiverId = receiverId;
			pi.channels = push.getBaiduChannelId();
			pi.deviceType = push.getDeviceType() + "";
			pi.title = "补办卡通知";
			pi.PushType = 19;
			pi.schoolId = schoolId;
			piList.add(pi);
			DBContextHolder.setDBType(schoolId);
			commonService.pushMsg(piList, true);// 消息推送
			
		} catch (Exception ex)
		{
			f = "0";
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(f);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}


	/**
	 * 补办卡申请页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAddCardApply.do")
	public String toAddCardApply()
	{
		return "system/addCardApply";
	}

	/**
	 * 新增补办卡申请
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/doAddCardApply.do")
	public String doAddCardApply(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		String schoolId = loginUser.getSchoolId();
		HashMap<String, Object> map = new HashMap<String, Object>();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat formatterTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String fileDirPath = "\\" + schoolId + "\\cardApply\\" + formatter.format(new Date()) + "\\";
		String savePath = getTempRoot() + fileDirPath;
		File file = new File(savePath);
		// 判断上传文件的保存目录是否存在
		if (!file.exists() && !file.isDirectory())
		{
			// 创建目录
			file.mkdirs();
		}
		try
		{
			// 使用Apache文件上传组件处理文件上传步骤：
			// 1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 3、判断提交上来的数据是否是上传表单的数据
			if (!ServletFileUpload.isMultipartContent(request))
			{
				// 按照传统方式获取数据
				map.put("status", 1);
				return null;
			}
			// 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
			List<FileItem> list = upload.parseRequest(request);
			String cardType = "";
			String sumNumber = "";
			String remark = "";
			String newCardPath = "";
			String memberUserId = "";
			for (FileItem item : list)
			{
				// 如果fileitem中封装的是普通输入项的数据
				if (item.isFormField())
				{
					String name = item.getFieldName();
					if ("cardType".equals(name))
					{
						cardType = item.getString("UTF-8");
					} else if ("sumNumber".equals(name))
					{
						sumNumber = item.getString("UTF-8");
					} else if ("remark".equals(name))
					{
						remark = item.getString("UTF-8");
					} else if ("memberUserId".equals(name))
					{
						memberUserId = item.getString("UTF-8");
					}
				} else
				{// 如果fileitem中封装的是上传文件
					// 得到上传的文件名称，
					String fieldName = item.getFieldName();
					String filename = item.getName();
					if (filename == null || filename.trim().equals(""))
					{
						continue;
					}
					// 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：
					// c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
					// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
					filename = filename.substring(filename.lastIndexOf("\\") + 1);
					// 获取item中的上传文件的输入流
					InputStream in = item.getInputStream();
					// 创建一个文件输出流
					FileOutputStream out = new FileOutputStream(savePath + "\\" + filename);
					// 创建一个缓冲区
					byte buffer[] = new byte[1024];
					// 判断输入流中的数据是否已经读完的标识
					int len = 0;
					// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
					while ((len = in.read(buffer)) > 0)
					{
						// 使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\"
						// + filename)当中
						out.write(buffer, 0, len);
					}
					// 关闭输入流
					in.close();
					// 关闭输出流
					out.close();
					if ("newCardPath".equals(fieldName))
					{
						newCardPath = "/upload/" + fileDirPath + filename;
					}
				}

			}

			String[] applyUserIds = memberUserId.split(",");
			String applyUserId = "";
			for (int i = 0; i < applyUserIds.length; i++)
			{
				if (applyUserIds[i].startsWith("C"))
				{
					List<User> studentList = studentService.getStudentListByClazzIdInStudentSMS(StringUtil.toint(applyUserIds[i].replace("C", "")));
					for (int j = 0; j < studentList.size(); j++)
					{
						if (i == applyUserIds.length && j == studentList.size() - 1)
						{
							applyUserId += studentList.get(j).getUserId();
						} else
						{
							applyUserId += studentList.get(j).getUserId() + ",";
						}
					}
				} else
				{
					if (i == applyUserIds.length - 1)
					{
						applyUserId += applyUserIds[i].replace("S", "");
					} else
					{
						applyUserId += applyUserIds[i].replace("S", "") + ",";
					}
				}
			}
			CardApplyAudit caa = new CardApplyAudit();
			caa.setApplyUserId(loginUser.getUserId());
			caa.setApplyTime(formatterTime.format(new Date()));
			caa.setAttachPath(newCardPath);
			caa.setAuditstatus(0);
			caa.setCardtype(cardType);
			caa.setMemberUserId(applyUserId);
			caa.setPhone(loginUser.getBindPhone());// 申请人手机号
			caa.setRemark(remark);
			caa.setSchoolId(Long.valueOf(schoolId));
			caa.setSumNumber(sumNumber);
			cardApplyAuditService.addCardApply(caa);

			return "system/addCardApply";
		} catch (Exception e)
		{
			e.printStackTrace();

		}
		return null;
	}

	@Override
	public String getCommandName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	// --------------------------手机端在线补办卡-------------------------------------
	@RequestMapping(value = "/toCardApplyByApiKey.do", method = RequestMethod.POST)
	public String toAbnormalListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");

		RichHttpResponse<Map<String, Object>> rhr = new RichHttpResponse<Map<String, Object>>();
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		String json;
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				List<Role> roleList = loginUser.getRoleList();
				boolean isParent = false;
				if (!CollectionUtils.isEmpty(roleList))
				{
					for (Role role : roleList)
					{
						if ("parent".equals(role.getRoleCode()))
						{
							isParent = true;
							break;
						}
					}
				}
				List<User> studentList = new ArrayList<User>();
				if (isParent)
				{
					Integer parentId = loginUser.getUserId();
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("schoolId", loginUser.getSchoolId());
					map.put("userId", loginUser.getUserId());
					studentList = userService.getStudentListByParentIdAndSchoolId(map);
					if (!CollectionUtils.isEmpty(studentList))
					{
						for (User student : studentList)
						{
							student.setParentId(parentId);
							student.setParentname(loginUser.getRealName());
							student.setPhone(loginUser.getPhone());
						}
					}
				}
				Map<String, Object> parmMap = new HashMap<String, Object>();
				Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
				Double cardApplyBalance = PropertiesUtil.getInstance().getCardApplyBalance(pro, schoolId);
				parmMap.put("cardApplyBalance", cardApplyBalance);
				parmMap.put("studentList", studentList);
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "进入在线补卡成功";
				rhr.ResponseObject = parmMap;
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
			log.error("进入在线补卡,json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			rhr.ResponseCode = -2;
			rhr.ResponseResult = "进入在线补卡失败";
			json = GsonHelper.toJson(rhr);

			log.error("进入在线补卡失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】进入支付页面前调用的下订单接口
	 */
	@RequestMapping(value = "/toApplyCardPayByApiKey.do", method = RequestMethod.POST)
	public String toOrderMessagePayByApiKey(@RequestParam(value = "mfile", required = false) MultipartFile mfile, HttpServletRequest request,
			HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Map<String, Object>> rhr = new RichHttpResponse<Map<String, Object>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		Integer userId = StringUtil.toint(request.getParameter("userId"));
		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));
		String clazzName = request.getParameter("clazzName");
		Integer type = StringUtil.toint(request.getParameter("type"));// 类型 0:补卡
																		// 1:办卡
		String cardApplyBalance = request.getParameter("cardApplyBalance");
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				// 没有购买过套餐的处理
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
				Double cardApplyBalance_orig = PropertiesUtil.getInstance().getCardApplyBalance(pro, schoolId);

				if (StringUtil.isEmpty(cardApplyBalance))
				{
					rhr.ResponseCode = -2;
					rhr.ResponseResult = "下单失败,补卡金额异常";
				} else
				{
					if (Double.valueOf(cardApplyBalance).doubleValue() != cardApplyBalance_orig.doubleValue())
					{
						rhr.ResponseCode = -3;
						rhr.ResponseResult = "下单失败,补卡金额异常";
					} else
					{

						// 创建订单
						String goodsName = "在线补办卡费用";
						Orders orders = new Orders();
						orders.setGoodsName(goodsName);
						orders.setAmount(String.valueOf(cardApplyBalance));
						orders.setCounts(1);
						orders.setReceiver(loginUser.getRealName());
						orders.setPhone(loginUser.getPhone());
						orders.setUserId(loginUser.getUserId());
						orders.setCreateTime(TimeUtil.getInstance().now());
						orders.setIsVirtual(7);
						orders.setSchoolId(schoolId);
						int ordersId = ordersService.addOrders(orders);

						// 上传文件保存提交记录
						String relativePth = "";
						if (type == 1)
						{
							String absolutePath = "D:/Guolang/wisdomcampus/cardapply/" + schoolId + "/" + clazzId + "/";

							String originalFilename = mfile.getOriginalFilename();
							String prefix = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
							String newFilename = System.currentTimeMillis() + "." + prefix;
							relativePth = "cardapply/" + schoolId + "/" + clazzId + "/" + newFilename;
							File file = new File(absolutePath);
							if (!file.exists() && !file.isDirectory())
							{
								file.mkdir();
							}
							FileUtils.copyInputStreamToFile(mfile.getInputStream(), new File(absolutePath, newFilename));
						}

						CardApplyAudit_person cardApplyAudit_person = new CardApplyAudit_person();
						cardApplyAudit_person.setUserId(userId);
						cardApplyAudit_person.setUserInfo(clazzName);
						cardApplyAudit_person.setApplyUserId(loginUser.getUserId());
						cardApplyAudit_person.setApplyUserName(loginUser.getRealName());
						cardApplyAudit_person.setPhone(loginUser.getPhone());
						cardApplyAudit_person.setAttachPath(relativePth);
						cardApplyAudit_person.setSchoolId(Long.valueOf(schoolId));
						cardApplyAudit_person.setAuditstatus(0);
						cardApplyAudit_person.setType(type);
						cardApplyAudit_person.setOrderId(ordersId);

						cardApplyAuditService.addCardApplyPerson(cardApplyAudit_person);

						Map<String, Object> resultMap = new HashMap<String, Object>();
						resultMap.put("amount", cardApplyBalance);
						resultMap.put("goodsName", goodsName);
						resultMap.put("ordersId", ordersId);

						rhr.ResponseCode = 0;
						rhr.ResponseObject = resultMap;
						rhr.ResponseResult = "下单成功";
					}
				}
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
			log.error("提交订单失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 查询面向个人的补办卡申请表信息
	 * 
	 * @author chenyong
	 * @Time 2016年12月26日 下午1:39:12
	 */
	@RequestMapping("/getReissuedcardPerson.do")
	@ResponseBody
	public void getReissuedcardPerson(String realName, String status, HttpServletResponse response, HttpSession session, Integer page,
			HttpServletRequest request)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1)
		{
			e1.printStackTrace();
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute("user");
		List<CardApplyAudit> list = null;
		boolean isPermission = false;
		if ("sysadmin".equals(user.getUsername()))
		{// 超级管理员才有权限
			isPermission = true;
		}else if(2 == user.getType()){
			//代理商
			isPermission = true;
		}else if(3 == user.getType()){
			//技术支持
			isPermission = true;
		}
		int pageSize = 10;
		final int offset = Pages.countOffset(pageSize, page);
		if (isPermission)
		{
			map.put("auditstatus", status);
			map.put("condition", realName);
			map.put("startIndex", "");
			if(2 == user.getType()){
				//代理商
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("userId", user.getUserId());
				List<SchoolInfo> schoolList = schoolService.getSchoolListByAgencyUserId(conditionMap);
				if(!CollectionUtils.isEmpty(schoolList)){
					map.put("schoolList", schoolList);
				}
			}else if(3 == user.getType()){
				//技术支持
				HashMap<String, Object> conditionMap = new HashMap<String, Object>();
				conditionMap.put("userId", user.getUserId());
				List<SchoolInfo> schoolList = schoolService.getSchoolListBySupportUserId(conditionMap);
				if(!CollectionUtils.isEmpty(schoolList)){
					map.put("schoolList", schoolList);
				}
			}
			List<CardApplyAudit> totallist = cardApplyAuditService.getReissuedcardPersonByStatus(map);
			int totalPage = Pages.countTotalPage(pageSize, totallist.size());
			map.put("startIndex", offset);
			map.put("endLenth", pageSize);// 一次读10条
			list = cardApplyAuditService.getReissuedcardPersonByStatus(map);
			map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("isPermission", isPermission);
			map.put("currentPage", page);
			map.put("totalPage", totalPage);
		} else
		{
			map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("isPermission", isPermission);
			map.put("currentPage", 0);
			map.put("totalPage", 0);
		}
		try
		{
			response.getWriter().write(GsonHelper.toJson(map));
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}
}
