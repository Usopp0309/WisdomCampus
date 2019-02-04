package com.guotop.palmschool.curriculum.entity;

/**
 * 教室实体类
 */
public class Classroom
{

	/**
	 * id
	 */
	private Integer id;
	
	/**
	 * 教室编码
	 */
	private String code;
	
	/**
	 * 教室名称
	 */
	private String name;

	public Integer getId()
	{
		return id;
	}

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	
}
