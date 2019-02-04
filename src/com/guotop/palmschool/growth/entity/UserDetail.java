package com.guotop.palmschool.growth.entity;

public class UserDetail
{
	private int id;
	//用户ID
	private Integer userId;
	//昵称
	private String nickName;
	//生肖
	private String zoodiac;
	//血型
	private String bloodType;
	//英文名
	private String englishName;
	//爱好
	private String favorite;
	//创建时间
	private String createTime;
	//性别
	private Integer sex;
	//生日
	private String birthday;
	//成长档案ID
	private Integer growthId;
	//图片访问路径
	private String imgPath;

	
	public int getUserId()
	{
		return userId;
	}
	public void setUserId(int userId)
	{
		this.userId = userId;
	}
	public String getNickName()
	{
		return nickName;
	}
	public void setNickName(String nickName)
	{
		this.nickName = nickName;
	}
	public String getZoodiac()
	{
		return zoodiac;
	}
	public void setZoodiac(String zoodiac)
	{
		this.zoodiac = zoodiac;
	}
	public String getBloodType()
	{
		return bloodType;
	}
	public void setBloodType(String bloodType)
	{
		this.bloodType = bloodType;
	}
	public String getEnglishName()
	{
		return englishName;
	}
	public void setEnglishName(String englishName)
	{
		this.englishName = englishName;
	}
	public String getFavorite()
	{
		return favorite;
	}
	public void setFavorite(String favorite)
	{
		this.favorite = favorite;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public Integer getSex()
	{
		return sex;
	}
	public void setSex(Integer sex)
	{
		this.sex = sex;
	}
	public String getBirthday()
	{
		return birthday;
	}
	public void setBirthday(String birthday)
	{
		this.birthday = birthday;
	}
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public Integer getGrowthId()
	{
		return growthId;
	}
	public void setGrowthId(Integer growthId)
	{
		this.growthId = growthId;
	}
	public String getImgPath()
	{
		return imgPath;
	}
	public void setImgPath(String imgPath)
	{
		this.imgPath = imgPath;
	}
	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}
	
}
