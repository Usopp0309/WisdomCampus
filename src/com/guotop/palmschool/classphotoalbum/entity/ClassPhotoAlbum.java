package com.guotop.palmschool.classphotoalbum.entity;

/**
 * 班级相册实体类
 * @author Administrator
 *
 */
public class ClassPhotoAlbum
{
	/**
	 * 相册Id 
	 */
	private Integer albumId;

	/**
	 * 相册名称
	 */
	private String albumName;

	/**
	 * 相册描述
	 */
	private String albumDesc;

	/**
	 * 相册创建人Id
	 */
	private Integer  createUserId;

	/**
	 * 相册创建人姓名
	 */
	private String createUserName;
	
	/**
	 * 相册创建人头像
	 */
	private String headImg;

	/**
	 * 相册对应的班级Id
	 */
	private Integer clazzId;

	/**
	 * 相册对应的班级名称
	 */
	private String clazzName;

	/**
	 * 相册创建时间
	 */
	private String createTime;

	/**
	 * 相册更新时间
	 */
	private String updateTime;
	
	/**
	 * 相册封面地址
	 */
	private String albumPath;
	
	/**
	 * 对应的照片数量
	 */
	private Integer photoNum;
	public Integer getAlbumId()
	{
		return albumId;
	}

	public void setAlbumId(Integer albumId)
	{
		this.albumId = albumId;
	}

	public String getAlbumName()
	{
		return albumName;
	}

	public void setAlbumName(String albumName)
	{
		this.albumName = albumName;
	}

	public String getAlbumDesc()
	{
		return albumDesc;
	}

	public void setAlbumDesc(String albumDesc)
	{
		this.albumDesc = albumDesc;
	}

	public Integer getCreateUserId()
	{
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId)
	{
		this.createUserId = createUserId;
	}

	public String getCreateUserName()
	{
		return createUserName;
	}

	public void setCreateUserName(String createUserName)
	{
		this.createUserName = createUserName;
	}

	public Integer getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId)
	{
		this.clazzId = clazzId;
	}

	public String getClazzName()
	{
		return clazzName;
	}

	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
	}

	public String getAlbumPath()
	{
		return albumPath;
	}

	public void setAlbumPath(String albumPath)
	{
		this.albumPath = albumPath;
	}

	public Integer getPhotoNum()
	{
		return photoNum;
	}

	public void setPhotoNum(Integer photoNum)
	{
		this.photoNum = photoNum;
	}

	public String getHeadImg()
	{
		return headImg;
	}

	public void setHeadImg(String headImg)
	{
		this.headImg = headImg;
	}
	
	
}
