package com.guotop.palmschool.camera.entity;

/**
 * 摄像头和班级或人员的关系实体类
 * @author Administrator
 *
 */
public class CameraRelation
{
	/**
	 * id
	 */
	private Integer id;
	
	/**
	 * 摄像头Id
	 */
	private Integer cameraId;

	/**
	 * 班级id
	 */
	private Integer clazzId;
	
	/**
	 * 学生的id
	 */
	private Integer userId;

	/**
	 * 创建时间
	 */
	private String createTime;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getCameraId()
	{
		return cameraId;
	}

	public void setCameraId(Integer cameraId)
	{
		this.cameraId = cameraId;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

}
