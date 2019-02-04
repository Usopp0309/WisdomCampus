package com.guotop.palmschool.entity;

import java.util.ArrayList;
import java.util.List;

import com.guotop.palmschool.entity.OnlineMessageDetail;

/**
 * 未读消息实体类
 * 
 * @author Administrator
 * 
 */
public class UnReadOnlineMessage
{

	// 未读在线留言数量
	private Integer unReadOnlineMessageCount;

	// 留言内容list
	private List<OnlineMessageDetail> list = new ArrayList<OnlineMessageDetail>();

	public Integer getUnReadOnlineMessageCount()
	{
		return unReadOnlineMessageCount;
	}

	public void setUnReadOnlineMessageCount(Integer unReadOnlineMessageCount)
	{
		this.unReadOnlineMessageCount = unReadOnlineMessageCount;
	}

	public List<OnlineMessageDetail> getList()
	{
		return list;
	}

	public void setList(List<OnlineMessageDetail> list)
	{
		this.list = list;
	}

}
