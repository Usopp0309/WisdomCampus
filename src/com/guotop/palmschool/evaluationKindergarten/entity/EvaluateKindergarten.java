package com.guotop.palmschool.evaluationKindergarten.entity;

import java.io.Serializable;

public class EvaluateKindergarten implements Serializable
{
	private static final long serialVersionUID = 1L;

	private int id;
	private int teacherId;
	private int studentId;
	private String createTime;
	private String conductStar;
	private String conduct;
	private String sportStar;
	private String sport;
	private String studyStar;
	private String study;
	private String lifeStar;
	private String life;
	private String clazzId;

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public int getTeacherId()
	{
		return teacherId;
	}

	public void setTeacherId(int teacherId)
	{
		this.teacherId = teacherId;
	}

	public int getStudentId()
	{
		return studentId;
	}

	public void setStudentId(int studentId)
	{
		this.studentId = studentId;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getConductStar()
	{
		return conductStar;
	}

	public void setConductStar(String conductStar)
	{
		this.conductStar = conductStar;
	}

	public String getConduct()
	{
		return conduct;
	}

	public void setConduct(String conduct)
	{
		this.conduct = conduct;
	}

	public String getSportStar()
	{
		return sportStar;
	}

	public void setSportStar(String sportStar)
	{
		this.sportStar = sportStar;
	}

	public String getSport()
	{
		return sport;
	}

	public void setSport(String sport)
	{
		this.sport = sport;
	}

	public String getStudyStar()
	{
		return studyStar;
	}

	public void setStudyStar(String studyStar)
	{
		this.studyStar = studyStar;
	}

	public String getStudy()
	{
		return study;
	}

	public void setStudy(String study)
	{
		this.study = study;
	}

	public String getLifeStar()
	{
		return lifeStar;
	}

	public void setLifeStar(String lifeStar)
	{
		this.lifeStar = lifeStar;
	}

	public String getLife()
	{
		return life;
	}

	public void setLife(String life)
	{
		this.life = life;
	}

	public String getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(String clazzId)
	{
		this.clazzId = clazzId;
	}
	
}
