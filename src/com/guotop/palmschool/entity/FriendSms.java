package com.guotop.palmschool.entity;


public class FriendSms{

	private int id;

	private String content;

	private String createTime;

	private int errorSmsSum;

	private String isRealTime;

	private int phoneCount;

	private int reportAmount;

	private int result;

	private int senderId;

	private String senderName;

	private String sentTime;

	private int smsLength;

	private int smsSum;

	private int succAmount;

	private String type;


	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public int getErrorSmsSum() {
		return this.errorSmsSum;
	}

	public void setErrorSmsSum(int errorSmsSum) {
		this.errorSmsSum = errorSmsSum;
	}

	public String getIsRealTime() {
		return this.isRealTime;
	}

	public void setIsRealTime(String isRealTime) {
		this.isRealTime = isRealTime;
	}

	public int getPhoneCount() {
		return this.phoneCount;
	}

	public void setPhoneCount(int phoneCount) {
		this.phoneCount = phoneCount;
	}

	public int getReportAmount() {
		return this.reportAmount;
	}

	public void setReportAmount(int reportAmount) {
		this.reportAmount = reportAmount;
	}

	public int getResult() {
		return this.result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public int getSenderId() {
		return this.senderId;
	}

	public void setSenderId(int senderId) {
		this.senderId = senderId;
	}

	public String getSenderName() {
		return this.senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getSentTime() {
		return this.sentTime;
	}

	public void setSentTime(String sentTime) {
		this.sentTime = sentTime;
	}

	public int getSmsLength() {
		return this.smsLength;
	}

	public void setSmsLength(int smsLength) {
		this.smsLength = smsLength;
	}

	public int getSmsSum() {
		return this.smsSum;
	}

	public void setSmsSum(int smsSum) {
		this.smsSum = smsSum;
	}

	public int getSuccAmount() {
		return this.succAmount;
	}

	public void setSuccAmount(int succAmount) {
		this.succAmount = succAmount;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

}