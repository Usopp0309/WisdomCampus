package com.guotop.palmschool.service;

import com.baidu.yun.push.exception.PushClientException;
import com.baidu.yun.push.exception.PushServerException;
import com.guotop.palmschool.entity.Pushmessage;
import com.guotop.palmschool.rest.entity.PushItem;

public interface PushmessageService
{
	/**
	 * 推送至安卓单个设备
	 * @param pi
	 * @throws PushClientException
	 * @throws PushServerException
	 */
	public void androidPushMsgToSingle(PushItem pi) throws PushClientException, PushServerException;
	
	/**
	 * 推送至IOS单个设备
	 * @param pi
	 * @param badge
	 * @throws PushClientException
	 * @throws PushServerException
	 */
	public void iosPushNotificationToSingleDevice(PushItem pi,int badge) throws PushClientException, PushServerException;
	
	/**
	 * 推送至安卓多个设备(IOS不支持)
	 * @param pi
	 * @param channelIdList
	 * @throws PushClientException
	 * @throws PushServerException
	 */
	public void androidPushBatchUniMsg(PushItem pi,  String[] channelIdStrs) throws PushClientException, PushServerException;
	
	/**
	 * 添加到推送表中
	 * @param pm
	 */
	public Integer addPushmesaage(Pushmessage pm);
	
	/**
	 * 获取这个人最新
	 * @param receiverId
	 * @return
	 */
	public int findLatestMessageCountList(Integer receiverId);
	
	/**
	 * 获取两周前的数据
	 * @param startTime
	 * @return
	 */
	public Integer getPushmessageByDate(String startTime);
	/**
	 * 删除两周前的数据
	 * @param startTime
	 * @return
	 */
	public void deletePushmessageByDate(String startTime);
}
