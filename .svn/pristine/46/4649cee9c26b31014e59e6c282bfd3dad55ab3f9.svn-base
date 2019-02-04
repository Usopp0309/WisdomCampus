package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.News;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.SchoolNewsService;
import com.guotop.palmschool.util.Pages;

@Service("schoolNewsService")
public class SchoolNewsServiceImpl extends BaseService implements SchoolNewsService
{

	@Override
	public void addNews(News news)
	{
		getBaseDao().addObject("News.addNews", news);

	}
     /**
      * 获得最新的几条新闻
       @author chenyong
       @date 2016年8月8日 下午7:22:45
      * @param length
      * @return
      */
	@SuppressWarnings("unchecked")
	@Override
	public List<News> getNewsListLimit(int length)
	{
		return getBaseDao().selectListByObject("News.getNewsListLimit", length);
	}
    /**
     * 分页获得新闻
      @author chenyong
      @date 2016年8月8日 下午7:26:32
     * @param pageSize
     * @param page
     * @param paramMap
     * @return
     */
	@SuppressWarnings("unchecked")
	@Override
	public Pages getPageNewsList(int pageSize, int page, Map<String, Object> paramMap)
	{
		List<News> list = new ArrayList<News>();
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		
		allRow = (int) this.getBaseDao().selectObjectByObject("News.getPageNewsListCount", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("News.getPageNewsList", paramMap);
		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

}
