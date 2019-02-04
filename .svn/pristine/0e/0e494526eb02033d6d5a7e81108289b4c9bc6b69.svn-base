package com.guotop.palmschool.entity;



/**
 * 
 * 用户操作日志详情表
 * 
 * @author: 王威
 * @time: 2016-07-22 11:06:42
 */
public class UserDataChangeRecordsDetail
{

	private Integer id;					//变动记录详细表id
	private Integer targetId;			//用户操作记录表id
	private String operationClass;		//操作表表名
	private String propertyName;		//操作表属性名
	private String propertyValue;		//操作表属性值
	private String operationType;		//操作表操作类型0add 1update 2delete
	private String objectId;			//变动记录表中的objectId

	public UserDataChangeRecordsDetail(){
		
	}
	/**
	 * 初始化UserDataChangeRecordsDetail
	 * @param operationClass
	 * @param operationType
	 * @param key
	 * @param value
	 * @param targetId
	 * @return
	 */
	public UserDataChangeRecordsDetail(String operationClass,String operationType,String key,String value,int targetId)
	{
		this.operationClass = operationClass;
		this.operationType = operationType;
		this.propertyName = key;
		this.propertyValue = value;
		this.targetId = targetId;
	}
	
	public String getObjectId()
	{
		return objectId;
	}

	public void setObjectId(String objectId)
	{
		this.objectId = objectId;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getTargetId()
	{
		return targetId;
	}

	public void setTargetId(Integer targetId)
	{
		this.targetId = targetId;
	}

	public String getOperationClass()
	{
		return operationClass;
	}

	public void setOperationClass(String operationClass)
	{
		this.operationClass = operationClass;
	}

	public String getPropertyName()
	{
		return propertyName;
	}

	public void setPropertyName(String propertyName)
	{
		this.propertyName = propertyName;
	}

	public String getPropertyValue()
	{
		return propertyValue;
	}

	public void setPropertyValue(String propertyValue)
	{
		this.propertyValue = propertyValue;
	}

	public String getOperationType()
	{
		return operationType;
	}

	public void setOperationType(String operationType)
	{
		this.operationType = operationType;
	}

}
