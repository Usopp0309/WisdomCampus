package com.guotop.palmschool.thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.guotop.palmschool.check.cons.CheckCons;
import com.guotop.palmschool.entity.Inout;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;

/**
 * TCP接收端
 * 【育才学校】正在使用
 * 
 * 接收读卡器发送过来的数据
 * 
 */
public class TCPServer extends Thread
{

	private static final Log log = LogFactory.getLog(TCPServer.class);

	private static ServerSocket server = null;

	protected final static int PORT = 8350;

	private static boolean signal = true;

	private static List<SocketHandle> sockets = new ArrayList<SocketHandle>();
	
	private Long schoolId;

	/**
	 * 注入配置项 0:使用ip地址 1:使用设备号
	 */
	private String ipSwitch;

	// @Value("#{settings['wisdomcampus.ipSwitch']}")
	// public void setIpSwitch(String ipSwitch)
	// {
	// this.ipSwitch = ipSwitch;
	// }

	public TCPServer()
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
				log.error("启动TCPServer失败", e);
				e.printStackTrace();
			}
		}
	}

	public void run()
	{
		log.info("TCPServer启动");
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
		log.info("TCPServer结束");
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

	private boolean trun(byte[] b, String ip)
	{
		byte[] cardbytes = new byte[10];
		System.arraycopy(b, 0, cardbytes, 0, 10);

		String cardStr = StringUtil.toHex(cardbytes);

		String deviceCode = cardStr.substring(0, 10);
		String cardCode = cardStr.substring(10);

//		log.info("设备号 ： " + deviceCode);

		Long result = Long.parseLong(cardCode, 16);
		String code = result.toString();
		while(code.length() < 10)
		{
			code = "0" + code;
		}
//		log.info("卡号 ： " + code);

		int battery = b[10] - 48; // 电池状态，1正常，0电压偏低
		int status = b[11] - 48; // 状态，1进入，0外出

		log.info("get:" + StringUtil.toHex(b) + " [" + code + "][" + battery + "][" + status + "][" + ip + "]");

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
		//根据设备查找数据源
		DBContextHolder.setDBType(String.valueOf(schoolId));
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
			} catch (IOException e)
			{
				e.printStackTrace();
			}

			if (in != null)
			{
				final byte[] b = new byte[14]; // 和消息长相同
				int pos = 0;
				// boolean isOK = false;

				while (true)
				{
					if (socket.isClosed())
					{
						break;
					}

					try
					{
						b[pos] = (byte) in.read();

						if (b[0] == -1)
						{
							if(pos < 4 && b[pos]!=-1)
							{
								pos=0;
								continue;
							}
							if (pos == 9)
							{
								byte[] cardbytes = new byte[10];
								System.arraycopy(b, 0, cardbytes, 0, 10);

								String cardStr = StringUtil.toHex(cardbytes);
								String deviceCode = cardStr.substring(0, 10);
								final String cardCode = cardStr.substring(10);

								Long result = Long.parseLong(cardCode, 16);
								String code = result.toString();
								while(code.length() < 10)
								{
									code = "0" + code;
								}
								
								// 获得输出流
								OutputStream out = socket.getOutputStream();
								// 给客户一个响应
								String reply = "0001FFFF";
								byte[] bs = StringUtil.fromHex(reply);
								out.write(bs);
								out.flush();
								
								//根据设备查找数据源
								try
								{
									schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(deviceCode);
									if(null!=schoolId && 0l != schoolId){
										DBContextHolder.setDBType(String.valueOf(schoolId));
										
										if (StartupListener.inoutService.isValid(code))
										{
//											// 获得输出流
//											OutputStream out = socket.getOutputStream();
//		
//											// 给客户一个响应
//											String reply = "0001FFFF";
//											byte[] bs = StringUtil.fromHex(reply);
//											out.write(bs);
//											out.flush();
		
											new Thread(new Runnable()
											{
												public void run()
												{
													trun(b, ip);
												}
											}).start();
										}
										
									}
									
								}catch(Exception ex)
								{
									log.error("TCPServer 263行报错，错误信息如下："+ex);
								}

								pos = 0;
								try
								{
									sleep(1);
								} catch (InterruptedException e)
								{
									break;
								}

								continue;
							}

							pos++;	
							
						}

					} catch (IOException e)
					{
						break;
					}
				}
			}

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
