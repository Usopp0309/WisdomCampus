package com.guotop.palmschool.entity;

import java.io.Serializable;

/**
 * 进出记录实体类
 * @author zhou
 */
public class Inout implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	private Integer id;
	
	/**
	 * 卡号
	 */
	private String code;
	
	/**
	 * 进出状态
	 * 1:进校，2:出校
	 */
	private Integer status;
	
	/**
	 * 位置
	 */
	private String position;
	
	/**
	 * 创建时间
	 */
	private String createTime;
	
	/**
	 * 用户ID
	 */
	private Integer userId;
	
	/**
	 * 用户名
	 */
	private String userName;

	/**
	 * 是否同步成功
	 * 1：成功
	 * 0：失败
	 */
	private Integer sync;
	
	/**
	 * 学校ID
	 */
	private String schoolId;
	
	/**
	 * 非db，UI显示
	 */
	/**
	 * 记录点名字
	 */
	private String positionName;
	
	/**
	 * 部门或者班级
	 */
	private String itemName;
	/**
	 * 进门拍照上传至服务器的相对地址
	 */
	private String imgPath;

	public Integer getId() 
	{
		return id;
	}

	public void setId(Integer id) 
	{
		this.id = id;
	}

	public String getCode() 
	{
		return code;
	}

	public void setCode(String code) 
	{
		this.code = code;
	}

	public Integer getStatus() 
	{
		return status;
	}

	public void setStatus(Integer status) 
	{
		this.status = status;
	}

	public String getPosition() 
	{
		return position;
	}

	public void setPosition(String position) 
	{
		this.position = position;
	}

	public String getCreateTime() 
	{
		return createTime;
	}

	public void setCreateTime(String createTime) 
	{
		this.createTime = createTime;
	}

	public Integer getUserId() 
	{
		return userId;
	}

	public void setUserId(Integer userId) 
	{
		this.userId = userId;
	}
	
	public String getUserName() 
	{
		return userName;
	}

	public void setUserName(String userName) 
	{
		this.userName = userName;
	}
	
	public Integer getSync() 
	{
		return sync;
	}

	public void setSync(Integer sync) 
	{
		this.sync = sync;
	}

	public String getSchoolId() 
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId) 
	{
		this.schoolId = schoolId;
	}
	
	public String getPositionName() 
	{
		return positionName;
	}

	public void setPositionName(String positionName) 
	{
		this.positionName = positionName;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getImgPath()
	{
		return imgPath;
	}

	public void setImgPath(String imgPath)
	{
		this.imgPath = imgPath;
	}	
	
}
