package com.guotop.palmschool.util;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PhoneAuthenticator {

	/**
	 * 验证手机号码
	 * @param phone
	 * @return  true：格式正确   false：格式错误
 	 * 
	 */
	/*
	 *联通网段  "130","131","132","145","154","155","156","176","185","186","1707","1708","1709"
	   移动网段 "134","135","136","137","138","139","144","147","150","151","152","157","158","159","178","182","183","184","187","188","1705"
	  电信网段 "133","153","173","177","180","181","189","1700","1701","1702" ,"171"
	 * @param phone
	 * @return
	 */
	public static boolean isMobileNO(String phone){
		Pattern p1 = Pattern.compile("^((13[0-9])|(14[4-5,7])|(15[0-9])|(17[1,3,6-8])|(18[0-9]))\\d{8}$");
		Pattern p2 = Pattern.compile("^(170[0-2,5,7-9])\\d{7}$");
		Matcher m1 = p1.matcher(phone);
		Matcher m2 = p2.matcher(phone);
		if(m1.matches() || m2.matches()){
			return true;
		}else{
			return false;
		}
	}
	public static void main(String[] args) throws IOException {
		System.out.println(PhoneAuthenticator.isMobileNO("18005933303"));
	}
}
