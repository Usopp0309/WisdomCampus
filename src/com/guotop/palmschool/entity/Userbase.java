package com.guotop.palmschool.entity;

import java.io.Serializable;
import java.util.List;

public class Userbase implements Serializable
{
	private static final long serialVersionUID = 1L;
	private int userId;

	private String apiKey;

	private int count;

	private String palmUserName;

	private String passWord;

	private String phone;

	private String source;

	private String state;

	private String type;
	private String userName;
	private String uuserId;
	
	private Integer deviceType;
	
	private String device;
	
	private List<Userbase> friends;
	
	private String baiduChannelId;

	public int getUserId()
	{
		return userId;
	}

	public void setUserId(int userId)
	{
		this.userId = userId;
	}

	public String getApiKey()
	{
		return apiKey;
	}

	public void setApiKey(String apiKey)
	{
		this.apiKey = apiKey;
	}

	public int getCount()
	{
		return count;
	}

	public void setCount(int count)
	{
		this.count = count;
	}

	public String getPalmUserName()
	{
		return palmUserName;
	}

	public void setPalmUserName(String palmUserName)
	{
		this.palmUserName = palmUserName;
	}

	public String getPassWord()
	{
		return passWord;
	}

	public void setPassWord(String passWord)
	{
		this.passWord = passWord;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getSource()
	{
		return source;
	}

	public void setSource(String source)
	{
		this.source = source;
	}

	public String getState()
	{
		return state;
	}

	public void setState(String state)
	{
		this.state = state;
	}

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	public String getUuserId()
	{
		return uuserId;
	}

	public void setUuserId(String uuserId)
	{
		this.uuserId = uuserId;
	}

	public Integer getDeviceType()
	{
		return deviceType;
	}

	public void setDeviceType(Integer deviceType)
	{
		this.deviceType = deviceType;
	}

	public String getDevice()
	{
		return device;
	}

	public void setDevice(String device)
	{
		this.device = device;
	}

	public List<Userbase> getFriends()
	{
		return friends;
	}

	public void setFriends(List<Userbase> friends)
	{
		this.friends = friends;
	}

	public String getBaiduChannelId()
	{
		return baiduChannelId;
	}

	public void setBaiduChannelId(String baiduChannelId)
	{
		this.baiduChannelId = baiduChannelId;
	} 
	
	
}
