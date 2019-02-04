package com.guotop.palmschool.rest.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.check.service.AbnormalService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.entity.Device;
import com.guotop.palmschool.entity.Inout;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.OrderUserMessageDetail;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.SmsDetail;
import com.guotop.palmschool.entity.StudentClazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserDepartment;
import com.guotop.palmschool.entity.Ykt;
import com.guotop.palmschool.entity.YktPlace;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.InoutService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.SmsService;
import com.guotop.palmschool.service.impl.InoutServiceImpl;
import com.guotop.palmschool.system.entity.InformationType;
import com.guotop.palmschool.system.service.InformationTypeService;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 同步数据控制类 用于明德幼儿园进出记录与一卡通同步数据
 * 
 * @author Administrator
 *
 */
@RequestMapping("/syn")
@Controller
public class SynController
{
	@Resource
	private CommonService commonService;

	@Resource
	private SmsService smsService;

	@Resource
	private SchoolService schoolService;

	@Resource
	private ScheduleService scheduleService;

	@Resource
	private AbnormalService abnormalService;

	@Resource
	private InformationTypeService informationTypeService;

	@Resource
	private InoutService inoutService;
	
	@Resource
	private OrderMessageService orderMessageService;
	/**
	 * 日志
	 */
	private Log logger = LogFactory.getLog(InoutServiceImpl.class);

