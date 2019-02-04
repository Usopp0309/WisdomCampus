package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.News;
import com.guotop.palmschool.util.Pages;

/**
 * 学校新闻服务接口
 * @author jfy
 * @date 2015年12月11日
 */
public interface SchoolNewsService
{
	/**
	 * 新增新闻
	 * @param news
	 */
	public void addNews(News news);
	/**
	 * 获得最新的几条新闻
	  @author chenyong
	  @date 2016年8月8日 下午7:21:03
	 * @param length
	 * @return
	 */
	public List<News> getNewsListLimit(int length);
	/**
	 * 分页获得最新的几条新闻
	  @author chenyong
	  @date 2016年8月8日 下午3:47:08
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @return
	 */
	public Pages getPageNewsList(int pageSize, int page, Map<String, Object> paramMap);
}
