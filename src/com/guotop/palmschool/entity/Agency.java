package com.guotop.palmschool.entity;

import java.util.List;

/**
 * 代理商实体类
 * 
 * @author jfy
 * @date 2015年12月14日
 */
public class Agency
{
	// 主键ID
	private Integer id;
	// 用户ID
	private Integer userId;
	// 代理商名
	private String name;
	// 省
	private String province;
	// 市
	private String city;
	// 区县
	private String country;
	// 地址
	private String address;
	// 法人
	private String corporation;
	// 联系电话
	private String phone;
	// 描述
	private String description;
	// 创建时间
	private String createTime;
	// 学校ID
	private long schoolId;
	// 学校名称
	private String schoolName;
	// 学校地址
	private String schoolAddress;
	//邮箱
	private String email;
	//代理类型
	private String agentType;
	//学校列表
	private List<School> schoolList;
	//联系人名称
	private String realName;

	// 代理商名称
	private String agencyName;

	// 技术支持人员id
	private String supportUserId;

	// 技术支持人员id列表
	private List<User> supportUserList;
	//状态 0启用 1禁用
	private int state;
	
	//登录账号
	private String username;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getProvince()
	{
		return province;
	}

	public void setProvince(String province)
	{
		this.province = province;
	}

	public String getCity()
	{
		return city;
	}

	public void setCity(String city)
	{
		this.city = city;
	}

	public String getCountry()
	{
		return country;
	}

	public void setCountry(String country)
	{
		this.country = country;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getCorporation()
	{
		return corporation;
	}

	public void setCorporation(String corporation)
	{
		this.corporation = corporation;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public long getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(long schoolId)
	{
		this.schoolId = schoolId;
	}

	public String getSchoolName()
	{
		return schoolName;
	}

	public void setSchoolName(String schoolName)
	{
		this.schoolName = schoolName;
	}

	public String getSchoolAddress()
	{
		return schoolAddress;
	}

	public void setSchoolAddress(String schoolAddress)
	{
		this.schoolAddress = schoolAddress;
	}
	public String getEmail()
	{
		return email;
	}
	public void setEmail(String email)
	{
		this.email = email;
	}
	public String getAgentType()
	{
		return agentType;
	}
	public void setAgentType(String agentType)
	{
		this.agentType = agentType;
	}
	public List<School> getSchoolList()
	{
		return schoolList;
	}
	public void setSchoolList(List<School> schoolList)
	{
		this.schoolList = schoolList;
	}
	public String getRealName()
	{
		return realName;
	}
	public void setRealName(String realName)
	{
		this.realName = realName;
	}

	public String getAgencyName()
	{
		return agencyName;
	}

	public void setAgencyName(String agencyName)
	{
		this.agencyName = agencyName;
	}

	public String getSupportUserId()
	{
		return supportUserId;
	}

	public void setSupportUserId(String supportUserId)
	{
		this.supportUserId = supportUserId;
	}

	public List<User> getSupportUserList()
	{
		return supportUserList;
	}

	public void setSupportUserList(List<User> supportUserList)
	{
		this.supportUserList = supportUserList;
	}

	public int getState()
	{
		return state;
	}

	public void setState(int state)
	{
		this.state = state;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}
	
}