	/**
	 * 用于明德幼儿园进出记录，非通用接口
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/synInout.do", method = RequestMethod.POST)
	public String synInout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
			StringBuilder sb = new StringBuilder();
			String line = null;

			while ((line = br.readLine()) != null)
			{
				sb.append(line);
			}

			String msgInfoStr = sb.toString();
			Gson gson = new Gson();

			List<HashMap> list = gson.fromJson(msgInfoStr, new TypeToken<List<HashMap>>()
			{
			}.getType());

			for (int i = 0; i < list.size(); i++)
			{

				String cardCode = (String) list.get(i).get("cardCode");
				String createTime = (String) list.get(i).get("createTime");
				String position = (String) list.get(i).get("position");
				String schoolId = (String) list.get(i).get("schoolId");
				DBContextHolder.setDBType(schoolId);

				Device device = commonService.getDeviceByIP(position);
				User user = commonService.getUserByCardCode(cardCode);

				try
				{

					Date now = new Date();
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

					String date = dateFormat.format(now).split("\\s+")[0];// 日期

					Date nowTime = (Date) dateFormat.parse(dateFormat.format(now));
					Date swInTimeBegin = (Date) dateFormat.parse(date + " 05:00:00");
					Date swInTimeEnd = (Date) dateFormat.parse(date + " 10:00:00");
					Date swOutTimeBegin = (Date) dateFormat.parse(date + " 10:30:00");
					Date swOutTimeEnd = (Date) dateFormat.parse(date + " 12:30:00");
					Date xwInTimeBegin = (Date) dateFormat.parse(date + " 13:00:00");
					Date xwInTimeEnd = (Date) dateFormat.parse(date + " 15:30:00");
					Date xwOutTimeBegin = (Date) dateFormat.parse(date + " 16:00:00");
					Date xwOutTimeEnd = (Date) dateFormat.parse(date + " 18:30:00");

					String content = null;
					Integer status = 1;
					PUSHTYPE p = PUSHTYPE.INSCHOOLPUSH;

					Integer infType = null;

					// AM5:00~AM10：00入园
					if (nowTime.getTime() > swInTimeBegin.getTime() && nowTime.getTime() < swInTimeEnd.getTime())
					{
						infType = 8001;
						status = 1;
						content = "尊敬的家长您好，您的孩子已入园，快乐的上午即将开始，在园期间您有任何问题请直接和班主任联系！明德幼儿园";
						p = PUSHTYPE.INSCHOOLPUSH;
					}
					// AM10：30~PM12：30离园
					else if (nowTime.getTime() > swOutTimeBegin.getTime() && nowTime.getTime() < swOutTimeEnd.getTime())

					{
						infType = 8002;
						status = 2;
						content = "尊敬的家长您好，您已入园接孩子，即将离园！如需帮助请和我园联系！明德幼儿园";
						p = PUSHTYPE.OUTSCHOOLPUSH;
					}
					// 13：00~15：30入园
					else if (nowTime.getTime() > xwInTimeBegin.getTime() && nowTime.getTime() < xwInTimeEnd.getTime())
					{
						infType = 8001;
						status = 1;
						content = "尊敬的家长您好，您的孩子已入园，快乐下午即将开始，在园期间您有任何问题请直接和班主任联系！明德幼儿园";
						p = PUSHTYPE.INSCHOOLPUSH;
					}
					// 16:00~18：30为离园
					else if (nowTime.getTime() > xwOutTimeBegin.getTime() && nowTime.getTime() < xwOutTimeEnd.getTime())
					{
						infType = 8002;
						status = 2;
						content = "尊敬的家长您好，您已入园接孩子，即将离园！如需帮助请和我园联系！明德幼儿园";
						p = PUSHTYPE.OUTSCHOOLPUSH;
					}

					String deviceId = null;
					Inout inout = new Inout();
					inout.setCode(cardCode);
					inout.setCreateTime(createTime);
					inout.setStatus(status);
					try
					{
						deviceId = device.getId();
					} catch (Exception e)
					{
						deviceId = "0";
						logger.error("查不到关联设备");
					}
					inout.setPosition(deviceId);

					try
					{
						inout.setUserId(user.getUserId());
						commonService.addInout(inout);

						if (content != null)
						{
							InformationType informationType = informationTypeService.getInformationTypeByInformationType(infType);

							if (informationType.getType() == 1)// 只发送短信
							{
								SmsDetail smsDetail = new SmsDetail();
								smsDetail.setContent(content);
								smsDetail.setSenderId(1);
								smsDetail.setSenderName("学校管理员");
								smsDetail.setReceiverId(user.getUserId());
								smsDetail.setReceiverName(user.getRealName());
								smsDetail.setType("5");
								smsDetail.setStatus(0);
								smsDetail.setCreateTime(TimeUtil.getInstance().now());
								smsDetail.setSentTime(TimeUtil.getInstance().now());

								if (user.getRoleCode().equals("student"))
								{
									List<User> parentList = commonService.getParentByStudentId(user.getUserId());
									for (User parent : parentList)
									{

										smsDetail.setPhone(parent.getPhone());
										sendSmsByServiceFeeForStudent(smsDetail,schoolId,p,parent.getPhone(),parent.getUserId(),user.getUserId(), content,
											 informationType.getType());
										
									}
								} else if (user.getRoleCode().equals("parent"))
								{
									smsDetail.setPhone(user.getPhone());
									smsService.addSmsDetail(smsDetail);
									commonService.sendSmsByDB(schoolId, p, user.getPhone(), user.getUserId(), content, null, 1);
								}

							} else if (informationType.getType() == 2)// 只推送
							{
								if (user.getRoleCode().equals("student"))
								{
									List<User> parentList = commonService.getParentByStudentId(user.getUserId());
									for (User parent : parentList)
									{
										// 推送手机端消息
										pushItem(p, content, parent, schoolId);

									}
								} else if (user.getRoleCode().equals("parent"))
								{
									// 推送手机端消息
									pushItem(p, content, user, schoolId);

								}
							} else if (informationType.getType() == 3)// 短信+推送
							{
								SmsDetail smsDetail = new SmsDetail();
								smsDetail.setContent(content);
								smsDetail.setSenderId(1);
								smsDetail.setSenderName("学校管理员");
								smsDetail.setReceiverId(user.getUserId());
								smsDetail.setReceiverName(user.getRealName());
								smsDetail.setType("5");
								smsDetail.setStatus(0);
								smsDetail.setCreateTime(TimeUtil.getInstance().now());
								smsDetail.setSentTime(TimeUtil.getInstance().now());

								if (user.getRoleCode().equals("student"))
								{
									List<User> parentList = commonService.getParentByStudentId(user.getUserId());
									for (User parent : parentList)
									{
										smsDetail.setPhone(parent.getPhone());
										sendSmsByServiceFeeForStudent(smsDetail,schoolId,p,parent.getPhone(),parent.getUserId(),user.getUserId(), content,
												 informationType.getType());
									}
								} else if (user.getRoleCode().equals("parent"))
								{
									smsDetail.setPhone(user.getPhone());
									smsService.addSmsDetail(smsDetail);
									commonService.sendSmsByDB(schoolId, p, user.getPhone(), user.getUserId(), content, null, 3);
								}
							}
						}

					} catch (Exception e)
					{
						commonService.addInoutError(inout);
						logger.error("卡号:" + cardCode + "查不到关联用户");
					}

				} catch (Exception e)
				{
					e.printStackTrace();
				}

			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().write("success");
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();

			try
			{
				response.setCharacterEncoding("utf-8");
				response.getWriter().write("false");
				response.getWriter().flush();
			} catch (Exception ex)
			{
				ex.printStackTrace();
			}
		}

		return null;
	}

	/**
	 * 用于文婷一卡通同步接口
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/synYkt.do", method = RequestMethod.POST)
	public String synYkt(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
			StringBuilder sb = new StringBuilder();
			String line = null;

			while ((line = br.readLine()) != null)
			{
				sb.append(line);
			}

			String msgInfoStr = sb.toString();
			Gson gson = new Gson();
			List<HashMap> list = gson.fromJson(msgInfoStr, new TypeToken<List<HashMap>>()
			{
			}.getType());

			for (int i = 0; i < list.size(); i++)
			{

				String cardCode = (String) list.get(i).get("cardCode");
				String consTime = (String) list.get(i).get("consTime");
				String consMoney = (String) list.get(i).get("consMoney");
				String oldMoney = (String) list.get(i).get("oldMoney");
				String consPlace = (String) list.get(i).get("consPlace");
				String balance = (String) list.get(i).get("balance");
				String consStatus = (String) list.get(i).get("consStatus");
				String schoolId = (String) list.get(i).get("schoolId");
				DBContextHolder.setDBType(schoolId);

				School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));

				User user = commonService.getUserByCardCode(cardCode);

				Ykt ykt = new Ykt();

				ykt.setCardCode(cardCode);
				ykt.setConsMoney(Double.valueOf(consMoney));
				ykt.setBalance(Double.valueOf(balance));
				ykt.setOldMoney(Double.valueOf(oldMoney));
				ykt.setConsTime(consTime);
				ykt.setConsPlace(consPlace);
				ykt.setConsStatus(consStatus);
				ykt.setCreateTime(TimeUtil.getInstance().now());

				try
				{
					ykt.setUserName(user.getRealName());
					ykt.setUserId(user.getUserId());
					if (user.getRoleCode().equals("student"))
					{
						List<StudentClazz> studentClazz = commonService.getUserClazzId(user.getUserId());
						if (studentClazz.size() == 0)
						{
						} else
						{
							ykt.setClazzId(studentClazz.get(0).getClazzId());
						}
					} else
					{
						List<UserDepartment> userDepartment = commonService.getUserDeparmentId(user.getUserId());
						if (userDepartment.size() == 0)
						{
						} else
						{
							ykt.setDepartmentId(userDepartment.get(0).getDepartmentId());
						}
					}
					commonService.addYkt(ykt);

					List<YktPlace> yktPlaceList = commonService.getYktPlace(consPlace);
					if (yktPlaceList.size() == 0)
					{
						YktPlace yktPlace = new YktPlace();
						yktPlace.setConsPlace(consPlace);
						yktPlace.setUpdateTime(TimeUtil.getInstance().now());
						yktPlace.setCreateTime(TimeUtil.getInstance().now());
						commonService.addYktPlace(yktPlace);
					}

					PUSHTYPE pushStatesEnum = PUSHTYPE.YKTBALANCEPUSH;
					String content = null;

					SmsDetail smsDetail = new SmsDetail();

					smsDetail.setSenderId(1);
					smsDetail.setSenderName("学校管理员");
					smsDetail.setReceiverId(user.getUserId());
					smsDetail.setReceiverName(user.getRealName());
					smsDetail.setType("6");
					smsDetail.setCreateTime(TimeUtil.getInstance().now());
					smsDetail.setSentTime(TimeUtil.getInstance().now());

					if (user.getRoleCode().equals("student"))
					{
						List<User> parentList = commonService.getParentByStudentId(user.getUserId());
						for (User parent : parentList)
						{
							smsDetail.setPhone(parent.getPhone());

							if (Double.valueOf(balance) < 5)
							{
								pushStatesEnum = PUSHTYPE.YKTBALANCEPUSH;
								content = "尊敬的" + user.getRealName() + "家长您好，您的孩子一卡通余额已不足5元，请及时充值！";
								smsDetail.setContent(content);

								InformationType informationType = informationTypeService.getInformationTypeByInformationType(9001);

								if (informationType.getType() == 1 || informationType.getType() == 3)// 1只发送短信3
																										// 短信+推送
								{
									sendSmsByServiceFeeForStudent(smsDetail, schoolId, pushStatesEnum,  parent.getPhone(), parent.getUserId(),user.getUserId(),content,
											informationType.getType());

								} else if (informationType.getType() == 2)// 只推送
								{
									// 推送手机端消息
									pushItem(pushStatesEnum, content, parent, schoolId);

								}

							} else if (consStatus.equals("存款") || consStatus.equals("充值"))
							{
								pushStatesEnum = PUSHTYPE.YKTDEPOSITPUSH;
								content = "尊敬的" + user.getRealName() + "家长，您好！您的孩子于" + consTime + "一卡通缴费" + consMoney + "元已成功，当前余额" + balance + "元！";
								smsDetail.setContent(content);

								InformationType informationType = informationTypeService.getInformationTypeByInformationType(9003);

								if (informationType.getType() == 1 || informationType.getType() == 3)// 1只发送短信3短信+推送
								{
									sendSmsByServiceFeeForStudent(smsDetail, schoolId, pushStatesEnum,  parent.getPhone(), parent.getUserId(),user.getUserId(),content,
											informationType.getType());

								} else if (informationType.getType() == 2)// 只推送
								{
									// 推送手机端消息
									pushItem(pushStatesEnum, content, parent, schoolId);
								}

							} else if (consStatus.equals("消费"))
							{
								pushStatesEnum = PUSHTYPE.YKTCONSUMPTIONPUSH;
								content = "尊敬的" + user.getRealName() + "家长，您好！您的孩子于" + consTime + "在" + consPlace + "消费" + consMoney + "元，当前余额" + balance + "元！"
										+ school.getSchoolName();
								smsDetail.setContent(content);

								InformationType informationType = informationTypeService.getInformationTypeByInformationType(9002);

								if (informationType.getType() == 1 || informationType.getType() == 3)// 1只发送短信3短信+推送
								{
									sendSmsByServiceFeeForStudent(smsDetail, schoolId, pushStatesEnum,  parent.getPhone(), parent.getUserId(),user.getUserId(),content,
											informationType.getType());
								} else if (informationType.getType() == 2)// 只推送
								{
									// 推送手机端消息
									pushItem(pushStatesEnum, content, parent, schoolId);

								}

							}
						}
					} else
					{
						smsDetail.setPhone(user.getPhone());
						if (Double.valueOf(balance) < 5)
						{
							pushStatesEnum = PUSHTYPE.YKTBALANCEPUSH;
							content = "尊敬的用户，您的余额已不足5元，请及时充值！";
							smsDetail.setContent(content);

							InformationType informationType = informationTypeService.getInformationTypeByInformationType(9001);

							if (informationType.getType() == 1 || informationType.getType() == 1)// １只发送短信3短信+推送
							{
								sendSmsByServiceFeeForTeacher(smsDetail, schoolId, pushStatesEnum, user,  content, informationType.getType());

							} else if (informationType.getType() == 2)// 只推送
							{
								// 推送手机端消息
								pushItem(pushStatesEnum, content, user, schoolId);
							}
						}
						if (consStatus.equals("存款"))
						{
							pushStatesEnum = PUSHTYPE.YKTDEPOSITPUSH;
							content = "尊敬的用户，您好！您于" + consTime + "一卡通缴费" + consMoney + "元已成功，当前余额" + balance + "元！";
							smsDetail.setContent(content);

							InformationType informationType = informationTypeService.getInformationTypeByInformationType(9003);

							if (informationType.getType() == 1 || informationType.getType() == 3)// 只发送短信
							{
								sendSmsByServiceFeeForTeacher(smsDetail, schoolId, pushStatesEnum, user,  content, informationType.getType());

							} else if (informationType.getType() == 2)// 只推送
							{
								// 推送手机端消息
								pushItem(pushStatesEnum, content, user, schoolId);

							}

						} else if (consStatus.equals("消费"))
						{
							pushStatesEnum = PUSHTYPE.YKTCONSUMPTIONPUSH;
							content = "尊敬的用户，您好！您于" + consTime + "在" + consPlace + "消费" + consMoney + "元，当前余额" + balance + "元！" + school.getSchoolName();
							smsDetail.setContent(content);

							InformationType informationType = informationTypeService.getInformationTypeByInformationType(9002);

							if (informationType.getType() == 1 || informationType.getType() == 3)// 只发送短信
							{
								sendSmsByServiceFeeForTeacher(smsDetail, schoolId, pushStatesEnum, user,  content, informationType.getType());
								
							} else if (informationType.getType() == 2)// 只推送
							{
								// 推送手机端消息
								pushItem(pushStatesEnum, content, user, schoolId);
							}

						}
					}
				} catch (Exception e)
				{
					logger.error("卡号:" + cardCode + "查不到关联用户");
					commonService.addYktError(ykt);
				}

			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().write("success");
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
			try
			{
				response.setCharacterEncoding("utf-8");
				response.getWriter().write("false");
				response.getWriter().flush();
			} catch (IOException e1)
			{
				e1.printStackTrace();
			}
		}

		return null;
	}

	// 推送
	public void pushItem(PUSHTYPE pushStatesEnum, String content, User user, String schoolId)
	{
		// 推送手机端消息
		List<PushItem> pushItemlist = new ArrayList<PushItem>();
		PushItem pi = new PushItem();
		pi.title = pushStatesEnum.getName();
		pi.PushContent = content;
		pi.PushType = pushStatesEnum.getType();
		pi.PushContentType = pushStatesEnum.getContentType();
		String channelId = user.getBaiduChannelId();
		Integer deviceType = user.getDeviceType();
		if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
		{
			pi.channels = channelId;
			pi.deviceType = String.valueOf(deviceType);
		}
		pi.receiverId = user.getUserId();
		pi.schoolId = schoolId;
		pushItemlist.add(pi);

		commonService.pushMsg(pushItemlist, false);
	}

	/**
	 * 教师根据服务费接收信息
	 */
	public void sendSmsByServiceFeeForTeacher(SmsDetail smsDetail, String schoolId, PUSHTYPE pushStatesEnum,User user, String content,Integer informationType)
	{
		boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐

		boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启

		boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐
		if (schoolHasMessage)// 学校有短信套餐
		{
			if (isVirtualOpen)// 虚拟套餐开启直接发送
			{
				// 调用短信接口
				boolean flag =  commonService.sendSmsByDB(schoolId, pushStatesEnum, user.getPhone(), user.getUserId(), content, null,
						informationType);
				if(flag)
				{
					smsDetail.setStatus(0);
				}else
				{
					smsDetail.setStatus(1);
				}
				smsService.addSmsDetail(smsDetail);

			} else// 虚拟套餐关闭
			{
				if (isSchoolSingleMsg)
				{
					// 学校条数套餐剩余条数
					Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(schoolId);
					if (null != remainCount && remainCount > 0)// 有条数且大于0 直接发送
					{
						// 调用短信接口
						boolean flag =  commonService.sendSmsByDB(schoolId, pushStatesEnum, user.getPhone(), user.getUserId(), content, null,
								informationType);
						if(flag)
						{
							smsDetail.setStatus(0);
						}else
						{
							smsDetail.setStatus(1);
						}
						smsService.addSmsDetail(smsDetail);
						
						orderMessageService.updateOrderMessageSchoolById(schoolId);
					} else
					{
						// "1":发送失败 "2":没有缴纳服务费
						smsDetail.setStatus(2);// 发送失败
						smsService.addSmsDetail(smsDetail);
					}
				} else
				{
					// 调用短信接口
					boolean flag =  commonService.sendSmsByDB(schoolId, pushStatesEnum, user.getPhone(), user.getUserId(), content, null,
							informationType);
					if(flag)
					{
						smsDetail.setStatus(0);
					}else
					{
						smsDetail.setStatus(1);
					}
					smsService.addSmsDetail(smsDetail);
				}
			}
		} else
		{
			// 调用短信接口
			boolean flag =  commonService.sendSmsByDB(schoolId, pushStatesEnum, user.getPhone(), user.getUserId(), content, null,
					informationType);
			if(flag)
			{
				smsDetail.setStatus(0);
			}else
			{
				smsDetail.setStatus(1);
			}
			smsService.addSmsDetail(smsDetail);
		}
	}

