package com.guotop.palmschool.personAlbum.entity;

/**
 * 个人相册实体类
 * @author Administrator
 *
 */
public class PersonAlbum
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
	 * 相册归属人Id
	 */
	private Integer  userId;

	/**
	 * 相册归属人姓名
	 */
	private String userName;
	
	/**
	 * 相册归属人头像
	 */
	private String headImg;

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

	public String getHeadImg()
	{
		return headImg;
	}

	public void setHeadImg(String headImg)
	{
		this.headImg = headImg;
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

	
}
