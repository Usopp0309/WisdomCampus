package com.guotop.palmschool.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * 服务器邮箱登录验证 
 * @author jfy
 * @date 2015年11月25日
 */
public class MailAuthenticator extends Authenticator
{

	/**
	 * 
	 * 
	 * 用户名（登录邮箱）
	 */

	private String username;

	/**
	 * 
	 * 
	 * 密码
	 */

	private String password;

	/**
	 * 
	 * 
	 * 初始化邮箱和密码
	 * 
	 * 
	 * 
	 * 
	 * 
	 * @param username
	 *            邮箱
	 * 
	 * 
	 * @param password
	 *            密码
	 */

	public MailAuthenticator(String username, String password)
	{

		this.username = username;

		this.password = password;

	}

	String getPassword()
	{

		return password;

	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication()
	{

		return new PasswordAuthentication(username, password);

	}

	public String getUsername()
	{

		return username;

	}

	public void setPassword(String password)
	{

		this.password = password;

	}

	public void setUsername(String username)
	{

		this.username = username;

	}

    /**
     * 验证邮箱
     * @param email
     * @return
     */
    public static boolean checkEmail(String email){
        boolean flag = false;
        try{
                String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
                Pattern regex = Pattern.compile(check);
                Matcher matcher = regex.matcher(email);
                flag = matcher.matches();
            }catch(Exception e){
                flag = false;
            }
        return flag;
    }
    
}
