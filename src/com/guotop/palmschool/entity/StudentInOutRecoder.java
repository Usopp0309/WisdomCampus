package com.guotop.palmschool.entity;

public class StudentInOutRecoder {
	
	//卡号
	private String cardId;
	//持有者
	private String cardOwner;
	//班级
	private String cardOwnerClass;
	//进出状态
	private String cardStatus;
	//电池状态
	private String cardBatteryStatus;
	//打卡地点
	private String recorderLocation;
	//创建时间
	private String createTime;
	
	public String getCardId() {
		return cardId;
	}
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	public String getCardOwner() {
		return cardOwner;
	}
	public void setCardOwner(String cardOwner) {
		this.cardOwner = cardOwner;
	}
	public String getCardOwnerClass() {
		return cardOwnerClass;
	}
	public void setCardOwnerClass(String cardOwnerClass) {
		this.cardOwnerClass = cardOwnerClass;
	}
	public String getCardStatus() {
		return cardStatus;
	}
	public void setCardStatus(String cardStatus) {
		this.cardStatus = cardStatus;
	}
	public String getCardBatteryStatus() {
		return cardBatteryStatus;
	}
	public void setCardBatteryStatus(String cardBatteryStatus) {
		this.cardBatteryStatus = cardBatteryStatus;
	}
	public String getRecorderLocation() {
		return recorderLocation;
	}
	public void setRecorderLocation(String recorderLocation) {
		this.recorderLocation = recorderLocation;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	
	
	

}
