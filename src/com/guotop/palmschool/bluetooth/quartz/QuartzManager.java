package com.guotop.palmschool.bluetooth.quartz;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;

import com.guotop.palmschool.bluetooth.entity.BluetoothBracelet;
import com.guotop.palmschool.bluetooth.entity.BluetoothSchool;
import com.guotop.palmschool.bluetooth.service.BraceletService;
import com.guotop.palmschool.util.CollectionUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * @Description: 定时任务管理类
 */
public class QuartzManager
{
	private static SchedulerFactory gSchedulerFactory = new StdSchedulerFactory();

	public QuartzManager(BraceletService braceletService)
	{
		initTask(braceletService);
	}

	/**
	 * @Description: 添加一个定时任务
	 * 
	 * @param key
	 *            任务名
	 * @param jobClass
	 *            任务
	 * @param cron
	 *            【"10/2 * * * * ?"】 时间设置，参考quartz说明文档
	 * @Title: QuartzManager.java
	 */
	@SuppressWarnings("rawtypes")
	public static void addJob(String schoolId, String key, Class jobClass, String cron)
	{
		try
		{
			Scheduler sched = gSchedulerFactory.getScheduler();
			JobDetail jobDetail = new JobDetail(key + "_job", key + "_jobGroup", jobClass);// 任务名，任务组，任务执行类
			jobDetail.getJobDataMap().put("schoolId", schoolId);
			// 触发器
			CronTrigger trigger = new CronTrigger(key + "trigger", key + "triggerGroup");// 触发器名,触发器组
			trigger.setCronExpression(cron);// 触发器时间设定
			sched.scheduleJob(jobDetail, trigger);
			// 启动
			if (!sched.isShutdown())
			{
				sched.start();
			}
		} catch (Exception e)
		{
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 移除一个任务
	 * 
	 * @param key
	 * 
	 * @Title: QuartzManager.java
	 */
	public static void removeJob(String key)
	{
		try
		{
			Scheduler sched = gSchedulerFactory.getScheduler();
			sched.pauseTrigger(key + "trigger", key + "triggerGroup");// 停止触发器
			sched.unscheduleJob(key + "trigger", key + "triggerGroup");// 移除触发器
			sched.deleteJob(key + "_job", key + "_jobGroup");// 删除任务
		} catch (Exception e)
		{
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description:启动所有定时任务
	 * 
	 * 
	 * @Title: QuartzManager.java
	 */
	public static void startJobs()
	{
		try
		{
			Scheduler sched = gSchedulerFactory.getScheduler();
			sched.start();
		} catch (Exception e)
		{
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description:关闭所有定时任务
	 * 
	 * @Title: QuartzManager.java
	 */
	public static void shutdownJobs()
	{
		try
		{
			Scheduler sched = gSchedulerFactory.getScheduler();
			if (!sched.isShutdown())
			{
				sched.shutdown();
			}
		} catch (Exception e)
		{
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据手环数据设置修改定时任务
	 * 
	 * @author syj
	 */
	public static void reSetTask(String startTime, String endTime, BraceletService braceletService, String schoolId)
	{
		if (StringUtil.isEmpty(startTime) || StringUtil.isEmpty(endTime))
		{
			return;
		}
		// 生效时间
		String validDate = startTime.split(" ")[0];
		BluetoothBracelet bluetoothBracelet = braceletService.getMaxTimeMinTime(validDate + " 00:00:01", validDate + " 23:59:59");
		try
		{
			String newStartTime = startTime;
			String newEndTime = endTime;
			// 是否需要更新学校库
			boolean flag = false;
			if (bluetoothBracelet == null)
			{
				newStartTime = startTime;
				newEndTime = endTime;
				flag = true;
			} else
			{
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date baseStart = f.parse(bluetoothBracelet.getStartTime());
				Date baseEnd = f.parse(bluetoothBracelet.getEndTime());
				Date st = f.parse(startTime);
				Date et = f.parse(endTime);

				if (st.before(baseStart) || st.equals(baseStart))
				{
					flag = true;
					newStartTime = startTime;
				}
				if (et.after(baseEnd) || et.equals(baseStart))
				{
					flag = true;
					newEndTime = endTime;
				}
			}
			if (flag)
			{
				List<BluetoothSchool> taskList = braceletService.getBluetoothSchoolBySchoolIdAndCreateDate(schoolId, validDate);
				if (!CollectionUtil.isEmpty(taskList))
				{
					for (BluetoothSchool bs : taskList)
					{
						// 创建定时任务
						removeJob(schoolId + "_" + validDate + "_" + bs.getJobKey());
					}
				}
				braceletService.deleteBluetoothSchoolBySchoolIdAndCreateDate(schoolId, validDate);
				List<Map<String, String>> cronExpressionsList = getCron(newStartTime, newEndTime, 5);// 默认5分钟
				if (!CollectionUtil.isEmpty(cronExpressionsList))
				{
					int count = 0;
					for (Map<String, String> map : cronExpressionsList)
					{
						try
						{
							BluetoothSchool bluetoothSchool = new BluetoothSchool();
							bluetoothSchool = new BluetoothSchool();
							bluetoothSchool.setSchoolId(schoolId);
							bluetoothSchool.setStartTime(map.get("startTime"));
							bluetoothSchool.setEndTime(map.get("endTime"));
							bluetoothSchool.setCreateDate(validDate);
							bluetoothSchool.setCronExpression(map.get("cron"));
							bluetoothSchool.setTimes(5);// 默认5分钟
							bluetoothSchool.setJobKey(count);
							braceletService.insertBluetoothSchool(bluetoothSchool);
							count++;
							addJob(schoolId, schoolId + "_" + validDate + "_" + count, HubScanJob.class, map.get("cron"));
						} catch (Exception e)
						{
							continue;
						}
					}
				}
			}

		} catch (ParseException e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 初始化定时任务
	 * 
	 * @author syj
	 */
	public static void initTask(BraceletService braceletService)
	{
		// 每个学校手环的最小开始时间，和最大结束时间
		List<BluetoothSchool> listSchool = braceletService.getAllBluetoothSchool();
		if (!CollectionUtil.isEmpty(listSchool))
		{
			for (BluetoothSchool bluetoothSchool : listSchool)
			{
				try
				{
					addJob(bluetoothSchool.getSchoolId(), bluetoothSchool.getSchoolId() + "_" + bluetoothSchool.getCreateDate() + "_" + bluetoothSchool.getJobKey(),
							HubScanJob.class, bluetoothSchool.getCronExpression());
				} catch (Exception e)
				{
					e.printStackTrace();
					continue;
				}
			}
		}
	}

	/**
	 * 根据时间来生成Corn
	 * 
	 * @param startTime
	 *            开始时间 yyyy-MM-dd HH:mm:ss
	 * @param endTime
	 *            结束时间yyyy-MM-dd HH:mm:ss
	 * @param times
	 *            时间间隔 开始时间和结束时间必须是同一天,因为一节体育课不可能跨天
	 * @return
	 */
	public static List<Map<String, String>> getCron(String startTime, String endTime, int times)
	{
		List<Map<String, String>> cronList = new ArrayList<Map<String, String>>();
		try
		{
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// 如果开始时间小于当前时间
			if (formatter.parse(startTime).getTime() <= new Date().getTime())
			{
				startTime = TimeUtil.getInstance().now();
			}
			Calendar c = Calendar.getInstance();
			c.setTime(formatter.parse(startTime));
			int start_min = c.get(Calendar.MINUTE);
			int start_hours = c.get(Calendar.HOUR_OF_DAY);
			int start_day = c.get(Calendar.DATE);
			int start_month = c.get(Calendar.MONTH) + 1;
			int start_year = c.get(Calendar.YEAR);

			c.setTime(formatter.parse(endTime));
			int end_min = c.get(Calendar.MINUTE);
			int end_hours = c.get(Calendar.HOUR_OF_DAY);

			// 计算开始时间和结束时间之间差了几个小时
			int except_hours = end_hours - start_hours;
			if (except_hours == 0)
			{
				// 11:05 - 11:30
				// 一个cron表达式
				String cron1 = "0 " + start_min + "-" + end_min + "/" + times + " " + start_hours + " " + start_day + " " + start_month + " ? " + start_year + "";
				if (end_min != start_min)
				{
					Map<String, String> map = new HashMap<String, String>();
					map.put("cron", cron1);
					map.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":" + start_min + ":00");
					map.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":" + end_min + ":00");
					cronList.add(map);
				}
			} else if (except_hours == 1)
			{
				// 11:05 - 12:30
				// 两个cron表达式
				if (59 != start_min)
				{
					Map<String, String> map = new HashMap<String, String>();
					String cron1 = "0 " + start_min + "-" + 59 + "/" + times + " " + start_hours + " " + start_day + " " + start_month + " ? " + start_year + "";
					map.put("cron", cron1);
					map.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":" + start_min + ":00");
					map.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":59:59");
					cronList.add(map);
				}
				if (0 != end_min)
				{
					Map<String, String> map = new HashMap<String, String>();
					String cron2 = "0 " + 0 + "-" + end_min + "/" + times + " " + end_hours + " " + start_day + " " + start_month + " ? " + start_year + "";
					map.put("cron", cron2);
					map.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + end_hours + ":00:00");
					map.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + end_hours + ":" + end_min + ":59");
					cronList.add(map);
				}
			} else if (except_hours == 2)
			{
				// 11:05 - 13:20或者11:05 - 14:20
				// 三个cron表达式
				if (59 != start_min)
				{
					Map<String, String> map1 = new HashMap<String, String>();
					String cron1 = "0 " + start_min + "-" + 59 + "/" + times + " " + start_hours + " " + start_day + " " + start_month + " ? " + start_year + "";
					map1.put("cron", cron1);
					map1.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":" + start_min + ":00");
					map1.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":59:59");
					cronList.add(map1);
				}
				Map<String, String> map2 = new HashMap<String, String>();
				String cron2 = "0 " + 0 + "/" + times + " " + (start_hours + 1) + " " + start_day + " " + start_month + " ? " + start_year + "";
				map2.put("cron", cron2);
				map2.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + (start_hours + 1) + ":00:00");
				map2.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + (start_hours + 1) + ":59:59");
				cronList.add(map2);
				if (0 != end_min)
				{
					Map<String, String> map3 = new HashMap<String, String>();
					String cron3 = "0 " + 0 + "-" + end_min + "/" + times + " " + end_hours + " " + start_day + " " + start_month + " ? " + start_year + "";
					map3.put("cron", cron3);
					map3.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + end_hours + ":00:00");
					map3.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + end_hours + ":" + end_min + ":59");
					cronList.add(map3);
				}
			} else if (except_hours > 2)
			{
				// 11:05 - 13:20或者11:05 - 14:20
				// 三个cron表达式
				if (59 != start_min)
				{
					Map<String, String> map1 = new HashMap<String, String>();
					String cron1 = "0 " + start_min + "-" + 59 + "/" + times + " " + start_hours + " " + start_day + " " + start_month + " ? " + start_year + "";
					map1.put("cron", cron1);
					map1.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":" + start_min + ":00");
					map1.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + start_hours + ":59:59");
					cronList.add(map1);
				}
				Map<String, String> map2 = new HashMap<String, String>();
				String cron2 = "0 " + 0 + "/" + times + " " + (start_hours + 1) + "-" + (end_hours - 1) + " " + start_day + " " + start_month + " ? " + start_year + "";
				map2.put("cron", cron2);
				map2.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + (start_hours + 1) + ":00:00");
				map2.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + (end_hours - 1) + ":59:59");
				cronList.add(map2);
				if (0 != end_min)
				{
					Map<String, String> map3 = new HashMap<String, String>();
					String cron3 = "0 " + 0 + "-" + end_min + "/" + times + " " + end_hours + " " + start_day + " " + start_month + " ? " + start_year + "";
					map3.put("cron", cron3);
					map3.put("startTime", start_year + "-" + start_month + "-" + start_day + " " + end_hours + ":00:00");
					map3.put("endTime", start_year + "-" + start_month + "-" + start_day + " " + end_hours + ":" + end_min + ":59");
					cronList.add(map3);
				}
			}
		} catch (ParseException e)
		{
			e.printStackTrace();
			return cronList;
		}
		return cronList;
	}

	public static void main(String[] args)
	{
		System.out.println("间隔一个小时内-----start-----");
		List<Map<String, String>> cronList1 = getCron("2017-05-12 11:02:30", "2017-05-12 11:50:30", 1);
		for (Map<String, String> map : cronList1)
		{
			System.out.println(map.get("startTime"));
			System.out.println(map.get("endTime"));
			System.out.println(map.get("cron"));
		}
		System.out.println("间隔2个小时内-----start -----");
		List<Map<String, String>> cronList2 = getCron("2017-05-12 11:02:30", "2017-05-12 12:50:30", 1);
		for (Map<String, String> map : cronList2)
		{
			System.out.println(map.get("startTime"));
			System.out.println(map.get("endTime"));
			System.out.println(map.get("cron"));
		}
		System.out.println("间隔2个小时以上-----start-----");
		List<Map<String, String>> cronList3 = getCron("2017-05-12 11:02:30", "2017-05-12 13:50:30", 1);
		for (Map<String, String> map : cronList3)
		{
			System.out.println(map.get("startTime"));
			System.out.println(map.get("endTime"));
			System.out.println(map.get("cron"));
		}
		System.out.println("间隔3个小时以上-----start-----");
		List<Map<String, String>> cronList4 = getCron("2017-05-12 11:02:30", "2017-05-12 14:50:30", 1);
		for (Map<String, String> map : cronList4)
		{
			System.out.println(map.get("startTime"));
			System.out.println(map.get("endTime"));
			System.out.println(map.get("cron"));
		}
	}
}