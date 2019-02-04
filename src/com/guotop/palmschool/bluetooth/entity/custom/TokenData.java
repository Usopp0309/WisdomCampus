package com.guotop.palmschool.bluetooth.entity.custom;

/**
 * 自定义获取token数据的实体类
 * 
 * @author Administrator
 *
 */
public class TokenData
{
	private String token_type="";
	private String access_token="";
	private String expires_in="";

	public String getToken_type()
	{
		return token_type;
	}

	public void setToken_type(String token_type)
	{
		this.token_type = token_type;
	}

	public String getAccess_token()
	{
		return access_token;
	}

	public void setAccess_token(String access_token)
	{
		this.access_token = access_token;
	}

	public String getExpires_in()
	{
		return expires_in;
	}

	public void setExpires_in(String expires_in)
	{
		this.expires_in = expires_in;
	}

}
