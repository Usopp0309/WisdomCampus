package com.guotop.palmschool.thread;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.rest.entity.PushItem;

/**
 * 自动通知购买服务费线程
 */
public class BuyServiceFeeThread extends Thread
{
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	private Long schoolId;

	private String content;

	private List<User> receiverList;

	public BuyServiceFeeThread(Long schoolId, String content, List<User> receiverList)
	{
		this.schoolId = schoolId;
		this.content = content;
		this.receiverList = receiverList;
	}

	@Override
	public void run()
	{
		DBContextHolder.setDBType(String.valueOf(schoolId));
		List<PushItem> piList = new ArrayList<PushItem>();
		for (User receiver : receiverList)
		{
			try
			{
				List<User> parentList = StartupListener.commonService.getParentByStudentId(receiver.getUserId());
				if (!CollectionUtils.isEmpty(parentList))
				{
					for (User parent : parentList)
					{
						PushItem pi = new PushItem();
						pi.receiverId = parent.getUserId();
						pi.channels = parent.getBaiduChannelId();
						pi.deviceType = String.valueOf(parent.getDeviceType());
						pi.PushContent = content;
						pi.PushType = PUSHTYPE.BUYSERVICEFEE.getType();
						pi.PushContentType = PUSHTYPE.BUYSERVICEFEE.getContentType();
						pi.title = PUSHTYPE.BUYSERVICEFEE.getName();
						pi.schoolId = String.valueOf(schoolId);
						piList.add(pi);
					}
				}
				
			} catch (Exception e)
			{
				logger.error("通知购买服务费线程出错：" + e.getMessage());
				continue;
			}
		}
		if (!CollectionUtils.isEmpty(piList))
		{
			StartupListener.commonService.pushMsg(piList, false);// 消息推送
		}
	}
}
