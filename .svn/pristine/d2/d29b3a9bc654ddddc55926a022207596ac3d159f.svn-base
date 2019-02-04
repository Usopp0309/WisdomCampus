package com.guotop.palmschool.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Properties;

/**
 * 配置文件操作工具类
 * @author zhou
 *
 */
public class PropertiesUtil 
{
	private static PropertiesUtil instance = null;
	
	private PropertiesUtil()
	{
		
	}
	
	public static PropertiesUtil getInstance()
	{
		if (null == instance)
		{
			return new PropertiesUtil();
		}
		return instance;
	}
	
	
	/**
	 * 读取配置文件API
	 * @return
	 */
	public Properties read(String fileName)
	{
		Properties prop = new Properties();
		try
		{
			//class路径
			String path = Thread.currentThread().getContextClassLoader().getResource("").getPath().replaceAll("%20", " ");
			FileInputStream input = new FileInputStream(path+File.separatorChar+fileName);
			InputStreamReader reader = new InputStreamReader(input,"UTF-8");
			BufferedReader br = new BufferedReader(reader);
			prop.load(br);
			input.close();
			reader.close();
			br.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return prop;
	}
	
	/**
	 * 获取学校限制短信条数
	 * @param pro
	 * @param schoolId
	 * @return
	 */
	public int getSmsWordLimit(Properties pro,String schoolId){
		int wordLimit = 190;
		
		if(StringUtil.isEmpty(schoolId)){
			return wordLimit;
		}
		String smsSchoolId = pro.getProperty("smsSchoolId");
		String smsWordLimit = pro.getProperty("smsWordLimit");
		if(StringUtil.isEmpty(smsSchoolId)){
			return wordLimit;
		}
		String[] schoolIdArray = smsSchoolId.split(",");
		String[] wordLimitArray = smsWordLimit.split(",");
		for(int i = 0;i<schoolIdArray.length;i++){
			if(schoolIdArray[i].equals(schoolId)){
				return Integer.valueOf(wordLimitArray[i]);
			}
		}
		return wordLimit;
	}
	
	/**
	 * 获取学校补卡单张卡金额
	 * @param pro
	 * @param schoolId
	 * @return
	 */
	public Double getCardApplyBalance(Properties pro,String schoolId){
		Double balance = 50.0;
		
		if(StringUtil.isEmpty(schoolId)){
			return balance;
		}
		String cardApplySchoolId = pro.getProperty("cardApplySchoolId");
		String cardApplyBalance = pro.getProperty("cardApplyBalance");
		if(StringUtil.isEmpty(cardApplySchoolId)){
			return balance;
		}
		String[] schoolIdArray = cardApplySchoolId.split(",");
		String[] balanceArray = cardApplyBalance.split(",");
		for(int i = 0;i<schoolIdArray.length;i++){
			if(schoolIdArray[i].equals(schoolId)){
				return Double.valueOf(balanceArray[i]);
			}
		}
		return balance;
	}
}
