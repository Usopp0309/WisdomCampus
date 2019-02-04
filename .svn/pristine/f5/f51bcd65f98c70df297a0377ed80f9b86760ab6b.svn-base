package com.guotop.palmschool.schoolnews.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.schoolnews.entity.Reviewers;
import com.guotop.palmschool.schoolnews.entity.SchoolNewsInfo;
import com.guotop.palmschool.schoolnews.service.SchoolNewsLookService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 校车管理业务类实现类
 * 
 */
@Service("schoolNewsLookService")
public class SchoolNewsLookServiceImpl extends BaseService implements SchoolNewsLookService
{

	@SuppressWarnings("unchecked")
	public Pages getSchoolNews(int pageSize, int page, Map<String,Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SchoolNewsInfo> list = new ArrayList<SchoolNewsInfo>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("SchoolNewsInfo.getNewsListCount", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		list = this.getBaseDao().selectListByObject("SchoolNewsInfo.getNewsList", paramMap);
		
		Pages pages = new Pages();
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}
	@SuppressWarnings("unchecked")
	public Pages getRichCloundSchoolNews(int pageSize, int page, Map<String,Integer> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SchoolNewsInfo> list = new ArrayList<SchoolNewsInfo>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("SchoolNewsInfo.getRichCloundNewsListCount", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		list = this.getBaseDao().selectListByObject("SchoolNewsInfo.getRichCloundNewsList", paramMap);
		Pages pages = new Pages();
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}
	@Override
	public SchoolNewsInfo getSchoolNewsById(String newsId)
	{
		return (SchoolNewsInfo) this.getBaseDao().selectObjectByObject("SchoolNewsInfo.getSchoolNewsById", newsId);
	}

	@Override
	public int getCommentsCountByNewsId(Reviewers reviewers)
	{
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("newsId", reviewers.getNewsId());
		List<String> list = new ArrayList<String>();
		list.add("0");
		map.put("ids", list);
		return (int) this.getBaseDao().selectObjectByObject("Reviewers.getCommentsCountByNewsId", map);
	}

	@Override
	public Integer addComment(Reviewers rv)
	{
		return (Integer) this.getBaseDao().addObject("Reviewers.addComment", rv);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Reviewers> getCommentsByNewsId(HashMap<String, Object> map)
	{
		return (List<Reviewers>) this.getBaseDao().selectListByObject("Reviewers.getCommentsByNewsId", map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Reviewers> getCommentByContent(HashMap<String, Object> map)
	{
		return (List<Reviewers>) this.getBaseDao().selectListByObject("Reviewers.getCommentByContent", map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Reviewers> getMyCommentByUserId(HashMap<String, Object> map)
	{
		return (List<Reviewers>) this.getBaseDao().selectListByObject("Reviewers.getMyCommentByUserId", map);
	}

	@Override
	public void addZan(String commentId)
	{
		this.getBaseDao().updateObject("Reviewers.addZan", commentId);
	}

	@Override
	public void addCommentCount(String parentId)
	{
		this.getBaseDao().updateObject("Reviewers.addCommentCount", parentId);
	}

	@Override
	public void deleteComments(String commentId)
	{
		this.getBaseDao().deleteObject("Reviewers.deleteComments", commentId);
	}

	@Override
	public void updateReplayCountsForDelete(String commentId)
	{
		this.getBaseDao().updateObject("Reviewers.updateReplayCountsForDelete", commentId);
	}

	public Reviewers getCommentByCommentId(Integer commentId)
	{
		return (Reviewers) getBaseDao().selectObject("Reviewers.getCommentByCommentId", commentId);
	}
	
	@SuppressWarnings("unchecked")
	public List<Reviewers> getCommentsByParentId(Integer parentId)
	{
		return (List<Reviewers>) this.getBaseDao().selectList("Reviewers.getCommentsByParentId", parentId);
	}
	/**
	 * 根据传入的type类型查询   1、校园新闻，2、学校活动，3、学校招生信息  4、家长课堂
	 * @param newsType
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SchoolNewsInfo> getSchoolNewsByNewsType(int pageSize, int page,Integer newsType)
	{
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		Map<String, Integer> paramMap = new HashMap<String, Integer>();
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		
		paramMap.put("newsType", newsType);
		
		List<SchoolNewsInfo> list = this.getBaseDao().selectListByObject("SchoolNewsInfo.getSchoolNewsByNewsType", paramMap);
		
		return list;
	}
	
	/**
	 * 根据newsId查询有多少条参加记录
	 * @param newsType
	 * @return
	 */
	public Integer getCountByNewsId(Integer newsId)
	{
		return (Integer)getBaseDao().selectObject("ApplyInfo.getCountByNewsId", newsId);
	}
	/**
	 * 首页新闻
	  @author chenyong
	  @date 2016年10月13日 下午5:24:40
	 * @param map
	 * @return
	 */
	@Override
	public List<SchoolNewsInfo> getSchoolNewsIndexInfo(Map<String, Object> map)
	{
		List<SchoolNewsInfo> list = this.getBaseDao().selectListByObject("SchoolNewsInfo.getSchoolNewsIndexInfo", map);
		return list;
	}
	
	/**
	 * 根据userId获取其发布的所有新闻
	 * @param userId
	 * @param newsId 从第几条开始
	 * @param newsType
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SchoolNewsInfo> getPersonSchoolNewsListByUserId(Map<String, Object> paramMap)
	{
		
		return  (List<SchoolNewsInfo>)this.getBaseDao().selectListByObject("SchoolNewsInfo.getPersonSchoolNewsListByUserId", paramMap);
		
	}
}
