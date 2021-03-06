package com.guotop.palmschool.service.impl;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baidu.yun.core.log.YunLogEvent;
import com.baidu.yun.core.log.YunLogHandler;
import com.baidu.yun.push.auth.PushKeyPair;
import com.baidu.yun.push.client.BaiduPushClient;
import com.baidu.yun.push.constants.BaiduPushConstants;
import com.baidu.yun.push.exception.PushClientException;
import com.baidu.yun.push.exception.PushServerException;
import com.baidu.yun.push.model.PushBatchUniMsgRequest;
import com.baidu.yun.push.model.PushBatchUniMsgResponse;
import com.baidu.yun.push.model.PushMsgToSingleDeviceRequest;
import com.baidu.yun.push.model.PushMsgToSingleDeviceResponse;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.Pushmessage;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.PushmessageService;

import dev.gson.GsonHelper;

@Service("pushmessageService")
public class PushmessageServiceImpl extends BaseService implements PushmessageService
{
	private static Logger log = LoggerFactory.getLogger(PushmessageServiceImpl.class);
	
	@Override
	public void androidPushMsgToSingle(PushItem pi) throws PushClientException, PushServerException
	{
		// 1. get apiKey and secretKey from developer console
		PushKeyPair pair = new PushKeyPair(Cons.PUSH_APIKEY, Cons.PUSH_SECRETKEY);

		// 2. build a BaidupushClient object to access released interfaces
		BaiduPushClient pushClient = new BaiduPushClient(pair, BaiduPushConstants.CHANNEL_REST_URL);

		// 3. register a YunLogHandler to get detail interacting information
		// in this request.
		pushClient.setChannelLogHandler(new YunLogHandler()
		{
			@Override
			public void onHandle(YunLogEvent event)
			{
				log.debug(event.getMessage());
			}
		});

		try
		{
			// 4. specify request arguments
			// 创建 Android的通知
			JSONObject notification = new JSONObject();
			notification.put("title", pi.title);
			if (pi.PushContent == null)
			{
				notification.put("description", "智慧校园向您发送了一条新消息，请注意查收");
			} else
			{
				String pushContent = pi.PushContent;
				if(pushContent.length() > 1800){
					pi.PushContent = pushContent.substring(0, 1800);
				}
				pushContent = pi.PushContent;
				notification.put("description", pushContent.length() > 60 ? pushContent.substring(0, 60) + "..." : pushContent);
			}
			notification.put("notification_builder_id", 0);
			notification.put("notification_basic_style", 4);
			notification.put("open_type", 3);
			notification.put("custom_content", GsonHelper.toJson(pi));
			PushMsgToSingleDeviceRequest request = new PushMsgToSingleDeviceRequest().addChannelId(pi.channels).addMsgExpires(new Integer(3600)). // message有效时间
					addMessageType(0).// 1：通知,0:透传消息. 默认为0 注：IOS只有通知.
					addMessage(notification.toString()).addDeviceType(3);// deviceType
																			// =>
																			// 3:android,
																			// 4:ios
			// 5. http request
			PushMsgToSingleDeviceResponse response = pushClient.pushMsgToSingleDevice(request);
			// Http请求结果解析打印
			log.debug("msgId: " + response.getMsgId() + ",sendTime: " + response.getSendTime());
		} catch (PushClientException e)
		{
			/*
			 * ERROROPTTYPE 用于设置异常的处理方式 -- 抛出异常和捕获异常,'true' 表示抛出, 'false' 表示捕获。
			 */
			if (BaiduPushConstants.ERROROPTTYPE)
			{
				throw e;
			} else
			{
				log.error("android，PushClientException推送错误："+"reciverId："+pi.receiverId+","+" deviceType："+pi.deviceType+","+String.format("requestId: %d, errorCode: %d, errorMessage: %s")+ e.getMessage());
			}
		} catch (PushServerException e)
		{
			if (BaiduPushConstants.ERROROPTTYPE)
			{
				throw e;
			} else
			{
				log.error("android，PushServerException推送错误："+"reciverId："+pi.receiverId+","+" deviceType："+pi.deviceType+","+String.format("requestId: %d, errorCode: %d, errorMessage: %s", e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
			}
		}
	}

	@Override
	public void iosPushNotificationToSingleDevice(PushItem pi, int badge) throws PushClientException, PushServerException
	{
		PushKeyPair pair = new PushKeyPair(Cons.PUSH_IOSAPIKEY, Cons.PUSH_IOSSECRETKEY);
		BaiduPushClient pushClient = new BaiduPushClient(pair, BaiduPushConstants.CHANNEL_REST_URL);
		pushClient.setChannelLogHandler(new YunLogHandler()
		{
			@Override
			public void onHandle(YunLogEvent event)
			{
				log.debug(event.getMessage());
			}
		});
		try
		{
			pi.aps = new HashMap<String, Object>();
			pi.aps.put("sound", "default");
			pi.aps.put("badge", badge);
			if (pi.PushContent == null)
			{
				pi.aps.put("alert", "智慧校园向您发送了一条新消息，请注意查收");
			} else
			{
				String pushContent = pi.PushContent;
				if(pushContent.length() > 1800){
					pi.PushContent = pushContent.substring(0, 1800);
				}
				pushContent = pi.PushContent;
				String content = pushContent.length() > 60 ? pushContent.substring(0, 60) + "..." : pushContent;
				pi.aps.put("alert", content);
			}
			PushMsgToSingleDeviceRequest request = new PushMsgToSingleDeviceRequest().addChannelId(pi.channels).addMsgExpires(new Integer(3600)). // 设置message的有效时间
					addMessageType(1).// 1：通知,0:透传消息.默认为0 注：IOS只有通知.
					// TODO 目前先使用开发环境，等待正式上线后，更改为生产环境
					addMessage(GsonHelper.toJson(pi)).addDeployStatus(2). // IOS,
																			// DeployStatus
																			// =>1:Developer2:Production.
					addDeviceType(4);// deviceType => 3:android, 4:ios
			PushMsgToSingleDeviceResponse response = pushClient.pushMsgToSingleDevice(request);
			log.debug("msgId: " + response.getMsgId() + ",sendTime: " + response.getSendTime());
		} catch (PushClientException e)
		{
			/*
			 * ERROROPTTYPE 用于设置异常的处理方式 -- 抛出异常和捕获异常,'true' 表示抛出, 'false' 表示捕获。
			 */
			if (BaiduPushConstants.ERROROPTTYPE)
			{
				throw e;
			} else
			{
				log.error("IOS，PushClientException推送错误："+"reciverId："+pi.receiverId+","+" deviceType："+pi.deviceType+","+ String.format("requestId: %d, errorCode: %d, errorMessage: %s")+ e.getMessage());
			}
		} catch (PushServerException e)
		{
			if (BaiduPushConstants.ERROROPTTYPE)
			{
				throw e;
			} else
			{
				log.error("IOS，PushServerException推送错误："+"reciverId："+pi.receiverId+","+" deviceType："+pi.deviceType+","+String.format("requestId: %d, errorCode: %d, errorMessage: %s", e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
			}
		}
	}
	
	/**
	 * 推送至安卓多个设备
	 * 
	 * @param title
	 * @param content
	 * @param channelIds
	 * @throws PushClientException
	 * @throws PushServerException
	 */
	@Override
	public void androidPushBatchUniMsg(PushItem pi, String[] channelIdStrs)
			throws PushClientException, PushServerException
	{
		// 1. get apiKey and secretKey from developer console
		PushKeyPair pair = new PushKeyPair(Cons.PUSH_APIKEY, Cons.PUSH_SECRETKEY);

		// 2. build a BaidupushClient object to access released interfaces
		BaiduPushClient pushClient = new BaiduPushClient(pair, BaiduPushConstants.CHANNEL_REST_URL);

		// 3. register a YunLogHandler to get detail interacting information
		// in this request.
		pushClient.setChannelLogHandler(new YunLogHandler()
		{
			@Override
			public void onHandle(YunLogEvent event)
			{
				log.debug(event.getMessage());
			}
		});

		try
		{
			// 4. specify request arguments
			// 创建Android通知
			JSONObject notification = new JSONObject();
			notification.put("title", pi.title);
			if (pi.PushContent == null)
			{
				notification.put("description", "智慧校园向您发送了一条新消息，请注意查收");
			} else
			{
				String pushContent = pi.PushContent;
				notification.put("description", pushContent.length() > 60 ? pushContent.substring(0, 60) + "..." : pushContent);
			}
			notification.put("notification_builder_id", 0);
			notification.put("notification_basic_style", 4);
			notification.put("open_type", 3);

//			JSONObject jsonCustormCont = new JSONObject();
//			jsonCustormCont.put("content", content); // 自定义内容，key-value
			notification.put("custom_content", GsonHelper.toJson(pi));

//			String[] channelIdStrs = channelIds.split(",");// 使用了第二种接口，返回值和参数均为结果
			PushBatchUniMsgRequest request = new PushBatchUniMsgRequest().addChannelIds(channelIdStrs).addMsgExpires(new Integer(3600)).addMessageType(0)
					.addMessage(notification.toString()).addDeviceType(3);
			// 5. http request
			PushBatchUniMsgResponse response = pushClient.pushBatchUniMsg(request);
			// Http请求结果解析打印
			log.debug(String.format("msgId: %s, sendTime: %d", response.getMsgId(), response.getSendTime()));
		} catch (PushClientException e)
		{
			if (BaiduPushConstants.ERROROPTTYPE)
			{
				throw e;
			} else
			{
				e.printStackTrace();
			}
		} catch (PushServerException e)
		{
			if (BaiduPushConstants.ERROROPTTYPE)
			{
				throw e;
			} else
			{
				log.error(String.format("requestId: %d, errorCode: %d, errorMessage: %s", e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
			}
		}
	}

	@Override
	public Integer addPushmesaage(Pushmessage pm)
	{
		Integer pushId = this.getBaseDao().addObject("Pushmessage.addPushmessage", pm);
		return pushId;
	}

	@Override
	public int findLatestMessageCountList(Integer receiverId)
	{
		return (int) this.getBaseDao().selectObjectByObject("Pushmessage.findLatestMessageCountList", receiverId);
	}
	
	@Override
	public Integer getPushmessageByDate(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		return (Integer) getBaseDao().selectObjectByObject("Pushmessage.getPushmessageByDate", parmMap);
	}

	@Override
	@Transactional
	public void deletePushmessageByDate(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		getBaseDao().deleteObject("Pushmessage.deletePushmessageByDate", parmMap);
		
	}
}
