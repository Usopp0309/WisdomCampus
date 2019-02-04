package com.guotop.palmschool.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.guotop.palmschool.bluetooth.quartz.QuartzManager;
import com.guotop.palmschool.bluetooth.service.BluetoothDataService;
import com.guotop.palmschool.bluetooth.service.BluetoothStudentService;
import com.guotop.palmschool.bluetooth.service.BraceletService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.common.service.impl.CommonServiceImpl;
import com.guotop.palmschool.meeting.service.MeetingDetailService;
import com.guotop.palmschool.meeting.service.MeetingService;
import com.guotop.palmschool.meeting.service.impl.MeetingServiceImpl;
import com.guotop.palmschool.patrol.service.PatrolService;
import com.guotop.palmschool.scheduler.service.CountService;
import com.guotop.palmschool.service.DeviceMonitorService;
import com.guotop.palmschool.service.DeviceService;
import com.guotop.palmschool.service.InoutService;
import com.guotop.palmschool.service.LocationInfoService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.PermissionService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.service.impl.DeviceMonitorServiceImpl;
import com.guotop.palmschool.service.impl.InoutServiceImpl;
import com.guotop.palmschool.service.impl.UserServiceImpl;
import com.guotop.palmschool.shopping.service.OrdersService;
import com.guotop.palmschool.thread.BusTCPServer;
import com.guotop.palmschool.thread.NewTCPServer;
import com.guotop.palmschool.thread.PatrolTCPServer;
import com.guotop.palmschool.thread.RVRXTCPServer;
import com.guotop.palmschool.thread.SchoolBusServer;
import com.guotop.palmschool.thread.TCPServer;
import com.guotop.palmschool.thread.TCPServerSY;
import com.guotop.palmschool.thread.TCPServerWT;

/**
 * 启动监听，启动注入servicebean和启动线程
 * @author zhou
 *
 */
public class StartupListener extends BaseStartupListener 
{
	private static String root;
	
	public static CommonService commonService;
	
	public static InoutService inoutService;
	
	public static MeetingService meetingService;
	
	public static MeetingDetailService meetingDetailService;
	
	public static PatrolService patrolService;
	/**
	 * 用户业务类
	 */
	public static UserService userService;
	/**
	 * 设备监控业务类
	 */
	public static DeviceMonitorService deviceMonitorService;
	/**
	 * 设备业务类
	 */
	public static DeviceService deviceService;
	/**
	 * 学校统计类
	 */
	public static CountService countService;
	
	public static OrdersService ordersService;
	 
	public static OrderMessageService orderMessageService;
	/**
	 * 定位实现类
	 */
	public static LocationInfoService locationInfoService;
	
	public static PermissionService permissionService;
	
	/**
	 * TCP服务
	 */
	public static TCPServer server;
	/**
	 * 新TCP服务
	 */
	public static NewTCPServer newServer;
	/**
	 * BusTCP服务
	 */
	public static BusTCPServer busServer;
	/**
	 * TCP服务
	 */
	public static TCPServerWT serverwt;
	
	/**
	 * TCP服务
	 */
	public static SchoolBusServer schoolBusServer;
	
	/**
	 * TCP服务
	 */
	public static RVRXTCPServer rvrxTCPServer;
	
	/**
	 * TCP服务
	 */
	public static TCPServerSY tcpServerSY;
	
	/**
	 * TCP服务
	 */
	public static PatrolTCPServer patrolTCPServer;
	
	public static BraceletService braceletService;
	public static BluetoothStudentService bluetoothStudentService;
	public static BluetoothDataService bluetoothDataService;
	public static QuartzManager quartzManager;
	
	public void init(ServletContext context) 
	{
		ApplicationContext ctx = WebApplicationContextUtils
				.getRequiredWebApplicationContext(context);
		
		root = context.getRealPath("/");
		
		commonService = (CommonServiceImpl)ctx.getBean("commonService");
		inoutService = (InoutServiceImpl)ctx.getBean("inoutService");
		meetingService = (MeetingServiceImpl)ctx.getBean("meetingService");
		meetingDetailService = (MeetingDetailService)ctx.getBean("meetingDetailService");
		patrolService = (PatrolService) ctx.getBean("patrolService");
		userService = (UserServiceImpl) ctx.getBean("userService");
		deviceService = (DeviceService)ctx.getBean("deviceService");
		deviceMonitorService = (DeviceMonitorServiceImpl) ctx.getBean("deviceMonitorService");
		countService = (CountService)ctx.getBean("countService");
		ordersService = (OrdersService)ctx.getBean("ordersService");
		orderMessageService = (OrderMessageService)ctx.getBean("orderMessageService");
		locationInfoService = (LocationInfoService)ctx.getBean("locationInfoService");
		permissionService = (PermissionService)ctx.getBean("permissionService");
		
		braceletService = (BraceletService)ctx.getBean("braceletService");
		quartzManager = new QuartzManager(braceletService);
		bluetoothStudentService = (BluetoothStudentService)ctx.getBean("bluetoothStudentService");
		bluetoothDataService= (BluetoothDataService)ctx.getBean("bluetoothDataService");
		
		server = new TCPServer();
		newServer = new NewTCPServer();
		busServer = new BusTCPServer();
		serverwt = new TCPServerWT();
		schoolBusServer = new SchoolBusServer();
		rvrxTCPServer = new RVRXTCPServer();
		tcpServerSY = new TCPServerSY();
		patrolTCPServer = new PatrolTCPServer();
	}
	
	
	public void close(ServletContextEvent event) 
	{
		server.disconnect();
		server = null;
		
		newServer.disconnect();
		newServer = null;
		
		busServer.disconnect();
		busServer = null;
		
		serverwt.disconnect();
		serverwt = null;
		
		schoolBusServer.disconnect();
		schoolBusServer = null;
		
		rvrxTCPServer.disconnect();
		rvrxTCPServer = null;
		
		tcpServerSY.disconnect();
		tcpServerSY = null;
		
		patrolTCPServer.disconnect();
		patrolTCPServer = null;
	}
	
	public static String getRoot() 
	{
		return root;
	}
	
	public static long seqno = System.currentTimeMillis();
	
	public static String getSeq() 
	{
		return String.valueOf(seqno++);
	}
	
}
