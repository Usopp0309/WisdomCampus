package com.guotop.palmschool.classphotoalbum.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 照片实体类
 * @author Administrator
 *
 */
public class Photo
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
	 * 上传记录Id
	 */
	private Integer recordsId;

	/**
	 *  相册Id 
	 */
	private Integer albumId;
	
	/**
	 * 相片创建人Id
	 */
	private Integer createUserId;
	
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
	private String createUserName;
	
	/**
	 * 相册创建人头像
	 */
	private String headImg;
	
	/**
	 * 相册创建时间
	 */
	private String createTime;
	
	/**
	 * 相册评论（只记录父级）
	 */
	private List<RecordsComment> commentList = new ArrayList<RecordsComment>();
	
	/**
	 * 相册评论map(所有评论的map集合)
	 */
	Map<Integer, RecordsComment> commentMap = new HashMap<Integer, RecordsComment>();
	
	/**
	 * 相册评论map(父级评论对应的所有子级评论)
	 * 一个父评论下多个子评论
	 */
	Map<Integer, List<RecordsComment>> commentSubMap = new HashMap<Integer, List<RecordsComment>>();

	/**
	 * 相册点赞列表
	 */
	private List<RecordsComment> praiseList = new ArrayList<RecordsComment>();

	/**
	 * 评论相关的属性 start
	 * @return
	 */
	/**
	 * 评论Id
	 */
	private Integer commentId;

	/**
	 * 父评论的id
	 */
	private Integer parentId;
	
	/**
	 * 回复评论的id
	 */
	private Integer commentReplyId;
	
	/**
	 * 回复评论的userId
	 */
	private Integer commentReplyUserId;
	
	/**
	 * 回复评论的userName
	 */
	private String commentReplyUserName;

	/**
	 * 评论类型 0 点赞 1 文字回复
	 */
	private Integer commentType;

	/**
	 * 评论内容
	 */
	private String content;

	/**
	 *  评论人Id
	 */
	private Integer commentUserId;
	
	/**
	 *  评论人姓名
	 */
	private String commentUserName;
	/**
	 * 评论相关的属性 end
	 * @return
	 */
	
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

	public String getAlbumName()
	{
		return albumName;
	}

	public void setAlbumName(String albumName)
	{
		this.albumName = albumName;
	}

	public String getCreateUserName()
	{
		return createUserName;
	}

	public void setCreateUserName(String createUserName)
	{
		this.createUserName = createUserName;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public List<RecordsComment> getCommentList()
	{
		return commentList;
	}

	public void setCommentList(List<RecordsComment> commentList)
	{
		this.commentList = commentList;
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

	public List<RecordsComment> getPraiseList()
	{
		return praiseList;
	}

	public void setPraiseList(List<RecordsComment> praiseList)
	{
		this.praiseList = praiseList;
	}

	public Integer getCreateUserId()
	{
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId)
	{
		this.createUserId = createUserId;
	}

	public String getHeadImg()
	{
		return headImg;
	}

	public void setHeadImg(String headImg)
	{
		this.headImg = headImg;
	}

	public Integer getCommentId()
	{
		return commentId;
	}

	public void setCommentId(Integer commentId)
	{
		this.commentId = commentId;
	}

	public Integer getParentId()
	{
		return parentId;
	}

	public void setParentId(Integer parentId)
	{
		this.parentId = parentId;
	}

	public Integer getCommentReplyId()
	{
		return commentReplyId;
	}

	public void setCommentReplyId(Integer commentReplyId)
	{
		this.commentReplyId = commentReplyId;
	}

	public Integer getCommentReplyUserId()
	{
		return commentReplyUserId;
	}

	public void setCommentReplyUserId(Integer commentReplyUserId)
	{
		this.commentReplyUserId = commentReplyUserId;
	}

	public String getCommentReplyUserName()
	{
		return commentReplyUserName;
	}

	public void setCommentReplyUserName(String commentReplyUserName)
	{
		this.commentReplyUserName = commentReplyUserName;
	}

	public Integer getCommentType()
	{
		return commentType;
	}

	public void setCommentType(Integer commentType)
	{
		this.commentType = commentType;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public Integer getCommentUserId()
	{
		return commentUserId;
	}

	public void setCommentUserId(Integer commentUserId)
	{
		this.commentUserId = commentUserId;
	}

	public String getCommentUserName()
	{
		return commentUserName;
	}

	public void setCommentUserName(String commentUserName)
	{
		this.commentUserName = commentUserName;
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
