package com.guotop.palmschool.taskAssistant.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.OrderUserMessageDetail;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.Sms;
import com.guotop.palmschool.entity.SmsDetail;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.SmsService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.taskAssistant.entity.TaskHistory;
import com.guotop.palmschool.taskAssistant.entity.TaskHistoryDetail;
import com.guotop.palmschool.taskAssistant.entity.TaskSubject;
import com.guotop.palmschool.taskAssistant.service.TaskAssistantService;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.Clazz;
import com.richx.pojo.Grade;
import com.richx.pojo.PalmUser;
import com.richx.pojo.RichHttpResponse;
import com.richx.pojo.TaskDate;

import dev.gson.GsonHelper;

@RequestMapping("/taskAssistant")
@Controller
public class TaskAssistantController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(TaskAssistantController.class);
	@Resource
	private UserService userService;
	@Resource
	private TaskAssistantService taskAssistantService;
	@Resource
	private StudentService studentService;
	@Resource
	private SmsService smsService;
	@Resource
	private CommonService commonService;
	@Resource
	private OrderMessageService orderMessageService;

	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 获取角色列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getRoleListByApiKey.do")
	public String getRoleListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RichHttpResponse<List<Role>> richHttpResponse = new RichHttpResponse<List<Role>>();
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{

				List<Role> roleList = loginUser.getRoleList();

				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseResult = "获取成功";
				richHttpResponse.ResponseObject = roleList;
			} else
			{
				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			log.error("getRoleListByApiKey.do:" + e.getMessage());
		}
		return null;
	}

	/**
	 * 获取作业科目
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getSubjectListByApiKey.do")
	public String getSubjectListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RichHttpResponse<List<TaskSubject>> richHttpResponse = new RichHttpResponse<List<TaskSubject>>();
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				List<TaskSubject> subjectList = taskAssistantService.getAllSubject(schoolId);
				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseResult = "获取成功";
				richHttpResponse.ResponseObject = subjectList;
			} else
			{
				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			log.error("getSubjectListByApiKey.do:" + e.getMessage());
		}
		return null;
	}

	/**
	 * 教师发送作业
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/sendTaskByApiKey.do")
	public String sendTaskByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RichHttpResponse<List<TaskSubject>> richHttpResponse = new RichHttpResponse<List<TaskSubject>>();
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			Integer taskSubjectId = StringUtil.toint(request.getParameter("taskSubjectId"));
			String taskContent = request.getParameter("taskContent");
			String taskContentImage = request.getParameter("taskContentImage");
			if (StringUtil.isEmpty(taskContent))
			{
				richHttpResponse.ResponseCode = -2;
				richHttpResponse.ResponseResult = "提交失败";
				String json = GsonHelper.toJson(richHttpResponse);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			ArrayList<PalmUser> receiverList_parse = new ArrayList<PalmUser>();
			if (loginUser != null)
			{
				// 接收前台发送过来的人员列表
				String receiverListJson = request.getParameter("receiverList");
				// 解析前台发送过来的接收人列表
				ArrayList<PalmUser> receiverList = GsonHelper.<ArrayList<PalmUser>>fromJson(receiverListJson, new TypeToken<ArrayList<PalmUser>>()
				{
				}.getType());
				if (receiverList != null && receiverList.size() > 0)
				{
					// 学生的话需要获得他的家长手机号码
					for (PalmUser palmUser : receiverList)
					{
						List<User> studentList = studentService.getStudentListWithPartentPhoneByIdInStudentSMS(Integer.valueOf(palmUser.UserId));
						for (User studentUser : studentList)
						{
							PalmUser palmUserWithParentPhone = new PalmUser();
							palmUserWithParentPhone.UserId = palmUser.UserId;
							palmUserWithParentPhone.UserName = palmUser.UserName;
							palmUserWithParentPhone.Phone = studentUser.getPhone();
							palmUserWithParentPhone.ParentId = String.valueOf(studentUser.getParentId());
							receiverList_parse.add(palmUserWithParentPhone);
						}
					}
				}

				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseResult = "提交成功";
			} else
			{
				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();

			// 下面启用线程发送作业短信，并且保存作业
			final ArrayList<PalmUser> receiverListFinal = receiverList_parse;
			final String contentFinal = taskContent;
			final String contentImageFinal = taskContentImage;
			final User userFinal = loginUser;
			final Integer subjectIdFinal = taskSubjectId;
			new Thread(new Runnable()
			{
				public void run()
				{
					try
					{
						User user = userFinal;
						DBContextHolder.setDBType(user.getSchoolId());
						send(user, contentFinal, contentImageFinal, receiverListFinal, subjectIdFinal);

					} catch (Exception e)
					{
						log.error("发送短信失败,接收人id：" + userFinal.getUserId() + "\r\n" + e.getMessage());
					}
				}
			}).start();

		} catch (Exception e)
		{
			log.error("sendTaskByApiKey.do:" + e.getMessage());
		}
		return null;
	}

	// 保存短信以及保存作业内容
	private void send(User user, String content, String contentImage, ArrayList<PalmUser> receiverList, Integer subjectId) throws ParseException
	{

		boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐

		boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启

		boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐

		String currentTime = TimeUtil.getInstance().now();
		String currentDate = TimeUtil.date();
		// 保存到sms表中
		Sms sms = new Sms();
		sms.setContent(content);
		sms.setSenderId(user.getUserId());
		sms.setSenderName(user.getRealName());
		sms.setSmsLength(content.length()); // 短信长度
		sms.setPhoneCount(receiverList.size()); // 发送人数
		sms.setResult(0);// 短信回执状态
		sms.setReportAmount(0);
		sms.setSuccAmount(0);
		sms.setCreateTime(TimeUtil.getInstance().now());
		sms.setIsRealTime(Cons.SMS_REALTIME);// 1:即时发送
		sms.setSentTime(currentTime);
		sms.setType("5"); // 发送短信类型，0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知 4:校车5:作业发送
		sms.setModule(Cons.MODULE_TASK); // 作业发布

		Integer smsCount = 0;
		try
		{
			// 先查找2小时内是否发过该短信,超过可以重发, 要是不超过判断如果是同一个人就发送短信
			Map<String, Object> paramMap_sms = new HashMap<String, Object>();
			paramMap_sms.put("content", content);
			paramMap_sms.put("time", formatter.format((formatter.parse(currentTime).getTime() - 2 * 60 * 60 * 1000)));
			smsCount = smsService.loadSmsByContent(paramMap_sms);
		} catch (ParseException e1)
		{
			log.error("作业发布：" + e1.getMessage());
		}

		// 获取数据库中最新一条数据的短信总数smsSum 和 errorSmsSum
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Sms lastSms = smsService.getLastOneFromSms(paramMap);
		int smsSum = 0; // 短信发送总数
		try
		{
			smsSum = lastSms.getSmsSum();
		} catch (Exception e)
		{

		}
		int errorSmsSum = 0; // 短信发送总数
		try
		{
			errorSmsSum = lastSms.getErrorSmsSum();
		} catch (Exception e)
		{

		}

		sms.setSmsSum(smsSum);
		sms.setErrorSmsSum(errorSmsSum);
		// 保存到数据库, 并且返回smsId
		int smsId = smsService.addSms(sms);
		TaskHistory th = new TaskHistory();
		th.setClazzId(0);
		th.setCreateDate(currentDate);
		th.setSendUserId(user.getUserId());
		th.setTaskContent(content);
		th.setTaskContentImage(contentImage);
		th.setTaskSubjectId(subjectId);
		th.setSendUserName(user.getRealName());
		th.setCreateTime((formatter.parse(currentTime)).getTime() + "");
		int historyId = taskAssistantService.addTaskHistory(th);
		th.setHistoryId(historyId);

		// 本次短信的条数（65个字算一条短信）
		int count = ((int) content.length() / 65) + 1;
		for (PalmUser receiver : receiverList)
		{
			SmsDetail smsDetail = new SmsDetail();
			smsDetail.setContent(content);
			smsDetail.setSenderId(user.getUserId());
			smsDetail.setSenderName(user.getRealName());
			smsDetail.setReceiverId(Integer.valueOf(receiver.UserId));
			smsDetail.setPhone(receiver.Phone);
			smsDetail.setReceiverName(receiver.UserName);
			smsDetail.setSeq("");
			smsDetail.setReport("");
			smsDetail.setSmsId(smsId);
			smsDetail.setReportTime(currentTime);
			smsDetail.setCreateTime(currentTime);
			smsDetail.setType(sms.getType());
			smsDetail.setSentTime(currentTime);

			if (smsCount < 1)
			{
				if (schoolHasMessage)// 学校有短信套餐
				{
					if (isVirtualOpen)// 虚拟套餐开启直接发送
					{
						// 调用短信接口
						try
						{
							boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
									Integer.valueOf(receiver.ParentId), content, currentTime, 3);
							if (flag)
							{
								smsDetail.setStatus(0);// 发送成功
								smsSum += count;
							} else
							{
								smsDetail.setStatus(1);// 发送失败
								errorSmsSum += count;// 发送失败+1
							}

						} catch (Exception e)
						{
							log.error("TaskAssistantController private void send(" + e.getMessage());
							smsDetail.setStatus(1);// 发送失败
							errorSmsSum += count;// 发送失败+1
						}
					} else// 虚拟套餐关闭
					{
						if (isSchoolSingleMsg)// 是否有学校单条套餐 有判断条数
						{
							// 学校条数套餐剩余条数
							Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(user.getSchoolId());
							if (null != remainCount && remainCount > 0)// 有条数且大于0
							{
								// 调用短信接口
								try
								{
									boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
											Integer.valueOf(receiver.ParentId), content, currentTime, 3);
									if (flag)
									{
										smsDetail.setStatus(0);// 发送成功
										smsSum += count;
									} else
									{
										smsDetail.setStatus(1);// 发送失败
										errorSmsSum += count;// 发送失败+1
									}

								} catch (Exception e)
								{
									log.error("TaskAssistantController private void send(" + e.getMessage());
									smsDetail.setStatus(1);// 发送失败
									errorSmsSum += count;// 发送失败+1
								}
								orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
							} else// 没有学校条数套餐 判断学生是否购买短信套餐
							{
								// 先判断学生有没有购买过
								Map<String, Object> map = new HashMap<String, Object>();
								map.put("userId", receiver.UserId);
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
									try
									{
										boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
												Integer.valueOf(receiver.ParentId), content, currentTime, 3);
										if (flag)
										{
											smsDetail.setStatus(0);// 发送成功
											smsSum += count;
										} else
										{
											smsDetail.setStatus(1);// 发送失败
											errorSmsSum += count;// 发送失败+1
										}

									} catch (Exception e)
									{
										log.error("TaskAssistantController private void send(" + e.getMessage());
										smsDetail.setStatus(1);// 发送失败
										errorSmsSum += count;// 发送失败+1
									}
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
									errorSmsSum += count;// 发送失败+1
								}
							}

						} else// 没有判断学生是否购买服务费
						{
							// 先判断学生有没有购买过
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("userId", receiver.UserId);
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
								try
								{
									boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
											Integer.valueOf(receiver.ParentId), content, currentTime, 3);
									if (flag)
									{
										smsDetail.setStatus(0);// 发送成功
										smsSum += count;
									} else
									{
										smsDetail.setStatus(1);// 发送失败
										errorSmsSum += count;// 发送失败+1
									}

								} catch (Exception e)
								{
									log.error("TaskAssistantController private void send(" + e.getMessage());
									smsDetail.setStatus(1);// 发送失败
									errorSmsSum += count;// 发送失败+1
								}
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
								errorSmsSum += count;// 发送失败+1
							}
						}
					}
				} else// 学校无短信套餐 直接发送
				{
					// 调用短信接口
					try
					{
						boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone, Integer.valueOf(receiver.ParentId),
								content, currentTime, 3);
						if (flag)
						{
							smsDetail.setStatus(0);// 发送成功
							smsSum += count;
						} else
						{
							smsDetail.setStatus(1);// 发送失败
							errorSmsSum += count;// 发送失败+1
						}

					} catch (Exception e)
					{
						log.error("TaskAssistantController private void send(" + e.getMessage());
						smsDetail.setStatus(1);// 发送失败
						errorSmsSum += count;// 发送失败+1
					}
				}

			} else
			{
				// 发送短信 如果2小时内已经发送成功， 就不用发送了，
				Map<String, Object> paramMap_smsDetail = new HashMap<String, Object>();
				paramMap_smsDetail.put("phone", receiver.Phone);
				paramMap_smsDetail.put("content", content);
				paramMap_smsDetail.put("status", 0);// 查询成功的短信
				Integer smsDetailCount = smsService.loadSmsDetailByReceiverIdAndContent(paramMap_smsDetail);
				if (smsDetailCount < 1)
				{
					if (schoolHasMessage)// 学校有短信套餐
					{
						if (isVirtualOpen)// 虚拟套餐开启直接发送
						{
							// 调用短信接口
							try
							{
								boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
										Integer.valueOf(receiver.ParentId), content, currentTime, 3);
								if (flag)
								{
									smsDetail.setStatus(0);// 发送成功
									smsSum += count;
								} else
								{
									smsDetail.setStatus(1);// 发送失败
									errorSmsSum += count;// 发送失败+1
								}

							} catch (Exception e)
							{
								log.error("TaskAssistantController private void send(" + e.getMessage());
								smsDetail.setStatus(1);// 发送失败
								errorSmsSum += count;// 发送失败+1
							}
						} else// 虚拟套餐关闭
						{
							if (isSchoolSingleMsg)// 是否有学校单条套餐 有判断条数
							{
								// 学校条数套餐剩余条数
								Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(user.getSchoolId());
								if (null != remainCount && remainCount > 0)// 有条数且大于0
								{
									// 调用短信接口
									try
									{
										boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
												Integer.valueOf(receiver.ParentId), content, currentTime, 3);
										if (flag)
										{
											smsDetail.setStatus(0);// 发送成功
											smsSum += count;
										} else
										{
											smsDetail.setStatus(1);// 发送失败
											errorSmsSum += count;// 发送失败+1
										}

									} catch (Exception e)
									{
										log.error("TaskAssistantController private void send(" + e.getMessage());
										smsDetail.setStatus(1);// 发送失败
										errorSmsSum += count;// 发送失败+1
									}
									orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
								} else// 没有学校条数套餐 判断学生是否购买短信套餐
								{
									// 先判断学生有没有购买过
									Map<String, Object> map = new HashMap<String, Object>();
									map.put("userId", receiver.UserId);
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
										try
										{
											boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
													Integer.valueOf(receiver.ParentId), content, currentTime, 3);
											if (flag)
											{
												smsDetail.setStatus(0);// 发送成功
												smsSum += count;
											} else
											{
												smsDetail.setStatus(1);// 发送失败
												errorSmsSum += count;// 发送失败+1
											}

										} catch (Exception e)
										{
											log.error("TaskAssistantController private void send(" + e.getMessage());
											smsDetail.setStatus(1);// 发送失败
											errorSmsSum += count;// 发送失败+1
										}
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
										errorSmsSum += count;// 发送失败+1
									}
								}

							} else// 没有判断学生是否购买服务费
							{
								// 先判断学生有没有购买过
								Map<String, Object> map = new HashMap<String, Object>();
								map.put("userId", receiver.UserId);
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
									try
									{
										boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone,
												Integer.valueOf(receiver.ParentId), content, currentTime, 3);
										if (flag)
										{
											smsDetail.setStatus(0);// 发送成功
											smsSum += count;
										} else
										{
											smsDetail.setStatus(1);// 发送失败
											errorSmsSum += count;// 发送失败+1
										}

									} catch (Exception e)
									{
										log.error("TaskAssistantController private void send(" + e.getMessage());
										smsDetail.setStatus(1);// 发送失败
										errorSmsSum += count;// 发送失败+1
									}
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
									errorSmsSum += count;// 发送失败+1
								}
							}
						}
					} else// 学校无短信套餐 直接发送
					{
						// 调用短信接口
						try
						{
							boolean flag = commonService.sendSmsByDB(user.getSchoolId(), PUSHTYPE.TASKSENDPUSH, receiver.Phone, Integer.valueOf(receiver.ParentId),
									content, currentTime, 3);
							if (flag)
							{
								smsDetail.setStatus(0);// 发送成功
								smsSum += count;
							} else
							{
								smsDetail.setStatus(1);// 发送失败
								errorSmsSum += count;// 发送失败+1
							}

						} catch (Exception e)
						{
							log.error("TaskAssistantController private void send(" + e.getMessage());
							smsDetail.setStatus(1);// 发送失败
							errorSmsSum += count;// 发送失败+1
						}
					}

				} else
				{
					smsDetail.setStatus(0);// 发送成功
				}
			}
			smsService.addSmsDetail(smsDetail);
			// 保存到taskHistoryDetail中
			TaskHistoryDetail thd = new TaskHistoryDetail();
			thd.setCreateDate(currentDate);
			thd.setHistoryId(historyId);
			thd.setReciveUserId(Integer.valueOf(receiver.UserId));
			thd.setReciveUserName(receiver.UserName);
			thd.setCreateTime((formatter.parse(currentTime)).getTime() + "");
			taskAssistantService.addTaskHistoryDetail(thd);

			// 更新总共发送条数和发送失败总条数
			Map<String, Object> paramMap_update = new HashMap<String, Object>();
			paramMap_update.put("id", smsId);
			paramMap_update.put("smsSum", smsSum);
			paramMap_update.put("errorSmsSum", errorSmsSum);
			smsService.updateSms(paramMap_update);
		}
	}

	/**
	 * 查询所有学生，姓名， 年级， 班级
	 * 
	 * @param type
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getStudentListByApiKey.do")
	public String getStudentListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RichHttpResponse<List<Grade>> richHttpResponse = new RichHttpResponse<List<Grade>>();
		List<User> studentList = null;
		try
		{
			HashMap<Integer, Grade> gradeMap = new HashMap<Integer, Grade>();
			HashMap<Integer, Clazz> clazzMap = new HashMap<Integer, Clazz>();

			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("permissionCode", "addTask");

				studentList = userService.selectStudentListByRole(paramMap, loginUser);
				for (User student : studentList)
				{
					if (student.getClazzId() != null)
					{
						Clazz clz;
						Grade grade;
						if (!clazzMap.containsKey(student.getClazzId()))
						{
							clz = new Clazz();
							clz.ClazzId = student.getClazzId() + "";
							clz.ClazzName = student.getClazzName();
							clz.UserList = new ArrayList<PalmUser>();
							clazzMap.put(student.getClazzId(), clz);
							if (!gradeMap.containsKey(student.getGradeId()))
							{
								grade = new Grade();
								grade.GradeId = student.getGradeId() + "";
								grade.GradeName = student.getGradeName();
								grade.ClazzList = new ArrayList<Clazz>();
								gradeMap.put(student.getGradeId(), grade);
							} else
							{
								grade = gradeMap.get(student.getGradeId());
							}
							grade.ClazzList.add(clz);
						} else
						{
							clz = clazzMap.get(student.getClazzId());
							grade = gradeMap.get(student.getGradeId());
						}

						if (student.getUserId() != null)
						{
							PalmUser pu = new PalmUser();
							pu.UserId = student.getUserId() + "";
							pu.UserName = student.getRealName();
							clz.UserList.add(pu);

							grade.Total++;
						}
					}
				}
				List<Grade> gradelist = new ArrayList<Grade>(gradeMap.values());
				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseResult = "获取成功";
				richHttpResponse.ResponseObject = gradelist;
			} else
			{
				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
			log.error("getStudentListByApiKey.do:" + e.getMessage());
		}

		return null;
	}

	/**
	 * 老师获取发送的作业列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getSendTaskListByApiKey.do")
	public String getSendTaskListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RichHttpResponse<List<TaskDate>> richHttpResponse = new RichHttpResponse<List<TaskDate>>();
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			int number = StringUtil.toint(request.getParameter("number"));
			int page = StringUtil.toint(request.getParameter("page"));
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				if (number == 0)
				{
					number = 5;
				}
				if (page == 0)
				{
					page = 1;
				}
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("sendUserId", loginUser.getUserId());
				List<TaskDate> taskList = taskAssistantService.getTaskHistoryListInTeacher(number, page, paramMap);

				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseResult = "获取成功";
				richHttpResponse.ResponseObject = taskList;
			} else
			{
				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
			log.error("getSendTaskListByApiKey.do:" + e.getMessage());
		}
		return null;
	}

	/**
	 * 学生/家长获取接收的作业列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getReciveTaskListByApiKey.do")
	public String getReciveTaskListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RichHttpResponse<List<TaskDate>> richHttpResponse = new RichHttpResponse<List<TaskDate>>();
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			int number = StringUtil.toint(request.getParameter("number"));
			int page = StringUtil.toint(request.getParameter("page"));
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				if (number == 0)
				{
					number = 5;
				}
				if (page == 0)
				{
					page = 1;
				}
				List<TaskDate> taskList = new ArrayList<TaskDate>();
				Map<String, Object> paramMap = new HashMap<String, Object>();
				for (Role role : loginUser.getRoleList())
				{
					if (role.getRoleCode().equals("parent"))
					{
						// 家长通过userId,查询他所有小孩的id
						List<User> allChildren = commonService.getAllChildrenByUserId(loginUser.getUserId());

						List<Integer> ids = new ArrayList<Integer>();
						for (User children : allChildren)
						{
							// 添加小孩的userId，因为给家长发的短息都是存的小孩userId
							ids.add(children.getUserId());
						}
						paramMap.put("reviceUserIdList", ids);
						taskList = taskAssistantService.getTaskHistoryListInParent(number, page, paramMap);
						break;
					} else if (role.getRoleCode().equals("student"))
					{
						paramMap.put("reciveUserId", loginUser.getUserId());
						taskList = taskAssistantService.getTaskHistoryListInStudent(number, page, paramMap);
						break;
					}
				}

				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseResult = "获取成功";
				richHttpResponse.ResponseObject = taskList;
			} else
			{
				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
			log.error("getReciveTaskListByApiKey.do:" + e.getMessage());
		}
		return null;
	}
}
