package com.guotop.palmschool.classphotoalbum.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 上传记录实体类
 * 
 * @author Administrator
 *
 */
public class UploadRecords
{
	/**
	 * 上传记录Id
	 */
	private Integer recordsId;

	/**
	 * 上传描述
	 */
	private String recordsDesc;

	/**
	 * 相册Id
	 */
	private Integer albumId;

	/**
	 * 类型 0文本 1图片 2音频 3视屏 4签到 5连接
	 */
	public Integer recordsType;

	/**
	 * 标题
	 */
	public String recordsTitle;

	/**
	 * 经度
	 */
	public Double recordsLongitude;

	/**
	 * 纬度
	 */
	public Double recordsLatitude;
	/**
	 * 地址
	 */
	public String recordsAddress;
	/**
	 * 连接
	 */
	public String recordsUrl;

	/**
	 * 上传人Id
	 */
	private Integer uploadUserId;

	/**
	 * 上传人姓名
	 */
	private String uploadUserName;

	/**
	 * 上传人头像
	 */
	private String headImg;

	/**
	 * 上传时间
	 */
	private String createTime;

	/**
	 * 相册名称
	 */
	private String albumName;
	/**
	 * 上传记录图片列表
	 */
	private List<Photo> photoList = new ArrayList<Photo>();

	/**
	 * 上传记录评论
	 */
	private List<RecordsComment> commentList = new ArrayList<RecordsComment>();

	/**
	 * 上传记录评论map
	 */
	Map<Integer, RecordsComment> commentMap = new HashMap<Integer, RecordsComment>();

	/**
	 * 上传记录评论map 一个父评论下多个子评论
	 */
	Map<Integer, List<RecordsComment>> commentSubMap = new HashMap<Integer, List<RecordsComment>>();

	/**
	 * 上传记录点赞列表
	 */
	private List<RecordsComment> praiseList = new ArrayList<RecordsComment>();

	public Integer getRecordsId()
	{
		return recordsId;
	}

	public void setRecordsId(Integer recordsId)
	{
		this.recordsId = recordsId;
	}

	public Integer getAlbumId()
	{
		return albumId;
	}

	public void setAlbumId(Integer albumId)
	{
		this.albumId = albumId;
	}

	public Integer getUploadUserId()
	{
		return uploadUserId;
	}

	public void setUploadUserId(Integer uploadUserId)
	{
		this.uploadUserId = uploadUserId;
	}

	public String getUploadUserName()
	{
		return uploadUserName;
	}

	public void setUploadUserName(String uploadUserName)
	{
		this.uploadUserName = uploadUserName;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public List<Photo> getPhotoList()
	{
		return photoList;
	}

	public void setPhotoList(List<Photo> photoList)
	{
		this.photoList = photoList;
	}

	public List<RecordsComment> getCommentList()
	{
		return commentList;
	}

	public void setCommentList(List<RecordsComment> commentList)
	{
		this.commentList = commentList;
	}

	public List<RecordsComment> getPraiseList()
	{
		return praiseList;
	}

	public void setPraiseList(List<RecordsComment> praiseList)
	{
		this.praiseList = praiseList;
	}

	public String getAlbumName()
	{
		return albumName;
	}

	public void setAlbumName(String albumName)
	{
		this.albumName = albumName;
	}

	public Map<Integer, RecordsComment> getCommentMap()
	{
		return commentMap;
	}

	public void setCommentMap(Map<Integer, RecordsComment> commentMap)
	{
		this.commentMap = commentMap;
	}

	public Map<Integer, List<RecordsComment>> getCommentSubMap()
	{
		return commentSubMap;
	}

	public void setCommentSubMap(Map<Integer, List<RecordsComment>> commentSubMap)
	{
		this.commentSubMap = commentSubMap;
	}

	public String getHeadImg()
	{
		return headImg;
	}

	public void setHeadImg(String headImg)
	{
		this.headImg = headImg;
	}

	public String getRecordsDesc()
	{
		return recordsDesc;
	}

	public void setRecordsDesc(String recordsDesc)
	{
		this.recordsDesc = recordsDesc;
	}

	public Integer getRecordsType()
	{
		return recordsType;
	}

	public void setRecordsType(Integer recordsType)
	{
		this.recordsType = recordsType;
	}

	public String getRecordsTitle()
	{
		return recordsTitle;
	}

	public void setRecordsTitle(String recordsTitle)
	{
		this.recordsTitle = recordsTitle;
	}

	public Double getRecordsLongitude()
	{
		return recordsLongitude;
	}

	public void setRecordsLongitude(Double recordsLongitude)
	{
		this.recordsLongitude = recordsLongitude;
	}

	public Double getRecordsLatitude()
	{
		return recordsLatitude;
	}

	public void setRecordsLatitude(Double recordsLatitude)
	{
		this.recordsLatitude = recordsLatitude;
	}

	public String getRecordsAddress()
	{
		return recordsAddress;
	}

	public void setRecordsAddress(String recordsAddress)
	{
		this.recordsAddress = recordsAddress;
	}

	public String getRecordsUrl()
	{
		return recordsUrl;
	}

	public void setRecordsUrl(String recordsUrl)
	{
		this.recordsUrl = recordsUrl;
	}

}
