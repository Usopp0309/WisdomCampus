package com.guotop.palmschool.growth.entity;

public class GrowthContent
{
	//ID
	private int id;
	//成长档案ID
	private Integer growthId;
	//第一张图路径
	private String firstImgPath;
	//第二张图路径
	private  String secondImgPath;
	//第三张图路径
	private String thirdImgPath;
	//创建时间
	private String createTime;
	//创建者ID
	private Integer createrId;
	//类型 0 开心的一天 1 我的作品 2 亲子活动 3 我的幼儿园 4 教学活动 5 童言 6 父母寄语
	private Integer type;
	//内容
	private String content;
	//更新时间
	private String updateTime;
	
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
	public String getFirstImgPath()
	{
		return firstImgPath;
	}
	public void setFirstImgPath(String firstImgPath)
	{
		this.firstImgPath = firstImgPath;
	}
	public String getSecondImgPath()
	{
		return secondImgPath;
	}
	public void setSecondImgPath(String secondImgPath)
	{
		this.secondImgPath = secondImgPath;
	}
	public String getThirdImgPath()
	{
		return thirdImgPath;
	}
	public void setThirdImgPath(String thirdImgPath)
	{
		this.thirdImgPath = thirdImgPath;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public Integer getCreaterId()
	{
		return createrId;
	}
	public void setCreaterId(Integer createrId)
	{
		this.createrId = createrId;
	}
	public Integer getType()
	{
		return type;
	}
	public void setType(Integer type)
	{
		this.type = type;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getUpdateTime()
	{
		return updateTime;
	}
	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
	}
	
	
}
