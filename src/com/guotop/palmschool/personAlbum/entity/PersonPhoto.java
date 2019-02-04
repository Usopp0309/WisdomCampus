package com.guotop.palmschool.personAlbum.entity;

/**
 * 照片实体类
 * @author Administrator
 *
 */
public class PersonPhoto
{
	/**
	 * 照片Id
	 */
	private Integer photoId;

	/**
	 * 照片名称
	 */
	private String photoName;
	
	/**
	 * 照片描述
	 */
	private String photoDesc;

	/**
	 * 照片路径
	 */
	private String photoPath;

	/**
	 *  相册Id 
	 */
	private Integer albumId;
	
	/**
	 * 相片归属人Id
	 */
	private Integer userId;
	
	/**
	 * 相片归属人姓名
	 */
	private String userName;
	
    /**
     * 0文本，1图文，2音频，3视频，4签到，5链接
     */
    public Integer mediaType;

    /**
     * 3视频 的封面
     */
    public String mediaSecordUrl;
	
	/**
	 * ------添加额外的属性-----------------
	 * @return
	 */
	/**
	 * 相册名字
	 */
	private String albumName;
	
	/**
	 * 相册创建人
	 */
	private String albumUserName;
	
	/**
	 * 相册归属人头像
	 */
	private String headImg;
	
	/**
	 * 相册创建时间
	 */
	private String createTime;
	
	public Integer getPhotoId()
	{
		return photoId;
	}

	public void setPhotoId(Integer photoId)
	{
		this.photoId = photoId;
	}

	public String getPhotoName()
	{
		return photoName;
	}

	public void setPhotoName(String photoName)
	{
		this.photoName = photoName;
	}
	
	public String getPhotoDesc()
	{
		return photoDesc;
	}

	public void setPhotoDesc(String photoDesc)
	{
		this.photoDesc = photoDesc;
	}

	public String getPhotoPath()
	{
		return photoPath;
	}

	public void setPhotoPath(String photoPath)
	{
		this.photoPath = photoPath;
	}

	public Integer getAlbumId()
	{
		return albumId;
	}

	public void setAlbumId(Integer albumId)
	{
		this.albumId = albumId;
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

	public String getAlbumName()
	{
		return albumName;
	}

	public void setAlbumName(String albumName)
	{
		this.albumName = albumName;
	}

	public String getAlbumUserName()
	{
		return albumUserName;
	}

	public void setAlbumUserName(String albumUserName)
	{
		this.albumUserName = albumUserName;
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

	public Integer getMediaType()
	{
		return mediaType;
	}

	public void setMediaType(Integer mediaType)
	{
		this.mediaType = mediaType;
	}

	public String getMediaSecordUrl()
	{
		return mediaSecordUrl;
	}

	public void setMediaSecordUrl(String mediaSecordUrl)
	{
		this.mediaSecordUrl = mediaSecordUrl;
	}

}
