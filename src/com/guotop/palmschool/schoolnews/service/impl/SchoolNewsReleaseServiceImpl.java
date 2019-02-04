package com.guotop.palmschool.schoolnews.service.impl;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.schoolnews.entity.SchoolNewsInfo;
import com.guotop.palmschool.schoolnews.service.SchoolNewsReleaseService;
import com.guotop.palmschool.service.BaseService;


/**
 * 校园新闻发布业务类实现类
 * @author
 */
@Service("schoolNewsReleaseService")
public class SchoolNewsReleaseServiceImpl extends BaseService implements SchoolNewsReleaseService
{
	/**
	 * 增加新闻
	 */
	public Integer addSchoolNewsRelease(SchoolNewsInfo schoolNews)
	{
		return (Integer)getBaseDao().addObject("SchoolNewsInfo.addSchoolNewsRelease", schoolNews);
	}
	
	/**
	 * 根据新闻id删除对应的新闻
	 * @param newsId
	 */
	public void deleteSchoolNews(Integer newsId)
	{
		getBaseDao().deleteObjectById("SchoolNewsInfo.deleteSchoolNews", newsId);
	}
}
