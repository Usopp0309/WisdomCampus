package com.guotop.palmschool.schoolnews.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guotop.palmschool.schoolnews.entity.Reviewers;
import com.guotop.palmschool.schoolnews.entity.SchoolNewsInfo;
import com.guotop.palmschool.util.Pages;

/**
 * 校车管理业务类接口
 * 
 * @author zhou
 */
public interface SchoolNewsLookService
{
	public Pages getSchoolNews(int pageSize, int currentPage, Map<String,Object> paramMap);
	public Pages getRichCloundSchoolNews(int pageSize, int page, Map<String,Integer> paramMap);
	
	SchoolNewsInfo getSchoolNewsById(String newsId);
	
	int getCommentsCountByNewsId(Reviewers reviewers);

	public Integer addComment(Reviewers rv);

	List<Reviewers> getCommentsByNewsId(HashMap<String, Object> map);

	void addZan(String commentId);

	void addCommentCount(String parentId);

	List<Reviewers> getCommentByContent(HashMap<String, Object> map);

	List<Reviewers> getMyCommentByUserId(HashMap<String, Object> map);

	void deleteComments(String commentId);

	void updateReplayCountsForDelete(String commentId);
	
	public Reviewers getCommentByCommentId(Integer commentId);
	
	public List<Reviewers> getCommentsByParentId(Integer parentId);
	
	/**
	 * 根据传入的type类型查询   1、校园新闻，2、学校活动，3、学校招生信息  4、家长课堂
	 * @param newsType
	 * @return
	 */
	public List<SchoolNewsInfo> getSchoolNewsByNewsType(int pageSize, int page,Integer newsType);
	
	/**
	 * 根据newsId查询有多少条参加记录
	 * @param newsType
	 * @return
	 */
	public Integer getCountByNewsId(Integer newsId);
	/**
	 * 首页新闻
	  @author chenyong
	  @date 2016年10月13日 下午5:24:40
	 * @param map
	 * @return
	 */
	public List<SchoolNewsInfo>getSchoolNewsIndexInfo(Map<String,Object> map);
	
	/**
	 * 根据userId获取其发布的所有新闻
	 * @param userId
	 * @param newsId 从第几条开始
	 * @param newsType
	 * @return
	 */
	public List<SchoolNewsInfo> getPersonSchoolNewsListByUserId(Map<String, Object> paramMap);
	
}