	/**
	 * 学生家长根据服务费接收信息
	 */
	public void sendSmsByServiceFeeForStudent(SmsDetail smsDetail, String schoolId, PUSHTYPE pushStatesEnum, String phone, Integer parentId,Integer studentId, String content,
			Integer informationType)
	{
		boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐

		boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启

		boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐

		if (schoolHasMessage)// 学校有短信套餐
		{
			if (isVirtualOpen)// 虚拟套餐开启直接发送
			{
				// 调用短信接口
				boolean flag = commonService.sendSmsByDB(schoolId, pushStatesEnum, phone, parentId, content, null, informationType);
				if(flag)
				{
					smsDetail.setStatus(0);
				}
				else
				{
					smsDetail.setStatus(1);
				}
				smsService.addSmsDetail(smsDetail);

			} else// 虚拟套餐关闭
			{
				if (isSchoolSingleMsg)// 是否有学校单条套餐 有判断条数
				{

					// 学校条数套餐剩余条数
					Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(schoolId);
					if (null != remainCount && remainCount > 0)// 有条数且大于0
					{
						// 调用短信接口
						boolean flag = commonService.sendSmsByDB(schoolId, pushStatesEnum, phone, parentId, content, null, informationType);
						if(flag)
						{
							smsDetail.setStatus(0);
						}
						else
						{
							smsDetail.setStatus(1);
						}
						smsService.addSmsDetail(smsDetail);
						orderMessageService.updateOrderMessageSchoolById(schoolId);
					} else// 没有学校条数套餐 判断学生是否购买短信套餐
					{
						// 先判断学生有没有购买过
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("userId", studentId);
						map.put("status", 0);
						OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(map);
						boolean isCharge = false;
						if (messageUser != null)
						{
							if (messageUser.getType() == 0)
							{
								TimeUtil.getInstance();
								if (TimeUtil.nowDateIsBetween(messageUser.getStartTime(), messageUser.getEndTime()))
								{
									isCharge = true;
								} else
								{
									isCharge = false;
								}

							} else
							{
								if (messageUser.getCount() > 0)
								{
									isCharge = true;
								} else
								{
									isCharge = false;
								}
							}
						}

						if (isCharge)
						{
							// 调用短信接口
							boolean flag = commonService.sendSmsByDB(schoolId, pushStatesEnum, phone, parentId, content, null, informationType);
							if(flag)
							{
								smsDetail.setStatus(0);
							}
							else
							{
								smsDetail.setStatus(1);
							}
							smsService.addSmsDetail(smsDetail);
							
							int smscount = ((int) content.length() / 65) + 1;
							int messcount = 0;
							if (messageUser.getType() == 1)
							{
								// 如果短信剩余条数小于本次短信条说 剩余条数为0 如果大于等于本次短信条说
								// 则本次剩余条数为原剩余条数减本次短信条数
								if (messageUser.getCount() < smscount)
								{
									messcount = 0;
								} else
								{
									messcount = messageUser.getCount() - smscount;
								}
								map.put("count", messcount);
								map.put("id", messageUser.getId());
								orderMessageService.updateOrederMessageUserCount(map);

							}

							OrderUserMessageDetail messDetail = new OrderUserMessageDetail();
							messDetail.setCount(smscount);
							messDetail.setMessageId(messageUser.getMessageId());
							messDetail.setMessUserId(messageUser.getId());
							messDetail.setNowCount(messcount);
							messDetail.setOrgCount(messageUser.getCount());
							messDetail.setType(messageUser.getType());
							messDetail.setUserId(messageUser.getUserId());
							orderMessageService.addOrderUserMessageDetail(messDetail);
						} else
						{
							// "1":发送失败 "2":没有缴纳服务费
							smsDetail.setStatus(2);// 发送失败
							smsService.addSmsDetail(smsDetail);
						}
					}

				} else// 没有判断学生是否购买服务费
				{
					// 先判断学生有没有购买过
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("userId", studentId);
					map.put("status", 0);
					OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(map);
					boolean isCharge = false;
					if (messageUser != null)
					{
						if (messageUser.getType() == 0)
						{
							TimeUtil.getInstance();
							if (TimeUtil.nowDateIsBetween(messageUser.getStartTime(), messageUser.getEndTime()))
							{
								isCharge = true;
							} else
							{
								isCharge = false;
							}

						} else
						{
							if (messageUser.getCount() > 0)
							{
								isCharge = true;
							} else
							{
								isCharge = false;
							}
						}
					}

					if (isCharge)
					{
						// 调用短信接口
						boolean flag = commonService.sendSmsByDB(schoolId, pushStatesEnum, phone, parentId, content, null, informationType);
						if(flag)
						{
							smsDetail.setStatus(0);
						}
						else
						{
							smsDetail.setStatus(1);
						}
						smsService.addSmsDetail(smsDetail);
						
						int smscount = ((int) content.length() / 65) + 1;
						int messcount = 0;
						if (messageUser.getType() == 1)
						{
							// 如果短信剩余条数小于本次短信条说 剩余条数为0 如果大于等于本次短信条说
							// 则本次剩余条数为原剩余条数减本次短信条数
							if (messageUser.getCount() < smscount)
							{
								messcount = 0;
							} else
							{
								messcount = messageUser.getCount() - smscount;
							}
							map.put("count", messcount);
							map.put("id", messageUser.getId());
							orderMessageService.updateOrederMessageUserCount(map);
						}

						OrderUserMessageDetail messDetail = new OrderUserMessageDetail();
						messDetail.setCount(smscount);
						messDetail.setMessageId(messageUser.getMessageId());
						messDetail.setMessUserId(messageUser.getId());
						messDetail.setNowCount(messcount);
						messDetail.setOrgCount(messageUser.getCount());
						messDetail.setType(messageUser.getType());
						messDetail.setUserId(messageUser.getUserId());
						orderMessageService.addOrderUserMessageDetail(messDetail);
					} else
					{
						// "1":发送失败 "2":没有缴纳服务费
						smsDetail.setStatus(2);// 发送失败
						smsService.addSmsDetail(smsDetail);
					}

				}
			}
		} else// 学校无短信套餐 直接发送
		{
			// 调用短信接口
			boolean flag = commonService.sendSmsByDB(schoolId, pushStatesEnum, phone, parentId, content, null, informationType);
			if(flag)
			{
				smsDetail.setStatus(0);
			}
			else
			{
				smsDetail.setStatus(1);
			}
			smsService.addSmsDetail(smsDetail);
		}

	}

}
