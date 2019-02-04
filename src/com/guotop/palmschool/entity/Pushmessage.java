package com.guotop.palmschool.entity;

import java.io.Serializable;

import com.guotop.palmschool.rest.entity.PushItem;


public class Pushmessage implements Serializable {
	private static final long serialVersionUID = 1L;

	private int pushId;

	private String alert;

	private String channels;

	private String createTime;

	private String deviceType;

	private String operationapplyId;

	private String operationResult;

	private String pushContent;

	private int pushContentType;

	private String pushData;

	private String pushGroupId;

	private String pushGroupName;

	private String pushImage;

	private String pushOwnerID;

	private String pushSender;

	private String pushSenderId;
	
	private String pushSenderVoipAccount;

	private int pushType;

	private String pushUrl;

	private String receiverId;

	private String sound;

	private int status;

	private String title;

	private String schoolId;

	public Pushmessage() {
	}
	
	public Pushmessage(PushItem pi)
	{
		this.pushType = pi.PushType;
		this.pushContentType = pi.PushContentType;
		this.pushContent = pi.PushContent;
		this.pushImage = pi.PushImage;
		this.pushSenderId = String.valueOf(pi.PushSenderId);
		this.pushSender = pi.PushSender;
		this.pushSenderVoipAccount = pi.PushSenderVoipAccount;
		this.pushGroupId = String.valueOf(pi.PushGroupId);
		this.pushGroupName = pi.PushGroupName;
		this.pushUrl = pi.PushUrl;
		this.createTime = System.currentTimeMillis()+"";
		this.operationapplyId = String.valueOf(pi.OperationapplyId);
		this.title = pi.title;
		this.channels = pi.channels;
		this.deviceType = pi.deviceType;
		this.receiverId = String.valueOf(pi.receiverId);
		this.pushOwnerID = pi.PushOwnerID+"";
		this.operationResult = String.valueOf(pi.OperationResult);
		this.pushData = pi.PushData;
		if(pi.aps != null){
			if(pi.aps.get("alert") != null){
				this.alert = (String) pi.aps.get("alert");
			}
			if(pi.aps.get("sound") != null){
				this.sound = (String) pi.aps.get("sound");
			}
		}
		this.schoolId = pi.schoolId;
	}

	public void setPushId(int pushId)
	{
		this.pushId = pushId;
	}

	public int getPushId()
	{
		return pushId;
	}

	public String getAlert() {
		return this.alert;
	}

	public void setAlert(String alert) {
		this.alert = alert;
	}

	public String getChannels() {
		return this.channels;
	}

	public void setChannels(String channels) {
		this.channels = channels;
	}

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getDeviceType() {
		return this.deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String getOperationapplyId() {
		return this.operationapplyId;
	}

	public void setOperationapplyId(String operationapplyId) {
		this.operationapplyId = operationapplyId;
	}

	public String getOperationResult() {
		return this.operationResult;
	}

	public void setOperationResult(String operationResult) {
		this.operationResult = operationResult;
	}

	public String getPushContent() {
		return this.pushContent;
	}

	public void setPushContent(String pushContent) {
		this.pushContent = pushContent;
	}

	public int getPushContentType() {
		return this.pushContentType;
	}

	public void setPushContentType(int pushContentType) {
		this.pushContentType = pushContentType;
	}

	public String getPushData() {
		return this.pushData;
	}

	public void setPushData(String pushData) {
		this.pushData = pushData;
	}

	public String getPushGroupId() {
		return this.pushGroupId;
	}

	public void setPushGroupId(String pushGroupId) {
		this.pushGroupId = pushGroupId;
	}

	public String getPushGroupName() {
		return this.pushGroupName;
	}

	public void setPushGroupName(String pushGroupName) {
		this.pushGroupName = pushGroupName;
	}

	public String getPushImage() {
		return this.pushImage;
	}

	public void setPushImage(String pushImage) {
		this.pushImage = pushImage;
	}

	public String getPushOwnerID() {
		return this.pushOwnerID;
	}

	public void setPushOwnerID(String pushOwnerID) {
		this.pushOwnerID = pushOwnerID;
	}

	public String getPushSender() {
		return this.pushSender;
	}

	public void setPushSender(String pushSender) {
		this.pushSender = pushSender;
	}

	public String getPushSenderId() {
		return this.pushSenderId;
	}

	public void setPushSenderId(String pushSenderId) {
		this.pushSenderId = pushSenderId;
	}

	public int getPushType() {
		return this.pushType;
	}

	public void setPushType(int pushType) {
		this.pushType = pushType;
	}

	public String getPushUrl() {
		return this.pushUrl;
	}

	public void setPushUrl(String pushUrl) {
		this.pushUrl = pushUrl;
	}

	public String getReceiverId() {
		return this.receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public String getSound() {
		return this.sound;
	}

	public void setSound(String sound) {
		this.sound = sound;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}

	public String getPushSenderVoipAccount()
	{
		return pushSenderVoipAccount;
	}

	public void setPushSenderVoipAccount(String pushSenderVoipAccount)
	{
		this.pushSenderVoipAccount = pushSenderVoipAccount;
	}
	
}