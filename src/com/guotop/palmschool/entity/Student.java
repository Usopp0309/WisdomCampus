package com.guotop.palmschool.entity;

import com.google.gson.annotations.Expose;

/**
 * 学生entity类
 * @author zhou
 *
 */
public class Student 
{
	/**
	 * 主键
	 */
	private Integer id;
	
	/**
	 * 姓名
	 */
	private String name;
	
	/**
	 * 学号
	 */
	private String code;

	/**
	 * 性别
	 */
	private String sex;
	
	/**
	 * 班级名
	 */
	private String clazzName;
	
	/**
	 * 年级名
	 */
	private String gradeName;
	
	/**
	 * 班主任
	 */
	private String headTeacherName;
	
	/**
	 * 联系人(家长)
	 */
	private String parentName;
	
	/**
	 * 联系电话
	 */
	private String phone;
	
	/**
	 * 头像
	 */
	private String stuPic;
	
	/**
	 * 学生id
	 */
	@Expose
	private Integer userId;
	
	/**
	 * 学生姓名
	 */
	@Expose
	private String realName;
	
	/**
	 * 学生头像
	 */
	@Expose
	private String headImg;
	/**
	 * 年级类型
	 */
    private Integer gradeType;
    
	public Integer getGradeType() {
		return gradeType;
	}

	public void setGradeType(Integer gradeType) {
		this.gradeType = gradeType;
	}

	public Integer getId() 
	{
		return id;
	}

	public void setId(Integer id) 
	{
		this.id = id;
	}

	public String getName() 
	{
		return name;
	}

	public void setName(String name) 
	{
		this.name = name;
	}

	public String getCode() 
	{
		return code;
	}

	public void setCode(String code) 
	{
		this.code = code;
	}
	
	public String getSex() 
	{
		return sex;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public String getClazzName() 
	{
		return clazzName;
	}

	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}

	public String getGradeName()
	{
		return gradeName;
	}

	public void setGradeName(String gradeName) 
	{
		this.gradeName = gradeName;
	}

	public String getHeadTeacherName() 
	{
		return headTeacherName;
	}

	public void setHeadTeacherName(String headTeacherName) 
	{
		this.headTeacherName = headTeacherName;
	}

	public String getParentName()
	{
		return parentName;
	}

	public void setParentName(String parentName) 
	{
		this.parentName = parentName;
	}

	public String getPhone() 
	{
		return phone;
	}

	public void setPhone(String phone) 
	{
		this.phone = phone;
	}

	public String getStuPic() 
	{
		return stuPic;
	}

	public void setStuPic(String stuPic) 
	{
		this.stuPic = stuPic;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getRealName()
	{
		return realName;
	}

	public void setRealName(String realName)
	{
		this.realName = realName;
	}

	public String getHeadImg()
	{
		return headImg;
	}

	public void setHeadImg(String headImg)
	{
		this.headImg = headImg;
	}
}
