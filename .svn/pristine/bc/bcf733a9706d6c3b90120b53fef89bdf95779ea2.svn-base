package com.guotop.palmschool.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cloopen.rest.sdk.CCPRestSDK;

public class SDKSubAccount
{

	private static Logger log = LoggerFactory.getLogger(SDKSubAccount.class);

	@SuppressWarnings("unchecked")
	public static String createSubAccount(String subAccountName)
	{
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		String ACCOUNT_SID = pro.getProperty("ACCOUNT_SID");
		String AUTH_TOKEN = pro.getProperty("AUTH_TOKEN");
		String APP_ID = pro.getProperty("APP_ID");
		
		HashMap<String, Object> result = null;

		CCPRestSDK restAPI = new CCPRestSDK();
		restAPI.init("app.cloopen.com", "8883");// 初始化服务器地址和端口，格式如下，服务器地址不需要写https://
		restAPI.setAccount(ACCOUNT_SID, AUTH_TOKEN);// 初始化主帐号和主帐号TOKEN
		restAPI.setAppId(APP_ID);// 初始化应用ID
		result = restAPI.createSubAccount(subAccountName);

		if ("000000".equals(result.get("statusCode")))
		{
			// 正常返回输出data包体信息（map）
			HashMap<String, Object> data = (HashMap<String, Object>) result.get("data");
			Set<String> keySet = data.keySet();
			for (String key : keySet)
			{
				ArrayList<HashMap<String, Object>> arrayList = (ArrayList<HashMap<String, Object>>) data.get(key);
				HashMap<String, Object> map = arrayList.get(0);
				String voipAccount = (String) map.get("voipAccount");
				return voipAccount;
			}
			return "";
		} else if ("111150".equals(result.get("statusCode")))
		{
			String voipAccount = querySubAccount(subAccountName);
			return voipAccount;
		} else
		{
			// 异常返回输出错误码和错误信息
			String errorMsg = "错误码=" + result.get("statusCode") + " 错误信息= " + result.get("statusMsg");
			log.error(errorMsg);
			return "";
		}
	}

	/**
	 * 返回voip账号
	 * @param subAccountName
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String querySubAccount(String subAccountName)
	{
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		String ACCOUNT_SID = pro.getProperty("ACCOUNT_SID");
		String AUTH_TOKEN = pro.getProperty("AUTH_TOKEN");
		String APP_ID = pro.getProperty("APP_ID");
		
		HashMap<String, Object> result = null;

		CCPRestSDK restAPI = new CCPRestSDK();
		restAPI.init("app.cloopen.com", "8883");// 初始化服务器地址和端口，格式如下，服务器地址不需要写https://
		restAPI.setAccount(ACCOUNT_SID, AUTH_TOKEN);// 初始化主帐号和主帐号TOKEN
		restAPI.setAppId(APP_ID);// 初始化应用ID
		result = restAPI.querySubAccount(subAccountName);

		if ("000000".equals(result.get("statusCode")))
		{
			// 正常返回输出data包体信息（map）
			HashMap<String, Object> data = (HashMap<String, Object>) result.get("data");
			Set<String> keySet = data.keySet();
			for (String key : keySet)
			{
				ArrayList<HashMap<String, Object>> arrayList = (ArrayList<HashMap<String, Object>>) data.get(key);
				HashMap<String, Object> map = arrayList.get(0);
				String voipAccount = (String) map.get("voipAccount");
				return voipAccount;
			}
			return "";
		} else
		{
			// 异常返回输出错误码和错误信息
			String errorMsg = "错误码=" + result.get("statusCode") + " 错误信息= " + result.get("statusMsg");
			log.error(errorMsg);
			return "";
		}
	}
}
