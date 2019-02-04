package com.guotop.palmschool.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.check.entity.InoutAbnormalTotal;
import com.guotop.palmschool.check.entity.InoutMeeting;
import com.guotop.palmschool.check.service.AbnormalService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.dormitory.entity.InoutDormitory;
import com.guotop.palmschool.entity.AbnormalInformation;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.Device;
import com.guotop.palmschool.entity.Inout;
import com.guotop.palmschool.entity.OrderMessageUser;
import com.guotop.palmschool.entity.OrderUserMessageDetail;
import com.guotop.palmschool.entity.Schedule;
import com.guotop.palmschool.entity.ScheduleClazz;
import com.guotop.palmschool.entity.ScheduleTeacher;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserRole;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.meeting.entity.Meeting;
import com.guotop.palmschool.rest.entity.PushDataByJson;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.schoolbus.entity.OnSchoolBus;
import com.guotop.palmschool.schoolbus.entity.PointInfo;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSchedule;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSmsDetail;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.CardService;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.InoutService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.SmsService;
import com.guotop.palmschool.system.entity.InformationType;
import com.guotop.palmschool.system.service.InformationTypeService;
import com.guotop.palmschool.util.CollectionUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 进出记录业务类实现类
 * 
 * @author zhou
 */
@Service("inoutService")
public class InoutServiceImpl extends BaseService implements InoutService
{
	/**
	 * 日志
	 */
	private Log logger = LogFactory.getLog(InoutServiceImpl.class);

	@Resource
	private CommonService commonService;

	@Resource
	private AbnormalService abnormalService;

	@Resource
	private DepartmentService departmentService;

	@Resource
	private ScheduleService scheduleService;

	@Resource
	private SchoolService schoolService;

	@Resource
	private InformationTypeService informationTypeService;

	@Resource
	private SmsService smsService;

	@Resource
	private CardService cardService;

	@Resource
	private OrderMessageService orderMessageService;

	/**
	 * 根据条件查询进出记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @return 进出记录/分页 20151130
	 */
	@SuppressWarnings("unchecked")
	public Pages getInoutList(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Inout> list = new ArrayList<Inout>();

		String roleCode = (String) paramMap.get("roleCode");

		/**
		 * 校长或者学校管理员（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Inout.getInoutCountAsHeadMaster", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsHeadMaster", paramMap);

		}

		/**
		 * 家长 （自己和孩子的记录）
		 */
		else if (roleCode != null && roleCode.equals("parent"))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Inout.getInoutCountAsParent", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);

			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsParent", paramMap);
		}

