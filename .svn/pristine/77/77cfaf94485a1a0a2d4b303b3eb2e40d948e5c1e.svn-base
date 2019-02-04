package com.guotop.palmschool.scheduler;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.scheduler.entity.SchoolCountInfo;
import com.guotop.palmschool.scheduler.service.CountService;
import com.guotop.palmschool.service.PushmessageService;
import com.guotop.palmschool.util.TimeUtil;

@Component("BackUpScheduler")
public class BackUpScheduler {

	private Logger logger = LoggerFactory.getLogger(BackUpScheduler.class);
	@Resource
	private CountService countService;
	
	@Resource
	private PushmessageService messageService;
	
	@Autowired
	private ThreadPoolTaskExecutor poolTaskExecutor;
	//每个星期四的00:01触发 
	@Scheduled(cron = "0 00 01 * * THU")
//	@Scheduled(cron = "0 28 19 * * WED")
	public void plamFormInoutJob(){
		// 获取待统计学校列表
		final List<SchoolCountInfo> list = countService.getSchoolDataSorceList();
			poolTaskExecutor.execute(new Thread(new Runnable() {
			@Override
			public void run() {
				/**
				 * PalmInout表的数据迁移 只保留一个月的数据
				 * 其他数据迁移到 palm_inout_back中
				 */
				if(!CollectionUtils.isEmpty(list)){
					System.out.println("Inout"+"开始:"+TimeUtil.getInstance().now());
					for (SchoolCountInfo ci : list)
					{
						try {
							String staTime = TimeUtil.getInstance().getBeforeMonth();//当前时间 的 一个月前的时间 
							DBContextHolder.setDBType(String.valueOf(ci.getSchoolId()));
							Integer count = countService.getPlamInout(staTime);
							if(count > 0){
								countService.addPalmInoutBack(staTime);
							}
						} catch (Exception e) {
							logger.error("Inout数据迁移失败:" + ci.getSchoolId());
							continue;
						}
						
					}
					System.out.println("Inout"+"结束:"+TimeUtil.getInstance().now());
				}
				
			}
		}));
			poolTaskExecutor.execute(new Thread(new Runnable() {
				/**
				 * SmsDetail表的数据迁移 只保留一个月的数据
				 * 其他数据迁移到 palm_sysDetail_back中
				 */
				@Override
				public void run() {
					System.out.println("SmsDetail"+"开始:"+TimeUtil.getInstance().now());
					if(!CollectionUtils.isEmpty(list)){
						for (SchoolCountInfo ci : list)
						{
							try {
								String staTime = TimeUtil.getInstance().getBeforeMonth();//当前时间 的 一个月前的时间 
								DBContextHolder.setDBType(String.valueOf(ci.getSchoolId()));
								Integer count = countService.getSmsDetail(staTime);
								if(count > 0){
									countService.addSmsDetailBack(staTime);
									
								}
								
								
							} catch (Exception e) {
								logger.error("SmsDetail数据迁移失败:" + ci.getSchoolId());
								continue;
							}
							
						}
						System.out.println("SmsDetail"+"结束:"+TimeUtil.getInstance().now());
					}
					
				}
			}));
			poolTaskExecutor.execute(new Thread(new Runnable() {
				/**
				 * palm_sys_message表的数据迁移 只保留一个月的数据
				 * 其他数据迁移到 palm_sys_message_back中
				 */
				@Override
				public void run() {
					System.out.println("SysMessage"+"开始:"+TimeUtil.getInstance().now());
					if(!CollectionUtils.isEmpty(list)){
						for (SchoolCountInfo ci : list)
						{
							try {
								String staTime = TimeUtil.getInstance().getBeforeMonth();//当前时间 的 一个月前的时间 
								DBContextHolder.setDBType(String.valueOf(ci.getSchoolId()));
								Integer count = countService.getSysMessage(staTime);
								if(count > 0){
									countService.addSysMessageBack(staTime);
								}
								
							} catch (Exception e) {
								logger.error("SysMessage数据迁移失败:" + ci.getSchoolId());
								continue;
							}
							
						}
						System.out.println("SysMessage"+"结束:"+TimeUtil.getInstance().now());
					}
					
				}
			}));
			poolTaskExecutor.execute(new Thread(new Runnable() {
				/**
				 * palm_checkattendance表的数据迁移 只保留一个月的数据
				 * 其他数据迁移到 palm_checkattendance_back中
				 */
				@Override
				public void run() {
					System.out.println("Checkattendance"+"开始:"+TimeUtil.getInstance().now());
					if(!CollectionUtils.isEmpty(list)){
						for (SchoolCountInfo ci : list)
						{
							try {
								String staTime = TimeUtil.getInstance().getBeforeMonth();//当前时间 的 一个月前的时间 
								DBContextHolder.setDBType(String.valueOf(ci.getSchoolId()));
								Integer count = countService.getCheckattendance(staTime);
								if(count > 0){
									countService.addCheckattendanceBack(staTime);
								}
								
							} catch (Exception e) {
								logger.error("Checkattendance数据迁移失败:" + ci.getSchoolId());
								continue;
							}
							
						}
						System.out.println("Checkattendance"+"结束:"+TimeUtil.getInstance().now());
					}
					
				}
			}));
			
			
			/*
			 * pushmessage 数据删除
			 */
			poolTaskExecutor.execute(new Thread(new Runnable() {
				/**
				 * pushmessage表的数据删除 只保留两周内的数据
				 * 
				 */
				@Override
				public void run() {
					System.out.println("pushmessage"+"开始:"+TimeUtil.getInstance().now());
							try {
								SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddhhmm");
								
								/**
								 * 获取当天前 14 天 时间
								 */
								Calendar cal = Calendar.getInstance();
								cal.setTime(new Date());
								cal.add(Calendar.DATE, - 14);
						        Date d = cal.getTime();
						        String millionSeconds = formatter.parse(formatter.format(d)).getTime()+"";
								
								Integer count = messageService.getPushmessageByDate(millionSeconds);
								if(count > 0){
									messageService.deletePushmessageByDate(millionSeconds);
								}
								
							} catch (Exception e) {
								logger.error("pushmessage数据删除:" + TimeUtil.getInstance().now());
							}
							
							System.out.println("pushmessage"+"结束:"+TimeUtil.getInstance().now());
						}
			}));
	}
}
