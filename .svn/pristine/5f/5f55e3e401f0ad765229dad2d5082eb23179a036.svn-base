package com.guotop.palmschool.util;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import com.cloopen.rest.sdk.utils.DateUtil;
import com.cloopen.rest.sdk.utils.EncryptUtil;

/**
 * 云通讯 验证信息生成
 * 
 * @author Administrator
 *
 */
public class YuntxAuthGenerate
{
	/**
	 * 群组管理的时候 应用鉴权方式 返回的验证信息
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 */
	public static Map<String, String> appGengrate(String voipAccount) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		Map<String, String> map = new HashMap<String, String>();
		Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
		String APP_ID = pro.getProperty("APP_ID");
		String APP_TOKEN = pro.getProperty("APP_TOKEN");

		String timestamp = DateUtil.dateToStr(new Date(), DateUtil.DATE_TIME_NO_SLASH);
		EncryptUtil eu = new EncryptUtil();
		// 使用MD5加密（应用Id + 应用授权令牌 +时间戳）
		String sig = APP_ID + APP_TOKEN + timestamp;
		String SigParameter = eu.md5Digest(sig);
		// 使用Base64编码（应用Id + 冒号 + 时间戳）
		String src = APP_ID + ":" + timestamp;
		String auth = eu.base64Encoder(src);
		// URL中的subAccountSid由（应用Id+自定义帐号组成）
		String subAccountSid = APP_ID + voipAccount;
		map.put("SigParameter", SigParameter);
		map.put("Authorization", auth);
		map.put("subAccountSid", subAccountSid);
		return map;
	}
}
