 package com.guotop.palmschool.thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.guotop.palmschool.check.cons.CheckCons;
import com.guotop.palmschool.entity.Inout;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;

/**
 * SchoolBus接收端
 * 
 * 
 * 接收读卡器发送过来的数据
 * 
 */
public class SchoolBusServer extends Thread 
{

	private static final Log log = LogFactory.getLog(SchoolBusServer.class);

	private static ServerSocket server = null;

	protected final static int PORT = 8361;

	private static boolean signal = true;

	private static List<SocketHandle> sockets = new ArrayList<SocketHandle>();
	
	/**
	 * 注入配置项  0:使用ip地址   1:使用设备号
	 */
	private String ipSwitch;
	
//	@Value("#{settings['wisdomcampus.ipSwitch']}")   
//	public void setIpSwitch(String ipSwitch)
//	{
//		this.ipSwitch = ipSwitch;
//	}
	
	public SchoolBusServer() 
	{
		if (null == server) 
		{
			try 
			{
				server = new ServerSocket(PORT);
				server.setSoTimeout(1000);
				this.start();
			} 
			catch (Exception e) 
			{
				log.error("启动SchoolBusServer失败", e);
				e.printStackTrace();
			}
		}
	}

	public void run() 
	{
		log.info("SchoolBusServer启动");
		while (server != null && signal) 
		{
			Socket socket = null;
			try 
			{
				socket = server.accept();
				
			} 
			catch (Exception e) 
			{
				
			}
			if (socket != null) 
			{
				try
				{
					socket.setSoTimeout(300000);
				} catch (SocketException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				SocketHandle sh = new SocketHandle(socket);
				sockets.add(sh);
				
			}
			
		}
		log.info("SchoolBusServer结束");
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
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		try 
		{
			server.close();
			server = null;
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}

	private boolean trun(byte[] b, String ip) 
	{
		byte[] cardbytes = new byte[17];
		System.arraycopy(b, 0, cardbytes, 0, 17);
		
		String cardStr = new String(cardbytes);
//		log.info("b :: " + Arrays.toString(b) );
//		log.info("cardbytes:: " + Arrays.toString(cardbytes) );
		
		cardStr = cardStr.replaceAll("\n", "");
//		log.info("!!!!!!!!!!!! " + cardStr );
		String deviceCode = cardStr.substring(0, 4);
		String cardCode = cardStr.substring(4, 14);
		
//		log.info("设备号 ： "  +  deviceCode);
		
//		log.info("卡号 ： "  +  cardCode);
		
		//ipSwitch 0 IP  1 deviceCode 设备号
		ipSwitch = "1";
		
		Inout inout = new Inout();
		inout.setCode(cardCode);
		
		String position = "";
		
		if (CheckCons.IPSWITCH_DEVICECODE.equals(ipSwitch))
		{
			//记录设备号
			position = deviceCode;
		}
		else
		{
			//记录ip
			position = ip;
		}
	
		return StartupListener.inoutService.addInout(inout, ipSwitch, position,true);
		
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

		public void run() 
		{
//			log.info("Socket[" + this.getName() + "]开始：" + ip);

			try 
			{
				in = socket.getInputStream();
			}
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			
			String deviceCode = null;

			Long schoolId = null;
			if (in != null) 
			{
				byte[] b = new byte[30]; // 和消息长相同
				int pos = 0;
				
				boolean isOK = false;
				
				while (true) 
				{
					if (socket.isClosed())
					{
						break;
					}
					
					try 
					{
						b[pos] = (byte) in.read();
						
						if (b[pos] == -1)
						{
							try {
								sleep(100);
							} catch (InterruptedException e)
							{
								break;
							}
							continue;
						}
						
						if (pos == 0 && b[0] == 49) {//1 开头
							// 过滤心跳包
							isOK = false;
							pos++;
							continue;
						}
						if(pos==3&& !isOK &&b[pos] == 49){
							pos=0;
							continue;
						}
						
						if (pos==4&&b[4] == 82) {//R开头
							// 过滤心跳包
							isOK = false;
							pos=0;
							continue;
						}
						
						if (pos == 0 && b[0] == 76) {
							// 读卡器在启动时，会先发有LOGIN:XXXX! 9个字节
							isOK = true;
							pos++;
							continue;
						}
						
						if (pos == 9 && isOK) 
						{
							// OK信息结束
							byte[] header = new byte[10];
							System.arraycopy(b, 0, header, 0, 10);
//							log.info("get:" + new String(header) + "初始化信息");
							
							String cardStr = new String(header);
							
						    deviceCode = cardStr.substring(6);
						    
//						    log.info("设备号 :" + deviceCode);
						    
							isOK = false;
							pos = 0;
							//根据设备查找数据源
							schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(deviceCode);
							
							if(null!=schoolId && 0l != schoolId)
							{
								DBContextHolder.setDBType(String.valueOf(schoolId));
								
								StartupListener.deviceMonitorService.updateDeviceConnection(1, this.getName(), deviceCode);
							}
							
							continue;
						}
						if (b[pos] == 10 && !isOK) 
						{
							
							OutputStream out = this.socket.getOutputStream();
							PrintWriter pw=new PrintWriter(out); 
			                String reply = "A";
			                pw.write(reply);
			                pw.flush();
							// 正常信息结束
							trun(b, ip);
							pos = 0;
							try {
								sleep(1);
							} catch (InterruptedException e)
							{
								break;
							}
							continue;
						}
						
						pos++;
					} 
					catch (IOException e) 
					{
						break;
					}
					
				}
				
			}
			if(null!=schoolId){
				DBContextHolder.setDBType(String.valueOf(schoolId));
				StartupListener.deviceMonitorService.updateDeviceDisconnect(this.getName());
			}

//			log.info("Socket[" + this.getName() + "]结束：" + ip);
			
			sockets.remove(this);
		}

		public void close() 
		
		{
			try 
			{
				in.close();
			}
			catch (IOException e1) 
			{
				e1.printStackTrace();
			}
			
			try 
			{
				socket.close();
				socket = null;
			}
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			this.interrupt();
		}
	}

}
