package com.guotop.palmschool.thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
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

/**
 * TCP接收端
 * 
 * 设备【校车一体机】
 * 接收读卡器发送过来的数据
 * 【泗洪第一实验学校】
 */
public class RVRXTCPServer extends Thread
{

	private static final Log log = LogFactory.getLog(RVRXTCPServer.class);

	private static ServerSocket server = null;

	protected final static int PORT = 8357;

	private static boolean signal = true;

	private static List<SocketHandle> sockets = new ArrayList<SocketHandle>();
	
//	private String schoolId ="3201140009";
	
	/**
	 * 注入配置项 0:使用ip地址 1:使用设备号
	 */
	private String ipSwitch;

	public RVRXTCPServer()
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
				log.error("启动RVRXTCPServer失败", e);
				e.printStackTrace();
			}
		}
	}

	public void run()
	{
		log.info("RVRXTCPServer启动");
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
		log.info("RVRXTCPServer结束");
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

	private boolean trun(String status,String cardCode, String ip)
	{
//		log.info("状态 ： " + status);

		//Long result = Long.parseLong(cardCode, 16);
		String code = cardCode;
//		log.info("卡号 ： " + code);


		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		// ipSwitch 0 IP 1 deviceCode 设备号
		ipSwitch = pro.getProperty("ipSwitch");

		Inout inout = new Inout();
		inout.setCode(code);
		if(status.equals("10"))
		{
			inout.setStatus(2);
		}else
		{
			inout.setStatus(1);
		}
		
		String position = "";

		if (CheckCons.IPSWITCH_DEVICECODE.equals(ipSwitch))
		{
			// 记录设备号
			position = "RVRX001";
		} else
		{
			// 记录ip
			position = ip;
		}
		//根据设备查找数据源（切换到泗洪第一实验学校）
		DBContextHolder.setDBType("3213240089");
		return StartupListener.inoutService.addNewInout(inout, ipSwitch, position,true);
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
			log.info("Socket[" + this.getName() + "]开始：" + ip);

			try
			{
				in = socket.getInputStream();
			} catch (IOException e)
			{
				e.printStackTrace();
			}

			if (in != null)
			{
				byte[] b = new byte[30]; // 和消息长相同
				int pos = 0;
				boolean isOK = false;
				boolean isPosition = false;
				boolean isStudentOK = false;
				boolean isLogin = false;
				while (true){
				try {
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
						if (pos == 0 && b[0] == 76) {
							// 读卡器在启动时，会先发有LOGIN:XXXX! 过滤10个字节
							isLogin = true;
							pos++;
							continue;
						}
						if (pos==0&&b[0] == 82) {//R开头设备号
							isOK = true;
							pos++;
							continue;
						}
						
						if(pos==11&&b[pos]==76&&isPosition){
							isPosition = false;
							pos++;
							continue;
						}
						//过滤登陆开头
						if(pos==9&&isLogin&&b[9]==49){
							isLogin = false;
							pos=0;
							continue;
						}
						//R开头心跳包记录设备号
						if (pos==10&&isOK&&b[10] == 33) {
							byte[] result = new byte[10];
							System.arraycopy(b, 0, result, 0, 10);
							String resultStr = new String(result);
							isOK = false;
			                pos=0;
			                continue;
						}
						//学生打卡
						if (b[pos] == 13 && !isOK){
							byte[] result = new byte[22];
							System.arraycopy(b, 0, result, 0, 22);
							String resultStr = new String(result);
							String code = resultStr.substring(0,10);
							String status = resultStr.substring(10,12);
							DBContextHolder.setDBType("3213240089");
							OutputStream out = this.socket.getOutputStream();
							PrintWriter pw=new PrintWriter(out); 
			                String reply = "A";
			                pw.write(reply);
			                pw.flush();
			                trun(status,code, ip);
			                pos = 0;
			                isStudentOK=false;
			                continue;
						}
						
						pos++;
					} catch (IOException e) {
						break;
					}
				}
			}
			log.info("Socket[" + this.getName() + "]结束：" + ip);
			
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
