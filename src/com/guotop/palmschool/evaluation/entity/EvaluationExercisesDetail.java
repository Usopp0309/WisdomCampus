package com.guotop.palmschool.evaluation.entity;

public class EvaluationExercisesDetail
{

	// 主键ID
	private Integer id;

	// 嫡属于题目的Id
	private Integer exId;

	// 字符长度
	private Integer length;

	// 该题分数 积分
	private Integer integral;

	// 答案或者参考答案
	private String text;

	// 答案类型
	private String type;

	// 正确答案
	private String answer;

	// 介绍和说明
	private String comment;

	// 更新时间
	private String updateTime;

	// 当前状态
	private Integer status;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getExId()
	{
		return exId;
	}

	public void setExId(Integer exId)
	{
		this.exId = exId;
	}

	public Integer getLength()
	{
		return length;
	}

	public void setLength(Integer length)
	{
		this.length = length;
	}

	public Integer getIntegral()
	{
		return integral;
	}

	public void setIntegral(Integer integral)
	{
		this.integral = integral;
	}

	public String getText()
	{
		return text;
	}

	public void setText(String text)
	{
		this.text = text;
	}

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public String getAnswer()
	{
		return answer;
	}

	public void setAnswer(String answer)
	{
		this.answer = answer;
	}

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	
}