		/**
		 * 学生 （自己和家长）
		 */
		else if (roleCode != null && roleCode.equals("student"))
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Inout.getInoutCountAsStudent", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsStudent", paramMap);
		}
		/**
		 * 教职工（ 教师，部门管理员，职工，班主任根据权限来判断能查到的信息）
		 */
		else
		{
			List<Integer> departmentIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "inoutManager", 1);

			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "inoutManager", 0);
			paramMap.put("type", "1");
			paramMap.put("departmentIdList", departmentIdList);
			paramMap.put("clazzIdList", clazzIdList);
			allRow = this.getBaseDao().getAllRowCountByCondition("Inout.getInoutCountAsTeachingStaff", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsTeachingStaff", paramMap);
		}

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

	/**
	 * 根据条件查询进出记录 /分页查询(APP)
	 * 
	 * @param paramMap
	 *            条件
	 * @return 进出记录/分页 20160128
	 */
	@SuppressWarnings("unchecked")
	public List<Inout> getAppInoutList(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		List<Inout> list = new ArrayList<Inout>();

		String roleCode = (String) paramMap.get("roleCode");

		/**
		 * 校长或者学校管理员（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsHeadMaster", paramMap);

		}

		/**
		 * 家长 （自己和孩子的记录）
		 */
		else if (roleCode.equals("parent"))
		{

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);

			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsParent", paramMap);
		}

		/**
		 * 学生 （自己和家长）
		 */
		else if (roleCode.equals("student"))
		{

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsStudent", paramMap);
		}
		/**
		 * 教职工（ 教师，部门管理员，职工，班主任根据权限来判断能查到的信息）
		 */
		else
		{
			List<Integer> departmentIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "inoutManager", 1);

			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "inoutManager", 0);

			paramMap.put("departmentIdList", departmentIdList);
			paramMap.put("clazzIdList", clazzIdList);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsTeachingStaff", paramMap);
		}

		return list;
	}

	/**
	 * 新增出入记录(刷卡产生)
	 * 
	 * @param inout
	 *            待新增的出入记录
	 * @param ipSwitch
	 *            0:ip 1:deviceCode
	 * @param position
	 *            记录点位置
	 * @param isSendSMS
	 *            打卡时间超过10min之后才发来的数据只保存到inout表中，不推送不短信
	 * @result true:保存成功 false:保存失败 20151210
	 */
	@SuppressWarnings("unchecked")
	public boolean addInout(Inout inout, String ipSwitch, String position, boolean isSendSMS)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (StringUtil.isEmpty(inout.getCreateTime()))
		{
			inout.setCreateTime(formatter.format(new Date()));
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		boolean result = false;
		boolean isGateInout = false;
		boolean isDormitoryInout = false;

		try
		{
			/**
			 * 根据code查找关联数据，插入inout中
			 */

			/**
			 * 关联用户
			 */
			User user = (User) getBaseDao().selectObjectByObject("User.getUserByCardCode", inout.getCode());
			if (user != null)
			{

				School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(DBContextHolder.getDBType()));

				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String[] date = df.format(new Date()).split(" ");
				paramMap.put("day", date[0]);// 刷卡的日期
				paramMap.put("time", date[1]);// 刷卡的时间
				Date nowTime = (Date) df.parse(df.format(new Date()));// 刷卡时间

				inout.setUserId(user.getUserId());
				paramMap.put("userId", user.getUserId());

				String positionType = null;
				Integer placeId = null;
				/**
				 * 关联记录点
				 */
				paramMap.put("ipSwitch", ipSwitch);
				paramMap.put("position", position);

				if (position.equals("1001") || position.startsWith("R"))
				{
					positionType = "4";
				} else
				{
					Device deviceEntity = (Device) getBaseDao().selectObjectByObject("Device.getDeviceByIpOrDeviceCode", paramMap);
					if (deviceEntity != null)
					{
						try
						{
							inout.setPosition(deviceEntity.getId());
							if (inout.getStatus() == null)
							{
								inout.setStatus(Integer.valueOf(deviceEntity.getInoutType()));
							}
							positionType = deviceEntity.getPositionType();
							placeId = deviceEntity.getPlaceId();
						} catch (Exception e)
						{
							logger.error("ipSwitch:" + ipSwitch + ",position:" + position + "查不到记录点,错误信息:" + e.getMessage());
						}
					} else
					{
						logger.error("ipSwitch:" + ipSwitch + ",position:" + position + "查不到记录点");
					}

				}

				String content = null;
				int pushType = -1;
				int pushContentType = 0;
				String title = null;
				boolean isAbnormalLeave = false;
				boolean isAbnormalIn = false;
				Integer infoType = null;// 信息提醒类型 1 只发送短信 2 只推送 3 即发送信息也推送 4
										// 即不发送信息也不推送
				AbnormalInformation abnormalInfo = new AbnormalInformation();

				PUSHTYPE push = PUSHTYPE.OUTSCHOOLPUSH;
				// 校门
				if (Cons.POSITIONTYPE_SCHOOLGATE.equals(positionType))
				{
					isGateInout = true;
					getBaseDao().addObject("Inout.addInout", inout);
					boolean flag = inout.getStatus() == 2;
					// 判断是否迟到早退，是则记录异常
					List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(date[0]);

					Integer informationType = null;

					boolean scheduleFlag = false;
					if ("student".equals(user.getRoleCode()))
					{

						ScheduleClazz scheduleClazz = scheduleService.getScheduleClazzByUserIdAndLiveingDate(date[0], user.getUserId());
						if (scheduleClazz == null)
						{
							scheduleFlag = true;
						} else
						{

							isAbnormalLeave = false;
							isAbnormalIn = false;
							String amStart = scheduleClazz.getAmStartTime() + ":00";
							String amEnd = scheduleClazz.getAmEndTime() + ":00";
							String pmStart = scheduleClazz.getPmStartTime() + ":00";
							String pmEnd = scheduleClazz.getPmEndTime() + ":00";
							String beginTime = scheduleClazz.getBeginTime() + ":00";
							String endTime = scheduleClazz.getEndTime() + ":00";
							int type = scheduleClazz.getType();

							if (type == 0)// 分段
							{
								if (!amStart.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(amStart)) && nowTime.before(formatter.parse(amEnd)))// 上午迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}

								}
								if (!pmStart.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(pmStart)) && nowTime.before(formatter.parse(pmEnd)))// 下午迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}
								}
							} else
							// 整天
							{
								if (!beginTime.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(beginTime)) && nowTime.before(formatter.parse(endTime)))// 迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}
								}
							}

						}
					} else
					{
						ScheduleTeacher scheduleTeacher = scheduleService.getScheduleTeacherByUserIdAndLiveingDate(date[0], user.getUserId());
						if (scheduleTeacher == null)
						{
							scheduleFlag = true;
						} else
						{

							isAbnormalLeave = false;
							isAbnormalIn = false;
							String amStart = scheduleTeacher.getAmStartTime() + ":00";
							String amEnd = scheduleTeacher.getAmEndTime() + ":00";
							String pmStart = scheduleTeacher.getPmStartTime() + ":00";
							String pmEnd = scheduleTeacher.getPmEndTime() + ":00";
							String beginTime = scheduleTeacher.getBeginTime() + ":00";
							String endTime = scheduleTeacher.getEndTime() + ":00";
							int type = scheduleTeacher.getType();

							if (type == 0)// 分段
							{
								if (!amStart.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(amStart)) && nowTime.before(formatter.parse(amEnd)))// 上午迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}

								}
								if (!pmStart.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(pmStart)) && nowTime.before(formatter.parse(pmEnd)))// 下午迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}
								}
							} else
							// 整天
							{
								if (!beginTime.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(beginTime)) && nowTime.before(formatter.parse(endTime)))// 迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}
								}
							}

						}
					}

					if (scheduleFlag)
					{
						for (Schedule s : list)
						{
							isAbnormalLeave = false;
							isAbnormalIn = false;
							String amStart = s.getAmStartTime() + ":00";
							String amEnd = s.getAmEndTime() + ":00";
							String pmStart = s.getPmStartTime() + ":00";
							String pmEnd = s.getPmEndTime() + ":00";
							String beginTime = s.getBeginTime() + ":00";
							String endTime = s.getEndTime() + ":00";
							int type = s.getType();

							if (type == 0)// 分段
							{
								if (!amStart.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(amStart)) && nowTime.before(formatter.parse(amEnd)))// 上午迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}

								}
								if (!pmStart.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(pmStart)) && nowTime.before(formatter.parse(pmEnd)))// 下午迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}
								}
							} else
							// 整天
							{
								if (!beginTime.equals("null:00"))
								{
									if (nowTime.after(formatter.parse(beginTime)) && nowTime.before(formatter.parse(endTime)))// 迟到早退
									{
										if (flag)
										{
											isAbnormalLeave = true;
										} else
										{
											isAbnormalIn = true;
										}
									}
								}
							}
						}
					}

					if ("student".equals(user.getRoleCode()))
					{
						if (isAbnormalIn)
						{
							push = PUSHTYPE.INSCHOOLPUSH;
							informationType = 8003;
							content = user.getRealName() + "家长您好: 您的孩子于" + formatter.format(new Date()) + "进入学校，现在是上课时间，系统将记录为迟到, 如有问题请及时和班主任联系。"
									+ school.getSchoolName();

						} else
						{
							content = user.getRealName() + "家长您好: 您的孩子于" + formatter.format(new Date()) + (flag ? "离开" : "进入") + "学校，如有问题请及时和班主任联系。"
									+ school.getSchoolName();
							if (flag)
							{
								push = PUSHTYPE.OUTSCHOOLPUSH;
								informationType = 8002;
							} else
							{
								push = PUSHTYPE.INSCHOOLPUSH;
								informationType = 8001;
							}
						}

					} else if ("parent".equals(user.getRoleCode()))
					{
						if (isAbnormalIn)
						{
							push = PUSHTYPE.INSCHOOLPUSH;
							informationType = 8003;
							content = user.getRealName() + "家长您好: 您于" + formatter.format(new Date()) + "进入学校！" + school.getSchoolName();

						} else
						{
							content = user.getRealName() + "家长您好: 您于" + formatter.format(new Date()) + (flag ? "离开" : "进入") + "学校！" + school.getSchoolName();
							if (flag)
							{
								push = PUSHTYPE.OUTSCHOOLPUSH;
								informationType = 8002;
							} else
							{
								push = PUSHTYPE.INSCHOOLPUSH;
								informationType = 8001;
							}
						}

					} else
					{
						if (isAbnormalLeave)
						{
							push = PUSHTYPE.OUTSCHOOLPUSH;
							informationType = 8004;
							content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + "离开学校，现在是上课时间，系统将记录您为早退，如有疑问请联系学校教务处。"
									+ school.getSchoolName();
						} else if (isAbnormalIn)
						{
							push = PUSHTYPE.INSCHOOLPUSH;
							informationType = 8003;
							content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + "进入学校，现在是上课时间，系统将记录您为迟到，如有疑问请联系学校教务处。"
									+ school.getSchoolName();
						} else
						{
							content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + (flag ? "离开" : "进入") + "学校，祝您生活快乐！"
									+ school.getSchoolName();
							if (flag)
							{
								push = PUSHTYPE.OUTSCHOOLPUSH;
								informationType = 8002;
							} else
							{
								push = PUSHTYPE.INSCHOOLPUSH;
								informationType = 8001;
							}
						}
					}

					pushType = PUSHTYPE.OUTSCHOOLPUSH.getType();

					pushContentType = flag ? PUSHTYPE.OUTSCHOOLPUSH.getContentType() : PUSHTYPE.INSCHOOLPUSH.getContentType();

					title = flag ? PUSHTYPE.OUTSCHOOLPUSH.getName() : PUSHTYPE.INSCHOOLPUSH.getName();

					if (inout.getImgPath() != null && !"".equals(inout.getImgPath()))
					{
						pushType = PUSHTYPE.INTEGRATEDMACHINE.getType();
						pushContentType = PUSHTYPE.INTEGRATEDMACHINE.getContentType();
					}

					InformationType information = informationTypeService.getInformationTypeByInformationType(informationType);

					infoType = information.getType();
				}
				// 宿舍:预留
				else if (Cons.POSITIONTYPE_DORMITORY.equals(positionType))
				{
					isDormitoryInout = true;
					InoutDormitory inoutDormitory = new InoutDormitory();
					PropertyUtils.copyProperties(inoutDormitory, inout);
					getBaseDao().addObject("Inout.addInoutDormitory", inoutDormitory);

					boolean flag = inoutDormitory.getStatus() == 2;
					content = "您好：您的孩子于" + formatter.format(new Date()) + (flag ? "离开宿舍" : "进入宿舍") + ",如有问题请及时和班主任联系。" + school.getSchoolName();
					pushType = PUSHTYPE.OUTDORMITORYPUSH.getType();
					pushContentType = flag ? PUSHTYPE.OUTDORMITORYPUSH.getContentType() : PUSHTYPE.INDORMITORYPUSH.getContentType();
					title = flag ? PUSHTYPE.OUTDORMITORYPUSH.getName() : PUSHTYPE.INDORMITORYPUSH.getName();

					Integer informationType = null;

					if (flag)
					{
						push = PUSHTYPE.OUTDORMITORYPUSH;
						informationType = 4002;
					} else
					{
						push = PUSHTYPE.INDORMITORYPUSH;
						informationType = 4001;
					}
					InformationType information = informationTypeService.getInformationTypeByInformationType(informationType);

					infoType = information.getType();
				}
				// 会议
				else if (Cons.POSITIONTYPE_MEETING.equals(positionType))
				{

					/**
					 * 获取参与会议的id
					 */
					InoutMeeting inoutMeeting = new InoutMeeting();
					PropertyUtils.copyProperties(inoutMeeting, inout);

					paramMap.put("place", placeId);
					paramMap.put("userId", user.getUserId());

					List<Meeting> meetingList = (List<Meeting>) getBaseDao().selectListByObject("Meeting.getMeetingListByPlaceAndTimeAndUserId", paramMap);
					if (!CollectionUtil.isEmpty(meetingList))
					{
						for (Meeting meeting : meetingList)
						{
							inoutMeeting.setMeetingId(meeting.getId());
							inoutMeeting.setPosition(meeting.getPlace());

							Date starTime = (Date) df.parse(meeting.getStartTime());// 会议开始时间
							Date endTime = (Date) df.parse(meeting.getEndTime());// 会议结束时间

							paramMap.put("meetingId", meeting.getId());
							paramMap.put("attendeeId", user.getUserId());

							if (nowTime.getTime() < starTime.getTime())
							{
								inoutMeeting.setStatus(0);
								paramMap.put("attenStatus", 0);
								getBaseDao().updateObject("MeetingDetail.updateAttensta", paramMap);
								break;
							} else if (starTime.getTime() < nowTime.getTime() && nowTime.getTime() < endTime.getTime())
							{
								inoutMeeting.setStatus(1);
								paramMap.put("attenStatus", 1);
								getBaseDao().updateObject("MeetingDetail.updateAttensta", paramMap);
								break;
							}
						}
					} else
					{
						logger.error("没有相关的会议,错误信息……");
					}

					getBaseDao().addObject("Inout.addInoutMeeting", inoutMeeting);
					infoType = 0;
				}
				// 校车:预留
				else if (Cons.POSITIONTYPE_SCHOOLBUS.equals(positionType))
				{
					infoType = 0;
					OnSchoolBus onSchoolBus = new OnSchoolBus();
					PropertyUtils.copyProperties(onSchoolBus, inout);

					SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
					Date now = (Date) sdf.parse(sdf.format(new Date()));// 刷卡时间

					List<SchoolBusSchedule> schoolBusScheduleList = (List<SchoolBusSchedule>) getBaseDao()
							.selectListByObject("SchoolBusSchedule.getSchoolBusScheduleListByDay", paramMap);

					if (schoolBusScheduleList.size() > 0)
					{
						Calendar calendar = Calendar.getInstance();
						calendar.set(Calendar.MINUTE, calendar.get(Calendar.MINUTE) - 5); // 分
						paramMap.put("code", inout.getCode());
						paramMap.put("beginTime", df.format(calendar.getTime()));
						paramMap.put("nowTime", df.format(new Date()));
						// 查询当前刷卡用户在五分钟内是否刷过卡
						List<OnSchoolBus> cardRecordsList = (List<OnSchoolBus>) getBaseDao().selectListByObject("SchoolBus.getSchoolBusOn", paramMap);
						if (cardRecordsList.size() == 0)
						{
							for (SchoolBusSchedule schoolBusSchedule : schoolBusScheduleList)
							{
								Date startTime = (Date) sdf.parse(schoolBusSchedule.getStartTime());
								Date endTime = (Date) sdf.parse(schoolBusSchedule.getEndTime());
								if (startTime.getTime() < now.getTime() && now.getTime() < endTime.getTime())
								{
									Integer type = schoolBusSchedule.getType();
									doSchoolBusInout(onSchoolBus, user, type, inout, paramMap);
									break;
								}
							}

							onSchoolBus.setPosition(position);
							getBaseDao().addObject("Inout.addOnSchoolBus", onSchoolBus);
						}

					}

				}

				if (isSendSMS && (infoType == 1 || infoType == 2 || infoType == 3))
				{

					boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐

					boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启

					boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐

					// 若是学生，则找寻其家长，发送推送消息
					if (isGateInout)// 校门推送消息
					{
						List<User> parentList = null;
						List<PushItem> piList = null;
						if ("student".equals(user.getRoleCode()))
						{
							parentList = new ArrayList<User>();
							parentList = getBaseDao().selectListByObject("User.getParentByStudentId", user.getUserId());

							for (User parent : parentList)
							{
								piList = new ArrayList<PushItem>();
								if (infoType == 1 || infoType == 3)// 1 只发送短信
																	// 3短信+推送
								{
									if (schoolHasMessage)// 学校有短信套餐
									{
										if (isVirtualOpen)// 虚拟套餐开启直接发送
										{
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
													parent.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, parent, 0, "5");
											} else
											{
												smsService.saveSmsDetail(content, user, parent, 1, "5");
											}
										} else// 虚拟套餐关闭
										{
											if (isSchoolSingleMsg)// 是否有学校单条套餐
																	// 有判断条数
											{
												// 学校条数套餐剩余条数
												Integer remainCount = orderMessageService
														.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
												if (null != remainCount && remainCount > 0)// 有条数且大于0
												{
													// 调用短信接口
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "5");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "5");
													}
													orderMessageService.updateOrderMessageSchoolById(String.valueOf(school.getSchoolId()));
												} else// 没有学校条数套餐 判断学生是否购买短信套餐
												{
													// 先判断学生有没有购买过
													Map<String, Object> studentMap = new HashMap<String, Object>();
													studentMap.put("userId", user.getUserId());
													studentMap.put("status", 0);
													OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
														boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
																parent.getUserId(), content, null, infoType);
														if (flag)
														{
															smsService.saveSmsDetail(content, user, parent, 0, "5");
														} else
														{
															smsService.saveSmsDetail(content, user, parent, 1, "5");
														}

														int smscount = ((int) content.length() / 65) + 1;
														int messcount = 0;
														if (messageUser.getType() == 1)
														{
															// 如果短信剩余条数小于本次短信条说
															// 剩余条数为0
															// 如果大于等于本次短信条说
															// 则本次剩余条数为原剩余条数减本次短信条数
															if (messageUser.getCount() < smscount)
															{
																messcount = 0;
															} else
															{
																messcount = messageUser.getCount() - smscount;
															}
															studentMap.put("count", messcount);
															studentMap.put("id", messageUser.getId());
															orderMessageService.updateOrederMessageUserCount(studentMap);

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
														smsService.saveSmsDetail(content, user, parent, 2, "5");
													}
												}

											} else// 没有判断学生是否购买服务费
											{
												// 先判断学生有没有购买过
												Map<String, Object> studentMap = new HashMap<String, Object>();
												studentMap.put("userId", user.getUserId());
												studentMap.put("status", 0);
												OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "5");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "5");
													}

													int smscount = ((int) content.length() / 65) + 1;
													int messcount = 0;
													if (messageUser.getType() == 1)
													{
														// 如果短信剩余条数小于本次短信条说
														// 剩余条数为0 如果大于等于本次短信条说
														// 则本次剩余条数为原剩余条数减本次短信条数
														if (messageUser.getCount() < smscount)
														{
															messcount = 0;
														} else
														{
															messcount = messageUser.getCount() - smscount;
														}
														studentMap.put("count", messcount);
														studentMap.put("id", messageUser.getId());
														orderMessageService.updateOrederMessageUserCount(studentMap);

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
													smsService.saveSmsDetail(content, user, parent, 2, "5");
												}
											}

										}

									} else// 学校无短信套餐直接发送
									{
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
												parent.getUserId(), content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, parent, 0, "5");
										} else
										{
											smsService.saveSmsDetail(content, user, parent, 1, "5");
										}
									}

								} else if (infoType == 2)// 2 只推送
								{
									PushItem pi = new PushItem();
									pi.receiverId = parent.getUserId();
									pi.channels = parent.getBaiduChannelId();
									pi.deviceType = String.valueOf(parent.getDeviceType());
									pi.PushContent = content;
									pi.PushType = pushType;
									pi.PushContentType = pushContentType;
									pi.title = title;
									pi.schoolId = String.valueOf(school.getSchoolId());
									piList.add(pi);
									if (inout.getImgPath() != null && !"".equals(inout.getImgPath()))
									{
										pi.PushImage = inout.getImgPath();
									}

									if (isAbnormalLeave || isAbnormalIn)
									{
										if (inout.getStatus() == 2)
										{
											abnormalInfo.setType(1);
										} else
										{
											abnormalInfo.setType(0);
										}
										abnormalInfo.setContent(content);
										abnormalInfo.setUserId(parent.getUserId());
										abnormalInfo.setCreateTime(formatter.format(new Date()));
										abnormalService.addAbnormalInfo(abnormalInfo);
									}

									commonService.pushMsg(piList, false);// 消息推送
								}
							}

						} else
						{
							if (infoType == 1 || infoType == 3)// 1 只发送短信 3短信+推送
							{
								if (schoolHasMessage)// 学校有短信套餐
								{
									if (isVirtualOpen)// 虚拟套餐开启直接发送
									{
										// 调用短信接口
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
												content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, user, 0, "5");
										} else
										{
											smsService.saveSmsDetail(content, user, user, 1, "5");
										}
									} else// 虚拟套餐关闭
									{
										if (isSchoolSingleMsg)// 有学校条数套餐
										{
											// 学校条数套餐剩余条数
											Integer remainCount = orderMessageService
													.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
											if (null != remainCount && remainCount > 0)
											{
												// 调用短信接口
												boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
														user.getUserId(), content, null, infoType);
												if (flag)
												{
													smsService.saveSmsDetail(content, user, user, 0, "5");
												} else
												{
													smsService.saveSmsDetail(content, user, user, 1, "5");
												}
												orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
											} else
											{
												// "1":发送失败 "2":没有缴纳服务费
												smsService.saveSmsDetail(content, user, user, 2, "5");
											}
										} else// 无学校条数套餐 直接发送
										{
											// 调用短信接口
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
													user.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, user, 0, "5");
											} else
											{
												smsService.saveSmsDetail(content, user, user, 1, "5");
											}
										}
									}

								} else// 学校无短信套餐 直接发送
								{
									// 调用短信接口
									boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
											content, null, infoType);
									if (flag)
									{
										smsService.saveSmsDetail(content, user, user, 0, "5");
									} else
									{
										smsService.saveSmsDetail(content, user, user, 1, "5");
									}
								}

							} else if (infoType == 2)
							{
								piList = new ArrayList<PushItem>();
								PushItem pi = new PushItem();
								pi.receiverId = user.getUserId();
								pi.channels = user.getBaiduChannelId();
								pi.deviceType = String.valueOf(user.getDeviceType());
								pi.PushContent = content;
								pi.PushType = pushType;
								pi.PushContentType = pushContentType;
								pi.title = title;
								pi.schoolId = String.valueOf(school.getSchoolId());
								piList.add(pi);
								if (isAbnormalLeave || isAbnormalIn)
								{
									if (inout.getStatus() == 2)
									{
										abnormalInfo.setType(1);
									} else
									{
										abnormalInfo.setType(0);
									}
									abnormalInfo.setContent(content);
									abnormalInfo.setUserId(user.getUserId());
									abnormalInfo.setCreateTime(formatter.format(new Date()));
									abnormalService.addAbnormalInfo(abnormalInfo);
								}
								commonService.pushMsg(piList, false);// 消息推送
							}

						}

					} else if (isDormitoryInout)// 宿舍推送
					{

						List<User> parentList = null;
						List<PushItem> piList = null;
						if ("student".equals(user.getRoleCode()))
						{
							parentList = new ArrayList<User>();
							parentList = getBaseDao().selectListByObject("User.getParentByStudentId", user.getUserId());

							for (User parent : parentList)
							{
								piList = new ArrayList<PushItem>();
								if (infoType == 1 || infoType == 3)// 1
																	// 只发送短信3短信+推送
								{
									if (schoolHasMessage)// 学校有短信套餐
									{
										if (isVirtualOpen)// 虚拟套餐开启直接发送
										{
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
													parent.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, parent, 0, "8");
											} else
											{
												smsService.saveSmsDetail(content, user, parent, 1, "8");
											}
										} else// 虚拟套餐关闭
										{
											if (isSchoolSingleMsg)// 是否有学校单条套餐
																	// 有判断条数
											{
												// 学校条数套餐剩余条数
												Integer remainCount = orderMessageService
														.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
												if (null != remainCount && remainCount > 0)// 有条数且大于0
												{
													// 调用短信接口
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "8");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "8");
													}
													orderMessageService.updateOrderMessageSchoolById(String.valueOf(school.getSchoolId()));
												} else// 没有学校条数套餐 判断学生是否购买短信套餐
												{
													// 先判断学生有没有购买过
													Map<String, Object> studentMap = new HashMap<String, Object>();
													studentMap.put("userId", user.getUserId());
													studentMap.put("status", 0);
													OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
														boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
																parent.getUserId(), content, null, infoType);
														if (flag)
														{
															smsService.saveSmsDetail(content, user, parent, 0, "8");
														} else
														{
															smsService.saveSmsDetail(content, user, parent, 1, "8");
														}

														int smscount = ((int) content.length() / 65) + 1;
														int messcount = 0;
														if (messageUser.getType() == 1)
														{
															// 如果短信剩余条数小于本次短信条说
															// 剩余条数为0
															// 如果大于等于本次短信条说
															// 则本次剩余条数为原剩余条数减本次短信条数
															if (messageUser.getCount() < smscount)
															{
																messcount = 0;
															} else
															{
																messcount = messageUser.getCount() - smscount;
															}
															studentMap.put("count", messcount);
															studentMap.put("id", messageUser.getId());
															orderMessageService.updateOrederMessageUserCount(studentMap);

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
														smsService.saveSmsDetail(content, user, parent, 2, "8");
													}
												}

											} else// 没有判断学生是否购买服务费
											{
												// 先判断学生有没有购买过
												Map<String, Object> studentMap = new HashMap<String, Object>();
												studentMap.put("userId", user.getUserId());
												studentMap.put("status", 0);
												OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "8");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "8");
													}

													int smscount = ((int) content.length() / 65) + 1;
													int messcount = 0;
													if (messageUser.getType() == 1)
													{
														// 如果短信剩余条数小于本次短信条说
														// 剩余条数为0 如果大于等于本次短信条说
														// 则本次剩余条数为原剩余条数减本次短信条数
														if (messageUser.getCount() < smscount)
														{
															messcount = 0;
														} else
														{
															messcount = messageUser.getCount() - smscount;
														}
														studentMap.put("count", messcount);
														studentMap.put("id", messageUser.getId());
														orderMessageService.updateOrederMessageUserCount(studentMap);

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
													smsService.saveSmsDetail(content, user, parent, 2, "8");
												}
											}

										}

									} else// 学校无短信套餐直接发送
									{
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
												parent.getUserId(), content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, parent, 0, "8");
										} else
										{
											smsService.saveSmsDetail(content, user, parent, 1, "8");
										}
									}

								} else if (infoType == 2)// 2 只推送
								{
									PushItem pi = new PushItem();
									pi.receiverId = parent.getUserId();
									pi.channels = parent.getBaiduChannelId();
									pi.deviceType = String.valueOf(parent.getDeviceType());
									pi.PushContent = content;
									pi.PushType = pushType;
									pi.PushContentType = pushContentType;
									pi.title = title;
									pi.schoolId = String.valueOf(school.getSchoolId());
									piList.add(pi);
									commonService.pushMsg(piList, false);// 消息推送
								}
							}

						} else
						{
							if (infoType == 1 || infoType == 3)
							{
								if (schoolHasMessage)// 学校有短信套餐
								{
									if (isVirtualOpen)// 虚拟套餐开启直接发送
									{
										// 调用短信接口
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
												content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, user, 0, "8");
										} else
										{
											smsService.saveSmsDetail(content, user, user, 1, "8");
										}
									} else// 虚拟套餐关闭
									{
										if (isSchoolSingleMsg)// 有学校条数套餐
										{
											// 学校条数套餐剩余条数
											Integer remainCount = orderMessageService
													.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
											if (null != remainCount && remainCount > 0)
											{
												// 调用短信接口
												boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
														user.getUserId(), content, null, infoType);
												if (flag)
												{
													smsService.saveSmsDetail(content, user, user, 0, "8");
												} else
												{
													smsService.saveSmsDetail(content, user, user, 1, "8");
												}
												orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
											} else
											{
												// "1":发送失败 "2":没有缴纳服务费
												smsService.saveSmsDetail(content, user, user, 2, "8");
											}
										} else// 无学校条数套餐 直接发送
										{
											// 调用短信接口
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
													user.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, user, 0, "8");
											} else
											{
												smsService.saveSmsDetail(content, user, user, 1, "8");
											}
										}
									}

								} else// 学校无短信套餐 直接发送
								{
									// 调用短信接口
									boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
											content, null, infoType);
									if (flag)
									{
										smsService.saveSmsDetail(content, user, user, 0, "8");
									} else
									{
										smsService.saveSmsDetail(content, user, user, 1, "8");
									}
								}

							} else if (infoType == 2)
							{
								piList = new ArrayList<PushItem>();
								PushItem pi = new PushItem();
								pi.receiverId = user.getUserId();
								pi.channels = user.getBaiduChannelId();
								pi.deviceType = String.valueOf(user.getDeviceType());
								pi.PushContent = content;
								pi.PushType = pushType;
								pi.PushContentType = pushContentType;
								pi.title = title;
								pi.schoolId = String.valueOf(school.getSchoolId());
								piList.add(pi);
								commonService.pushMsg(piList, false);// 消息推送
							}
						}
					}

				}

			} else
			{
				logger.error("卡号:" + inout.getCode() + "查不到关联用户!");
				result = false;
			}

			result = true;

		} catch (Exception e)
		{
			e.printStackTrace();
			result = false;
		}
		return result;
	}

	/**
	 * 新增出入记录(刷卡产生) 用于新读卡器及卡编号规则
	 * 
	 * @param inout
	 *            待新增的出入记录
	 * @param ipSwitch
	 *            0:ip 1:deviceCode
	 * @param position
	 *            记录点位置
	 * @param isSendSMS
	 *            校园一体机打开超过10min之后才发来的数据只保存到inout表中，不推送不短信
	 * @return true:保存成功 false:保存失败
	 */
	@SuppressWarnings("unchecked")
	public boolean addNewInout(Inout inout, String ipSwitch, String position, boolean isSendSMS)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (StringUtil.isEmpty(inout.getCreateTime()))
		{
			inout.setCreateTime(formatter.format(new Date()));
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		boolean result = false;
		boolean isGateInout = false;
		boolean isDormitoryInout = false;

		try
		{
			/**
			 * 根据code查找关联数据，插入inout中
			 */

			/**
			 * 关联用户
			 */
			User user = (User) getBaseDao().selectObjectByObject("User.getUserByCardCode", inout.getCode());
			if (null == user)
			{
				logger.error("卡号:" + inout.getCode() + "查不到关联用户!");
				result = false;
				return result;
			}
			School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(DBContextHolder.getDBType()));

			String[] date = inout.getCreateTime().split(" ");
			paramMap.put("day", date[0]);// 刷卡的日期
			paramMap.put("time", date[1]);// 刷卡的时间
			Date nowTime = (Date) formatter.parse(inout.getCreateTime());// 刷卡时间

			String positionType = null;
			Integer placeId = null;
			/**
			 * 关联记录点
			 */
			paramMap.put("ipSwitch", ipSwitch);
			paramMap.put("position", position);
			paramMap.put("userId", user.getUserId());

			Device deviceEntity = (Device) getBaseDao().selectObjectByObject("Device.getDeviceByIpOrDeviceCode", paramMap);
			if (null == deviceEntity)
			{
				logger.error("ipSwitch:" + ipSwitch + ",position:" + position + "查不到记录点");
				result = false;
				return result;
			}

			inout.setUserId(user.getUserId());
			inout.setPosition(deviceEntity.getId());
			if (inout.getStatus() == null)
			{
				inout.setStatus(Integer.valueOf(deviceEntity.getInoutType()));
			}
			positionType = deviceEntity.getPositionType();
			placeId = deviceEntity.getPlaceId();

			String content = null;
			int pushType = -1;
			int pushContentType = 0;
			String title = null;
			boolean isAbnormalLeave = false;
			boolean isAbnormalIn = false;
			// Integer infoType = null;// 信息提醒类型 1 只发送短信 2 只推送 3 即发送信息也推送 4
			// 即不发送信息也不推送
			Integer infoType = 4;
			AbnormalInformation abnormalInfo = new AbnormalInformation();

			PUSHTYPE push = PUSHTYPE.OUTSCHOOLPUSH;
			// 校门
			if (Cons.POSITIONTYPE_SCHOOLGATE.equals(positionType))
			{
				isGateInout = true;
				getBaseDao().addObject("Inout.addInout", inout);
				boolean flag = inout.getStatus() == 2;
				// 判断是否迟到早退，是则记录异常
				List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(date[0]);

				// 信息提醒 类型 查看palm_information_type表
				Integer informationType = null;
				boolean scheduleFlag = false;
				if (user.getRoleCode().equals("student"))
				{

					ScheduleClazz scheduleClazz = scheduleService.getScheduleClazzByUserIdAndLiveingDate(date[0], user.getUserId());
					if (scheduleClazz == null)
					{
						scheduleFlag = true;
					} else
					{

						isAbnormalLeave = false;
						isAbnormalIn = false;
						String amStart = scheduleClazz.getAmStartTime() + ":00";
						String amEnd = scheduleClazz.getAmEndTime() + ":00";
						String pmStart = scheduleClazz.getPmStartTime() + ":00";
						String pmEnd = scheduleClazz.getPmEndTime() + ":00";
						String beginTime = scheduleClazz.getBeginTime() + ":00";
						String endTime = scheduleClazz.getEndTime() + ":00";
						int type = scheduleClazz.getType();

						if (type == 0)// 分段
						{
							if (!amStart.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(amStart)) && nowTime.before(formatter.parse(amEnd)))// 上午迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}

							}
							if (!pmStart.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(pmStart)) && nowTime.before(formatter.parse(pmEnd)))// 下午迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}
							}
						} else
						// 整天
						{
							if (!beginTime.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(beginTime)) && nowTime.before(formatter.parse(endTime)))// 迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}
							}
						}

					}
				} else
				{
					ScheduleTeacher scheduleTeacher = scheduleService.getScheduleTeacherByUserIdAndLiveingDate(date[0], user.getUserId());
					if (scheduleTeacher == null)
					{
						scheduleFlag = true;
					} else
					{

						isAbnormalLeave = false;
						isAbnormalIn = false;
						String amStart = scheduleTeacher.getAmStartTime() + ":00";
						String amEnd = scheduleTeacher.getAmEndTime() + ":00";
						String pmStart = scheduleTeacher.getPmStartTime() + ":00";
						String pmEnd = scheduleTeacher.getPmEndTime() + ":00";
						String beginTime = scheduleTeacher.getBeginTime() + ":00";
						String endTime = scheduleTeacher.getEndTime() + ":00";
						int type = scheduleTeacher.getType();

						if (type == 0)// 分段
						{
							if (!amStart.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(amStart)) && nowTime.before(formatter.parse(amEnd)))// 上午迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}

							}
							if (!pmStart.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(pmStart)) && nowTime.before(formatter.parse(pmEnd)))// 下午迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}
							}
						} else
						// 整天
						{
							if (!beginTime.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(beginTime)) && nowTime.before(formatter.parse(endTime)))// 迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}
							}
						}

					}
				}

				if (scheduleFlag)
				{
					for (Schedule s : list)
					{
						isAbnormalLeave = false;
						isAbnormalIn = false;
						String amStart = s.getAmStartTime() + ":00";
						String amEnd = s.getAmEndTime() + ":00";
						String pmStart = s.getPmStartTime() + ":00";
						String pmEnd = s.getPmEndTime() + ":00";
						String beginTime = s.getBeginTime() + ":00";
						String endTime = s.getEndTime() + ":00";
						int type = s.getType();

						if (type == 0)// 分段
						{
							if (!amStart.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(amStart)) && nowTime.before(formatter.parse(amEnd)))// 上午迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}

							}
							if (!pmStart.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(pmStart)) && nowTime.before(formatter.parse(pmEnd)))// 下午迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}
							}
						} else
						// 整天
						{
							if (!beginTime.equals("null:00"))
							{
								if (nowTime.after(formatter.parse(beginTime)) && nowTime.before(formatter.parse(endTime)))// 迟到早退
								{
									if (flag)
									{
										isAbnormalLeave = true;
									} else
									{
										isAbnormalIn = true;
									}
								}
							}
						}

					}
				}

				if ("student".equals(user.getRoleCode()))
				{
					if (isAbnormalIn)
					{
						push = PUSHTYPE.INSCHOOLPUSH;
						informationType = 8003;
						content = user.getRealName() + "家长您好: 您的孩子于" + inout.getCreateTime() + "进入学校，现在是上课时间，系统将记录为迟到, 如有问题请及时和班主任联系。" + school.getSchoolName();

					} else
					{
						content = user.getRealName() + "家长您好: 您的孩子于" + inout.getCreateTime() + (flag ? "离开" : "进入") + "学校，如有问题请及时和班主任联系。"
								+ school.getSchoolName();
						if (flag)
						{
							push = PUSHTYPE.OUTSCHOOLPUSH;
							informationType = 8002;
						} else
						{
							push = PUSHTYPE.INSCHOOLPUSH;
							informationType = 8001;
						}
					}

				} else
				{
					if (isAbnormalLeave)
					{
						push = PUSHTYPE.OUTSCHOOLPUSH;
						informationType = 8004;
						content = user.getRealName() + "老师您好: 您于" + inout.getCreateTime() + "离开学校，现在是上课时间，系统将记录您为早退，如有疑问请联系学校教务处。" + school.getSchoolName();
					} else if (isAbnormalIn)
					{
						push = PUSHTYPE.INSCHOOLPUSH;
						informationType = 8003;
						content = user.getRealName() + "老师您好: 您于" + inout.getCreateTime() + "进入学校，现在是上课时间，系统将记录您为迟到，如有疑问请联系学校教务处。" + school.getSchoolName();
					} else
					{
						content = user.getRealName() + "老师您好: 您于" + inout.getCreateTime() + (flag ? "离开" : "进入") + "学校，祝您生活快乐！" + school.getSchoolName();
						if (flag)
						{
							push = PUSHTYPE.OUTSCHOOLPUSH;
							informationType = 8002;
						} else
						{
							push = PUSHTYPE.INSCHOOLPUSH;
							informationType = 8001;
						}
					}
				}

				pushType = PUSHTYPE.OUTSCHOOLPUSH.getType();
				pushContentType = flag ? PUSHTYPE.OUTSCHOOLPUSH.getContentType() : PUSHTYPE.INSCHOOLPUSH.getContentType();
				title = flag ? PUSHTYPE.OUTSCHOOLPUSH.getName() : PUSHTYPE.INSCHOOLPUSH.getName();
				if (inout.getImgPath() != null && !"".equals(inout.getImgPath()))
				{
					informationType = 10;
					pushType = PUSHTYPE.INTEGRATEDMACHINE.getType();
					pushContentType = PUSHTYPE.INTEGRATEDMACHINE.getContentType();
					if (content.indexOf("家长") != -1)
					{
						content = user.getRealName() + "家长您好: 您于" + formatter.format(new Date()) + "接送孩子, 如有问题请及时和班主任联系。" + school.getSchoolName();
					}
				}

				InformationType information = informationTypeService.getInformationTypeByInformationType(informationType);

				infoType = information.getType();
			}
			// 宿舍:预留
			else if (Cons.POSITIONTYPE_DORMITORY.equals(positionType))
			{
				isDormitoryInout = true;
				InoutDormitory inoutDormitory = new InoutDormitory();
				PropertyUtils.copyProperties(inoutDormitory, inout);
				getBaseDao().addObject("Inout.addInoutDormitory", inoutDormitory);

				boolean flag = inoutDormitory.getStatus() == 2;
				content = "您好：您的孩子于" + formatter.format(new Date()) + (flag ? "离开宿舍" : "进入宿舍") + ",如有问题请及时和班主任联系。" + school.getSchoolName();
				pushType = PUSHTYPE.OUTDORMITORYPUSH.getType();
				pushContentType = flag ? PUSHTYPE.OUTDORMITORYPUSH.getContentType() : PUSHTYPE.INDORMITORYPUSH.getContentType();
				title = flag ? PUSHTYPE.OUTDORMITORYPUSH.getName() : PUSHTYPE.INDORMITORYPUSH.getName();

				Integer informationType = null;

				if (flag)
				{
					push = PUSHTYPE.OUTDORMITORYPUSH;
					informationType = 4002;
				} else
				{
					push = PUSHTYPE.INDORMITORYPUSH;
					informationType = 4001;
				}
				InformationType information = informationTypeService.getInformationTypeByInformationType(informationType);

				infoType = information.getType();
			}
			// 会议
			else if (Cons.POSITIONTYPE_MEETING.equals(positionType))
			{
				infoType = 0;
				/**
				 * 获取参与会议的id
				 */
				InoutMeeting inoutMeeting = new InoutMeeting();
				PropertyUtils.copyProperties(inoutMeeting, inout);

				paramMap.put("place", placeId);
				paramMap.put("userId", user.getUserId());

				List<Meeting> meetingList = (List<Meeting>) getBaseDao().selectListByObject("Meeting.getMeetingListByPlaceAndTimeAndUserId", paramMap);

				if (meetingList != null && meetingList.size() > 0)
				{
					for (Meeting meeting : meetingList)
					{
						inoutMeeting.setMeetingId(meeting.getId());
						inoutMeeting.setPosition(meeting.getPlace());

						Date starTime = (Date) formatter.parse(meeting.getStartTime());// 会议开始时间
						Date endTime = (Date) formatter.parse(meeting.getEndTime());// 会议结束时间

						paramMap.put("meetingId", meeting.getId());
						paramMap.put("attendeeId", user.getUserId());

						if (nowTime.getTime() < starTime.getTime())
						{
							inoutMeeting.setStatus(0);
							paramMap.put("attenStatus", 0);
							getBaseDao().updateObject("MeetingDetail.updateAttensta", paramMap);
							break;
						} else if (starTime.getTime() < nowTime.getTime() && nowTime.getTime() < endTime.getTime())
						{
							inoutMeeting.setStatus(1);
							paramMap.put("attenStatus", 1);
							getBaseDao().updateObject("MeetingDetail.updateAttensta", paramMap);
							break;
						}

					}
				} else
				{
					logger.error("没有相关的会议,错误信息……");
				}

				getBaseDao().addObject("Inout.addInoutMeeting", inoutMeeting);
			}
			// 校车:预留
			else if (Cons.POSITIONTYPE_SCHOOLBUS.equals(positionType))
			{
				infoType = 0;
				OnSchoolBus onSchoolBus = new OnSchoolBus();
				PropertyUtils.copyProperties(onSchoolBus, inout);

				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				Date now = (Date) sdf.parse(sdf.format(new Date()));// 刷卡时间

				List<SchoolBusSchedule> schoolBusScheduleList = (List<SchoolBusSchedule>) getBaseDao()
						.selectListByObject("SchoolBusSchedule.getSchoolBusScheduleListByDay", paramMap);

				if (schoolBusScheduleList.size() > 0)
				{
					Calendar calendar = Calendar.getInstance();
					calendar.set(Calendar.MINUTE, calendar.get(Calendar.MINUTE) - 5); // 分
					paramMap.put("code", inout.getCode());
					paramMap.put("beginTime", formatter.format(calendar.getTime()));
					paramMap.put("nowTime", formatter.format(new Date()));
					// 查询当前刷卡用户在五分钟内是否刷过卡
					List<OnSchoolBus> cardRecordsList = (List<OnSchoolBus>) getBaseDao().selectListByObject("SchoolBus.getSchoolBusOn", paramMap);
					if (cardRecordsList.size() == 0)
					{
						for (SchoolBusSchedule schoolBusSchedule : schoolBusScheduleList)
						{
							Date startTime = (Date) sdf.parse(schoolBusSchedule.getStartTime());
							Date endTime = (Date) sdf.parse(schoolBusSchedule.getEndTime());
							if (startTime.getTime() < now.getTime() && now.getTime() < endTime.getTime())
							{
								Integer type = schoolBusSchedule.getType();
								doSchoolBusInout(onSchoolBus, user, type, inout, paramMap);
								break;
							}
						}

						onSchoolBus.setPosition(position);
						getBaseDao().addObject("Inout.addOnSchoolBus", onSchoolBus);
					}

				}

			}

			if (isSendSMS && (infoType == 1 || infoType == 2 || infoType == 3))
			{

				boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐

				boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启

				boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐

				// 若是学生，则找寻其家长，发送推送消息
				if (isGateInout)// 校门推送消息
				{
					List<User> parentList = null;
					List<PushItem> piList = null;
					if (user.getRoleCode().equals("student"))
					{
						parentList = new ArrayList<User>();
						parentList = getBaseDao().selectListByObject("User.getParentByStudentId", user.getUserId());

						for (User parent : parentList)
						{
							piList = new ArrayList<PushItem>();
							if (infoType == 1 || infoType == 3)// 1 只发送短信
																// 3短信+推送
							{
								if (schoolHasMessage)// 学校有短信套餐
								{
									if (isVirtualOpen)// 虚拟套餐开启直接发送
									{
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
												parent.getUserId(), content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, parent, 0, "5");
										} else
										{
											smsService.saveSmsDetail(content, user, parent, 1, "5");
										}
									} else// 虚拟套餐关闭
									{
										if (isSchoolSingleMsg)// 是否有学校单条套餐
																// 有判断条数
										{
											// 学校条数套餐剩余条数
											Integer remainCount = orderMessageService
													.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
											if (null != remainCount && remainCount > 0)// 有条数且大于0
											{
												// 调用短信接口
												boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
														parent.getUserId(), content, null, infoType);
												if (flag)
												{
													smsService.saveSmsDetail(content, user, parent, 0, "5");
												} else
												{
													smsService.saveSmsDetail(content, user, parent, 1, "5");
												}
												orderMessageService.updateOrderMessageSchoolById(String.valueOf(school.getSchoolId()));
											} else// 没有学校条数套餐 判断学生是否购买短信套餐
											{
												// 先判断学生有没有购买过
												Map<String, Object> studentMap = new HashMap<String, Object>();
												studentMap.put("userId", user.getUserId());
												studentMap.put("status", 0);
												OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "5");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "5");
													}

													int smscount = ((int) content.length() / 65) + 1;
													int messcount = 0;
													if (messageUser.getType() == 1)
													{
														// 如果短信剩余条数小于本次短信条说
														// 剩余条数为0
														// 如果大于等于本次短信条说
														// 则本次剩余条数为原剩余条数减本次短信条数
														if (messageUser.getCount() < smscount)
														{
															messcount = 0;
														} else
														{
															messcount = messageUser.getCount() - smscount;
														}
														studentMap.put("count", messcount);
														studentMap.put("id", messageUser.getId());
														orderMessageService.updateOrederMessageUserCount(studentMap);

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
													smsService.saveSmsDetail(content, user, parent, 2, "5");
												}
											}

										} else// 没有判断学生是否购买服务费
										{
											// 先判断学生有没有购买过
											Map<String, Object> studentMap = new HashMap<String, Object>();
											studentMap.put("userId", user.getUserId());
											studentMap.put("status", 0);
											OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
												boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
														parent.getUserId(), content, null, infoType);
												if (flag)
												{
													smsService.saveSmsDetail(content, user, parent, 0, "5");
												} else
												{
													smsService.saveSmsDetail(content, user, parent, 1, "5");
												}

												int smscount = ((int) content.length() / 65) + 1;
												int messcount = 0;
												if (messageUser.getType() == 1)
												{
													// 如果短信剩余条数小于本次短信条说
													// 剩余条数为0 如果大于等于本次短信条说
													// 则本次剩余条数为原剩余条数减本次短信条数
													if (messageUser.getCount() < smscount)
													{
														messcount = 0;
													} else
													{
														messcount = messageUser.getCount() - smscount;
													}
													studentMap.put("count", messcount);
													studentMap.put("id", messageUser.getId());
													orderMessageService.updateOrederMessageUserCount(studentMap);

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
												smsService.saveSmsDetail(content, user, parent, 2, "5");
											}
										}

									}

								} else// 学校无短信套餐直接发送
								{
									boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(), parent.getUserId(),
											content, null, infoType);
									if (flag)
									{
										smsService.saveSmsDetail(content, user, parent, 0, "5");
									} else
									{
										smsService.saveSmsDetail(content, user, parent, 1, "5");
									}
								}

								if (isAbnormalLeave || isAbnormalIn)
								{
									if (inout.getStatus() == 2)
									{
										abnormalInfo.setType(1);
									} else
									{
										abnormalInfo.setType(0);
									}
									abnormalInfo.setContent(content);
									abnormalInfo.setUserId(parent.getUserId());
									abnormalInfo.setCreateTime(formatter.format(new Date()));
									abnormalService.addAbnormalInfo(abnormalInfo);
								}

							} else if (infoType == 2)// 2 只推送
							{
								PushItem pi = new PushItem();
								pi.receiverId = parent.getUserId();
								pi.channels = parent.getBaiduChannelId();
								pi.deviceType = String.valueOf(parent.getDeviceType());
								pi.PushContent = content;
								pi.PushType = pushType;
								pi.PushContentType = pushContentType;
								pi.title = title;
								pi.schoolId = String.valueOf(school.getSchoolId());
								piList.add(pi);
								if (inout.getImgPath() != null && !"".equals(inout.getImgPath()))
								{
									pi.PushImage = inout.getImgPath();
								}

								if (isAbnormalLeave || isAbnormalIn)
								{
									if (inout.getStatus() == 2)
									{
										abnormalInfo.setType(1);
									} else
									{
										abnormalInfo.setType(0);
									}
									abnormalInfo.setContent(content);
									abnormalInfo.setUserId(parent.getUserId());
									abnormalInfo.setCreateTime(formatter.format(new Date()));
									abnormalService.addAbnormalInfo(abnormalInfo);
								}

								commonService.pushMsg(piList, false);// 消息推送
							}
						}

					} else
					{
						if (infoType == 1 || infoType == 3)
						{
							if (schoolHasMessage)// 学校有短信套餐
							{
								if (isVirtualOpen)// 虚拟套餐开启直接发送
								{
									// 调用短信接口
									boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
											content, null, infoType);
									if (flag)
									{
										smsService.saveSmsDetail(content, user, user, 0, "5");
									} else
									{
										smsService.saveSmsDetail(content, user, user, 1, "5");
									}
								} else// 虚拟套餐关闭
								{
									if (isSchoolSingleMsg)// 有学校条数套餐
									{
										// 学校条数套餐剩余条数
										Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
										if (null != remainCount && remainCount > 0)
										{
											// 调用短信接口
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
													user.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, user, 0, "5");
											} else
											{
												smsService.saveSmsDetail(content, user, user, 1, "5");
											}
											orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
										} else
										{
											// "1":发送失败 "2":没有缴纳服务费
											smsService.saveSmsDetail(content, user, user, 2, "5");
										}
									} else// 无学校条数套餐 直接发送
									{
										// 调用短信接口
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
												content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, user, 0, "5");
										} else
										{
											smsService.saveSmsDetail(content, user, user, 1, "5");
										}
									}
								}

							} else// 学校无短信套餐 直接发送
							{
								// 调用短信接口
								boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(), content,
										null, infoType);
								if (flag)
								{
									smsService.saveSmsDetail(content, user, user, 0, "5");
								} else
								{
									smsService.saveSmsDetail(content, user, user, 1, "5");
								}
							}

							if (isAbnormalLeave || isAbnormalIn)
							{
								if (inout.getStatus() == 2)
								{
									abnormalInfo.setType(1);
								} else
								{
									abnormalInfo.setType(0);
								}
								abnormalInfo.setContent(content);
								abnormalInfo.setUserId(user.getUserId());
								abnormalInfo.setCreateTime(formatter.format(new Date()));
								abnormalService.addAbnormalInfo(abnormalInfo);
							}

						} else if (infoType == 2)
						{
							piList = new ArrayList<PushItem>();
							PushItem pi = new PushItem();
							pi.receiverId = user.getUserId();
							pi.channels = user.getBaiduChannelId();
							pi.deviceType = String.valueOf(user.getDeviceType());
							pi.PushContent = content;
							pi.PushType = pushType;
							pi.PushContentType = pushContentType;
							pi.title = title;
							pi.schoolId = String.valueOf(school.getSchoolId());
							piList.add(pi);
							if (isAbnormalLeave || isAbnormalIn)
							{
								if (inout.getStatus() == 2)
								{
									abnormalInfo.setType(1);
								} else
								{
									abnormalInfo.setType(0);
								}
								abnormalInfo.setContent(content);
								abnormalInfo.setUserId(user.getUserId());
								abnormalInfo.setCreateTime(formatter.format(new Date()));
								abnormalService.addAbnormalInfo(abnormalInfo);
							}
							commonService.pushMsg(piList, false);// 消息推送
						}

					}

				} else if (isDormitoryInout)// 宿舍推送
				{

					List<User> parentList = null;
					List<PushItem> piList = null;
					if ("student".equals(user.getRoleCode()))
					{
						parentList = new ArrayList<User>();
						parentList = getBaseDao().selectListByObject("User.getParentByStudentId", user.getUserId());

						for (User parent : parentList)
						{
							piList = new ArrayList<PushItem>();
							if (infoType == 1 || infoType == 3)// 1 只发送短信3短信+推送
							{
								if (schoolHasMessage)// 学校有短信套餐
								{
									if (isVirtualOpen)// 虚拟套餐开启直接发送
									{
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
												parent.getUserId(), content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, parent, 0, "8");
										} else
										{
											smsService.saveSmsDetail(content, user, parent, 1, "8");
										}
									} else// 虚拟套餐关闭
									{
										if (isSchoolSingleMsg)// 是否有学校单条套餐
																// 有判断条数
										{
											// 学校条数套餐剩余条数
											Integer remainCount = orderMessageService
													.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
											if (null != remainCount && remainCount > 0)// 有条数且大于0
											{
												// 调用短信接口
												boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
														parent.getUserId(), content, null, infoType);
												if (flag)
												{
													smsService.saveSmsDetail(content, user, parent, 0, "8");
												} else
												{
													smsService.saveSmsDetail(content, user, parent, 1, "8");
												}
												orderMessageService.updateOrderMessageSchoolById(String.valueOf(school.getSchoolId()));
											} else// 没有学校条数套餐 判断学生是否购买短信套餐
											{
												// 先判断学生有没有购买过
												Map<String, Object> studentMap = new HashMap<String, Object>();
												studentMap.put("userId", user.getUserId());
												studentMap.put("status", 0);
												OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "8");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "8");
													}

													int smscount = ((int) content.length() / 65) + 1;
													int messcount = 0;
													if (messageUser.getType() == 1)
													{
														// 如果短信剩余条数小于本次短信条说
														// 剩余条数为0
														// 如果大于等于本次短信条说
														// 则本次剩余条数为原剩余条数减本次短信条数
														if (messageUser.getCount() < smscount)
														{
															messcount = 0;
														} else
														{
															messcount = messageUser.getCount() - smscount;
														}
														studentMap.put("count", messcount);
														studentMap.put("id", messageUser.getId());
														orderMessageService.updateOrederMessageUserCount(studentMap);

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
													smsService.saveSmsDetail(content, user, parent, 2, "8");
												}
											}

										} else// 没有判断学生是否购买服务费
										{
											// 先判断学生有没有购买过
											Map<String, Object> studentMap = new HashMap<String, Object>();
											studentMap.put("userId", user.getUserId());
											studentMap.put("status", 0);
											OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
												boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
														parent.getUserId(), content, null, infoType);
												if (flag)
												{
													smsService.saveSmsDetail(content, user, parent, 0, "8");
												} else
												{
													smsService.saveSmsDetail(content, user, parent, 1, "8");
												}

												int smscount = ((int) content.length() / 65) + 1;
												int messcount = 0;
												if (messageUser.getType() == 1)
												{
													// 如果短信剩余条数小于本次短信条说
													// 剩余条数为0 如果大于等于本次短信条说
													// 则本次剩余条数为原剩余条数减本次短信条数
													if (messageUser.getCount() < smscount)
													{
														messcount = 0;
													} else
													{
														messcount = messageUser.getCount() - smscount;
													}
													studentMap.put("count", messcount);
													studentMap.put("id", messageUser.getId());
													orderMessageService.updateOrederMessageUserCount(studentMap);

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
												smsService.saveSmsDetail(content, user, parent, 2, "8");
											}
										}

									}

								} else// 学校无短信套餐直接发送
								{
									boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(), parent.getUserId(),
											content, null, infoType);
									if (flag)
									{
										smsService.saveSmsDetail(content, user, parent, 0, "8");
									} else
									{
										smsService.saveSmsDetail(content, user, parent, 1, "8");
									}
								}

							} else if (infoType == 2)// 2 只推送
							{
								PushItem pi = new PushItem();
								pi.receiverId = parent.getUserId();
								pi.channels = parent.getBaiduChannelId();
								pi.deviceType = String.valueOf(parent.getDeviceType());
								pi.PushContent = content;
								pi.PushType = pushType;
								pi.PushContentType = pushContentType;
								pi.title = title;
								pi.schoolId = String.valueOf(school.getSchoolId());
								piList.add(pi);
								commonService.pushMsg(piList, false);// 消息推送
							}
						}

					} else
					{
						if (infoType == 1 || infoType == 3)
						{
							if (schoolHasMessage)// 学校有短信套餐
							{
								if (isVirtualOpen)// 虚拟套餐开启直接发送
								{
									// 调用短信接口
									boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
											content, null, infoType);
									if (flag)
									{
										smsService.saveSmsDetail(content, user, user, 0, "8");
									} else
									{
										smsService.saveSmsDetail(content, user, user, 1, "8");
									}
								} else// 虚拟套餐关闭
								{
									if (isSchoolSingleMsg)// 有学校条数套餐
									{
										// 学校条数套餐剩余条数
										Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
										if (null != remainCount && remainCount > 0)
										{
											// 调用短信接口
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
													user.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, user, 0, "8");
											} else
											{
												smsService.saveSmsDetail(content, user, user, 1, "8");
											}
											orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
										} else
										{
											// "1":发送失败 "2":没有缴纳服务费
											smsService.saveSmsDetail(content, user, user, 2, "8");
										}
									} else// 无学校条数套餐 直接发送
									{
										// 调用短信接口
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
												content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, user, 0, "8");
										} else
										{
											smsService.saveSmsDetail(content, user, user, 1, "8");
										}
									}
								}

							} else// 学校无短信套餐 直接发送
							{
								// 调用短信接口
								boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(), content,
										null, infoType);
								if (flag)
								{
									smsService.saveSmsDetail(content, user, user, 0, "8");
								} else
								{
									smsService.saveSmsDetail(content, user, user, 1, "8");
								}
							}

						} else if (infoType == 2)
						{
							piList = new ArrayList<PushItem>();
							PushItem pi = new PushItem();
							pi.receiverId = user.getUserId();
							pi.channels = user.getBaiduChannelId();
							pi.deviceType = String.valueOf(user.getDeviceType());
							pi.PushContent = content;
							pi.PushType = pushType;
							pi.PushContentType = pushContentType;
							pi.title = title;
							pi.schoolId = String.valueOf(school.getSchoolId());
							piList.add(pi);
							commonService.pushMsg(piList, false);// 消息推送
						}
					}
				}

			}
			result = true;

		} catch (Exception e)
		{
			e.printStackTrace();
			result = false;
		}
		return result;
	}

	/**
	 * 新增出入记录(刷卡产生) 【用于无障碍通道进出校园】
	 * 
	 * @param inout
	 *            待新增的出入记录
	 * @param ipSwitch
	 *            0:ip 1:deviceCode
	 * @param position
	 *            记录点位置
	 * @param inoutStatus
	 *            进出状态 0:不区分进出 1:进 2:出
	 *            只有当刷卡时间在作息时间范围内inoutStatus才启作用(作息时间开始前半小时作息时间后半小时也包括在内)
	 * @param isSendSMS
	 *            校园一体机打开超过10min之后才发来的数据只保存到inout表中，不推送不短信
	 * @return true:保存成功 false:保存失败
	 */
	@SuppressWarnings("unchecked")
	public boolean addNewInoutForAccess(Inout inout, String ipSwitch, String position, String inoutStatus, boolean isSendSMS)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (StringUtil.isEmpty(inout.getCreateTime()))
		{
			inout.setCreateTime(formatter.format(new Date()));
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		boolean result = false;
		boolean isGateInout = false;

		try
		{
			/*
			 * 根据code查找关联数据，插入inout中
			 */
			// 关联用户
			User user = (User) getBaseDao().selectObjectByObject("User.getUserByCardCode", inout.getCode());
			if (null == user)
			{
				logger.error("addNewInoutForAccess-卡号:" + inout.getCode() + "查不到关联用户!");
				result = false;
				return result;
			}
			School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(DBContextHolder.getDBType()));
			String[] date = inout.getCreateTime().split(" ");
			paramMap.put("day", date[0]);// 刷卡的日期
			paramMap.put("time", date[1]);// 刷卡的时间
			Date nowTime = (Date) formatter.parse(inout.getCreateTime());// 刷卡时间

			// 关联记录点
			paramMap.put("ipSwitch", ipSwitch);
			paramMap.put("position", position);
			paramMap.put("userId", user.getUserId());
			Device deviceEntity = (Device) getBaseDao().selectObjectByObject("Device.getDeviceByIpOrDeviceCode", paramMap);
			if (null == deviceEntity)
			{
				logger.error("addNewInoutForAccess-ipSwitch:" + ipSwitch + ",position:" + position + "查不到记录点");
				result = false;
				return result;
			}

			inout.setUserId(user.getUserId());
			inout.setPosition(deviceEntity.getId());

			String content = null;
			int pushType = -1;
			int pushContentType = 0;
			String title = null;

			boolean isAbnormalLeave = false;
			boolean isAbnormalIn = false;

			Integer infoType = 4;// 信息提醒类型 1 只发送短信 2 只推送 3 即发送信息也推送 4 即不发送信息也不推送
			AbnormalInformation abnormalInfo = new AbnormalInformation();
			PUSHTYPE push = PUSHTYPE.OUTSCHOOLPUSH;
			// 校门
			// if (Cons.POSITIONTYPE_SCHOOLGATE.equals(positionType))
			{
				isGateInout = true;
				// 判断是否迟到早退，是则记录异常
				List<Schedule> list = scheduleService.selectScheduleListByLiveingDate(date[0]);
				// 信息提醒 类型 查看palm_information_type表
				Integer informationType = null;
				boolean scheduleFlag = false;
				if (user.getRoleCode().equals("student"))
				{

					ScheduleClazz scheduleClazz = scheduleService.getScheduleClazzByUserIdAndLiveingDate(date[0], user.getUserId());
					if (scheduleClazz == null)
					{
						scheduleFlag = true;
					} else
					{

						String amStart = scheduleClazz.getAmStartTime() + ":00";
						String amEnd = scheduleClazz.getAmEndTime() + ":00";
						String pmStart = scheduleClazz.getPmStartTime() + ":00";
						String pmEnd = scheduleClazz.getPmEndTime() + ":00";
						String beginTime = scheduleClazz.getBeginTime() + ":00";
						String endTime = scheduleClazz.getEndTime() + ":00";
						int type = scheduleClazz.getType();

						if (type == 0)// 分段
						{
							if (!amStart.equals("null:00"))
							{
								Date scheduleAmStart = formatter.parse(amStart);
								Date scheduleAmEnd = formatter.parse(amEnd);
								// 得出计划上午午开始时间半小时前的时间以及上午午结束半小时后的时间,在开始前半小时和开始后半小时之间inoutStatus是不起作用的
								Date beforeAmStart30min = new Date(scheduleAmStart.getTime() - 1800000);
								Date afterAmStart30min = new Date(scheduleAmStart.getTime() + 1800000);
								Date beforeAmEnd30min = new Date(scheduleAmEnd.getTime() - 1800000);
								Date afterAmEnd30min = new Date(scheduleAmEnd.getTime() + 1800000);
								if (nowTime.after(beforeAmStart30min) && nowTime.before(afterAmStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforeAmEnd30min) && nowTime.before(afterAmEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(scheduleAmStart) && nowTime.before(scheduleAmEnd))// 上午迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
							if (!pmStart.equals("null:00"))
							{
								Date schedulePmStart = formatter.parse(pmStart);
								Date schedulePmEnd = formatter.parse(pmEnd);
								// 得出计划下午开始时间半小时前的时间以及下午结束半小时后的时间
								Date beforePmStart30min = new Date(schedulePmStart.getTime() - 1800000);
								Date afterPmStart30min = new Date(schedulePmStart.getTime() + 1800000);
								Date beforePmEnd30min = new Date(schedulePmEnd.getTime() - 1800000);
								Date afterPmEnd30min = new Date(schedulePmEnd.getTime() + 1800000);
								if (nowTime.after(beforePmStart30min) && nowTime.before(afterPmStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforePmEnd30min) && nowTime.before(afterPmEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(schedulePmStart) && nowTime.before(schedulePmEnd))// 下午迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
						} else
						// 整天
						{
							if (!beginTime.equals("null:00"))
							{
								Date dayBeginTime = formatter.parse(beginTime);
								Date dayEndTime = formatter.parse(endTime);

								Date beforeStart30min = new Date(dayBeginTime.getTime() - 1800000);
								Date afterStart30min = new Date(dayBeginTime.getTime() + 1800000);
								Date beforeEnd30min = new Date(dayEndTime.getTime() - 1800000);
								Date afterEnd30min = new Date(dayEndTime.getTime() + 1800000);
								if (nowTime.after(beforeStart30min) && nowTime.before(afterStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforeEnd30min) && nowTime.before(afterEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(dayBeginTime) && nowTime.before(dayEndTime))// 迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
						}

					}
				} else
				{
					ScheduleTeacher scheduleTeacher = scheduleService.getScheduleTeacherByUserIdAndLiveingDate(date[0], user.getUserId());
					if (scheduleTeacher == null)
					{
						scheduleFlag = true;
					} else
					{

						String amStart = scheduleTeacher.getAmStartTime() + ":00";
						String amEnd = scheduleTeacher.getAmEndTime() + ":00";
						String pmStart = scheduleTeacher.getPmStartTime() + ":00";
						String pmEnd = scheduleTeacher.getPmEndTime() + ":00";
						String beginTime = scheduleTeacher.getBeginTime() + ":00";
						String endTime = scheduleTeacher.getEndTime() + ":00";
						int type = scheduleTeacher.getType();

						if (type == 0)// 分段
						{
							if (!amStart.equals("null:00"))
							{
								Date scheduleAmStart = formatter.parse(amStart);
								Date scheduleAmEnd = formatter.parse(amEnd);
								// 得出计划上午午开始时间半小时前的时间以及上午午结束半小时后的时间,在开始前半小时和开始后半小时之间inoutStatus是不起作用的
								Date beforeAmStart30min = new Date(scheduleAmStart.getTime() - 1800000);
								Date afterAmStart30min = new Date(scheduleAmStart.getTime() + 1800000);
								Date beforeAmEnd30min = new Date(scheduleAmEnd.getTime() - 1800000);
								Date afterAmEnd30min = new Date(scheduleAmEnd.getTime() + 1800000);
								if (nowTime.after(beforeAmStart30min) && nowTime.before(afterAmStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforeAmEnd30min) && nowTime.before(afterAmEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(scheduleAmStart) && nowTime.before(scheduleAmEnd))// 上午迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
							if (!pmStart.equals("null:00"))
							{
								Date schedulePmStart = formatter.parse(pmStart);
								Date schedulePmEnd = formatter.parse(pmEnd);
								// 得出计划下午开始时间半小时前的时间以及下午结束半小时后的时间
								Date beforePmStart30min = new Date(schedulePmStart.getTime() - 1800000);
								Date afterPmStart30min = new Date(schedulePmStart.getTime() + 1800000);
								Date beforePmEnd30min = new Date(schedulePmEnd.getTime() - 1800000);
								Date afterPmEnd30min = new Date(schedulePmEnd.getTime() + 1800000);
								if (nowTime.after(beforePmStart30min) && nowTime.before(afterPmStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforePmEnd30min) && nowTime.before(afterPmEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(schedulePmStart) && nowTime.before(schedulePmEnd))// 下午迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
						} else
						// 整天
						{
							if (!beginTime.equals("null:00"))
							{
								Date dayBeginTime = formatter.parse(beginTime);
								Date dayEndTime = formatter.parse(endTime);

								Date beforeStart30min = new Date(dayBeginTime.getTime() - 1800000);
								Date afterStart30min = new Date(dayBeginTime.getTime() + 1800000);
								Date beforeEnd30min = new Date(dayEndTime.getTime() - 1800000);
								Date afterEnd30min = new Date(dayEndTime.getTime() + 1800000);
								if (nowTime.after(beforeStart30min) && nowTime.before(afterStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforeEnd30min) && nowTime.before(afterEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(dayBeginTime) && nowTime.before(dayEndTime))// 迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
						}

					}
				}

				if (scheduleFlag)
				{
					if (!CollectionUtils.isEmpty(list))
					{
						Schedule s = list.get(0);
						String amStart = s.getAmStartTime() + ":00";
						String amEnd = s.getAmEndTime() + ":00";
						String pmStart = s.getPmStartTime() + ":00";
						String pmEnd = s.getPmEndTime() + ":00";
						String beginTime = s.getBeginTime() + ":00";
						String endTime = s.getEndTime() + ":00";
						int type = s.getType();

						if (type == 0)// 分段
						{
							if (!amStart.equals("null:00"))
							{
								Date scheduleAmStart = formatter.parse(amStart);
								Date scheduleAmEnd = formatter.parse(amEnd);
								// 得出计划上午午开始时间半小时前的时间以及上午午结束半小时后的时间,在开始前半小时和开始后半小时之间inoutStatus是不起作用的
								Date beforeAmStart30min = new Date(scheduleAmStart.getTime() - 1800000);
								Date afterAmStart30min = new Date(scheduleAmStart.getTime() + 1800000);
								Date beforeAmEnd30min = new Date(scheduleAmEnd.getTime() - 1800000);
								Date afterAmEnd30min = new Date(scheduleAmEnd.getTime() + 1800000);
								if (nowTime.after(beforeAmStart30min) && nowTime.before(afterAmStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforeAmEnd30min) && nowTime.before(afterAmEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(scheduleAmStart) && nowTime.before(scheduleAmEnd))// 上午迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
							if (!pmStart.equals("null:00"))
							{
								Date schedulePmStart = formatter.parse(pmStart);
								Date schedulePmEnd = formatter.parse(pmEnd);
								// 得出计划下午开始时间半小时前的时间以及下午结束半小时后的时间
								Date beforePmStart30min = new Date(schedulePmStart.getTime() - 1800000);
								Date afterPmStart30min = new Date(schedulePmStart.getTime() + 1800000);
								Date beforePmEnd30min = new Date(schedulePmEnd.getTime() - 1800000);
								Date afterPmEnd30min = new Date(schedulePmEnd.getTime() + 1800000);
								if (nowTime.after(beforePmStart30min) && nowTime.before(afterPmStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforePmEnd30min) && nowTime.before(afterPmEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(schedulePmStart) && nowTime.before(schedulePmEnd))// 下午迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
						} else
						// 整天
						{
							if (!beginTime.equals("null:00"))
							{
								Date dayBeginTime = formatter.parse(beginTime);
								Date dayEndTime = formatter.parse(endTime);

								Date beforeStart30min = new Date(dayBeginTime.getTime() - 1800000);
								Date afterStart30min = new Date(dayBeginTime.getTime() + 1800000);
								Date beforeEnd30min = new Date(dayEndTime.getTime() - 1800000);
								Date afterEnd30min = new Date(dayEndTime.getTime() + 1800000);
								if (nowTime.after(beforeStart30min) && nowTime.before(afterStart30min))
								{
									inout.setStatus(1);
								} else if (nowTime.after(beforeEnd30min) && nowTime.before(afterEnd30min))
								{
									inout.setStatus(2);
								} else
								{
									inout.setStatus(Integer.valueOf(inoutStatus));
								}
								if (nowTime.after(dayBeginTime) && nowTime.before(dayEndTime))// 迟到早退
								{
									if ("1".equals(inout.getStatus()))
									{
										isAbnormalIn = true;
									} else if ("2".equals(inout.getStatus()))
									{
										isAbnormalLeave = true;
									}
								}
							}
						}

					} else
					{
						inout.setStatus(0);
					}
				}
				// 保存inout记录
				getBaseDao().addObject("Inout.addInout", inout);

				Boolean flag = inout.getStatus() == 2;
				if ("student".equals(user.getRoleCode()))
				{
					if (isAbnormalIn)
					{
						push = PUSHTYPE.INSCHOOLPUSH;
						informationType = 8003;
						content = user.getRealName() + "家长您好: 您的孩子于" + inout.getCreateTime() + "进入学校，现在是上课时间，系统将记录为迟到, 如有问题请及时和班主任联系。" + school.getSchoolName();
					} else
					{
						if ("1".equals(inout.getStatus()))
						{
							content = user.getRealName() + "家长您好: 您的孩子于" + inout.getCreateTime() + "进入学校，如有问题请及时和班主任联系。" + school.getSchoolName();
						} else if ("2".equals(inout.getStatus()))
						{
							content = user.getRealName() + "家长您好: 您的孩子于" + inout.getCreateTime() + "离开学校，如有问题请及时和班主任联系。" + school.getSchoolName();
						} else
						{
							content = user.getRealName() + "家长您好: 您的孩子于" + inout.getCreateTime() + "进出学校，如有问题请及时和班主任联系。" + school.getSchoolName();
						}
						if (flag)
						{
							push = PUSHTYPE.OUTSCHOOLPUSH;
							informationType = 8002;
						} else
						{
							push = PUSHTYPE.INSCHOOLPUSH;
							informationType = 8001;
						}
					}
				} else
				{
					if (isAbnormalLeave)
					{
						push = PUSHTYPE.OUTSCHOOLPUSH;
						informationType = 8004;
						content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + "离开学校，现在是上课时间，系统将记录您为早退，如有疑问请联系学校教务处。"
								+ school.getSchoolName();
					} else if (isAbnormalIn)
					{
						push = PUSHTYPE.INSCHOOLPUSH;
						informationType = 8003;
						content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + "进入学校，现在是上课时间，系统将记录您为迟到，如有疑问请联系学校教务处。"
								+ school.getSchoolName();
					} else
					{
						if ("1".equals(inout.getStatus()))
						{
							content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + "进入学校，祝您生活快乐！" + school.getSchoolName();
						} else if ("2".equals(inout.getStatus()))
						{
							content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + "离开学校，祝您生活快乐！" + school.getSchoolName();
						} else
						{
							content = user.getRealName() + "老师您好: 您于" + formatter.format(new Date()) + "进出学校，祝您生活快乐！" + school.getSchoolName();
						}

						if (flag)
						{
							push = PUSHTYPE.OUTSCHOOLPUSH;
							informationType = 8002;
						} else
						{
							push = PUSHTYPE.INSCHOOLPUSH;
							informationType = 8001;
						}
					}
				}

				pushType = PUSHTYPE.OUTSCHOOLPUSH.getType();
				pushContentType = flag ? PUSHTYPE.OUTSCHOOLPUSH.getContentType() : PUSHTYPE.INSCHOOLPUSH.getContentType();
				title = flag ? PUSHTYPE.OUTSCHOOLPUSH.getName() : PUSHTYPE.INSCHOOLPUSH.getName();
				InformationType information = informationTypeService.getInformationTypeByInformationType(informationType);
				infoType = information.getType();
			}

			if (isSendSMS && (infoType == 1 || infoType == 2 || infoType == 3))
			{
				// 若是学生，则找寻其家长，发送推送消息
				if (isGateInout)// 校门推送消息
				{

					boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐

					boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启

					boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐

					// 若是学生，则找寻其家长，发送推送消息
					if (isGateInout)// 校门推送消息
					{
						List<User> parentList = null;
						List<PushItem> piList = null;
						if (user.getRoleCode().equals("student"))
						{
							parentList = new ArrayList<User>();
							parentList = getBaseDao().selectListByObject("User.getParentByStudentId", user.getUserId());

							for (User parent : parentList)
							{
								piList = new ArrayList<PushItem>();
								if (infoType == 1 || infoType == 3)// 1 只发送短信
																	// 3短信+推送
								{
									if (schoolHasMessage)// 学校有短信套餐
									{
										if (isVirtualOpen)// 虚拟套餐开启直接发送
										{
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
													parent.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, parent, 0, "5");
											} else
											{
												smsService.saveSmsDetail(content, user, parent, 1, "5");
											}
										} else// 虚拟套餐关闭
										{
											if (isSchoolSingleMsg)// 是否有学校单条套餐
																	// 有判断条数
											{
												// 学校条数套餐剩余条数
												Integer remainCount = orderMessageService
														.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
												if (null != remainCount && remainCount > 0)// 有条数且大于0
												{
													// 调用短信接口
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "5");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "5");
													}
													orderMessageService.updateOrderMessageSchoolById(String.valueOf(school.getSchoolId()));
												} else// 没有学校条数套餐 判断学生是否购买短信套餐
												{
													// 先判断学生有没有购买过
													Map<String, Object> studentMap = new HashMap<String, Object>();
													studentMap.put("userId", user.getUserId());
													studentMap.put("status", 0);
													OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
														boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
																parent.getUserId(), content, null, infoType);
														if (flag)
														{
															smsService.saveSmsDetail(content, user, parent, 0, "5");
														} else
														{
															smsService.saveSmsDetail(content, user, parent, 1, "5");
														}

														int smscount = ((int) content.length() / 65) + 1;
														int messcount = 0;
														if (messageUser.getType() == 1)
														{
															// 如果短信剩余条数小于本次短信条说
															// 剩余条数为0
															// 如果大于等于本次短信条说
															// 则本次剩余条数为原剩余条数减本次短信条数
															if (messageUser.getCount() < smscount)
															{
																messcount = 0;
															} else
															{
																messcount = messageUser.getCount() - smscount;
															}
															studentMap.put("count", messcount);
															studentMap.put("id", messageUser.getId());
															orderMessageService.updateOrederMessageUserCount(studentMap);

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
														smsService.saveSmsDetail(content, user, parent, 2, "5");
													}
												}

											} else// 没有判断学生是否购买服务费
											{
												// 先判断学生有没有购买过
												Map<String, Object> studentMap = new HashMap<String, Object>();
												studentMap.put("userId", user.getUserId());
												studentMap.put("status", 0);
												OrderMessageUser messageUser = orderMessageService.getOrderMessageUserByUserId(studentMap);
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
													boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
															parent.getUserId(), content, null, infoType);
													if (flag)
													{
														smsService.saveSmsDetail(content, user, parent, 0, "5");
													} else
													{
														smsService.saveSmsDetail(content, user, parent, 1, "5");
													}

													int smscount = ((int) content.length() / 65) + 1;
													int messcount = 0;
													if (messageUser.getType() == 1)
													{
														// 如果短信剩余条数小于本次短信条说
														// 剩余条数为0 如果大于等于本次短信条说
														// 则本次剩余条数为原剩余条数减本次短信条数
														if (messageUser.getCount() < smscount)
														{
															messcount = 0;
														} else
														{
															messcount = messageUser.getCount() - smscount;
														}
														studentMap.put("count", messcount);
														studentMap.put("id", messageUser.getId());
														orderMessageService.updateOrederMessageUserCount(studentMap);

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
													smsService.saveSmsDetail(content, user, parent, 2, "5");
												}
											}

										}

									} else// 学校无短信套餐直接发送
									{
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, parent.getPhone(),
												parent.getUserId(), content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, parent, 0, "5");
										} else
										{
											smsService.saveSmsDetail(content, user, parent, 1, "5");
										}
									}

								} else if (infoType == 2)// 2 只推送
								{
									PushItem pi = new PushItem();
									pi.receiverId = parent.getUserId();
									pi.channels = parent.getBaiduChannelId();
									pi.deviceType = String.valueOf(parent.getDeviceType());
									pi.PushContent = content;
									pi.PushType = pushType;
									pi.PushContentType = pushContentType;
									pi.title = title;
									pi.schoolId = String.valueOf(school.getSchoolId());
									piList.add(pi);
									if (inout.getImgPath() != null && !"".equals(inout.getImgPath()))
									{
										pi.PushImage = inout.getImgPath();
									}

									if (isAbnormalLeave || isAbnormalIn)
									{
										if (inout.getStatus() == 2)
										{
											abnormalInfo.setType(1);
										} else
										{
											abnormalInfo.setType(0);
										}
										abnormalInfo.setContent(content);
										abnormalInfo.setUserId(parent.getUserId());
										abnormalInfo.setCreateTime(formatter.format(new Date()));
										abnormalService.addAbnormalInfo(abnormalInfo);
									}

									commonService.pushMsg(piList, false);// 消息推送
								}
							}

						} else
						{
							if (infoType == 1 || infoType == 3)
							{
								if (schoolHasMessage)// 学校有短信套餐
								{
									if (isVirtualOpen)// 虚拟套餐开启直接发送
									{
										// 调用短信接口
										boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
												content, null, infoType);
										if (flag)
										{
											smsService.saveSmsDetail(content, user, user, 0, "5");
										} else
										{
											smsService.saveSmsDetail(content, user, user, 1, "5");
										}
									} else// 虚拟套餐关闭
									{
										if (isSchoolSingleMsg)// 有学校条数套餐
										{
											// 学校条数套餐剩余条数
											Integer remainCount = orderMessageService
													.getRemainCountBySchoolIdForSchoolRange(String.valueOf(school.getSchoolId()));
											if (null != remainCount && remainCount > 0)
											{
												// 调用短信接口
												boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
														user.getUserId(), content, null, infoType);
												if (flag)
												{
													smsService.saveSmsDetail(content, user, user, 0, "5");
												} else
												{
													smsService.saveSmsDetail(content, user, user, 1, "5");
												}
												orderMessageService.updateOrderMessageSchoolById(user.getSchoolId());
											} else
											{
												// "1":发送失败 "2":没有缴纳服务费
												smsService.saveSmsDetail(content, user, user, 2, "5");
											}
										} else// 无学校条数套餐 直接发送
										{
											// 调用短信接口
											boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(),
													user.getUserId(), content, null, infoType);
											if (flag)
											{
												smsService.saveSmsDetail(content, user, user, 0, "5");
											} else
											{
												smsService.saveSmsDetail(content, user, user, 1, "5");
											}
										}
									}

								} else// 学校无短信套餐 直接发送
								{
									// 调用短信接口
									boolean flag = commonService.sendSmsByDB(String.valueOf(school.getSchoolId()), push, user.getPhone(), user.getUserId(),
											content, null, infoType);
									if (flag)
									{
										smsService.saveSmsDetail(content, user, user, 0, "5");
									} else
									{
										smsService.saveSmsDetail(content, user, user, 1, "5");
									}
								}

							} else if (infoType == 2)
							{
								piList = new ArrayList<PushItem>();
								PushItem pi = new PushItem();
								pi.receiverId = user.getUserId();
								pi.channels = user.getBaiduChannelId();
								pi.deviceType = String.valueOf(user.getDeviceType());
								pi.PushContent = content;
								pi.PushType = pushType;
								pi.PushContentType = pushContentType;
								pi.title = title;
								pi.schoolId = String.valueOf(school.getSchoolId());
								piList.add(pi);
								if (isAbnormalLeave || isAbnormalIn)
								{
									if (inout.getStatus() == 2)
									{
										abnormalInfo.setType(1);
									} else
									{
										abnormalInfo.setType(0);
									}
									abnormalInfo.setContent(content);
									abnormalInfo.setUserId(user.getUserId());
									abnormalInfo.setCreateTime(formatter.format(new Date()));
									abnormalService.addAbnormalInfo(abnormalInfo);
								}
								commonService.pushMsg(piList, false);// 消息推送
							}
						}

					}
				}
			}
			result = true;

		} catch (Exception e)
		{
			e.printStackTrace();
			result = false;
		}
		return result;
	}

	/**
	 * 校车刷卡时调用的方法
	 * 
	 * @param user
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public OnSchoolBus doSchoolBusInout(OnSchoolBus onSchoolBus, User user, Integer type, Inout inout, Map<String, Object> paramMap)
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String content = null;
		paramMap.put("userId", user.getUserId());

		List<UserRole> userRoleList = commonService.getUserRoleByUserId(user.getUserId());
		if (userRoleList.size() > 0)
		{
			for (UserRole userRole : userRoleList)
			{
				String roleCode = userRole.getRoleCode();

				// 判断当前刷卡用户是否为学生
				if (roleCode.equals("student"))
				{
					onSchoolBus.setStatus(type);
					paramMap.put("studentId", user.getUserId());
					Integer studentId = user.getUserId();
					// 通过userId查找学生对应的家长
					List<User> parentList = (List<User>) getBaseDao().selectList("User.getParentByStudentId", studentId);
					// 通过userId查找学生对应的SchoolId 用户统计发送信息
					Long schoolId = (Long) getBaseDao().selectObjectByObject("User.getSchoolIdByStudentId", paramMap);
					PUSHTYPE pushstates = null;

					if (parentList.size() > 0)
					{
						for (User parent : parentList)
						{
							SchoolBusSmsDetail schoolBussmsDetail = new SchoolBusSmsDetail();

							schoolBussmsDetail.setReceiverId(user.getUserId());
							schoolBussmsDetail.setPhone(parent.getPhone());
							schoolBussmsDetail.setReceiverName(user.getRealName());
							schoolBussmsDetail.setCreateTime(TimeUtil.getInstance().now());
							// 回家上车
							if (type == 1)
							{

								User driver = (User) getBaseDao().selectObjectByObject("SchoolBus.selectDriverRecords", paramMap);
								if (driver == null)
								{
									content = "尊敬的家长您好，您的孩子已于" + sdf.format(new Date()) + "上车，如有问题请和我校联系！";
								} else
								{
									onSchoolBus.setDriverName(driver.getRealName());
									content = "尊敬的家长您好，您的孩子已于" + sdf.format(new Date()) + "上车，司机" + driver.getRealName() + ",电话" + "(" + driver.getPhone()
											+ ")，如有问题请和我校联系！";
								}
								pushstates = PUSHTYPE.SCHOOLBUSINPUSH;

								schoolBussmsDetail.setContent(content);

								InformationType informationType = (InformationType) getBaseDao()
										.selectObject("InformationType.getInformationTypeByInformationType", 5001);

								if (informationType.getType() == 1 || informationType.getType() == 3)// 1只发送短信3
																										// 短信+推送)
								{
									PushDataByJson pd = new PushDataByJson();
									pd.setPosition((String) paramMap.get("position"));
									pd.setCardDate((String) paramMap.get("nowTime"));
									pd.setUserId(user.getUserId().toString());
									sendStudentSmsForSchoolBus(schoolId.toString(), pushstates, parent.getPhone(),  parent.getUserId(), content, informationType.getType(),
											 pd, user.getUserId());
									getBaseDao().addObject("SchoolBusSmsDetail.addSmsDetail", schoolBussmsDetail);

								} else if (informationType.getType() == 2)// 只推送
								{
									// 推送手机端消息
									List<PushItem> list = new ArrayList<PushItem>();
									PushItem pi = new PushItem();
									pi.title = pushstates.getName();
									pi.PushContent = content;
									pi.PushType = pushstates.getType();
									pi.PushContentType = pushstates.getContentType();
									String channelId = parent.getBaiduChannelId();
									Integer deviceType = parent.getDeviceType();
									if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
									{
										pi.channels = channelId;
										pi.deviceType = String.valueOf(deviceType);
									}
									pi.receiverId = parent.getUserId();
									pi.schoolId = DBContextHolder.getDBType();
									PushDataByJson pd = new PushDataByJson();
									pd.setPosition((String) paramMap.get("position"));
									pd.setCardDate((String) paramMap.get("nowTime"));
									pd.setUserId(user.getUserId().toString());
									pi.PushData = GsonHelper.toJson(pd);
									list.add(pi);

									commonService.pushMsg(list, false);

								}
								// 上学下车
							} else if (type == 2)
							{

								content = "尊敬的家长您好，您的孩子已经安全到达学校，您有任何问题请直接和班主任联系！";
								pushstates = PUSHTYPE.SCHOOLBUSOUTPUSH;

								InformationType informationType = (InformationType) getBaseDao()
										.selectObject("InformationType.getInformationTypeByInformationType", 5002);
								schoolBussmsDetail.setContent(content);

								if (informationType.getType() == 1 || informationType.getType() == 3)// 1只发送短信3短信+推送
								{
									PushDataByJson pd = new PushDataByJson();
									pd.setPosition((String) paramMap.get("position"));
									pd.setCardDate((String) paramMap.get("nowTime"));
									pd.setUserId(user.getUserId().toString());
									sendStudentSmsForSchoolBus(schoolId.toString(), pushstates, parent.getPhone(),  parent.getUserId(), content, informationType.getType(),
											 pd, user.getUserId());
									getBaseDao().addObject("SchoolBusSmsDetail.addSmsDetail", schoolBussmsDetail);
								} else if (informationType.getType() == 2)// 只推送
								{
									// 推送手机端消息
									List<PushItem> list = new ArrayList<PushItem>();
									PushItem pi = new PushItem();
									pi.title = pushstates.getName();
									pi.PushContent = content;
									pi.PushType = pushstates.getType();
									pi.PushContentType = pushstates.getContentType();
									String channelId = parent.getBaiduChannelId();
									Integer deviceType = parent.getDeviceType();
									if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
									{
										pi.channels = channelId;
										pi.deviceType = String.valueOf(deviceType);
									}
									pi.receiverId = parent.getUserId();
									pi.schoolId = DBContextHolder.getDBType();
									PushDataByJson pd = new PushDataByJson();
									pd.setPosition((String) paramMap.get("position"));
									pd.setCardDate((String) paramMap.get("nowTime"));
									pd.setUserId(user.getUserId().toString());
									pi.PushData = GsonHelper.toJson(pd);
									list.add(pi);
									commonService.pushMsg(list, false);
								}

							}

						}
					} else
					{
						logger.error("系统中未找到用户" + user.getRealName() + "对应的家长……");
					}

				}
				// 判断当前刷卡用户是否为家长
				else if (roleCode.equals("parent"))
				{
					onSchoolBus.setStatus(0);
					// 根据用户Id查出用户对应孩子
					Integer userId = user.getUserId();
					List<User> childrenList = (List<User>) getBaseDao().selectList("User.getAllChildrenByUserId", userId);

					if (type == 1)
					{
						for (User children : childrenList)
						{
							content = children.getRealName() + "家长已于" + sdf.format(new Date()) + "接到孩子！";

							SchoolBusSmsDetail schoolBussmsDetail = new SchoolBusSmsDetail();

							schoolBussmsDetail.setContent(content);
							schoolBussmsDetail.setReceiverId(children.getUserId());
							schoolBussmsDetail.setPhone(user.getPhone());
							schoolBussmsDetail.setReceiverName(children.getRealName());
							schoolBussmsDetail.setCreateTime(TimeUtil.getInstance().now());

							getBaseDao().addObject("SchoolBusSmsDetail.addSmsDetail", schoolBussmsDetail);
						}
					}

				} else
				{
					onSchoolBus.setStatus(0);
				}
			}

		} else
		{
			logger.error("卡号:" + inout.getCode() + "关联用户没有对应的权限…………");
		}
		return onSchoolBus;
	}

	/**
	 * 查找进出记录(为了导出excel)
	 * 
	 * @param paramMap
	 *            参数map
	 * @param roleId
	 *            权限ID
	 */
	@SuppressWarnings("unchecked")
	public List<Inout> loadInoutListForExport(Map<String, Object> paramMap, User user)
	{
		List<Inout> list = new ArrayList<Inout>();
		String roleCode = (String) paramMap.get("roleCode");

		/**
		 * 校长或者学校管理员（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{

			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsHeadMaster", paramMap);

		}

		/**
		 * 家长 （自己和孩子的记录）
		 */
		else if (roleCode != null && roleCode.equals("parent"))
		{
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsParent", paramMap);
		}

		/**
		 * 学生 （自己和家长）
		 */
		else if (roleCode != null && roleCode.equals("student"))
		{
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsStudent", paramMap);
		}
		/**
		 * 教职工（ 教师，部门管理员，职工，班主任根据权限来判断能查到的信息）
		 */
		else
		{
			List<Integer> departmentIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "inoutManager", 1);

			List<Integer> clazzIdList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "inoutManager", 0);

			paramMap.put("departmentIdList", departmentIdList);
			paramMap.put("clazzIdList", clazzIdList);
			list = this.getBaseDao().selectListByObject("Inout.getInoutListAsTeachingStaff", paramMap);
		}

		return list;
	}

	/**
	 * 根据userid查找进出记录
	 * 
	 * @param userId
	 *            用户ID
	 * @return 进出记录列表
	 */
	@SuppressWarnings("unchecked")
	public List<Inout> selectInoutListByUserId(Integer userId)
	{
		return getBaseDao().selectListByObject("Inout.selectInoutListByUserId", userId);
	}

	public Inout selectInoutByUserId(Map<String, Object> paramMap)
	{

		return (Inout) getBaseDao().selectObjectByObject("Inout.selectInoutByUserId", paramMap);
	}

	/**
	 * 查询卡号是否存在
	 */
	public boolean isValid(String code)
	{
		Card card = cardService.getCardByCardCode(code);
		if (card != null)
			return true;

		return false;
	}

	/**
	 * 加载进出异常分组数据
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出异常分组数据
	 */
	@SuppressWarnings("unchecked")
	public List<InoutAbnormalTotal> loadGroupData(Map<String, Object> paramMap, Integer roleId)
	{
		List<InoutAbnormalTotal> inoutAbnormalTotalList = new ArrayList<InoutAbnormalTotal>();

		/**
		 * 新增权限划分
		 */
		/**
		 * 校长权限 或者学校管理员权限
		 */
		if (Cons.ROLE_SCHOOLADMIN.equals(roleId) || Cons.ROLE_HEADMASTER.equals(roleId))
		{
			inoutAbnormalTotalList = getBaseDao().selectListByObject("Abnormal.selectGroupDataAsHeadMaster", paramMap);

		}

		/**
		 * 年级组长权限
		 */
		if (Cons.ROLE_GRADELEADER.equals(roleId))
		{
			inoutAbnormalTotalList = getBaseDao().selectListByObject("Abnormal.selectGroupDataAsGradeLeader", paramMap);
		}

		/**
		 * 班主任权限
		 */
		if (Cons.ROLE_HEADTEACHER.equals(roleId))
		{
			inoutAbnormalTotalList = getBaseDao().selectListByObject("Abnormal.selectGroupDataAsHeadTeacher", paramMap);
		}

		return inoutAbnormalTotalList;
	}

	@Override
	public void savePointByDevide(PointInfo point)
	{
		if (null != point)
		{
			if (null != point.getCarId())
			{
				// Date createTime = new Date();
				// SimpleDateFormat sdf = new
				// SimpleDateFormat("yyyyMMddHHmmssms");
				// point.setId(sdf.format(createTime)+point.getCarId());
				getBaseDao().addObject("PointInfo.insertPoint", point);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PointInfo> findPointByDevide(PointInfo point)
	{
		if (null != point)
		{
			if (null != point.getCarId())
			{
				return (List<PointInfo>) getBaseDao().selectListByObject("PointInfo.selectPointByDevide", point);
			}
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Inout> getInoutListAsStudent(Map<String, Object> paramMap)
	{
		return (List<Inout>) this.getBaseDao().selectListByObject("Inout.getInoutListAsStudent", paramMap);
	}

	@Override
	public synchronized void call_abnomalByclazzIdPro(Integer in_clazzId, String in_currentTime)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("in_clazzId", in_clazzId);
		paramMap.put("in_currentTime", in_currentTime);
		this.getBaseDao().selectListByObject("Inout.call_abnomalByclazzIdPro", paramMap);
	}

	@Override
	public synchronized void call_abnormalByUserIdPro(Integer in_userId, String in_currentTime)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("in_userId", in_userId);
		paramMap.put("in_currentTime", in_currentTime);
		this.getBaseDao().selectListByObject("Inout.call_abnormalByUserIdPro", paramMap);
	}

	/**
	 * 学生家长根据服务费接收信息
	 */
	public void sendStudentSmsForSchoolBus(String schoolId, PUSHTYPE pushstates, String phone, Integer parentId, String content, Integer informationType,
			PushDataByJson pd,Integer studentId)
	{
		boolean schoolHasMessage = (boolean) smsService.getSmsServiceStatus().get("schoolHasMessage");// 学校是否有短信套餐

		boolean isVirtualOpen = (boolean) smsService.getSmsServiceStatus().get("isVirtualOpen");// 学校虚拟套餐是否开启

		boolean isSchoolSingleMsg = (boolean) smsService.getSmsServiceStatus().get("isSchoolSingleMsg");// 是否有学校单条类型套餐

		if (schoolHasMessage)// 学校有短信套餐
		{
			if (isVirtualOpen)// 虚拟套餐开启直接发送
			{
				// 调用短信接口
				commonService.sendSmsByDB(schoolId, pushstates, phone, parentId, content, null, informationType, pd);

			} else// 虚拟套餐关闭
			{
				if (isSchoolSingleMsg)// 是否有学校单条套餐 有判断条数
				{

					// 学校条数套餐剩余条数
					Integer remainCount = orderMessageService.getRemainCountBySchoolIdForSchoolRange(schoolId);
					if (null != remainCount && remainCount > 0)// 有条数且大于0
					{
						// 调用短信接口
						commonService.sendSmsByDB(schoolId, pushstates, phone, parentId, content, null, informationType, pd);
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
							commonService.sendSmsByDB(schoolId, pushstates, phone, parentId, content, null, informationType, pd);

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
						commonService.sendSmsByDB(schoolId, pushstates, phone, parentId, content, null, informationType, pd);

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
					}
				}
			}
		} else// 学校无短信套餐 直接发送
		{
			// 调用短信接口
			commonService.sendSmsByDB(schoolId, pushstates, phone, parentId, content, null, informationType, pd);
		}

	}
}
