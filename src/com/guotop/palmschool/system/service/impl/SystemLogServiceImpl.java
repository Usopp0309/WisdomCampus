package com.guotop.palmschool.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.system.entity.SystemLog;
import com.guotop.palmschool.system.service.SystemLogService;
import com.guotop.palmschool.util.Pages;

/**
 * 系统日志业务实现类
 * @author zhou
 */
@Service("systemLogService")
public class SystemLogServiceImpl extends BaseService implements SystemLogService 
{
	/**
	 * 页面加载系统日志列表
	 * @param paramMap 参数map
	 * @return 检测系统日志/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages loadSystemLogList(int pageSize, int page, Map<String, Object> paramMap)
	{
		Integer allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SystemLog> list = new ArrayList<SystemLog>();
//		allRow = this.getBaseDao().getAllRowCountByCondition(
//				"SystemLog.selectSystemLogList", paramMap);
		allRow = (Integer) this.getBaseDao().selectObjectByObject(
				"SystemLog.selectSystemLogListCount", paramMap);
		
		totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition(
				"SystemLog.selectSystemLogList", paramMap, offset, length);
		
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
