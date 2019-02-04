package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.OnlineMessage;
import com.guotop.palmschool.entity.OnlineMessageDetail;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.OnlineMessageService;
import com.guotop.palmschool.util.Pages;

/**
 * 在线留言业务类实现类
 * 
 * @author shengyinjiang
 * 
 */
@Service("onlineMessageService")
public class OnlineMessageServiceImpl extends BaseService implements OnlineMessageService
{
	@Resource
	private CommonService commonService;
	/**
	 * 新增在线留言内容
	 * 
	 * @param sms
	 *            待新增的在线留言实体
	 */
	public int addSms(OnlineMessage onlineMessage)
	{
		int onlineMessageId = getBaseDao().addObject("OnlineMessage.addOnlineMessage", onlineMessage);
		return onlineMessageId;

	}

	/**
	 * 新增在线留言内容详情
	 * 
	 * @param sms
	 *            待新增的在线留言实体详情
	 *  update by syj 20151214
	 */
	public void addSmsDetail(OnlineMessageDetail onlineMessageDetail)
	{
		getBaseDao().addObject("OnlineMessageDetail.addOnlineMessageDetail", onlineMessageDetail);

	}

	/**
	 * 加载在线留言列表信息
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 *            参数列表
	 * @return 根据不同权限加载在线留言列表数据(分页)
	 * 
	 *         update syj 20151214
	 */
	@SuppressWarnings("unchecked")
	public Pages loadSmsList(int pageSize, int page, Map<String, Object> paramMap, User user)
	{

		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<OnlineMessage> list = new ArrayList<OnlineMessage>();

		/*
		 * 校长,学校管理员,董事长（全校所有人）
		 */
		if (commonService.hasAdminPermission(user))
		{

			allRow = (Integer) this.getBaseDao().selectObjectByObject("OnlineMessage.loadSmsCountAsMaster", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("OnlineMessage.loadSmsListAsMaster", paramMap);

		}

		/*
		 * 其他人只能看到自己发送的信息
		 */
		else
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("OnlineMessage.loadSmsCountAsSelf", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("OnlineMessage.loadSmsListAsSelf", paramMap);
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
	/**
	 * 加载在线留言列表信息【福建专用】
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 *            参数列表
	 * @return 根据不同权限加载在线留言列表数据(分页)
	 * 
	 *         update syj 20151214
	 */
	@SuppressWarnings("unchecked")
	public Pages loadSmsListFj(int pageSize, int page, Map<String, Object> paramMap, User user){
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<OnlineMessage> list = new ArrayList<OnlineMessage>();

		/*
		 * 校长,学校管理员,董事长（全校所有人）
		 */
		if (commonService.hasAdminPermissionFj(user))
		{

			allRow = (Integer) this.getBaseDao().selectObjectByObject("OnlineMessage.loadSmsCountAsMasterFj", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("OnlineMessage.loadSmsListAsMasterFj", paramMap);

		}

		/*
		 * 其他人只能看到自己发送的信息
		 */
		else
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("OnlineMessage.loadSmsCountAsSelfFj", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("OnlineMessage.loadSmsListAsSelfFj", paramMap);
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
	/**
	 * 加载接受在线未读留言列表信息
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 *            参数列表
	 * @return 加载未读在线留言列表数据(分页)
	 */
	@SuppressWarnings("unchecked")
	public Pages loadAcceptUnReadSmsList(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<OnlineMessageDetail> list = new ArrayList<OnlineMessageDetail>();

		allRow = this.getBaseDao().getAllRowCountByCondition("OnlineMessageDetail.selectUnReadOnlineMessageByUserId", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("OnlineMessageDetail.selectUnReadOnlineMessageByUserId", paramMap, offset, length);

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

	/**
	 * "发送在线留言"查询详情
	 * 
	 * update syj 20151214
	 */
	@SuppressWarnings("unchecked")
	public List<OnlineMessageDetail> loadSmsListDetail(Integer messageId)
	{
		return this.getBaseDao().selectListByObject("OnlineMessageDetail.loadSmsListAsMessageId", messageId);
	}

	/**
	 * 通过id查询 "接受在线留言"详情
	 * 
	 * shengyinjiang 2015/12/14
	 */
	public OnlineMessageDetail loadOnlineMessageDetailById(Integer id)
	{
		return (OnlineMessageDetail) this.getBaseDao().selectObject("OnlineMessageDetail.selectOnlineMessageById", id);
	}

	/**
	 * 通过id将接受的留言状态更改为已读
	 * 
	 * shengyinjiang 2015/12/14
	 */
	public void updateOnlineMessageStatusById(Integer id)
	{
		this.getBaseDao().updateObject("OnlineMessageDetail.updateStatusById", id);

	}

	/**
	 * 将接受的留言状态全部更改为已读
	 * 
	 * shengyinjiang 2015/12/14
	 */
	public void updateOnlineMessageStatus(Map<String, Object> paramMap)
	{

		this.getBaseDao().updateObject("OnlineMessageDetail.updateStatus", paramMap);
	}
	
	/**
	 * 通过receiverId 找到该用户三条未读消息，用于导航栏显示
	 * 
	 * @param receiverId
	 *            接收用户id
	 */
	@SuppressWarnings("unchecked")
	public List<OnlineMessageDetail> selectUnReadOnlineMessageByUserIdLimitThree(Map<String, Object> paramMap)
	{
		return getBaseDao().selectListByObject("OnlineMessageDetail.selectUnReadOnlineMessageByUserIdLimitThree", paramMap);
	}

	/**
	 * 通过receiverId 找到该用户所有未读消息，用户点击查看所有未读留言显示
	 * 
	 * @param receiverId
	 *            接受用户id
	 */
	@SuppressWarnings("unchecked")
	public List<OnlineMessageDetail> selectUnReadOnlineMessageByUserId(Map<String, Object> paramMap)
	{
		return getBaseDao().selectListByObject("OnlineMessageDetail.selectUnReadOnlineMessageByUserId", paramMap);
	}

	/**
	 * 通过receiverId 找到该用户所有消息，用户点击查看所有留言显示
	 * 
	 * @param receiverId
	 *            接受用户id
	 */
	@SuppressWarnings("unchecked")
	public Pages selectOnlineMessageByUserId(int pageSize, int page,Map<String, Object> paramMap)
	{
		
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<OnlineMessageDetail> list = new ArrayList<OnlineMessageDetail>();

		allRow = this.getBaseDao().getAllRowCountByCondition("OnlineMessageDetail.selectOnlineMessageByUserId", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("OnlineMessageDetail.selectOnlineMessageByUserId", paramMap, offset, length);
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
	/**
	 *  通过userId 找到该用户所有未读留言数量
	 * @author chenyong
	 * @Time 2016年12月17日 下午4:51:28
	 */
	@Override
	public Integer selectUnReadOnlineMessageByUserIdCount(Map<String, Object> map) {
		
		return (Integer) this.getBaseDao().selectObjectByObject("OnlineMessageDetail.selectUnReadOnlineMessageByUserIdCount", map);
	}
	
}
