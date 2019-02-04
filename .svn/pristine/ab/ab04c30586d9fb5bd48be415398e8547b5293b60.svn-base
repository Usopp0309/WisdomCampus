package com.guotop.palmschool.thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.guotop.palmschool.check.cons.CheckCons;
import com.guotop.palmschool.entity.Inout;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.schoolbus.entity.PointInfo;
import com.guotop.palmschool.util.PropertiesUtil;

/**
 * TCP接收端
 * 
 * 
 * 接收读卡器发送过来的数据
 * 
 */
public class BusTCPServer extends Thread
{

	private static final Log log = LogFactory.getLog(BusTCPServer.class);

	private static ServerSocket server = null;

	protected final static int PORT = 8356;

	private static boolean signal = true;

	private static List<SocketHandle> sockets = new ArrayList<SocketHandle>();

	private Long schoolId;

	private static String cardId = "";

	private static String studentId = "";

	private static String x = "0";

	private static String y = "0";

	private static Date createTime;

	/**
	 * 注入配置项 0:使用ip地址 1:使用设备号
	 */
	private String ipSwitch;

	// @Value("#{settings['wisdomcampus.ipSwitch']}")
	// public void setIpSwitch(String ipSwitch)
	// {
	// this.ipSwitch = ipSwitch;
	// }

	public BusTCPServer()
	{
		if (null == server)
		{
			try
			{
				server = new ServerSocket(PORT);
				server.setSoTimeout(1000);
				this.start();
			} catch (Exception e)
			{
				log.error("启动BusServer失败", e);
				e.printStackTrace();
			}
		}
	}

	public void run()
	{
		log.info("NewTCPServer启动");
		while (server != null && signal)
		{
			Socket socket = null;
			try
			{
				socket = server.accept();
			} catch (Exception e)
			{

			}
			if (socket != null)
			{
				SocketHandle sh = new SocketHandle(socket);
				sockets.add(sh);
			}
		}
		log.info("NewTCPServer结束");
	}

