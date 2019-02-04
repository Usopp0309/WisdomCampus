package com.guotop.palmschool.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * 【深圳壹通道】短信发送
 * 短信接口工具类
 * 
 * @author sheng
 * 
 */
public class SmsUtil
{
	private static SmsUtil instance = null;

	private SmsUtil()
	{

	}

	public static SmsUtil getInstance()
	{
		if (null == instance)
		{
			instance = new SmsUtil();
		}
		return instance;
	}

	/**
	 * 【欣易辰信息科技】发送短信(调用短信接口) http接口
	 * 
	 * @param phone
	 *            发送至手机号
	 * @param startTime
	 *            发送时间
	 * @param sendContent
	 *            发送内容
	 * @return result 返回值状态码 例如：<Result>0
	 */
	public String sendSmsSYC(String phone, String startTime, String sendContent)
	{
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");

		//接口地址
		String postUrl = pro.getProperty("postUrl");
		//接口用户ID
		String enterpriseId = pro.getProperty("enterpriseId");
		//接口用户账号
		String userName = pro.getProperty("userName");
		//接口用户密码
		String userPassword = pro.getProperty("userPassword");
		userPassword = StringUtil.encodePassword(userPassword, "MD5");

		/**
		 * 从配置文件中读取短信接口相关---end
		 */
		try
		{
			String postData = "enterpriseID=" + enterpriseId + "&loginName=" + userName + "&password=" + userPassword + "&mobiles=" + phone + "&sendTime=" + startTime + "&content="
					+ URLEncoder.encode(sendContent + "【智慧校园】", "utf-8");

			// 发送Post请求
			URL url = new URL(postUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setUseCaches(false);
			conn.setDoOutput(true);

			conn.setRequestProperty("Content-Length", "" + postData.length());
			OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
			out.write(postData);
			out.flush();
			out.close();

			// 获取相应状态
			if (conn.getResponseCode() != HttpURLConnection.HTTP_OK)
			{
				System.out.println("connect failed!");
				return "";
			}
			// 获取响应内容体
			String line, result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			while ((line = in.readLine()) != null)
			{
				result += line;
			}
			in.close();
			String elementContent = parseXml(result, "Result");
			return elementContent;
		} catch (Exception e)
		{
			// TODO: handle exception
			e.printStackTrace(System.out);
		}
		return "";
	}
	
	/**
	 * 【深圳壹通道】发送短信(调用短信接口) http接口
	 * @param phone 发送至手机号
	 * @param startTime  发送时间
	 * @param sendContent 发送内容
	 * @param type 0：移动   1：联通电信
	 * @return
	 */
	public Map<String, String> sendSmsFromYTD(String phone, String startTime, String sendContent,String type)
	{
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");

		//接口地址
		String postUrl = pro.getProperty("postUrl");
		//操作
		String action = pro.getProperty("action");
		//接口用户ID
		String userid_mobile = pro.getProperty("userid_mobile");
		String userid_Uni_telecom = pro.getProperty("userid_Uni_telecom");
		//接口用户账号
		String account_mobile = pro.getProperty("account_mobile");
		String account_Uni_telecom = pro.getProperty("account_Uni_telecom");
		String userid = "0";
		String account = "";
		if("0".equals(type)){
			userid = userid_mobile;
			account = account_mobile;
		}else{
			userid = userid_Uni_telecom;
			account = account_Uni_telecom;
		}
		
		//接口用户密码
		String password = pro.getProperty("password");

		/**
		 * 从配置文件中读取短信接口相关---end
		 */
		Map<String, String> resultMap= new HashMap<String, String>(); 
		try
		{
			String postData = "action="+action+"&userid=" + userid + "&account=" + account + "&password=" + password + "&mobile=" + phone + "&sendTime=" + startTime + "&content="
					+ URLEncoder.encode(sendContent + "【智慧校园】", "utf-8");

			// 发送Post请求
			URL url = new URL(postUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setUseCaches(false);
			conn.setDoOutput(true);

			conn.setRequestProperty("Content-Length", "" + postData.length());
			OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
			out.write(postData);
			out.flush();
			out.close();

			// 获取相应状态
			if (conn.getResponseCode() != HttpURLConnection.HTTP_OK)
			{
				System.out.println("connect failed!");
				return resultMap;
			}
			// 获取响应内容体
			String line, result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			while ((line = in.readLine()) != null)
			{
				result += line;
			}
			in.close();
			String message = parseXml(result, "message");
			String remainpoint = parseXml(result, "remainpoint");
			
			resultMap.put("message", message);
			resultMap.put("remainpoint", remainpoint);
			return resultMap;
		} catch (Exception e)
		{
			e.printStackTrace(System.out);
		}
		return resultMap;
	}

	/**
	 * dom4j解析xml字符串
	 * 
	 * @param xml
	 *            xml字符串
	 * @param element
	 *            节点元素
	 * @return
	 */
	public String parseXml(String xml, String element)
	{
		try
		{
			Document doc = DocumentHelper.parseText(xml);

			Element root = doc.getRootElement();

			Element eName = root.element(element);
			// 获取元素对应的值
			String elementContent = eName.getTextTrim();
			return elementContent;
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "";
	}
	
	public static void main(String[] args) 
	{
		 String sendContent = "我是正校长";
		 Map<String, String> resultMap = SmsUtil.getInstance().sendSmsFromYTD("18551972758", null, sendContent,"1");
		 System.out.println(resultMap.get("message"));
		 System.out.println(resultMap.get("remainpoint"));
//		 String fStr = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><returnsms><message>ok</message><remainpoint>15987</remainpoint><returnstatus>Success</returnstatus><successCounts>1</successCounts><taskID>515469</taskID></returnsms>";
//		 System.out.println(SmsUtil.getInstance().parseXml(fStr, "message"));
//		 System.out.println(SmsUtil.getInstance().parseXml(fStr, "remainpoint"));
		
		
	}
	
//	public static void main(String[] args) throws ParseException
//	{
//		System.out.println(StringUtil.toMD5("RichX2016"));
//		System.out.println(StringUtil.encodePassword("RichX2016", "MD5"));
//	}
}
