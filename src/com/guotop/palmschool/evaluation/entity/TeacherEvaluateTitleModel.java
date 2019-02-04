package com.guotop.palmschool.evaluation.entity;

import java.util.HashSet;
import java.util.Set;

/**
 *
 *
 *@author: 王森
 *@time: 2013-7-6下午3:11:54
 */
public class TeacherEvaluateTitleModel{

	/**
	 * id
	 */
	private Integer id;
	
	/**
	 * 关联学生对老师评价信息表单表
	 */
	private Integer formId;
	
	private Integer modelId;
	
	/**
	 * 评价标题
	 */
	private String title;
	/**
	 * 内容分类
	 */
	private String formType;
	/**
	 * 内容分类
	 */
	private String contextType;
	
	/**
	 * 题目分类
	 */
	private Integer titleType;
	
	/**
	 * 关联学生对老师评价详细信息表
	 */
	@SuppressWarnings("rawtypes")
	private Set detail=new HashSet();
	
	
	/**
	 * 关联学生对老师评价短语表
	 */
	@SuppressWarnings("rawtypes")
	private Set phrase=new HashSet();


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


	public Integer getModelId()
	{
		return modelId;
	}


	public void setModelId(Integer modelId)
	{
		this.modelId = modelId;
	}


	public String getTitle()
	{
		return title;
	}


	public void setTitle(String title)
	{
		this.title = title;
	}


	public String getFormType()
	{
		return formType;
	}


	public void setFormType(String formType)
	{
		this.formType = formType;
	}


	public String getContextType()
	{
		return contextType;
	}


	public void setContextType(String contextType)
	{
		this.contextType = contextType;
	}


	public Integer getTitleType()
	{
		return titleType;
	}


	public void setTitleType(Integer titleType)
	{
		this.titleType = titleType;
	}


	@SuppressWarnings("rawtypes")
	public Set getDetail()
	{
		return detail;
	}


	@SuppressWarnings("rawtypes")
	public void setDetail(Set detail)
	{
		this.detail = detail;
	}


	@SuppressWarnings("rawtypes")
	public Set getPhrase()
	{
		return phrase;
	}


	@SuppressWarnings("rawtypes")
	public void setPhrase(Set phrase)
	{
		this.phrase = phrase;
	}
	
	
}
