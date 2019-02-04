package com.guotop.palmschool.rest.entity;

import java.io.Serializable;
import java.util.HashMap;


public class PushItem  implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1475804328791875986L;

	/**
	 * 0系统预留，1校园公告，2在线请假(Type:2 pushContentType:1请假审批通知  2请假审批通过通知 3请假审批拒绝通知 )，
	 * 3会议通知，4宿舍通知，5校车通知，6短信平台，7成绩通知，8进出校园,
	 * 9一卡通， 10 一体机接送通知， 11 晨检 , 12 作息时间设置 ，13幼儿园版老师评价， 14 食谱变动， 15作业发布
	 * 16 新闻、活动、招生信息发布
	 * 17支付(pushContentType:1支付成功 2支付失败 3转账成功 4短信购买成功 5短信购买失败 6短信代购付款成功 7短信代购付款失败 8补办卡费用支付成功 9补办卡费用支付失败 )
	 * 18提现(pushContentType:1提现成功 2提现申请 3：拒绝提现)
	 * 19补卡通知(pushContentType:1补办卡通知  2.补办卡申请通过 3.补办卡申请拒绝)
	 * 20服务费订购通知(pushContentType:1 订购通知 ) 备注：提醒用户购买
	 * 21资产维修通知(pushContentType:1 资产报修通知,2资产催单通知,3资产审核通知,4资产审核通过通知,5资产审核不通过通知,6资产维修完成通知 )
	 * 22安全隐患排查(pushContentType:1 学生行为，2：学校资产 )
	 * 23智慧校园用户认证(pushContentType:1:智慧校园用户申请,2: 智慧校园用户申请修改信息，3：智慧校园申请成功通知，4：智慧校园申请被拒绝，5：智慧校园申请修改信息成功，6：智慧校园申请修改信息被拒绝，7:删除智慧校园用户)
	 * 24易信转智慧通知(pushContentType:1:系统监测到您是智慧校园用户,是否设置并登录)
	 * 25资源云平台资源上传通知(pushContentType:1:资源上传)
	 * 26作业助手(pushContentType:1:新作业提醒 ,2批改完作业提醒)
	 * 50新闻资讯,
	 * 51好友通知(pushContentType:1.申请好友,2.同意添加好友 3.拒绝添加好友 4.删除好友)
	 * 52群组通知(pushContentType:1.申请加为群组成员,2.群管理员同意添加,3.群管理员拒绝添加,4.邀请加为群成员,5.
	 * 被邀请人同意加入,6.被邀请人拒绝加入,7.解散群组,8.删除群组成员,9.设置群管理员,10.退出群组)
	 * 53关联通知(pushContentType:1.申请关联,2.同意关联 3.拒绝关联 4.删除关联)
	 * 说明：新增类型时请在palm_information_type中手动增加一条对应的数据  用于设置对应的信息提醒类型
	 */
	public int PushType;

	public int PushContentType;

	public String PushContent;
	
	/*** 推送人头像（申请加入群：推送人头像,邀请加入群：群头像） ***/
	public String PushImage;
	
	/*** 推送人id ***/
	public int PushSenderId;
	
	/*** 推送人名字 ***/
	
	public String PushSender;
	
	/*** 推送人容联云账号 ***/
	public String PushSenderVoipAccount;

	public String PushUrl;

	public String CreateTime;
	// 标题
	public String title;
	// 渠道
	public String channels;
	// 设备类型 3：android 4 ：ios
	public String deviceType;
	//其余数据
	public String PushData;
	
	/*** 申请记录id ***/
	public int OperationapplyId;
	
	/*** 推送接收人id***/
	public int receiverId;
	
	public HashMap<String, Object> aps = new HashMap<String, Object>();
	//学校ID
	public String schoolId;
	
	/*** 群id ***/
	public int PushGroupId;
	
	/*** 群名字 ***/
	public String PushGroupName;
	
	/*** 消息接受者id,手机端需要使用,当前用户的userid ***/
	public int PushOwnerID;
	/*** 接收到推送通知之后的操作结果,手机端需要使用,0：拒绝,1：通过,2:未操作 ***/
	public int OperationResult;
	/*** 后台pushmessage的主键 ***/
	public int pushId;
	
	public PushItem clone(){
		PushItem pi =new PushItem();
		pi.PushType = this.PushType;
		pi.PushContentType = this.PushContentType;
		pi.PushContent = this.PushContent;
		pi.PushImage = this.PushImage;
		pi.PushUrl = this.PushUrl;
		pi.PushSender = this.PushSender;
		pi.PushSenderId = this.PushSenderId;
		pi.PushSenderVoipAccount = this.PushSenderVoipAccount;
		pi.CreateTime = this.CreateTime;
		pi.title = this.title;
		pi.channels = this.channels;
		pi.deviceType = this.deviceType;
		pi.PushData = this.PushData;
		pi.receiverId = this.receiverId;
		pi.aps = this.aps;
		pi.schoolId = this.schoolId;
		return pi;
	}
}
