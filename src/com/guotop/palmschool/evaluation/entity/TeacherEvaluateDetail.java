package com.guotop.palmschool.evaluation.entity;

/**
 *
 *
 *@author: 王森
 *@time: 2013-7-6下午3:08:03
 */
public class TeacherEvaluateDetail{

	/**
	 * id
	 */
	private Integer id;
	/**
	 * 关联学生对老师评价信息表单表
	 */
	private Integer modelId;
	
	/**
	 * 关联学生对老师评价信息标题表
	 */
	private Integer titleId;
	
	/**
	 * 评价内容
	 */
	private String text;
	
	/**
	 * 给予老师评价等级
	 */
	private Integer level;
	
	/**
	 * 关联学生对老师评价信息表单表
	 */
	private Integer formId;
	
	
	private Integer userId;


	public Integer getId()
	{
		return id;
	}


	public void setId(Integer id)
	{
		this.id = id;
	}


	public Integer getModelId()
	{
		return modelId;
	}


	public void setModelId(Integer modelId)
	{
		this.modelId = modelId;
	}


	public Integer getTitleId()
	{
		return titleId;
	}


	public void setTitleId(Integer titleId)
	{
		this.titleId = titleId;
	}


	public String getText()
	{
		return text;
	}


	public void setText(String text)
	{
		this.text = text;
	}


	public Integer getLevel()
	{
		return level;
	}


	public void setLevel(Integer level)
	{
		this.level = level;
	}


	public Integer getFormId()
	{
		return formId;
	}


	public void setFormId(Integer formId)
	{
		this.formId = formId;
	}


	public Integer getUserId()
	{
		return userId;
	}


	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}
	
	
}
