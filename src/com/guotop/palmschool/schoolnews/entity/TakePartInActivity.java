package com.guotop.palmschool.schoolnews.entity;

/**
 * 参加校园活动信息实体类
 * @author Administrator
 *
 */
public class TakePartInActivity
{

	private int id;
	
	/**
	 * 学校Id
	 */
	private String schoolId;
	
	/**
	 * 学生姓名
	 */
	private String name;
	
	/**
	 * 性别 0男 1女
	 */
	private Integer sex;
	
	/**
	 *入学年份
	 */
	private String schoolYear;
	
	/**
	 * 联系人
	 */
	private String linkMan;
	
	/**
	 * 联系电话
	 */
	private String linkPhone;

	/**
	 * 参加儿童人数
	 */
	private Integer childNum;
	
	/**
	 * 参加大人人数
	 */
	private Integer adultNum;


	private String createTime;

	/**
	 * 活动id
	 */
	private Integer newsId;

	/**
	 * 活动名称
	 */
	private String newsTitle;

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public Integer getSex()
	{
		return sex;
	}

	public void setSex(Integer sex)
	{
		this.sex = sex;
	}

	public String getSchoolYear()
	{
		return schoolYear;
	}

	public void setSchoolYear(String schoolYear)
	{
		this.schoolYear = schoolYear;
	}

	public String getLinkMan()
	{
		return linkMan;
	}

	public void setLinkMan(String linkMan)
	{
		this.linkMan = linkMan;
	}

	public String getLinkPhone()
	{
		return linkPhone;
	}

	public void setLinkPhone(String linkPhone)
	{
		this.linkPhone = linkPhone;
	}

	public Integer getChildNum()
	{
		return childNum;
	}

	public void setChildNum(Integer childNum)
	{
		this.childNum = childNum;
	}

	public Integer getAdultNum()
	{
		return adultNum;
	}

	public void setAdultNum(Integer adultNum)
	{
		this.adultNum = adultNum;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public Integer getNewsId()
	{
		return newsId;
	}

	public void setNewsId(Integer newsId)
	{
		this.newsId = newsId;
	}

	public String getNewsTitle()
	{
		return newsTitle;
	}

	public void setNewsTitle(String newsTitle)
	{
		this.newsTitle = newsTitle;
	}

	

}
