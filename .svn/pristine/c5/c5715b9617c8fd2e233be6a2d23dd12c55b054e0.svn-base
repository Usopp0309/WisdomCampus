package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.SysMessage;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.SysMessageService;
import com.guotop.palmschool.util.Pages;
/**
 * 系统消息接口实现类
 * @author jfy
 * @date 2016年1月6日
 */
@Service("sysMessageService")
public class SysMessageServiceImpl extends BaseService implements SysMessageService
{
	@Resource
	private CommonService commonService;
	@Override
	public void addSysMessage(SysMessage sysMessage)
	{
		getBaseDao().addObject("SysMessage.addSysMessage", sysMessage);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pages getSysMessageList(int pageSize, int page, HashMap<String, Object> map, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SysMessage> list = new ArrayList<SysMessage>();
		
		if (commonService.hasAdminPermission(user))//管理员
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("SysMessage.getSysMessageCount4Admin", map);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			map.put("startIndex", offset);
			// 单页数据量
			map.put("length", length);
			list = this.getBaseDao().selectListByObject("SysMessage.getSysMessage4Admin", map);
		}else
		{
			map.put("userId", user.getUserId());
			allRow = (Integer) this.getBaseDao().selectObjectByObject("SysMessage.getSysMessageCount4Self", map);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			map.put("startIndex", offset);
			// 单页数据量
			map.put("length", length);
			list = this.getBaseDao().selectListByObject("SysMessage.getSysMessage4Self", map);
		}
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
