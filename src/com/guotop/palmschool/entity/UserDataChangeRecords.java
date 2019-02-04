package com.guotop.palmschool.entity;

import java.util.Date;

/**
 * 
 * 用户操作日志表
 * 
 * @author: 王威
 * @time: 2016-07-22 11:07:40
 */
public class UserDataChangeRecords
{

	private Integer id;			//ID
	private Integer objectId;	//操作对象Id
	private String oprateType;	//操作类型：0 add、1 update、2 delete
	private Date ctime;			//此条记录生成时间
	private String status;		//同步状态：0 未同步，1 已同步
	private int failCount;		//同步失败次数
	private String syncTarget;	//同步对象：1学生,2老师,3年级,4班级
	private Date syncTime;		//同步时间

	public UserDataChangeRecords() {
	}

	public UserDataChangeRecords(Integer id) {
		this.id = id;
	}
	
	public UserDataChangeRecords (int objectId,String operateType,String syncTarget)
	{
		this.objectId = objectId;
		this.oprateType = operateType;
		this.syncTarget = syncTarget;
		this.status = "0";
		this.failCount = 0;
		this.ctime = new Date();
	}
	
	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getObjectId()
	{
		return objectId;
	}

	public void setObjectId(Integer objectId)
	{
		this.objectId = objectId;
	}

	public int getFailCount()
	{
		return failCount;
	}

	public void setFailCount(int failCount)
	{
		this.failCount = failCount;
	}

	public String getSyncTarget()
	{
		return syncTarget;
	}

	public void setSyncTarget(String syncTarget)
	{
		this.syncTarget = syncTarget;
	}

	public Date getCtime()
	{
		return ctime;
	}

	public void setCtime(Date ctime)
	{
		this.ctime = ctime;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public String getOprateType()
	{
		return oprateType;
	}

	public void setOprateType(String oprateType)
	{
		this.oprateType = oprateType;
	}

	public Date getSyncTime()
	{
		return syncTime;
	}

	public void setSyncTime(Date syncTime)
	{
		this.syncTime = syncTime;
	}

}
