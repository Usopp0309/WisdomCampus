package com.guotop.palmschool.bluetooth.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.guotop.palmschool.listener.StartupListener;
  
/** 
 * @Description: 蓝牙路由器扫描执行类 
 * 
 * @ClassName: HubScanJob 
 * 
 */  
public class HubScanJob implements Job {  
  
	private Logger logger = LoggerFactory.getLogger(HubScanJob.class);
    @Override  
    public void execute(JobExecutionContext context) throws JobExecutionException { 
    	JobDataMap data = context.getJobDetail().getJobDataMap();
		String schoolId = data.getString("schoolId");
        System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+ "★★★★★★★★★★★"); 
        BlueToothDataHandle.saveBlueToothDataToDB(StartupListener.braceletService, StartupListener.bluetoothStudentService,
				StartupListener.bluetoothDataService, logger,schoolId);
    }  
} 