package com.guotop.palmschool.evaluation.entity;

public class TeacherEvaluatePhraseModel{
	/**
	 * id
	 */
	private Integer id;
	/**
	 * 关联学生对老师评价信息表单表
	 */
	private Integer formId;
	/**
	 * 关联学生对老师评价信息标题表
	 */
	private Integer titleId;
	/**
	 * 对老师评价的常用短语
	 */
	private String text;
	
	private Integer modelId;
	
	private Integer userId;
	
	private String realName; 

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getFormId()
	{
		return formId;
	}

	public void setFormId(Integer formId)
	{
		this.formId = formId;
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

	public Integer getModelId()
	{
		return modelId;
	}

	public void setModelId(Integer modelId)
	{
		this.modelId = modelId;
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
	
	
	
}
