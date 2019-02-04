package com.guotop.palmschool.thread;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.service.InoutService;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 统计线程
 * 
 * @author syj
 * @date 2016年11月25日
 */
public class StatisticAttendanceThread extends Thread
{
	private Logger logger = LoggerFactory.getLogger(StatisticAttendanceThread.class);
	private Long schoolId;
	@Resource
	private InoutService inoutService;

	private List<Clazz> clazzList;
	private List<User> teacherList;
	public StatisticAttendanceThread(Long schoolId,List<Clazz> clazzList,List<User> teacherList)
	{
		this.clazzList = clazzList;
		this.teacherList = teacherList;
		this.schoolId = schoolId;
		inoutService = StartupListener.inoutService;
	}

	@Override
	public void run()
	{
		clazzAttendance();
		teacherAttendance();
	}
	
	public void clazzAttendance(){
		if(!CollectionUtils.isEmpty(clazzList)){
			//循环出所有班级
			String currentTime = TimeUtil.getInstance().now();
			logger.info(schoolId+"_班级考勤统计开始-start:" + new Date());
			DBContextHolder.setDBType(String.valueOf(schoolId));
			for(Clazz clazz : clazzList){
				try{
					//传入参数clazzId,调用存储过程abnormalByClazzIdPro
					Integer clazzId =  clazz.getId();
					inoutService.call_abnomalByclazzIdPro(clazzId,currentTime);
					Thread.sleep(3000);
				}catch(Exception e){
					logger.error("call_abnomalByclazzIdPro error :" + e.getMessage());
					continue;
				}
			}
			logger.info(schoolId+"_班级考勤统计结束-end:" + new Date());
		}
	}
	
	public void teacherAttendance(){
		if(!CollectionUtils.isEmpty(teacherList)){
			//循环所有教职工
			String currentTime = TimeUtil.getInstance().now();
			logger.info(schoolId+"_教职工考勤统计开始-start:" + new Date());
			DBContextHolder.setDBType(String.valueOf(schoolId));
			for(User user : teacherList){
				try{
					//传入teacherId，调用存储过程abnormalByTeacherIdPro
					Integer userId =  user.getUserId();
					inoutService.call_abnormalByUserIdPro(userId,currentTime);
					Thread.sleep(1000);
				}catch(Exception e){
					logger.error("call_abnormalByUserIdPro error :" + e.getMessage());
					continue;
				}
			}
			logger.info(schoolId+"_教职工考勤统计结束-end:" + new Date());
		}
	}
}
