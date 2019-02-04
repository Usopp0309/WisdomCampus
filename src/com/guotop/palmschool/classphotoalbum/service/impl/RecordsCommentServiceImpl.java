package com.guotop.palmschool.classphotoalbum.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.classphotoalbum.entity.RecordsComment;
import com.guotop.palmschool.classphotoalbum.service.RecordsCommentService;
import com.guotop.palmschool.service.BaseService;

@Service("/recordsCommentService")
public class RecordsCommentServiceImpl extends BaseService implements RecordsCommentService
{

	@Override
	public Integer addComment(RecordsComment recordsComment)
	{
		Integer commentId = getBaseDao().addObject("Comment.addComment", recordsComment);
		return commentId;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<RecordsComment> getCommentListByRecordsIdAndCommentType(Map<String, Object> paramMap)
	{
		List<RecordsComment> list = this.getBaseDao().selectListByObject("Comment.getCommentListByRecordsIdAndCommentType", paramMap);
		return list;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<RecordsComment> getCommentListByPhotoIdAndCommentType(Map<String, Object> paramMap)
	{
		List<RecordsComment> list = this.getBaseDao().selectListByObject("Comment.getCommentListByPhotoIdAndCommentType", paramMap);
		return list;
	}

	@Override
	public RecordsComment getCommentByCommentId(Integer commentId)
	{
		RecordsComment comment = (RecordsComment) this.getBaseDao().selectObjectByObject("Comment.getCommentByCommentId", commentId);
		return comment;
	}

	@Override
	public RecordsComment getPraiseByPhotoIdAndCommentTypeAndUserId(Map<String, Object> paramMap)
	{
		RecordsComment comment = (RecordsComment) this.getBaseDao().selectObjectByObject("Comment.getPraiseByPhotoIdAndCommentTypeAndUserId", paramMap);
		return comment;
	}

	@Override
	public RecordsComment getPraiseByRecordsIdAndCommentTypeAndUserId(Map<String, Object> paramMap)
	{
		RecordsComment comment = (RecordsComment) this.getBaseDao().selectObjectByObject("Comment.getPraiseByRecordsIdAndCommentTypeAndUserId", paramMap);
		return comment;
	}

	@Override
	public void deleteRecordsComment(Integer commentId)
	{
		this.getBaseDao().deleteObjectById("Comment.deleteRecordsComment", commentId);
		
	}

	@Override
	public void deleteRecordsCommentByParentId(Integer parentId)
	{
		this.getBaseDao().deleteObjectById("Comment.deleteRecordsCommentByParentId", parentId);
	}

}
