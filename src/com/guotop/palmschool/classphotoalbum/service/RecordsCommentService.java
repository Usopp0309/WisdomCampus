package com.guotop.palmschool.classphotoalbum.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.classphotoalbum.entity.RecordsComment;

/**
 * 班级相册接口业务接口
 */
public interface RecordsCommentService
{
	/**
	 * 添加评论
	 */
	public Integer addComment(RecordsComment recordsComment);
	
	/**
	 * 获取上传记录的评论列表
	 * @param paramMap
	 * @return
	 */
	public List<RecordsComment> getCommentListByRecordsIdAndCommentType(Map<String, Object> paramMap);
	
	/**
	 * 获取单个图片对应的所有评论
	 * @param paramMap
	 * @return
	 */
	public List<RecordsComment> getCommentListByPhotoIdAndCommentType(Map<String, Object> paramMap);
	
	/**
	 * 获取根据评论Id找到评论的详情
	 * @param commentId
	 * @return
	 */
	public RecordsComment getCommentByCommentId(Integer commentId);
	
	/**
	 * 获取单个图片对应的自己的点赞
	 * @param paramMap
	 * @return
	 */
	public RecordsComment getPraiseByPhotoIdAndCommentTypeAndUserId(Map<String, Object> paramMap);
	
	/**
	 * 获取这个上传记录对应的自己的点赞
	 * @param paramMap
	 * @return
	 */
	public RecordsComment getPraiseByRecordsIdAndCommentTypeAndUserId(Map<String, Object> paramMap);
	
	/**
	 * 删除点评或者点赞
	 * @param commentId
	 */
	public void deleteRecordsComment(Integer commentId);
	
	/**
	 * 根据parentId删除点评
	 * @param parentId
	 */
	public void deleteRecordsCommentByParentId(Integer parentId);
}