	public void disconnect()
	{
		signal = false;
		this.interrupt();
		try
		{
			for (SocketHandle s : sockets)
			{
				s.close();
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		try
		{
			server.close();
			server = null;
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	private boolean trun(String deviceCode, String cardCode, String ip)
	{
//		log.info("设备号 ： " + deviceCode);

		// Long result = Long.parseLong(cardCode, 16);
		String code = cardCode;
//		log.info("卡号 ： " + code);

		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		// ipSwitch 0 IP 1 deviceCode 设备号
		ipSwitch = pro.getProperty("ipSwitch");

		Inout inout = new Inout();
		inout.setCode(code);

		String position = "";

		if (CheckCons.IPSWITCH_DEVICECODE.equals(ipSwitch))
		{
			// 记录设备号
			position = deviceCode;
		} else
		{
			// 记录ip
			position = ip;
		}
		// 根据设备查找数据源
		if(schoolId != null && schoolId != 0l){
			DBContextHolder.setDBType(String.valueOf(schoolId));
			return StartupListener.inoutService.addNewInout(inout, ipSwitch, position,true);
		}
		return false;
	}

	class SocketHandle extends Thread
	{
		private Socket socket = null;
		private InputStream in = null;
		private String ip = null;

		public SocketHandle(Socket socket)
		{
			this.socket = socket;
			this.ip = socket.getInetAddress().toString();
			this.start();
		}

		@SuppressWarnings("unused")
		public void run()
		{
//			log.info("Socket[" + this.getName() + "]开始：" + ip);

			try
			{
				in = socket.getInputStream();
			} catch (IOException e)
			{
				e.printStackTrace();
			}

			if (in != null)
			{
				byte[] b = new byte[40]; // 和消息长相同
				int pos = 0;
				// 作用于记录设备号，true开始记录
				boolean isOK = false;
				// 作用于记录位置信息，true开始记录
				boolean isPosition = false;
				// 作用于记录学生打卡，true开始记录打开信息
				boolean isStudentOK = false;
				// 记录注册，true为过滤注册信息
				boolean isLogin = false;
				while (true)
				{
					try
					{
						// 一个一个字节读取，读取内容为ASCII码
						b[pos] = (byte) in.read();
						// 判断最后一位是否为！，坐标位置获取时最后一位为！
						if (pos == 40 && b[40] > 33)
						{
							b = new byte[40];
						}
						if (b[pos] == -1)
						{
							try
							{
								sleep(100);
							} catch (InterruptedException e)
							{
								break;
							}
							continue;
						}
						// 读卡器在启动时，会先发有LOGIN:XXXX! 过滤10个字节
						if (pos == 0 && b[0] == 76)
						{
							// 表示获取到注册包，过滤完成后为fasle，防止打卡，获取坐标时ascii码重复
							isLogin = true;
							pos++;
							continue;
						}
						if (pos == 0 && b[0] == 82)
						{// R开头设备号
							isOK = true;
							pos++;
							continue;
						}
						if (pos == 0 && b[0] == 97)
						{// a开头admin,+坐标点
							// 表示获取到坐标，过滤完成后为fasle，防止打卡，注册时ascii码重复
							isPosition = true;
							pos++;
							continue;
						}
						// 表示读完坐标
						if (pos == 11 && b[pos] == 76 && isPosition)
						{
							isPosition = false;
							pos++;
							continue;
						}
						// 过滤完成心跳包
						if (pos == 9 && isLogin && b[9] == 49)
						{
							isLogin = false;
							pos = 0;
							continue;
						}
						// R开头心跳包记录设备号
						if (pos == 10 && isOK && b[10] == 33)
						{
							// 存放设备号
							byte[] result = new byte[10];
							// 复制设备号
							System.arraycopy(b, 0, result, 0, 10);
							// 把设备号字节数组转为字符串
							String resultStr = new String(result);
							// 表示已完成记录
							isOK = false;
							// 把设备号放到全局变量中，作用是在记录坐标点时与设备号关联
							cardId = resultStr;
							// 记录学校ID，与坐标点关联
							schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(cardId);
							// 获得输出流
							OutputStream out = socket.getOutputStream();
							// 给客户一个响应
							PrintWriter pw = new PrintWriter(out);
							// 接收到心跳包后会发送获取坐标的指令到DTU
							String reply = "admin,AT+GETGPS?\r\n";
							// 发送指令
							pw.write(reply);
							pw.flush();
							pos = 0;
							continue;
						}
						// 学生打卡,10：换行符
						if (pos == 24 && b[pos] == 10)
						{
							// 设备号+卡号
							byte[] result = new byte[22];
							System.arraycopy(b, 0, result, 0, 22);
							String resultStr = new String(result);
							// 设备号
							String deviceCode = resultStr.substring(0, 10);
							// 卡号
							String code = resultStr.substring(10, 22);
							studentId = code;
							createTime = new Date();
							// 根据学校ID获得数据源
//							log.info("deviceCode:" + deviceCode);
							schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(deviceCode);
							// 根据学校ID转换数据源
							if (schoolId != null && schoolId != 0l)
							{
								DBContextHolder.setDBType(String.valueOf(schoolId));
							}
							OutputStream out = this.socket.getOutputStream();
							PrintWriter pw = new PrintWriter(out);
							// 发送A到DTU，表示我已经读到打卡信息，不要再发送打卡信息过来
							String reply = "A";
							pw.write(reply);
							pw.flush();
							// 记录打卡信息
							trun(deviceCode, code, ip);
							pos = 0;
							isStudentOK = false;
							continue;
						}
						// 获取定位信息
						if (b[pos] == 13 && isPosition && pos > 35)
						{
							byte[] result = new byte[pos + 1];
							System.arraycopy(b, 0, result, 0, pos + 1);
							String resultStr = new String(result);
							// 假如获取到,E,表示已有正确的坐标点传输过来
							if (resultStr.indexOf(",E,") > -1)
							{
								// E表示经度，东经
								String isX = resultStr.substring(14, resultStr.indexOf(",E,"));
								// 表示纬度
								String isY = resultStr.substring(resultStr.indexOf(",E,") + 3, resultStr.indexOf("OK") - 2);
								// 如果坐标和上一个坐标完全相同，那就不记录坐标
								if ((!x.equals(isX)) && !y.equals(isY))
								{
									x = isX;
									y = isY;
									// 记录设备号
									if (cardId.length() > 10)
									{
										cardId = cardId.substring(0, 10);
									}
									// 坐标点
									PointInfo point = new PointInfo();
									point.setX(x);
									point.setY(y);
									// 记录设备号
									point.setCarId(cardId);
									// 记录上一个打卡的学生
									point.setUserId(studentId);
									if (createTime == null)
									{
										createTime = new Date();
									}
									point.setCreateTime(createTime);
									// 多线程记录坐标点
									BusTread bt = new BusTread(point);
									Thread t = new Thread(bt);
									t.start();
									studentId = "";
									createTime = null;
								}
							}
							pos = 0;
							isPosition = false;
							continue;
						}
						pos++;
					} catch (IOException e)
					{
						break;
					}
				}
			}
			if (null != schoolId && !"".equals(schoolId) && !"null".equals(schoolId) && null != this.getName() && !"".equals(this.getName()))
			{
				DBContextHolder.setDBType(String.valueOf(schoolId));
				StartupListener.deviceMonitorService.updateDeviceDisconnect(this.getName());
			}
			System.out.println();

//			log.info("Socket[" + this.getName() + "]结束：" + ip);

			sockets.remove(this);
		}

		public void close()
		{
			try
			{
				in.close();
			} catch (IOException e1)
			{
				e1.printStackTrace();
			}

			try
			{
				socket.close();
				socket = null;
			} catch (IOException e)
			{
				e.printStackTrace();
			}
			this.interrupt();
		}
	}

}
